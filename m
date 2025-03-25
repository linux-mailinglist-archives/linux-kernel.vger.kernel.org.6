Return-Path: <linux-kernel+bounces-574785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3DFA6E9F1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0F8188C3BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 06:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2121621480B;
	Tue, 25 Mar 2025 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMn2VPv0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92ED2AE9A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742885890; cv=none; b=geemjzuRlRvqx6IpkqHkAU7rN3Xbq4jYfblJJ6ifdppEOcbWddQChF9N37wH2CdQTtOJ6X2DWCp4QKYKay2eXVo3GSOjTpO36T5otcL0/HhWjR3v688MTT8hV++3GPau/RTa2ZG/PM7ClMmxYybuXk0cXifV7LX1Hw793U9IRz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742885890; c=relaxed/simple;
	bh=h0fHlaZMz5XtoUH8OETHCDfjpLG0nPB1YaUWxFkCW2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMAF99uoxmf8BLp33KF5ClyHJKgWBwhRHQ3jjZ7lXmj+VuC8ndtjmBamo06YFlyBlX5yEVkYekSBXZsh+m2iETC+FX9+MMkPCSti+YWDTbY6GZViL0Nz9vzp+JXZcAZiiex5uXT/Cqv7o2V0HKWnHOHT2kEUgabprJNrEJKBpPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CMn2VPv0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742885887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=19WP4WFqsV7qujfoRGQmqqeN7h9hu1fjTeGwGJQZMdQ=;
	b=CMn2VPv0kfXBG9p7mG4vt2kG6ulZJpUKA9B0nEXJuz6kuXNMH7E0C14TMrA4gQdAO5LkLk
	9Pu4bm1u0piPs029Jl5j8//Dj4jnME+3gp0I+8RYOIjtw02eO8X8Pm/CoufXhjdR3BvG93
	RE8UL/3ma/9q3hGN9dQ5+0KRgDODx2Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-qE_0gAprMS2WIAV1lbNLxA-1; Tue,
 25 Mar 2025 02:58:04 -0400
X-MC-Unique: qE_0gAprMS2WIAV1lbNLxA-1
X-Mimecast-MFC-AGG-ID: qE_0gAprMS2WIAV1lbNLxA_1742885880
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E98ED18DBA01;
	Tue, 25 Mar 2025 06:57:58 +0000 (UTC)
Received: from localhost (unknown [10.72.112.60])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E607180B48C;
	Tue, 25 Mar 2025 06:57:54 +0000 (UTC)
Date: Tue, 25 Mar 2025 14:57:50 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Young <dyoung@redhat.com>
Cc: Changyuan Lyu <changyuanl@google.com>, linux-kernel@vger.kernel.org,
	graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org,
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com,
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, dwmw2@infradead.org,
	ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com,
	corbet@lwn.net, krzk@kernel.org, rppt@kernel.org,
	mark.rutland@arm.com, pbonzini@redhat.com,
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org,
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org,
	saravanak@google.com, skinsburskii@linux.microsoft.com,
	rostedt@goodmis.org, tglx@linutronix.de, thomas.lendacky@amd.com,
	usama.arif@bytedance.com, will@kernel.org,
	devicetree@vger.kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 11/16] kexec: add config option for KHO
Message-ID: <Z+JT7kx+sfPqfWFA@MiWiFi-R3L-srv>
References: <20250320015551.2157511-1-changyuanl@google.com>
 <20250320015551.2157511-12-changyuanl@google.com>
 <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALu+AoS01QJ-H5Vpr378rbx==iRQLG0HajtMCUzDXRO75biCag@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/24/25 at 12:18pm, Dave Young wrote:
> On Thu, 20 Mar 2025 at 23:05, Changyuan Lyu <changyuanl@google.com> wrote:
> >
> > From: Alexander Graf <graf@amazon.com>
> >
> > We have all generic code in place now to support Kexec with KHO. This
> > patch adds a config option that depends on architecture support to
> > enable KHO support.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Co-developed-by: Changyuan Lyu <changyuanl@google.com>
> > Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> > ---
> >  kernel/Kconfig.kexec | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> > index 4d111f871951..57db99e758a8 100644
> > --- a/kernel/Kconfig.kexec
> > +++ b/kernel/Kconfig.kexec
> > @@ -95,6 +95,21 @@ config KEXEC_JUMP
> >           Jump between original kernel and kexeced kernel and invoke
> >           code in physical address mode via KEXEC
> >
> > +config KEXEC_HANDOVER
> > +       bool "kexec handover"
> > +       depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
> > +       select MEMBLOCK_KHO_SCRATCH
> > +       select KEXEC_FILE
> > +       select DEBUG_FS
> > +       select LIBFDT
> > +       select CMA
> > +       select XXHASH
> > +       help
> > +         Allow kexec to hand over state across kernels by generating and
> > +         passing additional metadata to the target kernel. This is useful
> > +         to keep data or state alive across the kexec. For this to work,
> > +         both source and target kernels need to have this option enabled.
> > +
> 
> Have you tested kdump?  In my mind there are two issues,  one is with
> CMA enabled, it could cause kdump crashkernel memory reservation
> failures more often due to the fragmented low memory.  Secondly,  in

kho scracth memorys are reserved much later than crashkernel, we may not
need to worry about it.
====================
start_kernel()
  ......
  -->setup_arch(&command_line);
     -->arch_reserve_crashkernel();
  ......
  -->mm_core_init();
     -->kho_memory_init();

> kdump kernel dump the crazy scratch memory in vmcore is not very
> meaningful.  Otherwise I suspect this is not tested under kdump.  If
> so please disable this option for kdump.

Yeah, it's not meaningful to dump out scratch memorys into vmcore. We
may need to dig them out from eflcorehdr. While it's an optimization,
kho scratch is not big relative to the entire system memory. It can be
done in later stage. My personal opinion.


