Return-Path: <linux-kernel+bounces-174760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D057D8C149C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B548B229F2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA5F77103;
	Thu,  9 May 2024 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfCzvEu3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D01B770FB
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715278781; cv=none; b=TT2QSzP+bJRL6ZLQcaqjOqxnHnQyEbc6f+x1N/TZJOveBRJ4FRtU7+mAGHMvcrf3avgqgIISqS6ACrANZzdTD5HwGlM/Q+n8gCT3FXAl1rhWDICmyPifOfoxAyySL2hzqvba/QdP+aq+/F9BcdH5EtI+xNZBppQrx5WGt/HrixA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715278781; c=relaxed/simple;
	bh=/t2pB7QSKYBgF36Vts5qeGbyY0WPmNyjKYluvoaa0e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J02XKun1O6gNAKPuIksN9wx8cP3D4oIeXhlkpuAhuv7N8rFVSSYn0F4cJg/fz8sN69eovYSxF5sGxFM1qbWJtQ+ktjJ8+di8Bu0Z2MWfy8+1oBjy13MRF3PhGWhi1skSGQ4q7gYihzxW/ZCSuCSD9csoQv2SLAOUqJaqottUD8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfCzvEu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50157C116B1;
	Thu,  9 May 2024 18:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715278780;
	bh=/t2pB7QSKYBgF36Vts5qeGbyY0WPmNyjKYluvoaa0e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sfCzvEu3z3WHRI1nraVl6WeK1wotw9++4gucuIDqKxMu5wUS/QYU4aFM+u13Ot/29
	 ilihfAxTJySycWkwZWHBRBctf/dDFrBNmw9zUC0zIAvXcvLXHVi/MFpp7ZGqFUhZoG
	 lWBKWGZtV8iFVlZqyQcngV3ZaHRB+DoNcAYC84c/QWFY26T2fwO3th9B4WN4yncRKA
	 6REhCvNjCrscVWbiHuWWP4lrQi8mAqL6PXjCg7wdpgeftsOHUaq1tVXBvgdkmhUqIV
	 LhYk/fUpJnP5+zYDzLugEYyf57oPesdOBkk5wL4gTP5LkSTNeE0V2P06vtnPjAEKCQ
	 1rYQMvEWRSNuQ==
Date: Thu, 9 May 2024 18:19:38 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow dirty sections with zero valid
 block for checkpoint disabled
Message-ID: <Zj0TuhzHzevgxGfe@google.com>
References: <20240507175628.2460390-1-daeho43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507175628.2460390-1-daeho43@gmail.com>

On 05/07, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Following the semantic for dirty segments in checkpoint disabled mode,
> apply the same rule to dirty sections.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/segment.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 6474b7338e81..2463398b243f 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -771,8 +771,11 @@ static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
>  			block_t valid_blocks =
>  				get_valid_blocks(sbi, segno, true);
>  
> -			f2fs_bug_on(sbi, unlikely(!valid_blocks ||
> -					valid_blocks == CAP_BLKS_PER_SEC(sbi)));
> +			if (!is_sbi_flag_set(sbi, SBI_CP_DISABLED))
> +				f2fs_bug_on(sbi, unlikely(!valid_blocks));
> +
> +			f2fs_bug_on(sbi, unlikely(valid_blocks ==
> +					CAP_BLKS_PER_SEC(sbi)));

What about:
f2fs_bug_on(sbi,
	(!is_sbi_flag_set(sbi, SBI_CP_DISABLED) && !valid_blocks) ||
	valid_blocks == CAP_BLKS_PER_SEC(sbi));

>  
>  			if (!IS_CURSEC(sbi, secno))
>  				set_bit(secno, dirty_i->dirty_secmap);
> -- 
> 2.45.0.rc1.225.g2a3ae87e7f-goog
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

