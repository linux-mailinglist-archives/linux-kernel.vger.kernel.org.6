Return-Path: <linux-kernel+bounces-443465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FCF9EF19D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3878617B6C6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29FF236FBA;
	Thu, 12 Dec 2024 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FG5qBbGZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48826226540
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020550; cv=none; b=OSZLQJ5Yl5tfMfVfzpgx+k0I8KAUUQMp2m5KJLbBcODmK266mBOJl862qaFUbVEGP7dkSQQhbBVY1iFFOTYuykVGPSAp0JI15XbniBz99WkW6P70clxB+y/0tJamYblGZ1CZiL11a5tP4KmaqvuUvwtnezMs/iZmEB4CBuP5QqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020550; c=relaxed/simple;
	bh=0gZG4E+lI17ylP0f1KSzZLx6ghl2G3iZ0xfmkYVpC0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aod4As+EsMDwnDHxS8mgNcGEanUTwxQUa9/z2bArZ4cIC7xWIg362wyqO+eBpU3DBttB97rdIp/yd3Vf3fCQrezylnbAJWTGv9BxD24NBVkQMsi5xX7vuW80I1oEz6v14tDrMU33/tu1I6D55C3erE8bbrX6Krb4ZE/k5sdBdfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FG5qBbGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E38C4CECE;
	Thu, 12 Dec 2024 16:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734020550;
	bh=0gZG4E+lI17ylP0f1KSzZLx6ghl2G3iZ0xfmkYVpC0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FG5qBbGZCMBihr7rFevPxWzXK77IQ6okBvEg2D4dRhnWcHbEHuTdIHNrjOD2S8VFr
	 f6N/zXLc/+/FWQeJIgdTurh0VVOYQVrr4tMgtEn58Unb3PAG109HQTJ0J5adQcwmth
	 oyR89XV/WP3/1spB/txmaVA8T/6T2sBaSW4i/NLK7iG7urz7OtstiPzMBjaqPQnS4u
	 XQyzgyZGw+jjSlvjUx/ra+/lCpj84N8iu4d9vTGsy1YB4EvHI9TQmjSKzMq3hYbWGI
	 E88meINsxfMpePD//iF6lqzqqi2bqbdk6P0CAYVI08hsfi+vytrW7WULTIkqjJPIO9
	 MIaaqrsU58gwg==
Date: Thu, 12 Dec 2024 16:22:27 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: yi sun <sunyibuaa@gmail.com>
Cc: Yi Sun <yi.sun@unisoc.com>, chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
	Hao_hao.Wang@unisoc.com, ke.wang@unisoc.com
Subject: Re: [PATCH v3 5/5] f2fs: Optimize f2fs_truncate_data_blocks_range()
Message-ID: <Z1sNw-rrvAnpwY3r@google.com>
References: <20241104034545.497907-1-yi.sun@unisoc.com>
 <20241104034545.497907-6-yi.sun@unisoc.com>
 <CALpufv34r8cMv0BtGXWLd_LEBjtMGM+CZ=XpnsL8Qr8WOsOk6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALpufv34r8cMv0BtGXWLd_LEBjtMGM+CZ=XpnsL8Qr8WOsOk6Q@mail.gmail.com>

On 12/11, yi sun wrote:
> Kindly ping.
> I think there are no problems with the first few patches, but the
> current patch may still have room for improvement. Do you have any
> good suggestions?

Hi, may I ask for some basic tests? Have you run xfstests?

