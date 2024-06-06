Return-Path: <linux-kernel+bounces-203610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF988FDDE6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 06:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C553C1C233F3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 04:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF4328373;
	Thu,  6 Jun 2024 04:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6ftpFwm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22B81EB3E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 04:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717649390; cv=none; b=cEHauzdwNvpTTyCssYgalapj5vhhYwtLN1srQ9CVu2CC4kNLNZLz+EJSbFk2xxkgYbt0C5aqfElLZ/xY7DwW0irDr8LCP0/LcKo9FI6UYIRPKoZif7/2gNmhVbi6kPJIXfIKT2IFqs7yg3Jp2zddegRkz6mN42PRxlD9AIN6Mcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717649390; c=relaxed/simple;
	bh=XSSuH4Gi9VGhDJPg74B25Nay3I9Fe8bZHBosKR94FxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oz4kGB45OlBJv9WMAgY81aXa7fbr23XL64pXBA0dDWeLtTCUWNPY3BjlurXpjBsJx7w9gpHq2A7ADJq0t+3HpsEVRe5IQLOvXaRc7b3AdGzlVmATA6mCjlHvJsWZBui83eEswpFW5bWBXgYP3V0npkEwBueqA5fHGdJFPd0PWzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6ftpFwm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717649387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQ5KGBK8vl2NCuRN/qH5IfCCVfv8NGZ7xNGOGpusaHc=;
	b=P6ftpFwm1ei5hwPSYnHfHB+AkNBqo4jvVk3UEK5Ku+rHp/v5i/McBOgTDgbU8kvU1VsTr5
	LiHJqZct9KgnF34faqZaKwom5aTI2/5GtIg7N4vabjt8fFTmMMQACagZaxrm9TGuW5jvLJ
	M/VIkgRP9T6Gw3sAOIlLY0DDkVnLIDM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-mKJALqifPw-Kmf5LnaTeiA-1; Thu, 06 Jun 2024 00:49:06 -0400
X-MC-Unique: mKJALqifPw-Kmf5LnaTeiA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c1b176f795so530153a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 21:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717649345; x=1718254145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQ5KGBK8vl2NCuRN/qH5IfCCVfv8NGZ7xNGOGpusaHc=;
        b=blmcee/lfCeEqX3zmDMjrMOuidcwjy48xkjUCk7hdXG/cEMecH9NHXs3ymLxE0zIdC
         EGrg/K16tGSJIBCVJ3Av07sHl+IfVtMRmaDdXPtVM0aV4SdwWHrW8DBh7q2HPvu2GZkd
         0ghoFiWcM7nWBVaQ2ov/EwrOFVtJjLFZIlmI6B3hTS0yZLa07LEMuIhfiqCinNMKrRfc
         uO2qzB+70D565CS3zJNuUlEFwVKgEQ4uiWDt/y/KHJ1RmTKzc9FywcPa0XurO2+3MI9z
         FeQnvZai1RSfEN3Scc1cMamCQQVrTEO80aNN4vVmMkUVkNNY7HictJMSWP8uODags7gB
         cZgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH15qV+r6/quEwW6Lj+9kZhMZg7BNRJXANNave4Gl+KCRoHt/u2nHjR3IqVwHAZyGgHqWhBW0seUiegcLFDLkpicMMhJGwe3y18eKj
X-Gm-Message-State: AOJu0YxOVp+jXwVmhI58UabTRXlHueDLx8wbPVPNEzt6FASvo/SVFMK9
	1CFavV3X2Zab1Q/MavQlArbd9Pr8/5WeI059fV+Pr8WduX5PiA5yTE4sWraBGFiW5zRo9mBgX9l
	YQ/J/ObMqLcC0O79E8sYToGeuZ4IhGqgBC5RRRiRUVaQSx83haWk40Btk3/us5pb0TzrKKOfx/R
	QBVlzj7p8YGarkXNzX1GFqXjJb15nHcfQv/xEc
X-Received: by 2002:a17:90b:1d06:b0:29b:b5a4:c040 with SMTP id 98e67ed59e1d1-2c27db68db9mr4670275a91.46.1717649344956;
        Wed, 05 Jun 2024 21:49:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEArLK1nFJlz805l05bLNccvPIbM2xzGCCEEz9Isw/EvqGWCFT2IOArsAMRZ3Z7Ja7X/7tHDfvITdjznAxwvWM=
