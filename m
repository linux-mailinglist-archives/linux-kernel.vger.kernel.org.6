Return-Path: <linux-kernel+bounces-196181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C905F8D5887
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1371C22B53
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 02:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B033674E3D;
	Fri, 31 May 2024 02:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZu5SNF+"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF45221
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717121751; cv=none; b=u0VU2yaG1FtNKpy5wl0WE/emsnJr78/GP4YZl2n1Wq+UOkbPCyN+cV1kqb45pBM4A7zE1jSueAOa5P9P0azhtw/0CgfiZwHjDdmqTQ9Myaaf7LXylxkb6sCQL4mAG9SrF6qzvqoI59sn49jrSkCt6H528Xq4ANBqxXvyR+I+95k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717121751; c=relaxed/simple;
	bh=ujqjt6nPYvhHkI8+PJNsQn1SZ1cTucvti8kPxHzCn1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8Q4oddXjBuYyi1vbRlszB5TnXgJo8G4XB9zcIs9+wLGbRGm4bshYBFGFYYtiDUfno/UGZ5JNhuQq/GAKETJRvHqVly6GHkSxstcD8c6fgzH1RQHqc23czTFl1xyBmUSvlIa33WppPJvTH86owr/MfS5Exxn+A3vIViAHLFdMFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZu5SNF+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35dc36b107fso639291f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 19:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717121748; x=1717726548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVZ+m5D5+txNLZWQ1wHkb88kpVVpmlzrHDUo9d6Wu3o=;
        b=WZu5SNF+xMWhLNNyB9BRQ2L1QGPRbJ3/cPDE9dTVvz/XNGBeuuY4OPc1dYsQyUL9Vy
         V2tnl5PBWw9JXnkWCOpeJcG9ofx/TZwH34YB2zbXHNAekioUFjReBiaqtVs4l1yMsloK
         xWq/BdOH1DQGo5V2Sah4XiwV4BKOpqaLPW+7o9+ouVOEnpz0KFvUEvaidKLhbbUIeUb/
         hA+w3MQf1xPT1S+RMVItKT9IYQTlyRpdpjWGPRRxTg5yFY4GnMQYgaRuODfFsqW5M2eh
         aeQ/SefGD5dxULDi65yaU6bqdQB2v4FKbADSXRRY0QvLd9r16pB0mp1f3VxvOFNWTK3a
         3CqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717121748; x=1717726548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVZ+m5D5+txNLZWQ1wHkb88kpVVpmlzrHDUo9d6Wu3o=;
        b=dATEOOO9Kx6GpTduUWBfug9stxpQGKS298xRW103VlXUer6zGcgFaHoleLG248K8Q6
         j6OrDzMwHX+ozTdfOflLLp+o7cv1gAz+hkk11+bNZoa2t2kT/ZGVfBM/4fP5j7fnVeLG
         5HHS/Z0ife4O65TKRbCsuRIvT6KGwgG0pbRrQtALhRqcbtaqe02RWdxKF6fLeYhk6Oxr
         TNI0D4wpi7wzNndVcUp3/ikZuL/fYGvSVMmVS9ku9+csKvSGVd0nM4qTqUwxoU7ZOblt
         Gtb3QVxE2U+XptGdNVHaL2GoU/gnIN0NVl53VeWbq48WJ+ky2XXjR206W2WbBCZoEVXG
         J0Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWbhpU8kdQDj8HuTJL6AdvDV1d7L1l20q9qxnCVomTeDdO2Iqq0JndxsWuluGw6VLOfyyqgUrqPB+YMqebaaCi+GNEqzIOLiSlrMOO4
X-Gm-Message-State: AOJu0YzlkmeWJpUy9j9FqSma6gZbh46nBzuIjiDQ7f3/jNdDsqNEZEq9
	fds8HPkx+A9fxP3kxuIocYw2PQ3b7PQn6MLIc297Dm2foLADRI5dSgV5+L7BHLBYoCR8272nIr3
	+23iIJq1hF75qbjYC9wtSSRtSLHc=
