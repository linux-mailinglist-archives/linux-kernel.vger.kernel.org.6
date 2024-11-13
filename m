Return-Path: <linux-kernel+bounces-407226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1E79C6A7A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86E43B2276D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B43189F4B;
	Wed, 13 Nov 2024 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w6EB50Jn"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC722170A03
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731485977; cv=none; b=mMj/XeRDRIF4WG6lNv+atlQIYmbKSEjjdtksz7fUx28P+t2umrmlX3O4rfG86GW1LaD1NNPAGM38xsyScAzlnKGBof0+zMKsMOgW/Jeh16kKGW+lswVn9Mn7phv8fhuMpyESQBr/6EcppA16xEn2ascGr5kG3+pD5w7gxYJ8QUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731485977; c=relaxed/simple;
	bh=Cnx5/u7WVVRjL/g2O6lnbYtDQ1Q9FLDekhDrsRiOiw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnDWZjFOTiXC5gCIeCeRGQkTCF2IkMZwqV0JCuQBcPUpRiI1L5rJaOwz7AQQ6KhrU2IegG0pcFcJdCBVxB9AnlhyEjBSSur2TxDTmZziM/PbJ95IcOjHACDGMFrEkDg9sQEU2FIMpAvjm6cRyVU9U3elY6KJ5QOfjnAHr7XfJ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w6EB50Jn; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-460969c49f2so197721cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731485974; x=1732090774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cnx5/u7WVVRjL/g2O6lnbYtDQ1Q9FLDekhDrsRiOiw0=;
        b=w6EB50JnfBV1kvY3WD+YZD3acIrQVc9RVwkvhrmLof6Vw+NQ1eWahywX9yix4iJkbZ
         r5wtf0EQjDIdkvz/15Pxwq1D98i3O7U9SMJWlY22PYmjmZ70LAK9mo7sSpJ1VB1K9Rxl
         EXcIeEY1RsSPesiBkKoPlnZWOSjkzDliD6/TjGG2vgr/BGlaMi3g7vlt6hr5dEk7zzlI
         mSooNN7a/ZtKzPWmLs8WnG+2MpSgOojkaPO9OyxkbsVLtNktshvdgl6M4jqO4HQ0TrtH
         R/fevSyvQTN9/hSwhY/0e8voE0ACrKgW9DXKfnIRMM0wGS8CTTUrM5HhivDycqKG7Z8O
         EtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731485974; x=1732090774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cnx5/u7WVVRjL/g2O6lnbYtDQ1Q9FLDekhDrsRiOiw0=;
        b=Oqol4vUIEEG65AGxByURudJAMRVNG+iRL+HPZX8lHiIKpdXcmDjlfn6ijdx8UOvGly
         pPC73s7RvaD/URPmROaQjNVjMYNT+Zw0M31c1R3QVBTC6zZA1Q+3TWJTfvoccZpKenST
         CNfAz2MC0tp3A3pQsJrJyb2M6yk8tu7vr2VLWzHSxAEWyJIVZoBkP4pAgykzG/KNDdlm
         6iqix874A4xRLWyraRacCRpjebverY+qDMqDGIBbNy0aV7F97fsO2l1Tp+YMmFiyNY3M
         Ckv3NHvSBdfMt2CReIPIBZHNE3E118XbQkGsfqsRXxgIVC5Gy3Wsk7nT0yq/5UY7XZRA
         QJLg==
X-Forwarded-Encrypted: i=1; AJvYcCVtmPMt7zRvkJdmiVkbA3llPSaITaOKdllAsxdMpaRKFUE0aW9srIBcUYBP4+8o9d+1YyBTaNiwg5AVAwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEygRITgUuT4DpgHonhHYz9zZ8Z2poaA0r3fc81Oso6a7PyFS9
	wlkg978l5fexU1TMMuNArvO6u5r8tYoaY/rgrOmy0NUmk1XXWv2opOXM7Bmk6VQvoJdcw1GDLlO
	x0i0Qb8SAKZPG6kahK2fQ4I3IrjtQrb2OBF5T
