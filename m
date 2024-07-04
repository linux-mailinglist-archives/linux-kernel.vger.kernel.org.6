Return-Path: <linux-kernel+bounces-240645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A929927059
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8746283FB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB1F1A2548;
	Thu,  4 Jul 2024 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYyWGdMs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D911A254F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720077358; cv=none; b=LrBou0wpMyIO8meKlJashRI432OoM9aeYHSLFZXHKP3zPOVqzPLDluNuXZdktEVaTv4hHBO1nQwbLWqgCOVBWnUk8Nt/MBIqJ9x1BZwG98c9hHKsZNwWPLE3rsyJqDtZnybxKSStFQzYCclrhGd+fLG248ZXF8+5RJuEqUkMyNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720077358; c=relaxed/simple;
	bh=pQbfYzQWPX0rbbB4vNj8e9Rf84wXlBV0HGoeVKAEc04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIATiWDVQatGbwWxPeV3bw1u1EuY+3h7oq5k6o2OeOkh4uDCBPjIiFlNJHAyGOAhy1wfmnRI3hZTckY27ppIf3u3f5PANHugU9pZMjDRqF+0vWdQ3u6FUWjL+r6eC9O8wOs3v7n/XBDKlg/i0E2rdC/A7saSdXKRLJ/TNfvBbLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYyWGdMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD710C32781;
	Thu,  4 Jul 2024 07:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720077358;
	bh=pQbfYzQWPX0rbbB4vNj8e9Rf84wXlBV0HGoeVKAEc04=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZYyWGdMso/danZkI6QiYRlBhcTMi3EeRhJVJa0dy3SlseYpONgZzK5CXnwAtoYs+R
	 VIfKDInlvzlDkopnSCLoYfaR0WzL6Jj4XsY5IDPWS0ykGCc7Z9FC7tXCeUXA+O6js+
	 QuHYhNokdxfYQlHjFiezGt/MqLlRz+U3V1UgqErJb3MRHqIoE0rkJulCh+R+XAYhh5
	 tcQxG2UvoWAR5/2SyVnH5NLKa9JDnjBjyB9nsx/Smw9Hr5zU48qV0EtToY/NyFsTnu
	 9f5z82i/g0yb11MwrpeM+/yYBpSFdcd4vYufzjOmZuH2+HIiSu4Tl3sbrAhCVr+oVT
	 VwldnW8zBmuDA==
Message-ID: <460c4708-3ec6-4fbc-8f6c-7f8e5f901061@kernel.org>
Date: Thu, 4 Jul 2024 15:15:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix null reference error when checking end of zone
To: daejun7.park@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "daehojeong@google.com" <daehojeong@google.com>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Seokhwan Kim <sukka.kim@samsung.com>,
 Dongjin Kim <dongjin_.kim@samsung.com>,
 Yonggil Song <yonggil.song@samsung.com>,
 Jaeyoon Choi <j_yoon.choi@samsung.com>, Nayeon Kim
 <nayeoni.kim@samsung.com>, Siwoo Jung <siu.jung@samsung.com>
References: <CGME20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90@epcms2p4>
 <20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90@epcms2p4>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240704010121epcms2p4cff8b25d976d4a1b820ba18f1eb5aa90@epcms2p4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/4 9:01, Daejun Park wrote:
> This patch fixes a potentially null pointer being accessed by
> is_end_zone_blkaddr() that checks the last block of a zone
> when f2fs is mounted as a single device.

blkzoned feature depends on multiple device feature? One regular
device and one seq-zone device?

Thanks,

> 
> Fixes: e067dc3c6b9c ("f2fs: maintain six open zones for zoned devices")
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> ---
>   fs/f2fs/data.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index b6dcb3bcaef7..1aa7eefa659c 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -925,6 +925,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>   #ifdef CONFIG_BLK_DEV_ZONED
>   static bool is_end_zone_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr)
>   {
> +	struct block_device *bdev = sbi->sb->s_bdev;
>   	int devi = 0;
>   
>   	if (f2fs_is_multi_device(sbi)) {
> @@ -935,8 +936,9 @@ static bool is_end_zone_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr)
>   			return false;
>   		}
>   		blkaddr -= FDEV(devi).start_blk;
> +		bdev = FDEV(devi).bdev;
>   	}
> -	return bdev_is_zoned(FDEV(devi).bdev) &&
> +	return bdev_is_zoned(bdev) &&
>   		f2fs_blkz_is_seq(sbi, devi, blkaddr) &&
>   		(blkaddr % sbi->blocks_per_blkz == sbi->blocks_per_blkz - 1);
>   }

