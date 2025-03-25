Return-Path: <linux-kernel+bounces-574638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1607A6E7EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 347717A39B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEB1149C6F;
	Tue, 25 Mar 2025 01:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZPRRp74"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0DF2AD2D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742865828; cv=none; b=L1IfA3DqjQxbB3vZOMR6OwDVC/kHZItIYaiEuW5519Vvc6qXXKSu47n59p/ejdRRL12nEKCv/NIGcP/pPfEgsuqoTqinbr781ORuluveJoWO+WVftQujGt5BIb8nO42hglk2uYta10I2yz6CkJ2/ZROJInGNWzGoIKmzPinvCAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742865828; c=relaxed/simple;
	bh=dmXOgSyiMkzP5lmOjikLvzTL3OGmqHkvRNIsCLUyNUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4u+PJsMzhaV2072vp/w91wfKRiOcO623mxRYKHLoaFwyhCIzjrBPkkxIR7TRqwrNMqEzrdYnL13KNUt3b6RgtNZIEu/5wMbB3j9eyFDKGokaQ113WlAeIapAShWJQRfgHU5UKp8lQNND2YeguImQSCYVL/YevSwQM7J5KLafZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZPRRp74; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742865825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80YXslX43Vd+KzUMLEtvDw9pbdwUBTF2zW23HR+RDds=;
	b=TZPRRp74mFhm3kfkgSDZisTDWCN/BEAIvX8sVo9SkkPtev0LXoHwCRZ8ByTEzsSwRYe0UX
	MpJ7ekxNA7gEVGJPrOX6/zl+65W9ItEgEV5wXd5XGSipV2vppoKYaWVxYfszd0vxQnO+dy
	RsyjpjQ8JoQ3cUbL4uvwc9b8JJGY2Io=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-ZPx4-XNENRmpnTKz1GMXjQ-1; Mon, 24 Mar 2025 21:23:43 -0400
X-MC-Unique: ZPx4-XNENRmpnTKz1GMXjQ-1
X-Mimecast-MFC-AGG-ID: ZPx4-XNENRmpnTKz1GMXjQ_1742865821
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d5bb1708e4so2357465ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742865821; x=1743470621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80YXslX43Vd+KzUMLEtvDw9pbdwUBTF2zW23HR+RDds=;
        b=pWpz/bZnrh9Ut39961EJiCKmXT03VufggU3Bp0+uo4nHad8Ke8N4Nz+KfyZUb7EzUR
         a8rmgQwRRGxH2nwDNwjLVjkner68Q8nBBv7hTgERQawMwwht6y0i4M5r+M7VvQFE9aD8
         VygZrr43Unof5L3ZlUNGYQtQqcdB+oymjqfYMf+7PiYS7e9b7Ugav0GTHBmaypRPrKhd
         F0Xc57AiOOEO8nmj18g3DwX04NRZWLH2/PZy1o4gu8EZ+xs6Kg9Q/j8yf+LbXcDWeBN/
         feC7TZSgO1QTSCL+qOI4WXWtVNktniLWp1RVscVVjRjqQzxdvcWw8uZs/IkGaoP5ck+G
         41vw==
X-Forwarded-Encrypted: i=1; AJvYcCXD5KQELokIbISvuqIXx0iVUEjLgKqXIwQdKEf94rywuzwVcVEcaq+tspnJjeZfBAWA0XE5aifHt+1qBDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWew3CG+SvG+4QN9LtfaNUqhN28VRp0dZ4MpCpieDppP7r+7ry
	WS45WIVdIB0/UGUcoagz/po98rmIKW4X2UOf8+8ZVoBbxw+3v+yFTqnSCwh2BigAA3dxn/Us46H
	sB9XcOkF5XQMSYQJk+FMJbA7iPFs7cBRgHlGmzjvfauXu2nxbV0NAuj9niShP2b2v0PsdSBe8A9
	HERMQaj7e20tjUFHBCjZegwQ78cEUWLEs10WHl
X-Gm-Gg: ASbGncs+ubl6eauspT4p20vJBE5lf2FyLFB3V9n3Qts4g76gRippO1ycfEekAB1l5ab
	krBh6zpuK0i8ZjeUQEIb0OAHjcTmIiYeqlsNMT8uD+aI6Evzj6TtjrCQEY/Ubt97LWBCMb1gaSg
	==
X-Received: by 2002:a05:6e02:349c:b0:3d3:dd60:bc37 with SMTP id e9e14a558f8ab-3d5961c530dmr173137175ab.22.1742865821202;
        Mon, 24 Mar 2025 18:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/JUKTQmyT7rmzB1113MDJsVnMSnwa5fEmJ4QQvGW8nT/qrXson+JpXQKKM8geQr7VEFqwbzNfblKLM2iKFAI=
