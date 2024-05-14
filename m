Return-Path: <linux-kernel+bounces-178443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C4D8C4DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93DBF2842C6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 08:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192F117BD2;
	Tue, 14 May 2024 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evpJPZZd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB1D182B5
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715676047; cv=none; b=pmsI/IC08GBvC/jMFuALX+WEo3CKxiO+of07Blyxcfl1th5+6IkMHIFXz5xde33iF6m3dpdUJGRpFWUu6KAW8BvyzEnWR/jMMQg0L2I+ivvtWaqYNe3Ce8tbpq1NHpxVU9uFiuKIhNTegOeRC7etIS3Y52+zQ75s1ik6xaKSGCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715676047; c=relaxed/simple;
	bh=dFetEP4vkmRWLTuq1sqXsZFTQHPK5+caLDooAk7uDDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Th5DZ2pHU3dzOzh96L6SIR2ey4DS0FxrEvK/BHMIVKO1z3Sm+/jiPdt4vaMqsoVATtUdzoxKtX3P4tUuJ33VICAdxZXWgfsMQaY3itUiqzIaDoiJ/WLGbn43u/hkzKM/YDyfFq10JoyaPtdh9c5usXa7R3vrcL+MZ/BuuPq+Pvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=evpJPZZd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715676044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTDAkRQKfljadsK+bvkReAfKhEEpDm2v7Tj55z8J0R0=;
	b=evpJPZZdXiElN69/iXhM/ymXVaIfrS8fSJSyF0qkD6qbiXclI1DvgbYiLZPvQ8775EWL1o
	GI6OInsw5lfx+NSKvhrA76//Q64iUr0BUiX+ng+vZxMZs5sbHdPr6hQSkISl04l+XeeGeO
	y4fxMYRtu74qyw+wK56GFWHgp8vVcec=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-3f2RUViQMgKyDquTAidueg-1; Tue, 14 May 2024 04:40:43 -0400
X-MC-Unique: 3f2RUViQMgKyDquTAidueg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6f4574f6bffso3999011b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 01:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715676042; x=1716280842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTDAkRQKfljadsK+bvkReAfKhEEpDm2v7Tj55z8J0R0=;
        b=asPIVocK7E/lwSb63o+t3e8qVO5fYta8tjff5a5MJgs/H8gpiaxqB4/KwQUrwXYam8
         veIrg3d7HOAA2Ie03j2UH7wMBiMq4YL953wEqzR90DNTkbmTNbCiK12LFqiY93Q9ihrV
         SaQl9rIYqmsBvucQOtGWjklXnH1m+YzLkb7Q1e9UHy8hZH7CsnO7iBX8foumORe62kea
         WVcLxQIgKxp1WRWc6r59hbjBSx4tOgvTR1pUbK0xryAetOdGSlyDh/W8kOpdkzF5rK8X
         SPCr8L3TgzzD4axbUR4EGbdm96CaUa52kbSi6p5nTjwNLYBMNA6qkgIHEE+yNcMOQfKx
         tqEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKYa1x9ghyBwn2VGr2Vy6sAiuUqStGs/PbEPO207yATDch+efZcqy2i/Sd66uT5DkrIfApYCC8ngpl59d7/KHv0gnD6rWtHPWuPRlu
X-Gm-Message-State: AOJu0YwikpQ5Rn5yAKL+Dft+Zq8hpanScIrY7zfnpb6HA3sx4doFN2Nb
	Pcvrd+0TN1tzokPffNTbHvgP9kQ2JU9jiyli4dgpu5bumgpZq6RXl4iFmyPsyy6JvUxuqZdCYlf
	Y9zCns2h1k/d2WkKJ+goBxVQzt/9mNVltmwe+P9ApX8J2YSfhgXPGuZd0Qt147foq3UIwqeRDO4
	tao8nJOVZ7iWzCJS7j0xCPDk0az85cO6bc1srY
