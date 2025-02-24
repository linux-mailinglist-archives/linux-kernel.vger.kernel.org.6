Return-Path: <linux-kernel+bounces-529923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8892A42C91
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1F71895B46
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1231A76AC;
	Mon, 24 Feb 2025 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpEpWS/L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E4E1C7012
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424692; cv=none; b=R3XksT8PIXrOTtOtg1d+L1a5+8hekcdU3XM6cSJLlw48zlTHRu2bFHSf5Ko7GCAep2LbPQ4bjdSD8Aeo5ykR1+nlB4P2kuLrfDXKd9hz8k2yTcTG+cS2CevMMLnQx8H36FmDvpwoa7qI//b2Ct+N/G1RHEeJIsO6lBDqZY9DuUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424692; c=relaxed/simple;
	bh=+BZxL6di1N3tWTlbC/lnpBgfQsNEvuLPkbqkZugUgYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PlfBP3k7UIKUbsXuQCyUzTsz6IZnUF5YYdImmMHhNrNw6/Ki8pcXAU4c1NrqUt1gpIhRKiVnpe+oqFalkxj1AEXhlBS0ifzJI0MQJPp7+eljwYoEH0AfWjdIyoYqnSdSJtmFDReFpTvwEhgi0UPjGem/mBAN2jtlwBwLwYsQXoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpEpWS/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8A0C4CEDD;
	Mon, 24 Feb 2025 19:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740424691;
	bh=+BZxL6di1N3tWTlbC/lnpBgfQsNEvuLPkbqkZugUgYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QpEpWS/L2Fjou57HuIaa/mK9QQdc2Kqmvo+Dz8hxwjuGYFutHC1/hvRmYA5pfZpO+
	 Yu1BrqOkYrPdY813kA1J1v5gtS9iGlSxODJwdBYH96SPI1KqzuE2cjjS/kjvp+3qwc
	 nbp85XllM1V+nWaMOqp2qhS7qN/wMOvbnbygMP7hZdpXcHtQ1LsmRtLy4KJoT+d//l
	 qa1L2eMkGQPUPun8JW+LgSNlbtDAsI9o8HHiBDben8AwKQrJGKohW9wqKrFkMVDY6h
	 53pi407yem1v/aW5PLu6Xt87q7BPvonHFsvk+5RfgJNSzWdQDwwu4oHsIhqT6B3PS4
	 725AGNPTD6fxA==
From: Kees Cook <kees@kernel.org>
To: luto@amacapital.net,
	wad@chromium.org,
	Mateusz Guzik <mjguzik@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] seccomp: avoid the lock trip seccomp_filter_release in common case
Date: Mon, 24 Feb 2025 11:18:04 -0800
Message-Id: <174042468261.3899124.11197404704577449998.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213170911.1140187-1-mjguzik@gmail.com>
References: <20250213170911.1140187-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 13 Feb 2025 18:09:10 +0100, Mateusz Guzik wrote:
> Vast majority of threads don't have any seccomp filters, all while the
> lock taken here is shared between all threads in given process and
> frequently used.
> 
> Safety of the check relies on the following:
> - seccomp_filter_release is only legally called for PF_EXITING threads
> - SIGNAL_GROUP_EXIT is only ever set with the sighand lock held
> - PF_EXITING is only ever set with the sighand lock held *or* after
>   SIGNAL_GROUP_EXIT is set *or* the process is single-threaded
> - seccomp_sync_threads holds the sighand lock and skips all threads if
>   SIGNAL_GROUP_EXIT is set, PF_EXITING threads if not
> 
> [...]

Applied to for-next/seccomp, thanks!

[1/1] seccomp: avoid the lock trip seccomp_filter_release in common case
      https://git.kernel.org/kees/c/8f19331384e6

Take care,

-- 
Kees Cook