X-Received: by 2002:a05:6e02:349c:b0:3d3:dd60:bc37 with SMTP id
 e9e14a558f8ab-3d5961c530dmr173136965ab.22.1742865820779; Mon, 24 Mar 2025
 18:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-12-changyuanl@google.com> <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
 <CA+CK2bC4PM0JnHOUm7qfpQ=wUhwsYQ-hJ12tTK_7pSWgYk+bhg@mail.gmail.com>
In-Reply-To: <CA+CK2bC4PM0JnHOUm7qfpQ=wUhwsYQ-hJ12tTK_7pSWgYk+bhg@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 25 Mar 2025 09:24:02 +0800
X-Gm-Features: AQ5f1JqwitaQjBg4ofN5mWtcdKnJXVa6ylkj6L0R0h_oYxt_kysMu1ZOpV0VfzE
Message-ID: <CALu+AoRL+oHW2vN8nf1wpsG2Ki8d44AABQRCBMd+CE4_XzqRTw@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] kexec: add config option for KHO
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org, graf@amazon.com, 
	akpm@linux-foundation.org, luto@kernel.org, anthony.yznaga@oracle.com, 
	arnd@arndb.de, ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, dave.hansen@linux.intel.com, dwmw2@infradead.org, 
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, 
	krzk@kernel.org, rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	hpa@zytor.com, peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org, 
	robh@kernel.org, saravanak@google.com, skinsburskii@linux.microsoft.com, 
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, will@kernel.org, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Mar 2025 at 03:27, Pasha Tatashin <pasha.tatashin@soleen.com> wr=
ote:
>
> On Mon, Mar 24, 2025 at 12:18=E2=80=AFAM Dave Young <dyoung@redhat.com> w=
rote:
> >
> > On Thu, 20 Mar 2025 at 23:05, Changyuan Lyu <changyuanl@google.com> wro=
te:
> > >
> > > From: Alexander Graf <graf@amazon.com>
> > >
> > > We have all generic code in place now to support Kexec with KHO. This
> > > patch adds a config option that depends on architecture support to
> > > enable KHO support.
> > >
> > > Signed-off-by: Alexander Graf <graf@amazon.com>
> > > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> > > Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> > > ---
> > >  kernel/Kconfig.kexec | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> > > index 4d111f871951..57db99e758a8 100644
> > > --- a/kernel/Kconfig.kexec
> > > +++ b/kernel/Kconfig.kexec
> > > @@ -95,6 +95,21 @@ config KEXEC_JUMP
> > >           Jump between original kernel and kexeced kernel and invoke
> > >           code in physical address mode via KEXEC
> > >
> > > +config KEXEC_HANDOVER
> > > +       bool "kexec handover"
> > > +       depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXE=
C_FILE
> > > +       select MEMBLOCK_KHO_SCRATCH
> > > +       select KEXEC_FILE
> > > +       select DEBUG_FS
> > > +       select LIBFDT
> > > +       select CMA
> > > +       select XXHASH
> > > +       help
> > > +         Allow kexec to hand over state across kernels by generating=
 and
> > > +         passing additional metadata to the target kernel. This is u=
seful
> > > +         to keep data or state alive across the kexec. For this to w=
ork,
> > > +         both source and target kernels need to have this option ena=
bled.
> > > +
> >
> > Have you tested kdump?  In my mind there are two issues,  one is with
> > CMA enabled, it could cause kdump crashkernel memory reservation
> > failures more often due to the fragmented low memory.  Secondly,  in
>
> As I understand cma low memory scratch reservation is needed only to
> support some legacy pci devices that cannot use the full 64-bit space.
> If so, I am not sure if KHO needs to be supported on machines with
> such devices. However, even if we keep it, it should really be small,
> so I would not expect that to be a problem for crash kernel memory
> reservation.

It is not easy to estimate how much of the KHO reserved memory is
needed.  I assume this as a mechanism for all different users, it is
not  predictable.  Also it is not only about the size, but also it
makes the memory fragmented.

>
> > kdump kernel dump the crazy scratch memory in vmcore is not very
> > meaningful.  Otherwise I suspect this is not tested under kdump.  If
> > so please disable this option for kdump.
>
> The scratch memory will appear as regular CMA in the vmcore. The crash
> kernel can be kexec loaded only from userland, long after the scratch
> memory is converted to CMA.

Depending on the reserved size, if big enough it should be excluded in
vmcore dumping.
Otherwise if it is a kdump kernel it should skip the handling of the
KHO passed previous old states.

>
> Pasha
>