X-Received: by 2002:a17:90b:1d06:b0:29b:b5a4:c040 with SMTP id
 98e67ed59e1d1-2c27db68db9mr4670253a91.46.1717649344251; Wed, 05 Jun 2024
 21:49:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529095313.2568595-1-linan666@huaweicloud.com>
 <Zl0QpCbYVHIkKa/H@fedora> <225f4c8e-0e2c-8f4b-f87d-69f4677af572@huaweicloud.com>
 <CAGVVp+XD5MbYOWL4pbLMxXL0yNKO5NJ84--=KVnW6w5-GF7Drw@mail.gmail.com>
 <918f128b-f752-2d66-ca60-7d9c711ed928@huaweicloud.com> <CAGVVp+V6XGmE_LyOYM3z8cEOzkvQZy=2Fnr5V3G4+DchxAz3Qw@mail.gmail.com>
 <ZmA0Se+t/LZihBKp@fedora>
In-Reply-To: <ZmA0Se+t/LZihBKp@fedora>
From: Changhui Zhong <czhong@redhat.com>
Date: Thu, 6 Jun 2024 12:48:53 +0800
Message-ID: <CAGVVp+WoBochfQvLgAVbpWFv6JVAfQVkPwWDG8mBxqgGK-NDbg@mail.gmail.com>
Subject: Re: [PATCH] ublk_drv: fix NULL pointer dereference in ublk_ctrl_start_recovery()
To: Ming Lei <ming.lei@redhat.com>
Cc: Li Nan <linan666@huaweicloud.com>, axboe@kernel.dk, 
	ZiyangZhang@linux.alibaba.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
	houtao1@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 5:48=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Wed, Jun 05, 2024 at 03:20:34PM +0800, Changhui Zhong wrote:
> > On Wed, Jun 5, 2024 at 9:41=E2=80=AFAM Li Nan <linan666@huaweicloud.com=
> wrote:
> > >
> > >
> > >
> > > =E5=9C=A8 2024/6/4 9:32, Changhui Zhong =E5=86=99=E9=81=93:
> > > > On Mon, Jun 3, 2024 at 10:20=E2=80=AFAM Li Nan <linan666@huaweiclou=
d.com> wrote:
> > > >>
> > > >>
> > > >>
> > > >> =E5=9C=A8 2024/6/3 8:39, Ming Lei =E5=86=99=E9=81=93:
> > > >>
> > > >> [...]
> > > >>
> > > >>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > >>>> index 4e159948c912..99b621b2d40f 100644
> > > >>>> --- a/drivers/block/ublk_drv.c
> > > >>>> +++ b/drivers/block/ublk_drv.c
> > > >>>> @@ -2630,7 +2630,8 @@ static void ublk_queue_reinit(struct ublk_=
device *ub, struct ublk_queue *ubq)
> > > >>>>    {
> > > >>>>       int i;
> > > >>>>
> > > >>>> -    WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq))=
);
> > > >>>> +    if (WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(u=
bq))))
> > > >>>> +            return;
> > > >>>
> > > >>> Yeah, it is one bug. However, it could be addressed by adding the=
 check in
> > > >>> ublk_ctrl_start_recovery() and return immediately in case of NULL=
 ubq->ubq_daemon,
