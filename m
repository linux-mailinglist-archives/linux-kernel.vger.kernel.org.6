Return-Path: <linux-kernel+bounces-229911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB1E9175E7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 03:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E031F21CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 01:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDCA12B87;
	Wed, 26 Jun 2024 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkiAFW7r"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABD0171AD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366840; cv=none; b=tpKLe0xoKILPSYEvuTdYw6sJC2ep0jz48JCXJF3te3H31djof751U7F8+2umWjGiv+GA3mRy10CAaa3KxLP3J4rXjAo4ziopbAvr8uwylkAbJrmmOzmCz1ovBpTDZ3fG9cSByi6FEsY7MI5FvO3UEd3KDhjucd/pJAw6T/913bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366840; c=relaxed/simple;
	bh=b6c36eSIIIPzLYmgYP5apoOUUDj6Qep6oar74QIJoqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3w++EAvFFIZl8QUcNkjnc/L7lIRSkJjBK8MmV6/YuuKzlhP67OmQFRkAPIJ1G/o13Ot/7vlL6lhYmPRvAxZa0apnlO6R6D9rlCUso3/L8IpkEHx0J6UJUXdd1cY7oTbU6blE58zJuLKdfOwzvFN+NFmkSbY5vDtd8LxdxxUick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkiAFW7r; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ce6a9fd5cso2707698e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719366836; x=1719971636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt1OSJl92903gzgy+xbO+teewEi8pHwOPc/OOCe+r8U=;
        b=GkiAFW7rGJrPU4WfBvcxOZck5gHFip/xuXbOIhYr4T7356AJy9+etFOiBeEr8cZZj3
         vsTTUfsdbyGJar31XCDlQQCJO0fpx+Xu7Tn+zaJNPVwIF4kacqsEg21RgW0u4vxFmzOf
         AYMq/NtRaA43+M03KHbII05R4eKhadE8QEYLi+4GbaDu7FVoLTbrhzYqWhsX6lldhh7Y
         mbbnUgNO5KxRlBqu/QqmLIR9WA/RsTHD4XvgWINc+4475rY8/XVPQZ7+KDtKorCJ5gfC
         DzLLv6jdhJQe1rDSbRgcS47/+4KzlFiIJh6nR+ITrxbcUsEoXs39I1hgetOf9NbxYvJx
         KOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719366836; x=1719971636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yt1OSJl92903gzgy+xbO+teewEi8pHwOPc/OOCe+r8U=;
        b=VAw+MPfp6sbRw+GcC2ENL+IG8+7YeJmt4M13rF6GNL2UWr590a361GGPJol+L9TKTP
         OVSccp7r1wIJShYyhi657khyjvsbKYnuRJKB3HqOtiZyLZPEXyR//RA7W85fF48UtXya
         6Aluw9c71VbOkD0Ihq5vQW9HpKHA2Ao9pdLGn0I7ekiEw3lxkyLlcdXEgrqkFxGIbO6g
         Je/qPp4pXZ64df+oFmj47avUjhEIGh2ioELOWBmjj3hEfisGdtlR9K5hH2Ni9X9I67TV
         NhpqHQlTYni2NrgvXmoDoEmQWfu7/kTIEIinIJqvhkRxgQY7Tg5p+mpscMobHW54oTXP
         rlbA==
X-Forwarded-Encrypted: i=1; AJvYcCWO6WrCqEeo9nHG1LP1IKU0TR3u8RiObeJEqNBfAWw6v7+ASs63MnSLjmE7K/SwmBT5DLVlHhL6QBAD0z1bhKgbA9zmHIDjsPILA22Q
X-Gm-Message-State: AOJu0YyKRJoF7FAmkNMNn5W9USgafgLJfZM8w73tgZdi6XyAeRBqDA6J
	eUnFr35OtJg6V8J0fFr7QOQyzeu+67cW9XGcOGNZa2QpXU1GN9OYKdoUx9j0grpdBYVT/yhNo3C
	sGPIAyKsSQJDF97EH9MoVGE9frRk=
