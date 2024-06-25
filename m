Return-Path: <linux-kernel+bounces-228715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EB59165DD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E88286CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E99F14AD24;
	Tue, 25 Jun 2024 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ8gNf72"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8844714AD0A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719313643; cv=none; b=EGLgFAcyuyCM6vsXHt4aALsStkrR/Uo7ULlkOeHbYIUn8pbEMmilHn7Nqi1cZVCZQP677l/aG5lOlKCK85d+rX/S5QFWfxSouoULYgbokitfNF54YUGw2Wks8Z/dWKXICefoaC2tJecgh0WrDKyesgh/ULbr5t5eKfnk7/GEU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719313643; c=relaxed/simple;
	bh=Rd9U8YrxGoPLDZ+G+xqGFzpzDiMbBlFLliBjhBZKRuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwNRMTnYa851ShjkQgE9XGvhxekui+T1QTQktUb9XBKxfagZK6DpDvvPg25/u7SJJWi5XyPEjn4MgiFXQJfLpPha15U1tZ0uxdNLBn9s7XiLuQXuUP4t/+8BG+eWMI7mh1iqpcvwMcStl7N1BSpJwIQMgQ38gEfx8HFZtC4A6Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZ8gNf72; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-421bb51d81aso44903265e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719313640; x=1719918440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1k8CR++PA8MBzEN5wdULt6PR+WuLY3v204LHFnZGiv8=;
        b=PZ8gNf72lG10/YGGvzaaL6tjpf9bNBEV6c4PSWHV4Gw/0dXKptvuXfwpQeLGUAC8+R
         GxNfobITOMiCz4TToLJbhAST2C3u/DyfVIpGHfBd+Lt9+6FQCxStdWa6iYCA/sDWq8rZ
         Q+mLVoDmkfUGHDt39d82Fs5liaQF37dZwcDvPGnJLwHCt6QvsPIuNn0G7m1IJW2z4hh0
         QHLVSlIsTUCcJEFVRcztNX5MNAreCw4PCX0JRB1174vXDfvtUHR1XTEa5WK+EBAWf7dX
         A0ABVaPiFGurGX5QINmsBaTJJXop2+iPjr3zhw3hVHeNm1jD6yuxZ2UhXN/HKZw124VC
         zsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719313640; x=1719918440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1k8CR++PA8MBzEN5wdULt6PR+WuLY3v204LHFnZGiv8=;
        b=iOBUTPGyu2U5ubHAPrYCyEo2xahRMOnCgyzNLl49s0rehyZoAXPc391isYXv0IaZ1n
         oE/SSxyDwjrRJfzIWTs+0OPlPaOC5zW8havSchhDbSFz6Ub+bZgKdLqErCv/zEhPoA/q
         88Tov92fa+tWvo8Qm2pELVLp0Vww1Htljn/VVnWtiKeahUZriCPZFfzNzJhCHNhcVt+8
         vFiuTTEHrcD3Uyj65xQf/S1pxkW+KqHtKjgtcy20S+uxStq7shz1L5BrGjyAqvoe4zuz
         jKEnFc4Dd4YfO75JD9liSs+Q7HEPKSzzMwJxroJSE+3e1Te6n4Ta4qRZBntHQ2SJMNVQ
         BDmw==
X-Forwarded-Encrypted: i=1; AJvYcCXHkwNVbvSoKZ/gmHOPWo8f5WVIzUJKacHA54eU+KkBh/8B8nJ13oQsj3aAz0GNZ9xlQyLorRJkQHA1KAeVYnCGaJ1tbyui4ckTTikn
X-Gm-Message-State: AOJu0Yy66KZi3lcBYj0lXHI2ujd3n1GmjY6njtDUk1S1KEi4oWInGXtv
	bVL/WLEqgddaS5SJT81fNjzFM33oi8OEebB3GEpT1Ig5mZNzhC7jHwPn6WNj1WaJEV0ERxKG6hq
	9Os0J0kY4h8icmKrW+Pv3Oh7tMwU=
