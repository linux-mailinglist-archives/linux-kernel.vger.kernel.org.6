Return-Path: <linux-kernel+bounces-293107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A45957ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348E9282070
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB062E3FE;
	Tue, 20 Aug 2024 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOi9vDyj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E573E29D19
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724116807; cv=none; b=mBkjWgmsU6yRu6UK1Mr6JfGTMCW10I2zSMosaG6NjhiAbNy5v+ifJ7SBEYiCQkqqNsQP5QoirX2aRhihAlk4ixcJaYaDoPL6ev63Rxv5sRbYu5USXm8D8WD4p9OZXuEvLl270l8rd/MZjA5dgU+b17ceXx0LbmblJMpEjWt2/rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724116807; c=relaxed/simple;
	bh=VjhEBDGS9iYKFsN2C3UZNPQFoThzUMhspy3TWnKLR4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFVabGhc31vQ0LHCUnfyORBdnpKj/UMZPciaqAJ/e+NQWUst2dHvub8OX6HoasvS/PgZMwze8O5BnX1EbX0BNx6NKwb/OrBDZLstNiy8KYGQ1uVISTCbSeqadGkRWN9MndGcex4VhMSxHVTbzudSknHGp6oqi6OVpx88CuxHH44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOi9vDyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9027C32782;
	Tue, 20 Aug 2024 01:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724116806;
	bh=VjhEBDGS9iYKFsN2C3UZNPQFoThzUMhspy3TWnKLR4M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lOi9vDyjwCzXcfIo8fifN33o5TQ43g3hICp3VVPzlzw331EYhSzml+lqU86x3319R
	 FPLdemQFvUQvC0Ljjbjuez4EbQ9hGn/b9/7W7i/fnf/JPnFXI7H0CwlA48lwXvdEQd
	 vzAeN1Ja7awOoRnmTGbJbrQTxSJrG+BGZYYlkq25BE5Dzw5SIYDPeWVac5Ma3Or/f+
	 lHwdZv9ItWV8qgpi4kCuS4UfM6ImAOZUIoeHc5EY+MPozMgUErOT0Mc9AxXaDYKGNY
	 j2tIcuYWxoZu00vU0RvTNB4SqZfvXtqqhUdXBJFyxyBSddM6odIIbhdunRrpBuaDMz
	 zx5nx1onEdxvA==
Message-ID: <4b916314-4d0a-493e-a04a-8148643e600b@kernel.org>
Date: Tue, 20 Aug 2024 09:20:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] f2fs: compress: don't redirty sparse cluster during
 {,de}compress
To: Yeongjin Gil <youngjin.gil@samsung.com>, jaegeuk@kernel.org,
 daehojeong@google.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Sungjong Seo <sj1557.seo@samsung.com>, Sunmin Jeong
 <s_min.jeong@samsung.com>, Jaewook Kim <jw5454.kim@samsung.com>
References: <CGME20240819083433epcas1p3861b773a5b21eea6f0332036a71bb5d7@epcas1p3.samsung.com>
 <20240819083430.31852-1-youngjin.gil@samsung.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240819083430.31852-1-youngjin.gil@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/19 16:34, Yeongjin Gil wrote:
> In f2fs_do_write_data_page, when the data block is NULL_ADDR, it skips
> writepage considering that it has been already truncated.
> This results in an infinite loop as the PAGECACHE_TAG_TOWRITE tag is not
> cleared during the writeback process for a compressed file including
> NULL_ADDR in compress_mode=user.
> 
> This is the reproduction process:
> 
> 1. dd if=/dev/zero bs=4096 count=1024 seek=1024 of=testfile
> 2. f2fs_io compress testfile
> 3. dd if=/dev/zero bs=4096 count=1 conv=notrunc of=testfile
> 4. f2fs_io decompress testfile
> 
> To prevent the problem, let's check whether the cluster is fully
> allocated before redirty its pages.
> 
> Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
> Tested-by: Jaewook Kim <jw5454.kim@samsung.com>
> Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

