Return-Path: <linux-kernel+bounces-415234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8463B9D333E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 06:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43083283A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 05:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34146156F2B;
	Wed, 20 Nov 2024 05:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDoZbLvj"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1334920B22
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 05:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732081539; cv=none; b=gK6cv6IzxeYESzSZNa2Ajkf69v5VEhxopIdTjQ6bIyc7DtUYNMKsEZVMbYJOLq/pfATl8xpWOE6UyW2cp1bbIqaADWZNcBu9G5S97Vo0K6m9Gc7RoQSLfJ/o0uiqngqyZqHSYyZMueCu6uzYfnIiwl8Pmzvjv19GWS5lygus+n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732081539; c=relaxed/simple;
	bh=P9Hm7MEdht0GkcepV91wVCpX4S7oeFpgelF+cCCWb5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyfvpC/HRN7lbG0Y46HAX556mk7GzbhppJEK88IicdJflT/hCpAapFZ7+/m0kQ10o4ECtJ0N5BmimOVJMtmZXMyZfTvsxBH4wKjvE3/TDoIjp+Fpa5Rjv3YNVTEThI43HQnMSjpz+CaKXxJ/bMfdXXYHb4k6dlIRrInYTj1najk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDoZbLvj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315855ec58so7302855e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 21:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732081535; x=1732686335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKkfR2xq8tOGKFIo0uBWNHo7cXRr2NkLQXqpwRPPoFA=;
        b=WDoZbLvjdy+9rJzrx4vURbRtm2Q71dSn/h1sx0LURjA4dXxDiMPll65R7jc04pMvQo
         QFPUfPb2Gz9dd7eaNuvW2wMz731aAdubHjdNYEg2gbEUqoPdC+6TVfDZknammYko+bxd
         Pa0J5Svrg3zPOH1k2R2RHxDBf5L3s8K8e17VHHhWnP1nk9gUaDaO7I7Z2VUvTOIAjhxj
         n2cRA3iZ63Nj2Qh9WmQ7OdtP85fTfLHoGDd3T0jPsk3COVp5D1j6unHAMnMUICQMUWzt
         j4ROxseSwyh8tL8YWFC6rzfKxEiME+b++WHzw3YnRGehsZTc279cv/xJLIdn87L7g8GP
         Clbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732081535; x=1732686335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKkfR2xq8tOGKFIo0uBWNHo7cXRr2NkLQXqpwRPPoFA=;
        b=MLZFgbpTq4AE+7cUe2QCk1JSr99fhQPuHyFtlOec2CNAPfjYA4wT4V9/e6iGxVlVQk
         BKeWFghOdR9kpKUEdj9s63BrAQ7QxMDU01y3cflvDN+hX8JG//+S4xJ/qAyMj3f6/OLC
         z84GskTgpjW3Cc/zbS6iQVMjwc75+o9WS1wAM2sLJzmZJWP4uj5jM+5x6PU8o/X2lcQp
         bt4eWhhcjWlSNDKBmR3m3peMpe73WebtT3O0qe8lymw+PxCoyz/qBEuNPG3WJIdF0jnP
         BtE/ubQwd8imzojkbjQpS7UoBCQL/vrCZWQmtbzIpEa7TCjk8NoQZn1xKKv6eONdga26
         FMZw==
X-Forwarded-Encrypted: i=1; AJvYcCUXZbSJjr95NbIPsG/xeH67xbTJeHdyFNLOf1Fx1T6cjZnvlaIz0nKzAsSD4LL3B3liGIgv9PSDVhuF6MI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg7yHP8fDJz2Ae2bkzwpeiV6TWw7IYYQgrhQsODgLlQq50Fzuf
	KVIdjbmH5xUoH3BtEak6kK6bpEf2XxNnNp3ZQBxWJ8Mfr+RPz8l/1oigkZO/n9RSGj8GK1mjdBo
	1lzj9yhG20SIe7s9Fsy7jhxVmsCt8PIUi
X-Gm-Gg: ASbGncsM9tCDbsdkiELfvpnfs+xSMJ4JOLA8aLnonGnqdR/ud9pg6uU3NtOnyL4/2zy
	Px3NUWd8sN6Lx59BXA1ABVKy2nC8tNvSx
