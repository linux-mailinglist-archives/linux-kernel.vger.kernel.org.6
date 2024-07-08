Return-Path: <linux-kernel+bounces-243866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B080C929BF2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666F21F2141C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5E912E78;
	Mon,  8 Jul 2024 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOXKt8uK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F35125AC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720418956; cv=none; b=pHqeDH4b46PuOKvnXqEXwbv+CiJbgswkxU1Pl8nuKUFqglMIHYy9fD6RB/dCgG/M6i4U0tuHu5R1STRJH/xNBKraUIBDiLt4c9HEICQk36R6tUWIum/1DcfWUeAs77RkEkClXXVnDKBHIBQ5Fb+3V93yPvnTbofBX70QUATEcpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720418956; c=relaxed/simple;
	bh=e31UxuCuU39AhhqKTDVLOunVMLNlFlDSQUdrPqdpEDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOwSo3YPiGTZqIcG0ObK+WvLGw4ScO41T8A+bLephzKtSq+op1CwkilS5qALlWbk6bkDcy1oryzsw15GiWffb/t1ledkV8EPllP5OFVDcYM6rSedsFi8+WhSlUutCIQIMRyXuQ2HLweU+Kro/7z7ts6gUKB/h8T5Uy6fCokk32E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOXKt8uK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5CDC116B1;
	Mon,  8 Jul 2024 06:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720418956;
	bh=e31UxuCuU39AhhqKTDVLOunVMLNlFlDSQUdrPqdpEDU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WOXKt8uKJH0PeJD6Yi3tS2aMI7LdZ4xtVjfS1BwN5GjMj6kNzoSllY+1f/Y4WFu0c
	 oYzSnS3zDWNyvQGVst6SUWgwarRZGugewokpxlwqMupDgAZivnhvoZ+t+sYkrBjAx7
	 lA/AEtvjiEfvlWKdsr/iBO7KojWcOhsAKoqBIOXvgYzSyJ4wfeuAYRt1D/cwby/veC
	 f9shb3VGjmlmxyf2K+Xpx95UvFQ/c8Z0UXZxyyrFZ1u7ZapLJxHeQOMIjv17UesABc
	 Fhqu2TUT2Qb6X0DCYM40yk/xxNgtOwhrD/BdvDIGnGe7qGcwPP15J96X2auvMn1MVk
	 1B9rAhZjMe0Hg==
Message-ID: <5919b47f-616a-441d-bfe8-9c03739b61d7@kernel.org>
Date: Mon, 8 Jul 2024 14:09:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix start segno of large section
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240706091634.1970874-1-shengyong@oppo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240706091634.1970874-1-shengyong@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/6 17:16, Sheng Yong wrote:
> get_ckpt_valid_blocks() checks valid ckpt blocks in current section.
> It counts all vblocks from the first to the last segment in the
> large section. However, START_SEGNO() is used to get the first segno
> in an SIT block. This patch fixes that to get the correct start segno.
> 
> Fixes: 61461fc921b7 ("f2fs: fix to avoid touching checkpointed data in get_victim()")
> Signed-off-by: Sheng Yong <shengyong@oppo.com>
> ---
>   fs/f2fs/segment.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index e1c0f418aa11..6ed5bc811d2c 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -347,7 +347,8 @@ static inline unsigned int get_ckpt_valid_blocks(struct f2fs_sb_info *sbi,
>   				unsigned int segno, bool use_section)
>   {
>   	if (use_section && __is_large_section(sbi)) {
> -		unsigned int start_segno = START_SEGNO(segno);
> +		unsigned int start_segno = segno / SEGS_PER_SEC(sbi) *
> +							SEGS_PER_SEC(sbi);

How about using macro?

	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
	unsigned int start_seno = GET_SEG_FROM_SEC(sbi, secno);

Thanks,

>   		unsigned int blocks = 0;
>   		int i;
>   

