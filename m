Return-Path: <linux-kernel+bounces-361571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2465D99A9EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46C71F25748
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD491BD519;
	Fri, 11 Oct 2024 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gD64PAQg"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612531A070E;
	Fri, 11 Oct 2024 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667565; cv=none; b=W86+GgzTZ+6VbEbLqA4yBHlXsD7JLNketuEiinr2qgRwhLIvMFaMl67rcuvIg5LUBrh/FBzVtPPzXnNsWtG3k0Ah+YlSnzHL4RttQ+zdGU8Brxf9AhJxVkeXrOszqMoIHSutXAfFM71Lkv0yG8QJH4RbuCgXtnvB5XKE9cpvWvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667565; c=relaxed/simple;
	bh=d4XdU7LwmImoIfgJxzrFLRWHX5GkzhJSbQ2gevvsFFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctr9vR4tR2W64pQpWpcqsW/iSw5x9GbS+ZBWR/wF2Hs0oWNkUAKqIGEb3eTeq+S8fobhuL+vGAoeQq6VDKC3qsBR3N5lfzU9lE6N//e8sD/8YG+0FPX2+FDI03kL9YPhiC1IE3IbStMNev3/wSMU92VnCI/LAoPB7QitQTq4PsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gD64PAQg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BGj2gs020365;
	Fri, 11 Oct 2024 17:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=qHmCblbnT4h7Ll7/4j0U3z5eo/7
	FTineVarzU4VqC4A=; b=gD64PAQgidBAXddYtz5jaaON0ZL6wA2rXPcIK3T8vxw
	WnTrEgnJVsLhdLqdgLYj1ic65/O6Zr3HRJUqR3jy9fi1Ox9lfKIUerpdlyNjuHpQ
	q/0FJEII34EK/fT7NQ0u46krnIV+aZCFrOGpBxzN8yptStXfyWVx/p8lIem2y6Kj
	LuZJcWlYkUPEjG1aiYWz3m1IC95/pGLXUb97M6j61RteZ13SHgf+7SqNG5+RYfno
	4jWSnZ7fUL7UWTvzR0r+IXiJXV4VpnsVC3tmzMY/USBPcKWaeJNirJPKYEfP7gHS
	gc3lYFluJ1YUmL2Pr3eE6vDrBPABGwr46AJ1wPeY+lQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4277tgg4qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 17:20:39 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49BHH8AP020562;
	Fri, 11 Oct 2024 17:20:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4277tgg4qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 17:20:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49BGOQgB011535;
	Fri, 11 Oct 2024 17:20:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423g5y6w5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 17:20:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49BHKa0e40173902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 17:20:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFD4D20043;
	Fri, 11 Oct 2024 17:20:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6496C20040;
	Fri, 11 Oct 2024 17:20:34 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.219.55])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 11 Oct 2024 17:20:34 +0000 (GMT)
Date: Fri, 11 Oct 2024 22:50:31 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/nx: Invalid wait context issue when rebooting
Message-ID: <ZwleX01sala8Rc3-@linux.ibm.com>
References: <ZwjjXJ5UtZ28FH6s@linux.ibm.com>
 <87wmif53iw.fsf@mail.lhotse>
 <ZwkPT3H_WVd5KyZQ@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwkPT3H_WVd5KyZQ@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Mf_Y6sY-NXVwBknLbevm1FOmpe1qMtCC
X-Proofpoint-ORIG-GUID: XABgsGASvsuwhi3rAvjn_8r01EzCr0fL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_14,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410110118