X-Google-Smtp-Source: AGHT+IE9+fNqB3SD6B9SB2D58HneDXUTUgLp0Tb82wQov+6QPMa5SWYo9vyiur1mNcuOmisug9kvv2GBX4byYbrmC5g=
X-Received: by 2002:a05:6000:2a5:b0:382:42c3:83f7 with SMTP id
 ffacd0b85a97d-38254b0f088mr359036f8f.10.1732081535048; Tue, 19 Nov 2024
 21:45:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112110627.1314632-1-xiuhong.wang@unisoc.com>
 <fb436fdb-a4eb-49cc-a730-354611e88b21@kernel.org> <CAOsHCa1t+LeeAG2PDJ0BfYtoh_+CUmLjZcp1+dGZWR5PPfmFSQ@mail.gmail.com>
 <5b0c17da-f1e1-490d-a560-3312bc8c3247@kernel.org> <CAHJ8P3+dqhsNOy6-jvPaazSSOk7V9pEkQmamE48oLgGK1ORHfg@mail.gmail.com>
 <65b89566-1038-4422-9e2e-4d7da26dd1c7@kernel.org>
In-Reply-To: <65b89566-1038-4422-9e2e-4d7da26dd1c7@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 20 Nov 2024 13:45:23 +0800
Message-ID: <CAHJ8P3+SzZ-_8dsg7GkjLDqiWB6G6b+c8+EJku5eaMkxmf=ZVg@mail.gmail.com>
Subject: Re: [PATCH] f2fs: Fix to avoid long time to shrink extent cache
To: Chao Yu <chao@kernel.org>
Cc: Xiuhong Wang <xiuhong.wang.cn@gmail.com>, Xiuhong Wang <xiuhong.wang@unisoc.com>, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, hao_hao.wang@unisoc.com, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=8820=E6=97=A5=E5=
=91=A8=E4=B8=89 11:26=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/11/19 16:26, Zhiguo Niu wrote:
> > Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=8819=E6=97=A5=
=E5=91=A8=E4=BA=8C 15:50=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 2024/11/19 14:46, Xiuhong Wang wrote:
> >>> Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=8819=E6=97=
=A5=E5=91=A8=E4=BA=8C 14:05=E5=86=99=E9=81=93=EF=BC=9A
> >>>>
> >>>> On 2024/11/12 19:06, Xiuhong Wang wrote:
> >>>>> We encountered a system hang problem based on the following
> >>>>> experiment:
> >>>>> There are 17 processes, 8 of which do 4k data read, write and
> >>>>> compare tests, and 8 do 64k read, write and compare tests. Each
> >>>>> thread writes a 256M file, and another thread writes a large file
> >>>>> to 80% of the disk, and then keeps doing read operations, all of
> >>>>> which are direct operations. This will cause the large file to be
> >>>>> filled to 80% of the disk to be severely fragmented. On a 512GB
> >>>>> device, this large file may generate a huge zombie extent tree.
> >>>>>
> >>>>> When system shutting down, the init process needs to wait for the
> >>>>> writeback process, and the writeback process may encounter the
> >>>>> situation where the READ_EXTENT_CACHE space is insufficient and
> >>>>> needs to free the zombie extent tree. The extent tree has a large
> >>>>> number of extent nodes, it will a long free time to free, which
> >>>>> triggers system hang.
> >>>>    > > The stack when the problem occurs is as follows:
> >>>>> crash_arm64> bt 1
> >>>>> PID: 1        TASK: ffffff80801a9200  CPU: 1    COMMAND: "init"
> >>>>>     #0 [ffffffc00806b9a0] __switch_to at ffffffc00810711c
> >>>>>     #1 [ffffffc00806ba00] __schedule at ffffffc0097c1c4c
> >>>>>     #2 [ffffffc00806ba60] schedule at ffffffc0097c2308
> >>>>>     #3 [ffffffc00806bab0] wb_wait_for_completion at ffffffc0086320d=
4
> >>>>>     #4 [ffffffc00806bb20] writeback_inodes_sb at ffffffc00863719c
> >>>>>     #5 [ffffffc00806bba0] sync_filesystem at ffffffc00863c98c
> >>>>>     #6 [ffffffc00806bbc0] f2fs_quota_off_umount at ffffffc00886fc60
> >>>>>     #7 [ffffffc00806bc20] f2fs_put_super at ffffffc0088715b4
> >>>>>     #8 [ffffffc00806bc60] generic_shutdown_super at ffffffc0085cd61=
c
> >>>>>     #9 [ffffffc00806bcd0] kill_f2fs_super at ffffffc00886b3dc
> >>>>>
> >>>>> crash_arm64> bt 14997
> >>>>> PID: 14997    TASK: ffffff8119d82400  CPU: 3    COMMAND: "kworker/u=
16:0"
> >>>>>     #0 [ffffffc019f8b760] __detach_extent_node at ffffffc0088d5a58
> >>>>>     #1 [ffffffc019f8b790] __release_extent_node at ffffffc0088d5970
> >>>>>     #2 [ffffffc019f8b810] f2fs_shrink_extent_tree at ffffffc0088d5c=
7c
> >>>>>     #3 [ffffffc019f8b8a0] f2fs_balance_fs_bg at ffffffc0088c109c
> >>>>>     #4 [ffffffc019f8b910] f2fs_write_node_pages at ffffffc0088bd4d8
> >>>>>     #5 [ffffffc019f8b990] do_writepages at ffffffc0084a0b5c
> >>>>>     #6 [ffffffc019f8b9f0] __writeback_single_inode at ffffffc00862e=
e28
> >>>>>     #7 [ffffffc019f8bb30] writeback_sb_inodes at ffffffc0086358c0
> >>>>>     #8 [ffffffc019f8bc10] wb_writeback at ffffffc0086362dc
> >>>>>     #9 [ffffffc019f8bcc0] wb_do_writeback at ffffffc008634910
> >>>>>
> >>>>> Process 14997 ran for too long and caused the system hang.
> >>>>>
> >>>>> At this time, there are still 1086911 extent nodes in this zombie
> >>>>> extent tree that need to be cleaned up.
> >>>>>
> >>>>> crash_arm64_sprd_v8.0.3++> extent_tree.node_cnt ffffff80896cc500
> >>>>>      node_cnt =3D {
> >>>>>        counter =3D 1086911
> >>>>>      },
> >>>>>
> >>>>> The root cause of this problem is that when the f2fs_balance_fs
> >>>>> function is called in the write process, it will determine
> >>>>> whether to call f2fs_balance_fs_bg, but it is difficult to
> >>>>> meet the condition of excess_cached_nats. When the
> >>>>> f2fs_shrink_extent_tree function is called to free during
> >>>>> f2fs_write_node_pages, there are too many extent nodes on the
> >>>>> extent tree, which causes a loop and causes a system hang.
> >>>>>
> >>>>> To solve this problem, when calling f2fs_balance_fs, check whether
> >>>>> the extent cache is sufficient. If not, release the zombie extent
> >>>>> tree.
> >>>>>
> >>>>> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> >>>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>>>> ---
> >>>>> Test the problem with the temporary versions:
> >>>>> patch did not reproduce the problem, the patch is as follows:
> >>>>> @@ -415,7 +415,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, =
bool need)
> >>>>>                    f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_=
FAULT_INJECT);
> >>>>>
> >>>>>            /* balance_fs_bg is able to be pending */
> >>>>> -       if (need && excess_cached_nats(sbi))
> >>>>> +       if (need)
> >>>>>                    f2fs_balance_fs_bg(sbi, false);
> >>>>>
> >>>>> ---
> >>>>>     fs/f2fs/segment.c | 4 +++-
> >>>>>     1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>>>> index 1766254279d2..390bec177567 100644
> >>>>> --- a/fs/f2fs/segment.c
> >>>>> +++ b/fs/f2fs/segment.c
> >>>>> @@ -415,7 +415,9 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, =
bool need)
> >>>>>                 f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_FAU=
LT_INJECT);
> >>>>>
> >>>>>         /* balance_fs_bg is able to be pending */
> >>>>> -     if (need && excess_cached_nats(sbi))
> >>>>> +     if (need && (excess_cached_nats(sbi) ||
> >>>>> +                     !f2fs_available_free_memory(sbi, READ_EXTENT_=
CACHE) ||
> >>>>> +                     !f2fs_available_free_memory(sbi, AGE_EXTENT_C=
ACHE)))
> >>>>
> >>>> Hi,
> >>>>
> >>>> I doubt if there is no enough memory, we may still run into
> >>>> f2fs_shrink_extent_tree() and suffer such long time delay.
> >>>>
> >>>> So, can we just let __free_extent_tree() break the loop once we have
> >>>> released entries w/ target number? something like this:
> >>>>
> >>>> ---
> >>>>     fs/f2fs/extent_cache.c | 15 ++++++++++-----
> >>>>     1 file changed, 10 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> >>>> index 019c1f7b7fa5..38c71c1c4fb7 100644
> >>>> --- a/fs/f2fs/extent_cache.c
> >>>> +++ b/fs/f2fs/extent_cache.c
> >>>> @@ -379,11 +379,12 @@ static struct extent_tree *__grab_extent_tree(=
struct inode *inode,
> >>>>     }
> >>>>
> >>>>     static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
> >>>> -                                       struct extent_tree *et)
> >>>> +                               struct extent_tree *et, unsigned int=
 nr_shrink)
