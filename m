Return-Path: <linux-kernel+bounces-318914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF2396F506
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E78288273
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BE81CEABD;
	Fri,  6 Sep 2024 13:06:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1181CDFBB
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627967; cv=none; b=bnXAAFRoBLxMKbd5im6ZmnYTF9cTyH19DnibWd37UkZjjyC4yAGH7P26ySWOFQpnrcD38chc+WRuXHFBqq17yEv9t62x455gD4AwQMHXpULbII/p+ycCpXo+zyHgmstoI+1L2/L9RDH9ZgQUJ6MdikQpZthWysSelGYrL6wf31c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627967; c=relaxed/simple;
	bh=52eTM5yLTGYYQTZpZE1b7zlItuXgmXIFPNQUpB74Av4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGdX2PJaZ2/IQCiXDGtPYOJC2io82R8l+gJTLRrg9tH2dpCpXLVxZMEck8fIMzjFWDoEf7xb4K2B67BltMkkqgbm2WnBh/h/CD4CyzRT++w8yxqPetIrJWcvNh1+/lrKQh4WBEvCxryiku8WlaDCpfOXngiP97L/nhFgejznJ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E4D8DA7;
	Fri,  6 Sep 2024 06:06:31 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 387F53F73B;
	Fri,  6 Sep 2024 06:06:03 -0700 (PDT)
Date: Fri, 6 Sep 2024 14:05:57 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "tiantao (H)" <tiantao6@hisilicon.com>
Cc: catalin.marinas@arm.com, will@kernel.org, jonathan.cameron@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com
Subject: Re: [PATCH] arm64: Add ARM64_HAS_LSE2 CPU capability
Message-ID: <Ztr-FHF5MG1YvLse@J2N7QTR9R3.cambridge.arm.com>
References: <20240906090812.249473-1-tiantao6@hisilicon.com>
 <ZtrPCVhqj5qLrQVY@J2N7QTR9R3>
 <587f7c84-cdfc-b348-4cd0-1015adad2cca@hisilicon.com>
 <Ztrqie427P_Lxaoh@J2N7QTR9R3>
 <54980e73-4a1c-1eb2-98b4-fbb49e9a9b8f@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54980e73-4a1c-1eb2-98b4-fbb49e9a9b8f@hisilicon.com>

On Fri, Sep 06, 2024 at 08:20:19PM +0800, tiantao (H) wrote:
> 
> 在 2024/9/6 19:42, Mark Rutland 写道:
> > On Fri, Sep 06, 2024 at 06:58:19PM +0800, tiantao (H) wrote:
> > > 在 2024/9/6 17:44, Mark Rutland 写道:
> > > > On Fri, Sep 06, 2024 at 05:08:12PM +0800, Tian Tao wrote:
> > > I've come across a situation where the simplified code is as follows:
> > > 
> > >   long  address = (long) mmap(NULL,1024*1024*2,PROT_READ|PROT_WRITE,
> > > MAP_PRIVATE|MAP_ANONYMOUS,-1,0);
> > > 
> > > long new_address = address + 9;
> > > 
> > >   long *p = (long*) new_address;
> > >   long v = -1;
> > > 
> > >   __atomic_store(p, &v, __ATOMIC_RELEASE);
> > Hold on; looking at the ARM ARM (ARM DDI 0487K.a), the example and the
> > patch are both bogus. NAK to this patch, explanation below.
> > 
> > Per section B2.2.1.1 "Changes to single-copy atomicity in Armv8.4", all of the
> > LSE2 relaxations on alignment require:
> > 
> > | all bytes being accessed are within a 16-byte quantity that is aligned
> > | to 16 bytes
> > 
> > In your example you perform an 8-byte access at an offset of 9 bytes,
> > which means the access is *not* contained within 16 bytes, and is *not*
> > guaranteed to be atomic. That code simply has to be fixed, the kernel
> > cannot magically make it safe.
> > 
> > Regardless of that, the nAA bit *only* causes an alignment fault for
> > accesses which cannot be atomic. If a CPU has LSE2 and SCTLR_ELx.nAA=0,
> > an unaligned access within 16 bytes (which would be atomic) does not
> > cause an alignment fault. That's pretty clear from the description of
> > nAA and the AArch64.UnalignedAccessFaults() pseudocode:
> 
> Sorry, this example is just for verifying nnA, it's not an example of a real
> scenario,
> 
> we have scenarios that don't require atomicity to be guaranteed, they just
> require that coredump doesn't occur when non-aligned

Please give a concrete explanation of such a scenario, with an
explanation of why atomicity is not required.

Mark.

