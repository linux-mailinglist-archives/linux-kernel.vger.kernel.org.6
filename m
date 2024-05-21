Return-Path: <linux-kernel+bounces-184460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755F28CA706
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE28D1F21F80
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F032B9A4;
	Tue, 21 May 2024 03:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+pmog6K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8798D28DBC
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716261949; cv=none; b=ZJdYzj7DI451LUR9rFdoI3RCItSdZZoLnYEDzq6SQ0Oe8xxCpWMNUvkxKMYZVA1HHl+MrnJG0BmNUY6T2tAbSgd35cGx1jgb3RsyUv767YVyLvk9oHoseNhKcS4WyQW/4gQFSG9TGvcFWs0zKCWraTGbEspXT3HNSYX97+bX6Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716261949; c=relaxed/simple;
	bh=dAps9Jje+W4BKsGAWJ7FOYkkRW+Moe63q6k+RBEUFkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0zytOMP6c1m0FOxuDSMDsxD5y13NXiVCLn0tzhPs5znQeo8TOjXuGef7iXd4xEhghDVzXRFSnKxk6I/1KXse91eJOWgdOPbgnZl09bOU1JvpzatDtrOUjdwfZFv3Y/hFriEGl9oKxLXVT+gCwwqYTWLOz4pCn61rbgHVFNTw80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+pmog6K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716261946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTqNoq7Ywwug/KZupHOhiNfUyNAblVbOrSzbZCVlky8=;
	b=e+pmog6KS0VoQoVpwGjZgEiCDf0C+P0UC3p7l14CtECoWtOV/XwLw8vHt3iETlp37DNa7z
	HjB6E4T0kBQ/7ZI6N4vcjg34utLIgp9OdLCh7LKw96LecT27v3YWgnorbBloaq0IGslThr
	+DvJ2N6TQwhZn6dUGkxtZTk8K4nxqkg=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-qHK5-hQcOsWjDitsljIqMQ-1; Mon, 20 May 2024 23:25:44 -0400
X-MC-Unique: qHK5-hQcOsWjDitsljIqMQ-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5b27c7a007cso13665589eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716261943; x=1716866743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTqNoq7Ywwug/KZupHOhiNfUyNAblVbOrSzbZCVlky8=;
        b=FHU4DLOSGu7Z6RWbSER1RumYH9x331hGkruQdvj73CzPTn/RvLUF7jTTCW8aJd8fUO
         7vdI7i+MnZa3loiLopqJQ3BgqkNfmpi9pjDDSYdVqEumaynnIzYh9V2usCP6RUgWr4+h
         iKCO5qcdRpvcz2dChA3iwTFeFymJMAJdonqOEwf6VbdiKXQqeJ5IY2aqInlHpPGYVksl
         /yQYmcbhqKwqJPQxJfhxPJgmT8NRGKcAeI4eeoxcv1ysyfItyni7rSKMPMLY04Qm+Ubu
         nuigF6dplHG4NM734Y48PHtwx8QFwaXQbqsM5SrKcB7cTAzmch8g0vGMZtbHd0GgjTDI
         PGyA==
X-Forwarded-Encrypted: i=1; AJvYcCXzdp9Lt7p7COx1ImYaskhXb3q1k+84jGroQrPsuMMNeJe+/lY7H0gSVke5sXNevXNoDv8aWEvmzZui8iZ72TdlYMwNnFnRU6ObeGk/
X-Gm-Message-State: AOJu0YwH/+hqysuJfJzD+etamUn8R4At2rK4Uzfu9bSLXF3TrzGyYCkl
	TCvIUl3saIrEPCBla3OSUfVRt/kYNDbEkJg9+h4lnXbp5yuwokS6tiRuiNMJDnfT3JKfIO0PTL6
	Txn0cmfUfndqwYcnT+umAOZng2DfLvd3X+lOdO0yQxkwOBVulhKkkbZ89PkPb2tomMAtoezz2UP
	M7Zyry9HGsXhZm0GrOb9JXolAynz+xQk/tHOis
X-Received: by 2002:a05:6358:3992:b0:18a:e062:ff55 with SMTP id e5c5f4694b2df-193badda3e1mr3424984455d.0.1716261943009;
        Mon, 20 May 2024 20:25:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXijquOe3UDtI/IZRj3oWKr9KI+JW7yIIBbhlVb8Ah6rYdv037aA7CPM7ivMIE5RK0N7pQ6Ld6KJnSA19IZLU=
X-Received: by 2002:a05:6358:3992:b0:18a:e062:ff55 with SMTP id
 e5c5f4694b2df-193badda3e1mr3424982455d.0.1716261942568; Mon, 20 May 2024
 20:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509011900.2694291-1-yukuai1@huaweicloud.com>
 <20240509011900.2694291-4-yukuai1@huaweicloud.com> <v838ekaa.fsf@damenly.org>
In-Reply-To: <v838ekaa.fsf@damenly.org>
From: Xiao Ni <xni@redhat.com>
Date: Tue, 21 May 2024 11:25:31 +0800
Message-ID: <CALTww28PVgS3D+9JsNv4PvDLAi=hOyT14QMkk5245_a8JXvgNQ@mail.gmail.com>
Subject: Re: [PATCH md-6.10 3/9] md: add new helpers for sync_action
To: Su Yue <l@damenly.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, agk@redhat.com, snitzer@kernel.org, 
	mpatocka@redhat.com, song@kernel.org, dm-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 8:38=E2=80=AFPM Su Yue <l@damenly.org> wrote:
