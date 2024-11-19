Return-Path: <linux-kernel+bounces-413989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31169D2189
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0241DB21FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 08:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AFF198A07;
	Tue, 19 Nov 2024 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gL4cNycA"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5EA1474CF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732004793; cv=none; b=OoB3KR+tOkKzI1O91jyzzBvmAPdaZ//dcS6MbPOTVbSCd8KTiJc+uLG8B1WkE0yOcCNMQBCC94DGb6Sq+VPZOFAF8uMaZngt742f9bJY6M3NqRo5QPE+puxTKS5sMskXmsXpehincSVTWSLio4tkIuGKF9k1zV1HzuimMXlSPFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732004793; c=relaxed/simple;
	bh=6aCx4mgc9iPbOfw1H/QPk0i3xlqnorTIqLgXaFUDWBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byNS4C//oeYPDAhOEEwU76thWUD5ZswLvH0wnkDhtEXxa+kNp7NK0Tky6GD6dUnpkO2I0LbnZcAxyRgC2hcnbz0u/rcAG8mmfSWD5f02eLYVdNHJyWohS3rQ0kzzT5305Kfdf7aYM8A0ez9teZnVz6wrmv4ITTQgtb06vTYLKhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gL4cNycA; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-382435f561cso240996f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 00:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732004790; x=1732609590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8F/f1JVuG1/4L3xoA/BuZmrA79fjSAEhXH9BA0nKX8E=;
        b=gL4cNycAm9vOwVcoOv5WyFHTC296/i8afQEXu1AR9P6UxsZ76+v/gIf4PsvxpqV4e4
         YYSIon6H5ENmHuDj9/05x+sw/EQOn3CtSygfC5PS3z40X1Qox15xwiHmoB4bU8b2aI1D
         AtMO4IFatWBI3Wk9qIb+NN93KGW0MArDj1xEZmy0Q9e1nz1cq7TtEVVzcsFjKbT3R9VK
         3sJ+AzXsxMVpC7yx/fa/WCTGxIf3SPmzIVvFYsPHO2uCDgzA5XPjCgvFW2LxKUWtSFzm
         uVRgP0OWYEw6k7QXgfs4d2L5ix6uyQtUGoGYE9nu9eGavmu+wzraZ3RNElxtrJ/lau+U
         l/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732004790; x=1732609590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8F/f1JVuG1/4L3xoA/BuZmrA79fjSAEhXH9BA0nKX8E=;
        b=Ly2qY7ngiNhHIM2X1O2eJLyDGx9L+fXLvGYgKKc8RkNoFxmRgPXB8+oVe0AgT3zd49
         HDE1zdInW2kNOzvpo4gkMraCQhS00ZFSfmxB9XiTQl+CWAlVK4XEo+oFx/J/HllypUyP
         Ud7cwzF8pJxqexk4IwbgcZ5UlF28pSSaJU9QlSIW2LtzrJEXnIy0arCn/FGfDacnasUa
         6CFfez6xyH0cFJKwQBAa/BRi7UTQcGNC81YFaoQG+MWRCfDeVaZUG4rMvnrzL0/129yb
         qRcMJK3pecHrSTE7z/6TKhjJ3hTd8K18gsKH3XTI9+H1DMlQWJFiyOtatwB9+K53hMAY
         T5vA==
X-Forwarded-Encrypted: i=1; AJvYcCWIfQdr4VHcyjRrIGYlmAc7yAx8bH3TUVU4Nhh83S97fr5Ho62Muqtr83BKnM3S/OpXAkMQkH6CECGJRaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5X5aY0HJo6iCEZA+7wjz4nadBXztaRyWqmzRWONKXng24L0zc
	BvRClEYYuysqwNK2Ek5U40E0mWtFQy34zqEgmjBKQoflYdnT54eWo1JJNYzVCJDNSUalYmCoZAd
	Wkxde6/22CTOAVbAS8dpclQQrk1Q=
X-Google-Smtp-Source: AGHT+IFzSjc9vFJGGEdMyChIRwyrY50Xv9jtOnG9bmyOyAJKGCmdRAeb3y9enjfoi3BCUpLNAGyZ5JiN0qnwiQtBD+8=
X-Received: by 2002:a05:6000:400b:b0:382:4538:c0d with SMTP id
 ffacd0b85a97d-38245380e2bmr2127655f8f.2.1732004789635; Tue, 19 Nov 2024
 00:26:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112110627.1314632-1-xiuhong.wang@unisoc.com>
 <fb436fdb-a4eb-49cc-a730-354611e88b21@kernel.org> <CAOsHCa1t+LeeAG2PDJ0BfYtoh_+CUmLjZcp1+dGZWR5PPfmFSQ@mail.gmail.com>
 <5b0c17da-f1e1-490d-a560-3312bc8c3247@kernel.org>
