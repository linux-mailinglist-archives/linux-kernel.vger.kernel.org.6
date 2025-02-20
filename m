Return-Path: <linux-kernel+bounces-524496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F8CA3E3C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9960A19C0EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06E221422F;
	Thu, 20 Feb 2025 18:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUXFb46Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A8621506B;
	Thu, 20 Feb 2025 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075976; cv=none; b=twbm7LlB3UZWCUeHmHhKl0RnH0eoifM9PPbybxiYFF6Y3xyj54h9GIZLI/OvhgsNCyJON3ey+a5UHBqLqa7qpdN18Grc8ne+QGcIEOKZLGZ9L9sTWt89GiKFxpMOmZHro8ZpzjZswY+EIlv2bfRQkBYVKpCZ6TS1si0uE1NMitQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075976; c=relaxed/simple;
	bh=QA8oH3548r5dQ+WwkSHxktUNOTDQcHyR4Ka9gHIDgpM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iQWr7J+hEqvWXKXCXvQro98lQnsBeRkDVcZg1zQKOjMoqIe+5ydwst2KogA11gX5pKftTBq7+wrsQQ/HhJAsvyYSVBs4m6jxFDe81mZl+25KhN5wRFFOmlo1K2xCGIJCrag0D6aCDWqckUdXcL9vVGEVQ+b9ZhPn0xt1uczbI70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUXFb46Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989FDC4CEE9;
	Thu, 20 Feb 2025 18:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740075974;
	bh=QA8oH3548r5dQ+WwkSHxktUNOTDQcHyR4Ka9gHIDgpM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bUXFb46Y6X1XqrIlFIYRmcOWqFjezeSgh/LWdv1+bw7dp5YSBtPISKZmdpDYv/O4f
	 5Rvf4Z/d/vhg+NFxxpp/iGi7selxaN9/hDwkyNXOW7Ub3aSSvA9g02Bdbk1qDIzy1P
	 BO3sERCrbcjQAbVQIqErOHV8YVZyQZvezXxwPme13GTpKEkY6QtgAkaySjJxcatQeV
	 /QqSKLwl1XUlbGvtnGwtuYGzRzlD5NCsYs7U1kvZZptBbQIun51il4jiVRTSVRSsCI
	 swpatZF+JFCdaIlBBqHYwXn1VgBo9vc9ef2COgq7DPKRvpwDLID5GsgjjVx2dIdTZD
	 jFd24B3baDr6Q==
From: Namhyung Kim <namhyung@kernel.org>
To: irogers@google.com, Dmitry Vyukov <dvyukov@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250108063628.215577-1-dvyukov@google.com>
References: <20250108063628.215577-1-dvyukov@google.com>
Subject: Re: [PATCH] perf report: Fix input reload/switch functionality
Message-Id: <174007597458.1790567.14699630079068730273.b4-ty@kernel.org>
Date: Thu, 20 Feb 2025 10:26:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 08 Jan 2025 07:36:23 +0100, Dmitry Vyukov wrote:
> Currently the code checks that there is no "ipc" in the sort order
> and add an ipc string. This will always error out on the second pass
> after input reload/switch, since the sort order already contains "ipc".
> Do the ipc check/fixup only on the first pass.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



