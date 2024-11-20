Return-Path: <linux-kernel+bounces-415485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEB99D36F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18EF01F27395
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104BD1A3AA8;
	Wed, 20 Nov 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjQ7RzMs"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7F519D091
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732094364; cv=none; b=IOg2iVITMIKOynmzwJLjW7jNLS5+qQip6qIAbCpBQ4O1CWVnkh/kk6BR+klObS5dcYeBrCysCFbDMqeMljOzQ+urvFOSfU68VvC+1QI1CDxczBO/4tvrHZPdBR4acC527wlABb4AnzJx1u/Sjg5cizlOnhCX3iM640BKBEtXig8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732094364; c=relaxed/simple;
	bh=Zni+9CLPZeE2M5yHF6SMTeSM+p8eEeA/fLcXk0GubXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hibaPLOavy7qe6jGYqLLufDugWCEv8aSO4a7WcdNMzGzlrm7YccgJMw3GNt0p8VJuUlIANuowC7NscOx6MBMcfi8taN4sUmv11TDVqAc4vRGZbej7f4W8rSFyzV3Usz7glquaCk3Elp9Z6L60DnhAH41XZkwiDpJ1s79Chgn+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjQ7RzMs; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3824a646667so353856f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 01:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732094357; x=1732699157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3T4pVCKMHJOGfsizGa28a2mJDTYv+Hjd9FVUBN9zpUc=;
        b=SjQ7RzMsXSLbOaPzcNY74yXs0MZotzO//xIJDT1Uit9+hRG12DHxI2sQW06x1C+9tr
         7KiLeQkvN7aqjPHEIPLXqjoc9C0Dt4JXikQGcBrswqJXJ77eE16EVI+mwHfQjUAovqXz
         KUzGrfdiW6k7XprQ9DGwmK+fS/e7AzN02tSS89HvdEdC9WRk6iHxZPtdsED60hMQsOPu
         MCZJxjDm0sHmbNrwbdEPdujO4vXpOQ7O/aDjZQKG3GTGDNsYRLlq5EzvAhtWpZGNgAFh
         W8c+/foVYQP9A0XZw8eqiWvVW5K8gsg+8Sp1a20CABpPxouN5uiNg9O1IxD0A3WHUzKN
         IR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732094357; x=1732699157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3T4pVCKMHJOGfsizGa28a2mJDTYv+Hjd9FVUBN9zpUc=;
        b=rpGpfqppHAcQ1NGLz/071vK6zQd6yHXF/HuEU/Kdb+CaGblA0LeZQntBKbxlms9K3Z
         AqhpU7eCHABKsi5TrMoYPfdHFSJZzXRK3F+gNwhaO/9Wx7bI2zw5fEw7KLADfNHPiEYX
         vW2jjOAZB89umm8XhUngeY7ex5CKqJBjZw4NrAa/uD94JtKTvnn87uVXIDQf7/0KL32h
         YVoAU2Kn6qhHGBWrQ4sQGYsU1o/XTa/6QEDHkFNCfUD3A1XFwe0MsyjmfVgiIXKH6Lpd
         QsX7jsrSfksbCedC/lQP+41U6gTLhPLFtnenYAJP2UYH654w4RJHacMSQw/qmqwhFH7R
         S/VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS9AFeDCu69Lju4xNXpUsywBq3hYq/kq89MgAezhd0r01zrqYrm+TIjpkf53mo45gNpf4a5rS92qGDy+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkBy72ZGGvKF6wNkvqWKtAjHGP9WEvl1l9yC2WwvUPiCqUiitV
	L/zaeqFyHcn0k5XlVFHOyY6aC0ilMjsGlOsUM6PhmKa0Is4H7lgDkmLmfGjYAizoGb6CLzWpnsh
	2fjnjfYRTCeRTBP+Xy/82rNTVlrs=
X-Gm-Gg: ASbGncuzgCfWLJE+V7B5SnibHZPeWteSt6DKmOkNUn18z2nF609MPs3FteomTYZcIL2
	lW+cl5fPzYztzspuDkm8aAjd18CSXzPMT