X-Google-Smtp-Source: AGHT+IHGGDT30WcdY64WppzLAUApw09NudbErIcqTouiL42vqsSl2ke/6zsJ34Zy1/mhQOcoc9GWhLB2JYkX4AJcaA4=
X-Received: by 2002:ac2:46d4:0:b0:52c:e112:4b0c with SMTP id
 2adb3069b0e04-52ce183314dmr4725882e87.9.1719366836049; Tue, 25 Jun 2024
 18:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625065459.3665791-1-chao@kernel.org> <a861d9aaf9394aa6bc77548735629f87@BJMBX02.spreadtrum.com>
 <1fe7878f-36db-4055-9e40-b39425eb5936@kernel.org> <CAHJ8P3Jj0SYuTgqo12r1fZxnWrx_ZH-=Cg5FUhmX4ZvRCLbROA@mail.gmail.com>
 <1516a462-1273-428d-aa3d-285bd00b7b69@kernel.org>
In-Reply-To: <1516a462-1273-428d-aa3d-285bd00b7b69@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 26 Jun 2024 09:53:44 +0800
Message-ID: <CAHJ8P3LVUguWpDsq3NobqdxUfCvhdpdxpuC6_S1=A9X5Spb-jw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5Bf2fs=2Ddev=5D_=E7=AD=94=E5=A4=8D=3A_=5BPATCH_v4=5D_f2fs=3A_reduce_expen?=
	=?UTF-8?Q?sive_checkpoint_trigger_frequency?=
To: Chao Yu <chao@kernel.org>
Cc: =?UTF-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>, 
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>, =?UTF-8?B?546L55qTIChIYW9faGFvIFdhbmcp?= <Hao_hao.Wang@unisoc.com>, 
	wangzijie <wangzijie1@honor.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B46=E6=9C=8826=E6=97=A5=E5=91=
=A8=E4=B8=89 09:36=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/6/25 19:07, Zhiguo Niu wrote:
> > Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B46=E6=9C=8825=E6=97=A5=
=E5=91=A8=E4=BA=8C 18:38=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 2024/6/25 16:09, =E7=89=9B=E5=BF=97=E5=9B=BD (Zhiguo Niu) wrote:
> >>>
> >>>
> >>> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> >>> =E5=8F=91=E4=BB=B6=E4=BA=BA: Chao Yu <chao@kernel.org>
> >>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B46=E6=9C=8825=E6=97=
=A5 14:55
> >>> =E6=94=B6=E4=BB=B6=E4=BA=BA: jaegeuk@kernel.org
> >>> =E6=8A=84=E9=80=81: linux-f2fs-devel@lists.sourceforge.net; linux-ker=
nel@vger.kernel.org; Chao Yu <chao@kernel.org>; wangzijie <wangzijie1@honor=
.com>; =E7=89=9B=E5=BF=97=E5=9B=BD (Zhiguo Niu) <Zhiguo.Niu@unisoc.com>; Yu=
nlei He <heyunlei@hihonor.com>
> >>> =E4=B8=BB=E9=A2=98: [PATCH v4] f2fs: reduce expensive checkpoint trig=
ger frequency
> >>>
> >>>
> >>> =E6=B3=A8=E6=84=8F: =E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E6=9D=A5=E8=
=87=AA=E4=BA=8E=E5=A4=96=E9=83=A8=E3=80=82=E9=99=A4=E9=9D=9E=E4=BD=A0=E7=A1=
=AE=E5=AE=9A=E9=82=AE=E4=BB=B6=E5=86=85=E5=AE=B9=E5=AE=89=E5=85=A8=EF=BC=8C=
=E5=90=A6=E5=88=99=E4=B8=8D=E8=A6=81=E7=82=B9=E5=87=BB=E4=BB=BB=E4=BD=95=E9=
=93=BE=E6=8E=A5=E5=92=8C=E9=99=84=E4=BB=B6=E3=80=82
> >>> CAUTION: This email originated from outside of the organization. Do n=
ot click links or open attachments unless you recognize the sender and know=
 the content is safe.