> 
> On Mon, Nov 4, 2024 at 11:46 AM Yi Sun <yi.sun@unisoc.com> wrote:
> >
> > Function f2fs_invalidate_blocks() can process continuous
> > blocks at a time, so f2fs_truncate_data_blocks_range() is
> > optimized to use the new functionality of
> > f2fs_invalidate_blocks().
> >
> > Signed-off-by: Yi Sun <yi.sun@unisoc.com>
> > ---
> >  fs/f2fs/file.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 68 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 9366e7fc7c39..d20cc5f36d4c 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -612,6 +612,15 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
> >         return finish_preallocate_blocks(inode);
> >  }
> >
> > +static bool check_curr_block_is_consecutive(struct f2fs_sb_info *sbi,
> > +                                       block_t curr, block_t end)
> > +{
> > +       if (curr - end == 1 || curr == end)
> > +               return true;
> > +       else
> > +               return false;
> > +}
> > +
> >  void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
> >  {
> >         struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
> > @@ -621,8 +630,27 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
> >         int cluster_index = 0, valid_blocks = 0;
> >         int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
> >         bool released = !atomic_read(&F2FS_I(dn->inode)->i_compr_blocks);
> > +       /*
> > +        * Temporary record location.
> > +        * When the current  @blkaddr and @blkaddr_end can be processed
> > +        * together, update the value of @blkaddr_end.
> > +        * When it is detected that current @blkaddr is not continues with
> > +        * @blkaddr_end, it is necessary to process continues blocks
> > +        * range [blkaddr_start, blkaddr_end].
> > +        */
> > +       block_t blkaddr_start, blkaddr_end;
> > +       /*.
> > +        * To avoid processing various invalid data blocks.
> > +        * Because @blkaddr_start and @blkaddr_end may be assigned
> > +        * NULL_ADDR or invalid data blocks, @last_valid is used to
> > +        * record this situation.
> > +        */
> > +       bool last_valid = false;
> > +       /* Process the last @blkaddr separately? */
> > +       bool last_one = true;
> >
> >         addr = get_dnode_addr(dn->inode, dn->node_page) + ofs;
> > +       blkaddr_start = blkaddr_end = le32_to_cpu(*addr);
> >
> >         /* Assumption: truncation starts with cluster */
> >         for (; count > 0; count--, addr++, dn->ofs_in_node++, cluster_index++) {
> > @@ -638,24 +666,60 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
> >                 }
> >
> >                 if (blkaddr == NULL_ADDR)
> > -                       continue;
> > +                       goto next;
> >
> >                 f2fs_set_data_blkaddr(dn, NULL_ADDR);
> >
> >                 if (__is_valid_data_blkaddr(blkaddr)) {
> >                         if (time_to_inject(sbi, FAULT_BLKADDR_CONSISTENCE))
> > -                               continue;
> > +                               goto next;
> >                         if (!f2fs_is_valid_blkaddr_raw(sbi, blkaddr,
> >                                                 DATA_GENERIC_ENHANCE))
> > -                               continue;
> > +                               goto next;
> >                         if (compressed_cluster)
> >                                 valid_blocks++;
> >                 }
> >
> > -               f2fs_invalidate_blocks(sbi, blkaddr, 1);
> > +
> > +               if (check_curr_block_is_consecutive(sbi, blkaddr, blkaddr_end)) {
> > +                       /*
> > +                        * The current block @blkaddr is continuous with
> > +                        * @blkaddr_end, so @blkaddr_end is updated.
> > +                        * And the f2fs_invalidate_blocks() is skipped
> > +                        * until @blkaddr that cannot be processed
> > +                        * together is encountered.
> > +                        */
> > +                       blkaddr_end = blkaddr;
> > +                       if (count == 1)
> > +                               last_one = false;
> > +                       else
> > +                               goto skip_invalid;
> > +               }
> > +
> > +               f2fs_invalidate_blocks(sbi, blkaddr_start,
> > +                                       blkaddr_end - blkaddr_start + 1);
> > +               blkaddr_start = blkaddr_end = blkaddr;
> > +
> > +               if (count == 1 && last_one)
> > +                       f2fs_invalidate_blocks(sbi, blkaddr, 1);
> > +
> > +skip_invalid:
> > +               last_valid = true;
> >
> >                 if (!released || blkaddr != COMPRESS_ADDR)
> >                         nr_free++;
> > +
> > +               continue;
> > +
> > +next:
> > +               /* If consecutive blocks have been recorded, we need to process them. */
> > +               if (last_valid == true)
> > +                       f2fs_invalidate_blocks(sbi, blkaddr_start,
> > +                                       blkaddr_end - blkaddr_start + 1);
> > +
> > +               blkaddr_start = blkaddr_end = le32_to_cpu(*(addr + 1));
> > +               last_valid = false;
> > +
> >         }
> >
> >         if (compressed_cluster)
> > --
> > 2.25.1
> >