X-Google-Smtp-Source: AGHT+IHRWJN+gxDchzmDSqJk6zLAuQIT1nOSjWlbD6Rv+4uUgrbaWgOh/7ArTSHrMuvTdEVXCutlfFw3zw5BoONSCjE=
X-Received: by 2002:a5d:4808:0:b0:354:fca5:4190 with SMTP id
 ffacd0b85a97d-35e0f289f41mr212647f8f.41.1717121748147; Thu, 30 May 2024
 19:15:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716204978-29455-1-git-send-email-zhiguo.niu@unisoc.com>
 <1d67715b-5f88-4940-969d-e098fd80ae2a@kernel.org> <CAHJ8P3LXYWQ+bLZHPn_5FLu3oi83ei8C9ZCzAXwa9oBdEKVDNA@mail.gmail.com>
 <CAHJ8P3+ro9YsU7jZWeAfiUh9uNFEj_=Wiaf2YRLVLBD5_9fM0g@mail.gmail.com> <0a4b5b40-1532-44a4-a4d6-601ceced20a4@kernel.org>
In-Reply-To: <0a4b5b40-1532-44a4-a4d6-601ceced20a4@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Fri, 31 May 2024 10:15:36 +0800
Message-ID: <CAHJ8P3J1_Yg3FAruR0zPQdDnbw_GbT7wOKON3-xzBr32+HU_6w@mail.gmail.com>
Subject: Re: [PATCH] f2fs: enable atgc if atgc_age_threshold from user is less
 than elapsed_time
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 10:04=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/5/30 17:49, Zhiguo Niu wrote:
> > On Mon, May 27, 2024 at 12:07=E2=80=AFPM Zhiguo Niu <niuzhiguo84@gmail.=
com> wrote:
> >>
> >> On Mon, May 27, 2024 at 11:49=E2=80=AFAM Chao Yu <chao@kernel.org> wro=
te:
> >>>
> >>> On 2024/5/20 19:36, Zhiguo Niu wrote:
> >>>> Now atgc can be enabled based on the following conditions:
> >>>> -ATGC mount option is set
> >>>> -elapsed_time is more than atgc_age_threshold already
> >>>> but these conditions are check when umounted->mounted device again.
> >>>> If the device has not be umounted->mounted for a long time, atgc can
> >>>> not work even the above conditions met.
> >>>
> >>> Zhiguo, I didn't get it, can you please explain more about this issue=
?
> >>>
> >>> Thanks,
> >> Hi Chao,
> >>
> >> At present, the point of atgc enale is checked during the mount
> >> process. What I mean is that if a device has not been rebooted
> >> (re-mounted) for a long time, even if the above two conditions are
> >> met(ATGC mount option is set, and the device has been powered on long
> >> enough=EF=BC=8C more than atgc default threshold ), atgc cannot be dyn=
amically
> >> enabled.
> >>
> >> If the user is used to not restarting the phone after turning it on,
> >> it will be difficult to use atgc.
> >> thanks!
> > Hi Chao,
> > Do you have any suggestions or comments on this?
>
> Zhiguo,
>
> I remember that atgc can not be enabled at runtime due to some reasons, b=
ut
> I need some time to recall and check the details...
>
> Thanks,
Hi Chao,
OK, Thanks for your help.
>
> > thanks=EF=BC=81
> >
> >>>
> >>>>
> >>>> It is better to enable atgc dynamiclly when user change atgc_age_thr=
eshold
> >>>> meanwhile this vale is less than elapsed_time and ATGC mount option =
is on.
> >>>>
> >>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>>> ---
> >>>>    fs/f2fs/f2fs.h    |  1 +
> >>>>    fs/f2fs/segment.c |  9 ++++-----
> >>>>    fs/f2fs/sysfs.c   | 16 ++++++++++++++++
> >>>>    3 files changed, 21 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>>> index 1974b6a..e441d2d 100644
> >>>> --- a/fs/f2fs/f2fs.h
> >>>> +++ b/fs/f2fs/f2fs.h
> >>>> @@ -3694,6 +3694,7 @@ void f2fs_clear_prefree_segments(struct f2fs_s=
b_info *sbi,
> >>>>    int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi);
> >>>>    void f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi);
> >>>>    void f2fs_restore_inmem_curseg(struct f2fs_sb_info *sbi);
> >>>> +int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi);
> >>>>    int f2fs_allocate_segment_for_resize(struct f2fs_sb_info *sbi, in=
t type,
> >>>>                                        unsigned int start, unsigned =
int end);
> >>>>    int f2fs_allocate_new_section(struct f2fs_sb_info *sbi, int type,=
 bool force);
