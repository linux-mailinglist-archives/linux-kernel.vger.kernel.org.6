Return-Path: <linux-kernel+bounces-307044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37FB964730
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42F81C22AB8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332321AC44F;
	Thu, 29 Aug 2024 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b0R9G5tw"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D0A19306A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939471; cv=none; b=mcMNGpyfK6DDLUddUHttV6TKX1AZZZpQiedqF1hiUMBlyoWG4FxWNkzEQEwuC3J1dLf1NZ+8mucVonzKQMovTfQlARVHW7KsLeD3amDyxAg8cWM+tMT0AryaiyEMtDwtPQAot9mXwMbNZmWnUFKJTAJMsJOgq77YZqnw0HgBPAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939471; c=relaxed/simple;
	bh=4QljaFl3Vsm9a0816zRPEctRjY+migg2Hk0Qnd+JvBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nhWDlgUcMDtPZn8+kwwPP2sGaqgm6UCH5r5IAdfQ17VsBweUk88R8R7sJrZC1gDWkxjo3nLQzSiHUTYSF+qY1x15lhqeY//uVSreYFYa3i0Rkt9pNNzwM2PSS7qC4KzbIo62ySgBQHfDpyBd6z4hS5o4U66eLIv9ClDrxED9U7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b0R9G5tw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47T1d1iZ032155;
	Thu, 29 Aug 2024 13:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=a
	+3jydTIUFLbIFPPVLalUu4+A0e3T4wDvZ2z6IvdjXs=; b=b0R9G5twXU7gFydIO
	aXf8wA33gDoJSrR4LktpwVubpkZgYEHBLgLk6V+iqAAoWSWPO/PWlNOR+ABUyxPI
	LJB3I0Pn+Ztg+QF12O476P9ShwFfBz0664LsSQDb+2p80wKBnVw4stX2jHeWspq0
	oW7hGo9EzOq5KuibsaNSL2xqsY6jcb/ZIL1XExVD8wZ07nPZ3oBo2rR+BsKGsSY5
	TC65xPHjl4hSuDFAafDbDsDksHkwaIYfqN1etuePb9vgEKZrHMAxHhKTn62dS6oR
	o5Hb8HSLVPw6Np0BxaVMemBBkukqd1J6BR9VhtsvFuOXySuD3xfr1bvkNxEYdrAU
	cYBOA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8u87hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 13:50:42 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47TDlOxk019521;
	Thu, 29 Aug 2024 13:50:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8u87hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 13:50:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47TAFKCk030966;
	Thu, 29 Aug 2024 13:50:41 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 417t8150nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 13:50:41 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47TDoeQE44171692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 13:50:40 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AA0D58056;
	Thu, 29 Aug 2024 13:50:40 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 147FC58052;
	Thu, 29 Aug 2024 13:50:37 +0000 (GMT)
Received: from [9.171.43.86] (unknown [9.171.43.86])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Aug 2024 13:50:36 +0000 (GMT)
Message-ID: <4afe5232-78ae-42a0-9b6d-669cc7f6b051@linux.ibm.com>
Date: Thu, 29 Aug 2024 19:20:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] powerpc/pci: restore LSI mappings on card present
 state change
To: Oleksandr Ocheretnyi <oocheret@cisco.com>, xe-linux-external@cisco.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20240827165738.1083422-1-oocheret@cisco.com>
Content-Language: en-US
From: krishna kumar <krishnak@linux.ibm.com>
In-Reply-To: <20240827165738.1083422-1-oocheret@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kW1vDl35JfHWQ3ie-6t96PKSIaohLPkB
X-Proofpoint-ORIG-GUID: DKI4L79Go83gBxnv02tt_RQ1MpoQlA-2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290093


On 8/27/24 22:27, Oleksandr Ocheretnyi wrote:
> Commit 450be4960a0f ("powerpc/pci: Remove LSI mappings on device
> teardown") frees irq descriptors on PCIe hotplug link change event
> (Link Down), but the disposed mappings are not restored back on PCIe
> hotplug link change event (Card present).
>
> This change restores IRQ mappings disposed earlier when pcieport
> link's gone down. So, the call pci_read_irq_line is invoked again
> on pcieport's state change (Card present).

Few things are important to know regarding these change-sets:

1. The commit (450be4960aof) addressed an issue where the removal
or hot-unplug of an LSI passthroughed IO adapter was not working on
pseries machines. This was due to interrupt resources not getting cleaned
up before removal. Since there were no pcibios_* hooks for the interrupt
cleanup, the interrupt-related resource cleanup has been addressed using
the notifier framework and an explicit call of ppc_pci_intx_release().

2. Does without your current patch and after hot-plug operation, device is
not working (io not happening or interrupt not getting generated) correctly ?

3. There is already a pcibios_* hook available for creating the interrupt
mapping. Here's a snippet -

  /*
   * Called after device has been added to bus and
   * before sysfs has been created.
   */

void (*pcibios_bus_add_device)(struct pci_dev *pdev);

Above function calls - below function to restore the irq mapping.

/* Read default IRQs and fixup if necessary */
   pci_read_irq_line(dev);

4. Does the above pcibios_* hook not sufficient for enabling the interrupt
mapping or does it not getting invoked during hot-plug operation ?

>
> Fixes 450be4960a0f ("powerpc/pci: Remove LSI mappings on device teardown")
> Signed-off-by: Oleksandr Ocheretnyi <oocheret@cisco.com>
> ---
>   arch/powerpc/kernel/pci-common.c | 30 ++++++++++++++++++++----------
>   1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index eac84d687b53..a0e7cab2baa7 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -390,22 +390,32 @@ static void ppc_pci_intx_release(struct kref *kref)
>   	kfree(vi);
>   }
>   
> +static int pci_read_irq_line(struct pci_dev *pci_dev);
> +
>   static int ppc_pci_unmap_irq_line(struct notifier_block *nb,
>   			       unsigned long action, void *data)
>   {
>   	struct pci_dev *pdev = to_pci_dev(data);
>   
> -	if (action == BUS_NOTIFY_DEL_DEVICE) {
> -		struct pci_intx_virq *vi;
> -
> -		mutex_lock(&intx_mutex);
> -		list_for_each_entry(vi, &intx_list, list_node) {
> -			if (vi->virq == pdev->irq) {
> -				kref_put(&vi->kref, ppc_pci_intx_release);
> -				break;
> +	switch (action) {
> +		case BUS_NOTIFY_DEL_DEVICE:
> +			{
> +				struct pci_intx_virq *vi;
> +
> +				mutex_lock(&intx_mutex);
> +				list_for_each_entry(vi, &intx_list, list_node) {
> +					if (vi->virq == pdev->irq) {
> +						kref_put(&vi->kref, ppc_pci_intx_release);
> +						break;
> +					}
> +				}
> +				mutex_unlock(&intx_mutex);
>   			}
> -		}
> -		mutex_unlock(&intx_mutex);
> +			break;
> +
> +		case BUS_NOTIFY_ADD_DEVICE:
> +			pci_read_irq_line(pdev);
> +			break;

The above code is fine only if my aforementioned points do not hold.

>   	}
>   
>   	return NOTIFY_DONE;


Best Regards,

Krishna