On Fri, Oct 11, 2024 at 05:13:11PM +0530, Vishal Chourasia wrote:
> On Fri, Oct 11, 2024 at 09:37:27PM +1100, Michael Ellerman wrote:
> > Vishal Chourasia <vishalc@linux.ibm.com> writes:
> > > Hi,
> > > I am getting Invalid wait context warning printed when rebooting lpar
> > >
> > > kexec/61926 is trying to acquire `of_reconfig_chain.rwsem` while holding
> > > spinlock `devdata_mutex`
> > >
> > > Note: Name of the spinlock is misleading.
> > 
> > Oof, yeah let's rename that to devdata_spinlock at least.
> > 
> > > In my case, I compiled a new vmlinux file and loaded it into the running
> > > kernel using `kexec -l` and then hit `reboot`
> > >
> > > dmesg:
> > > ------
> > >
> > > [ BUG: Invalid wait context ]
> > > 6.11.0-test2-10547-g684a64bf32b6-dirty #79 Not tainted
> > 
> > Is that v6.11 plus ~10,000 patches? O_o
> > 
> > Ah no, 684a64bf32b6 is roughly v6.12-rc1. Maybe if you fetch tags into
> > your tree you will get a more sensible version string?
> > 
> > Could also be good to try v6.12-rc2.
> Sure.
> > 
> > > -----------------------------
> > > kexec/61926 is trying to lock:
> > > c000000002d8b590 ((of_reconfig_chain).rwsem){++++}-{4:4}, at: blocking_notifier_chain_unregister+0x44/0xa0
> > > other info that might help us debug this:
> > > context-{5:5}
> > > 4 locks held by kexec/61926:
> > >  #0: c000000002926c70 (system_transition_mutex){+.+.}-{4:4}, at: __do_sys_reboot+0xf8/0x2e0
> > >  #1: c00000000291af30 (&dev->mutex){....}-{4:4}, at: device_shutdown+0x160/0x310
> > >  #2: c000000051011938 (&dev->mutex){....}-{4:4}, at: device_shutdown+0x174/0x310
> > >  #3: c000000002d88070 (devdata_mutex){....}-{3:3}, at: nx842_remove+0xac/0x1bc
> >   
> > That's pretty conclusive.
> > 
> > I don't understand why you're the first person to see this. I can't see
> > that any of the relevant code has changed recently. Unless something in
> > lockdep itself changed?
> > 
> > Did you just start seeing this on recent kernels? Can you bisect?
> Yes. Sure, I will try bisecting, and get back.
I tested for v6.0, v6.6, v6.9 kernel version, and all of them hit this
bug. 

Also, this bug is hit when I load the vmlinux file using `kexec -l`
and do a reboot.
> > 
> > > stack backtrace:
> > > CPU: 2 UID: 0 PID: 61926 Comm: kexec Not tainted 6.11.0-test2-10547-g684a64bf32b6-dirty #79
> > > Hardware name: IBM,9080-HEX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.00 (NH1060_012) hv:phyp pSeries
> > > Call Trace:
> > > [c0000000bb577400] [c000000001239704] dump_stack_lvl+0xc8/0x130 (unreliable)
> > > [c0000000bb577440] [c000000000248398] __lock_acquire+0xb68/0xf00
> > > [c0000000bb577550] [c000000000248820] lock_acquire.part.0+0xf0/0x2a0
> > > [c0000000bb577670] [c00000000127faa0] down_write+0x70/0x1e0
> > > [c0000000bb5776b0] [c0000000001acea4] blocking_notifier_chain_unregister+0x44/0xa0
> > > [c0000000bb5776e0] [c000000000e2312c] of_reconfig_notifier_unregister+0x2c/0x40
> > > [c0000000bb577700] [c000000000ded24c] nx842_remove+0x148/0x1bc
> > > [c0000000bb577790] [c00000000011a114] vio_bus_remove+0x54/0xc0
> > > [c0000000bb5777c0] [c000000000c1a44c] device_shutdown+0x20c/0x310
> > > [c0000000bb577850] [c0000000001b0ab4] kernel_restart_prepare+0x54/0x70
> > > [c0000000bb577870] [c000000000308718] kernel_kexec+0xa8/0x110
> > > [c0000000bb5778e0] [c0000000001b1144] __do_sys_reboot+0x214/0x2e0
> > > [c0000000bb577a40] [c000000000032f98] system_call_exception+0x148/0x310
> > > [c0000000bb577e50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec
> > 
> > I don't see why of_reconfig_notifier_unregister() needs to be called
> > with the devdata_mutext held, but I haven't looked that closely at it.
> > 
> > So the change below might work.
> > 
> > cheers
> > 
> > diff --git a/drivers/crypto/nx/nx-common-pseries.c b/drivers/crypto/nx/nx-common-pseries.c
> > index 35f2d0d8507e..a2050c5fb11d 100644
> > --- a/drivers/crypto/nx/nx-common-pseries.c
> > +++ b/drivers/crypto/nx/nx-common-pseries.c
> > @@ -1122,10 +1122,11 @@ static void nx842_remove(struct vio_dev *viodev)
> >  
> >  	crypto_unregister_alg(&nx842_pseries_alg);
> >  
> > +	of_reconfig_notifier_unregister(&nx842_of_nb);
> > +
> >  	spin_lock_irqsave(&devdata_mutex, flags);
> >  	old_devdata = rcu_dereference_check(devdata,
> >  			lockdep_is_held(&devdata_mutex));
> > -	of_reconfig_notifier_unregister(&nx842_of_nb);
> >  	RCU_INIT_POINTER(devdata, NULL);
> >  	spin_unlock_irqrestore(&devdata_mutex, flags);
> >  	synchronize_rcu();
> > 

