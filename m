Return-Path: <linux-kernel+bounces-196039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7300C8D5657
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BFF284496
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D548A180A71;
	Thu, 30 May 2024 23:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dh2h9nBd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121BA6F31E
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112367; cv=none; b=CZ4sS3JMKtEzsbLZBkjgwrRbbz4YNzWfa43xKZ60RthL3xGrkyIlZNqanIaT+xl7AZsy1xV7zsXEQ07W42V5+TACoi5v28eIqkmPiRWvoAhtDF+xCGUCfBm9zoXHCSuRFj+luZhkOE7T3uXU4QIgAO35LY1TNsn2aTr4+biICcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112367; c=relaxed/simple;
	bh=sVv/oR9gef/2s1T5b+tAfBDYtP0ALpovcy0y5xS7bFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpgeHG9IHZkjDaBsT5+WX3HNxpkSy0C3ZuS5fe2AsCaj1G9OQOryGvykb6BNC5RVrTNIZi+WhictGuhnNQ2U8pbRI1i0GPqvc/fpc8/OtCLlOm8bJgMGvJr7S705mOdGuTwT14I5flL/Vx+BYfos7eDC27RUoprBSte2il9R5do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dh2h9nBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62815C2BBFC;
	Thu, 30 May 2024 23:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717112366;
	bh=sVv/oR9gef/2s1T5b+tAfBDYtP0ALpovcy0y5xS7bFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dh2h9nBdEwLpAg8aiHA6n8oZ6P6LUJMFVKCYqrLXQWgduD7reb0Gijcw9JZCkd2qP
	 rxs8aGaOz/W4rCfZCtSPkkUqKYNmTlGqAeA53+UAU/w+TG0RTS8QUqvfz1nLYVLVPH
	 KYqHTIpOvKbuM7SmpWlKrL2sujfBXTXXpuiOLxInJwdOk5IVLL2HocfBkb2R/e3J20
	 Qa8Jp+UpKVh8yT8N5cNE0GwYAQochQ/X7rpyLI97UemOW6xl+gdhgUWtA7f75PgQwE
	 tqaVyZk5fbQn+QSLqJ28S+GqMJQINd0bQzwjLuVUUtoSjV3fwpPC7HfA0DLY0urqGo
	 NBCRNTIQwTRvg==
Date: Thu, 30 May 2024 23:39:24 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: use per-log target_bitmap to
 improve lookup performace of ssr allocation
Message-ID: <ZlkOLN0BugwQ2p5p@google.com>
References: <20240411082354.1691820-1-chao@kernel.org>
 <11d5d736-bae5-4a71-b400-087b8722893c@kernel.org>
 <03647897-8b1f-4c82-b2b6-0aa0704bed05@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03647897-8b1f-4c82-b2b6-0aa0704bed05@kernel.org>

On 05/29, Chao Yu wrote:
> Ping,

Chao, sorry, I might need some time to take a look at the change cautiously.