>
>
> On Thu 09 May 2024 at 09:18, Yu Kuai <yukuai1@huaweicloud.com>
> wrote:
>
> > From: Yu Kuai <yukuai3@huawei.com>
> >
> > The new helpers will get current sync_action of the array, will
> > be used
> > in later patches to make code cleaner.
> >
> > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > ---
> >  drivers/md/md.c | 64
> >  +++++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/md/md.h |  3 +++
> >  2 files changed, 67 insertions(+)
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index 00bbafcd27bb..48ec35342d1b 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -69,6 +69,16 @@
> >  #include "md-bitmap.h"
> >  #include "md-cluster.h"
> >
> > +static char *action_name[NR_SYNC_ACTIONS] =3D {
> >
>
> Th array will not be modified, so:
>
> static const char * const action_names[NR_SYNC_ACTIONS]
>
> > +     [ACTION_RESYNC]         =3D "resync",
> > +     [ACTION_RECOVER]        =3D "recover",
> > +     [ACTION_CHECK]          =3D "check",
> > +     [ACTION_REPAIR]         =3D "repair",
> > +     [ACTION_RESHAPE]        =3D "reshape",
> > +     [ACTION_FROZEN]         =3D "frozen",
> > +     [ACTION_IDLE]           =3D "idle",
> > +};
> > +
> >  /* pers_list is a list of registered personalities protected by
> >  pers_lock. */
> >  static LIST_HEAD(pers_list);
> >  static DEFINE_SPINLOCK(pers_lock);
> > @@ -4867,6 +4877,60 @@ metadata_store(struct mddev *mddev, const
> > char *buf, size_t len)
> >  static struct md_sysfs_entry md_metadata =3D
> >  __ATTR_PREALLOC(metadata_version, S_IRUGO|S_IWUSR,
> >  metadata_show, metadata_store);
> >
> > +enum sync_action md_sync_action(struct mddev *mddev)
> > +{
> > +     unsigned long recovery =3D mddev->recovery;
> > +
> > +     /*
> > +      * frozen has the highest priority, means running sync_thread
> > will be
> > +      * stopped immediately, and no new sync_thread can start.
> > +      */
> > +     if (test_bit(MD_RECOVERY_FROZEN, &recovery))
> > +             return ACTION_FROZEN;
> > +
> > +     /*
> > +      * idle means no sync_thread is running, and no new
> > sync_thread is
> > +      * requested.
> > +      */
> > +     if (!test_bit(MD_RECOVERY_RUNNING, &recovery) &&
> > +         (!md_is_rdwr(mddev) || !test_bit(MD_RECOVERY_NEEDED,
> > &recovery)))
> > +             return ACTION_IDLE;
> My brain was lost sometimes looking into nested conditions of md
> code...

agree+

> I agree with Xiao Ni's suggestion that more comments about the
> array
> state should be added.

In fact, I suggest to keep the logic which is in action_show now. The
logic in action_show is easier to understand for me.

Best Regards
Xiao
>
> > +     if (test_bit(MD_RECOVERY_RESHAPE, &recovery) ||
> > +         mddev->reshape_position !=3D MaxSector)
> > +             return ACTION_RESHAPE;
> > +
> > +     if (test_bit(MD_RECOVERY_RECOVER, &recovery))
> > +             return ACTION_RECOVER;
> > +
> >
> In action_show, MD_RECOVERY_SYNC is tested first then
> MD_RECOVERY_RECOVER.
> After looking through the logic of MD_RECOVERY_RECOVER
> clear/set_bit, the
> change is fine to me. However, better to follow old pattern unless
> there
> have resons.
>
>
> > +     if (test_bit(MD_RECOVERY_SYNC, &recovery)) {
> > +             if (test_bit(MD_RECOVERY_CHECK, &recovery))
> > +                     return ACTION_CHECK;
> > +             if (test_bit(MD_RECOVERY_REQUESTED, &recovery))
> > +                     return ACTION_REPAIR;
> > +             return ACTION_RESYNC;
> > +     }
> > +
> > +     return ACTION_IDLE;
> > +}
> > +
> > +enum sync_action md_sync_action_by_name(char *page)
> > +{
> > +     enum sync_action action;
> > +
> > +     for (action =3D 0; action < NR_SYNC_ACTIONS; ++action) {
> > +             if (cmd_match(page, action_name[action]))
> > +                     return action;
> > +     }
> > +
> > +     return NR_SYNC_ACTIONS;
> > +}
> > +
> > +char *md_sync_action_name(enum sync_action action)
> >
>
> And 'const char *'
>
> --
> Su
>
> > +{
> > +     return action_name[action];
> > +}
> > +
> >  static ssize_t
> >  action_show(struct mddev *mddev, char *page)
> >  {
> > diff --git a/drivers/md/md.h b/drivers/md/md.h
> > index 2edad966f90a..72ca7a796df5 100644
> > --- a/drivers/md/md.h
> > +++ b/drivers/md/md.h
> > @@ -864,6 +864,9 @@ extern void md_unregister_thread(struct
> > mddev *mddev, struct md_thread __rcu **t
> >  extern void md_wakeup_thread(struct md_thread __rcu *thread);
> >  extern void md_check_recovery(struct mddev *mddev);
> >  extern void md_reap_sync_thread(struct mddev *mddev);
> > +extern enum sync_action md_sync_action(struct mddev *mddev);
> > +extern enum sync_action md_sync_action_by_name(char *page);
> > +extern char *md_sync_action_name(enum sync_action action);
> >  extern bool md_write_start(struct mddev *mddev, struct bio
> >  *bi);
> >  extern void md_write_inc(struct mddev *mddev, struct bio *bi);
> >  extern void md_write_end(struct mddev *mddev);
>