> >>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>>> index 71dc8042..44923d4 100644
> >>>> --- a/fs/f2fs/segment.c
> >>>> +++ b/fs/f2fs/segment.c
> >>>> @@ -2931,14 +2931,11 @@ static int get_atssr_segment(struct f2fs_sb_=
info *sbi, int type,
> >>>>        return ret;
> >>>>    }
> >>>>
> >>>> -static int __f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
> >>>> +int f2fs_init_atgc_curseg(struct f2fs_sb_info *sbi)
> >>>>    {
> >>>>        struct curseg_info *curseg =3D CURSEG_I(sbi, CURSEG_ALL_DATA_=
ATGC);
> >>>>        int ret =3D 0;
> >>>>
> >>>> -     if (!sbi->am.atgc_enabled)
> >>>> -             return 0;
> >>>> -
> >>>>        f2fs_down_read(&SM_I(sbi)->curseg_lock);
> >>>>
> >>>>        mutex_lock(&curseg->curseg_mutex);
> >>>> @@ -2955,7 +2952,9 @@ static int __f2fs_init_atgc_curseg(struct f2fs=
_sb_info *sbi)
> >>>>    }
> >>>>    int f2fs_init_inmem_curseg(struct f2fs_sb_info *sbi)
> >>>>    {
> >>>> -     return __f2fs_init_atgc_curseg(sbi);
> >>>> +     if (!sbi->am.atgc_enabled)
> >>>> +             return 0;
> >>>> +     return f2fs_init_atgc_curseg(sbi);
> >>>>    }
> >>>>
> >>>>    static void __f2fs_save_inmem_curseg(struct f2fs_sb_info *sbi, in=
t type)
> >>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> >>>> index 09d3ecf..72676c5 100644
> >>>> --- a/fs/f2fs/sysfs.c
> >>>> +++ b/fs/f2fs/sysfs.c
> >>>> @@ -673,6 +673,22 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
> >>>>                return count;
> >>>>        }
> >>>>
> >>>> +     if (!strcmp(a->attr.name, "atgc_age_threshold")) {
> >>>> +             if (t < 0)
> >>>> +                     return -EINVAL;
> >>>> +             sbi->am.age_threshold =3D t;
> >>>> +             if (sbi->am.atgc_enabled)
> >>>> +                     return count;
> >>>> +
> >>>> +             if (test_opt(sbi, ATGC) &&
> >>>> +                     le64_to_cpu(sbi->ckpt->elapsed_time) >=3D t) {
> >>>> +                     if (f2fs_init_atgc_curseg(sbi))
> >>>> +                             return -EINVAL;
> >>>> +                     sbi->am.atgc_enabled =3D true;
> >>>> +             }
> >>>> +             return count;
> >>>> +     }
> >>>> +
> >>>>        if (!strcmp(a->attr.name, "gc_segment_mode")) {
> >>>>                if (t < MAX_GC_MODE)
> >>>>                        sbi->gc_segment_mode =3D t;

