Return-Path: <linux-kernel+bounces-330956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCAE97A678
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06E21C264BF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734AD158D8B;
	Mon, 16 Sep 2024 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYVzPd4G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9593142E77
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726506620; cv=none; b=lbxfGtdn8XckF9ip0uXTCK58IWXb4m+tIazSOFbcBPSpUAPh1VOdjMg7tfLwCkBg36h1L+z4XgdcaO83epg6ZE/SGxbw3ok55Dj8kbMX1spJEtQslnzZ5AD/FrRxS2s3YmpA+qPlTaiQC+wHlVPjd2ec50lYuRsDXS3jO5MU5aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726506620; c=relaxed/simple;
	bh=PURqVwYInz1hujzo3/vXTwZMB9mBg4BhaAV1rQrozjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1X9+zaA03zyt/teys6WreBcVRddpvJLdTH2Q+pQHWstce+jXl+EYfeOMIyKynouku9HAO1mkwAcO/so394IXChOpPp/RzmtMrPxXx8W4ZR0sjQS6PS4ML7IMGwjXWwzoz4+176TxuHeXL/ucP/Vu28C/ERCy/g07Ssto4iZK+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYVzPd4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3D6C4CEC4;
	Mon, 16 Sep 2024 17:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726506620;
	bh=PURqVwYInz1hujzo3/vXTwZMB9mBg4BhaAV1rQrozjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYVzPd4GlcKPGzyilsgs6LNVSXeAzubd7CGQqnbBvI5AgcSQzthSnnIcjk9AphdnL
	 r4IjShn6z82jSIptkPop4E8sx6vEQsvT7zkglRRyb+dWEFwApznN8tOnhwAkpSdGCP
	 fS0l69VvtwayVZ+F86L0m59biJZXyDz8PI2MGKPqna7L81p6pEU3kE2XTWwjLGy4yy
	 KbE9b+SJFyK1TY1KV0l0VP0YFWzIwIP9ib6ZK4i5Eo2+Jo84sTDTazKgX0l+dG6A1K
	 xG7VvX+st7udhQqMpH8ohARpwpUNzb4tRajBFv1SrH8UMvPIaLIiAWIj3A7G21T4hA
	 yR9Nt43JobOSA==
Date: Mon, 16 Sep 2024 17:10:18 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH 2/2] mkfs.f2fs: add device aliasing feature
Message-ID: <ZuhmerGguMOoFAtl@google.com>
References: <20240913212802.912131-1-daeho43@gmail.com>
 <20240913212802.912131-2-daeho43@gmail.com>
 <ZuS8Tcw9V1vlyK1L@google.com>
 <CACOAw_zTWUSDpn33LuYNFVkdSD2+xq6kKvrk_LLqE1mckWh9vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACOAw_zTWUSDpn33LuYNFVkdSD2+xq6kKvrk_LLqE1mckWh9vw@mail.gmail.com>

