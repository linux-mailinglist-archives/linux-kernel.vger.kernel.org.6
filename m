Return-Path: <linux-kernel+bounces-220856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB52B90E83A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754C5285FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2419182C60;
	Wed, 19 Jun 2024 10:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4l+f3Og"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55440879;
	Wed, 19 Jun 2024 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718792484; cv=none; b=jamvrjnwtes8/3rHEDobXdDQH7dfPvxw+ajjKaCPTF/hT+BP1+tZUuOWfRRbe4wkgCyJ3T8USPTTgyxREMofyFZ/e9slLTt9GQPRIlOLNZPHcBxW6gk7A9xaJTsPNPQ1vGZfBdKoy9joYFY6rmVTlOPhDGJ0PiFXknYMK4OAYbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718792484; c=relaxed/simple;
	bh=P7BVwrlPu5JLfPjoFAsx3EZJBuN98wCr8B57Z2OIK8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u5GtNwGvawIaexZIbz0QKYp3nJQkb73TTQyD5NmdUa2B9moNv/DtL/lIJie1h3nrx9ExJrP9WmnOCVaZwuQN3JCJv3wjwiNiUEPAiE+mA2GvelNCa6Fy1K4A4JTKYrELSstE00VGvEwKzctccLhyur1BKl96fMIpz3b/x4usmck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4l+f3Og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FE7C32786;
	Wed, 19 Jun 2024 10:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718792483;
	bh=P7BVwrlPu5JLfPjoFAsx3EZJBuN98wCr8B57Z2OIK8w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u4l+f3OgZGiRgcrI9V1lttiQ8oOOKmdVmGbM5rAXXz5SlJ182Tsbt/AalMKT0gGCP
	 t9N2p6DfZntt3f3WYM5QDpnvKW9F5ZRcyc3qfQrbAhLQFBTZImsu7F+7QzqpLSlKWN
	 MHOHSGwPml1OMmgnMDSAGeDbC3AQIwvu0RY/vC9wPPeHJGvkXpOwIzv2wDTUotdrvJ
	 vm2+QWd+WvrUugXpTmtbnSIbfkeeKZiKDAghT87udxpfy9smNitz1J+jwvRkFmkEPl
	 qS7KGazXyFalD2PsGOg1+xVn2X2gL58hSU3rSB/6+nIDpUbjg6DWin7gIPJfcL0AMS
	 x7l8vhsvcArag==
Message-ID: <a4ae575c-9eee-47fe-b49d-c71737022d24@kernel.org>
Date: Wed, 19 Jun 2024 18:21:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] f2fs: add support single node mode
To: daejun7.park@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Seokhwan Kim <sukka.kim@samsung.com>,
 Dongjin Kim <dongjin_.kim@samsung.com>,
 Yonggil Song <yonggil.song@samsung.com>,
 Jaeyoon Choi <j_yoon.choi@samsung.com>, Nayeon Kim
 <nayeoni.kim@samsung.com>, Siwoo Jung <siu.jung@samsung.com>
References: <CGME20240617045134epcms2p3f2f82336438f636b3f1ad58fd0c1cd29@epcms2p3>
 <20240617045134epcms2p3f2f82336438f636b3f1ad58fd0c1cd29@epcms2p3>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240617045134epcms2p3f2f82336438f636b3f1ad58fd0c1cd29@epcms2p3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/17 12:51, Daejun Park wrote:
> The amount of node writes is small compared to the amount of user data
> writes in most workloads. Therefore, even if there is enough free space
> in the node section, it cannot be used by another type because the type
> for its section is fixed. When using zoned storage, the free space in
> node section issue can be a problem due to the large section.
> 
> This patch can avoid the problem by using a single node section without
> considering the hotness of the node section. For particularly high file
> system usage, two sections can be used as free sections, which makes it
> more efficient.
> 
> To use single node section, add the 'single_node_sec' in mount option.
> The single node section mode can be activated when the number of active
> logs is equal to 6.

This patch is out-of-format due to tab is replaced as blanks.