> >>>>     {
> >>>>           struct rb_node *node, *next;
> >>>>           struct extent_node *en;
> >>>>           unsigned int count =3D atomic_read(&et->node_cnt);
> >>>> +       unsigned int i =3D 0;
> >>>>
> >>>>           node =3D rb_first_cached(&et->root);
> >>>>           while (node) {
> >>>> @@ -391,6 +392,9 @@ static unsigned int __free_extent_tree(struct f2=
fs_sb_info *sbi,
> >>>>                   en =3D rb_entry(node, struct extent_node, rb_node)=
;
> >>>>                   __release_extent_node(sbi, et, en);
> >>>>                   node =3D next;
> >>>> +
> >>>> +               if (nr_shrink && ++i >=3D nr_shrink)
> >>>> +                       break;
> >>>>           }
> >>>>
> >>>>           return count - atomic_read(&et->node_cnt);
> >>>> @@ -761,7 +765,7 @@ static void __update_extent_tree_range(struct in=
ode *inode,
> >>>>           }
> >>>>
> >>>>           if (is_inode_flag_set(inode, FI_NO_EXTENT))
> >>>> -               __free_extent_tree(sbi, et);
> >>>> +               __free_extent_tree(sbi, et, 0);
> >>>>
> >>>>           if (et->largest_updated) {
> >>>>                   et->largest_updated =3D false;
> >>>> @@ -942,7 +946,8 @@ static unsigned int __shrink_extent_tree(struct =
f2fs_sb_info *sbi, int nr_shrink
> >>>>           list_for_each_entry_safe(et, next, &eti->zombie_list, list=
) {
> >>>>                   if (atomic_read(&et->node_cnt)) {
> >>>>                           write_lock(&et->lock);
> >>>> -                       node_cnt +=3D __free_extent_tree(sbi, et);
> >>>> +                       node_cnt +=3D __free_extent_tree(sbi, et,
> >>>> +                                       nr_shrink - node_cnt - tree_=
cnt);
> >>>>                           write_unlock(&et->lock);
> >>>>                   }
> >>>>                   f2fs_bug_on(sbi, atomic_read(&et->node_cnt));
> >>>> @@ -1095,7 +1100,7 @@ static unsigned int __destroy_extent_node(stru=
ct inode *inode,
> >>>>                   return 0;
> >>>>
> >>>>           write_lock(&et->lock);
> >>>> -       node_cnt =3D __free_extent_tree(sbi, et);
> >>>> +       node_cnt =3D __free_extent_tree(sbi, et, 0);
> >>>>           write_unlock(&et->lock);
> >>>>
> >>>>           return node_cnt;
> >>>> @@ -1117,7 +1122,7 @@ static void __drop_extent_tree(struct inode *i=
node, enum extent_type type)
> >>>>                   return;
> >>>>
> >>>>           write_lock(&et->lock);
> >>>> -       __free_extent_tree(sbi, et);
> >>>> +       __free_extent_tree(sbi, et, 0);
> >>>>           if (type =3D=3D EX_READ) {
> >>>>                   set_inode_flag(inode, FI_NO_EXTENT);
> >>>>                   if (et->largest.len) {
> >>>> --
> >>>> 2.40.1
> >>>>
> >>>> Thanks,
> >>>>
> >>>>>                 f2fs_balance_fs_bg(sbi, false);
> >>>>>
> >>>>>         if (!f2fs_is_checkpoint_ready(sbi))
> >>>>
> >>>
> >>>
> >>> Hi chao,
> >>>
> >>> We have also considered this approach, but the problem still occurs
> >>> after retesting.
> >>> 1. The problem still occurs in the following call of the unmount data=
 process.
> >>> f2fs_put_super -> f2fs_leave_shrinker
> >>
> >> Yes, I guess we need to fix this path as well, however, your patch did=
n't
> >> cover this path as well, am I missing something?
> > Dear Chao,
> > This patch version aim  to shrink extent cache as early as possible on
> > the  "all write path"
> > by "write action" -> f2fs_balance_fs -> f2fs_balance_fs_bg
>
> Zhiguo, thanks for explaining again.
>
Dear Chao,
> However, I doubt covering all write paths is not enough, because extent
> node can increase when f2fs_precache_extents() was called from paths
> including fadvise/fiemap/swapon/ioc_precache_extents, and there may be
> no writeback, so we may get no chance to call into f2fs_balance_fs_bg(),
> e.g. there is no data update in mountpoint, or mountpoint is readonly.
yes, Indeed it is.
>
> > As the comment , the "excess_cached_nats" is difficult to achieve in
> > this scenario, and
>
> Another concern is, in high-end products w/ more memory, it may has less
> chance to hit newly added condition in f2fs_balance_fs()? not sure though=
.
I also agree with this.
There is no other better idea for me(^^) excpetion for the two methods
we discussed above.
any good suggestions ? ^^
thanks=EF=BC=81
>
> +     if (need && (excess_cached_nats(sbi) ||
> +                     !f2fs_available_free_memory(sbi, READ_EXTENT_CACHE)=
 ||
> +                     !f2fs_available_free_memory(sbi, AGE_EXTENT_CACHE))=
)
>
> I mean will f2fs_available_free_memory(sbi, {READ,AGE}_EXTENT_CACHE)
> return true if available memory is sufficient?
>
> Thanks,
>
> > trigger the issue in path f2fs_write_node_pages->f2fs_balance_fs_bg(is
> > called directly here).
> > At that time, there were already a lot of extent node cnt.
> > Thanks!
> >>
> >>> 2. Writing back the inode in the normal write-back process will
> >>> release the extent cache, and the problem still occurs. The stack is
> >>> as follows:
> >>
> >> Ditto,
> >>
> >> Thanks,
> >>
> >>> [H 103098.974356] c2 [<ffffffc008aee8a4>] (rb_erase+0x204/0x334)
> >>> [H 103098.974389] c2 [<ffffffc0088f8fd0>] (__release_extent_node+0xc8=
/0x168)
> >>> [H 103098.974425] c2 [<ffffffc0088fad74>]
> >>> (f2fs_update_extent_tree_range+0x4a0/0x724)
> >>> [H 103098.974459] c2 [<ffffffc0088fa8c0>] (f2fs_update_extent_cache+0=
x19c/0x1b0)
> >>> [H 103098.974495] c2 [<ffffffc0088edc70>] (f2fs_outplace_write_data+0=
x74/0xf0)
> >>> [H 103098.974525] c2 [<ffffffc0088ca834>] (f2fs_do_write_data_page+0x=
3e4/0x6c8)
> >>> [H 103098.974552] c2 [<ffffffc0088cb150>]
> >>> (f2fs_write_single_data_page+0x478/0xab0)
> >>> [H 103098.974574] c2 [<ffffffc0088d0bd0>] (f2fs_write_cache_pages+0x4=
54/0xaac)
> >>> [H 103098.974596] c2 [<ffffffc0088d0698>] (__f2fs_write_data_pages+0x=
40c/0x4f0)
> >>> [H 103098.974617] c2 [<ffffffc0088cc860>] (f2fs_write_data_pages+0x30=
/0x40)
> >>> [H 103098.974645] c2 [<ffffffc0084c0e00>] (do_writepages+0x18c/0x3e8)
> >>> [H 103098.974678] c2 [<ffffffc0086503cc>] (__writeback_single_inode+0=
x48/0x498)
> >>> [H 103098.974720] c2 [<ffffffc0086562c8>] (writeback_sb_inodes+0x454/=
0x9b0)
> >>> [H 103098.974754] c2 [<ffffffc008655de8>] (__writeback_inodes_wb+0x19=
8/0x224)
> >>> [H 103098.974788] c2 [<ffffffc008656d0c>] (wb_writeback+0x1c0/0x698)
> >>> [H 103098.974819] c2 [<ffffffc008655614>] (wb_do_writeback+0x420/0x54=
c)
> >>> [H 103098.974853] c2 [<ffffffc008654f50>] (wb_workfn+0xe4/0x388)
> >>
>

