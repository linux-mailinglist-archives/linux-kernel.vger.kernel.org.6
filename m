Return-Path: <linux-kernel+bounces-255484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC65934147
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39CE28165D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4E2181CE7;
	Wed, 17 Jul 2024 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THGtgR5V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E16F17E8E2;
	Wed, 17 Jul 2024 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236613; cv=none; b=i/Sr0nwVTxbjwhPX/eJoRzqSloKAVgDs+lpEkARw0kkIUDq+8HLYpbozUdS+o1BfM7IA5ADr0eqkOIuex+kIdU3UEWs5cbbeJZh/2x/XF5Vj9mLI6b/0qbt9lwwyIOpu5EGnLkCbnBx2eDh9B7g7ADjL5NdqpdVcIIF+OgidFV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236613; c=relaxed/simple;
	bh=yBRi4wphUoMe/4Zy6VzuKVwA0LEFrw39GK4vniN0oPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bF4xSXNfRB08Fj9d3esyuorYyC3GuqNYB6MHkQ+iGM5aurvfMZd31YQSgJyRuRqfNrJrTAlu2nu9HreZ7o+N81rh4mEKTKJWsPlKlYtU3+2FA+RgwaFibhneNAsdanSfw5UZh7VUQQK4w+m8Yh3Mq1u5CWzsF/vARQeZ5vpbsjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THGtgR5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25625C2BD10;
	Wed, 17 Jul 2024 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721236613;
	bh=yBRi4wphUoMe/4Zy6VzuKVwA0LEFrw39GK4vniN0oPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=THGtgR5Vlyrids+YPWcn3NUkai8KXh6dmNQet1PcEEn/3Aj7VIMCMsVb0ELsT53WR
	 KhxXdkDEuf2rAwT3skCTBPCj/Rlj3DMmiPodOtyOacWmkqjVw8PI51q6OAfgqu4y6i
	 CIPDJSg2uW8ABw/XwsQ2RKDS8qmVsMXmH91TD6ROHhQiqwRjdzMNLctiiRFAykULTz
	 /k0g5UgWEDtt8XfLrsQi/eiLIr+R95V76NtI2HCx7kZAhvGAx/4quyvulJvuc86VJn
	 KwSnj0pl/wa+psNh8M78DNjG/hsNk8P2963m3gWolN1ko/tlMSxEFrWr9HuReZRILu
	 q/FjeneGOUa9A==
Date: Wed, 17 Jul 2024 10:16:52 -0700
From: Kees Cook <kees@kernel.org>
To: "Balasubrmanian, Vignesh" <vigbalas@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Balasubrmanian, Vignesh" <Vignesh.Balasubrmanian@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"npiggin@gmail.com" <npiggin@gmail.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>,
	"George, Jini Susan" <JiniSusan.George@amd.com>,
	"matz@suse.de" <matz@suse.de>,
	"binutils@sourceware.org" <binutils@sourceware.org>,
	"jhb@FreeBSD.org" <jhb@freebsd.org>,
	"felix.willgerodt@intel.com" <felix.willgerodt@intel.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 1/1] x86/elf: Add a new .note section containing
 xfeatures buffer layout info to x86 core files
Message-ID: <202407171010.DC51195@keescook>
References: <20240712094630.29757-1-vigbalas@amd.com>
 <20240712094630.29757-2-vigbalas@amd.com>
 <87plrhshdl.ffs@tglx>
 <a4943b94-3407-42a0-9273-f7948ae8c35b@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4943b94-3407-42a0-9273-f7948ae8c35b@amd.com>

On Wed, Jul 17, 2024 at 03:02:23PM +0530, Balasubrmanian, Vignesh wrote:
> 
> On 7/13/2024 4:12 PM, Thomas Gleixner wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > On Fri, Jul 12 2024 at 15:16, Vignesh Balasubramanian wrote:
> > > diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> > > index 1fb83d477..cad37090b 100644
> > > --- a/arch/x86/include/asm/elf.h
> > > +++ b/arch/x86/include/asm/elf.h
> > > @@ -13,6 +13,15 @@
> > >   #include <asm/auxvec.h>
> > >   #include <asm/fsgsbase.h>
> > > 
> > > +struct xfeat_component {
> > > +     u32 type;
> > > +     u32 size;
> > > +     u32 offset;
> > > +     u32 flags;
> > > +} __packed;
> > > +
> > > +_Static_assert(sizeof(struct xfeat_component)%4 == 0, "xfeat_component is not aligned");
> > This struct is only used in xstate.c and asm/elf.h is not a UAPI
> > header. So what's the point of declaring it in the header instead of
> > xtsate.c?
> > 
> > If this needs to provided for user space consumption, then it want's to
> > be in a UAPI header, no?
> Our initial idea is to pass the "struct xfeat_component" through "glibc".
> is "include/uapi/linux/elf.h" proper header to add this ?

I'd rather not put arch-specific things in the main UAPI elf.h file
unless there is a good reason.

> I couldn't see any proper header inside "arch/x86/include/uapi/asm/".

Other architectures have arch/*/include/uapi/asm/elf.h, so it may be
time to add one for x86 too. For this to be UAPI, I would want to see
more explicit namespacing, e.g. struct x86_xfeat_component, etc.

-Kees

-- 
Kees Cook

