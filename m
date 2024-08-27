Return-Path: <linux-kernel+bounces-302600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114A69600C2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B427B21F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C716C33CFC;
	Tue, 27 Aug 2024 05:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C6K7KLFN"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E48F4C92
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735043; cv=none; b=cn/fPmLVT7mJDx4riH4XDjztfHJQlFpfFDml9bjcC0QtydYLEfG85XwOnj33E2eYfX5/5bp/6z/Oeia0llgV/TN87fLMbcHWrYdSSa2C2knlY4B13UGXBtFstnH8SOKeD7IPF6DUOCUiYQwGsQ7jG3fVbrXLFzedg8f4LT1Me1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735043; c=relaxed/simple;
	bh=wksRg42g0VVOA2GWRSHzFHZK9dQOKIE2GlpGoreMqb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=SWIdS57ibaae9mHDgAjVx7vZQaOOsv8/ofz1e0nU4ULy7WSIA0ubQYYDSDLROsfmywGuU0TDzKudWUxovTg3+GTRYnUa4jjqa8Y0tO+4DRwNsSoPuzEp4ww9JvHs6zaVTjAWcsJAOluX50EFJX2IuwZ0wyiZqFb0DUj3ewGbIpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C6K7KLFN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R1xInM014691;
	Tue, 27 Aug 2024 05:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=pp1; bh=xAJzky6VlIH1RnuZZ+v8zK2DMO
	HKt74QQUCJakQdb5Y=; b=C6K7KLFNOTuJ9htRHzHKbjaHt+E7CNpx7t0cHQ5R6U
	aHyr/LiKc6yKJxnUaRDmNHxe+I/7J+xQGOge10hC6jmKbA1wwqEeR52yr2f7sZCs
	1O8ePMce2EggtPPQxbCImk8yTRfYstvkva7WRv2LBj5W9zlE40bcON1zK23KZQTx
	C+6VPDiZhvYkBIxaAOtCUW4IKYwIQu7oFo9HW0fZ4G2WhiHL0R+9rIPoBeXrd3nl
	UavbArx0YGqEjDRz53gPDHjSEYM4CT6lrM6MsJQd94uFkL5Swbyn1kprQ3p7CR4g
	dbidj2mDi8na6B4VLXp4cvtW5ZMf/tIW3RZ+DxiiO44w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417g51hyj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 05:03:45 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47R4xDON021942;
	Tue, 27 Aug 2024 05:03:44 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417g51hyj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 05:03:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47R15VWq021741;
	Tue, 27 Aug 2024 05:03:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 417suu9grg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 05:03:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47R53dk943319728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 05:03:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3D7F2004B;
	Tue, 27 Aug 2024 05:03:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C272820049;
	Tue, 27 Aug 2024 05:03:36 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.171.52.227])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 27 Aug 2024 05:03:36 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Tue, 27 Aug 2024 10:33:35 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Narayana Murty N <nnmlinux@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, linux-kernel@vger.kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, ganeshgr@linux.ibm.com,
        sbhat@linux.ibm.com
Subject: Re: [PATCH v2] powerpc/pseries/eeh: Fix pseries_eeh_err_inject
In-Reply-To: <20240823151158.92602-1-nnmlinux@linux.ibm.com>
References: <20240823151158.92602-1-nnmlinux@linux.ibm.com>
Date: Tue, 27 Aug 2024 10:33:35 +0530
Message-ID: <87mskyy2u0.fsf@vajain21.in.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EBJ-5CNmJ00Fq8A7LUKkvr-9dGVWlGVj
X-Proofpoint-GUID: 91vrVtlJbTAMZB9e6bld7jglgBs4r2UB
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_03,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1011
 phishscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408270035

Hi Narayana,

Thanks for the patch.

Narayana Murty N <nnmlinux@linux.ibm.com> writes:

> VFIO_EEH_PE_INJECT_ERR ioctl is currently failing on pseries
> due to missing implementation of err_inject eeh_ops for pseries.
> This patch implements pseries_eeh_err_inject in eeh_ops/pseries
> eeh_ops. Implements support for injecting MMIO load/store error
> for testing from user space.
>
> The check on PCI error type code is moved to platform code, since
> the eeh_pe_inject_err can be allowed to more error types depending
> on platform requirement.
>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>

Code changes LGTM, hence
Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>