X-Received: by 2002:a05:6a21:9209:b0:1af:f817:7c30 with SMTP id adf61e73a8af0-1aff8177ccemr4598293637.54.1715676041667;
        Tue, 14 May 2024 01:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk0+nnfe4H6D5lCU6UzBHKF4/CM04JrcTMJkYrIEBuYxkc9VBbcacfdhScATnxIPp80XWNGD6qidj2o+fQvyM=
X-Received: by 2002:a05:6a21:9209:b0:1af:f817:7c30 with SMTP id
 adf61e73a8af0-1aff8177ccemr4598261637.54.1715676040436; Tue, 14 May 2024
 01:40:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509011900.2694291-1-yukuai1@huaweicloud.com>
 <20240509011900.2694291-4-yukuai1@huaweicloud.com> <CALTww2-RPH_eYBumjxhHLkj7J2tfHskTYNif93Hwn5ksCN0+kA@mail.gmail.com>
 <06211ae2-9b5f-10c7-7953-9d79d2eacc67@huaweicloud.com>
In-Reply-To: <06211ae2-9b5f-10c7-7953-9d79d2eacc67@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Tue, 14 May 2024 16:40:28 +0800
Message-ID: <CALTww28LM_b6SMC-vLY3y7R3ZD9z80H+2vZCXMzmAwnoEH-eMA@mail.gmail.com>
Subject: Re: [PATCH md-6.10 3/9] md: add new helpers for sync_action
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org, 
	dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 3:39=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/05/14 14:52, Xiao Ni =E5=86=99=E9=81=93:
