Return-Path: <linux-kernel+bounces-374491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2C09A6B10
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985322816C8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08651F8925;
	Mon, 21 Oct 2024 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7X29sQ+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1468E1E570F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518748; cv=none; b=lN8/NvRHKCi1Mloob8AzuKgMjDzSdkLvfXIqieXIJHF+tPAb9OIBkZuiZXjR5hp3pVnI/emWXtTZDgh1td1lswcSG45P3CZ0GV8cLJIePN/zm7jvyZMIStm0Okp5wjaSDv11+h2Zk7liDoFyYZG8PDgB0KE0r519v8/JRJ9HlBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518748; c=relaxed/simple;
	bh=yixNZRtUAPrY+e+uVVeUhm+RcEKp0QQb5IT69xYtxTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+mdcLBPUKmt/qGeVb01gBEJH9vHnTBnjV8xMaNvBOrUiD1kCn7XGYbakBiU88KxgnF7+OJIT7t0RHEt2GLFqXTPqdyk9Tt+qG90YyKaG6+2gmxVIZZky6vnRiinpM1Oiy3ya8Bj7wKNm594b9CXzwFmYFsWR+iGINixNWIedBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7X29sQ+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729518744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AydGMqBX7Z+tuYb/IW4dKkC2L7bMtStxPdbI/fd8h+M=;
	b=X7X29sQ+aAIWUDECvx4jO+QdzU7GtOgvAQpunSAvqZH9dY/RusGWrdImKwZUEwOByTExLJ
	dZl3NPDndo/PYRQoHEg1ptCzEIE+KLG/iGy5nF5R/FbnZfg6wF095SqvixIt9xwGeOAj7l
	OFIOrMYVMAOTjg2xjr0+lzKN2mhlBSE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-KlsEjlQsPu6RGTFXKE-Xag-1; Mon, 21 Oct 2024 09:52:23 -0400
X-MC-Unique: KlsEjlQsPu6RGTFXKE-Xag-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a99f084683fso307668766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729518741; x=1730123541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AydGMqBX7Z+tuYb/IW4dKkC2L7bMtStxPdbI/fd8h+M=;
        b=ndmXgAf043Z6NHSPsSyaq3781+9NZj1y/bBJw8aLSZlKoLy8zIqQBExhMOEocPNqvR
         Y19kh8VROssO3WLYZOVY7w4H82wrUgHqF4E33zsK+qaifmH8CC3XVn1R5KJ6MDn6+WLN
         yM5KxWPA6wAzqmB9XdAmH46kWEzaxzent2ILjINPlT375OsPPmixNOQVYE//UUFO8ui5
         r+F68uJVuT2M1lBeybpAHPoZbeV9QKkjDyFea7srmZwYd49YB0oBhpdta9DWhxp8pedk
         GEdw9VRz+2usSgfpKSZnqmVxwwJNjXp6WG5tuz0WFICn7ZTzoIhf/k/QiX6M8g69gMue
         mlgw==
X-Forwarded-Encrypted: i=1; AJvYcCV8hezrZUe6oK7zIjUUDskdI3lpkBrxupqsnNlfr4HOwjVAwaroxa9ncjbCSavUj14P0SKjC0cC6hOSVgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwROwv+hMFs5a8wyzU5qLPboFpd7Bbz5vJLUCImuHFyAkmao5BW
	mauL+Wvb0wPmHr7gs7J0TiufKVJ2FohZyMfRTUL3+jh9zdhb2Vq/P1G8FaSSn5XdQ2BuZpgT4x5
	rOhAErdb+U4thoTAf9ZZhnGMXWbG8vGVm863bNMdEa+1sGLcLdkYpSWXgNjatQPuPaNDBgCLW+x
	ObNXYkYLVWyWl+drUBwtRUFZPbxQjuYJg/b0mZyBFL8zpUs9E=
X-Received: by 2002:a17:906:6a29:b0:a99:e504:40c5 with SMTP id a640c23a62f3a-a9a69bb4776mr1227165466b.39.1729518741330;
        Mon, 21 Oct 2024 06:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGulfB1IarH/oSLq12aN14lRQiyUgCefQvibXPQP2R5iRcNGCUEollbP940MRbZl/f06qFQIKF2e26dmG30dRw=