X-Google-Smtp-Source: AGHT+IF69pOuflSOllUrwUAcK5tdahhvC52CFpj+goGmlctCdz2/olKWdjzXVtSdGvLYqsm0YEVBika7p39KaYq9cnA=
X-Received: by 2002:a05:6000:ac8:b0:366:f001:78d5 with SMTP id
 ffacd0b85a97d-366f0017a59mr4191436f8f.13.1719313639508; Tue, 25 Jun 2024
 04:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625065459.3665791-1-chao@kernel.org> <a861d9aaf9394aa6bc77548735629f87@BJMBX02.spreadtrum.com>
 <1fe7878f-36db-4055-9e40-b39425eb5936@kernel.org>
In-Reply-To: <1fe7878f-36db-4055-9e40-b39425eb5936@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 25 Jun 2024 19:07:08 +0800
Message-ID: <CAHJ8P3Jj0SYuTgqo12r1fZxnWrx_ZH-=Cg5FUhmX4ZvRCLbROA@mail.gmail.com>
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

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B46=E6=9C=8825=E6=97=A5=E5=91=
=A8=E4=BA=8C 18:38=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/6/25 16:09, =E7=89=9B=E5=BF=97=E5=9B=BD (Zhiguo Niu) wrote:
> >
> >
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Chao Yu <chao@kernel.org>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B46=E6=9C=8825=E6=97=
=A5 14:55
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: jaegeuk@kernel.org
> > =E6=8A=84=E9=80=81: linux-f2fs-devel@lists.sourceforge.net; linux-kerne=
l@vger.kernel.org; Chao Yu <chao@kernel.org>; wangzijie <wangzijie1@honor.c=
om>; =E7=89=9B=E5=BF=97=E5=9B=BD (Zhiguo Niu) <Zhiguo.Niu@unisoc.com>; Yunl=
ei He <heyunlei@hihonor.com>
> > =E4=B8=BB=E9=A2=98: [PATCH v4] f2fs: reduce expensive checkpoint trigge=
r frequency
> >
> >
> > =E6=B3=A8=E6=84=8F: =E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E6=9D=A5=E8=87=
=AA=E4=BA=8E=E5=A4=96=E9=83=A8=E3=80=82=E9=99=A4=E9=9D=9E=E4=BD=A0=E7=A1=AE=
=E5=AE=9A=E9=82=AE=E4=BB=B6=E5=86=85=E5=AE=B9=E5=AE=89=E5=85=A8=EF=BC=8C=E5=
=90=A6=E5=88=99=E4=B8=8D=E8=A6=81=E7=82=B9=E5=87=BB=E4=BB=BB=E4=BD=95=E9=93=
=BE=E6=8E=A5=E5=92=8C=E9=99=84=E4=BB=B6=E3=80=82
> > CAUTION: This email originated from outside of the organization. Do not=
 click links or open attachments unless you recognize the sender and know t=