> 
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> ---
>   Documentation/filesystems/f2fs.rst |  2 +
>   fs/f2fs/f2fs.h                     |  3 ++
>   fs/f2fs/recovery.c                 |  3 ++
>   fs/f2fs/segment.c                  | 78 ++++++++++++++++++++++++++++++
>   fs/f2fs/segment.h                  |  2 +
>   fs/f2fs/super.c                    | 12 +++++
>   6 files changed, 100 insertions(+)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 68a0885fb5e6..ba26b2ce4fa4 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -134,6 +134,8 @@ noacl                        Disable POSIX Access Control List. Note: acl is enabled
>   active_logs=%u          Support configuring the number of active logs. In the
>                           current design, f2fs supports only 2, 4, and 6 logs.
>                           Default number is 6.
> +single_node_sec         Support single node section mode, it enables single active
> +                        log for hot/warm/cold nodes. This is disabled by default.

Do we allow changing this config during remount?

>   disable_ext_identify    Disable the extension list configured by mkfs, so f2fs
>                           is not aware of cold files such as media files.
>   inline_xattr            Enable the inline xattrs feature.
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 1974b6aff397..90f13a6b64ce 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -116,6 +116,7 @@ extern const char *f2fs_fault_name[FAULT_MAX];
>   #define        F2FS_MOUNT_GC_MERGE             0x02000000
>   #define F2FS_MOUNT_COMPRESS_CACHE      0x04000000
>   #define F2FS_MOUNT_AGE_EXTENT_CACHE    0x08000000
> +#define F2FS_MOUNT_SINGLE_NODE_SEC     0x10000000
> 
>   #define F2FS_OPTION(sbi)       ((sbi)->mount_opt)
>   #define clear_opt(sbi, option) (F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
> @@ -1655,6 +1656,8 @@ struct f2fs_sb_info {
> 
>          struct f2fs_mount_info mount_opt;       /* mount options */
> 
> +       bool single_node_sec;                   /* single node section */

Better to move it into struct f2fs_mount_info?

> +
>          /* for cleaning operations */
>          struct f2fs_rwsem gc_lock;              /*
>                                                   * semaphore for GC, avoid
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index 496aee53c38a..b5cdb0845ac7 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -414,6 +414,9 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
> 
>          /* get node pages in the current segment */
>          curseg = CURSEG_I(sbi, CURSEG_WARM_NODE);
> +       /* check hot node if single node section mode is enabled */
> +       if (sbi->single_node_sec && curseg->segno == NULL_SEGNO)
> +               curseg = CURSEG_I(sbi, CURSEG_HOT_NODE);

If we turn off single_node_sec mode, fsynced data may be lost since warm node
chain is empty?

>          blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
>          blkaddr_fast = blkaddr;
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index a0ce3d080f80..81b4d52b25c0 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -394,6 +394,9 @@ int f2fs_commit_atomic_write(struct inode *inode)
>          return err;
>   }
> 
> +static int new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec);
> +static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno);
> +
>   /*
>    * This function balances dirty node and dentry pages.
>    * In addition, it controls garbage collection.
> @@ -420,6 +423,59 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
>          if (has_enough_free_secs(sbi, 0, 0))
>                  return;
> 
> +       if (test_opt(sbi, SINGLE_NODE_SEC) && !sbi->single_node_sec &&
> +           F2FS_OPTION(sbi).active_logs == 6) {
> +               int type, segno, left_blocks = 0;
> +
> +               for (type = CURSEG_HOT_NODE; type <= CURSEG_COLD_NODE; type++) {
> +                       segno = CURSEG_I(sbi, type)->segno;
> +                       left_blocks += CAP_BLKS_PER_SEC(sbi) -
> +                                       get_ckpt_valid_blocks(sbi, segno, true);
> +               }
> +
> +               /* enable single node section mode if we get 2 free sections */
> +               if (left_blocks < CAP_BLKS_PER_SEC(sbi) * 2)
> +                       goto do_gc;
> +
> +               f2fs_down_read(&SM_I(sbi)->curseg_lock);
> +               down_write(&SIT_I(sbi)->sentry_lock);
> +
> +               /* it can be enabled by others */
> +               if (sbi->single_node_sec)
> +                       goto unlock;
> +
> +               /* leave current zone by allocating new section */
> +               for (type = CURSEG_WARM_NODE; type <= CURSEG_COLD_NODE; type++) {
> +                       struct curseg_info *curseg = CURSEG_I(sbi, type);
> +
> +                       mutex_lock(&curseg->curseg_mutex);
> +                       segno = curseg->segno;
> +                       if (new_curseg(sbi, type, true)) {

It looks dangerous to allocate new section here for the case there
is heavy fragment and no available user space, because free section
may be exhausted during latter FGGC.

> +                               mutex_unlock(&curseg->curseg_mutex);
> +                               goto unlock;
> +                       }
> +                       locate_dirty_segment(sbi, segno);
> +                       mutex_unlock(&curseg->curseg_mutex);
> +               }
> +
> +               /* clear warm node, cold node information */
> +               for (type = CURSEG_WARM_NODE; type <= CURSEG_COLD_NODE; type++) {
> +                       struct curseg_info *curseg = CURSEG_I(sbi, type);
> +
> +                       mutex_lock(&curseg->curseg_mutex);
> +                       segno = curseg->segno;
> +                       curseg->segno = NULL_SEGNO;
> +                       curseg->inited = false;
> +                       __set_test_and_free(sbi, segno, false);
> +                       mutex_unlock(&curseg->curseg_mutex);
> +               }
> +               f2fs_notice(sbi, "single node section mode enabled");
> +               sbi->single_node_sec = true;

