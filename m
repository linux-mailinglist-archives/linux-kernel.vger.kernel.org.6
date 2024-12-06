Return-Path: <linux-kernel+bounces-434557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 590AC9E6837
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DFE169189
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9CB1DDA09;
	Fri,  6 Dec 2024 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DD02B4+M"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8161197A9E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733471434; cv=none; b=N2ACPpQO6LfQt4tGGCPVrViWsU6O8Kfvw3nsdN2BDlW1jD4X9TATxP7YXl19addDZpYpBO4A5cLOPF7q7912s5xVRKg2lktrKSfnU9xyxZqmSvhEkkEvPi8lcjtz2DbXn1EBzX/pTkg+r5FmZWTdwreKi8HA4j2HYyKfDMwSlM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733471434; c=relaxed/simple;
	bh=E/pjKB+T65FPQFHjcKHewmxm9NCEzJIcRT+NGNfA6SU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G39w0b8ne3IzfAhh9cv5gb1uiLAJmihtimXYOQVz4H53Ve+akehA0zByf94Er3JiAzDyZeb9qYwh2jskDke6gU5D5JHP5KfmhDstfX+Qu3v9vUvOevdC1HXLTuHrJP12d/ZGqzrRahYRs6BINGTXUxky0arxlsx7St2YNUW3oTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DD02B4+M; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa551d5dd72so28141166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 23:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733471430; x=1734076230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZ1KZrKq9fjjZZzg1BpDFYDzANeNx3Q16LjjyXms8rg=;
        b=DD02B4+MjGiW3WNh+sogdHMd0ALnbVrg3sBUM44E7v/Fayr4EH2Ou4j8HUw/ED9XiZ
         c/j9Ubc9MOLEgB3Vh/o7p6/rSjpisxM3gyhKgdGDqt6DHGiY9pvHmV2FsDKwvEX4azYl
         lvfWXOBsEmoLt0fCpCDak/jZE7BV0JV50s7AKuQEOjEg7VQ1tdQeL3P3c8A7xuY6uEYF
         Sb1mO8yOHqtb4cmZ2FB/kMzr/Numg3eJEODJ+3SixvfEJgoOCjdokarRrPtzKuz3VW3T
         kDTwl8QBQvsji/yEli1m4ac50rbNHfSKO/QKFtlVpH9kD/y5cm7+4eVSIMz0Kz2/101W
         zUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733471430; x=1734076230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZ1KZrKq9fjjZZzg1BpDFYDzANeNx3Q16LjjyXms8rg=;
        b=vcMnWCVmsJmK6HXmOlUrnv3ZfHzUYVQmBO0WZl5+9JnypiaLtbpkniK+LEdxR5gF+X
         wCGaBRhl/0n1rJBKbqs+BYNJNMw3JwhWfG6IjJV3QJ+K1uKcm/egZCNZC9TLeA1ZW8m/
         mQ58/aP1Bl26tjdxtzzisv+kmJnWcjKRt+M10deoN7ke0rw2JAm5OhkRI46VnwfFPBtH
         c2XZF7Di4afOQeyvAQaSR9NIhu2aq0suI4YS4rqQL7kAiuqo6ZgsPJdeid5MAaZ2bAcn
         0BQKk010j8yRMaLo+cGQMkqqqNYjogmrQwmsBpK5kRwfCOsMfC01T6lOCp2JyrENjdHM
         kxTg==
X-Forwarded-Encrypted: i=1; AJvYcCUXGbZy59i20WXCV6JpL+QqG5uHeu0bVhCr/tNRZZyg2n9w8tk0AWYY5X+npxSP7KSTT9C2587DOno9i2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/SLhdXU0UD3wAPmUxR3Nw/ojk9mAgHl2gxcMOdpg5ifSxIxuM
	qdloaJ8HrPDlp8rTZc40IHFsOTsHiSnhg9fNcHJTCVB2rOPjib6lHZc1srGzF3s=
