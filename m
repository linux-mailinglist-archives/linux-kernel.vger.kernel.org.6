Return-Path: <linux-kernel+bounces-541905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FF2A4C33B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DCBB18866E8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E32214801;
	Mon,  3 Mar 2025 14:18:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFFA213E81
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011493; cv=none; b=lmHR94Ygo923EwyuoD4nwPCIutC7FTnnNuNXlw9kS37nVAnfFbstYm8HAKYnt+GvXN6c4xqQd6cE89FQ2v7qGtVi6hC1Rr/PpFXdhDaqrkFXiayQtwhUbdNDnNdZbKWUwiJFpbM08ex7zMUINIkt9sxe5LK2oGyniejrChmDNk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011493; c=relaxed/simple;
	bh=0SP3nAnya9shQwTJ904iRRAXvKH8WbEBbTbDbMI7ag0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItH327hGbjGZ6IHNZ0kXJJ1lx4XAlOM1JP1KzDiyGIJNLPZsTH5VifVXJt1uNL8vEMkJdgFq8+9YFvAvIXNa6moN/UMG4ul2+LNvL9eW7OWNtP5+iGYoAvjhzpnoVtJEisNTicEnXwA6rwXmb6nQsF8KUWF6sEJzmWGQlfafIOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B173106F;
	Mon,  3 Mar 2025 06:18:25 -0800 (PST)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 034E83F66E;
	Mon,  3 Mar 2025 06:18:09 -0800 (PST)
Date: Mon, 3 Mar 2025 14:18:05 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Paul Benoit <paul@os.amperecomputing.com>
Cc: linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] firmware: smccc: Support optional Arm SMC SOC_ID name
Message-ID: <Z8W6HXZy46K7ebWe@J2N7QTR9R3.cambridge.arm.com>
References: <20241114030452.10149-1-paul@os.amperecomputing.com>
 <20250219005932.3466-1-paul@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219005932.3466-1-paul@os.amperecomputing.com>

Hi Paul,

This looks generally good with a couple of minor nits.

