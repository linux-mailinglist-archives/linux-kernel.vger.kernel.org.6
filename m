Return-Path: <linux-kernel+bounces-193898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE3A8D33CC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B970A1C22457
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EF616E89C;
	Wed, 29 May 2024 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVhPXxqk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9FC16A360
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976655; cv=none; b=dGGStKPTmUA3VVpBjJEro4SUlJ2EZWbwBvL0Q9Io/YSiH1X0L+pCZSXqJU6UrfdyjA4eiwgN6kXTy/fFNef/tFRudylhB60ANJ8vsfmVAhJ9M610F84nT9/vMKpHaZU2cVEJZQ1SLjHRJ0CtqLYdcdJw3eZJjbtLoHykwZCf3nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976655; c=relaxed/simple;
	bh=6XgEyPsEN2NFoJlrtqnjT0UAsnXAycD0xgXGpmhOtc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCBpo0YjfrbdNQ38MaeY70btbShbhbYC8Qt7bWSBenbcZRZ7ZmRtCIzCDApElSqRF6cO9deOCuK1GFQKyGy29HmYFI3zYEfKtI8neSq51GI8Fluk+663K3qX/e+Q9HFdaXKTtpjSmwBUcmoGxhyzJVROGM3P6jLvXQWOoaNHJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVhPXxqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE548C32786;
	Wed, 29 May 2024 09:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716976654;
	bh=6XgEyPsEN2NFoJlrtqnjT0UAsnXAycD0xgXGpmhOtc0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SVhPXxqkJ5iR85XHhjMyba0+veN+xlnvqZa+qCAzsIptXQyKKftc9Y65yuALp0f81
	 I63nHeQrHyNb8jqIgbfNtleyQHR3S2IT12R8N2cmJ34u2bve/jKSB/F1tjOu/6lPHU
	 5zaI5Owq88NkMMTglLDHon/Ftk/8zaIetimTAL506CD6L8US8qAEoGTuMzxtPxyH7s
	 ZCYrOlnOrOM7MVwFjBFdiP+gVZQnOsED36Mt7GmZ7kk8ibouRzfHTzoXVlJaBKl/qx
	 lGSXtZbzWGd9Ma56jSnm1eN69DZeUqefSU3NKaIQxhxLR1n0lf/9amdjkYgT2TQV8H
	 Ns3vQOWIGQZCw==
Message-ID: <19f53d36-0415-4b34-9b6b-e28ea19a44f0@kernel.org>
Date: Wed, 29 May 2024 17:57:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] f2fs: fix to avoid use SSR allocate when do defragment
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
References: <1716976020-28757-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1716976020-28757-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/29 17:47, Zhiguo Niu wrote:
> SSR allocate mode will be used when doing file defragment
> if ATGC is working at the same time, that is because
> set_page_private_gcing may make CURSEG_ALL_DATA_ATGC segment
> type got in f2fs_allocate_data_block when defragment page
> is writeback, which may cause file fragmentation is worse.
> 
> A file with 2 fragmentations is changed as following after defragment:
> 
> ----------------file info-------------------
> sensorsdata :
> --------------------------------------------
> dev       [254:48]
> ino       [0x    3029 : 12329]
> mode      [0x    81b0 : 33200]
> nlink     [0x       1 : 1]
> uid       [0x    27e6 : 10214]
> gid       [0x    27e6 : 10214]
> size      [0x  242000 : 2367488]
> blksize   [0x    1000 : 4096]
> blocks    [0x    1210 : 4624]
> --------------------------------------------
> 
> file_pos   start_blk     end_blk        blks
>         0    11361121    11361207          87
>    356352    11361215    11361216           2
>    364544    11361218    11361218           1
>    368640    11361220    11361221           2
>    376832    11361224    11361225           2
>    385024    11361227    11361238          12
>    434176    11361240    11361252          13
>    487424    11361254    11361254           1
>    491520    11361271    11361279           9
>    528384     3681794     3681795           2
>    536576     3681797     3681797           1
>    540672     3681799     3681799           1
>    544768     3681803     3681803           1
>    548864     3681805     3681805           1
>    552960     3681807     3681807           1
>    557056     3681809     3681809           1
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

