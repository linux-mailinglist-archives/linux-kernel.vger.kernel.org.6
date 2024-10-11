Return-Path: <linux-kernel+bounces-361414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5CC99A7DE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5BF31C208E9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E91195FEF;
	Fri, 11 Oct 2024 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrYYv8Wp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44235381E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660882; cv=none; b=BlF2Gwpw9WTXOrraEVAI2isCX50nBDE1yRngcQ/z0gQheqM8RdJm6IDrcYRi7//Ys7LKnyeQJKXXJiKmfgkLncBHAyqaPu4vCkSv3RwIIV6S7u1AG4GuDZdLcvzzccTvaEkEseAst6sLpDV5dzrtyJuEUfqwRwsfAn/6QOyjW1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660882; c=relaxed/simple;
	bh=2zjq4Ks3ur9+Akzi/sv+mw+4+XesiyAmSjBvkeudVnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WL1L5+vIpmSd7Cej/iICT7uUcFnwaBHU2lhHHGycLIgDGYFfHi7Wqp2EnREBBW8nkhoQLyM8hOK3kcI8t7slpgIqoqiz9psgMw/BU94vPE1cjkGhnlvijU8Veest8/zQ86z0h1n8wHc0desVzZOWKkbZX627HgI3UU+/enbQdPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrYYv8Wp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023EEC4CEC3;
	Fri, 11 Oct 2024 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728660882;
	bh=2zjq4Ks3ur9+Akzi/sv+mw+4+XesiyAmSjBvkeudVnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XrYYv8WpBXqLu3Zd+a3ilj9tVg/ivwC/p4/3/Bi3LvKsXPbnB9MkYuL6Bf+fhkJnz
	 IAgr54fHcMIl89Bhj4qpdnI3pMRKwsf/ZPuVp7Zp0w9S9tLb/HYvt+LZlXuVnuBCJz
	 2QFrSwUnMGfA4p5ZWZjn6ueJQZpmYZw23wCBppXrrH3lqnJRzIXNkFq5daA5KrngJ7
	 a8zlyHlxF+eb2SZ6D/2CxFnnUTKZ4pAZ8RRHz8BrZo4zWAlHXCgNibOSM+bZXQRAXM
	 PZdkpPus0Y7WR4V7SZL5qmDFqQnI7UEmNpav+XGOS1FTxNbjzSQrcjje97sF17f+GS
	 fylUdXK/Wx1RA==
Date: Fri, 11 Oct 2024 15:34:40 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Yonggil Song <yonggil.song@samsung.com>
Cc: Chao Yu <chao@kernel.org>,
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Dongjin Kim <dongjin_.kim@samsung.com>,
	Siwoo Jung <siu.jung@samsung.com>,
	Daejun Park <daejun7.park@samsung.com>
Subject: Re: [PATCH v2] libf2fs: Fix calculation of usable segments for single
Message-ID: <ZwlFkBAV2yxf1DBt@google.com>
References: <20241010043123epcms2p2ad514eb5e4a94413d8b26aea56f772a8@epcms2p2>
 <20241010021506epcms2p21d877e3c72389b41805db31f391d2b42@epcms2p2>
 <e26d7399-a0a7-4646-8e93-267cb20018cf@kernel.org>
 <20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303@epcms2p8>
 <CGME20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303@epcms2p7>
 <20241010045935epcms2p7ab5f54e9789b36ea496abcb100a7878f@epcms2p7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010045935epcms2p7ab5f54e9789b36ea496abcb100a7878f@epcms2p7>

On 10/10, Yonggil Song wrote:
> There was a problem that did not subtract the super block area when calculating
> the usable segments for a single zoned device with a conventional zone.
> This resulted in incorrect the overprovision and reserved area.
> 
> 	<256MiB legacy block + zoned block w/ 32MiB zone size>
> 	Info: Overprovision ratio = 3.570%
> 	Info: Overprovision segments = 656 (GC reserved = 560)
> 
> 	<8 conventional zone + 1016 sequential zone w/ 32MiB zone size>
> 	Info: Overprovision ratio = 3.700%
> 	Info: Overprovision segments = 676 (GC reserved = 578)
> 
> This patch addresses the problem by subtracting the super block area when
> there is only one zoned device.
> 
> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
> ---
>  lib/libf2fs_zoned.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
> index 89ba5ad73a76..1a0985378789 100644
> --- a/lib/libf2fs_zoned.c
> +++ b/lib/libf2fs_zoned.c
> @@ -555,6 +555,11 @@ uint32_t f2fs_get_usable_segments(struct f2fs_super_block *sb)
>  	}
>  	usable_segs -= (get_sb(main_blkaddr) - get_sb(segment0_blkaddr)) >>
>  						get_sb(log_blocks_per_seg);
> +
> +	/* single zoned device needs to remove a super block area */
> +	if (c.ndevs == 1 && c.devices[0].zoned_model == F2FS_ZONED_HM)

Does this work?

> +		usable_segs -= (get_sb(segment0_blkaddr) >> get_sb(log_blocks_per_seg));
> +
>  	return usable_segs;
>  #endif
>  	return get_sb(segment_count_main);
> -- 
> 2.43.0