he content is safe.
> >
> >
> >
> > We may trigger high frequent checkpoint for below case:
> > 1. mkdir /mnt/dir1; set dir1 encrypted
> > 2. touch /mnt/file1; fsync /mnt/file1
> > 3. mkdir /mnt/dir2; set dir2 encrypted
> > 4. touch /mnt/file2; fsync /mnt/file2
> > ...
> >
> > Although, newly created dir and file are not related, due to commit bbf=
156f7afa7 ("f2fs: fix lost xattrs of directories"), we will trigger checkpo=
int whenever fsync() comes after a new encrypted dir created.
> >
> > In order to avoid such performance regression issue, let's record an en=
try including directory's ino in global cache whenever we update directory'=
s xattr data, and then triggerring checkpoint() only if xattr metadata of t=
arget file's parent was updated.
> >
> > This patch updates to cover below no encryption case as well:
> > 1) parent is checkpointed
> > 2) set_xattr(dir) w/ new xnid
> > 3) create(file)
> > 4) fsync(file)
> >
> > Fixes: bbf156f7afa7 ("f2fs: fix lost xattrs of directories")
> > Reported-by: wangzijie <wangzijie1@honor.com>
> > Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > Tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > Reported-by: Yunlei He <heyunlei@hihonor.com>
> > Signed-off-by: Chao Yu <chao@kernel.org>
> > ---
> >   fs/f2fs/f2fs.h              |  2 ++
> >   fs/f2fs/file.c              |  3 +++
> >   fs/f2fs/xattr.c             | 14 ++++++++++++--
> >   include/trace/events/f2fs.h |  3 ++-
> >   4 files changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h index f1d65ee3addf..f3c910=
b8983b 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -284,6 +284,7 @@ enum {
> >          APPEND_INO,             /* for append ino list */
> >          UPDATE_INO,             /* for update ino list */
> >          TRANS_DIR_INO,          /* for transactions dir ino list */
> > +       ENC_DIR_INO,            /* for encrypted dir ino list */
> >          FLUSH_INO,              /* for multiple device flushing */
> >          MAX_INO_ENTRY,          /* max. list */
> >   };
> > @@ -1150,6 +1151,7 @@ enum cp_reason_type {
> >          CP_FASTBOOT_MODE,
> >          CP_SPEC_LOG_NUM,
> >          CP_RECOVER_DIR,
> > +       CP_ENC_DIR,
> >   };
> >
> >   enum iostat_type {
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c index a527de1e7a2f..278573=
974db4 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -217,6 +217,9 @@ static inline enum cp_reason_type need_do_checkpoin=
t(struct inode *inode)
> >                  f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
> >                                                          TRANS_DIR_INO)=
)
> >                  cp_reason =3D CP_RECOVER_DIR;
> > +       else if (f2fs_exist_written_data(sbi, F2FS_I(inode)->i_pino,
> > +                                                       ENC_DIR_INO))
> > +               cp_reason =3D CP_ENC_DIR;
> >
> >          return cp_reason;
> >   }
> > diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c index f290fe9327c4..d04c=
0b47a4e4 100644
> > --- a/fs/f2fs/xattr.c
> > +++ b/fs/f2fs/xattr.c
> > @@ -629,6 +629,7 @@ static int __f2fs_setxattr(struct inode *inode, int=
 index,
> >                          const char *name, const void *value, size_t si=
ze,
> >                          struct page *ipage, int flags)  {
> > +       struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> >          struct f2fs_xattr_entry *here, *last;
> >          void *base_addr, *last_base_addr;
> >          int found, newsize;
> > @@ -772,9 +773,18 @@ static int __f2fs_setxattr(struct inode *inode, in=
t index,
> >          if (index =3D=3D F2FS_XATTR_INDEX_ENCRYPTION &&
> >                          !strcmp(name, F2FS_XATTR_NAME_ENCRYPTION_CONTE=
XT))
> >                  f2fs_set_encrypted_inode(inode);
> > -       if (S_ISDIR(inode->i_mode))
> > -               set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);
> >
> > +       if (!S_ISDIR(inode->i_mode))
> > +               goto same;
> > +       /*
> > +        * In restrict mode, fsync() always try to trigger checkpoint f=
or all
> > +        * metadata consistency, in other mode, it triggers checkpoint =
when
> > +        * parent's xattr metadata was updated.
> > +        */
> > +       if (F2FS_OPTION(sbi).fsync_mode =3D=3D FSYNC_MODE_STRICT)
> > +               set_sbi_flag(sbi, SBI_NEED_CP);
> > Hi Chao,
> > For this case, will it also cause the same issue with original issue wh=
en fsync_mode =3D=3D FSYNC_MODE_STRICT ?
> > if ckpt thread is blocked by some reasons and SBI_NEED_CP is not cleare=
d in time, Subsequent fsync will trigger cp?
>
> Hi Zhiguo,
>
> If there is no dirty data after previous CP, later CP triggered by subseq=
uent
> fsync will return directly?
>
>         if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
>                 ((cpc->reason & CP_FASTBOOT) || (cpc->reason & CP_SYNC) |=
|
>                 ((cpc->reason & CP_DISCARD) && !sbi->discard_blks)))
>                 goto out;

Hi Chao,
I mean in the case of  F2FS_OPTION(sbi).fsync_mode =3D=3D
FSYNC_MODE_STRICT,  this will still cause the same issue with original
question.
Let me repost the problems I encountered .

1.set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_CP);

