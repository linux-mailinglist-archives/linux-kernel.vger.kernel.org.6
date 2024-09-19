Return-Path: <linux-kernel+bounces-333606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33F497CB43
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEE4EB228EC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75031190477;
	Thu, 19 Sep 2024 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OjMeDP3F"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38781DDC9
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726758115; cv=none; b=BPrhZ2xF1RsDOBQ15mqMXKXJ2G20Xbk87JGUKM3V7A/UC7hlnU2J4aE5Xqgp2V2SYxDjyrRgdDiPohWhq7odQlduE44rZe9WfibFQrsIJTvz7IY5Pd2G84ykGGA7tLT+xkvkiDRcrjMRe3KgTzuw25K0yWud1P1+6qWx2s6cJHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726758115; c=relaxed/simple;
	bh=gfFYAX8Wkw7xR3ohBQ7tGjWvt51dgudj/WdKi801p70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=ORKHoR8BTv6oQbHcLzyxDQagyj8lU1kqIwEK9/Um1dGbiEj8bAb8R2r2fuCbcurEweqWPrlgHxhQkvqkgiDTnDPenRlbofRb0kpg16GT0BFiSgu5cEf7n8jvLTqgOjz3XJ6PeOHSzZa5uNrsuOdPHAG883+l6JBA5J7kID9MSLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OjMeDP3F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JEMfDr027076;
	Thu, 19 Sep 2024 15:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:mime-version; s=pp1; bh=3/QMlVBloIHFi2ohshUULd/kYl
	48od3sFeUczC9S+jg=; b=OjMeDP3FZsUMyGHmRwBILr8JXdCBKMj4VASxMVG+pa
	cd+5w2uKmhJuo1KsGmyIajJuD0dd4pNeyfhc5J7fmV3rt+eDk/JZiG+2+iaGby1U
	3wF0KBldgT/ReaoOQSzAIDhBxQYp9W7vKysGv9LprFrgXggXUSRGgHe6ADxnJVyJ
	NsiT58ejfKJqBM9T7/tQ4pJklw4piRKY9rPlJxA4iBMxHs9aBUNTbptgIDGJRl5+
	0qjfjgXC2AnMDhbPBAVthlxoSGLVqIpgctYUvNph/FlD+1GVmBaPOgKAda+yfdHr
	ubMUJ+qNhIep1w3nz0yrd/M+q/9e5pi8gZMz9BbhOuaA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3udmaxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 15:01:25 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48JF1P5L032265;
	Thu, 19 Sep 2024 15:01:25 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3udmaub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 15:01:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48JD1QAb001187;
	Thu, 19 Sep 2024 15:00:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nntqj1se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 15:00:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48JF0rkw54788396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Sep 2024 15:00:53 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9861F2004F;
	Thu, 19 Sep 2024 15:00:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBFE32004E;
	Thu, 19 Sep 2024 15:00:49 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.30.22])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 19 Sep 2024 15:00:49 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Thu, 19 Sep 2024 20:30:48 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>,
        Narayana Murty N
 <nnmlinux@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, ganeshgr@linux.ibm.com,
        sbhat@linux.ibm.com
Subject: Re: [PATCH] powerpc/pseries/eeh: move pseries_eeh_err_inject()
 outside CONFIG_DEBUG_FS block
In-Reply-To: <871q1hbsh7.fsf@gmail.com>
References: <20240917132445.3868016-1-nnmlinux@linux.ibm.com>
 <871q1hbsh7.fsf@gmail.com>
Date: Thu, 19 Sep 2024 20:30:48 +0530
Message-ID: <87bk0jbsdb.fsf@vajain21.in.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Rb4gT66GOt97oYcD8pdorqZDXA2fElrU
X-Proofpoint-ORIG-GUID: lj7VS7Tl7p8Rj5GEgCqR_hmiEBJfYDf2
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_12,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=932
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409190099

Hi Ritesh,

