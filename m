Return-Path: <linux-kernel+bounces-314648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C98EA96B653
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17C4EB26A2D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396601CBEB4;
	Wed,  4 Sep 2024 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qaNOBQy9"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E0189911
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441553; cv=none; b=B0K0MUo7x+6P7sSzkPeVBla2yvVYplpJ4jhHU78DCB5av373qYRvUT2T/ZmraUEwKaUPJqsKsCDHa+aWLAXKqzu3H6eUFX6IFzg1aA/lTv+uc6Q4g/EgdAmm72AO8sYGbVeLQE7cVVZwS4mh8IXMf9M4UzZNHlHPMdMlTkRiTaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441553; c=relaxed/simple;
	bh=hHb94xNSw4StvKuusOHdbEFZ2XsR6hiwAPxhOQKVGao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QSKr/iD31YxCBQP9d1CqM9d+1viIsn4ofKp9qK143socCLhJOjqLpl+AohL6zVI5dGlcan5cWwhoUNLzeRtc4s5dv+sxVvsZT8QruauP39kyEKbKm+ne1jNVo9WaplNl7ey35p9QBRMAjiB/hhklaeU/tfXL9F0kpNzWy6roHtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qaNOBQy9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4848NRVI005433;
	Wed, 4 Sep 2024 09:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:reply-to:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=No+ZWBVLeGFEntqxKUPXdow5p2Q
	k0f8/DwriUb8SxDM=; b=qaNOBQy9Xfw3JJ/UJtcCtCh/i/Vw3EizXCnI2Cpn86h
	iE/B50YF4OAIM7b2O1T0v5PQkEL/NOgb9NRpZyJnh4/WY15Yshz1p6AWQeWzG+iQ
	WBKdDvis8DPazVfTsYTH7JaptCTuu4UnNA8CMVJ9X60IfyL7sqU+XG9fi7jDs5HF
	+hGEuAUAbWmemgsm+bxW3i5Wgs2QCZ8SCYn7K0PsBQ/8bU6FpgHmgPX11NZ55K4z
	tEpBY2B6wBKI3n4HlD33IvSGIO5nDjqE2MltFmq4SD4FTXKyq04ZKcAjcRgmxKdQ
	79Cfo5LchW/nwpliW88hOY7kM5X2FJozl7Qa0nkyPEA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkqtmk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 09:18:55 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4849EMiu013481;
	Wed, 4 Sep 2024 09:18:55 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkqtmju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 09:18:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4848dWYD018726;
	Wed, 4 Sep 2024 09:18:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cdw174a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 09:18:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4849Io9F15139186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 09:18:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E0C12004E;
	Wed,  4 Sep 2024 09:18:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CE2E2004B;
	Wed,  4 Sep 2024 09:18:48 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.216.36])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Sep 2024 09:18:48 +0000 (GMT)
Date: Wed, 4 Sep 2024 14:48:46 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To: Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org, oohall@gmail.com, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, vaibhav@linux.ibm.com,
        ganeshgr@linux.ibm.com, sbhat@linux.ibm.com
Subject: Re: [PATCH v2] powerpc/pseries/eeh: Fix pseries_eeh_err_inject
Message-ID: <hop6tsixsczuktfowy5hqo6hbfllogomkxgjvkimrxm7bt3pt3@hcvxg552xkoc>
Reply-To: mahesh@linux.ibm.com
References: <20240823151158.92602-1-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823151158.92602-1-nnmlinux@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 049Qn5xHnq_pk63kbZqNV7QrvbNft6W6
X-Proofpoint-ORIG-GUID: VvBqTS0_l0D8lbvtSckAPfRNPsDqGlFA
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_07,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040067

On 2024-08-23 10:11:58 Fri, Narayana Murty N wrote:
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


Changes looks good to me.

Reviewed-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>

I have tested this with your VFIO chenges at https://github.com/nnmwebmin/vfio-ppc-tests/tree/vfio-ppc-ex

Tested-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>

Thanks,
-Mahesh.

