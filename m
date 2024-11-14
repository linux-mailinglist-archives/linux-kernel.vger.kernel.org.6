Return-Path: <linux-kernel+bounces-409268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAEF9C89FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1C98B2C2D0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EF01F80CC;
	Thu, 14 Nov 2024 12:22:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A65D1F77B8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586955; cv=none; b=OT5yQMNkgfeRVnc4sSMUupQUa6dtrm1UW/OB0NLUKoeKgeob7csn7U5B1UbJnV7/MZ/866AtOAbWXd+aTJY4/J9Va+RNeaqvCMJ27+TzI79OL0PkMavHuYwAZJp0KM8QRBEmmPcK7+dzcnlXvobkS46nnPNLP0eBjOWdakkRelM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586955; c=relaxed/simple;
	bh=Ho8+cbC29QWSlaoAWmumCnCfW6ZPOSRIICUJzKf24ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOxb88pKHVirS7Z+UM0QK5E0YXjyw3s04jreWrzfVwL3rRpg5ZfgJvZnVeCLOJRU5FQjsOUUTS3jrMOc7/xQRSNZPaAz+v3AiMsJ+ZXtX/cwJCu0feeNT/NCvUG9cgre6jbyzE97vHbWKx19PsklQcSCFfe7GUGx4w6uTbvj/SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3ABD1480;
	Thu, 14 Nov 2024 04:22:54 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 068313F6A8;
	Thu, 14 Nov 2024 04:22:23 -0800 (PST)
Date: Thu, 14 Nov 2024 12:22:21 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Paul Benoit <paul@os.amperecomputing.com>
Cc: linux-kernel@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] firmware: smccc: Support optional Arm SMC SOC_ID name
Message-ID: <ZzXrfV3uDGRkBD2L@J2N7QTR9R3>
References: <20241114030452.10149-1-paul@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114030452.10149-1-paul@os.amperecomputing.com>

Hi Paul,