It looks complicated to enable single_node_sec mode dynamically, what do
you think of making this as a feature which can only be eanbled by mkfs?

Thanks,

> +unlock:
> +               up_write(&SIT_I(sbi)->sentry_lock);
> +               f2fs_up_read(&SM_I(sbi)->curseg_lock);
> +       }
> +do_gc:
>          if (test_opt(sbi, GC_MERGE) && sbi->gc_thread &&
>                                  sbi->gc_thread->f2fs_gc_task) {
>                  DEFINE_WAIT(wait);
> @@ -3502,6 +3558,9 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>                  return f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
>                                                  inode->i_write_hint);
>          } else {
> +               if (fio->sbi->single_node_sec)
> +                       return CURSEG_HOT_NODE;
> +
>                  if (IS_DNODE(fio->page))
>                          return is_cold_node(fio->page) ? CURSEG_WARM_NODE :
>                                                  CURSEG_HOT_NODE;
> @@ -4116,6 +4175,15 @@ static int read_normal_summaries(struct f2fs_sb_info *sbi, int type)
>                                                          CURSEG_HOT_NODE]);
>                  blk_off = le16_to_cpu(ckpt->cur_node_blkoff[type -
>                                                          CURSEG_HOT_NODE]);
> +               if (segno == NULL_SEGNO && type != CURSEG_HOT_NODE) {
> +                       if (!test_opt(sbi, SINGLE_NODE_SEC)) {
> +                               f2fs_err(sbi, "single_node_sec option required");
> +                               return -EFAULT;
> +                       }
> +                       sbi->single_node_sec = true;
> +                       return 0;
> +               }
> +
>                  if (__exist_node_summaries(sbi))
>                          blk_addr = sum_blk_addr(sbi, NR_CURSEG_NODE_TYPE,
>                                                          type - CURSEG_HOT_NODE);
> @@ -4884,6 +4952,8 @@ static void init_free_segmap(struct f2fs_sb_info *sbi)
>                  struct curseg_info *curseg_t = CURSEG_I(sbi, type);
> 
>                  __set_test_and_inuse(sbi, curseg_t->segno);
> +               if (sbi->single_node_sec && type == CURSEG_HOT_NODE)
> +                       break;
>          }
>   }
> 
> @@ -5027,6 +5097,10 @@ static int sanity_check_curseg(struct f2fs_sb_info *sbi)
>                          f2fs_handle_error(sbi, ERROR_INVALID_CURSEG);
>                          return -EFSCORRUPTED;
>                  }
> +
> +               /* in single node section mode, WARM/COLD NODE are invalid */
> +               if (sbi->single_node_sec && i == CURSEG_HOT_NODE)
> +                       break;
>          }
>          return 0;
>   }
> @@ -5153,6 +5227,10 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
>          if (!zbd)
>                  return 0;
> 
> +       /* in single node section mode, WARM/COLD node are not valid */
> +       if (sbi->single_node_sec && type > CURSEG_HOT_NODE)
> +               return 0;
> +
>          /* report zone for the sector the curseg points to */
>          zone_sector = (sector_t)(cs_zone_block - zbd->start_blk)
>                  << log_sectors_per_block;
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index e1c0f418aa11..152a07e61b5f 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -570,6 +570,8 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
>                                  get_ckpt_valid_blocks(sbi, segno, true);
>                  if (node_blocks > left_blocks)
>                          return false;
> +               if (sbi->single_node_sec) /* check only hot node */
> +                       break;
>          }
> 
>          /* check current data section for dentry blocks. */
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 1f1b3647a998..7e1e80fe58dd 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -129,6 +129,7 @@ enum {
>          Opt_acl,
>          Opt_noacl,
>          Opt_active_logs,
> +       Opt_single_node_sec,
>          Opt_disable_ext_identify,
>          Opt_inline_xattr,
>          Opt_noinline_xattr,
> @@ -207,6 +208,7 @@ static match_table_t f2fs_tokens = {
>          {Opt_acl, "acl"},
>          {Opt_noacl, "noacl"},
>          {Opt_active_logs, "active_logs=%u"},
> +       {Opt_single_node_sec, "single_node_sec"},
>          {Opt_disable_ext_identify, "disable_ext_identify"},
>          {Opt_inline_xattr, "inline_xattr"},
>          {Opt_noinline_xattr, "noinline_xattr"},
> @@ -803,6 +805,9 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>                                  return -EINVAL;
>                          F2FS_OPTION(sbi).active_logs = arg;
>                          break;
> +               case Opt_single_node_sec:
> +                       set_opt(sbi, SINGLE_NODE_SEC);
> +                       break;
>                  case Opt_disable_ext_identify:
>                          set_opt(sbi, DISABLE_EXT_IDENTIFY);
>                          break;
> @@ -2039,6 +2044,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>                                          F2FS_OPTION(sbi).s_resuid),
>                                  from_kgid_munged(&init_user_ns,
>                                          F2FS_OPTION(sbi).s_resgid));
> +       if (test_opt(sbi, SINGLE_NODE_SEC))
> +               seq_puts(seq, ",single_node_sec");
>   #ifdef CONFIG_F2FS_FAULT_INJECTION
>          if (test_opt(sbi, FAULT_INJECTION)) {
>                  seq_printf(seq, ",fault_injection=%u",
> @@ -3675,6 +3682,9 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
>          blocks_per_seg = BLKS_PER_SEG(sbi);
> 
>          for (i = 0; i < NR_CURSEG_NODE_TYPE; i++) {
> +               /* bypass single node section mode */
> +               if (le32_to_cpu(ckpt->cur_node_segno[i]) == NULL_SEGNO)
> +                       goto check_data;
>                  if (le32_to_cpu(ckpt->cur_node_segno[i]) >= main_segs ||
>                          le16_to_cpu(ckpt->cur_node_blkoff[i]) >= blocks_per_seg)
>                          return 1;
> @@ -3823,6 +3833,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>          init_f2fs_rwsem(&sbi->io_order_lock);
>          spin_lock_init(&sbi->cp_lock);
> 
> +       sbi->single_node_sec = false;
> +
>          sbi->dirty_device = 0;
>          spin_lock_init(&sbi->dev_lock);
> 
> --
> 2.25.1