> 
> On 2024/4/23 10:07, Chao Yu wrote:
> > Jaegeuk, any comments for this serials?
> > 
> > On 2024/4/11 16:23, Chao Yu wrote:
> > > After commit 899fee36fac0 ("f2fs: fix to avoid data corruption by
> > > forbidding SSR overwrite"), valid block bitmap of current openned
> > > segment is fixed, let's introduce a per-log bitmap instead of temp
> > > bitmap to avoid unnecessary calculation overhead whenever allocating
> > > free slot w/ SSR allocator.
> > > 
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > > v2:
> > > - rebase to last dev-test branch.
> > >   fs/f2fs/segment.c | 30 ++++++++++++++++++++++--------
> > >   fs/f2fs/segment.h |  1 +
> > >   2 files changed, 23 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > index 6474b7338e81..af716925db19 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -2840,31 +2840,39 @@ static int new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
> > >       return 0;
> > >   }
> > > -static int __next_free_blkoff(struct f2fs_sb_info *sbi,
> > > -                    int segno, block_t start)
> > > +static void __get_segment_bitmap(struct f2fs_sb_info *sbi,
> > > +                    unsigned long *target_map,
> > > +                    int segno)
> > >   {
> > >       struct seg_entry *se = get_seg_entry(sbi, segno);
> > >       int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
> > > -    unsigned long *target_map = SIT_I(sbi)->tmp_map;
> > >       unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
> > >       unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
> > >       int i;
> > >       for (i = 0; i < entries; i++)
> > >           target_map[i] = ckpt_map[i] | cur_map[i];
> > > +}
> > > +
> > > +static int __next_free_blkoff(struct f2fs_sb_info *sbi, unsigned long *bitmap,
> > > +                    int segno, block_t start)
> > > +{
> > > +    __get_segment_bitmap(sbi, bitmap, segno);
> > > -    return __find_rev_next_zero_bit(target_map, BLKS_PER_SEG(sbi), start);
> > > +    return __find_rev_next_zero_bit(bitmap, BLKS_PER_SEG(sbi), start);
> > >   }
> > >   static int f2fs_find_next_ssr_block(struct f2fs_sb_info *sbi,
> > > -        struct curseg_info *seg)
> > > +                    struct curseg_info *seg)
> > >   {
> > > -    return __next_free_blkoff(sbi, seg->segno, seg->next_blkoff + 1);
> > > +    return __find_rev_next_zero_bit(seg->target_map,
> > > +                BLKS_PER_SEG(sbi), seg->next_blkoff + 1);
> > >   }
> > >   bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno)
> > >   {
> > > -    return __next_free_blkoff(sbi, segno, 0) < BLKS_PER_SEG(sbi);
> > > +    return __next_free_blkoff(sbi, SIT_I(sbi)->tmp_map, segno, 0) <
> > > +                            BLKS_PER_SEG(sbi);
> > >   }
> > >   /*
> > > @@ -2890,7 +2898,8 @@ static int change_curseg(struct f2fs_sb_info *sbi, int type)
> > >       reset_curseg(sbi, type, 1);
> > >       curseg->alloc_type = SSR;
> > > -    curseg->next_blkoff = __next_free_blkoff(sbi, curseg->segno, 0);
> > > +    curseg->next_blkoff = __next_free_blkoff(sbi, curseg->target_map,
> > > +                            curseg->segno, 0);
> > >       sum_page = f2fs_get_sum_page(sbi, new_segno);
> > >       if (IS_ERR(sum_page)) {
> > > @@ -4635,6 +4644,10 @@ static int build_curseg(struct f2fs_sb_info *sbi)
> > >                   sizeof(struct f2fs_journal), GFP_KERNEL);
> > >           if (!array[i].journal)
> > >               return -ENOMEM;
> > > +        array[i].target_map = f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE,
> > > +                                GFP_KERNEL);
> > > +        if (!array[i].target_map)
> > > +            return -ENOMEM;
> > >           if (i < NR_PERSISTENT_LOG)
> > >               array[i].seg_type = CURSEG_HOT_DATA + i;
> > >           else if (i == CURSEG_COLD_DATA_PINNED)
> > > @@ -5453,6 +5466,7 @@ static void destroy_curseg(struct f2fs_sb_info *sbi)
> > >       for (i = 0; i < NR_CURSEG_TYPE; i++) {
> > >           kfree(array[i].sum_blk);
> > >           kfree(array[i].journal);
> > > +        kfree(array[i].target_map);
> > >       }
> > >       kfree(array);
> > >   }
> > > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > > index e1c0f418aa11..10f3e44f036f 100644
> > > --- a/fs/f2fs/segment.h
> > > +++ b/fs/f2fs/segment.h
> > > @@ -292,6 +292,7 @@ struct curseg_info {
> > >       struct f2fs_summary_block *sum_blk;    /* cached summary block */
> > >       struct rw_semaphore journal_rwsem;    /* protect journal area */
> > >       struct f2fs_journal *journal;        /* cached journal info */
> > > +    unsigned long *target_map;        /* bitmap for SSR allocator */
> > >       unsigned char alloc_type;        /* current allocation type */
> > >       unsigned short seg_type;        /* segment type like CURSEG_XXX_TYPE */
> > >       unsigned int segno;            /* current segment number */
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

