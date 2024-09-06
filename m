Return-Path: <linux-kernel+bounces-318784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A51A496F34C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D131A1C20BEB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF1C1CB33F;
	Fri,  6 Sep 2024 11:42:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602A11CB12E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725622926; cv=none; b=jNes4obvYJch56QZsyjhisU7MtCicWndOEsZSePuAd1g0m5pZGM+7BFXf3ec+mWhM0tXUlNHJqbhLqAgtEDh/YOkVyxFG4G6qHJCHyger2j9OrMwuIoI7x7yvbK5GYB0C/wb5R4sfFSwF1sYyJ4wl35EpXT1UkZLyH7qqEt36KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725622926; c=relaxed/simple;
	bh=1LCwCLkRxcVwZ5qDIkjo5FpCFQUWpwXvn7CgtRWDhPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akoyJEaYSEs3JcXjouz1O3LEaFyjcuxDQOzQG7SIaiWLqprFe/YoFSsQLs/MLOkurO3vaRwFK5P188vcnjihcOfqUYXQUylCoKECtVFIwyYuCPKwEiZdNDueafjAgrZZxxJ4a/1K1HQJHqkCszeKVqVLbkQqrMJcNh712yTWQPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE94CFEC;
	Fri,  6 Sep 2024 04:42:31 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9821A3F73B;
	Fri,  6 Sep 2024 04:42:03 -0700 (PDT)
Date: Fri, 6 Sep 2024 12:42:01 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "tiantao (H)" <tiantao6@hisilicon.com>
Cc: catalin.marinas@arm.com, will@kernel.org, jonathan.cameron@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com
Subject: Re: [PATCH] arm64: Add ARM64_HAS_LSE2 CPU capability
Message-ID: <Ztrqie427P_Lxaoh@J2N7QTR9R3>
References: <20240906090812.249473-1-tiantao6@hisilicon.com>
 <ZtrPCVhqj5qLrQVY@J2N7QTR9R3>
 <587f7c84-cdfc-b348-4cd0-1015adad2cca@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <587f7c84-cdfc-b348-4cd0-1015adad2cca@hisilicon.com>

On Fri, Sep 06, 2024 at 06:58:19PM +0800, tiantao (H) wrote:
> 
> 在 2024/9/6 17:44, Mark Rutland 写道:
> > On Fri, Sep 06, 2024 at 05:08:12PM +0800, Tian Tao wrote:
> > > When FEAT_LSE2 is implemented and Bit 6 of sctlr_elx is nAA, the
> > > full name of the Not-aligned access. nAA bit has two values:
> > > 0b0 Unaligned accesses by the specified instructions generate an
> > > Alignment fault.
> > > 0b1 Unaligned accesses by the specified instructions do not generate
> > > an Alignment fault.
> > > 
> > > this patch sets the nAA bit to 1,The following instructions will not
> > > generate an Alignment fault if all bytes being accessed are not within
> > > a single 16-byte quantity:
> > > • LDAPR, LDAPRH, LDAPUR, LDAPURH, LDAPURSH, LDAPURSW, LDAR, LDARH,LDLAR,
> > > LDLARH.
> > > • STLLR, STLLRH, STLR, STLRH, STLUR, and STLURH
> > > 
> > > Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> > What is going to depend on this? Nothing in the kernel depends on being
> > able to make unaligned accesses with these instructions, and (since you
> > haven't added a HWCAP), userspace has no idea that these accesses won't
> > generate an alignment fault.
> > 
> > Mark.
> 
> I've come across a situation where the simplified code is as follows:
> 
>  long  address = (long) mmap(NULL,1024*1024*2,PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS,-1,0);
> 
> long new_address = address + 9;
> 
>  long *p = (long*) new_address;
>  long v = -1;
> 
>  __atomic_store(p, &v, __ATOMIC_RELEASE);

Hold on; looking at the ARM ARM (ARM DDI 0487K.a), the example and the
patch are both bogus. NAK to this patch, explanation below.

Per section B2.2.1.1 "Changes to single-copy atomicity in Armv8.4", all of the
LSE2 relaxations on alignment require:

| all bytes being accessed are within a 16-byte quantity that is aligned
| to 16 bytes

In your example you perform an 8-byte access at an offset of 9 bytes,
which means the access is *not* contained within 16 bytes, and is *not*
guaranteed to be atomic. That code simply has to be fixed, the kernel
cannot magically make it safe.

Regardless of that, the nAA bit *only* causes an alignment fault for
accesses which cannot be atomic. If a CPU has LSE2 and SCTLR_ELx.nAA=0,
an unaligned access within 16 bytes (which would be atomic) does not
cause an alignment fault. That's pretty clear from the description of
nAA and the AArch64.UnalignedAccessFaults() pseudocode:

| boolean AArch64.UnalignedAccessFaults(AccessDescriptor accdesc, bits(64) address, integer size)
|     if AlignmentEnforced() then
|         return TRUE;
|     elsif accdesc.acctype == AccessType_GCS then
|         return TRUE;
|     elsif accdesc.rcw then
|         return TRUE;
|     elsif accdesc.ls64 then
|         return TRUE;
|     elsif accdesc.exclusive || accdesc.atomicop then
|         return !IsFeatureImplemented(FEAT_LSE2) || !AllInAlignedQuantity(address, size, 16);
|     elsif accdesc.acqsc || accdesc.acqpc || accdesc.relsc then
|         return (!IsFeatureImplemented(FEAT_LSE2) ||
|                 (SCTLR_ELx[].nAA == '0' && !AllInAlignedQuantity(address, size, 16)));
|     else
|         return FALSE;

Note that when FEAT_LSE2 is implemented, unaligned atomic accesss within
a 16-byte window never raise an alignment fault, regardless of the value
of the nAA bit.

Setting the nAA bit only hides where atomicity is lost, and does not
make code function correctly. Consequently, that only serves to hide
bugs, making those harder to detect, debug, and fix. Thus I see no
reason to set the nAA bit.

So as above, NAK to this path. Please fir your broken userspace code.

Mark.

