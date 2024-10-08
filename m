Return-Path: <linux-kernel+bounces-354853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3685994386
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC93C1C23E8E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D442566;
	Tue,  8 Oct 2024 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqwKyJBG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002B77603F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378136; cv=none; b=uvBt7f+YVvJUCsYjp4TNLi/cVCyYYYjrSwefK2P6QfnnQDJDNduOpS7kk5S61WzLg08CN7ipDuF2fqsBhIpSvi0S++u6TshEyiAFHmCxhNe6y17gUy69cWBcuD4lRs2xeZadoJtBRCvKv8MEDeozw2Xa1H361SXRWgdVDX3NXEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378136; c=relaxed/simple;
	bh=zQiizLClsBxLSB6OT29x/oYUUPknpiOhCSGFL9uzqss=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N86n0IpFtnYBRH1eA69fYsIZCq6ydCVEfTTASMsqYLPC/OoRjTiulhbHvPuKm9DY1+cehyXsDTjAwQ+j3dEmCquz0Fh1fLFEYFTReNgRmF+EzRNCiNQ+6xY2pi0APZ0ayfenEXEmxDr0+z75fjjuirk92he/q37UhOSNfjJLVEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqwKyJBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D699C4CEC7;
	Tue,  8 Oct 2024 09:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728378135;
	bh=zQiizLClsBxLSB6OT29x/oYUUPknpiOhCSGFL9uzqss=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=BqwKyJBGoOtUn3Lm6JXfWX2U+P70Ov3aYIWIRDLij0ssPOcz09+7q4cYsPRJ616vI
	 stbpdemTOLWcSQTlSlL5JsnUBZ0/nkXr7B7Fwp2mqL5XOk1jCj2nNWVmJ/OGNCTQRx
	 Z6Um54hAnU8jJi3r7zWGbs42q2v6td4JNG61fCTIWQHalAN7UTdNY532p/z5rgo25M
	 JPKSEUoogE5klojYva5jG6laXrwHx5eXxnui3ZjyG9QGS6V4RAli0Znx4IHe8puSyk
	 UiYKs95a5iG5h5ecx8ym+qIs9FtW4gNZz0D4STY6mfqlDEfCc+AeRzGqwBIe+qnu+v
	 qrBQhZBvsH6yg==
Message-ID: <e26d7399-a0a7-4646-8e93-267cb20018cf@kernel.org>
Date: Tue, 8 Oct 2024 17:02:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] libf2fs: Fix calculation of usable segments for single
 zoned
To: yonggil.song@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Dongjin Kim <dongjin_.kim@samsung.com>, Siwoo Jung <siu.jung@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
References: <CGME20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303@epcms2p8>
 <20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303@epcms2p8>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241007052122epcms2p8a7a733c92a8da751ac64af8a29de0303@epcms2p8>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/7 13:21, Yonggil Song wrote:
> There was a bug that did not subtract the super block area when calculating
> the usable segments for a single zoned device with a conventional zone.
> This bug resulted in incorrect the overprovision and reserved area.
> 
> 	<256MiB legacy block + zoned block w/ 32MiB zone size>
> 	Info: Overprovision ratio = 3.570%
> 	Info: Overprovision segments = 656 (GC reserved = 560)
> 
> 	<8 conventional zone + 1016 sequential zone w/ 32MiB zone size>
> 	Info: Overprovision ratio = 3.700%
> 	Info: Overprovision segments = 676 (GC reserved = 578)
> 
> This patch fixes the bug by subtracting the super block area when there is
> only one zoned device.
> 
> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
> ---
>   lib/libf2fs_zoned.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
> index 89ba5ad73a76..cc5c064b7e3e 100644
> --- a/lib/libf2fs_zoned.c
> +++ b/lib/libf2fs_zoned.c
> @@ -555,6 +555,11 @@ uint32_t f2fs_get_usable_segments(struct f2fs_super_block *sb)
>   	}
>   	usable_segs -= (get_sb(main_blkaddr) - get_sb(segment0_blkaddr)) >>
>   						get_sb(log_blocks_per_seg);
> +
> +	/* single zoned device needs to remove a super block area */

If we don't format zoned device, it doesn't need to do this?

Thanks,

> +	if (c.ndevs == 1)
 > +		usable_segs -= (get_sb(segment0_blkaddr) >> get_sb(log_blocks_per_seg));> +
>   	return usable_segs;
>   #endif
>   	return get_sb(segment_count_main);