X-Google-Smtp-Source: AGHT+IFjiOOM8DcxBdrMs87n9NgH8sqqh/pm3JJandQSt+FxrhXgNaZKIkSsT5feYP/NgF2wE9+RyhKCd2efRxn5A1Q=
X-Received: by 2002:a05:6000:2a1:b0:37d:2e83:bc44 with SMTP id
 ffacd0b85a97d-38254b270femr553841f8f.9.1732094356576; Wed, 20 Nov 2024
 01:19:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112110627.1314632-1-xiuhong.wang@unisoc.com>
 <fb436fdb-a4eb-49cc-a730-354611e88b21@kernel.org> <CAOsHCa1t+LeeAG2PDJ0BfYtoh_+CUmLjZcp1+dGZWR5PPfmFSQ@mail.gmail.com>
 <5b0c17da-f1e1-490d-a560-3312bc8c3247@kernel.org> <CAHJ8P3+dqhsNOy6-jvPaazSSOk7V9pEkQmamE48oLgGK1ORHfg@mail.gmail.com>
 <65b89566-1038-4422-9e2e-4d7da26dd1c7@kernel.org> <CAHJ8P3+SzZ-_8dsg7GkjLDqiWB6G6b+c8+EJku5eaMkxmf=ZVg@mail.gmail.com>
 <5b40ca3c-efd6-4b50-8d11-845930a0e365@kernel.org>