2. cp threa is blocked by io resource
#0 [ffffffc015fcb330] __switch_to at ffffffc010196350
#1 [ffffffc015fcb390] __schedule at ffffffc01168e53c
#2 [ffffffc015fcb3f0] schedule at ffffffc01168ed7c
#3 [ffffffc015fcb450] io_schedule at ffffffc01168f7a0
#4 [ffffffc015fcb4c0] blk_mq_get_tag at ffffffc0101008a4
#5 [ffffffc015fcb530] blk_mq_get_request at ffffffc0109241b0
#6 [ffffffc015fcb5f0] blk_mq_make_request at ffffffc0109233bc
#7 [ffffffc015fcb680] generic_make_request at ffffffc0100fc6ec
#8 [ffffffc015fcb700] submit_bio at ffffffc0100fc3b8
#9 [ffffffc015fcb750] __submit_bio at ffffffc01081a2e0
#10 [ffffffc015fcb7d0] __submit_merged_bio at ffffffc01081b07c
#11 [ffffffc015fcb8a0] f2fs_submit_page_write at ffffffc0100ecd3c
#12 [ffffffc015fcb990] f2fs_do_write_meta_page at ffffffc010845738
#13 [ffffffc015fcb9d0] __f2fs_write_meta_page at ffffffc01080a8f4
#14 [ffffffc015fcbb60] f2fs_sync_meta_pages at ffffffc01080a684
#15 [ffffffc015fcbca0] do_checkpoint at ffffffc01080f0a8
#16 [ffffffc015fcbd10] f2fs_write_checkpoint at ffffffc01080e50c
#17 [ffffffc015fcbdb0] __checkpoint_and_complete_reqs at ffffffc010810f54
#18 [ffffffc015fcbe40] issue_checkpoint_thread at ffffffc0108113ec
#19 [ffffffc015fcbe80] kthread at ffffffc0102665b0

3. subsequent fsync will still issue ckpt becasue SBI_NEED_CP is set,
and if this is a very important thread, it will cause system issue,
such as init.
but this is should be avoided.
PID: 287      TASK: ffffff80f9eb0ec0  CPU: 2    COMMAND: "init"

#0 [ffffffc01389bab0] __switch_to at ffffffc010196350
#1 [ffffffc01389bb10] __schedule at ffffffc01168e53c
#2 [ffffffc01389bb70] schedule at ffffffc01168ed7c
#3 [ffffffc01389bbc0] wait_for_completion at ffffffc011692368
#4 [ffffffc01389bca0] f2fs_issue_checkpoint at ffffffc010810cb0
#5 [ffffffc01389bd00] f2fs_sync_fs at ffffffc0107f4e1c
#6 [ffffffc01389bdc0] f2fs_do_sync_file at ffffffc0107d4d44
#7 [ffffffc01389be20] f2fs_sync_file at ffffffc0107d492c
#8 [ffffffc01389be30] __arm64_sys_fsync at ffffffc0105d31d8
#9 [ffffffc01389be70] el0_svc_common at ffffffc0101aa550
#10 [ffffffc01389beb0] el0_svc_handler at ffffffc0100886fc

thanks!
>
> > +       else
> > +               f2fs_add_ino_entry(sbi, inode->i_ino, ENC_DIR_INO);
> > This patch version regardless of whether dir is encrypted or not, so th=
is name(ENC_DIR_INO) can be rename other for more accurate?
>
> Thanks for pointing out this, let me fix it in v5.
>
> Thanks,
>
> > Thanks=EF=BC=81
> >   same:
> >          if (is_inode_flag_set(inode, FI_ACL_MODE)) {
> >                  inode->i_mode =3D F2FS_I(inode)->i_acl_mode; diff --gi=
t a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h index ed794b5=
fefbe..e4a94995e9a8 100644
> > --- a/include/trace/events/f2fs.h
> > +++ b/include/trace/events/f2fs.h
> > @@ -139,7 +139,8 @@ TRACE_DEFINE_ENUM(EX_BLOCK_AGE);
> >                  { CP_NODE_NEED_CP,      "node needs cp" },            =
  \
> >                  { CP_FASTBOOT_MODE,     "fastboot mode" },            =
  \
> >                  { CP_SPEC_LOG_NUM,      "log type is 2" },            =
  \
> > -               { CP_RECOVER_DIR,       "dir needs recovery" })
> > +               { CP_RECOVER_DIR,       "dir needs recovery" },        =
 \
> > +               { CP_ENC_DIR,           "persist encryption policy" })
> >
> >   #define show_shutdown_mode(type)                                     =
  \
> >          __print_symbolic(type,                                        =
  \
> > --
> > 2.40.1
> >
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