> > > >>> what do you think about this way?
> > > >>>
> > > >>
> > > >> Check ub->nr_queues_ready seems better. How about:
> > > >>
> > > >> @@ -2662,6 +2662,8 @@ static int ublk_ctrl_start_recovery(struct
> > > >> ublk_device *ub,
> > > >>           mutex_lock(&ub->mutex);
> > > >>           if (!ublk_can_use_recovery(ub))
> > > >>                   goto out_unlock;
> > > >> +       if (!ub->nr_queues_ready)
> > > >> +               goto out_unlock;
> > > >>           /*
> > > >>            * START_RECOVERY is only allowd after:
> > > >>            *
> > > >>
> > > >>>
> > > >>> Thanks,
> > > >>> Ming
> > > >>
> > > >> --
> > > >> Thanks,
> > > >> Nan
> > > >>
> > > >
> > > >
> > > > Hi,Nan
> > > >
> > > > After applying your new patch, I did not trigger "NULL pointer
> > > > dereference" and "Warning",
> > > > but hit task hung "Call Trace" info, please check
> > > >
> > > > [13617.812306] running generic/004
> > > > [13622.293674] blk_print_req_error: 91 callbacks suppressed
> > > > [13622.293681] I/O error, dev ublkb4, sector 233256 op 0x1:(WRITE)
> > > > flags 0x8800 phys_seg 1 prio class 0
> > > > [13622.308145] I/O error, dev ublkb4, sector 233256 op 0x0:(READ)
> > > > flags 0x0 phys_seg 2 prio class 0
> > > > [13622.316923] I/O error, dev ublkb4, sector 233264 op 0x1:(WRITE)
> > > > flags 0x8800 phys_seg 1 prio class 0
> > > > [13622.326048] I/O error, dev ublkb4, sector 233272 op 0x0:(READ)
> > > > flags 0x0 phys_seg 1 prio class 0
> > > > [13622.334828] I/O error, dev ublkb4, sector 233272 op 0x1:(WRITE)
> > > > flags 0x8800 phys_seg 1 prio class 0
> > > > [13622.343954] I/O error, dev ublkb4, sector 233312 op 0x0:(READ)
> > > > flags 0x0 phys_seg 1 prio class 0
> > > > [13622.352733] I/O error, dev ublkb4, sector 233008 op 0x0:(READ)
> > > > flags 0x0 phys_seg 1 prio class 0
> > > > [13622.361514] I/O error, dev ublkb4, sector 233112 op 0x0:(READ)
> > > > flags 0x0 phys_seg 1 prio class 0
> > > > [13622.370292] I/O error, dev ublkb4, sector 233192 op 0x1:(WRITE)
> > > > flags 0x8800 phys_seg 1 prio class 0
> > > > [13622.379419] I/O error, dev ublkb4, sector 233120 op 0x0:(READ)
> > > > flags 0x0 phys_seg 1 prio class 0
> > > > [13641.069695] INFO: task fio:174413 blocked for more than 122 seco=
nds.
> > > > [13641.076061]       Not tainted 6.10.0-rc1+ #1
> > > > [13641.080338] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > > disables this message.
> > > > [13641.088164] task:fio             state:D stack:0     pid:174413
> > > > tgid:174413 ppid:174386 flags:0x00004002
> > > > [13641.088168] Call Trace:
> > > > [13641.088170]  <TASK>
> > > > [13641.088171]  __schedule+0x221/0x670
> > > > [13641.088177]  schedule+0x23/0xa0
> > > > [13641.088179]  io_schedule+0x42/0x70
> > > > [13641.088181]  blk_mq_get_tag+0x118/0x2b0
> > > > [13641.088185]  ? gup_fast_pgd_range+0x280/0x370
> > > > [13641.088188]  ? __pfx_autoremove_wake_function+0x10/0x10
> > > > [13641.088192]  __blk_mq_alloc_requests+0x194/0x3a0
> > > > [13641.088194]  blk_mq_submit_bio+0x241/0x6c0
> > > > [13641.088196]  __submit_bio+0x8a/0x1f0
> > > > [13641.088199]  submit_bio_noacct_nocheck+0x168/0x250
> > > > [13641.088201]  ? submit_bio_noacct+0x45/0x560
> > > > [13641.088203]  __blkdev_direct_IO_async+0x167/0x1a0
> > > > [13641.088206]  blkdev_write_iter+0x1c8/0x270
> > > > [13641.088208]  aio_write+0x11c/0x240
> > > > [13641.088212]  ? __rq_qos_issue+0x21/0x40
> > > > [13641.088214]  ? blk_mq_start_request+0x34/0x1a0
> > > > [13641.088216]  ? io_submit_one+0x68/0x380
> > > > [13641.088218]  ? kmem_cache_alloc_noprof+0x4e/0x320
> > > > [13641.088221]  ? fget+0x7c/0xc0
> > > > [13641.088224]  ? io_submit_one+0xde/0x380
> > > > [13641.088226]  io_submit_one+0xde/0x380
> > > > [13641.088228]  __x64_sys_io_submit+0x80/0x160
> > > > [13641.088229]  do_syscall_64+0x79/0x150
> > > > [13641.088233]  ? syscall_exit_to_user_mode+0x6c/0x1f0
> > > > [13641.088237]  ? do_io_getevents+0x8b/0xe0
> > > > [13641.088238]  ? syscall_exit_work+0xf3/0x120
> > > > [13641.088241]  ? syscall_exit_to_user_mode+0x6c/0x1f0
> > > > [13641.088243]  ? do_syscall_64+0x85/0x150
> > > > [13641.088245]  ? do_syscall_64+0x85/0x150
> > > > [13641.088247]  ? blk_mq_flush_plug_list.part.0+0x108/0x160
> > > > [13641.088249]  ? rseq_get_rseq_cs+0x1d/0x220
> > > > [13641.088252]  ? rseq_ip_fixup+0x6d/0x1d0
> > > > [13641.088254]  ? blk_finish_plug+0x24/0x40
> > > > [13641.088256]  ? syscall_exit_to_user_mode+0x6c/0x1f0
> > > > [13641.088258]  ? do_syscall_64+0x85/0x150
> > > > [13641.088260]  ? syscall_exit_to_user_mode+0x6c/0x1f0
> > > > [13641.088262]  ? do_syscall_64+0x85/0x150
> > > > [13641.088264]  ? syscall_exit_to_user_mode+0x6c/0x1f0
> > > > [13641.088266]  ? do_syscall_64+0x85/0x150
> > > > [13641.088268]  ? do_syscall_64+0x85/0x150
> > > > [13641.088270]  ? do_syscall_64+0x85/0x150
> > > > [13641.088272]  ? clear_bhb_loop+0x45/0xa0
> > > > [13641.088275]  ? clear_bhb_loop+0x45/0xa0
> > > > [13641.088277]  ? clear_bhb_loop+0x45/0xa0
> > > > [13641.088279]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > [13641.088281] RIP: 0033:0x7ff92150713d
> > > > [13641.088283] RSP: 002b:00007ffca1ef81f8 EFLAGS: 00000246 ORIG_RAX=
:
> > > > 00000000000000d1
> > > > [13641.088285] RAX: ffffffffffffffda RBX: 00007ff9217e2f70 RCX: 000=
07ff92150713d
> > > > [13641.088286] RDX: 000055863b694fe0 RSI: 0000000000000010 RDI: 000=
07ff92164d000
> > > > [13641.088287] RBP: 00007ff92164d000 R08: 00007ff91936d000 R09: 000=
0000000000180
> > > > [13641.088288] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
0000000000010
> > > > [13641.088289] R13: 0000000000000000 R14: 000055863b694fe0 R15: 000=
055863b6970c0
> > > > [13641.088291]  </TASK>
> > > >
> > > > Thanks=EF=BC=8C
> > > > Changhui
> > > >
> > >
> > > After applying the previous patch, will the test environment continue=
 to
> > > execute test cases after WARN?
> >
> > a few days ago=EF=BC=8Ctest with the previous patch, the test environme=
nt
> > continued to execute test cases after WARN,
> > and I terminated the test when I observed a WARN=EF=BC=8Cso I did not o=
bserve
> > the subsequent situation.
> >
> > > I am not sure whether this issue has always
> > > existed but was not tested becasue of WARN, or whether the new patch
> > > introduced it.
> >
> > today=EF=BC=8C I re-test previous patch=EF=BC=8C and let it run for a l=
ong time=EF=BC=8CI
> > observed WARN and task hung=EF=BC=8C
> > looks this issue already existed and not introduced by new patch.
>
> Hi Changhui,
>
> The hang is actually expected because recovery fails.
>
> Please pull the latest ublksrv and check if the issue can still be
> reproduced:
>
> https://github.com/ublk-org/ublksrv
>
> BTW, one ublksrv segfault and two test cleanup issues are fixed.
>
> Thanks,
> Ming
>

Hi,Ming and Nan

after applying the new patch and pulling the latest ublksrv,
I ran the test for 4 hours and did not observe any task hang.
the test results looks good=EF=BC=81

Thanks=EF=BC=8C
Changhui


