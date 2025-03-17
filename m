Return-Path: <linux-kernel+bounces-563606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 935ABA64539
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7AF016BD6D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7412121CC7D;
	Mon, 17 Mar 2025 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="luk1APmx"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BD121E0AC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742199795; cv=none; b=bah0H0n1Df3F8hc968gFCGQ2caeaPpRcPCH2kmyKsOO3i0O+M2VfDIPmbbqPKns5yxFPR/Yrj+3VH9f1ofKuw2WdSf4cqQjwVT8juGi3xI3SmAkXQOVXEKezGBRNUj+0bialeNL3+Yf8znLbhLLFKryo6bkeZVhn2e9ky7UNwFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742199795; c=relaxed/simple;
	bh=WpFgNwc8iTy+ic8zvThJh/LrOGJEdfq8lpE+cc/saXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDwfx6Fn4PxrxVbC4BHFWLVEo9tXhZovPIzcs/4snJjtup7/vM9AR3WngKV22+zSewNbMUJYEKbPPMgJgNHCnni6ogfijJ/ZOBZBI8KlVSvWF5g6HPsCHuRfU7xpMlnAAarvBtgaEdiHqogtxFN9DXSnC0Bn14nSvNnATmh798k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=luk1APmx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H7ogoC003088;
	Mon, 17 Mar 2025 08:22:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xvL0Pp
	AeErdyXUkpj2HkMsYgvrJPF4QQTEgBNCTaDmg=; b=luk1APmxpKlPcSQlmSzfPt
	bJkkGaMqDMIqwVtUnlHFGSCWQfgLUU1uL33KhoeIXhWQRnQ1xIVkRIgPnb9Hk72P
	Zd8xn3Gkr9/CWhAXFdcD9sNjNpluhjcMHHh2ZdJVGLT2GZ6+v3w5mEK/Yk77fRs+
	QhzpJYags6gOp3WcXCiJTBQLeAEqV+qouexScParQ34KqmS/8hylEN6EMBQorU2I
	as2jCw7fxXZWI/V106NVRDuNhxw6XTRtDdBVpmrwTvavQHnbvH/yBgBrAVOayVkG
	HHVR/yF3KEWxbBfhFYB8oXPFUr4pWIcqZmb/jN1WXgzaGZTj0mLt4V+YJGiLJU8A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45e5v0258v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 08:22:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52H4WA0i012451;
	Mon, 17 Mar 2025 08:22:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dmvnn611-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 08:22:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52H8Mss751839450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 08:22:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F37D820043;
	Mon, 17 Mar 2025 08:22:53 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B70C20040;
	Mon, 17 Mar 2025 08:22:53 +0000 (GMT)
