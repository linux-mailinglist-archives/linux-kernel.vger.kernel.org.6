Return-Path: <linux-kernel+bounces-178358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE038C4C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 08:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2281C20CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 06:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8F7F9F5;
	Tue, 14 May 2024 06:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLWAwZFg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC395E541
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 06:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715669842; cv=none; b=ZHX0WQNfmEoLXU+2+PuDmA+iabOS+LP8Jpg98XPHb0J5H3/VpH8pwpwQqWGwdt49uUIgMzSowis1qmNMbPl0NY2zngDtu70Gf3fyZmYbp/+s9Y1LnQ8zhR01m6mVOBiyDBkZhZy7j6vbqyjRenH109WmpwhUh5uDt03/J8M9vZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715669842; c=relaxed/simple;
	bh=6aIPSi+GUkocJtWzCmsTX5dWm52pyDTisNVEAYOpQmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7SLRKrE0t6IcDtYGVTrBNDKMDeB/9vxsWaCE1alpMCKO0WJHXDQXv0+4iXZPnjc604a6LV08MiRfpU9Nd52PRAUP64UQRLpDAxOr/2zeYAHRhpbGyFdszGdI2hNnyvuL4fVc8KtLZawna4mcPNHnLZY/SBQGdT/YGAbutPo3eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLWAwZFg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715669839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tt9yK6I/O8EYanlAPHDgSca+ykSFbvnV0w6tvpdiWNs=;
	b=aLWAwZFgCipLW3NAVlwOecJdWoTFR055JKQ6URJCRmbdGR5NJZol2I7Lek0iN1zQTfT+vI
	y3l5Ojhky/5Re1zBDsNtuRz0cP8/sDX0NeufSeKZWUl/gEZi5Fh6s+pECrFng9yP8/YqTj
	iiKasC2mfmcROAjZq+P5Qymel9o13NQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-7442m_BxOvCvu2k5h7r6kw-1; Tue, 14 May 2024 02:52:18 -0400
X-MC-Unique: 7442m_BxOvCvu2k5h7r6kw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-635731168f7so2981838a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 23:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715669537; x=1716274337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tt9yK6I/O8EYanlAPHDgSca+ykSFbvnV0w6tvpdiWNs=;
        b=a5mp22ghap/L6gvAgberFHyLauBHfh9I6vpePFlh1Re5dPMaRFl+TE5MtnMpI2lx3p
         OCKsxRUQfyyJcZPvqh3qwpnnfqdi3vOpx+o7eHC1YWTBqFz0B+qg3I+8lU9+yia173DO
         /DIS8bN+X3JC4VDuyQIuQDDsg30C2BFJ7nMeumkTTi+CAhq1NnoQVoIuqXNZmrtj1diP
         AAybsNcQ11x1gh9vGBS/vO+GXPOMv1R1eriMwLK8wPP5wfvkslT1QJaous6Zvevf42FW
         ISwoazP5/X5HGXULKTX1hgFAyS1g6Syx8shc0dOoGBm2+3VmQMQdBO2RZVW7SQs4562f
         I57Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmx7qxwIDQFU6aVlvN5DV4po4FlE8RxbFC3r1jC6xJtnCH31LTpBUqRd6P1H/CCav3kwQf+DyZHXgtNr8antBJY1elVebj26LDiCnY
X-Gm-Message-State: AOJu0Yz7vBT/MId4qdHrnZP23V6Mxe5BTxHmg7DStofvsM1w/ojoiHpp
	vXKSlCB9JXfnxr2dcE+nApXDmVb1lo7JoujxqiRXjUi6mMW6/yhlW/kGZEdFnTZH/jLgXi+KwEE
	8wZ0cktVR3BiKIlE0ZRMX8SfRSxUTOayUoQXcwY8/H/C6OgNz+zNYrTAM7QkBxyJFPPikBVSiI9
	3/5l3XWpqdMMsMyLAbhslB+NIZrRwNn0eOOmfS
X-Received: by 2002:a05:6a20:2d2a:b0:1af:f5d3:b919 with SMTP id adf61e73a8af0-1aff5d3ba1emr5310272637.4.1715669537027;
        Mon, 13 May 2024 23:52:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH03hiv7dUouGI6qNIM6FbukFBpKI4K+JPWCWHUdhQQ/ueIAvM2k6M9rZP5Vm/SRlGw8FRyKAXO5ebt9NZab3c=
X-Received: by 2002:a05:6a20:2d2a:b0:1af:f5d3:b919 with SMTP id
 adf61e73a8af0-1aff5d3ba1emr5310243637.4.1715669536555; Mon, 13 May 2024
 23:52:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509011900.2694291-1-yukuai1@huaweicloud.com> <20240509011900.2694291-4-yukuai1@huaweicloud.com>