On Tue, Feb 18, 2025 at 04:59:32PM -0800, Paul Benoit wrote:
> Issue Number 1.6 of the Arm SMC Calling Convention introduces an optional
> SOC_ID name string.  If implemented, point the 'machine' field of the SoC
> Device Attributes at this string so that it will appear under
> /sys/bus/soc/devices/soc0/machine.
> 
> On Arm SMC compliant SoCs, this will allow things like 'lscpu' to
> eventually get a SoC provider model name from there rather than each
> tool/utility needing to get a possibly inconsistent, obsolete, or incorrect
> model/machine name from its own hardcoded model/machine name table.
> 
> Signed-off-by: Paul Benoit <paul@os.amperecomputing.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
> 
> v3->v4: Address code review identified issues of v3.
> v2->v3: Add conditionalization to exclude SOC_ID Name from 32-bit builds.
> v1->v2: Address code review identified issues.
> 
>  drivers/firmware/smccc/soc_id.c | 81 +++++++++++++++++++++++++++++++++
>  include/linux/arm-smccc.h       | 40 ++++++++++++++++
>  2 files changed, 121 insertions(+)
> 
> diff --git a/drivers/firmware/smccc/soc_id.c b/drivers/firmware/smccc/soc_id.c
> index 1990263fbba0..7b0688d78dab 100644
> --- a/drivers/firmware/smccc/soc_id.c
> +++ b/drivers/firmware/smccc/soc_id.c
> @@ -32,6 +32,86 @@
>  static struct soc_device *soc_dev;
>  static struct soc_device_attribute *soc_dev_attr;
>  
> +#ifdef CONFIG_ARM64
> +
> +static char __ro_after_init smccc_soc_id_name[136] = "";
> +
> +static inline void str_fragment_from_reg(char *dst, unsigned long reg)
> +{
> +	dst[0] = (reg >> 0)  & 0xff;
> +	dst[1] = (reg >> 8)  & 0xff;
> +	dst[2] = (reg >> 16) & 0xff;
> +	dst[3] = (reg >> 24) & 0xff;
> +	dst[4] = (reg >> 32) & 0xff;
> +	dst[5] = (reg >> 40) & 0xff;
> +	dst[6] = (reg >> 48) & 0xff;
> +	dst[7] = (reg >> 56) & 0xff;
> +}
> +
> +static char __init *smccc_soc_name_init(void)
> +{
> +	struct arm_smccc_1_2_regs args;
> +	struct arm_smccc_1_2_regs res;
> +	size_t len;
> +
> +	/*
> +	 * Issue Number 1.6 of the Arm SMC Calling Convention
> +	 * specification introduces an optional "name" string
> +	 * to the ARM_SMCCC_ARCH_SOC_ID function.  Fetch it if
> +	 * available.
> +	 */
> +	args.a0 = ARM_SMCCC_ARCH_SOC_ID;
> +	args.a1 = 2;    /* SOC_ID name */
> +	arm_smccc_1_2_invoke(&args, &res);
> +	if ((u32)res.a0 == 0) {
> +		const unsigned int regsize = sizeof(res.a1);
> +
> +		/*
> +		 * Copy res.a1..res.a17 to the smccc_soc_id_name string
> +		 * 8 bytes at a time.  As per Issue 1.6 of the Arm SMC
> +		 * Calling Convention, the string will be NUL terminated
> +		 * and padded, from the end of the string to the end of the
> +		 * 136 byte buffer, with NULs.
> +		 */
> +		str_fragment_from_reg(smccc_soc_id_name + 0*regsize, res.a1);
> +		str_fragment_from_reg(smccc_soc_id_name + 1*regsize, res.a2);
> +		str_fragment_from_reg(smccc_soc_id_name + 2*regsize, res.a3);
> +		str_fragment_from_reg(smccc_soc_id_name + 3*regsize, res.a4);
> +		str_fragment_from_reg(smccc_soc_id_name + 4*regsize, res.a5);
> +		str_fragment_from_reg(smccc_soc_id_name + 5*regsize, res.a6);
> +		str_fragment_from_reg(smccc_soc_id_name + 6*regsize, res.a7);
> +		str_fragment_from_reg(smccc_soc_id_name + 7*regsize, res.a8);
> +		str_fragment_from_reg(smccc_soc_id_name + 8*regsize, res.a9);
> +		str_fragment_from_reg(smccc_soc_id_name + 9*regsize, res.a10);
> +		str_fragment_from_reg(smccc_soc_id_name + 10*regsize, res.a11);
> +		str_fragment_from_reg(smccc_soc_id_name + 11*regsize, res.a12);
> +		str_fragment_from_reg(smccc_soc_id_name + 12*regsize, res.a13);
> +		str_fragment_from_reg(smccc_soc_id_name + 13*regsize, res.a14);
> +		str_fragment_from_reg(smccc_soc_id_name + 14*regsize, res.a15);
> +		str_fragment_from_reg(smccc_soc_id_name + 15*regsize, res.a16);
> +		str_fragment_from_reg(smccc_soc_id_name + 16*regsize, res.a17);

Please get rid of 'regsize' and use '8' directly. This only exists for
arm64, where the registeres are 8 bytes, and the comment immediately
above refers to "8 bytes" specifically anyway, so 'regsize' only serves
to make this harder to read.

It'd be a bit clearer as:

	str_fragment_from_reg(smccc_soc_id_name + 8 * 0,  res.a1);
	str_fragment_from_reg(smccc_soc_id_name + 8 * 1,  res.a2);
	...
	str_fragment_from_reg(smccc_soc_id_name + 8 * 15, res.a16);
	str_fragment_from_reg(smccc_soc_id_name + 8 * 16, res.a17);

Sudeep, are you happy to fix that up when applying?

> +
> +		len = strnlen(smccc_soc_id_name, sizeof(smccc_soc_id_name));
> +		if (len) {
> +			if (len == sizeof(smccc_soc_id_name))
> +				pr_warn(FW_BUG "Ignoring improperly formatted Name\n");

It's odd that 'Name' is capitalized here. Not a big deal, but it doesn't
look quite right.

> +			else
> +				return smccc_soc_id_name;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +#else
> +
> +static char __init *smccc_soc_name_init(void)
> +{
> +	return NULL;
> +}
> +
> +#endif
> +
>  static int __init smccc_soc_init(void)
>  {
>  	int soc_id_rev, soc_id_version;
> @@ -72,6 +152,7 @@ static int __init smccc_soc_init(void)
>  	soc_dev_attr->soc_id = soc_id_str;
>  	soc_dev_attr->revision = soc_id_rev_str;
>  	soc_dev_attr->family = soc_id_jep106_id_str;
> +	soc_dev_attr->machine = smccc_soc_name_init();
>  
>  	soc_dev = soc_device_register(soc_dev_attr);
>  	if (IS_ERR(soc_dev)) {
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index 67f6fdf2e7cd..eb7eab04755a 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -639,5 +639,45 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
>  		method;							\
>  	})
>  
> +#ifdef CONFIG_ARM64
> +
> +#define __fail_smccc_1_2(___res)					\
> +	do {								\
> +		if (___res)						\
> +			___res->a0 = SMCCC_RET_NOT_SUPPORTED;		\
> +	} while (0)
> +
> +/*
> + * arm_smccc_1_2_invoke() - make an SMCCC v1.2 compliant call
> + *
> + * @args: SMC args are in the a0..a17 fields of the arm_smcc_1_2_regs structure
> + * @res: result values from registers 0 to 17
> + *
> + * This macro will make either an HVC call or an SMC call depending on the
> + * current SMCCC conduit. If no valid conduit is available then -1
> + * (SMCCC_RET_NOT_SUPPORTED) is returned in @res.a0 (if supplied).
> + *
> + * The return value also provides the conduit that was used.
> + */
> +#define arm_smccc_1_2_invoke(args, res) ({				\
> +		struct arm_smccc_1_2_regs *__args = args;		\
> +		struct arm_smccc_1_2_regs *__res = res;			\
> +		int method = arm_smccc_1_1_get_conduit();		\
> +		switch (method) {					\
> +		case SMCCC_CONDUIT_HVC:					\
> +			arm_smccc_1_2_hvc(__args, __res);		\
> +			break;						\
> +		case SMCCC_CONDUIT_SMC:					\
> +			arm_smccc_1_2_smc(__args, __res);		\
> +			break;						\
> +		default:						\
> +			__fail_smccc_1_2(__res);			\
> +			method = SMCCC_CONDUIT_NONE;			\
> +			break;						\
> +		}							\
> +		method;							\
> +	})
> +#endif /*CONFIG_ARM64*/

At some point I intend to rework the existing helpers to not return the
conduit, but this is fine for now.

With the fixups above:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> +
>  #endif /*__ASSEMBLY__*/
>  #endif /*__LINUX_ARM_SMCCC_H*/
> -- 
> 2.48.1
> 