> > On Mon, May 13, 2024 at 5:31=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> The new helpers will get current sync_action of the array, will be use=
d
> >> in later patches to make code cleaner.
> >>
> >> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >> ---
> >>   drivers/md/md.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++=
++
> >>   drivers/md/md.h |  3 +++
> >>   2 files changed, 67 insertions(+)
> >>
> >> diff --git a/drivers/md/md.c b/drivers/md/md.c
> >> index 00bbafcd27bb..48ec35342d1b 100644
> >> --- a/drivers/md/md.c
> >> +++ b/drivers/md/md.c
> >> @@ -69,6 +69,16 @@
> >>   #include "md-bitmap.h"
> >>   #include "md-cluster.h"
> >>
> >> +static char *action_name[NR_SYNC_ACTIONS] =3D {
> >> +       [ACTION_RESYNC]         =3D "resync",
> >> +       [ACTION_RECOVER]        =3D "recover",
> >> +       [ACTION_CHECK]          =3D "check",
> >> +       [ACTION_REPAIR]         =3D "repair",
> >> +       [ACTION_RESHAPE]        =3D "reshape",
> >> +       [ACTION_FROZEN]         =3D "frozen",
> >> +       [ACTION_IDLE]           =3D "idle",
> >> +};
> >> +
> >>   /* pers_list is a list of registered personalities protected by pers=
_lock. */
> >>   static LIST_HEAD(pers_list);
> >>   static DEFINE_SPINLOCK(pers_lock);
> >> @@ -4867,6 +4877,60 @@ metadata_store(struct mddev *mddev, const char =
*buf, size_t len)
> >>   static struct md_sysfs_entry md_metadata =3D
> >>   __ATTR_PREALLOC(metadata_version, S_IRUGO|S_IWUSR, metadata_show, me=
tadata_store);
> >>
> >> +enum sync_action md_sync_action(struct mddev *mddev)
> >> +{
> >> +       unsigned long recovery =3D mddev->recovery;
> >> +
> >> +       /*
> >> +        * frozen has the highest priority, means running sync_thread =
will be
> >> +        * stopped immediately, and no new sync_thread can start.
> >> +        */
> >> +       if (test_bit(MD_RECOVERY_FROZEN, &recovery))
> >> +               return ACTION_FROZEN;
> >> +
> >> +       /*
> >> +        * idle means no sync_thread is running, and no new sync_threa=
d is
> >> +        * requested.
> >> +        */
> >> +       if (!test_bit(MD_RECOVERY_RUNNING, &recovery) &&
> >> +           (!md_is_rdwr(mddev) || !test_bit(MD_RECOVERY_NEEDED, &reco=
very)))
> >> +               return ACTION_IDLE;
> >
> > Hi Kuai
> >
> > Can I think the above judgement cover these two situations:
> > 1. The array is readonly / readauto and it doesn't have
> > MD_RECOVERY_RUNNING. Now maybe it has MD_RECOVERY_NEEDED, it means one
> > array may want to do some sync action, but the array state is not
> > readwrite and it can't start.
> > 2. The array doesn't have MD_RECOVERY_RUNNING and MD_RECOVERY_NEEDED
> >
> >> +
> >> +       if (test_bit(MD_RECOVERY_RESHAPE, &recovery) ||
> >> +           mddev->reshape_position !=3D MaxSector)
> >> +               return ACTION_RESHAPE;
> >> +
> >> +       if (test_bit(MD_RECOVERY_RECOVER, &recovery))
> >> +               return ACTION_RECOVER;
> >> +
> >> +       if (test_bit(MD_RECOVERY_SYNC, &recovery)) {
> >> +               if (test_bit(MD_RECOVERY_CHECK, &recovery))
> >> +                       return ACTION_CHECK;
> >> +               if (test_bit(MD_RECOVERY_REQUESTED, &recovery))
> >> +                       return ACTION_REPAIR;
> >> +               return ACTION_RESYNC;
> >> +       }
> >> +
> >> +       return ACTION_IDLE;
> >
> > Does it need this? I guess it's the reason in case there are other
> > situations, right?
>
> Yes, we need this, because they are many places to set
> MD_RECOVERY_NEEDED, while there are no sync action actually, this case
> is 'idle'.

To be frank, the logic in action_show is easier to understand than the
logic above. I have taken more than half an hour to think if the logic
here is right or not. In action_show, it only needs to think when it's
not idle and it's easy.

Now this patch logic needs to think in the opposite direction: when
it's idle. And it returns ACTION_IDLE at two places which means it
still needs to think about when it has sync action. So it's better to
keep the original logic in action_show now. It's just my 2 cents
point.

Best Regards
Xiao

>
> Thanks,
> Kuai
>
> >
> > Regards
> > Xiao
> >
> >> +}
> >> +
> >> +enum sync_action md_sync_action_by_name(char *page)
> >> +{
> >> +       enum sync_action action;
> >> +
> >> +       for (action =3D 0; action < NR_SYNC_ACTIONS; ++action) {
> >> +               if (cmd_match(page, action_name[action]))
> >> +                       return action;
> >> +       }
> >> +
> >> +       return NR_SYNC_ACTIONS;
> >> +}
> >> +
> >> +char *md_sync_action_name(enum sync_action action)
> >> +{
> >> +       return action_name[action];
> >> +}
> >> +
> >>   static ssize_t
> >>   action_show(struct mddev *mddev, char *page)
> >>   {
> >> diff --git a/drivers/md/md.h b/drivers/md/md.h
> >> index 2edad966f90a..72ca7a796df5 100644
> >> --- a/drivers/md/md.h
> >> +++ b/drivers/md/md.h
> >> @@ -864,6 +864,9 @@ extern void md_unregister_thread(struct mddev *mdd=
ev, struct md_thread __rcu **t
> >>   extern void md_wakeup_thread(struct md_thread __rcu *thread);
> >>   extern void md_check_recovery(struct mddev *mddev);
> >>   extern void md_reap_sync_thread(struct mddev *mddev);
> >> +extern enum sync_action md_sync_action(struct mddev *mddev);
> >> +extern enum sync_action md_sync_action_by_name(char *page);
> >> +extern char *md_sync_action_name(enum sync_action action);
> >>   extern bool md_write_start(struct mddev *mddev, struct bio *bi);
> >>   extern void md_write_inc(struct mddev *mddev, struct bio *bi);
> >>   extern void md_write_end(struct mddev *mddev);
> >> --
> >> 2.39.2
> >>
> >
> > .
> >
>
>