In-Reply-To: <20240509011900.2694291-4-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Tue, 14 May 2024 14:52:05 +0800
Message-ID: <CALTww2-RPH_eYBumjxhHLkj7J2tfHskTYNif93Hwn5ksCN0+kA@mail.gmail.com>
Subject: Re: [PATCH md-6.10 3/9] md: add new helpers for sync_action
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org, 
	dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
	yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 5:31=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> The new helpers will get current sync_action of the array, will be used
> in later patches to make code cleaner.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/md/md.h |  3 +++
>  2 files changed, 67 insertions(+)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 00bbafcd27bb..48ec35342d1b 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -69,6 +69,16 @@
>  #include "md-bitmap.h"
>  #include "md-cluster.h"
>
> +static char *action_name[NR_SYNC_ACTIONS] =3D {
> +       [ACTION_RESYNC]         =3D "resync",
> +       [ACTION_RECOVER]        =3D "recover",
> +       [ACTION_CHECK]          =3D "check",
> +       [ACTION_REPAIR]         =3D "repair",
> +       [ACTION_RESHAPE]        =3D "reshape",
> +       [ACTION_FROZEN]         =3D "frozen",
> +       [ACTION_IDLE]           =3D "idle",
> +};
> +
>  /* pers_list is a list of registered personalities protected by pers_loc=
k. */
>  static LIST_HEAD(pers_list);
>  static DEFINE_SPINLOCK(pers_lock);
> @@ -4867,6 +4877,60 @@ metadata_store(struct mddev *mddev, const char *bu=
f, size_t len)
>  static struct md_sysfs_entry md_metadata =3D
>  __ATTR_PREALLOC(metadata_version, S_IRUGO|S_IWUSR, metadata_show, metada=
ta_store);
>
> +enum sync_action md_sync_action(struct mddev *mddev)
> +{
> +       unsigned long recovery =3D mddev->recovery;
> +
> +       /*
> +        * frozen has the highest priority, means running sync_thread wil=
l be
> +        * stopped immediately, and no new sync_thread can start.
> +        */
> +       if (test_bit(MD_RECOVERY_FROZEN, &recovery))
> +               return ACTION_FROZEN;
> +
> +       /*
> +        * idle means no sync_thread is running, and no new sync_thread i=
s
> +        * requested.
> +        */
> +       if (!test_bit(MD_RECOVERY_RUNNING, &recovery) &&
> +           (!md_is_rdwr(mddev) || !test_bit(MD_RECOVERY_NEEDED, &recover=
y)))
> +               return ACTION_IDLE;

Hi Kuai

Can I think the above judgement cover these two situations:
1. The array is readonly / readauto and it doesn't have
MD_RECOVERY_RUNNING. Now maybe it has MD_RECOVERY_NEEDED, it means one
array may want to do some sync action, but the array state is not
readwrite and it can't start.
2. The array doesn't have MD_RECOVERY_RUNNING and MD_RECOVERY_NEEDED

> +
> +       if (test_bit(MD_RECOVERY_RESHAPE, &recovery) ||
> +           mddev->reshape_position !=3D MaxSector)
> +               return ACTION_RESHAPE;
> +
> +       if (test_bit(MD_RECOVERY_RECOVER, &recovery))
> +               return ACTION_RECOVER;
> +
> +       if (test_bit(MD_RECOVERY_SYNC, &recovery)) {
> +               if (test_bit(MD_RECOVERY_CHECK, &recovery))
> +                       return ACTION_CHECK;
> +               if (test_bit(MD_RECOVERY_REQUESTED, &recovery))
> +                       return ACTION_REPAIR;
> +               return ACTION_RESYNC;
> +       }
> +
> +       return ACTION_IDLE;

Does it need this? I guess it's the reason in case there are other
situations, right?

Regards
Xiao

> +}
> +
> +enum sync_action md_sync_action_by_name(char *page)
> +{
> +       enum sync_action action;
> +
> +       for (action =3D 0; action < NR_SYNC_ACTIONS; ++action) {
> +               if (cmd_match(page, action_name[action]))
> +                       return action;
> +       }
> +
> +       return NR_SYNC_ACTIONS;
> +}
> +
> +char *md_sync_action_name(enum sync_action action)
> +{
> +       return action_name[action];
> +}
> +
>  static ssize_t
>  action_show(struct mddev *mddev, char *page)
>  {
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 2edad966f90a..72ca7a796df5 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -864,6 +864,9 @@ extern void md_unregister_thread(struct mddev *mddev,=
 struct md_thread __rcu **t
>  extern void md_wakeup_thread(struct md_thread __rcu *thread);
>  extern void md_check_recovery(struct mddev *mddev);
>  extern void md_reap_sync_thread(struct mddev *mddev);
> +extern enum sync_action md_sync_action(struct mddev *mddev);
> +extern enum sync_action md_sync_action_by_name(char *page);
> +extern char *md_sync_action_name(enum sync_action action);
>  extern bool md_write_start(struct mddev *mddev, struct bio *bi);
>  extern void md_write_inc(struct mddev *mddev, struct bio *bi);
>  extern void md_write_end(struct mddev *mddev);
> --
> 2.39.2
>