In-Reply-To: <5b40ca3c-efd6-4b50-8d11-845930a0e365@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 20 Nov 2024 17:19:05 +0800
Message-ID: <CAHJ8P3LD-9D91p6gtT1DpmrL=JpuuG8HhtgPpZ7uQELgr0FtrA@mail.gmail.com>
Subject: Re: [PATCH] f2fs: Fix to avoid long time to shrink extent cache
To: Chao Yu <chao@kernel.org>
Cc: Xiuhong Wang <xiuhong.wang.cn@gmail.com>, Xiuhong Wang <xiuhong.wang@unisoc.com>, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, hao_hao.wang@unisoc.com, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=8820=E6=97=A5=E5=
=91=A8=E4=B8=89 16:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/11/20 13:45, Zhiguo Niu wrote:
> > Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=8820=E6=97=A5=
=E5=91=A8=E4=B8=89 11:26=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 2024/11/19 16:26, Zhiguo Niu wrote:
> >>> Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=8819=E6=97=
=A5=E5=91=A8=E4=BA=8C 15:50=E5=86=99=E9=81=93=EF=BC=9A
> >>>>
> >>>> On 2024/11/19 14:46, Xiuhong Wang wrote:
> >>>>> Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=8819=E6=97=
=A5=E5=91=A8=E4=BA=8C 14:05=E5=86=99=E9=81=93=EF=BC=9A
> >>>>>>
> >>>>>> On 2024/11/12 19:06, Xiuhong Wang wrote:
> >>>>>>> We encountered a system hang problem based on the following
> >>>>>>> experiment:
> >>>>>>> There are 17 processes, 8 of which do 4k data read, write and
> >>>>>>> compare tests, and 8 do 64k read, write and compare tests. Each
> >>>>>>> thread writes a 256M file, and another thread writes a large file
> >>>>>>> to 80% of the disk, and then keeps doing read operations, all of
> >>>>>>> which are direct operations. This will cause the large file to be
> >>>>>>> filled to 80% of the disk to be severely fragmented. On a 512GB
> >>>>>>> device, this large file may generate a huge zombie extent tree.
> >>>>>>>
> >>>>>>> When system shutting down, the init process needs to wait for the
> >>>>>>> writeback process, and the writeback process may encounter the
> >>>>>>> situation where the READ_EXTENT_CACHE space is insufficient and
> >>>>>>> needs to free the zombie extent tree. The extent tree has a large
> >>>>>>> number of extent nodes, it will a long free time to free, which
> >>>>>>> triggers system hang.
> >>>>>>     > > The stack when the problem occurs is as follows:
> >>>>>>> crash_arm64> bt 1
> >>>>>>> PID: 1        TASK: ffffff80801a9200  CPU: 1    COMMAND: "init"
> >>>>>>>      #0 [ffffffc00806b9a0] __switch_to at ffffffc00810711c
> >>>>>>>      #1 [ffffffc00806ba00] __schedule at ffffffc0097c1c4c
> >>>>>>>      #2 [ffffffc00806ba60] schedule at ffffffc0097c2308
> >>>>>>>      #3 [ffffffc00806bab0] wb_wait_for_completion at ffffffc00863=
20d4
> >>>>>>>      #4 [ffffffc00806bb20] writeback_inodes_sb at ffffffc00863719=
c
> >>>>>>>      #5 [ffffffc00806bba0] sync_filesystem at ffffffc00863c98c
> >>>>>>>      #6 [ffffffc00806bbc0] f2fs_quota_off_umount at ffffffc00886f=
c60
> >>>>>>>      #7 [ffffffc00806bc20] f2fs_put_super at ffffffc0088715b4
> >>>>>>>      #8 [ffffffc00806bc60] generic_shutdown_super at ffffffc0085c=
d61c
> >>>>>>>      #9 [ffffffc00806bcd0] kill_f2fs_super at ffffffc00886b3dc
> >>>>>>>
> >>>>>>> crash_arm64> bt 14997
> >>>>>>> PID: 14997    TASK: ffffff8119d82400  CPU: 3    COMMAND: "kworker=
/u16:0"
> >>>>>>>      #0 [ffffffc019f8b760] __detach_extent_node at ffffffc0088d5a=
58
> >>>>>>>      #1 [ffffffc019f8b790] __release_extent_node at ffffffc0088d5=
970
> >>>>>>>      #2 [ffffffc019f8b810] f2fs_shrink_extent_tree at ffffffc0088=
d5c7c
> >>>>>>>      #3 [ffffffc019f8b8a0] f2fs_balance_fs_bg at ffffffc0088c109c
> >>>>>>>      #4 [ffffffc019f8b910] f2fs_write_node_pages at ffffffc0088bd=
4d8
> >>>>>>>      #5 [ffffffc019f8b990] do_writepages at ffffffc0084a0b5c
> >>>>>>>      #6 [ffffffc019f8b9f0] __writeback_single_inode at ffffffc008=
62ee28
> >>>>>>>      #7 [ffffffc019f8bb30] writeback_sb_inodes at ffffffc0086358c=
0
> >>>>>>>      #8 [ffffffc019f8bc10] wb_writeback at ffffffc0086362dc
> >>>>>>>      #9 [ffffffc019f8bcc0] wb_do_writeback at ffffffc008634910
> >>>>>>>
> >>>>>>> Process 14997 ran for too long and caused the system hang.
> >>>>>>>
> >>>>>>> At this time, there are still 1086911 extent nodes in this zombie
> >>>>>>> extent tree that need to be cleaned up.
> >>>>>>>
> >>>>>>> crash_arm64_sprd_v8.0.3++> extent_tree.node_cnt ffffff80896cc500
> >>>>>>>       node_cnt =3D {
> >>>>>>>         counter =3D 1086911
> >>>>>>>       },
> >>>>>>>
> >>>>>>> The root cause of this problem is that when the f2fs_balance_fs
> >>>>>>> function is called in the write process, it will determine
> >>>>>>> whether to call f2fs_balance_fs_bg, but it is difficult to
> >>>>>>> meet the condition of excess_cached_nats. When the
> >>>>>>> f2fs_shrink_extent_tree function is called to free during
> >>>>>>> f2fs_write_node_pages, there are too many extent nodes on the
> >>>>>>> extent tree, which causes a loop and causes a system hang.
> >>>>>>>
> >>>>>>> To solve this problem, when calling f2fs_balance_fs, check whethe=
r
> >>>>>>> the extent cache is sufficient. If not, release the zombie extent
> >>>>>>> tree.
> >>>>>>>
> >>>>>>> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> >>>>>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>>>>>> ---
> >>>>>>> Test the problem with the temporary versions:
> >>>>>>> patch did not reproduce the problem, the patch is as follows:
> >>>>>>> @@ -415,7 +415,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi=
, bool need)
> >>>>>>>                     f2fs_stop_checkpoint(sbi, false, STOP_CP_REAS=
ON_FAULT_INJECT);
> >>>>>>>
> >>>>>>>             /* balance_fs_bg is able to be pending */
> >>>>>>> -       if (need && excess_cached_nats(sbi))
> >>>>>>> +       if (need)
> >>>>>>>                     f2fs_balance_fs_bg(sbi, false);
> >>>>>>>
> >>>>>>> ---
> >>>>>>>      fs/f2fs/segment.c | 4 +++-
> >>>>>>>      1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>>>>>> index 1766254279d2..390bec177567 100644
> >>>>>>> --- a/fs/f2fs/segment.c
> >>>>>>> +++ b/fs/f2fs/segment.c
> >>>>>>> @@ -415,7 +415,9 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi=
, bool need)
> >>>>>>>                  f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_=
FAULT_INJECT);
> >>>>>>>
> >>>>>>>          /* balance_fs_bg is able to be pending */
> >>>>>>> -     if (need && excess_cached_nats(sbi))
> >>>>>>> +     if (need && (excess_cached_nats(sbi) ||
> >>>>>>> +                     !f2fs_available_free_memory(sbi, READ_EXTEN=
T_CACHE) ||
> >>>>>>> +                     !f2fs_available_free_memory(sbi, AGE_EXTENT=
_CACHE)))
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> I doubt if there is no enough memory, we may still run into
> >>>>>> f2fs_shrink_extent_tree() and suffer such long time delay.
> >>>>>>
> >>>>>> So, can we just let __free_extent_tree() break the loop once we ha=
ve
> >>>>>> released entries w/ target number? something like this:
> >>>>>>
> >>>>>> ---
> >>>>>>      fs/f2fs/extent_cache.c | 15 ++++++++++-----
> >>>>>>      1 file changed, 10 insertions(+), 5 deletions(-)
> >>>>>>
> >>>>>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> >>>>>> index 019c1f7b7fa5..38c71c1c4fb7 100644
> >>>>>> --- a/fs/f2fs/extent_cache.c
> >>>>>> +++ b/fs/f2fs/extent_cache.c
> >>>>>> @@ -379,11 +379,12 @@ static struct extent_tree *__grab_extent_tre=
e(struct inode *inode,
> >>>>>>      }
> >>>>>>
> >>>>>>      static unsigned int __free_extent_tree(struct f2fs_sb_info *s=
bi,
> >>>>>> -                                       struct extent_tree *et)
> >>>>>> +                               struct extent_tree *et, unsigned i=
nt nr_shrink)
> >>>>>>      {
> >>>>>>            struct rb_node *node, *next;
> >>>>>>            struct extent_node *en;
> >>>>>>            unsigned int count =3D atomic_read(&et->node_cnt);
> >>>>>> +       unsigned int i =3D 0;
> >>>>>>
> >>>>>>            node =3D rb_first_cached(&et->root);
> >>>>>>            while (node) {
> >>>>>> @@ -391,6 +392,9 @@ static unsigned int __free_extent_tree(struct =
f2fs_sb_info *sbi,
> >>>>>>                    en =3D rb_entry(node, struct extent_node, rb_no=
de);
> >>>>>>                    __release_extent_node(sbi, et, en);
> >>>>>>                    node =3D next;
> >>>>>> +
> >>>>>> +               if (nr_shrink && ++i >=3D nr_shrink)
> >>>>>> +                       break;
> >>>>>>            }
> >>>>>>
> >>>>>>            return count - atomic_read(&et->node_cnt);
> >>>>>> @@ -761,7 +765,7 @@ static void __update_extent_tree_range(struct =
inode *inode,
> >>>>>>            }
> >>>>>>
> >>>>>>            if (is_inode_flag_set(inode, FI_NO_EXTENT))
> >>>>>> -               __free_extent_tree(sbi, et);
> >>>>>> +               __free_extent_tree(sbi, et, 0);
> >>>>>>
> >>>>>>            if (et->largest_updated) {
> >>>>>>                    et->largest_updated =3D false;
> >>>>>> @@ -942,7 +946,8 @@ static unsigned int __shrink_extent_tree(struc=
t f2fs_sb_info *sbi, int nr_shrink
> >>>>>>            list_for_each_entry_safe(et, next, &eti->zombie_list, l=
ist) {
> >>>>>>                    if (atomic_read(&et->node_cnt)) {
> >>>>>>                            write_lock(&et->lock);
> >>>>>> -                       node_cnt +=3D __free_extent_tree(sbi, et);
> >>>>>> +                       node_cnt +=3D __free_extent_tree(sbi, et,
> >>>>>> +                                       nr_shrink - node_cnt - tre=
e_cnt);
> >>>>>>                            write_unlock(&et->lock);
> >>>>>>                    }
> >>>>>>                    f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
> >>>>>> @@ -1095,7 +1100,7 @@ static unsigned int __destroy_extent_node(st=
ruct inode *inode,
> >>>>>>                    return 0;
> >>>>>>
> >>>>>>            write_lock(&et->lock);
> >>>>>> -       node_cnt =3D __free_extent_tree(sbi, et);
> >>>>>> +       node_cnt =3D __free_extent_tree(sbi, et, 0);
> >>>>>>            write_unlock(&et->lock);
> >>>>>>
> >>>>>>            return node_cnt;
> >>>>>> @@ -1117,7 +1122,7 @@ static void __drop_extent_tree(struct inode =
*inode, enum extent_type type)
> >>>>>>                    return;
> >>>>>>
> >>>>>>            write_lock(&et->lock);
> >>>>>> -       __free_extent_tree(sbi, et);
> >>>>>> +       __free_extent_tree(sbi, et, 0);
> >>>>>>            if (type =3D=3D EX_READ) {
> >>>>>>                    set_inode_flag(inode, FI_NO_EXTENT);
> >>>>>>                    if (et->largest.len) {
> >>>>>> --
> >>>>>> 2.40.1
> >>>>>>
> >>>>>> Thanks,
> >>>>>>
> >>>>>>>                  f2fs_balance_fs_bg(sbi, false);
> >>>>>>>
> >>>>>>>          if (!f2fs_is_checkpoint_ready(sbi))
> >>>>>>
> >>>>>
> >>>>>
> >>>>> Hi chao,
> >>>>>
> >>>>> We have also considered this approach, but the problem still occurs
> >>>>> after retesting.
> >>>>> 1. The problem still occurs in the following call of the unmount da=
ta process.
> >>>>> f2fs_put_super -> f2fs_leave_shrinker
> >>>>
> >>>> Yes, I guess we need to fix this path as well, however, your patch d=
idn't
> >>>> cover this path as well, am I missing something?
> >>> Dear Chao,
> >>> This patch version aim  to shrink extent cache as early as possible o=
n
> >>> the  "all write path"
> >>> by "write action" -> f2fs_balance_fs -> f2fs_balance_fs_bg
> >>
> >> Zhiguo, thanks for explaining again.
> >>
> > Dear Chao,
> >> However, I doubt covering all write paths is not enough, because exten=
t
> >> node can increase when f2fs_precache_extents() was called from paths
> >> including fadvise/fiemap/swapon/ioc_precache_extents, and there may be
> >> no writeback, so we may get no chance to call into f2fs_balance_fs_bg(=
),
> >> e.g. there is no data update in mountpoint, or mountpoint is readonly.
> > yes, Indeed it is.
> >>
> >>> As the comment , the "excess_cached_nats" is difficult to achieve in
> >>> this scenario, and
> >>
> >> Another concern is, in high-end products w/ more memory, it may has le=
ss
> >> chance to hit newly added condition in f2fs_balance_fs()? not sure tho=
ugh.
> > I also agree with this.
> > There is no other better idea for me(^^) excpetion for the two methods
> > we discussed above.
> > any good suggestions ? ^^
>
Dear Chao,
It is good solution to limit the maximum extent count of each inode.
> What do you think of this?
>
>  From 8646c28027d5b050938335066ab56abbeca799e7 Mon Sep 17 00:00:00 2001
> From: Chao Yu <chao@kernel.org>
> Date: Tue, 19 Nov 2024 11:53:09 +0800
> Subject: [PATCH 1/2] f2fs: fix to shrink read extent node in batches
>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   fs/f2fs/extent_cache.c | 64 ++++++++++++++++++++++++------------------
>   1 file changed, 37 insertions(+), 27 deletions(-)
>
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 019c1f7b7fa5..0c0d05f8551a 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -379,21 +379,22 @@ static struct extent_tree *__grab_extent_tree(struc=
t inode *inode,
>   }
>
>   static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
> -                                       struct extent_tree *et)
> +                               struct extent_tree *et, unsigned int nr_s=
hrink)
>   {
>         struct rb_node *node, *next;
>         struct extent_node *en;
> -       unsigned int count =3D atomic_read(&et->node_cnt);
> +       unsigned int count;
>
>         node =3D rb_first_cached(&et->root);
> -       while (node) {
> +
> +       for (count =3D 0; node && count < nr_shrink; count++) {
>                 next =3D rb_next(node);
>                 en =3D rb_entry(node, struct extent_node, rb_node);
>                 __release_extent_node(sbi, et, en);
>                 node =3D next;
>         }
>
> -       return count - atomic_read(&et->node_cnt);
> +       return count;
>   }
>
>   static void __drop_largest_extent(struct extent_tree *et,
> @@ -622,6 +623,30 @@ static struct extent_node *__insert_extent_tree(stru=
ct f2fs_sb_info *sbi,
>         return en;
>   }
>
> +static unsigned int __destroy_extent_node(struct inode *inode,
> +                                       enum extent_type type)
> +{
> +       struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> +       struct extent_tree *et =3D F2FS_I(inode)->extent_tree[type];
> +       unsigned int nr_shrink =3D type =3D=3D EX_READ ?
> +                               READ_EXTENT_CACHE_SHRINK_NUMBER :
> +                               AGE_EXTENT_CACHE_SHRINK_NUMBER;
> +       unsigned int node_cnt =3D 0;
> +
> +       if (!et || !atomic_read(&et->node_cnt))
> +               return 0;
> +
> +       while (atomic_read(&et->node_cnt)) {
> +               write_lock(&et->lock);
> +               node_cnt =3D __free_extent_tree(sbi, et, nr_shrink);
should be:  node_cnt +=3D __free_extent_tree(sbi, et, nr_shrink); ??
> +               write_unlock(&et->lock);
> +       }
> +
> +       f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
> +
> +       return node_cnt;
> +}
> +
>   static void __update_extent_tree_range(struct inode *inode,
>                         struct extent_info *tei, enum extent_type type)
>   {
> @@ -760,9 +785,6 @@ static void __update_extent_tree_range(struct inode *=
inode,
>                 }
>         }
>
> -       if (is_inode_flag_set(inode, FI_NO_EXTENT))
> -               __free_extent_tree(sbi, et);
> -
>         if (et->largest_updated) {
>                 et->largest_updated =3D false;
>                 updated =3D true;
> @@ -780,6 +802,9 @@ static void __update_extent_tree_range(struct inode *=
inode,
>   out_read_extent_cache:
>         write_unlock(&et->lock);
>
> +       if (is_inode_flag_set(inode, FI_NO_EXTENT))
> +               __destroy_extent_node(inode, EX_READ);
> +
>         if (updated)
>                 f2fs_mark_inode_dirty_sync(inode, true);
>   }
> @@ -942,7 +967,8 @@ static unsigned int __shrink_extent_tree(struct f2fs_=
sb_info *sbi, int nr_shrink
>         list_for_each_entry_safe(et, next, &eti->zombie_list, list) {
>                 if (atomic_read(&et->node_cnt)) {
>                         write_lock(&et->lock);
> -                       node_cnt +=3D __free_extent_tree(sbi, et);
> +                       node_cnt +=3D __free_extent_tree(sbi, et,
> +                                       nr_shrink - node_cnt - tree_cnt);
>                         write_unlock(&et->lock);
>                 }
>                 f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
this f2fs_bug_on statment should be removed or omited?
and the following free tree action can not be do if
atomic_read(&et->node_cnt) !=3D0 ?
thanks!
> @@ -1084,23 +1110,6 @@ unsigned int f2fs_shrink_age_extent_tree(struct f2=
fs_sb_info *sbi, int nr_shrink
>         return __shrink_extent_tree(sbi, nr_shrink, EX_BLOCK_AGE);
>   }
>
> -static unsigned int __destroy_extent_node(struct inode *inode,
> -                                       enum extent_type type)
> -{
> -       struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> -       struct extent_tree *et =3D F2FS_I(inode)->extent_tree[type];
> -       unsigned int node_cnt =3D 0;
> -
> -       if (!et || !atomic_read(&et->node_cnt))
> -               return 0;
> -
> -       write_lock(&et->lock);
> -       node_cnt =3D __free_extent_tree(sbi, et);
> -       write_unlock(&et->lock);
> -
> -       return node_cnt;
> -}
> -
>   void f2fs_destroy_extent_node(struct inode *inode)
>   {
>         __destroy_extent_node(inode, EX_READ);
> @@ -1109,7 +1118,6 @@ void f2fs_destroy_extent_node(struct inode *inode)
>
>   static void __drop_extent_tree(struct inode *inode, enum extent_type ty=
pe)
>   {
> -       struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
>         struct extent_tree *et =3D F2FS_I(inode)->extent_tree[type];
>         bool updated =3D false;
>
> @@ -1117,7 +1125,6 @@ static void __drop_extent_tree(struct inode *inode,=
 enum extent_type type)
>                 return;
>
>         write_lock(&et->lock);
> -       __free_extent_tree(sbi, et);
>         if (type =3D=3D EX_READ) {
>                 set_inode_flag(inode, FI_NO_EXTENT);
>                 if (et->largest.len) {
> @@ -1126,6 +1133,9 @@ static void __drop_extent_tree(struct inode *inode,=
 enum extent_type type)
>                 }
>         }
>         write_unlock(&et->lock);
> +
> +       __destroy_extent_node(inode, type);
> +
>         if (updated)
>                 f2fs_mark_inode_dirty_sync(inode, true);
>   }
> --
> 2.40.1
>
>  From 3a1b7ec606d6211b2eaf72d148ebe52d38a0bf59 Mon Sep 17 00:00:00 2001
> From: Chao Yu <chao@kernel.org>
> Date: Wed, 20 Nov 2024 15:37:22 +0800
> Subject: [PATCH 2/2] f2fs: add a sysfs node to limit max read extent coun=
t
>   per-inode
>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
>   fs/f2fs/extent_cache.c                  | 5 ++++-
>   fs/f2fs/f2fs.h                          | 4 ++++
>   fs/f2fs/sysfs.c                         | 7 +++++++
>   4 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/=
testing/sysfs-fs-f2fs
> index 513296bb6f29..3e1630c70d8a 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -822,3 +822,9 @@ Description:        It controls the valid block ratio=
 threshold not to trigger excessiv
>                 for zoned deivces. The initial value of it is 95(%). F2FS=
 will stop the
>                 background GC thread from intiating GC for sections havin=
g valid blocks
>                 exceeding the ratio.
> +
> +What:          /sys/fs/f2fs/<disk>/max_read_extent_count
> +Date:          November 2024
> +Contact:       "Chao Yu" <chao@kernel.org>
> +Description:   It controls max read extent count for per-inode, the valu=
e of threshold
> +               is 10240 by default.
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 0c0d05f8551a..b08563ad010d 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -717,7 +717,9 @@ static void __update_extent_tree_range(struct inode *=
inode,
>                 }
>
>                 if (end < org_end && (type !=3D EX_READ ||
> -                               org_end - end >=3D F2FS_MIN_EXTENT_LEN)) =
{
> +                       (org_end - end >=3D F2FS_MIN_EXTENT_LEN &&
> +                       atomic_read(&et->node_cnt) <
> +                                       sbi->max_read_extent_count))) {
>                         if (parts) {
>                                 __set_extent_info(&ei,
>                                         end, org_end - end,
> @@ -1209,6 +1211,7 @@ void f2fs_init_extent_cache_info(struct f2fs_sb_inf=
o *sbi)
>         sbi->hot_data_age_threshold =3D DEF_HOT_DATA_AGE_THRESHOLD;
>         sbi->warm_data_age_threshold =3D DEF_WARM_DATA_AGE_THRESHOLD;
>         sbi->last_age_weight =3D LAST_AGE_WEIGHT;
> +       sbi->max_read_extent_count =3D DEF_MAX_READ_EXTENT_COUNT;
>   }
>
>   int __init f2fs_create_extent_cache(void)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b65b023a588a..6f2cbf4c5740 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -635,6 +635,9 @@ enum {
>   #define DEF_HOT_DATA_AGE_THRESHOLD    262144
>   #define DEF_WARM_DATA_AGE_THRESHOLD   2621440
>
> +/* default max read extent count per inode */
> +#define DEF_MAX_READ_EXTENT_COUNT      10240
> +
>   /* extent cache type */
>   enum extent_type {
>         EX_READ,
> @@ -1619,6 +1622,7 @@ struct f2fs_sb_info {
>         /* for extent tree cache */
>         struct extent_tree_info extent_tree[NR_EXTENT_CACHES];
>         atomic64_t allocated_data_blocks;       /* for block age extent_c=
ache */
> +       unsigned int max_read_extent_count;     /* max read extent count =
per inode */
>
>         /* The threshold used for hot and warm data seperation*/
>         unsigned int hot_data_age_threshold;
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index bdbf24db667b..d1356c656cac 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -787,6 +787,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>                 return count;
>         }
>
> +       if (!strcmp(a->attr.name, "max_read_extent_count")) {
> +               if (t > UINT_MAX)
> +                       return -EINVAL;
> +               *ui =3D (unsigned int)t;
> +               return count;
> +       }
> +
>         if (!strcmp(a->attr.name, "ipu_policy")) {
>                 if (t >=3D BIT(F2FS_IPU_MAX))
>                         return -EINVAL;
> --
> 2.40.1
>
>
>
> > thanks=EF=BC=81
> >>
> >> +     if (need && (excess_cached_nats(sbi) ||
> >> +                     !f2fs_available_free_memory(sbi, READ_EXTENT_CAC=
HE) ||
> >> +                     !f2fs_available_free_memory(sbi, AGE_EXTENT_CACH=
E)))
> >>
> >> I mean will f2fs_available_free_memory(sbi, {READ,AGE}_EXTENT_CACHE)
> >> return true if available memory is sufficient?
> >>
> >> Thanks,
> >>
> >>> trigger the issue in path f2fs_write_node_pages->f2fs_balance_fs_bg(i=
s
> >>> called directly here).
> >>> At that time, there were already a lot of extent node cnt.
> >>> Thanks!
> >>>>
> >>>>> 2. Writing back the inode in the normal write-back process will
> >>>>> release the extent cache, and the problem still occurs. The stack i=
s
> >>>>> as follows:
> >>>>
> >>>> Ditto,
> >>>>
> >>>> Thanks,
> >>>>
> >>>>> [H 103098.974356] c2 [<ffffffc008aee8a4>] (rb_erase+0x204/0x334)
> >>>>> [H 103098.974389] c2 [<ffffffc0088f8fd0>] (__release_extent_node+0x=
c8/0x168)
> >>>>> [H 103098.974425] c2 [<ffffffc0088fad74>]
> >>>>> (f2fs_update_extent_tree_range+0x4a0/0x724)
> >>>>> [H 103098.974459] c2 [<ffffffc0088fa8c0>] (f2fs_update_extent_cache=
+0x19c/0x1b0)
> >>>>> [H 103098.974495] c2 [<ffffffc0088edc70>] (f2fs_outplace_write_data=
+0x74/0xf0)
> >>>>> [H 103098.974525] c2 [<ffffffc0088ca834>] (f2fs_do_write_data_page+=
0x3e4/0x6c8)
> >>>>> [H 103098.974552] c2 [<ffffffc0088cb150>]
> >>>>> (f2fs_write_single_data_page+0x478/0xab0)
> >>>>> [H 103098.974574] c2 [<ffffffc0088d0bd0>] (f2fs_write_cache_pages+0=
x454/0xaac)
> >>>>> [H 103098.974596] c2 [<ffffffc0088d0698>] (__f2fs_write_data_pages+=
0x40c/0x4f0)
> >>>>> [H 103098.974617] c2 [<ffffffc0088cc860>] (f2fs_write_data_pages+0x=
30/0x40)
> >>>>> [H 103098.974645] c2 [<ffffffc0084c0e00>] (do_writepages+0x18c/0x3e=
8)
> >>>>> [H 103098.974678] c2 [<ffffffc0086503cc>] (__writeback_single_inode=
+0x48/0x498)
> >>>>> [H 103098.974720] c2 [<ffffffc0086562c8>] (writeback_sb_inodes+0x45=
4/0x9b0)
> >>>>> [H 103098.974754] c2 [<ffffffc008655de8>] (__writeback_inodes_wb+0x=
198/0x224)
> >>>>> [H 103098.974788] c2 [<ffffffc008656d0c>] (wb_writeback+0x1c0/0x698=
)
> >>>>> [H 103098.974819] c2 [<ffffffc008655614>] (wb_do_writeback+0x420/0x=
54c)
> >>>>> [H 103098.974853] c2 [<ffffffc008654f50>] (wb_workfn+0xe4/0x388)
> >>>>
> >>
>

