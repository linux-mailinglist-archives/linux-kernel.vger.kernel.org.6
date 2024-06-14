Return-Path: <linux-kernel+bounces-214324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A169082C7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E881C229D4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2F71474C6;
	Fri, 14 Jun 2024 03:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hl396kw/"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388331474BA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718337181; cv=none; b=Ep40XnV0DeXt4Pg2GF2z7wF+D301eHi60wYxUb9QmDbHOWBUHsZXsBi8m4lGdvxNIemrkjzWeNN7ftpz/sCt5cewhyPm5W6Fx4K4P+FAPWqbE8xd+CeqHC2nQ+jnoOWsGCbId2H9VXJm0QNmuPRtQDq+4liRFY6+kIHwXbkId/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718337181; c=relaxed/simple;
	bh=NGIk/G1j1QivtRlto+W3eZFS1naqnXftrbavFKGpr5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hnkklwj0k+uTN2TjBG0XXkkiWpYvIt05OuANf5wcDCwRRgN7LBLnM/ftX5Xvj1NmhmxYnjITvPputDVBa8bekms4pdzuYLVNeVh/vrkDzbFR/L/Eq52EcIeL8qgBPobrXs8w207j2IkFaCDjdc19jGnoygJDelnn+jmcmfx9zsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hl396kw/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E3VAXg028468;
	Fri, 14 Jun 2024 03:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=YqDBOBB+klZnwQ4u4HVSWBlFf19
	ScRoRTYcE9T62iYY=; b=Hl396kw/SyeeCERHv+qQTgxdrOYhI0BPok8SQDUlKEY
	ip0NkJmJlQmsebWr3ZdkMrCteyBnK3dbf/FT1hLtWsEHjRK21/DDx7Ek4Lz5M6T/
	sQR/rzq80qNHICr9fOuynsNIkL8uSLbbi1Xa7Ji8EJxmVQYmCUgsegAzC9bsW0Pn
	KfZ6eZpfGqWjoLQn7QbBqsIv+OjDM3Eh9V+UoCozbz2Gc3F/FjkXEIHaZrrBhf0W
	SJ15cShJKlbpDXPA7jcOU6/YDO8bG4y7he1q7rUXG66K4mnrFALwtAikOSiuDvps
	HP7sY6NEqUhW+SkLYBgL6c5M7bTN4GyOrsZ+LCPFfqQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yre0er22v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 03:52:27 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45E3qRcD028506;
	Fri, 14 Jun 2024 03:52:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yre0er22t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 03:52:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45E1Epm3003916;
	Fri, 14 Jun 2024 03:52:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn2mqduxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 03:52:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45E3qKpP48628056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 03:52:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65E422006F;
	Fri, 14 Jun 2024 03:52:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7B6920063;
	Fri, 14 Jun 2024 03:52:19 +0000 (GMT)
Received: from localhost (unknown [9.124.219.48])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Jun 2024 03:52:19 +0000 (GMT)
Date: Fri, 14 Jun 2024 09:22:15 +0530
From: "Nysal Jan K.A." <nysal@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Skip offline cores when enabling SMT on PowerPC
Message-ID: <s2x7yvilqnonpkl75w2os6vpvw7jn6b5jlr2t6dn7krgxzmmhz@vjs32jxuf4pc>
References: <20240612185046.1826891-1-nysal@linux.ibm.com>
 <875xudoz4d.fsf@mail.lhotse>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xudoz4d.fsf@mail.lhotse>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e3mpk2FUehqqVJw59LwgnSLhKYKl4ipF
X-Proofpoint-ORIG-GUID: _jD6RlOvnKSXbm5gx5F0j_kom45eQ4P6
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406140020