> ---
>
> Testing:
> ========
> vfio-test [1] by Alex Willamson, was forked and updated to add
> support inject error on pSeries guest and used to test this
> patch[2].
>
> References:
> ===========
> [1] https://github.com/awilliam/tests
> [2] https://github.com/nnmwebmin/vfio-ppc-tests/tree/vfio-ppc-ex
>
> ================
> Changelog:
> V1:https://lore.kernel.org/all/20240822082713.529982-1-nnmlinux@linux.ibm.com/
> - Resolved build issues for ppc64|le_defconfig by moving the
> pseries_eeh_err_inject() definition outside of the CONFIG_PCI_IOV
> code block.
> - New eeh_pe_inject_mmio_error wrapper function added to avoid
> CONFIG_EEH is not set.
> ---
>  arch/powerpc/include/asm/eeh.h               |  6 ++-
>  arch/powerpc/kernel/eeh.c                    |  9 +++--
>  arch/powerpc/platforms/pseries/eeh_pseries.c | 39 +++++++++++++++++++-
>  3 files changed, 48 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index 91a9fd53254f..8da6b047a4fe 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -308,7 +308,7 @@ int eeh_pe_reset(struct eeh_pe *pe, int option, bool include_passed);
>  int eeh_pe_configure(struct eeh_pe *pe);
>  int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
>  		      unsigned long addr, unsigned long mask);
> -
> +int eeh_pe_inject_mmio_error(struct pci_dev *pdev);
>  /**
>   * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
>   *
> @@ -338,6 +338,10 @@ static inline int eeh_check_failure(const volatile void __iomem *token)
>  	return 0;
>  }
>  
> +static inline int eeh_pe_inject_mmio_error(struct pci_dev *pdev)
> +{
> +	return -ENXIO;
> +}
>  #define eeh_dev_check_failure(x) (0)
>  
>  static inline void eeh_addr_cache_init(void) { }
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index d03f17987fca..49ab11a287a3 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -1537,10 +1537,6 @@ int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
>  	if (!eeh_ops || !eeh_ops->err_inject)
>  		return -ENOENT;
>  
> -	/* Check on PCI error type */
> -	if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
> -		return -EINVAL;
> -
>  	/* Check on PCI error function */
>  	if (func < EEH_ERR_FUNC_MIN || func > EEH_ERR_FUNC_MAX)
>  		return -EINVAL;
> @@ -1851,6 +1847,11 @@ static const struct file_operations eeh_dev_break_fops = {
>  	.read   = eeh_debugfs_dev_usage,
>  };
>  
> +int eeh_pe_inject_mmio_error(struct pci_dev *pdev)
> +{
> +	return eeh_debugfs_break_device(pdev);
> +}
> +
>  static ssize_t eeh_dev_can_recover(struct file *filp,
>  				   const char __user *user_buf,
>  				   size_t count, loff_t *ppos)
> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> index b1ae0c0d1187..1893f66371fa 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> @@ -784,6 +784,43 @@ static int pseries_notify_resume(struct eeh_dev *edev)
>  }
>  #endif
>  
> +/**
> + * pseries_eeh_err_inject - Inject specified error to the indicated PE
> + * @pe: the indicated PE
> + * @type: error type
> + * @func: specific error type
> + * @addr: address
> + * @mask: address mask
> + * The routine is called to inject specified error, which is
> + * determined by @type and @func, to the indicated PE
> + */
> +static int pseries_eeh_err_inject(struct eeh_pe *pe, int type, int func,
> +				  unsigned long addr, unsigned long mask)
> +{
> +	struct	eeh_dev	*pdev;
> +
> +	/* Check on PCI error type */
> +	if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
> +		return -EINVAL;
> +
> +	switch (func) {
> +	case EEH_ERR_FUNC_LD_MEM_ADDR:
> +	case EEH_ERR_FUNC_LD_MEM_DATA:
> +	case EEH_ERR_FUNC_ST_MEM_ADDR:
> +	case EEH_ERR_FUNC_ST_MEM_DATA:
> +		/* injects a MMIO error for all pdev's belonging to PE */
> +		pci_lock_rescan_remove();
> +		list_for_each_entry(pdev, &pe->edevs, entry)
> +			eeh_pe_inject_mmio_error(pdev->pdev);
> +		pci_unlock_rescan_remove();
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct eeh_ops pseries_eeh_ops = {
>  	.name			= "pseries",
>  	.probe			= pseries_eeh_probe,
> @@ -792,7 +829,7 @@ static struct eeh_ops pseries_eeh_ops = {
>  	.reset			= pseries_eeh_reset,
>  	.get_log		= pseries_eeh_get_log,
>  	.configure_bridge       = pseries_eeh_configure_bridge,
> -	.err_inject		= NULL,
> +	.err_inject		= pseries_eeh_err_inject,
>  	.read_config		= pseries_eeh_read_config,
>  	.write_config		= pseries_eeh_write_config,
>  	.next_error		= NULL,
> -- 
> 2.45.2
>

-- 
Cheers
~ Vaibhav

