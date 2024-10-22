Return-Path: <linux-kernel+bounces-375377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2374C9A9536
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E792928354B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 00:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEA477104;
	Tue, 22 Oct 2024 00:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F2bzBJTE"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191B4C2C8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 00:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729558547; cv=none; b=VtlVMQYUAJk08lrczWxd1CQWSdwEyDupxYOygpoHgYSFPs7sSc85mD8KyRPziz5/EqKik+v8qd8G/AgJozM2gre+OmOD/KpFdWI/teNAWMB4fAAHn8ZUQIlUDPuEzFsO/JFnXOeSF3J8xia2xdTQnfgpbVrx5TsXd8AIFS3K4Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729558547; c=relaxed/simple;
	bh=D91LW0u/aFo2LHxpaGxk97lhk+pdYY8G6zMOXYJ2nvs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qHSoYu3/jifWSgHMswV2CCRRUZsTlyn5oWtraxWiEUchD6VNJy9P5C3HfSQCRUUB5uCEjvtxWc+cZw5cmdknQNSmgaVN8hMAkZJ9KYWVJV0pW/KQ+RheI5YcdzSFETpM6Pub6RhQ0TYvmSmEnxC6TU7GPNBwLZWx/PjlQPphaYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F2bzBJTE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28edea9af6so7507855276.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729558545; x=1730163345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tq3cNUO91Vvfgq5tI/z1NounXZjIn6GDS1+EJ7csv/E=;
        b=F2bzBJTE2b1F7w/vnfVBcD4MeMsb92WkB1Uv9wv/ecRtX2U4wj9jz/IFhyziEuvgHX
         qQSl4tOgje8WauCAVjq41w0FozuQXC37xQGAoz45Og621waLgl+O3/uZxkoDymJBqEWW
         X0x4PE+25FPiUph2FRwzt3Xrx0pFv2dfPzyQdV43HVVOC/osRdhHVTvk7Imc90JvKSM7
         2D8wDG6vOyDaV7DoxQBoKTay/1L6a5YhyF298+Wq988dQl+L/GcCSrIgQNzuO5ATepc5
         SYCvG1AB24E0pWFMGogTUpOCAbYVwWgNHlrOLaset0o98zsJvTrPH+4vfRjeQz0AfCpa
         JZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729558545; x=1730163345;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tq3cNUO91Vvfgq5tI/z1NounXZjIn6GDS1+EJ7csv/E=;
        b=i17keuuJ159YZKvbd4p3ZWhMSDjP4wlIKT6qQSntoY150n6hXnArYoKdHKVOyCwvmp
         w/xGNOUxmfww4ZPBL9c3IBQW8AT8C5XcCdq8h4Yt2fo6Hvpe914EEXQDYW9y5kouO99A
         Sej37Q7sH48lcc9jY1vW2ZbJEy8lygupMLbzsnh3W9X714JLJplNDfAiIKzJXJExLqo9
         66AVf4v/vVucGbTROlS0si/LTTLKsCcUASvp13ziDR+c5SNp8XLFiAiPyjmzOY9355KD
         1y+7a1WPP6OyDJr0IxDxW5LsGjtpJNGrotrIDZop55cZGRQ0ONLsHMSocf0DLV+m2HsN
         oX9A==
X-Forwarded-Encrypted: i=1; AJvYcCVVR/sNvur+wpOoqeMuDN2OmnbsTl5LRl+RP8MFTnRdzkTDU1CUduocwlHWtoYxUi0liOcNGReJJNwTYJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbVmeUQjZunLlZoJdBSXHjaJ+TiEYLWZJvWwpK6pU5zGLQO/Ng
	LnBSpC4TalkGdITvNCdZxpTCDJuFvlnG+iKV6iWH6GPM/CM0LRaKV16uaNgT8lXDv+3Eo3UOyxD
	ptQ==
X-Google-Smtp-Source: AGHT+IH7kfJdxNMEfZg9Xeveg6Vy9o9/9o56WmGVBFGfMm/buRcX/ZXrs9PYDx+l/JDWHiEcvXeAcDKATc4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:97c7:0:b0:e0b:af9b:fb79 with SMTP id
 3f1490d57ef6-e2bb12db995mr31889276.3.1729558544863; Mon, 21 Oct 2024 17:55:44
 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:55:43 -0700
In-Reply-To: <1d6044e0d71cd95c477e319d7e47819eee61a8fc.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231002115723.175344-1-mlevitsk@redhat.com> <ZRsYNnYEEaY1gMo5@google.com>
 <1d6044e0d71cd95c477e319d7e47819eee61a8fc.camel@redhat.com>
