Return-Path: <linux-kernel+bounces-541950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AE8A4C3B9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09094170FA4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480B5214202;
	Mon,  3 Mar 2025 14:45:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4CC214217
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013134; cv=none; b=gzG0GuF5/C9oKBxjDqZHwu97CFEKrx1QBMdbmXTn0uwpqA03bbi8cSK1bVmNeg19T7Zp8sP+9oYJKp/1C/SFup+Wi93nkWedrchSePlCY1HrsmoPu4R4BvhuCDV8YZxpqs7nYUL8yVXaAikwd6h5uREUV8m5e28zV9yfNNOQPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013134; c=relaxed/simple;
	bh=sS66acge6yiIBQa1JeXzb4CY96goAFvbCv1lCn2Hhy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvAm0N2yuSSIyEsl7r0W1V5MiK+yH4hav4ZVlvY/sbyo9WWR3epBMzsfLYe8OIMRD5ZOYa20al+RCZ9RV7FQ48Avh4Sv1Jpsz5wj8d1gvxuhpw94IvwLTfAO/IFI7X+TLi8VB0snuczmaId8Ol79o0poNKPHcVnoPLM7e6VUo4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72BAD106F;
	Mon,  3 Mar 2025 06:45:46 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41B9D3F66E;
	Mon,  3 Mar 2025 06:45:31 -0800 (PST)
Date: Mon, 3 Mar 2025 14:45:28 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Paul Benoit <paul@os.amperecomputing.com>,
	Mark Rutland <mark.rutland@arm.com>
Cc: <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4] firmware: smccc: Support optional Arm SMC SOC_ID name
Message-ID: <Z8XAiMSoaOmR5JxY@bogus>
References: <20241114030452.10149-1-paul@os.amperecomputing.com>
 <20250219005932.3466-1-paul@os.amperecomputing.com>
 <Z8W6HXZy46K7ebWe@J2N7QTR9R3.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8W6HXZy46K7ebWe@J2N7QTR9R3.cambridge.arm.com>

On Mon, Mar 03, 2025 at 02:18:05PM +0000, Mark Rutland wrote:
> Hi Paul,
>
> This looks generally good with a couple of minor nits.
>
> On Tue, Feb 18, 2025 at 04:59:32PM -0800, Paul Benoit wrote:
> > Issue Number 1.6 of the Arm SMC Calling Convention introduces an optional
> > SOC_ID name string.  If implemented, point the 'machine' field of the SoC
> > Device Attributes at this string so that it will appear under
> > /sys/bus/soc/devices/soc0/machine.
> >
> > On Arm SMC compliant SoCs, this will allow things like 'lscpu' to
> > eventually get a SoC provider model name from there rather than each
> > tool/utility needing to get a possibly inconsistent, obsolete, or incorrect
> > model/machine name from its own hardcoded model/machine name table.
> >
> > Signed-off-by: Paul Benoit <paul@os.amperecomputing.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > ---

[...]

> > +static char __init *smccc_soc_name_init(void)
> > +{
> > +	struct arm_smccc_1_2_regs args;
> > +	struct arm_smccc_1_2_regs res;
> > +	size_t len;
> > +
> > +	/*
> > +	 * Issue Number 1.6 of the Arm SMC Calling Convention
> > +	 * specification introduces an optional "name" string
> > +	 * to the ARM_SMCCC_ARCH_SOC_ID function.  Fetch it if
> > +	 * available.
> > +	 */
> > +	args.a0 = ARM_SMCCC_ARCH_SOC_ID;
> > +	args.a1 = 2;    /* SOC_ID name */
> > +	arm_smccc_1_2_invoke(&args, &res);
> > +	if ((u32)res.a0 == 0) {
> > +		const unsigned int regsize = sizeof(res.a1);
> > +
> > +		/*
> > +		 * Copy res.a1..res.a17 to the smccc_soc_id_name string
> > +		 * 8 bytes at a time.  As per Issue 1.6 of the Arm SMC
> > +		 * Calling Convention, the string will be NUL terminated
> > +		 * and padded, from the end of the string to the end of the
> > +		 * 136 byte buffer, with NULs.
> > +		 */
> > +		str_fragment_from_reg(smccc_soc_id_name + 0*regsize, res.a1);
> > +		str_fragment_from_reg(smccc_soc_id_name + 1*regsize, res.a2);
> > +		str_fragment_from_reg(smccc_soc_id_name + 2*regsize, res.a3);
> > +		str_fragment_from_reg(smccc_soc_id_name + 3*regsize, res.a4);
> > +		str_fragment_from_reg(smccc_soc_id_name + 4*regsize, res.a5);
> > +		str_fragment_from_reg(smccc_soc_id_name + 5*regsize, res.a6);
> > +		str_fragment_from_reg(smccc_soc_id_name + 6*regsize, res.a7);
> > +		str_fragment_from_reg(smccc_soc_id_name + 7*regsize, res.a8);
> > +		str_fragment_from_reg(smccc_soc_id_name + 8*regsize, res.a9);
> > +		str_fragment_from_reg(smccc_soc_id_name + 9*regsize, res.a10);
> > +		str_fragment_from_reg(smccc_soc_id_name + 10*regsize, res.a11);
> > +		str_fragment_from_reg(smccc_soc_id_name + 11*regsize, res.a12);
> > +		str_fragment_from_reg(smccc_soc_id_name + 12*regsize, res.a13);
> > +		str_fragment_from_reg(smccc_soc_id_name + 13*regsize, res.a14);
> > +		str_fragment_from_reg(smccc_soc_id_name + 14*regsize, res.a15);
> > +		str_fragment_from_reg(smccc_soc_id_name + 15*regsize, res.a16);
> > +		str_fragment_from_reg(smccc_soc_id_name + 16*regsize, res.a17);
> 
> Please get rid of 'regsize' and use '8' directly. This only exists for
> arm64, where the registeres are 8 bytes, and the comment immediately
> above refers to "8 bytes" specifically anyway, so 'regsize' only serves
> to make this harder to read.
> 
> It'd be a bit clearer as:
> 
> 	str_fragment_from_reg(smccc_soc_id_name + 8 * 0,  res.a1);
> 	str_fragment_from_reg(smccc_soc_id_name + 8 * 1,  res.a2);
> 	...
> 	str_fragment_from_reg(smccc_soc_id_name + 8 * 15, res.a16);
> 	str_fragment_from_reg(smccc_soc_id_name + 8 * 16, res.a17);
> 
> Sudeep, are you happy to fix that up when applying?
> 
> > +
> > +		len = strnlen(smccc_soc_id_name, sizeof(smccc_soc_id_name));
> > +		if (len) {
> > +			if (len == sizeof(smccc_soc_id_name))
> > +				pr_warn(FW_BUG "Ignoring improperly formatted Name\n");
> 
> It's odd that 'Name' is capitalized here. Not a big deal, but it doesn't
> look quite right.
>

I can fix both of these and apply. No need to repost.

-- 
Regards,
Sudeep

