Return-Path: <linux-kernel+bounces-563303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D418AA63CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 04:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A12C16B9F9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63F7207E1B;
	Mon, 17 Mar 2025 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/Q2ClrZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210ED207E14
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742181629; cv=none; b=juINKnPn5YXRiO7Hs4JJ9RAPXAlMXLg/WXA0EbN4s+3CwAM+SjUMeBUICxFzUHML/yyKAOgA7Phw5J0JysODSJJO2+CePFthNlWF96k4C0qnPcjsgBTLihCNEMxugBTIkK4/uiIetNzBAiHj0/zYsPrwIdM53KL6WQov/LJVo5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742181629; c=relaxed/simple;
	bh=na9zDyLGCts4zvbhbnkO+YnZ1DfpFRD6cSk88Yd3fd8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rLfQwLFB8cUu40VQn4a2q/BCHgm4NkEueTArw0EfciuCYAqhxe4mF8usRUnAykU3s4V70LlsW+mhaTeJ9TKHD8Vk1GpNE9Atx9+s2046jgCZMw9T8Fe6QnXI6j8EqKfMhD72U7ns6VWfh8sRmyokgEOUGSnyIf3dTVvo+5258wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/Q2ClrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE44C4CEDD;
	Mon, 17 Mar 2025 03:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742181628;
	bh=na9zDyLGCts4zvbhbnkO+YnZ1DfpFRD6cSk88Yd3fd8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=g/Q2ClrZM9mzpJD9kygj613MO2sLMyM7EwJ5BhQ2LE2zFtc/VXz/OuSMFs6glsIqR
	 JgYH+oXbyioDQkWpGMGNQZMAJkUlyUd4V7vokitTy3e2w6Av2EZoFpHJyhx/EL2eK0
	 Ui3ooDZVGhBc78nktNMBwfZ2vNBKXG3tdHdx44XzUo6dmIGYC12xTST1eXnjrvkgMq
	 6AFjre2q9RnIPx+acObHEkiTse7lEU7Cb1IPHG/O/T9IyycStt+kZzI3UkUAL9HUds
	 tM3xcpo2NsokBHXeg24du/Hp8b1yrrNTT7Omn+0XkYswHun3z98PaFR/lkiVVZE10g
	 DrF2T41b6xpqg==
Message-ID: <d1d43936-1de7-4550-8bf2-f4c604b367d1@kernel.org>
Date: Mon, 17 Mar 2025 11:20:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Yohan Joung <yohan.joung@sk.com>
Subject: Re: [PATCH v1] f2fs: optimize f2fs DIO overwrites
To: Yohan Joung <jyh429@gmail.com>, jaegeuk@kernel.org, daeho43@gmail.com
References: <20250312134805.362-1-yohan.joung@sk.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250312134805.362-1-yohan.joung@sk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 21:48, Yohan Joung wrote:
> this is unnecessary when we know we are overwriting already allocated
> blocks and the overhead of starting a transaction can be significant
> especially for multithreaded workloads doing small writes.
> 
> Signed-off-by: Yohan Joung <yohan.joung@sk.com>
> ---
>  fs/f2fs/data.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d872f785a996..b55d253f7be9 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -4181,7 +4181,8 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	map.m_next_pgofs = &next_pgofs;
>  	map.m_seg_type = f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
>  						inode->i_write_hint);
> -	if (flags & IOMAP_WRITE)
> +	if ((flags & IOMAP_WRITE) &&
> +		!f2fs_overwrite_io(inode, offset, length))

Can you please add a comment for this change? Otherwise it looks
fine to me.

Thanks,

>  		map.m_may_create = true;
>  
>  	err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DIO);