In-Reply-To: <5b0c17da-f1e1-490d-a560-3312bc8c3247@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 19 Nov 2024 16:26:18 +0800
Message-ID: <CAHJ8P3+dqhsNOy6-jvPaazSSOk7V9pEkQmamE48oLgGK1ORHfg@mail.gmail.com>
Subject: Re: [PATCH] f2fs: Fix to avoid long time to shrink extent cache
To: Chao Yu <chao@kernel.org>
Cc: Xiuhong Wang <xiuhong.wang.cn@gmail.com>, Xiuhong Wang <xiuhong.wang@unisoc.com>, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, hao_hao.wang@unisoc.com, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=8819=E6=97=A5=E5=
=91=A8=E4=BA=8C 15:50=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/11/19 14:46, Xiuhong Wang wrote:
> > Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=8819=E6=97=A5=
=E5=91=A8=E4=BA=8C 14:05=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 2024/11/12 19:06, Xiuhong Wang wrote:
> >>> We encountered a system hang problem based on the following
> >>> experiment:
> >>> There are 17 processes, 8 of which do 4k data read, write and
> >>> compare tests, and 8 do 64k read, write and compare tests. Each
> >>> thread writes a 256M file, and another thread writes a large file
> >>> to 80% of the disk, and then keeps doing read operations, all of
> >>> which are direct operations. This will cause the large file to be
> >>> filled to 80% of the disk to be severely fragmented. On a 512GB
> >>> device, this large file may generate a huge zombie extent tree.
> >>>
> >>> When system shutting down, the init process needs to wait for the
> >>> writeback process, and the writeback process may encounter the
> >>> situation where the READ_EXTENT_CACHE space is insufficient and
> >>> needs to free the zombie extent tree. The extent tree has a large
> >>> number of extent nodes, it will a long free time to free, which
> >>> triggers system hang.
> >>   > > The stack when the problem occurs is as follows:
> >>> crash_arm64> bt 1
> >>> PID: 1        TASK: ffffff80801a9200  CPU: 1    COMMAND: "init"
> >>>    #0 [ffffffc00806b9a0] __switch_to at ffffffc00810711c
> >>>    #1 [ffffffc00806ba00] __schedule at ffffffc0097c1c4c
> >>>    #2 [ffffffc00806ba60] schedule at ffffffc0097c2308
> >>>    #3 [ffffffc00806bab0] wb_wait_for_completion at ffffffc0086320d4
> >>>    #4 [ffffffc00806bb20] writeback_inodes_sb at ffffffc00863719c
> >>>    #5 [ffffffc00806bba0] sync_filesystem at ffffffc00863c98c
> >>>    #6 [ffffffc00806bbc0] f2fs_quota_off_umount at ffffffc00886fc60
> >>>    #7 [ffffffc00806bc20] f2fs_put_super at ffffffc0088715b4
> >>>    #8 [ffffffc00806bc60] generic_shutdown_super at ffffffc0085cd61c
> >>>    #9 [ffffffc00806bcd0] kill_f2fs_super at ffffffc00886b3dc
> >>>
> >>> crash_arm64> bt 14997
> >>> PID: 14997    TASK: ffffff8119d82400  CPU: 3    COMMAND: "kworker/u16=
:0"
> >>>    #0 [ffffffc019f8b760] __detach_extent_node at ffffffc0088d5a58
> >>>    #1 [ffffffc019f8b790] __release_extent_node at ffffffc0088d5970
> >>>    #2 [ffffffc019f8b810] f2fs_shrink_extent_tree at ffffffc0088d5c7c
> >>>    #3 [ffffffc019f8b8a0] f2fs_balance_fs_bg at ffffffc0088c109c
> >>>    #4 [ffffffc019f8b910] f2fs_write_node_pages at ffffffc0088bd4d8
> >>>    #5 [ffffffc019f8b990] do_writepages at ffffffc0084a0b5c
> >>>    #6 [ffffffc019f8b9f0] __writeback_single_inode at ffffffc00862ee28
> >>>    #7 [ffffffc019f8bb30] writeback_sb_inodes at ffffffc0086358c0
> >>>    #8 [ffffffc019f8bc10] wb_writeback at ffffffc0086362dc
> >>>    #9 [ffffffc019f8bcc0] wb_do_writeback at ffffffc008634910
> >>>
> >>> Process 14997 ran for too long and caused the system hang.
> >>>
> >>> At this time, there are still 1086911 extent nodes in this zombie
> >>> extent tree that need to be cleaned up.
> >>>
> >>> crash_arm64_sprd_v8.0.3++> extent_tree.node_cnt ffffff80896cc500
> >>>     node_cnt =3D {
> >>>       counter =3D 1086911
> >>>     },
> >>>
> >>> The root cause of this problem is that when the f2fs_balance_fs
> >>> function is called in the write process, it will determine
> >>> whether to call f2fs_balance_fs_bg, but it is difficult to
> >>> meet the condition of excess_cached_nats. When the
> >>> f2fs_shrink_extent_tree function is called to free during
> >>> f2fs_write_node_pages, there are too many extent nodes on the
> >>> extent tree, which causes a loop and causes a system hang.
> >>>
> >>> To solve this problem, when calling f2fs_balance_fs, check whether
> >>> the extent cache is sufficient. If not, release the zombie extent
> >>> tree.
> >>>
> >>> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> >>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>> ---
> >>> Test the problem with the temporary versions:
> >>> patch did not reproduce the problem, the patch is as follows:
> >>> @@ -415,7 +415,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bo=
ol need)
> >>>                   f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_FAU=
LT_INJECT);
> >>>
> >>>           /* balance_fs_bg is able to be pending */
> >>> -       if (need && excess_cached_nats(sbi))
> >>> +       if (need)
> >>>                   f2fs_balance_fs_bg(sbi, false);
> >>>
> >>> ---
> >>>    fs/f2fs/segment.c | 4 +++-
> >>>    1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>> index 1766254279d2..390bec177567 100644
> >>> --- a/fs/f2fs/segment.c
> >>> +++ b/fs/f2fs/segment.c
> >>> @@ -415,7 +415,9 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bo=
ol need)
> >>>                f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_FAULT_=
INJECT);
> >>>
> >>>        /* balance_fs_bg is able to be pending */
> >>> -     if (need && excess_cached_nats(sbi))
> >>> +     if (need && (excess_cached_nats(sbi) ||
> >>> +                     !f2fs_available_free_memory(sbi, READ_EXTENT_CA=
CHE) ||
> >>> +                     !f2fs_available_free_memory(sbi, AGE_EXTENT_CAC=
HE)))
> >>
> >> Hi,
> >>
> >> I doubt if there is no enough memory, we may still run into
> >> f2fs_shrink_extent_tree() and suffer such long time delay.
> >>
> >> So, can we just let __free_extent_tree() break the loop once we have
> >> released entries w/ target number? something like this:
> >>
> >> ---
> >>    fs/f2fs/extent_cache.c | 15 ++++++++++-----
> >>    1 file changed, 10 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> >> index 019c1f7b7fa5..38c71c1c4fb7 100644
> >> --- a/fs/f2fs/extent_cache.c
> >> +++ b/fs/f2fs/extent_cache.c
> >> @@ -379,11 +379,12 @@ static struct extent_tree *__grab_extent_tree(st=
ruct inode *inode,
> >>    }
> >>
> >>    static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
> >> -                                       struct extent_tree *et)
> >> +                               struct extent_tree *et, unsigned int n=
r_shrink)
> >>    {
> >>          struct rb_node *node, *next;
> >>          struct extent_node *en;
> >>          unsigned int count =3D atomic_read(&et->node_cnt);
> >> +       unsigned int i =3D 0;
> >>
> >>          node =3D rb_first_cached(&et->root);
> >>          while (node) {
> >> @@ -391,6 +392,9 @@ static unsigned int __free_extent_tree(struct f2fs=
_sb_info *sbi,
> >>                  en =3D rb_entry(node, struct extent_node, rb_node);
> >>                  __release_extent_node(sbi, et, en);
> >>                  node =3D next;
> >> +
> >> +               if (nr_shrink && ++i >=3D nr_shrink)
> >> +                       break;
> >>          }
> >>
> >>          return count - atomic_read(&et->node_cnt);
> >> @@ -761,7 +765,7 @@ static void __update_extent_tree_range(struct inod=
e *inode,
> >>          }
> >>
> >>          if (is_inode_flag_set(inode, FI_NO_EXTENT))
> >> -               __free_extent_tree(sbi, et);
> >> +               __free_extent_tree(sbi, et, 0);
> >>
> >>          if (et->largest_updated) {
> >>                  et->largest_updated =3D false;
> >> @@ -942,7 +946,8 @@ static unsigned int __shrink_extent_tree(struct f2=
fs_sb_info *sbi, int nr_shrink
> >>          list_for_each_entry_safe(et, next, &eti->zombie_list, list) {
> >>                  if (atomic_read(&et->node_cnt)) {
> >>                          write_lock(&et->lock);
> >> -                       node_cnt +=3D __free_extent_tree(sbi, et);
> >> +                       node_cnt +=3D __free_extent_tree(sbi, et,
> >> +                                       nr_shrink - node_cnt - tree_cn=
t);
> >>                          write_unlock(&et->lock);
> >>                  }
> >>                  f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
> >> @@ -1095,7 +1100,7 @@ static unsigned int __destroy_extent_node(struct=
 inode *inode,
> >>                  return 0;
> >>
> >>          write_lock(&et->lock);
> >> -       node_cnt =3D __free_extent_tree(sbi, et);
> >> +       node_cnt =3D __free_extent_tree(sbi, et, 0);
> >>          write_unlock(&et->lock);
> >>
> >>          return node_cnt;
> >> @@ -1117,7 +1122,7 @@ static void __drop_extent_tree(struct inode *ino=
de, enum extent_type type)
> >>                  return;
> >>
> >>          write_lock(&et->lock);
> >> -       __free_extent_tree(sbi, et);
> >> +       __free_extent_tree(sbi, et, 0);
> >>          if (type =3D=3D EX_READ) {
> >>                  set_inode_flag(inode, FI_NO_EXTENT);
> >>                  if (et->largest.len) {
> >> --
> >> 2.40.1
> >>
> >> Thanks,
> >>
> >>>                f2fs_balance_fs_bg(sbi, false);
> >>>
> >>>        if (!f2fs_is_checkpoint_ready(sbi))
> >>
> >
> >
> > Hi chao,
> >
> > We have also considered this approach, but the problem still occurs
> > after retesting.
> > 1. The problem still occurs in the following call of the unmount data p=
rocess.
> > f2fs_put_super -> f2fs_leave_shrinker
>
> Yes, I guess we need to fix this path as well, however, your patch didn't
> cover this path as well, am I missing something?
Dear Chao,
This patch version aim  to shrink extent cache as early as possible on
the  "all write path"
by "write action" -> f2fs_balance_fs -> f2fs_balance_fs_bg
As the comment , the "excess_cached_nats" is difficult to achieve in
this scenario, and
trigger the issue in path f2fs_write_node_pages->f2fs_balance_fs_bg(is
called directly here).
At that time, there were already a lot of extent node cnt.
Thanks!
>
> > 2. Writing back the inode in the normal write-back process will
> > release the extent cache, and the problem still occurs. The stack is
> > as follows:
>
> Ditto,
>
> Thanks,
>
> > [H 103098.974356] c2 [<ffffffc008aee8a4>] (rb_erase+0x204/0x334)
> > [H 103098.974389] c2 [<ffffffc0088f8fd0>] (__release_extent_node+0xc8/0=
x168)
> > [H 103098.974425] c2 [<ffffffc0088fad74>]
> > (f2fs_update_extent_tree_range+0x4a0/0x724)
> > [H 103098.974459] c2 [<ffffffc0088fa8c0>] (f2fs_update_extent_cache+0x1=
9c/0x1b0)
> > [H 103098.974495] c2 [<ffffffc0088edc70>] (f2fs_outplace_write_data+0x7=
4/0xf0)
> > [H 103098.974525] c2 [<ffffffc0088ca834>] (f2fs_do_write_data_page+0x3e=
4/0x6c8)
> > [H 103098.974552] c2 [<ffffffc0088cb150>]
> > (f2fs_write_single_data_page+0x478/0xab0)
> > [H 103098.974574] c2 [<ffffffc0088d0bd0>] (f2fs_write_cache_pages+0x454=
/0xaac)
> > [H 103098.974596] c2 [<ffffffc0088d0698>] (__f2fs_write_data_pages+0x40=
c/0x4f0)
> > [H 103098.974617] c2 [<ffffffc0088cc860>] (f2fs_write_data_pages+0x30/0=
x40)
> > [H 103098.974645] c2 [<ffffffc0084c0e00>] (do_writepages+0x18c/0x3e8)
> > [H 103098.974678] c2 [<ffffffc0086503cc>] (__writeback_single_inode+0x4=
8/0x498)
> > [H 103098.974720] c2 [<ffffffc0086562c8>] (writeback_sb_inodes+0x454/0x=
9b0)
> > [H 103098.974754] c2 [<ffffffc008655de8>] (__writeback_inodes_wb+0x198/=
0x224)
> > [H 103098.974788] c2 [<ffffffc008656d0c>] (wb_writeback+0x1c0/0x698)
> > [H 103098.974819] c2 [<ffffffc008655614>] (wb_do_writeback+0x420/0x54c)
> > [H 103098.974853] c2 [<ffffffc008654f50>] (wb_workfn+0xe4/0x388)
>

