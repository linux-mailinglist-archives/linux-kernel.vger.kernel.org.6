Return-Path: <linux-kernel+bounces-385206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACB39B33F6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A892829BE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6BC1DE2B1;
	Mon, 28 Oct 2024 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaBuJPBx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0E718E778
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126790; cv=none; b=c1fjPPFmVlwAXYR0PelNagB5AehfhDFMfcSUvHEMEQKouc6D+F73/O7y1gACy0Q5UHmmYcP6IU8G48xvPbp6ZbzdRizKoupVP0X33PW0s+A3Z0gYCDeOKcfxsCs79AsqdhqRjAT70F404u/c0ex6cZMicw76qnQVcydwI3PrTOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126790; c=relaxed/simple;
	bh=oYGeCWynHLCN1ITsmum0w4ehrAVU3TnoBN5fZz/wgbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWyYihHNm3QaUPXVP+N7qKBGym8ieAi7BtZLPyGZURvG6kpzgUirDPzmpWkx82ZDAEJNN5k565pGNiP9I7zOniMWyH3B/fl5pwMpALa5WaZcJJRcCwQpFc6R4wDHABormHoaDQo4z+AogSdargrrrZUWUh2Rrg/wiEkuwDZVI68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaBuJPBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831EDC4CEC3;
	Mon, 28 Oct 2024 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730126790;
	bh=oYGeCWynHLCN1ITsmum0w4ehrAVU3TnoBN5fZz/wgbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OaBuJPBxrD/ND9Z6HTkRpq/DZHL0W/jtKSV8Lfmuphmu4qrr76QuUOm6tHOLWZGsh
	 t3qpjHhmat2Nuy+Y67TePJjaXEROXsr+Yukcdmky4Fv3aMEje+mj0uYVkEmDcVZJad
	 zmW9ih0BebcUvPGg/GcUiq72B6m1LshrpoUnDKwSHhFv3f6wonZw4Y0028HbLfNG4V
	 1i2m+Yhjj071TbKgqVzcHprc+nW5tgW3vNviTRuV+RCgTAthevn8eyRHbNTghaencT
	 fKTKqF8hDoGnqpNE6ldQQ0kqRYi8Tywu5fjpHWxMHvQf4mf5js7AsWTh1UFvwq4T5S
	 ixpFU7YCGK3IQ==
Date: Mon, 28 Oct 2024 15:46:25 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Joel Granados <j.granados@samsung.com>, Christian Brauner <brauner@kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] sysctl: encode the min/max values directly in the
 table entry
Message-ID: <mmmu2glg4cmopjfixz6e54fxnj5ylro7szyo3czn6dwqie2vdj@by2mk2ftgprp>
References: <cover.1726910671.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726910671.git.wen.yang@linux.dev>

On Sat, Sep 21, 2024 at 05:28:59PM +0800, Wen Yang wrote:
Just FYI. I'm waiting on an answer from
https://lore.kernel.org/all/5yfnu64fqsuahcmifvqdaynvdesqvaehhikhjff46ndoaacxyd@jvjrd3ivdpyz/
as that one has to go in first. Right?

Best

> Many modules use these additional static/global variables (such as
> two_five_five, n_65535, ue_int_max, etc.) in the boundary checking of
> sysctl, and they are read-only and never changed.
> 
> Eric points out: "by turning .extra1 and .extra2 into longs instead of
> keeping them as pointers and needing constants to be pointed at somewhere
> .. The only people I can see who find a significant benefit by
> consolidating all of the constants into one place are people who know how
> to stomp kernel memory."
> 
> This patch series achieves direct encoding values in table entries and still
> maintains compatibility with existing extra1/extra2 pointers.
> Afterwards, we can remove these unnecessary static variables progressively and
> also gradually kill the shared const array.
> 
> v3: https://lore.kernel.org/all/cover.1726365007.git.wen.yang@linux.dev/
> v2: https://lore.kernel.org/all/tencent_143077FB953D8B549153BB07F54C5AA4870A@qq.com/
> v1: https://lore.kernel.org/all/tencent_95D22FF919A42A99DA3C886B322CBD983905@qq.com/
> 
> Wen Yang (5):
>   sysctl: add helper functions to extract table->extra1/extra2
>   sysctl: support encoding values directly in the table entry
>   sysctl: add kunit test code to check the min/max encoding of sysctl
>     table entries
>   sysctl: delete mmap_rnd_bits_{min/max} and
>     mmap_rnd_compat_bits_{min/max} to save 16 bytes
>   sysctl: delete six_hundred_forty_kb to save 4 bytes
> 
>  fs/proc/proc_sysctl.c  |  29 +-
>  include/linux/mm.h     |   4 -
>  include/linux/sysctl.h |  64 ++++-
>  kernel/sysctl-test.c   | 581 +++++++++++++++++++++++++++++++++++++++++
>  kernel/sysctl.c        |  45 ++--
>  mm/mmap.c              |   4 -
>  6 files changed, 677 insertions(+), 50 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 

Joel Granados