X-Gm-Gg: ASbGncsiF5Z5QcjXxkuyMthaF0Bs3dBvdOoA+/QQJC4LRO3oPvt7LrROu8HUgcfSs2o
	VW0cWZsHmcgRNPP4VsaVgPYdnjyIREKg=
X-Google-Smtp-Source: AGHT+IGE+nQpUYoL6FDT1s86sWs+I0FvuajgY1+GilAavFJvfleccnErI/dSJ4HZqOpFIpDau9jUOQ/tmyOe1suyIyE=
X-Received: by 2002:a05:622a:114:b0:461:70cc:3799 with SMTP id
 d75a77b69052e-4634cad9282mr1849331cf.21.1731485974244; Wed, 13 Nov 2024
 00:19:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112194635.444146-1-surenb@google.com> <20241112194635.444146-5-surenb@google.com>
 <CAJuCfpFd2_7q6pi1=G9B0VW5ynCWhkkDDA3PU293FPtT_CcBQA@mail.gmail.com>
 <6d0c5c2d-2963-489a-2376-8edaeb064de3@google.com> <CAJuCfpEG7hhh+mHbZe_9duk2kbFvv_NeGfBqw0JBxiHK-9yWxQ@mail.gmail.com>
 <54394536-da24-d01d-e4a7-2ece22b1ddab@google.com>
In-Reply-To: <54394536-da24-d01d-e4a7-2ece22b1ddab@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 13 Nov 2024 00:19:23 -0800
Message-ID: <CAJuCfpEEH2SMv050+41dLp5j820iP5u-0XyCmDh+mzdAfs266w@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
To: Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 10:52=E2=80=AFPM Hugh Dickins <hughd@google.com> wr=
ote:
>
> On Tue, 12 Nov 2024, Suren Baghdasaryan wrote:
> > On Tue, Nov 12, 2024 at 9:08=E2=80=AFPM Hugh Dickins <hughd@google.com>=
 wrote:
> > > On Tue, 12 Nov 2024, Suren Baghdasaryan wrote:
> > > >
> > > > Thinking about this some more, I don't think this works. I'm relyin=
g
> > > > on vma_start_read() to stabilize the vma, however the lock I'm taki=
ng
> > > > is part of the vma which can be reused from under us. So, the lock =
I'm
> > > > taking might be reinitialized after I take the lock...
> > > > I need to figure out a way to stabilize the vma in some other manne=
r
> > > > before taking this lock.
> > >
> > > (I'm not paying attention and following the patches, I just happened
> > > to notice this remark: forgive me if I'm out of context and have
> > > misunderstood, but hope this might help:)
> > >
> > > But this is exactly the problem SLAB_TYPESAFE_BY_RCU was invented for=
.
> > > You just have to be careful that the locks are initialized only when =
the
> > > slab is first created (allocated from buddy), not reinitialized whene=
ver
> > > a new object is allocated from that slab.
> >
> > Hi Hugh!
> > I'm looking into SLAB_TYPESAFE_BY_RCU implementation and trying to
> > figure out if initializing the lock in the ctor() of the cache as
> > mentioned in the comment here:
> > https://elixir.bootlin.com/linux/v6.12-rc7/source/include/linux/slab.h#=
L127
> > would help my case. I assume that's what you are hinting here?
>
> Yes, if I'm "hinting", it's because offhand I forget the right names:
> "ctor", yes, that sounds right.

Just wanted to make sure I understood you correctly. Thanks for confirmatio=
n.

>
> Just grep around for examples of how it is used: there must be plenty
> now. but anon_vma is what it was first used for.

Yeah, there are plenty of examples now.

>
> But given the title of this patch, I'm surprised it's new to you.

Thinking about issues arising from possible object reuse is indeed new
to me, that's why I missed the lock reinitialization issue. I think I
know how to fix that now.
Thanks,
Suren.

>
> Hugh