On Thu, Jun 13, 2024 at 09:34:10PM GMT, Michael Ellerman wrote:
> "Nysal Jan K.A." <nysal@linux.ibm.com> writes:
> > From: "Nysal Jan K.A" <nysal@linux.ibm.com>
> >
> > After the addition of HOTPLUG_SMT support for PowerPC [1] there was a
> > regression reported [2] when enabling SMT.
> 
> This implies it was a kernel regression. But it can't be a kernel
> regression because previously there was no support at all for the sysfs
> interface on powerpc.
> 
> IIUIC the regression was in the ppc64_cpu userspace tool, which switched
> to using the new kernel interface without taking into account the way it
> behaves.
> 
> Or are you saying the kernel behaviour changed on x86 after the powerpc
> HOTPLUG_SMT was added?
> 

The regression is in ppc64_cpu. If we need the older behaviour we will need this
or an equivalent change in the kernel though. Fixing it in userspace in an
efficient way might be difficult.

> > On a system with at least
> > one offline core, when enabling SMT, the expectation is that no CPUs
> > of offline cores are made online.
> >
> > On a POWER9 system with 4 cores in SMT4 mode:
> > $ ppc64_cpu --info
> > Core   0:    0*    1*    2*    3*
> > Core   1:    4*    5*    6*    7*
> > Core   2:    8*    9*   10*   11*
> > Core   3:   12*   13*   14*   15*
> >
> > Turn only one core on:
> > $ ppc64_cpu --cores-on=1
> > $ ppc64_cpu --info
> > Core   0:    0*    1*    2*    3*
> > Core   1:    4     5     6     7
> > Core   2:    8     9    10    11
> > Core   3:   12    13    14    15
> >
> > Change the SMT level to 2:
> > $ ppc64_cpu --smt=2
> > $ ppc64_cpu --info
> > Core   0:    0*    1*    2     3
> > Core   1:    4     5     6     7
> > Core   2:    8     9    10    11
> > Core   3:   12    13    14    15
> >
> > As expected we see only two CPUs of core 0 are online
> >
> > Change the SMT level to 4:
> > $ ppc64_cpu --smt=4
> > $ ppc64_cpu --info
> > Core   0:    0*    1*    2*    3*
> > Core   1:    4*    5*    6*    7*
> > Core   2:    8*    9*   10*   11*
> > Core   3:   12*   13*   14*   15*
> >
> > The CPUs of offline cores are made online. If a core is offline then
> > enabling SMT should not online CPUs of this core.
> 
> That's the way the ppc64_cpu tool behaves, but it's not necessarily what
> other arches want.
> 

True, but from a user perspective it seems logical though. I think one can make
a case for either behaviour. 

> > An arch specific
> > function topology_is_core_online() is proposed to address this.
> > Another approach is to check the topology_sibling_cpumask() for any
> > online siblings. This avoids the need for an arch specific function
> > but is less efficient and more importantly this introduces a change
> > in existing behaviour on other architectures.
> 
> It's only x86 and powerpc right?
> 
> Having different behaviour on the only two arches that support the
> interface does not seem like a good result.
> 

Agree, I was originally thinking of sending out a patch changing this for both
architectures, but was unsure if there might be users who now depend on this
behaviour on x86.

> > What is the expected behaviour on x86 when enabling SMT and certain cores
> > are offline? 
> 
> AFAIK no one really touches SMT on x86 other than to turn it off for
> security reasons.
> 
> cheers
> 

Thanks for your comments. It will be good to hear if changing this behaviour
for both x86 and PowerPC might be an acceptable path forward.

Regards
--Nysal

> > [1] https://lore.kernel.org/lkml/20230705145143.40545-1-ldufour@linux.ibm.com/
> > [2] https://groups.google.com/g/powerpc-utils-devel/c/wrwVzAAnRlI/m/5KJSoqP4BAAJ
> >
> > Nysal Jan K.A (2):
> >   cpu/SMT: Enable SMT only if a core is online
> >   powerpc/topology: Check if a core is online
> >
> >  arch/powerpc/include/asm/topology.h | 13 +++++++++++++
> >  kernel/cpu.c                        | 12 +++++++++++-
> >  2 files changed, 24 insertions(+), 1 deletion(-)
> >
> >
> > base-commit: c760b3725e52403dc1b28644fb09c47a83cacea6
> > -- 
> > 2.35.3

