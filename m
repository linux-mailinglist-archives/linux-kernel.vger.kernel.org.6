Return-Path: <linux-kernel+bounces-228354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5118915EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAAA1C2186A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F557145B39;
	Tue, 25 Jun 2024 06:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Bczqh/du"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800741B806
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719296018; cv=none; b=d2s95NIjxnFZud17xmm4jq3fi4xjgu8uNA8n1HwifWbM2PI/s7JFSM6jNpuaMydgbrn2RWoqEeWWs0VBNUKQtWo1fDSQNQe9wlBf0zcTVRDE7DcXPYCbXmg4vfsJ7r8hH5420CUC0yu7ca/r4FoGnVZ8iFaDK6hBMG7D783e4V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719296018; c=relaxed/simple;
	bh=cMrS3hRZbamFEDrc5TplaVQlDjl1NP8n+fsS3eR7uis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZkzvsqv4lMU95pFmeQeZIPuq7QCE8i6qI0sOGW+mQ/1CyMpbE4f5n/pyah10Z/ldDWdg3u5+xuuDkQVU4l0UOxgDSv4GAPSgX6Xeyzu0LrOnX6+4RXCt4VZZ2dJobxZ7xqrJ9gdkbWU0+5x2pr7E7LaR0/q9wNzzb4QwAm1yNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Bczqh/du; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P5wjY5027802;
	Tue, 25 Jun 2024 06:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=pMLbcZIkfmFRfthbezC897uG4I0
	nURSyVKsS8MqB7Vw=; b=Bczqh/duFhOa2O+eUCOuOxgo/4OVta06Uuu/7t+BhpU
	e6oSB9/tt3G0HVxsr/iiw68L6776cR/pjwLAaC+gQu6yNNaXQEofrilvb/0ZM8Uf
	RQ8ifYg2v2EO0gssQ4CmErz6n+xfiO3u0YxPDD/yXly6Mlyu0HLv8wrvYgnDMm/V
	BROeWoR0wWuk1jzL4DIrhWW/CNGqX6iYfIKo3xkECGAe9PuZkPZmuxGJkjjEVfWh
	G7KRpHNvJGR1ZO5gaFXTRdE3jSb6S4fqreolb0AbjCzG+ScqaHZF8sCHn7nM0aff
	wx2AZ1yfCyYO5BSgpiNzG/tZ+N50BU1w9FbmFWZk9fg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyr7cg0sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 06:13:14 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45P6DETD016079;
	Tue, 25 Jun 2024 06:13:14 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyr7cg0sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 06:13:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45P4xucd019949;
	Tue, 25 Jun 2024 06:13:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxb5mcjya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 06:13:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45P6D7KR44105996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 06:13:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B253820049;
	Tue, 25 Jun 2024 06:13:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34BF520040;
	Tue, 25 Jun 2024 06:13:07 +0000 (GMT)
Received: from localhost (unknown [9.171.10.36])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Jun 2024 06:13:06 +0000 (GMT)
Date: Tue, 25 Jun 2024 11:43:06 +0530
From: "Nysal Jan K.A." <nysal@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] powerpc/topology: Check if a core is online
Message-ID: <vwwuujb76o26vkce5jd6tnyzzzg4ycktfs2lapkluynhs7hdv7@bejuuqhellfd>
References: <20240612185046.1826891-1-nysal@linux.ibm.com>
 <20240612185046.1826891-3-nysal@linux.ibm.com>
 <985e10dd-230b-4325-856f-1229361205d2@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <985e10dd-230b-4325-856f-1229361205d2@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -oGO8XEZwt9H0oCgxc-J7mg1RBwS7UHc
X-Proofpoint-GUID: hyEvKRbegPIfTRLunqu1SKaZbJrYHCGq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_02,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=500 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250044

On Tue, Jun 25, 2024 at 12:36:33AM GMT, Shrikanth Hegde wrote:
> > --- a/arch/powerpc/include/asm/topology.h
> > +++ b/arch/powerpc/include/asm/topology.h
> > @@ -145,6 +145,7 @@ static inline int cpu_to_coregroup_id(int cpu)
> >  
> >  #ifdef CONFIG_HOTPLUG_SMT
> >  #include <linux/cpu_smt.h>
> > +#include <linux/cpumask.h>
> 
> Is this header file needed? 
> I don't see any reference to cpumask related code. 
> 

cpu_online() is defined in that header.

> >  #include <asm/cputhreads.h>
> >  
> >  static inline bool topology_is_primary_thread(unsigned int cpu)
> > @@ -156,6 +157,18 @@ static inline bool topology_smt_thread_allowed(unsigned int cpu)
> >  {
> >  	return cpu_thread_in_core(cpu) < cpu_smt_num_threads;
> >  }
> > +
> 
> This is defined only if CONFIG_HOTPLUG_SMT is true. But this could be 
> generic function which might be used to check if a core is offline in other cases. 
> Would that make sense to keep it out of CONFIG_HOTPLUG_SMT ?
> 

I'm not opposed to the idea, it would also be easy to do that later if there is
another consumer of this function.

Regards
--Nysal