Received: from [9.109.215.252] (unknown [9.109.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Mar 2025 08:22:52 +0000 (GMT)
Message-ID: <b0e222ca-0226-45fc-b348-fd21f691a466@linux.ibm.com>
Date: Mon, 17 Mar 2025 13:52:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 05/46] genirq/resend: Switch to lock guards
To: Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20250313154615.860723120@linutronix.de>
 <20250313155914.210122456@linutronix.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250313155914.210122456@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F6Bntv2FJGEY3YGffif2_P9GgwkICafG
X-Proofpoint-GUID: F6Bntv2FJGEY3YGffif2_P9GgwkICafG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_02,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 impostorscore=0 adultscore=0 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503170058

Hi Thomas.

On 3/13/25 21:29, Thomas Gleixner wrote:
> Convert all lock/unlock pairs to guards and tidy up the code.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   kernel/irq/resend.c |   50 +++++++++++++++++++++-----------------------------
>   1 file changed, 21 insertions(+), 29 deletions(-)
> 
> --- a/kernel/irq/resend.c
> +++ b/kernel/irq/resend.c
> @@ -30,18 +30,17 @@ static DEFINE_RAW_SPINLOCK(irq_resend_lo
>    */
>   static void resend_irqs(struct tasklet_struct *unused)
>   {
> -	struct irq_desc *desc;
> -
> -	raw_spin_lock_irq(&irq_resend_lock);
> +	guard(raw_spinlock_irq)(&irq_resend_lock);
>   	while (!hlist_empty(&irq_resend_list)) {
> -		desc = hlist_entry(irq_resend_list.first, struct irq_desc,
> -				   resend_node);
> +		struct irq_desc *desc;
> +
> +		desc = hlist_entry(irq_resend_list.first, struct irq_desc,  resend_node);
>   		hlist_del_init(&desc->resend_node);
> +
>   		raw_spin_unlock(&irq_resend_lock);
>   		desc->handle_irq(desc);
>   		raw_spin_lock(&irq_resend_lock);
>   	}
> -	raw_spin_unlock_irq(&irq_resend_lock);
>   }
>   
>   /* Tasklet to handle resend: */
> @@ -75,19 +74,18 @@ static int irq_sw_resend(struct irq_desc
>   	}
>   
>   	/* Add to resend_list and activate the softirq: */
> -	raw_spin_lock(&irq_resend_lock);
> -	if (hlist_unhashed(&desc->resend_node))
> -		hlist_add_head(&desc->resend_node, &irq_resend_list);
> -	raw_spin_unlock(&irq_resend_lock);
> +	scoped_guard (raw_spinlock, &irq_resend_lock) {

Nit: Any reason why it is "scoped_guard ()" instead of "scoped_guard()". 
Is there a difference between the two?

I have seen in the current code base both are present, i would be nice 
to have one of it no? or guideline on which one to use when?

> +		if (hlist_unhashed(&desc->resend_node))
> +			hlist_add_head(&desc->resend_node, &irq_resend_list);
> +	}
>   	tasklet_schedule(&resend_tasklet);
>   	return 0;
>   }
>   
>   void clear_irq_resend(struct irq_desc *desc)
>   {
> -	raw_spin_lock(&irq_resend_lock);
> +	guard(raw_spinlock)(&irq_resend_lock);
>   	hlist_del_init(&desc->resend_node);
> -	raw_spin_unlock(&irq_resend_lock);
>   }
>   
>   void irq_resend_init(struct irq_desc *desc)
> @@ -172,30 +170,24 @@ int check_irq_resend(struct irq_desc *de
>    */
>   int irq_inject_interrupt(unsigned int irq)
>   {
> -	struct irq_desc *desc;
> -	unsigned long flags;
> -	int err;
> +	int err = -EINVAL;
>   
>   	/* Try the state injection hardware interface first */
>   	if (!irq_set_irqchip_state(irq, IRQCHIP_STATE_PENDING, true))
>   		return 0;
>   
>   	/* That failed, try via the resend mechanism */
> -	desc = irq_get_desc_buslock(irq, &flags, 0);
> -	if (!desc)
> -		return -EINVAL;
> +	scoped_irqdesc_get_and_buslock(irq, 0) {
> +		struct irq_desc *desc = scoped_irqdesc;
>   
> -	/*
> -	 * Only try to inject when the interrupt is:
> -	 *  - not NMI type
> -	 *  - activated
> -	 */
> -	if (irq_is_nmi(desc) || !irqd_is_activated(&desc->irq_data))
> -		err = -EINVAL;
> -	else
> -		err = check_irq_resend(desc, true);
> -
> -	irq_put_desc_busunlock(desc, flags);
> +		/*
> +		 * Only try to inject when the interrupt is:
> +		 *  - not NMI type
> +		 *  - activated
> +		 */
> +		if (!irq_is_nmi(desc) && irqd_is_activated(&desc->irq_data))
> +			err = check_irq_resend(desc, true);
> +	}
>   	return err;
>   }
>   EXPORT_SYMBOL_GPL(irq_inject_interrupt);
> 
> 