X-Gm-Gg: ASbGncuUPBdLwOzdEahjwVcAgB/EW2scrmAudznZSZo2vSxG6zDgb12d9QLZMgEdtad
	3M9EAbNuOYVGTFjWC8RbA/yB3edTiPn6jMGnzOH4XFRp84IXrbsCmFRGO0zZKsEOsDC4ncpG2Rb
	Dw0bYHV1OX1ACKtJ51iXFIrtvoPD1hPyHRaj7TdARSXJXHGsj67HqzEyc6j2ax01BT+jXka62NB
	EWU0JgfG2VILD5LIKADyU2Spie6NrgZGOWLy+x/ZeK4lZ205J/qKTsmdFnFvV7Xliq13PnH14WP
	767S3iXKI1OhsNKVe9+eIgxUr944/rNAQ4SSA07QmqAz1fedRkc1800=
X-Google-Smtp-Source: AGHT+IF8xoPo6If2nLWiursPzHftrg3L5Sg/0RCI2v1dsSwqFkxqadIQUN7AYaRQbEqFSAHgtuUilA==
X-Received: by 2002:a17:907:3fa8:b0:a9a:8216:2f4d with SMTP id a640c23a62f3a-aa639fa5dfamr62692766b.3.1733471429904;
        Thu, 05 Dec 2024 23:50:29 -0800 (PST)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e58da5sm202707966b.28.2024.12.05.23.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 23:50:29 -0800 (PST)
Date: Fri, 6 Dec 2024 08:50:26 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>, Greg
 Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Message-ID: <20241206085026.32c89a03@mordecai.tesarici.cz>
In-Reply-To: <SN6PR02MB41571E0BD384C44C46127B49D4302@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
	<20241017142752.17f2c816@mordecai.tesarici.cz>
	<aa9a7118-3067-448e-aa34-bbc148c921a2@arm.com>
	<20241205182008.2b36476a@mordecai.tesarici.cz>
	<SN6PR02MB41571E0BD384C44C46127B49D4302@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Dec 2024 18:52:35 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Petr Tesarik <ptesarik@suse.com> Sent: Thursday, December 5, 2024 9=
:20 AM
> >=20
> > Hi Ryan,
> >=20
> > On Thu, 17 Oct 2024 13:32:43 +0100
> > Ryan Roberts <ryan.roberts@arm.com> wrote:
> >  =20
> > > On 17/10/2024 13:27, Petr Tesarik wrote: =20
> > > > On Mon, 14 Oct 2024 11:55:11 +0100
> > > > Ryan Roberts <ryan.roberts@arm.com> wrote:
> > > > =20
> > > >> [...]
> > > >> The series is arranged as follows:
> > > >>
> > > >>   - patch 1:	   Add macros required for converting non-arch code t=
o support
> > > >>   		   boot-time page size selection
> > > >>   - patches 2-36:  Remove PAGE_SIZE compile-time constant assumpti=
on from all
> > > >>   		   non-arch code =20
> > > >
> > > > I have just tried to recompile the openSUSE kernel with these patch=
es
> > > > applied, and I'm running into this:
> > > >
> > > >   CC      arch/arm64/hyperv/hv_core.o
> > > > In file included from ../arch/arm64/hyperv/hv_core.c:14:0:
> > > > ../include/linux/hyperv.h:158:5: error: variably modified =E2=80=98=
reserved2=E2=80=99 at file scope
> > > >   u8 reserved2[PAGE_SIZE - 68];
> > > >      ^~~~~~~~~
> > > >
> > > > It looks like one more place which needs a patch, right? =20
> > >
> > > As mentioned in the cover letter, so far I've only converted enough t=
o get the
> > > defconfig *image* building (i.e. no modules). If you are compiling a =
different
> > > config or compiling the modules for defconfig, you will likely run in=
to these
> > > types of issues.
> > >
> > > That said, I do have some patches to fix Hyper-V, which Michael Kelle=
y was kind
> > > enough to send me.
> > >
> > > I understand that Suse might be able to help with wider performance t=
esting - if
> > > that's the reason you are trying to compile, you could send me your c=
onfig and
> > > I'll start working on fixing up other drivers? =20
> >=20
> > This project was de-prioritised for some time, but I have just returned
> > to it, and one of our test systems uses a Mellanox 5 NIC, which did not=
 build.
> >=20
> > If you still have time to work on your patch series, please, can you
> > look into enabling MLX5_CORE_EN?
> >=20
> > Oh, and have you rebased the series to 6.12 yet?
> >  =20
>=20
> FWIW, here's what I hacked together to compile and run the mlx5 driver in
> a Hyper-V VM.  This was against a 6.11 kernel code base.

Wow! Thank you, Michael. I'll give it a try.

Petr T

