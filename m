Return-Path: <linux-kernel+bounces-344535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 233BC98AAFD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9531C22E13
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBD0195FFA;
	Mon, 30 Sep 2024 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h8BWNBbG"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2CC193416
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716803; cv=none; b=X/RA2vvatQIuSnZ0ulGp5VW5S5LFcZTDSSoHXkO5KWGmJPlnFG/Gircy/B78Za5+tNjXv+FsXtvgRj80L/BW7n0zbaYG1wZCxTpAyzFFIpy37MuYxTNM2VEt4Ss8dhYltrjh7Piz7mc7Yz70LKQgDJqdFVmiXGQ/k2LyFQ8ppOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716803; c=relaxed/simple;
	bh=HUlp4+9vnQ8mzU5IidX9bUwbnyCuarQYAu8fAnyFcTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMRKppMwBaZ00dPaYXSwviK7OcwGyEMV7tXIuTGBAO3fOGNggYke43aXUSk02nRc7sqWk3Za9DzMnxUjZ36evmWe846y9InXNS7BPlbk4MEPXwgeDSrqCwSk+Wnf4YYL7/MQm4jaQ5rVqElvTgzBfRtJtexdT3KEOu+SXJfTbo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h8BWNBbG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UAcmut027558;
	Mon, 30 Sep 2024 17:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=QPvsOh1CGi5uMLg1SlnPg+4yIL+
	KNmslqtGznAHWvUU=; b=h8BWNBbGYPbQrHdPJYN1Asclt9kSEm5Wi1cZvHGlszS
	3bKba6F78hrrKrkuJHg8fP4z96P7+ge7HhnLSQRrKspMyzx54MtL4aXA2Rdctf7A
	IK+n9NeulSugxep78+nYfcvzKNUKEU4DEdDrzC6b7A11zdm38Z8trMqZblV+H+vz
	VEUF/8AuoMEBVaX1MD+gkcgDItQC1w07gNY7kJHp6UEnmM2GeGSVyopFNmT0uEhh
	YVrEF5QKureoFQ1yWWe9kUaqYFuUUGrb31Yuu+XqMUAxhDruXys/UEYH5siCaAq4
	fFHO3ZHsvGAqgCtf/nU8jTmkPxvElm9h0M5uTVewZeQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9fwu816-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 17:19:47 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UHJkJO014421;
	Mon, 30 Sep 2024 17:19:47 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9fwu812-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 17:19:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UFoqhi002386;
	Mon, 30 Sep 2024 17:19:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxu0yexn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 17:19:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UHJiue7668180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 17:19:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DF242004B;
	Mon, 30 Sep 2024 17:19:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2000B20043;
	Mon, 30 Sep 2024 17:19:42 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.31.120])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 30 Sep 2024 17:19:41 +0000 (GMT)
Date: Mon, 30 Sep 2024 22:49:39 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 10/20] net: pktgen: Use kthread_create_on_node()
Message-ID: <Zvrdq43viQlcyk-K@linux.ibm.com>
References: <20240926224910.11106-1-frederic@kernel.org>
 <20240926224910.11106-11-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926224910.11106-11-frederic@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VUi9ILBPQRH-usCTxvPxOM7twC--9Lq6
X-Proofpoint-GUID: 7UMbkstHGfvhiz614bE2Fpoc6IezdRcX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_16,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=531 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300124

On Fri, Sep 27, 2024 at 12:48:58AM +0200, Frederic Weisbecker wrote:
> Use the proper API instead of open coding it.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  net/core/pktgen.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> index 34f68ef74b8f..7fcb4fc7a5d6 100644
> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -3883,17 +3883,14 @@ static int __net_init pktgen_create_thread(int cpu, struct pktgen_net *pn)
>  	list_add_tail(&t->th_list, &pn->pktgen_threads);
>  	init_completion(&t->start_done);
>  
> -	p = kthread_create_on_node(pktgen_thread_worker,
> -				   t,
> -				   cpu_to_node(cpu),
> -				   "kpktgend_%d", cpu);
> +	p = kthread_create_on_cpu(pktgen_thread_worker, t, cpu, "kpktgend_%d");
Hi Frederic, 

The Subject line says "Use kthread_create_on_node()" while
kthread_create_on_cpu is used in the diff.


>  	if (IS_ERR(p)) {
>  		pr_err("kthread_create_on_node() failed for cpu %d\n", t->cpu);
>  		list_del(&t->th_list);
>  		kfree(t);
>  		return PTR_ERR(p);
>  	}
> -	kthread_bind(p, cpu);
> +
>  	t->tsk = p;
>  
>  	pe = proc_create_data(t->tsk->comm, 0600, pn->proc_dir,
> -- 
> 2.46.0
> 