X-Received: by 2002:a17:906:6a29:b0:a99:e504:40c5 with SMTP id
 a640c23a62f3a-a9a69bb4776mr1227163466b.39.1729518740965; Mon, 21 Oct 2024
 06:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013011642.555987-1-batrick@batbytes.com> <3039501f-f7b2-443b-a727-c53c41b41ed9@redhat.com>
In-Reply-To: <3039501f-f7b2-443b-a727-c53c41b41ed9@redhat.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Mon, 21 Oct 2024 09:51:53 -0400
Message-ID: <CA+2bHPaYD8VuLrYcJJ93ODPHVhC3QvCL=5d78_4mUXpmF=1hYA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ceph: correct ceph_mds_cap_item field name
To: Xiubo Li <xiubli@redhat.com>
Cc: Patrick Donnelly <batrick@batbytes.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xiubo,

On Sun, Oct 13, 2024 at 8:57=E2=80=AFPM Xiubo Li <xiubli@redhat.com> wrote:
>
> Hi Patrick,
>
> Thanks for your patches.
>
> BTW, I think this should be the V2, right ?
>
> Then could you explain what's the difference between V1 and V2 ?Usually
> we will add this in the cover-letter.

There's no difference. These patches accidentally got picked up with
the other set I sent out (I already sent a new series for that set:
"ceph: use entity name from new device string"). These are the three
patches:

https://lore.kernel.org/ceph-devel/20241012235529.520289-1-batrick@batbytes=
.com/T/#r691410e455d5b10da617880b91a6c45703ff764e

I can resend in a new series if you like.


> And also we will add a version tag from the second version of the patch
> series, which is something like:
>
>    [PATCH v2 0/3]
>    [PATCH v2 1/3]
>    ...
>    [PATCH v2 3/3]
>
> At the same time please add a cover-letter if there are more than 1
> patch in the series, which will be the '[PATCH 0/3]', and you can
> generate it by using the '--cover-letter' option:
>
>    $ git patch-format -3 --cover-letter
>
> Please note that in the cover-letter patch you need to add the title, a
> summary about this series and certainly a comment about the changes from
> the last version manually. One example about this please see
> https://lore.kernel.org/all/20240418142019.133191-1-xiubli@redhat.com/.
>
> If there is only one patch in the series, then the cover-letter is not a
> must and you can just do it likes:
> https://patchwork.kernel.org/project/ceph-devel/patch/20240314073915.8445=
41-1-xiubli@redhat.com/,
>
> Thanks
>
> - Xiubo
>
>
> On 10/13/24 09:16, Patrick Donnelly wrote:
> > The issue_seq is sent with bulk cap releases, not the current sequence =
number.
> >
> > See also ceph.git commit: "include/ceph_fs: correct ceph_mds_cap_item f=
ield name".
> >
> > See-also: https://tracker.ceph.com/issues/66704
> > Signed-off-by: Patrick Donnelly <pdonnell@redhat.com>
> > ---
> >   fs/ceph/mds_client.c         | 2 +-
> >   include/linux/ceph/ceph_fs.h | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index c4a5fd94bbbb..0be82de8a6da 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -2362,7 +2362,7 @@ static void ceph_send_cap_releases(struct ceph_md=
s_client *mdsc,
> >               item->ino =3D cpu_to_le64(cap->cap_ino);
> >               item->cap_id =3D cpu_to_le64(cap->cap_id);
> >               item->migrate_seq =3D cpu_to_le32(cap->mseq);
> > -             item->seq =3D cpu_to_le32(cap->issue_seq);
> > +             item->issue_seq =3D cpu_to_le32(cap->issue_seq);
> >               msg->front.iov_len +=3D sizeof(*item);
> >
> >               ceph_put_cap(mdsc, cap);
> > diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.=
h
> > index ee1d0e5f9789..4ff3ad5e9210 100644
> > --- a/include/linux/ceph/ceph_fs.h
> > +++ b/include/linux/ceph/ceph_fs.h
> > @@ -822,7 +822,7 @@ struct ceph_mds_cap_release {
> >   struct ceph_mds_cap_item {
> >       __le64 ino;
> >       __le64 cap_id;
> > -     __le32 migrate_seq, seq;
> > +     __le32 migrate_seq, issue_seq;
> >   } __attribute__ ((packed));
> >
> >   #define CEPH_MDS_LEASE_REVOKE           1  /*    mds  -> client */
> >
> > base-commit: 75b607fab38d149f232f01eae5e6392b394dd659
>


--
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