Thanks for looking into this patch. My responses your review inline
below:

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Narayana Murty N <nnmlinux@linux.ibm.com> writes:
>
>> Makes pseries_eeh_err_inject() available even when debugfs
>> is disabled (CONFIG_DEBUG_FS=n). It moves eeh_debugfs_break_device()
>> and eeh_pe_inject_mmio_error() out of the CONFIG_DEBUG_FS block
>> and renames it as eeh_break_device().
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202409170509.VWC6jadC-lkp@intel.com/
>> Fixes: b0e2b828dfca ("powerpc/pseries/eeh: Fix pseries_eeh_err_inject")
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>  arch/powerpc/kernel/eeh.c | 198 +++++++++++++++++++-------------------
>>  1 file changed, 99 insertions(+), 99 deletions(-)
>
> Ok, so in your original patch you implemented eeh_inject ops for pseries
> using mmio based eeh error injection (eeh_pe_inject_mmio_error()), which
> uses the functions defined under debugfs -> eeh_debugfs_break_device(). 
>
> This was failing when CONFIG_DEBUGFS is not defined, thus referring to
> undefined function definition. 
>
> Minor nit below.
>
>>
>> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>> index 49ab11a287a3..0fe25e907ea6 100644
>> --- a/arch/powerpc/kernel/eeh.c
>> +++ b/arch/powerpc/kernel/eeh.c
>> @@ -1574,6 +1574,104 @@ static int proc_eeh_show(struct seq_file *m, void *v)
>>  }
>>  #endif /* CONFIG_PROC_FS */
>>  
>> +static int eeh_break_device(struct pci_dev *pdev)
>> +{
>> +	struct resource *bar = NULL;
>> +	void __iomem *mapped;
>> +	u16 old, bit;
>> +	int i, pos;
>> +
>> +	/* Do we have an MMIO BAR to disable? */
>> +	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
>> +		struct resource *r = &pdev->resource[i];
>> +
>> +		if (!r->flags || !r->start)
>> +			continue;
>> +		if (r->flags & IORESOURCE_IO)
>> +			continue;
>> +		if (r->flags & IORESOURCE_UNSET)
>> +			continue;
>> +
>> +		bar = r;
>> +		break;
>> +	}
>> +
>> +	if (!bar) {
>> +		pci_err(pdev, "Unable to find Memory BAR to cause EEH with\n");
>> +		return -ENXIO;
>> +	}
>> +
>> +	pci_err(pdev, "Going to break: %pR\n", bar);
>> +
>> +	if (pdev->is_virtfn) {
>> +#ifndef CONFIG_PCI_IOV
>> +		return -ENXIO;
>> +#else
>> +		/*
>> +		 * VFs don't have a per-function COMMAND register, so the best
>> +		 * we can do is clear the Memory Space Enable bit in the PF's
>> +		 * SRIOV control reg.
>> +		 *
>> +		 * Unfortunately, this requires that we have a PF (i.e doesn't
>> +		 * work for a passed-through VF) and it has the potential side
>> +		 * effect of also causing an EEH on every other VF under the
>> +		 * PF. Oh well.
>> +		 */
>> +		pdev = pdev->physfn;
>> +		if (!pdev)
>> +			return -ENXIO; /* passed through VFs have no PF */
>> +
>> +		pos  = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
>> +		pos += PCI_SRIOV_CTRL;
>> +		bit  = PCI_SRIOV_CTRL_MSE;
>> +#endif /* !CONFIG_PCI_IOV */
>> +	} else {
>> +		bit = PCI_COMMAND_MEMORY;
>> +		pos = PCI_COMMAND;
>> +	}
>> +
>> +	/*
>> +	 * Process here is:
>> +	 *
>> +	 * 1. Disable Memory space.
>> +	 *
>> +	 * 2. Perform an MMIO to the device. This should result in an error
>> +	 *    (CA  / UR) being raised by the device which results in an EEH
>> +	 *    PE freeze. Using the in_8() accessor skips the eeh detection hook
>> +	 *    so the freeze hook so the EEH Detection machinery won't be
>> +	 *    triggered here. This is to match the usual behaviour of EEH
>> +	 *    where the HW will asynchronously freeze a PE and it's up to
>> +	 *    the kernel to notice and deal with it.
>> +	 *
>> +	 * 3. Turn Memory space back on. This is more important for VFs
>> +	 *    since recovery will probably fail if we don't. For normal
>> +	 *    the COMMAND register is reset as a part of re-initialising
>> +	 *    the device.
>> +	 *
>> +	 * Breaking stuff is the point so who cares if it's racy ;)
>> +	 */
>> +	pci_read_config_word(pdev, pos, &old);
>> +
>> +	mapped = ioremap(bar->start, PAGE_SIZE);
>> +	if (!mapped) {
>> +		pci_err(pdev, "Unable to map MMIO BAR %pR\n", bar);
>> +		return -ENXIO;
>> +	}
>> +
>> +	pci_write_config_word(pdev, pos, old & ~bit);
>> +	in_8(mapped);
>> +	pci_write_config_word(pdev, pos, old);
>> +
>> +	iounmap(mapped);
>> +
>> +	return 0;
>> +}
>> +
>> +int eeh_pe_inject_mmio_error(struct pci_dev *pdev)
>> +{
>> +	return eeh_break_device(pdev);
>> +}
>> +
>
> Why have an extra eeh_pe_inject_mmio_error() function which only calls
> eeh_break_device()?
>
> Maybe we can rename eeh_break_device() to eeh_mmio_break_device() and use
> this function itself at both call sites?

Fair suggestion,

However we want to keep the method debugfs interface uses
to inject EEH (thats ppc platform agonistic), decoupled from what pseries
uses. Right now to support as initial work VFIO EEH injection on
pseries, we are piggy backing on eeh_debugfs_break_device().

This will change in future as we add more capabilities to pseries EEH
injection and this will change working of eeh_pe_inject_mmio_error()
without impacting the semantics of existing eeh_break_device().

-- 
Cheers
~ Vaibhav

