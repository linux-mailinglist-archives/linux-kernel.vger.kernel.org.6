Return-Path: <linux-kernel+bounces-231367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B7691948D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2121C22E02
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE499191475;
	Wed, 26 Jun 2024 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeCMy7bh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9869191479
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719428406; cv=none; b=GGAHtlOVQoaIUsGu9JjZcs0yco4EzeSXUN9tztqMv94NrQh78KySGX9P/FTnKJprW6H9ZkWkYaGDWAVkBvFXlXJ7t15RnQgzfNxLhEYwsDOrqCnVeSFoKodlFAXN2wGGtJa9rZLqdkJ9oie9niWhqcqLfblZR3Ei8yYsp8dW1qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719428406; c=relaxed/simple;
	bh=qlJ6WLl779toGU1qUQGCocGE+COhB/4+HlE79vfNzBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MX7ks0WQjhceA6Iqb5Hwt0XL51WnZP61IwS2M/YQDiwKWH3MTdy9RzKj2n1zGf28mB3iFVY2lrMkHE4baimyBRbDJavrsNHwbRL4JvBn7TRVN3R2YfncXJUOq1GIWCcaMbzw2bfFQ35JtwdDe3TiVCd3ah5bTXMmkXsbwNSac04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeCMy7bh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C21C116B1;
	Wed, 26 Jun 2024 19:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719428405;
	bh=qlJ6WLl779toGU1qUQGCocGE+COhB/4+HlE79vfNzBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IeCMy7bhQU4tbsaFrBLWdjWYv320Ly3rjqXYTbp6V1T3BaE8MiY89BABvsXLEMED/
	 mnPFoE0OsVCGMwxZ7uLAdgtxtzxw4usLfLjuMaMyaT8uTQoHZn9JwWDPjbkQFAlO7b
	 G9RQ42lmI70siujMEW4qD4P8boFY9N8C2xqEX1sKrcC8FKME0cvTjJEXiPPuXeMQMo
	 XMUs6bMusOwzwpJuXsr+l4j5as/WQtYr3kqJaQk+GgJG18cobegCa6ouQXwu1irkcx
	 hMWm9u6i85SzRVkjWfdwC3nmmErOUl4+urvnvde638/FidTC8Sv9znzVWZRGvSoo6s
	 qQYUuJjQY06Xg==
Date: Wed, 26 Jun 2024 12:00:04 -0700
From: Kees Cook <kees@kernel.org>
To: Andrei Vagin <avagin@google.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/3 v2] seccomp: improve handling of
 SECCOMP_IOCTL_NOTIF_RECV
Message-ID: <202406261158.B5650CAB2@keescook>
References: <20240523014540.372255-1-avagin@google.com>
 <CAEWA0a4_-SLpW1Bx0ZS-nqhG5hGn6+_9qG5-jtHk1hrnHZcp7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEWA0a4_-SLpW1Bx0ZS-nqhG5hGn6+_9qG5-jtHk1hrnHZcp7A@mail.gmail.com>

On Mon, Jun 24, 2024 at 05:17:09PM -0700, Andrei Vagin wrote:
> Are you waiting for anything from me? I think this series is ready to be merged.

Oops, sorry for the silence! I had been waiting for Oleg's review, and
then it happened and I missed it, so it fell off my TODO list. :)

I just sent a reply with 2 bits of feedback, but with a v3, I think I
can land this ASAP.

Thanks for chasing me down, and I appreciate the selftest updates!

-Kees

-- 
Kees Cook