> >>>
> >>>
> >>>
> >>> We may trigger high frequent checkpoint for below case:
> >>> 1. mkdir /mnt/dir1; set dir1 encrypted
> >>> 2. touch /mnt/file1; fsync /mnt/file1
> >>> 3. mkdir /mnt/dir2; set dir2 encrypted
> >>> 4. touch /mnt/file2; fsync /mnt/file2
> >>> ...
> >>>
> >>> Although, newly created dir and file are not related, due to commit b=
bf156f7afa7 ("f2fs: fix lost xattrs of directories"), we will trigger check=
point whenever fsync() comes after a new encrypted dir created.
> >>>
> >>> In order to avoid such performance regression issue, let's record an =
entry including directory's ino in global cache whenever we update director=
y's xattr data, and then triggerring checkpoint() only if xattr metadata of=
 target file's parent was updated.
> >>>
> >>> This patch updates to cover below no encryption case as well:
> >>> 1) parent is checkpointed
> >>> 2) set_xattr(dir) w/ new xnid
> >>> 3) create(file)
> >>> 4) fsync(file)
> >>>
> >>> Fixes: bbf156f7afa7 ("f2fs: fix lost xattrs of directories")
> >>> Reported-by: wangzijie <wangzijie1@honor.com>
> >>> Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>> Tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>> Reported-by: Yunlei He <heyunlei@hihonor.com>
> >>> Signed-off-by: Chao Yu <chao@kernel.org>
> >>> ---
> >>>    fs/f2fs/f2fs.h              |  2 ++
> >>>    fs/f2fs/file.c              |  3 +++
> >>>    fs/f2fs/xattr.c             | 14 ++++++++++++--
> >>>    include/trace/events/f2fs.h |  3 ++-
> >>>    4 files changed, 19 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h index f1d65ee3addf..f3c9=
10b8983b 100644
> >>> --- a/fs/f2fs/f2fs.h
> >>> +++ b/fs/f2fs/f2fs.h
> >>> @@ -284,6 +284,7 @@ enum {
> >>>           APPEND_INO,             /* for append ino list */
> >>>           UPDATE_INO,             /* for update ino list */
> >>>           TRANS_DIR_INO,          /* for transactions dir ino list */
> >>> +       ENC_DIR_INO,            /* for encrypted dir ino list */
> >>>           FLUSH_INO,              /* for multiple device flushing */
> >>>           MAX_INO_ENTRY,          /* max. list */
> >>>    };
> >>> @@ -1150,6 +1151,7 @@ enum cp_reason_type {
> >>>           CP_FASTBOOT_MODE,
> >>>           CP_SPEC_LOG_NUM,
> >>>           CP_RECOVER_DIR,
> >>> +       CP_ENC_DIR,
> >>>    };
> >>>
> >>>    enum iostat_type {
> >>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c index a527de1e7a2f..2785=
73974db4 100644
> >>> --- a/fs/f2fs/file.c
> >>> +++ b/fs/f2fs/file.c
> >>> @@ -217,6 +217,9 @@ static inline enum cp_reason_type need_do_checkpo=
int(struct inode *inode)
> >>>                   f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
> >>>                                                           TRANS_DIR_I=
NO))
> >>>                   cp_reason =3D CP_RECOVER_DIR;
> >>> +       else if (f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
> >>> +                                                       ENC_DIR_INO))
> >>> +               cp_reason =3D CP_ENC_DIR;
> >>>
> >>>           return cp_reason;
> >>>    }
> >>> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c index f290fe9327c4..d0=
4c0b47a4e4 100644
> >>> --- a/fs/f2fs/xattr.c
> >>> +++ b/fs/f2fs/xattr.c
> >>> @@ -629,6 +629,7 @@ static int __f2fs_setxattr(struct inode *inode, i=
nt index,
> >>>                           const char *name, const void *value, size_t=
 size,
> >>>                           struct page *ipage, int flags)  {
> >>> +       struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> >>>           struct f2fs_xattr_entry *here, *last;
> >>>           void *base_addr, *last_base_addr;
> >>>           int found, newsize;
> >>> @@ -772,9 +773,18 @@ static int __f2fs_setxattr(struct inode *inode, =
int index,
> >>>           if (index =3D=3D F2FS_XATTR_INDEX_ENCRYPTION &&
> >>>                           !strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CO=
NTEXT))
> >>>                   f2fs_set_encrypted_inode(inode);
> >>> -       if (S_ISDIR(inode->i_mode))
> >>> -               set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
> >>>
> >>> +       if (!S_ISDIR(inode->i_mode))
> >>> +               goto same;
> >>> +       /*
> >>> +        * In restrict mode, fsync() always try to trigger checkpoint=
 for all
> >>> +        * metadata consistency, in other mode, it triggers checkpoin=
t when
> >>> +        * parent's xattr metadata was updated.
> >>> +        */
> >>> +       if (F2FS_OPTION(sbi).fsync_mode =3D=3D FSYNC_MODE_STRICT)
> >>> +               set_sbi_flag(sbi, SBI_NEED_CP);
> >>> Hi Chao,
> >>> For this case, will it also cause the same issue with original issue =
when fsync_mode =3D=3D FSYNC_MODE_STRICT ?
> >>> if ckpt thread is blocked by some reasons and SBI_NEED_CP is not clea=
red in time, Subsequent fsync will trigger cp?
> >>
> >> Hi Zhiguo,
> >>
> >> If there is no dirty data after previous CP, later CP triggered by sub=
sequent
> >> fsync will return directly?
> >>
> >>          if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
> >>                  ((cpc->reason & CP_FASTBOOT) || (cpc->reason & CP_SYN=
C) ||
> >>                  ((cpc->reason & CP_DISCARD) && !sbi->discard_blks)))
> >>                  goto out;
> >
> > Hi Chao,
> > I mean in the case of  F2FS_OPTION(sbi).fsync_mode =3D=3D
> > FSYNC_MODE_STRICT,  this will still cause the same issue with original
> > question.
> > Let me repost the problems I encountered .
> >
> > 1.set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
> >
> > 2. cp threa is blocked by io resource
> > #0 [ffffffc015fcb330] __switch_to at ffffffc010196350
> > #1 [ffffffc015fcb390] __schedule at ffffffc01168e53c
> > #2 [ffffffc015fcb3f0] schedule at ffffffc01168ed7c
> > #3 [ffffffc015fcb450] io_schedule at ffffffc01168f7a0
> > #4 [ffffffc015fcb4c0] blk_mq_get_tag at ffffffc0101008a4
>
Hi Chao
> It seems there is no free tag at that time, can you check its context
> to see why IO queue can be congested once you can reproduce this issue?
Yes, its monkek test report this issue, and IO load is heavy
>
> If the bottleneck is performance of storage, how about using other
> fsync_mode if its data consistency performace matches the requirement.
agree this,  thanks a lot.
>
> Thanks,
>
> > #5 [ffffffc015fcb530] blk_mq_get_request at ffffffc0109241b0
> > #6 [ffffffc015fcb5f0] blk_mq_make_request at ffffffc0109233bc
> > #7 [ffffffc015fcb680] generic_make_request at ffffffc0100fc6ec
> > #8 [ffffffc015fcb700] submit_bio at ffffffc0100fc3b8
> > #9 [ffffffc015fcb750] __submit_bio at ffffffc01081a2e0
> > #10 [ffffffc015fcb7d0] __submit_merged_bio at ffffffc01081b07c
> > #11 [ffffffc015fcb8a0] f2fs_submit_page_write at ffffffc0100ecd3c
> > #12 [ffffffc015fcb990] f2fs_do_write_meta_page at ffffffc010845738
> > #13 [ffffffc015fcb9d0] __f2fs_write_meta_page at ffffffc01080a8f4
> > #14 [ffffffc015fcbb60] f2fs_sync_meta_pages at ffffffc01080a684
> > #15 [ffffffc015fcbca0] do_checkpoint at ffffffc01080f0a8
> > #16 [ffffffc015fcbd10] f2fs_write_checkpoint at ffffffc01080e50c
> > #17 [ffffffc015fcbdb0] __checkpoint_and_complete_reqs at ffffffc010810f=
54
> > #18 [ffffffc015fcbe40] issue_checkpoint_thread at ffffffc0108113ec
> > #19 [ffffffc015fcbe80] kthread at ffffffc0102665b0
> >
> > 3. subsequent fsync will still issue ckpt becasue SBI_NEED_CP is set,
> > and if this is a very important thread, it will cause system issue,
> > such as init.
> > but this is should be avoided.
> > PID: 287      TASK: ffffff80f9eb0ec0  CPU: 2    COMMAND: "init"
> >
> > #0 [ffffffc01389bab0] __switch_to at ffffffc010196350
> > #1 [ffffffc01389bb10] __schedule at ffffffc01168e53c
> > #2 [ffffffc01389bb70] schedule at ffffffc01168ed7c
> > #3 [ffffffc01389bbc0] wait_for_completion at ffffffc011692368
> > #4 [ffffffc01389bca0] f2fs_issue_checkpoint at ffffffc010810cb0
> > #5 [ffffffc01389bd00] f2fs_sync_fs at ffffffc0107f4e1c
> > #6 [ffffffc01389bdc0] f2fs_do_sync_file at ffffffc0107d4d44
> > #7 [ffffffc01389be20] f2fs_sync_file at ffffffc0107d492c
> > #8 [ffffffc01389be30] __arm64_sys_fsync at ffffffc0105d31d8
> > #9 [ffffffc01389be70] el0_svc_common at ffffffc0101aa550
> > #10 [ffffffc01389beb0] el0_svc_handler at ffffffc0100886fc
> >
> > thanks!
> >>
> >>> +       else
> >>> +               f2fs_add_ino_entry(sbi, inode->i_ino, ENC_DIR_INO);
> >>> This patch version regardless of whether dir is encrypted or not, so =
this name(ENC_DIR_INO) can be rename other for more accurate?
> >>
> >> Thanks for pointing out this, let me fix it in v5.
> >>
> >> Thanks,
> >>
> >>> Thanks=EF=BC=81
> >>>    same:
> >>>           if (is_inode_flag_set(inode, FI_ACL_MODE)) {
> >>>                   inode->i_mode =3D F2FS_I(inode)->i_acl_mode; diff -=
-git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h index ed79=
4b5fefbe..e4a94995e9a8 100644
> >>> --- a/include/trace/events/f2fs.h
> >>> +++ b/include/trace/events/f2fs.h
> >>> @@ -139,7 +139,8 @@ TRACE_DEFINE_ENUM(EX_BLOCK_AGE);
> >>>                   { CP_NODE_NEED_CP,      "node needs cp" },         =
     \
> >>>                   { CP_FASTBOOT_MODE,     "fastboot mode" },         =
     \
> >>>                   { CP_SPEC_LOG_NUM,      "log type is 2" },         =
     \
> >>> -               { CP_RECOVER_DIR,       "dir needs recovery" })
> >>> +               { CP_RECOVER_DIR,       "dir needs recovery" },      =
   \
> >>> +               { CP_ENC_DIR,           "persist encryption policy" }=
)
> >>>
> >>>    #define show_shutdown_mode(type)                                  =
     \
> >>>           __print_symbolic(type,                                     =
     \
> >>> --
> >>> 2.40.1
> >>>
> >>
> >>
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