On Wed, Nov 13, 2024 at 07:04:52PM -0800, Paul Benoit wrote:
> Issue Number 1.6 of the Arm SMC Calling Convention introduces an
> optional SOC_ID name string.  If available, point the 'machine' field of
> the SoC Device Attributes at this string so that it will appear under
> /sys/bus/soc/devices/soc0/machine.  On Arm SMC compliant SoCs, this will
> allow things like 'lscpu' to eventually get a SoC provider model name
> from there rather than each tool/utility needing to get a possibly
> inconsistent, obsolete, or incorrect model/machine name from its own
> hardcoded model/machine name table.
> 
> Signed-off-by: Paul Benoit <paul@os.amperecomputing.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/firmware/smccc/smccc.c  | 70 +++++++++++++++++++++++++++++++++
>  drivers/firmware/smccc/soc_id.c |  1 +
>  include/linux/arm-smccc.h       | 10 +++++
>  3 files changed, 81 insertions(+)
> 
> diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
> index a74600d9f2d7..1c7084b0b8d7 100644
> --- a/drivers/firmware/smccc/smccc.c
> +++ b/drivers/firmware/smccc/smccc.c
> @@ -18,10 +18,12 @@ static enum arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE;
>  bool __ro_after_init smccc_trng_available = false;
>  s32 __ro_after_init smccc_soc_id_version = SMCCC_RET_NOT_SUPPORTED;
>  s32 __ro_after_init smccc_soc_id_revision = SMCCC_RET_NOT_SUPPORTED;
> +char __ro_after_init smccc_soc_id_name[136] = "";
>  
>  void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
>  {
>  	struct arm_smccc_res res;
> +	struct arm_smccc_1_2_regs regs_1_2;
>  
>  	smccc_version = version;
>  	smccc_conduit = conduit;
> @@ -37,6 +39,66 @@ void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
>  			smccc_soc_id_version = (s32)res.a0;
>  			arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
>  			smccc_soc_id_revision = (s32)res.a0;
> +
> +			/* Issue Number 1.6 of the Arm SMC Calling Convention
> +			 * specification introduces an optional "name" string
> +			 * to the ARM_SMCCC_ARCH_SOC_ID function.  Fetch it if
> +			 * available.
> +			 */

I think the code for the SOC_ID name should live under soc_id.c, since
it *only* matters to the sysfs interface (and will not be used by other
code in the kernel to identify the SOC). That should be initialised
under smccc_soc_init(), ideally factored into a smccc_soc_name_init()
helper.

Nit: comments should have the leading '/*' on its own line, e.g.

	/*
	 * Multi-line comments should be formatted like this, with a
	 * leading and trailing line.
	 */

> +			regs_1_2.a0 = ARM_SMCCC_ARCH_SOC_ID;
> +			regs_1_2.a1 = 2;	/* SOC_ID name */
> +			arm_smccc_1_2_smc(
> +				(const struct arm_smccc_1_2_regs *)&regs_1_2,
> +				(struct arm_smccc_1_2_regs *)&regs_1_2);

These casts shouldn't be necessary, and they look suspicious.

Additionally, this should be using whichever conduit SMCCC happens to be
using rather than assuming SMC. As with the rest of this code using
arm_smccc_1_1_invoke(), we should add a arm_smccc_1_2_invoke() wrapper
for that, with this looking like:

			arm_smccc_1_2_invoke(&regs_1_2, &regs_1_2);
> +
> +			if ((u32)regs_1_2.a0 == 0) {
> +				unsigned long *destination =
> +					(unsigned long *)smccc_soc_id_name;
> +
> +				/*
> +				 * Copy regs_1_2.a1..regs_1_2.a17 to the
> +				 * smccc_soc_id_name string with consideration
> +				 * to the endianness of the values in a1..a17.

This indicates that we have to do *something* about endianness, but
doesn't say *what* consideration is necessary, which is rather
unhelpful -- it would be better to describe the format of the registers,
which would indicate what specifically we need to do.

For example:

	The string is packed into registers a1 to a17 such that each
	register contains 8 successive bytes, and within each register
	byte N of the string fragment is encoded into bits [8*N+7:8*N].

> +				 * As per Issue 1.6 of the Arm SMC Calling
> +				 * Convention, the string will be NUL terminated
> +				 * and padded, from the end of the string to
> +				 * the end of the 136 byte buffer, with NULs.
> +				 */
> +				*destination++ =
> +				    cpu_to_le64p((const __u64 *)&regs_1_2.a1);

If you used cpu_to_le64(), you wouldn't need a cast, though either way you will
need a cast on the return value since 'destination' is not an array of __le64,
and sparse should complain.

This isn't really an endianness conversion since we're unpacking smaller
elements out of a larger container, so I reckon it would be better to
handle this explicitly, e.g.

	void str_fragment_from_reg(char *dst, u64 reg)
	{
		dst[0] = (reg >> 0)  & 0xff;
		dst[1] = (reg >> 8)  & 0xff;
		dst[2] = (reg >> 16) & 0xff;
		dst[3] = (reg >> 24) & 0xff;
		dst[4] = (reg >> 32) & 0xff;
		dst[5] = (reg >> 40) & 0xff;
		dst[6] = (reg >> 48) & 0xff;
		dst[7] = (reg >> 56) & 0xff;
	}

... and then using that:

	str_fragment_from_reg(destination + 0,  regs_1_2.a1);
	str_fragment_from_reg(destination + 8,  regs_1_2.a2);
	str_fragment_from_reg(destination + 16, regs_1_2.a3);
	str_fragment_from_reg(destination + 24, regs_1_2.a4);
	...

That way we avoid all the messy casting, and we can more clearly align
this with the way the spec says this is packed.

The generated code looks sane (with GCC 14.2.0, at least):

	// little-endian kernel
	0000000000000000 <str_fragment_from_reg>:
	   0:   f9000001        str     x1, [x0]
	   4:   d65f03c0        ret

	// big-endian kernel
	0000000000000000 <str_fragment_from_reg>:
	   0:   dac00c21        rev     x1, x1
	   4:   f9000001        str     x1, [x0]
	   8:   d65f03c0        ret

> +				*destination++ =
> +				    cpu_to_le64p((const __u64 *)&regs_1_2.a2);
> +				*destination++ =
> +				    cpu_to_le64p((const __u64 *)&regs_1_2.a3);
> +				*destination++ =
> +				    cpu_to_le64p((const __u64 *)&regs_1_2.a4);
> +				*destination++ =
> +				    cpu_to_le64p((const __u64 *)&regs_1_2.a5);
> +				*destination++ =
> +				    cpu_to_le64p((const __u64 *)&regs_1_2.a6);
> +				*destination++ =
> +				    cpu_to_le64p((const __u64 *)&regs_1_2.a7);
> +				*destination++ =
> +				    cpu_to_le64p((const __u64 *)&regs_1_2.a8);
> +				*destination++ =
> +				    cpu_to_le64p((const __u64 *)&regs_1_2.a9);
> +				*destination++ =
> +				    cpu_to_le64p((const __u64 *)&regs_1_2.a10);
> +				*destination++ =
> +				    cpu_to_le64p((const __u64 *)&regs_1_2.a11);
> +				*destination++ =
> +				    cpu_to_le64p((const __u64 *)&regs_1_2.a12);
> +				*destination++ =
> +				    cpu_to_le64p((const __u64 *)&regs_1_2.a13);
> +				*destination++ =
> +				    cpu_to_le64p((const __u64 *)&regs_1_2.a14);
> +				*destination++ =
> +				    cpu_to_le64p((const __u64 *)&regs_1_2.a15);
> +				*destination++ =
> +				    cpu_to_le64p((const __u64 *)&regs_1_2.a16);
> +				*destination++ =
> +				    cpu_to_le64p((const __u64 *)&regs_1_2.a17);

We probably want to check that the string is actually NUL terminated
here, and log a FW BUG message if it is not.

> +			}
>  		}
>  	}
>  }
> @@ -67,6 +129,14 @@ s32 arm_smccc_get_soc_id_revision(void)
>  }
>  EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);
>  
> +char *arm_smccc_get_soc_id_name(void)
> +{
> +	if (strnlen(smccc_soc_id_name, sizeof(smccc_soc_id_name)))
> +		return smccc_soc_id_name;
> +
> +	return NULL;
> +}

