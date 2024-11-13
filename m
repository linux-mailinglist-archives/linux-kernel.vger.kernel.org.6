Return-Path: <linux-kernel+bounces-407894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B98CA9C7730
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71EB01F28B60
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59AA207A1B;
	Wed, 13 Nov 2024 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ImAB6+zw"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7B42076B9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511542; cv=none; b=ar/nCr2aWBy9T6CfWeCMVzK9ZTPI9PwmBuS5ERTXq3KDjeCDViBHEZepDK6X/+IZX05qTvf5yyqnxO2oYeaYnB+BLTrqw1pfYT8hWC7szLxSfRm+rdBNr3BNWVY0OgRxVgbBw2qOwObj0APLWIM+5l8zkyLGia/Jo7aaM5DFWdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511542; c=relaxed/simple;
	bh=I7v0vhoWOu97O5THUp9GbrhdIbIJwITBE+FFok+eKG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QScCf2qo9ciFlNNMRZHMk8Qkf9ZZTeiYp0M0jsEpgdxD330RPmYef+rzxJHkEafmVu/Sw/gZnxWjWwR3dbdSKHrh3kLJjGh2S/IPnV+8Y2Ix9r4mmgRXqzNSkXN1q+TJL3cE+n3dIeZSs0nGkKB7apirQ0ii5g8GVcXWGWT1+rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ImAB6+zw; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4608dddaa35so311401cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731511539; x=1732116339; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/2c/aZ6NLfnxI4FeRQCzS7sXT8BvAmij78zkkNVWe0=;
        b=ImAB6+zwU4AENwEyqwdpe0dd6KkRD6R3jY830M/v37MPJW6V22+McEPf7u2rF+RTpo
         5+zvntpER0QgwIuuhxevrXYAWpXSv3nyuDqF2SN/GUj12tY4KAXXc8eM1z5DEUCvg/91
         JbOWbGPN15LyNKL3Q2bWy70Fk8defVghUs7gB6UiKb23GtZgKKQnLd10Iz1V5fKLrl+w
         JC9Ujv66PzV6vyVLbRiMgBTjW1YDWpgGecveMIvYEDdEEnrb3fZWU38acn6Om8D05j79
         /AOsM3iHw7zVczAMGwLIsYxNxOaNlSmAJ/JQydX6aJ6G1EDtZSOi96B2cPro+C1s92Oz
         w1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731511539; x=1732116339;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/2c/aZ6NLfnxI4FeRQCzS7sXT8BvAmij78zkkNVWe0=;
        b=F1BwcLk+IAIGL6PwXxq+Hd6LDPqrpeeyxfMXlg1KmS1s9OxJ8v9RVMaIhHyx58MoBG
         IBm90aWIoZ6R53GwwEWHmM5R6hZ48RNOYg5ZUgGsyAN6tNseBUPYKkPuvfH19HPr2HkJ
         e3kQMMveUVXUhswkAX1V1r3KmvwwyKhnnoBR19BoU9ZsEuh3TlQs8mhHjc0sjoFelczn
         47AsEMo4hdr9ndBBnwKsxijwnl9ekS9ZjbBGJwpk+HY5fjRHtl8TGpZqtHT7/gUFa05O
         1Xuhp4iOAVGtyHgMk31s/J4JYmDdhS+ahxhkjrn7a/Z0+gDrwG0FO3iVbamtHapSmWDv
         6Qbw==
X-Forwarded-Encrypted: i=1; AJvYcCWMh/0i0Y0HZO2p2CHPgMcfeQuIcp4sZOf6KnXpNMU3LbB6Dz8upepMwTZBw9QGv/DE0rxOFAerkqGIDfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrr5kcRzXBTMNAVFZ2ph3IFMAP3n9mx878NlC+HHpj6VHJJss9
	dcDVKt6oYA7qXaf92CmxpCrnaX6JIC3Gl0dm8W+dKeL3z9B4Ecu92nGnXFJj9dtbYJNufboe1pI
	3B9hVDV3x0JSXq57PAk6+S7Mpr2bIArSyhZlv
X-Gm-Gg: ASbGncsirafvrorW6j4BHt5NrbYT2PZxpCcK3PX7A3C7VsZzmH4/Ht4kPAz1IcdQcpb
	m0MQJMse/2YhEsgFhK1BgaGHh7lYtNXA=
X-Google-Smtp-Source: AGHT+IGFTNZ6XVCQERQU4CFc5yvL6hJOaoS0Q0cVh7Ggr4d3T/91GcL3NlHg7DiBOBMIPr7lMera8e/CzHfBJwHac50=
X-Received: by 2002:a05:622a:1494:b0:462:9e4:de13 with SMTP id
 d75a77b69052e-4634caa989fmr2815101cf.9.1731511537742; Wed, 13 Nov 2024
 07:25:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112194635.444146-1-surenb@google.com> <20241112194635.444146-5-surenb@google.com>
 <54b8d0b9-a1c7-4c1b-a588-2e5308a977fb@suse.cz> <sdfh56itaffzhpk4rft2tsjm7r44auhjomfthzgxzrmj5632eq@noi2uhgp3a3h>
 <ZzSwM5qwStadOZvv@casper.infradead.org> <k26pa6fhn2j6bgfwtcdp6u5vk25mkclitzvqqeqvji77k4lqop@yowwrqusmdyp>
In-Reply-To: <k26pa6fhn2j6bgfwtcdp6u5vk25mkclitzvqqeqvji77k4lqop@yowwrqusmdyp>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 13 Nov 2024 07:25:26 -0800
Message-ID: <CAJuCfpHjuMWCzeONq2YOOkr1JGH=E=xn=BAcjQyo_=P1cz=crA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, hannes@cmpxchg.org, 
	mjguzik@gmail.com, oliver.sang@intel.com, mgorman@techsingularity.net, 
	david@redhat.com, peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, 
	paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, 
	hughd@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 7:23=E2=80=AFAM 'Liam R. Howlett' via kernel-team
<kernel-team@android.com> wrote:
>
> * Matthew Wilcox <willy@infradead.org> [241113 08:57]:
> > On Wed, Nov 13, 2024 at 07:38:02AM -0500, Liam R. Howlett wrote:
> > > > Hi, I was wondering if we actually need the detached flag. Couldn't
> > > > "detached" simply mean vma->vm_mm =3D=3D NULL and we save 4 bytes? =
Do we ever
> > > > need a vma that's detached but still has a mm pointer? I'd hope the=
 places
> > > > that set detached to false have the mm pointer around so it's not i=
nconvenient.
> > >
> > > I think the gate vmas ruin this plan.
> >
> > But the gate VMAs aren't to be found in the VMA tree.  Used to be that
> > was because the VMA tree was the injective RB tree and so VMAs could
> > only be in one tree at a time.  We could change that now!
>
> \o/
>
> >
> > Anyway, we could use (void *)1 instead of NULL to indicate a "detached"
> > VMA if we need to distinguish between a detached VMA and a gate VMA.
>
> I was thinking a pointer to itself vma->vm_mm =3D vma, then a check for
> this, instead of null like we do today.

The motivation for having a separate detached flag was that vma->vm_mm
is used when read/write locking the vma, so it has to stay valid even
when vma gets detached. Maybe we can be more cautious in
vma_start_read()/vma_start_write() about it but I don't recall if
those were the only places that was an issue.

>
> Either way, we should make it a function so it's easier to reuse for
> whatever we need in the future, wdyt?
>
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

