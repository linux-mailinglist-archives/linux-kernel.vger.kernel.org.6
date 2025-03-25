Return-Path: <linux-kernel+bounces-575493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295DDA7034E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872EA3B46B8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B81F259CA4;
	Tue, 25 Mar 2025 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="RWsHP/xZ"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57CF259C96
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911502; cv=none; b=Sgj8HoMekC0TX+JJ3D+cFW9UKXzGe/4pa1lyo+0HJuB2tAOOejTVoTFi+SyzcnSEXsoMNXAQPQ4Ep+Nd4F+pwVd9VdnZOTqi/gxvtGQpZ8AtJ1SSzITTDGBuXqKffJW7UPe5CVv+9LvWV6v+j21gXN8ceQZ3e6HpqImLfm4aaDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911502; c=relaxed/simple;
	bh=HIjTuiJtFJRThNQQcmoXQWPTsKs5+eolgRd911Gghok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMV7VZN7l2KfLIhP4p0J8c1t0nKLzKRUs4p4RMwTaXB8aKcxHzwhb3CwkSsL65M9TOyoBfoTCod9bBRu2qxrMSqZSHHM5b6t6jqsdGO+rOY+7DnAs/xWzlu/Q8aTwQ7qeYy6c6xDGjs9O99mHJcX20LA/W5vaWdw2oW9zYvym90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=RWsHP/xZ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-476a304a8edso49670461cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1742911500; x=1743516300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKMJVcSSYFhFkaF9OI9BOHOle5JxWrFZ54yuemRi3B0=;
        b=RWsHP/xZPYgfNRNs03jXEhoGs6zwv4pwLS4MIqKu9kjEghj9hjEvZFoCGXJ83O3ETY
         5gD2f7OT/QfB8y9sVeiBchXYGwJ/hYkDHRobWuhx2oMsQ/Dneg3uOgJuYVWkRLQO4ZUx
         hoJfcz5cGEMPJI1BqRnrGWeDnJ959q7XscKYUobEYFzTn8IZIwZpThTWSTRVIlstVVpr
         GpbNcEUC/ueBBISs5M8WTWFe5NVcz8DzWF3HQKYmd46Avwf+WnwxBD6gskF0UqB742Ld
         Enq7Al+iM0G0dLrdrfn7ucUgVza6DSIdBMrAMkPnw9XHQ/lI5hka7yGN8x1/yGp6RXjn
         ea5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742911500; x=1743516300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKMJVcSSYFhFkaF9OI9BOHOle5JxWrFZ54yuemRi3B0=;
        b=fkpP5KhqalulQqMJCUGzYaYzf9BQqK19q6HNpVf3GvVpS5TDU7Y7NpiXTCXaoQFTDd
         SFwsOR0krW4LOsAjUtOBiR9Y/fa4sl6Vqp710Kmne0/ZLPxTphKaBq6oGJiqgqXwRBdm
         +0oaZKfExsDENa6pHoHLQ6Aq7EzaxE4ErpSX30Kryf/y+u/TBZtjesH0ZVgvfbC61sI/
         vazgmkULw5/ZW9SzbtmxC2oa+KyKz43m86peEP0WhWlGEEZIoE7agVwJUsaH6vm0+u3d
         Xwx4XBMQyAGejJcTrIZt5JykmmZ/GwzEDH8UcRDF47lzYF1mlaTYaZ/CdG/Tgu50nVf7
         xXJg==
X-Forwarded-Encrypted: i=1; AJvYcCWvweraiyZWchT6cRZDjfeDD+J9I3q8R9fNTbpCsytEISA3B0hARAJrz6HPEzMBNR2zh6oe8gTygmnIxlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC9dhXF/ZMQvn0vppA+UZ/8quX8hOQrZ2jNsOd3DK7A3u3YZI+
	oxSNElS8Fw+5cw9551t6jxh0CLzVJzD5n9n1bv0AbkYAcFK1ka9Kql9xTH2+xB39Hw2VCP6nW1s
	ifvOgCcOsdxro9RxKWhBRyCCjEUi/BAzQLvjIVA==
X-Gm-Gg: ASbGnctXjKhLIBr+XkCg9eWHivVcbkEMZzfgaezsCcuTCGWFoK16Cdlo7QURNFlmSoo
	aTZrtfUYztWyQ3gJ3dtVzTOLD+xZY2a5RmseP1QvsRXJnJPsWkaq91WwzyGsVLmOL/XQso4ctCy
	5OkajiOpetBlXprjac4VQZvEE/
X-Google-Smtp-Source: AGHT+IGMYVQtiX/h+EVJlPHZz5Rq/az3V8wIPVjd4SZUiiPGocRCmY6VSmvm0irS2U8qQcxFKzIzc2oRCd6fuO2LGmc=
X-Received: by 2002:a05:622a:248e:b0:476:b56d:eb46 with SMTP id
 d75a77b69052e-4771dd77d25mr264001271cf.15.1742911499617; Tue, 25 Mar 2025
 07:04:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-12-changyuanl@google.com> <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
 <Z+JT7kx+sfPqfWFA@MiWiFi-R3L-srv>
In-Reply-To: <Z+JT7kx+sfPqfWFA@MiWiFi-R3L-srv>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 25 Mar 2025 10:04:21 -0400
X-Gm-Features: AQ5f1Jrjo6HkojvC1uIVMuAy34VVl7CYnqSMt1jjfTIiYkTHpp9oYG_kKxOqyPA
Message-ID: <CA+CK2bB-qPV-QnqUwAv+OGujZwWLAAgBT0xH6fyKY8-cP1bNSQ@mail.gmail.com>
Subject: Re: [PATCH v5 11/16] kexec: add config option for KHO
To: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, Changyuan Lyu <changyuanl@google.com>, 
	linux-kernel@vger.kernel.org, graf@amazon.com, akpm@linux-foundation.org, 
	luto@kernel.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
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

On Tue, Mar 25, 2025 at 2:58=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> On 03/24/25 at 12:18pm, Dave Young wrote:
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
> kho scracth memorys are reserved much later than crashkernel, we may not
> need to worry about it.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> start_kernel()
>   ......
>   -->setup_arch(&command_line);
>      -->arch_reserve_crashkernel();
>   ......
>   -->mm_core_init();
>      -->kho_memory_init();
>
> > kdump kernel dump the crazy scratch memory in vmcore is not very
> > meaningful.  Otherwise I suspect this is not tested under kdump.  If
> > so please disable this option for kdump.
>
> Yeah, it's not meaningful to dump out scratch memorys into vmcore. We
> may need to dig them out from eflcorehdr. While it's an optimization,
> kho scratch is not big relative to the entire system memory. It can be
> done in later stage. My personal opinion.

But, we don't; we only dump out the regular CMA memory that absolutely
should be part of vmcore. When scratch is used during boot, it is used
for regular early boot kernel allocations, such as to allocate memmap,
which is an essential part of the crash dump.

Pasha