As above, I think this can be folded into the probing routine.

> +
>  static int __init smccc_devices_init(void)
>  {
>  	struct platform_device *pdev;
> diff --git a/drivers/firmware/smccc/soc_id.c b/drivers/firmware/smccc/soc_id.c
> index 1990263fbba0..6f698c703868 100644
> --- a/drivers/firmware/smccc/soc_id.c
> +++ b/drivers/firmware/smccc/soc_id.c
> @@ -72,6 +72,7 @@ static int __init smccc_soc_init(void)
>  	soc_dev_attr->soc_id = soc_id_str;
>  	soc_dev_attr->revision = soc_id_rev_str;
>  	soc_dev_attr->family = soc_id_jep106_id_str;
> +	soc_dev_attr->machine = arm_smccc_get_soc_id_name();
>  
>  	soc_dev = soc_device_register(soc_dev_attr);
>  	if (IS_ERR(soc_dev)) {
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index 67f6fdf2e7cd..5935cf636135 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -333,6 +333,16 @@ s32 arm_smccc_get_soc_id_version(void);
>   */
>  s32 arm_smccc_get_soc_id_revision(void);
>  
> +/**
> + * arm_smccc_get_soc_id_name()
> + *
> + * Returns the SOC ID name.
> + *
> + * When ARM_SMCCC_ARCH_SOC_ID name is not present, returns NULL.
> + */
> +char *arm_smccc_get_soc_id_name(void);

I don't think this needs to be exposed outside of the SOC ID code.

Thanks,
Mark.