On 09/16, Daeho Jeong wrote:
> On Fri, Sep 13, 2024 at 3:27 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > On 09/13, Daeho Jeong wrote:
> > > From: Daeho Jeong <daehojeong@google.com>
> > >
> > > We can add a device aliasing file which can map the whole device with an
> > > extent, not using node blocks. This mapped area should be pinned and
> > > normally used for read-only usages. After finished using it, we can
> > > deallocate the whole area and return it back to use it for other files.
> > >
> > > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > > ---
> > >  fsck/dump.c             |  13 ++
> > >  fsck/fsck.c             |  49 ++++--
> > >  fsck/fsck.h             |   4 +-
> > >  fsck/main.c             |   5 +
> > >  include/f2fs_fs.h       |  11 ++
> > >  mkfs/f2fs_format.c      | 335 ++++++++++++++++++++++++++++++++--------
> > >  mkfs/f2fs_format_main.c |  30 +++-
> > >  7 files changed, 363 insertions(+), 84 deletions(-)
> > >
> > > diff --git a/fsck/dump.c b/fsck/dump.c
> > > index 8d5613e..aa9b5d3 100644
> > > --- a/fsck/dump.c
> > > +++ b/fsck/dump.c
> > > @@ -499,6 +499,19 @@ static int dump_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
> > >       }
> > >
> > >       c.show_file_map_max_offset = f2fs_max_file_offset(&node_blk->i);
> > > +
> > > +     if (IS_ALIASING(&node_blk->i)) {
> > > +             u32 blkaddr = le32_to_cpu(node_blk->i.i_ext.blk_addr);
> > > +             u32 len = le32_to_cpu(node_blk->i.i_ext.len);
> > > +             u32 idx;
> > > +
> > > +             for (idx = 0; idx < len; idx++)
> > > +                     dump_data_blk(sbi, idx * F2FS_BLKSIZE, blkaddr++, false);
> > > +             print_extent(true);
> > > +
> > > +             goto dump_xattr;
> > > +     }
> > > +
> > >       addr_per_block = ADDRS_PER_BLOCK(&node_blk->i);
> > >
> > >       /* check data blocks in inode */
> > > diff --git a/fsck/fsck.c b/fsck/fsck.c
> > > index f8607fd..6feb294 100644
> > > --- a/fsck/fsck.c
> > > +++ b/fsck/fsck.c
> > > @@ -914,6 +914,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
> > >       int need_fix = 0;
> > >       int ret;
> > >       u32 cluster_size = 1 << node_blk->i.i_log_cluster_size;
> > > +     bool is_aliasing = IS_ALIASING(&node_blk->i);
> > >
> > >       if (!compressed)
> > >               goto check_next;
> > > @@ -1146,6 +1147,33 @@ check_next:
> > >                               addrs_per_blk * NIDS_PER_BLOCK *
> > >                               NIDS_PER_BLOCK) * F2FS_BLKSIZE;
> > >       }
> > > +
> > > +     if (is_aliasing) {
> > > +             struct extent_info ei;
> > > +
> > > +             get_extent_info(&ei, &node_blk->i.i_ext);
> > > +             for (idx = 0; idx < ei.len; idx++, child.pgofs++) {
> > > +                     block_t blkaddr = ei.blk + idx;
> > > +
> > > +                     /* check extent info */
> > > +                     check_extent_info(&child, blkaddr, 0);
> > > +                     ret = fsck_chk_data_blk(sbi, &node_blk->i, blkaddr,
> > > +                             &child, (i_blocks == *blk_cnt), ftype, nid,
> > > +                             idx, ni->version, node_blk);
> > > +                     if (!ret) {
> > > +                             *blk_cnt = *blk_cnt + 1;
> > > +                             if (cur_qtype != -1)
> > > +                                     qf_last_blkofs[cur_qtype] = child.pgofs;
> > > +                     } else if (c.fix_on) {
> > > +                             node_blk->i.i_ext.len = cpu_to_le32(idx);
> > > +                             need_fix = 1;
> > > +                             break;
> > > +                     }
> > > +             }
> > > +
> > > +             goto check;
> > > +     }
> > > +
> > >       for (idx = 0; idx < addrs; idx++, child.pgofs++) {
> > >               block_t blkaddr = le32_to_cpu(node_blk->i.i_addr[ofs + idx]);
> > >
> > > @@ -1178,11 +1206,11 @@ check_next:
> > >                               child.pgofs - cbc->cheader_pgofs < cluster_size)
> > >                       cbc->cnt++;
> > >               ret = fsck_chk_data_blk(sbi,
> > > -                             IS_CASEFOLDED(&node_blk->i),
> > > +                             &node_blk->i,
> > >                               blkaddr,
> > >                               &child, (i_blocks == *blk_cnt),
> > >                               ftype, nid, idx, ni->version,
> > > -                             file_is_encrypt(&node_blk->i), node_blk);
> > > +                             node_blk);
> > >               if (blkaddr != le32_to_cpu(node_blk->i.i_addr[ofs + idx]))
> > >                       need_fix = 1;
> > >               if (!ret) {
> > > @@ -1376,7 +1404,7 @@ skip_blkcnt_fix:
> > >       }
> > >
> > >       /* drop extent information to avoid potential wrong access */
> > > -     if (need_fix && f2fs_dev_is_writable())
> > > +     if (need_fix && f2fs_dev_is_writable() && !is_aliasing)
> > >               node_blk->i.i_ext.len = 0;
> > >
> > >       if ((c.feature & F2FS_FEATURE_INODE_CHKSUM) &&
> > > @@ -1448,11 +1476,9 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
> > >               if (!compr_rel && blkaddr == NEW_ADDR && child->pgofs -
> > >                               cbc->cheader_pgofs < cluster_size)
> > >                       cbc->cnt++;
> > > -             ret = fsck_chk_data_blk(sbi, IS_CASEFOLDED(inode),
> > > -                     blkaddr, child,
> > > +             ret = fsck_chk_data_blk(sbi, inode, blkaddr, child,
> > >                       le64_to_cpu(inode->i_blocks) == *blk_cnt, ftype,
> > > -                     nid, idx, ni->version,
> > > -                     file_is_encrypt(inode), node_blk);
> > > +                     nid, idx, ni->version, node_blk);
> > >               if (blkaddr != le32_to_cpu(node_blk->dn.addr[idx]))
> > >                       need_fix = 1;
> > >               if (!ret) {
> > > @@ -2056,12 +2082,15 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, int casefolded, u32 blk_addr,
> > >       return 0;
> > >  }
> > >
> > > -int fsck_chk_data_blk(struct f2fs_sb_info *sbi, int casefolded,
> > > +int fsck_chk_data_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
> > >               u32 blk_addr, struct child_info *child, int last_blk,
> > >               enum FILE_TYPE ftype, u32 parent_nid, u16 idx_in_node, u8 ver,
> > > -             int enc_name, struct f2fs_node *node_blk)
> > > +             struct f2fs_node *node_blk)
> > >  {
> > >       struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
> > > +     int casefolded = IS_CASEFOLDED(inode);
> > > +     int enc_name = file_is_encrypt(inode);
> > > +     int aliasing = IS_ALIASING(inode);
> > >
> > >       /* Is it reserved block? */
> > >       if (blk_addr == NEW_ADDR) {
> > > @@ -2074,7 +2103,7 @@ int fsck_chk_data_blk(struct f2fs_sb_info *sbi, int casefolded,
> > >               return -EINVAL;
> > >       }
> > >
> > > -     if (is_valid_ssa_data_blk(sbi, blk_addr, parent_nid,
> > > +     if (!aliasing && is_valid_ssa_data_blk(sbi, blk_addr, parent_nid,
> > >                                               idx_in_node, ver)) {
> > >               ASSERT_MSG("summary data block is not valid. [0x%x]",
> > >                                               parent_nid);
> > > diff --git a/fsck/fsck.h b/fsck/fsck.h
> > > index 6cac926..d306c22 100644
> > > --- a/fsck/fsck.h
> > > +++ b/fsck/fsck.h
> > > @@ -179,9 +179,9 @@ extern int fsck_chk_idnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
> > >  extern int fsck_chk_didnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
> > >               enum FILE_TYPE, struct f2fs_node *, u32 *,
> > >               struct f2fs_compr_blk_cnt *, struct child_info *);
> > > -extern int fsck_chk_data_blk(struct f2fs_sb_info *, int,
> > > +extern int fsck_chk_data_blk(struct f2fs_sb_info *, struct f2fs_inode *,
> > >               u32, struct child_info *, int, enum FILE_TYPE, u32, u16, u8,
> > > -             int, struct f2fs_node *);
> > > +             struct f2fs_node *);
> > >  extern int fsck_chk_dentry_blk(struct f2fs_sb_info *, int,
> > >               u32, struct child_info *, int, int, struct f2fs_node *);
> > >  int fsck_chk_inline_dentries(struct f2fs_sb_info *, struct f2fs_node *,
> > > diff --git a/fsck/main.c b/fsck/main.c
> > > index c13e287..c4f6167 100644
> > > --- a/fsck/main.c
> > > +++ b/fsck/main.c
> > > @@ -976,6 +976,11 @@ static int do_defrag(struct f2fs_sb_info *sbi)
> > >               return -1;
> > >       }
> > >
> > > +     if (get_sb(feature) & F2FS_FEATURE_DEVICE_ALIAS) {
> > > +             MSG(0, "Not support on image with device aliasing feature.\n");
> > > +             return -1;
> > > +     }
> > > +
> > >       if (c.defrag_start > get_sb(block_count))
> > >               goto out_range;
> > >       if (c.defrag_start < SM_I(sbi)->main_blkaddr)
> > > diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> > > index fdbc25b..108fde3 100644
> > > --- a/include/f2fs_fs.h
> > > +++ b/include/f2fs_fs.h
> > > @@ -442,6 +442,7 @@ struct device_info {
> > >       uint64_t start_blkaddr;
> > >       uint64_t end_blkaddr;
> > >       uint32_t total_segments;
> > > +     char *alias_filename;
> > >
> > >       /* to handle zone block devices */
> > >       int zoned_model;
> > > @@ -661,7 +662,13 @@ enum {
> > >   */
> > >  #define F2FS_IMMUTABLE_FL            0x00000010 /* Immutable file */
> > >  #define F2FS_NOATIME_FL                      0x00000080 /* do not update atime */
> > > +#define F2FS_DEVICE_ALIAS_FL         0x80000000 /* File for aliasing a device */
> > > +#define IS_ALIASING(fi)     ((fi)->i_flags & cpu_to_le32(F2FS_DEVICE_ALIAS_FL))
> >
> > Could you please rebase on the latest f2fs-tools? I got merge conflict around
> > here.
> 
> Let me rebase it.
> 
> >
> > >
> > > +/*
> > > + * On-disk file inline flags (f2fs_inode::i_inline)
> > > + */
> > > +#define F2FS_PIN_FILE           0x40    /* file should not be gced */
> >
> > Do we need the above define?
> 
> We need this to set F2FS_PIN_FILE to device aliasing files.

The definition already exists in:

 964 #define F2FS_PIN_FILE           0x40    /* file should not be gced */

> 
> >
> > >
> > >  #define F2FS_ENC_UTF8_12_1   1
> > >  #define F2FS_ENC_STRICT_MODE_FL      (1 << 0)
> > > @@ -694,6 +701,7 @@ enum {
> > >  #define F2FS_FEATURE_CASEFOLD                0x1000
> > >  #define F2FS_FEATURE_COMPRESSION     0x2000
> > >  #define F2FS_FEATURE_RO                      0x4000
> > > +#define F2FS_FEATURE_DEVICE_ALIAS    0x8000
> > >
> > >  #define MAX_NR_FEATURE                       32
> > >
> > > @@ -1515,11 +1523,14 @@ struct f2fs_configuration {
> > >       time_t fixed_time;
> > >       int roll_forward;
> > >       bool need_fsync;
> > > +     int aliased_devices;
> > > +     uint32_t aliased_segments;
> > >
> > >       /* mkfs parameters */
> > >       int fake_seed;
> > >       uint32_t next_free_nid;
> > >       uint32_t lpf_ino;
> > > +     uint32_t first_alias_ino;
> > >       uint32_t root_uid;
> > >       uint32_t root_gid;
> > >       uint32_t blksize;
> > > diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> > > index db1bc89..077f620 100644
> > > --- a/mkfs/f2fs_format.c
> > > +++ b/mkfs/f2fs_format.c
> > > @@ -13,6 +13,7 @@
> > >  #include <unistd.h>
> > >  #include <f2fs_fs.h>
> > >  #include <assert.h>
> > > +#include <stdbool.h>
> > >
> > >  #ifdef HAVE_SYS_STAT_H
> > >  #include <sys/stat.h>
> > > @@ -39,10 +40,62 @@ struct f2fs_super_block raw_sb;
> > >  struct f2fs_super_block *sb = &raw_sb;
> > >  struct f2fs_checkpoint *cp;
> > >
> > > +static inline bool device_is_aliased(unsigned int dev_num)
> > > +{
> > > +     if (dev_num >= c.ndevs)
> > > +             return false;
> > > +     return c.devices[dev_num].alias_filename != NULL;
> > > +}
> > > +
> > > +static inline unsigned int target_device_index(uint64_t blkaddr)
> > > +{
> > > +     int i;
> > > +
> > > +     for (i = 0; i < c.ndevs; i++)
> > > +             if (c.devices[i].start_blkaddr <= blkaddr &&
> > > +                             c.devices[i].end_blkaddr >= blkaddr)
> > > +                     return i;
> > > +     return 0;
> > > +}
> > > +
> > > +#define GET_SEGNO(blk_addr) ((blk_addr - get_sb(main_blkaddr)) / \
> > > +                             c.blks_per_seg)
> > > +#define START_BLOCK(segno) (segno * c.blks_per_seg + get_sb(main_blkaddr))
> > > +
> > >  /* Return first segment number of each area */
> > > -#define prev_zone(cur)               (c.cur_seg[cur] - c.segs_per_zone)
> > > -#define next_zone(cur)               (c.cur_seg[cur] + c.segs_per_zone)
> > > -#define last_zone(cur)               ((cur - 1) * c.segs_per_zone)
> > > +static inline uint32_t next_zone(int seg_type)
> > > +{
> > > +     uint32_t next_seg = c.cur_seg[seg_type] + c.segs_per_zone;
> > > +     uint64_t next_blkaddr = START_BLOCK(next_seg);
> > > +     int dev_num;
> > > +
> > > +     dev_num = target_device_index(next_blkaddr);
> > > +     if (!device_is_aliased(dev_num))
> > > +             return GET_SEGNO(next_blkaddr);
> > > +
> > > +     while (dev_num < c.ndevs && device_is_aliased(dev_num))
> > > +             dev_num++;
> > > +
> > > +     return GET_SEGNO(c.devices[dev_num - 1].end_blkaddr + 1);
> > > +}
> > > +
> > > +static inline uint32_t last_zone(uint32_t total_zone)
> > > +{
> > > +     uint32_t last_seg = (total_zone - 1) * c.segs_per_zone;
> > > +     uint64_t last_blkaddr = START_BLOCK(last_seg);
> > > +     int dev_num;
> > > +
> > > +     dev_num = target_device_index(last_blkaddr);
> > > +     if (!device_is_aliased(dev_num))
> > > +             return GET_SEGNO(last_blkaddr);
> > > +
> > > +     while (dev_num > 0 && device_is_aliased(dev_num))
> > > +             dev_num--;
> > > +
> > > +     return GET_SEGNO(c.devices[dev_num + 1].start_blkaddr) -
> > > +             c.segs_per_zone;
> > > +}
> > > +
> > >  #define last_section(cur)    (cur + (c.secs_per_zone - 1) * c.segs_per_sec)
> > >
> > >  /* Return time fixed by the user or current time by default */
> > > @@ -220,7 +273,7 @@ static int f2fs_prepare_super_block(void)
> > >       uint64_t total_meta_zones, total_meta_segments;
> > >       uint32_t sit_bitmap_size, max_sit_bitmap_size;
> > >       uint32_t max_nat_bitmap_size, max_nat_segments;
> > > -     uint32_t total_zones, avail_zones;
> > > +     uint32_t total_zones, avail_zones = 0;
> > >       enum quota_type qtype;
> > >       int i;
> > >
> > > @@ -314,6 +367,16 @@ static int f2fs_prepare_super_block(void)
> > >                       c.devices[i].end_blkaddr = c.devices[i].start_blkaddr +
> > >                                       c.devices[i].total_segments *
> > >                                       c.blks_per_seg - 1;
> > > +                     if (device_is_aliased(i)) {
> > > +                             if (c.devices[i].zoned_model ==
> > > +                                             F2FS_ZONED_HM) {
> > > +                                     MSG(1, "\tError: do not support "
> > > +                                     "device aliasing for device[%d]\n", i);
> > > +                                     return -1;
> > > +                             }
> > > +                             c.aliased_segments +=
> > > +                                     c.devices[i].total_segments;
> > > +                     }
> > >               }
> > >               if (c.ndevs > 1) {
> > >                       memcpy(sb->devs[i].path, c.devices[i].path, MAX_PATH_LEN);
> > > @@ -531,10 +594,16 @@ static int f2fs_prepare_super_block(void)
> > >       if (c.feature & F2FS_FEATURE_LOST_FOUND)
> > >               c.lpf_ino = c.next_free_nid++;
> > >
> > > +     if (c.aliased_devices) {
> > > +             c.first_alias_ino = c.next_free_nid;
> > > +             c.next_free_nid += c.aliased_devices;
> > > +             avail_zones += c.aliased_segments / c.segs_per_zone;
> > > +     }
> > > +
> > >       if (c.feature & F2FS_FEATURE_RO)
> > > -             avail_zones = 2;
> > > +             avail_zones += 2;
> > >       else
> > > -             avail_zones = 6;
> > > +             avail_zones += 6;
> > >
> > >       if (total_zones <= avail_zones) {
> > >               MSG(1, "\tError: %d zones: Need more zones "
> > > @@ -701,6 +770,7 @@ static int f2fs_write_check_point_pack(void)
> > >       char *sum_compact, *sum_compact_p;
> > >       struct f2fs_summary *sum_entry;
> > >       unsigned short vblocks;
> > > +     uint32_t used_segments = c.aliased_segments;
> > >       int ret = -1;
> > >
> > >       cp = calloc(F2FS_BLKSIZE, 1);
> > > @@ -752,9 +822,14 @@ static int f2fs_write_check_point_pack(void)
> > >       }
> > >
> > >       set_cp(cur_node_blkoff[0], c.curseg_offset[CURSEG_HOT_NODE]);
> > > +     set_cp(cur_node_blkoff[2], c.curseg_offset[CURSEG_COLD_NODE]);
> > >       set_cp(cur_data_blkoff[0], c.curseg_offset[CURSEG_HOT_DATA]);
> > > +     set_cp(cur_data_blkoff[2], c.curseg_offset[CURSEG_COLD_DATA]);
> > >       set_cp(valid_block_count, c.curseg_offset[CURSEG_HOT_NODE] +
> > > -                                     c.curseg_offset[CURSEG_HOT_DATA]);
> > > +                     c.curseg_offset[CURSEG_HOT_DATA] +
> > > +                     c.curseg_offset[CURSEG_COLD_NODE] +
> > > +                     c.curseg_offset[CURSEG_COLD_DATA] +
> > > +                     c.aliased_segments * c.blks_per_seg);
> > >       set_cp(rsvd_segment_count, c.reserved_segments);
> > >
> > >       /*
> > > @@ -802,15 +877,16 @@ static int f2fs_write_check_point_pack(void)
> > >                                       c.reserved_segments);
> > >
> > >       /* main segments - reserved segments - (node + data segments) */
> > > -     if (c.feature & F2FS_FEATURE_RO) {
> > > -             set_cp(free_segment_count, f2fs_get_usable_segments(sb) - 2);
> > > -             set_cp(user_block_count, ((get_cp(free_segment_count) + 2 -
> > > -                     get_cp(overprov_segment_count)) * c.blks_per_seg));
> > > -     } else {
> > > -             set_cp(free_segment_count, f2fs_get_usable_segments(sb) - 6);
> > > -             set_cp(user_block_count, ((get_cp(free_segment_count) + 6 -
> > > -                     get_cp(overprov_segment_count)) * c.blks_per_seg));
> > > -     }
> > > +     if (c.feature & F2FS_FEATURE_RO)
> > > +             used_segments += 2;
> > > +     else
> > > +             used_segments += 6;
> > > +
> > > +     set_cp(user_block_count, (f2fs_get_usable_segments(sb) -
> > > +                     get_cp(overprov_segment_count)) * c.blks_per_seg);
> > > +     set_cp(free_segment_count, f2fs_get_usable_segments(sb) -
> > > +                     used_segments);
> > > +
> > >       /* cp page (2), data summaries (1), node summaries (3) */
> > >       set_cp(cp_pack_total_block_count, 6 + get_sb(cp_payload));
> > >       flags = CP_UMOUNT_FLAG | CP_COMPACT_SUM_FLAG;
> > > @@ -826,8 +902,10 @@ static int f2fs_write_check_point_pack(void)
> > >
> > >       set_cp(ckpt_flags, flags);
> > >       set_cp(cp_pack_start_sum, 1 + get_sb(cp_payload));
> > > -     set_cp(valid_node_count, c.curseg_offset[CURSEG_HOT_NODE]);
> > > -     set_cp(valid_inode_count, c.curseg_offset[CURSEG_HOT_NODE]);
> > > +     set_cp(valid_node_count, c.curseg_offset[CURSEG_HOT_NODE] +
> > > +                     c.curseg_offset[CURSEG_COLD_NODE]);
> > > +     set_cp(valid_inode_count, c.curseg_offset[CURSEG_HOT_NODE] +
> > > +                     c.curseg_offset[CURSEG_COLD_NODE]);
> > >       set_cp(next_free_nid, c.next_free_nid);
> > >       set_cp(sit_ver_bitmap_bytesize, ((get_sb(segment_count_sit) / 2) <<
> > >                       get_sb(log_blocks_per_seg)) / 8);
> > > @@ -975,9 +1053,12 @@ static int f2fs_write_check_point_pack(void)
> > >               goto free_cp_payload;
> > >       }
> > >
> > > -     /* Fill segment summary for COLD_NODE to zero. */
> > > +     /* Prepare and write Segment summary for COLD_NODE */
> > >       memset(sum, 0, F2FS_BLKSIZE);
> > >       SET_SUM_TYPE(sum, SUM_TYPE_NODE);
> > > +     memcpy(sum->entries, c.sum[CURSEG_COLD_NODE],
> > > +                     sizeof(struct f2fs_summary) * MAX_CACHE_SUMS);
> > > +
> > >       cp_seg_blk++;
> > >       DBG(1, "\tWriting Segment summary for COLD_NODE, at offset 0x%08"PRIx64"\n",
> > >                       cp_seg_blk);
> > > @@ -1210,10 +1291,40 @@ void update_summary_entry(int curseg_type, nid_t nid,
> > >       sum->ofs_in_node = cpu_to_le16(ofs_in_node);
> > >  }
> > >
> > > +static void add_dentry(struct f2fs_dentry_block *dent_blk, unsigned int *didx,
> > > +             const char *name, uint32_t ino, u8 type)
> > > +{
> > > +     int len = strlen(name);
> > > +     f2fs_hash_t hash;
> > > +
> > > +     if (name[0] == '.' && (len == 1 || (len == 2 && name[1] == '.')))
> > > +             hash = 0;
> > > +     else
> > > +             hash = f2fs_dentry_hash(0, 0, (unsigned char *)name, len);
> > > +
> > > +     F2FS_DENTRY_BLOCK_DENTRY(dent_blk, *didx).hash_code = cpu_to_le32(hash);
> > > +     F2FS_DENTRY_BLOCK_DENTRY(dent_blk, *didx).ino = cpu_to_le32(ino);
> > > +     F2FS_DENTRY_BLOCK_DENTRY(dent_blk, *didx).name_len = cpu_to_le16(len);
> > > +     F2FS_DENTRY_BLOCK_DENTRY(dent_blk, *didx).file_type = type;
> > > +
> > > +     while (len > F2FS_SLOT_LEN) {
> > > +             memcpy(F2FS_DENTRY_BLOCK_FILENAME(dent_blk, *didx), name,
> > > +                             F2FS_SLOT_LEN);
> > > +             test_and_set_bit_le(*didx, dent_blk->dentry_bitmap);
> > > +             len -= (int)F2FS_SLOT_LEN;
> > > +             name += F2FS_SLOT_LEN;
> > > +             (*didx)++;
> > > +     }
> > > +     memcpy(F2FS_DENTRY_BLOCK_FILENAME(dent_blk, *didx), name, len);
> > > +     test_and_set_bit_le(*didx, dent_blk->dentry_bitmap);
> > > +     (*didx)++;
> > > +}
> > > +
> > >  static block_t f2fs_add_default_dentry_root(void)
> > >  {
> > >       struct f2fs_dentry_block *dent_blk = NULL;
> > >       block_t data_blkaddr;
> > > +     unsigned int didx = 0;
> > >
> > >       dent_blk = calloc(F2FS_BLKSIZE, 1);
> > >       if(dent_blk == NULL) {
> > > @@ -1221,37 +1332,26 @@ static block_t f2fs_add_default_dentry_root(void)
> > >               return 0;
> > >       }
> > >
> > > -     F2FS_DENTRY_BLOCK_DENTRY(dent_blk, 0).hash_code = 0;
> > > -     F2FS_DENTRY_BLOCK_DENTRY(dent_blk, 0).ino = sb->root_ino;
> > > -     F2FS_DENTRY_BLOCK_DENTRY(dent_blk, 0).name_len = cpu_to_le16(1);
> > > -     F2FS_DENTRY_BLOCK_DENTRY(dent_blk, 0).file_type = F2FS_FT_DIR;
> > > -     memcpy(F2FS_DENTRY_BLOCK_FILENAME(dent_blk, 0), ".", 1);
> > > +     add_dentry(dent_blk, &didx, ".",
> > > +                     le32_to_cpu(sb->root_ino), F2FS_FT_DIR);
> > > +     add_dentry(dent_blk, &didx, "..",
> > > +                     le32_to_cpu(sb->root_ino), F2FS_FT_DIR);
> > >
> > > -     F2FS_DENTRY_BLOCK_DENTRY(dent_blk, 1).hash_code = 0;
> > > -     F2FS_DENTRY_BLOCK_DENTRY(dent_blk, 1).ino = sb->root_ino;
> > > -     F2FS_DENTRY_BLOCK_DENTRY(dent_blk, 1).name_len = cpu_to_le16(2);
> > > -     F2FS_DENTRY_BLOCK_DENTRY(dent_blk, 1).file_type = F2FS_FT_DIR;
> > > -     memcpy(F2FS_DENTRY_BLOCK_FILENAME(dent_blk, 1), "..", 2);
> > > -
> > > -     /* bitmap for . and .. */
> > > -     test_and_set_bit_le(0, dent_blk->dentry_bitmap);
> > > -     test_and_set_bit_le(1, dent_blk->dentry_bitmap);
> > > -
> > > -     if (c.lpf_ino) {
> > > -             int len = strlen(LPF);
> > > -             f2fs_hash_t hash = f2fs_dentry_hash(0, 0, (unsigned char *)LPF, len);
> > > +     if (c.lpf_ino)
> > > +             add_dentry(dent_blk, &didx, LPF, c.lpf_ino, F2FS_FT_DIR);
> > >
> > > -             F2FS_DENTRY_BLOCK_DENTRY(dent_blk, 2).hash_code = cpu_to_le32(hash);
> > > -             F2FS_DENTRY_BLOCK_DENTRY(dent_blk, 2).ino = cpu_to_le32(c.lpf_ino);
> > > -             F2FS_DENTRY_BLOCK_DENTRY(dent_blk, 2).name_len = cpu_to_le16(len);
> > > -             F2FS_DENTRY_BLOCK_DENTRY(dent_blk, 2).file_type = F2FS_FT_DIR;
> > > -             memcpy(F2FS_DENTRY_BLOCK_FILENAME(dent_blk, 2), LPF, F2FS_SLOT_LEN);
> > > +     if (c.aliased_devices) {
> > > +             int i, dev_off = 0;
> > >
> > > -             memcpy(F2FS_DENTRY_BLOCK_FILENAME(dent_blk, 3), &LPF[F2FS_SLOT_LEN],
> > > -                             len - F2FS_SLOT_LEN);
> > > +             for (i = 1; i < c.ndevs; i++) {
> > > +                     if (!device_is_aliased(i))
> > > +                             continue;
> > >
> > > -             test_and_set_bit_le(2, dent_blk->dentry_bitmap);
> > > -             test_and_set_bit_le(3, dent_blk->dentry_bitmap);
> > > +                     add_dentry(dent_blk, &didx, c.devices[i].alias_filename,
> > > +                                     c.first_alias_ino + dev_off,
> > > +                                     F2FS_FT_REG_FILE);
> > > +                     dev_off++;
> > > +             }
> > >       }
> > >
> > >       data_blkaddr = alloc_next_free_block(CURSEG_HOT_DATA);
> > > @@ -1324,6 +1424,7 @@ static int f2fs_write_default_quota(int qtype, __le32 raw_id)
> > >       struct v2_disk_dqinfo ddqinfo;
> > >       struct v2r1_disk_dqblk dqblk;
> > >       block_t blkaddr;
> > > +     uint64_t icnt = 1, bcnt = 1;
> > >       int i;
> > >
> > >       if (filebuf == NULL) {
> > > @@ -1359,16 +1460,18 @@ static int f2fs_write_default_quota(int qtype, __le32 raw_id)
> > >       dqblk.dqb_pad = cpu_to_le32(0);
> > >       dqblk.dqb_ihardlimit = cpu_to_le64(0);
> > >       dqblk.dqb_isoftlimit = cpu_to_le64(0);
> > > -     if (c.lpf_ino)
> > > -             dqblk.dqb_curinodes = cpu_to_le64(2);
> > > -     else
> > > -             dqblk.dqb_curinodes = cpu_to_le64(1);
> > > +     if (c.lpf_ino) {
> > > +             icnt++;
> > > +             bcnt++;
> > > +     }
> > > +     if (c.aliased_devices) {
> > > +             icnt += c.aliased_devices;
> > > +             bcnt += c.aliased_segments * c.blks_per_seg;
> > > +     }
> > > +     dqblk.dqb_curinodes = cpu_to_le64(icnt);
> > >       dqblk.dqb_bhardlimit = cpu_to_le64(0);
> > >       dqblk.dqb_bsoftlimit = cpu_to_le64(0);
> > > -     if (c.lpf_ino)
> > > -             dqblk.dqb_curspace = cpu_to_le64(F2FS_BLKSIZE * 2);
> > > -     else
> > > -             dqblk.dqb_curspace = cpu_to_le64(F2FS_BLKSIZE);
> > > +     dqblk.dqb_curspace = cpu_to_le64(F2FS_BLKSIZE * bcnt);
> > >       dqblk.dqb_btime = cpu_to_le64(0);
> > >       dqblk.dqb_itime = cpu_to_le64(0);
> > >
> > > @@ -1491,6 +1594,7 @@ static block_t f2fs_add_default_dentry_lpf(void)
> > >  {
> > >       struct f2fs_dentry_block *dent_blk;
> > >       block_t data_blkaddr;
> > > +     unsigned int didx = 0;
> > >
> > >       dent_blk = calloc(F2FS_BLKSIZE, 1);
> > >       if (dent_blk == NULL) {
> > > @@ -1498,20 +1602,8 @@ static block_t f2fs_add_default_dentry_lpf(void)
> > >               return 0;
> > >       }
> > >
> > > -     F2FS_DENTRY_BLOCK_DENTRY(dent_blk, 0).hash_code = 0;
> > > -     F2FS_DENTRY_BLOCK_DENTRY(dent_blk, 0).ino = cpu_to_le32(c.lpf_ino);
> > > -     F2FS_DENTRY_BLOCK_DENTRY(dent_blk, 0).name_len = cpu_to_le16(1);
> > > -     F2FS_DENTRY_BLOCK_DENTRY(dent_blk, 0).file_type = F2FS_FT_DIR;
> > > -     memcpy(F2FS_DENTRY_BLOCK_FILENAME(dent_blk, 0), ".", 1);
> > > -
> > > -     F2FS_DENTRY_BLOCK_DENTRY(dent_blk, 1).hash_code = 0;
> > > -     F2FS_DENTRY_BLOCK_DENTRY(dent_blk, 1).ino = sb->root_ino;
> > > -     F2FS_DENTRY_BLOCK_DENTRY(dent_blk, 1).name_len = cpu_to_le16(2);
> > > -     F2FS_DENTRY_BLOCK_DENTRY(dent_blk, 1).file_type = F2FS_FT_DIR;
> > > -     memcpy(F2FS_DENTRY_BLOCK_FILENAME(dent_blk, 1), "..", 2);
> > > -
> > > -     test_and_set_bit_le(0, dent_blk->dentry_bitmap);
> > > -     test_and_set_bit_le(1, dent_blk->dentry_bitmap);
> > > +     add_dentry(dent_blk, &didx, ".", c.lpf_ino, F2FS_FT_DIR);
> > > +     add_dentry(dent_blk, &didx, "..", c.lpf_ino, F2FS_FT_DIR);
> > >
> > >       data_blkaddr = alloc_next_free_block(CURSEG_HOT_DATA);
> > >
> > > @@ -1579,6 +1671,104 @@ exit:
> > >       return err;
> > >  }
> > >
> > > +static void allocate_blocks_for_aliased_device(struct f2fs_node *raw_node,
> > > +             unsigned int dev_num)
> > > +{
> > > +     uint32_t start_segno = (c.devices[dev_num].start_blkaddr -
> > > +                     get_sb(main_blkaddr)) / c.blks_per_seg;
> > > +     uint32_t end_segno = (c.devices[dev_num].end_blkaddr -
> > > +                     get_sb(main_blkaddr) + 1) / c.blks_per_seg;
> > > +     uint32_t segno;
> > > +     uint64_t blkcnt;
> > > +     struct f2fs_sit_block *sit_blk = calloc(F2FS_BLKSIZE, 1);
> > > +
> > > +     ASSERT(sit_blk);
> > > +
> > > +     for (segno = start_segno; segno < end_segno; segno++) {
> > > +             struct f2fs_sit_entry *sit;
> > > +             uint64_t sit_blk_addr = get_sb(sit_blkaddr) +
> > > +                     (segno / SIT_ENTRY_PER_BLOCK);
> > > +
> > > +             ASSERT(dev_read_block(sit_blk, sit_blk_addr) >= 0);
> > > +             sit = &sit_blk->entries[segno % SIT_ENTRY_PER_BLOCK];
> > > +             memset(&sit->valid_map, 0xFF, SIT_VBLOCK_MAP_SIZE);
> > > +             sit->vblocks = cpu_to_le16((CURSEG_COLD_DATA <<
> > > +                                     SIT_VBLOCKS_SHIFT) | c.blks_per_seg);
> > > +             sit->mtime = cpu_to_le64(mkfs_time);
> > > +             ASSERT(dev_write_block(sit_blk, sit_blk_addr) >= 0);
> > > +     }
> > > +
> > > +     blkcnt = (end_segno - start_segno) * c.blks_per_seg;
> > > +     raw_node->i.i_size = cpu_to_le64(blkcnt << get_sb(log_blocksize));
> > > +     raw_node->i.i_blocks = cpu_to_le64(blkcnt + 1);
> > > +
> > > +     raw_node->i.i_ext.fofs = cpu_to_le32(0);
> > > +     raw_node->i.i_ext.blk_addr =
> > > +             cpu_to_le32(c.devices[dev_num].start_blkaddr);
> > > +     raw_node->i.i_ext.len = cpu_to_le32(blkcnt);
> > > +
> > > +     free(sit_blk);
> > > +}
> > > +
> > > +static int f2fs_write_alias_inodes(void)
> > > +{
> > > +     struct f2fs_node *raw_node;
> > > +     block_t node_blkaddr;
> > > +     int err = 0;
> > > +     unsigned int i, dev_off = 0;
> > > +
> > > +     ASSERT(c.aliased_devices);
> > > +
> > > +     raw_node = calloc(F2FS_BLKSIZE, 1);
> > > +     if (raw_node == NULL) {
> > > +             MSG(1, "\tError: Calloc Failed for raw_node!!!\n");
> > > +             return -1;
> > > +     }
> > > +
> > > +     for (i = 1; i < c.ndevs; i++) {
> > > +             const char *filename;
> > > +             nid_t ino;
> > > +
> > > +             if (!device_is_aliased(i))
> > > +                     continue;
> > > +
> > > +             ino = c.first_alias_ino + dev_off;
> > > +             dev_off++;
> > > +             f2fs_init_inode(sb, raw_node, ino, mkfs_time, 0x81c0);
> > > +
> > > +             raw_node->i.i_flags = cpu_to_le32(F2FS_IMMUTABLE_FL |
> > > +                             F2FS_DEVICE_ALIAS_FL);
> > > +             raw_node->i.i_inline = F2FS_PIN_FILE;
> > > +             raw_node->i.i_pino = sb->root_ino;
> > > +             filename = c.devices[i].alias_filename;
> > > +             raw_node->i.i_namelen = cpu_to_le32(strlen(filename));
> > > +             memcpy(raw_node->i.i_name, filename, strlen(filename));
> > > +
> > > +             node_blkaddr = alloc_next_free_block(CURSEG_COLD_NODE);
> > > +             F2FS_NODE_FOOTER(raw_node)->next_blkaddr =
> > > +                     cpu_to_le32(node_blkaddr + 1);
> > > +
> > > +             allocate_blocks_for_aliased_device(raw_node, i);
> > > +
> > > +             DBG(1, "\tWriting aliased device inode (cold node), "
> > > +                             "offset 0x%x\n", node_blkaddr);
> > > +             if (write_inode(raw_node, node_blkaddr) < 0) {
> > > +                     MSG(1, "\tError: While writing the raw_node to "
> > > +                                     "disk!!!\n");
> > > +                     err = -1;
> > > +                     goto exit;
> > > +             }
> > > +
> > > +             update_nat_journal(ino, node_blkaddr);
> > > +             update_sit_journal(CURSEG_COLD_NODE);
> > > +             update_summary_entry(CURSEG_COLD_NODE, ino, 0);
> > > +     }
> > > +
> > > +exit:
> > > +     free(raw_node);
> > > +     return err;
> > > +}
> > > +
> > >  static int f2fs_create_root_dir(void)
> > >  {
> > >       enum quota_type qtype;
> > > @@ -1608,6 +1798,15 @@ static int f2fs_create_root_dir(void)
> > >               }
> > >       }
> > >
> > > +     if (c.aliased_devices) {
> > > +             err = f2fs_write_alias_inodes();
> > > +             if (err < 0) {
> > > +                     MSG(1, "\tError: Failed to write aliased device "
> > > +                             "inodes!!!\n");
> > > +                     goto exit;
> > > +             }
> > > +     }
> > > +
> > >  #ifndef WITH_ANDROID
> > >       err = f2fs_discard_obsolete_dnode();
> > >       if (err < 0) {
> > > diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
> > > index 2ba1c21..b113bbc 100644
> > > --- a/mkfs/f2fs_format_main.c
> > > +++ b/mkfs/f2fs_format_main.c
> > > @@ -50,7 +50,7 @@ static void mkfs_usage()
> > >       MSG(0, "\nUsage: mkfs.f2fs [options] device [sectors]\n");
> > >       MSG(0, "[options]:\n");
> > >       MSG(0, "  -b filesystem block size [default:4096]\n");
> > > -     MSG(0, "  -c [device_name] up to 7 additional devices, except meta device\n");
> > > +     MSG(0, "  -c [device_name[@alias_filename]] up to 7 additional devices, except meta device\n");
> > >       MSG(0, "  -d debug level [default:0]\n");
> > >       MSG(0, "  -e [cold file ext list] e.g. \"mp3,gif,mov\"\n");
> > >       MSG(0, "  -E [hot file ext list] e.g. \"db\"\n");
> > > @@ -105,6 +105,9 @@ static void f2fs_show_info()
> > >
> > >       if (c.feature & F2FS_FEATURE_COMPRESSION)
> > >               MSG(0, "Info: Enable Compression\n");
> > > +
> > > +     if (c.feature & F2FS_FEATURE_DEVICE_ALIAS)
> > > +             MSG(0, "Info: Enable device aliasing\n");
> > >  }
> > >
> > >  #if defined(ANDROID_TARGET) && defined(HAVE_SYS_UTSNAME_H)
> > > @@ -181,6 +184,7 @@ static void f2fs_parse_options(int argc, char *argv[])
> > >       int32_t option=0;
> > >       int val;
> > >       char *token;
> > > +     int dev_num;
> > >
> > >       while ((option = getopt_long(argc,argv,option_string,long_opts,NULL)) != EOF) {
> > >               switch (option) {
> > > @@ -200,17 +204,35 @@ static void f2fs_parse_options(int argc, char *argv[])
> > >                       }
> > >                       break;
> > >               case 'c':
> > > -                     if (c.ndevs >= MAX_DEVICES) {
> > > +                     dev_num = c.ndevs;
> > > +
> > > +                     if (dev_num >= MAX_DEVICES) {
> > >                               MSG(0, "Error: Too many devices\n");
> > >                               mkfs_usage();
> > >                       }
> > >
> > > -                     if (strlen(optarg) > MAX_PATH_LEN) {
> > > +                     token = strtok(optarg, "@");
> > > +                     if (strlen(token) > MAX_PATH_LEN) {
> > >                               MSG(0, "Error: device path should be less than "
> > >                                       "%d characters\n", MAX_PATH_LEN);
> > >                               mkfs_usage();
> > >                       }
> > > -                     c.devices[c.ndevs++].path = strdup(optarg);
> > > +                     c.devices[dev_num].path = strdup(token);
> > > +                     token = strtok(NULL, "");
> > > +                     if (token) {
> > > +                             if (strlen(token) > MAX_PATH_LEN) {
> > > +                                     MSG(0, "Error: alias_filename should "
> > > +                                             "be less than %d characters\n",
> > > +                                             MAX_PATH_LEN);
> > > +                                     mkfs_usage();
> > > +                             }
> > > +                             c.devices[dev_num].alias_filename =
> > > +                                     strdup(token);
> > > +                             if (!c.aliased_devices)
> > > +                                     c.feature |= F2FS_FEATURE_DEVICE_ALIAS;
> > > +                             c.aliased_devices++;
> > > +                     }
> > > +                     c.ndevs++;
> > >                       break;
> > >               case 'd':
> > >                       c.dbg_lv = atoi(optarg);
> > > --
> > > 2.46.0.662.g92d0881bb0-goog
> > >