Message-ID: <Zxb4D_JCC-L7OQDT@google.com>
Subject: Re: [PATCH v3 0/4] Allow AVIC's IPI virtualization to be optional
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Finally got back to this...

On Wed, Oct 04, 2023, Maxim Levitsky wrote:
> =D0=A3 =D0=BF=D0=BD, 2023-10-02 =D1=83 12:21 -0700, Sean Christopherson =
=D0=BF=D0=B8=D1=88=D0=B5:
> > On Mon, Oct 02, 2023, Maxim Levitsky wrote:
> > > Hi!
> > >=20
> > > This patch allows AVIC's ICR emulation to be optional and thus allows
> > > to workaround AVIC's errata #1235 by disabling this portion of the fe=
ature.
> > >=20
> > > This is v3 of my patch series 'AVIC bugfixes and workarounds' includi=
ng
> > > review feedback.
> >=20
> > Please respond to my idea[*] instead of sending more patches.=20
>=20
> Hi,
>=20
> For the v2 of the patch I was already on the fence if to do it this way o=
r to
> refactor the code, and back when I posted it, I decided still to avoid th=
e
> refactoring.
>=20
> However, your idea of rewriting this patch, while it does change less lin=
es
> of code, is even less obvious and consequently required you to write even
> longer comment to justify it which is not a good sign.

Agreed.  And FWIW, if we keep the local "entry" variables, I actually like =
your
version much better.

> In particular I don't want someone to find out later, and in the hard way
> that sometimes real physid table is accessed, and sometimes a fake copy o=
f it
> is.

Note, this quirk is present in your v2 as well.  I bring that up only becau=
se I
prefer your v2, and rebased it (with massaging) on top of the next version =
of the
max vCPUs.  This is what I have currently:

-       WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
+       svm->avic_physical_id_entry =3D entry;
+
+       /*
+        * If IPI virtualization is disable, don't update the actual Physic=
al
+        * ID table, so that the CPU never sees IsRunning=3D1.
+        */
+       if (enable_ipiv)
+               WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], =
entry);
+

I have no objection to writing the "real" table, but with IsRunning=3D0.  T=
hat's
easy enough to do, e.g. tweak the above to:

	/*
	 * If IPI virtualization is disabled, clear IsRunning when updating the
	 * actual Physical ID table, so that the CPU never sees IsRunning=3D1.
	 */
	if (!enable_ipiv)
		entry &=3D ~AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;

	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);

> So I decided to fix the root cause by not reading the physid table back,
> which made the code cleaner, and even with the workaround the code IMHO i=
s
> still simpler than it was before.
>=20
> About the added 'vcpu->loaded' variable, I added it also because it is
> something that is long overdue to be added, I remember that in IPIv code
> there was also a need for this, and probalby more places in KVM can be
> refactored to take advantage of it, instead of various hacks.

I don't view using the information from the Physical ID table as a hack.  I=
t very
explicitly uses the ir_list_lock to ensure that the pCPU that's programmed =
into
the IRTE is the pCPU on which the vCPU is loaded, and provides rather stric=
t
ordering between task migration and device assignment.  It's not a super ho=
t path,
so I don't think lockless programming is justified.

I also think we should keep IsRunning=3D1 when the vCPU is unloaded.  That =
approach
won't run afoul of your concern with signaling the wrong pCPU, because KVM =
can
still keep the ID up-to-date, e.g. if the task is migrated when a pCPU is b=
eing
offlined.

The motiviation for keeping IsRunning=3D1 is to avoid unnecessary VM-Exits =
and GA
log IRQs.  E.g. if a vCPU exits to userspace, there's zero reason to force =
IPI
senders to exit, because KVM can't/won't notify userspace, and the pending =
virtual
interrupt will be processed on the next VMRUN.

> I did adopt your idea of using 'enable_ipiv', although I am still not 100=
%
> sure that this is more readable than 'avic_zen2_workaround'.

The problem with "avic_zen2_workaround" is that it becomes nonsensical if a=
 user
wants to disable IPI virtualization on a CPU that isn't affected by the err=
atum.
And I also think KVM should disallow enabling IPI virtualization if the CPU=
 is
affected by the erratum; even with HLT-exiting disabled on every VM, kvm_vc=
pu_block()
is still reachable, so I don't think it's at all reasonable to expect a use=
r to
be able to know when it's safe to ignore the erratum.

