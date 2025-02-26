Return-Path: <linux-kernel+bounces-533266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65000A457A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768F41887AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468FF258CE7;
	Wed, 26 Feb 2025 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LEbWlcYA"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D8D258CC8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556983; cv=none; b=hkmZ1wg/nvFgLsyqs+I6lBz6TCo9qni14lNzkWdkpMICa+5menpUw27TncoLptk93Yj2rpSI6czxD1z/H9UDeYUChhSM6iJ8yQUbaPSn/eKfXqdErPu9IDCpUGXFNcFBgdsiBaytJVCgoi/rkv3oW321t6D+kJlCKyVg3OPX5xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556983; c=relaxed/simple;
	bh=/avpYjwsVH3UwI19sicSVjGRs76KJPoO/nuC4aWewSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHM5tCm2yilBFcUKf4BzdaCEw4ClIIx5mRgsCPKHDXzDM3qis2ajloz/HDWygaBnnyL/UHC3mRioT8/4iWEfCWOgi4hFdDYPo9oTPe42PrSOdasFa0+g3fPOUpQMIlw8YZTk+WUwlwERvOzCGlM949nwBIFWCUS6V9+f+GQMLXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LEbWlcYA; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 00:02:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740556969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Umudae46qma0rLnaRVWxf7e3jia6FAzRnuS7p9TokA=;
	b=LEbWlcYA/kwL0+Fm2RuHPUtbPKnbItPI79RipLsu1pS47dqdSjSQ8gDnqkxvtplo2or/RV
	UKoKrt4pplEDmiZdQKHI5fTY5qgtqGvgeJS13Qe/ruKny/tsNRY2r/xPswD0QLCnj+zM4c
	SjqUw5T+7KalbBZl3ANYvDz9+kL2uS0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Marc Zyngier <maz@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, Joey Gouly <joey.gouly@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, Will Deacon <will@kernel.org>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Peter Collingbourne <pcc@google.com>
Subject: Re: [PATCH] KVM: arm64: Drop mte_allowed check during memslot
 creation
Message-ID: <Z77Kox18iINqlp6L@linux.dev>
References: <20250224093938.3934386-1-aneesh.kumar@kernel.org>
 <Z7xSfVME4z2ComUm@arm.com>
 <86ldtvr0nl.wl-maz@kernel.org>
 <Z7yElHKrJGn8XuPS@arm.com>
 <86jz9fqtbk.wl-maz@kernel.org>
 <yq5aseo3gund.fsf@kernel.org>
 <86ikozqmsl.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ikozqmsl.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 24, 2025 at 05:23:38PM +0000, Marc Zyngier wrote:
> On Mon, 24 Feb 2025 16:44:06 +0000, Aneesh Kumar K.V <aneesh.kumar@kernel.org> wrote:
> > What if we trigger a memory fault exit with the TAGACCESS flag, allowing
> > the VMM to use the GPA to retrieve additional details and print extra
> > information to aid in analysis? BTW, we will do this on the first fault
> > in cacheable, non-tagged memory even if there is no tagaccess in that
> > region. This can be further improved using the NoTagAccess series I
> > posted earlier, which ensures the memory fault exit occurs only on
> > actual tag access
> > 
> > Something like below?
> 
> Something like that, only with:
> 
> - a capability informing userspace of this behaviour
> 
> - a per-VM (or per-VMA) flag as a buy-in for that behaviour
> 
> - the relaxation is made conditional on the memslot not being memory
> (i.e. really MMIO-only).

I pretty much agree with you here but I think the flag ought to be a
per-memslot thing (rather than VMA or VM). Rather than open up the
entire memory attributes space to userspace we could just have a flag to
prevent cacheable mappings for the memslot.

Similar to how MTE is enforced today, we can have a shared check between
memslot creation && the abort path that'd require VM_MTE_ALLOWED for any
'cacheable memslot'. Failing memslot creation still is the clearest
signal of misuse to the VMM, IMO.

Thanks,
Oliver

