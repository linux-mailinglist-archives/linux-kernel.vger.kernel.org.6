Return-Path: <linux-kernel+bounces-386250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F0F9B40FD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB041C220AF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C921F429A;
	Tue, 29 Oct 2024 03:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcEGLwRS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5AEFC0B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730172291; cv=none; b=PNrHBaVQ2xACR7gw96d1IWzAWuXKG6ZPH0bIFqg8poe8ViV28seSu9BIl5PhPYF0ShY37Q48SaQYwFEVypYqkOYbs59+kcaQtOF7YdGBM6ITXmAiwycTMvTP099kKtjT9dF1o6TlVz9161rb7OrU/WC9oA8hrRRFV7RgwqWlIZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730172291; c=relaxed/simple;
	bh=LvpMyiaaNKLeTHaVFYd4nKHxAgZ31IpQg4KBhS92H7c=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IRgnldo8dgIa9x7/Lw7eMYnUmMFi0uk1Zissb/iN6b7Eq6keyMfgjsBde14UkmMu1V1ab3lISEsiBhMkpfjvUMNuGi/IRyvn3evveCc2odS8wt+KM4iWLF7rvFtcKtKSdDreDRuR88NvaaPIxzS+7czGz1T1bOr594Pzf+BdIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcEGLwRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A01C4CECD;
	Tue, 29 Oct 2024 03:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730172291;
	bh=LvpMyiaaNKLeTHaVFYd4nKHxAgZ31IpQg4KBhS92H7c=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=EcEGLwRSK0em4tQUAvvOSPBTOAd5G6I0czh+JmUsLeyUCL6GeWIPGdHMah6MrR/Ni
	 gflzXtv1aIP0NPv3zhCodmRe7Krf7Dqo7Ka9sgJ9f6ma+imMwcEJyeJdyNYGNBkjZC
	 Um7Z3u12rWFJlLW3y8E/HherRDiB2Xv+KXWvsvem9Q70J0jg3eU/P4f7dzsVa6hgeC
	 Rw1a7463JOIvRPawB+54nuNrPXNIuWMGlUtCcpQxlo5Tj1gZWnV3z4uK2p0Kr5TmyD
	 TCGuL23VPe4m4WLyKt3RuHAokGOS0SPl393pi3bnwkHnPnKtAB3GSjRYeCkJZUqbey
	 y/yMkULz6JlPg==
Message-ID: <e8c6f079-2bc7-4738-8d34-268d2f86bb0b@kernel.org>
Date: Tue, 29 Oct 2024 11:24:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com, ke.wang@unisoc.com,
 Hao_hao.Wang@unisoc.com
Subject: Re: [PATCH V3] f2fs: fix to avoid use GC_AT when setting gc_mode as
 GC_URGENT_LOW or GC_URGENT_MID
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1730171569-10757-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1730171569-10757-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/29 11:12, Zhiguo Niu wrote:
> If gc_mode is set to GC_URGENT_LOW or GC_URGENT_MID, cost benefit GC
> approach should be used, but if ATGC is enabled at the same time,
> Age-threshold approach will be selected, which can only do amount of
> GC and it is much less than the numbers of CB approach.
> 
> some traces:
>    f2fs_gc-254:48-396     [007] ..... 2311600.684028: f2fs_gc_begin: dev = (254,48), gc_type = Background GC, no_background_GC = 0, nr_free_secs = 0, nodes = 1053, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:0
>    f2fs_gc-254:48-396     [007] ..... 2311600.684527: f2fs_get_victim: dev = (254,48), type = No TYPE, policy = (Background GC, LFS-mode, Age-threshold), victim = 10, cost = 4294364975, ofs_unit = 1, pre_victim_secno = -1, prefree = 0, free = 44898
>    f2fs_gc-254:48-396     [007] ..... 2311600.714835: f2fs_gc_end: dev = (254,48), ret = 0, seg_freed = 0, sec_freed = 0, nodes = 1562, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:0
>    f2fs_gc-254:48-396     [007] ..... 2311600.714843: f2fs_background_gc: dev = (254,48), wait_ms = 50, prefree = 0, free = 44898
>    f2fs_gc-254:48-396     [007] ..... 2311600.771785: f2fs_gc_begin: dev = (254,48), gc_type = Background GC, no_background_GC = 0, nr_free_secs = 0, nodes = 1562, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:
>    f2fs_gc-254:48-396     [007] ..... 2311600.772275: f2fs_gc_end: dev = (254,48), ret = -61, seg_freed = 0, sec_freed = 0, nodes = 1562, dents = 2, imeta = 18, free_sec:44898, free_seg:44898, rsv_seg:239, prefree_seg:0
> 
> Fixes: 0e5e81114de1 ("f2fs: add GC_URGENT_LOW mode in gc_urgent")
> Fixes: d98af5f45520 ("f2fs: introduce gc_urgent_mid mode")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

