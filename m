Return-Path: <linux-kernel+bounces-400077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE79B9C08A7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3769AB22B98
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33DE213141;
	Thu,  7 Nov 2024 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eCUIcqkO"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B854D212F06
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988820; cv=none; b=S9ZaZO1lWnfF1sdxjYqG2J/2ch1mb5sfe4nHxmJFn8PCPG1fVj9JDih26wEWxDTrj59teKbzAGxZchYVC7XTj7VfcGTYo/ubIJe1qWnaNZjInqvZKPW/xvlSuG4cJvYxjwCl69OBmLN+XiIe+Jg8BY6mlpy+LaAOmiIMLqoL098=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988820; c=relaxed/simple;
	bh=37ObabFHx3U9TJg7HWgEMySRuRc8p07l9tVjXD0hGPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkVGnFWrOqBIU2UVX4iTZLwY8XDXaWiV6ee4yGGqZD2ueqk6PodKmb9w5ac+pcnJNDqyIRjTfsyE/nZblFO2zZ8QRF/jUwM3VfgjVP8enPIJZgn3CwW1r/SEy7Q8ClrhKP9ZJEWgxNv9CdXKkkXd8cnuzRGMEZUb1n6goMF8CSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eCUIcqkO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7E9u3E031182;
	Thu, 7 Nov 2024 14:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=AwU6f9g4/UeatPa2CtGBIPn3FGkR1+
	NhcMAHd7GfVmw=; b=eCUIcqkOK7dYvjvVdiIjPHmAUA57a067NEYFAaGdemuBWI
	sk0IM22A6ACkaVbQEg3nbSdg782xm+Loa2JHh8aCG9SEy1m5wYJRZ+/P+JM3h2Yz
	90UqrcVfohmnpJs6RcyT4HYWcF9NJWyH/DouoAjHYU+aRm74vfpHItzvUtrk0GiD
	/i8nr9k0mhP1hNaiV00szCkrED1KPCRZs2QlApICiariuJJOnNRM8w9jxj5Wrk/m
	c1uHIuB0WZGgtNneB1O3YLbXL5sy2gyeUKaIiOHhNjblfvYssvPPzXXT5YfP+L5O
	yIeghTXtnNPhkemUXFJHLJlY/fs4zPAjzpCy/nqA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rxmrr503-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 14:12:45 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A7ECjh8005385;
	Thu, 7 Nov 2024 14:12:45 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rxmrr4yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 14:12:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7BbM5K031854;
	Thu, 7 Nov 2024 14:12:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nydmrb9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 14:12:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A7ECgjk34079400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 14:12:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66BB120043;
	Thu,  7 Nov 2024 14:12:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 792EF20040;
	Thu,  7 Nov 2024 14:12:40 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown [9.124.213.199])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 Nov 2024 14:12:40 +0000 (GMT)
Date: Thu, 7 Nov 2024 19:42:37 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
        maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/powerpc/pseries: Fix KVM guest detection for
 disabling hardlockup detector
Message-ID: <2kkln3emctf7ewsh3eysujid2e7jel7yjtscfxmqeymeo5bjxf@7yzi5eye2n5j>
References: <20241105132734.499506-1-gautam@linux.ibm.com>
 <87ed3ncl8q.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed3ncl8q.fsf@mpe.ellerman.id.au>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k25Z8U5bE-r4wwIghCv9v7MsnU_Vs5Jf
X-Proofpoint-GUID: z54yCQYWmv27il52UZDaWwWxbk7EIW0d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070110

On Thu, Nov 07, 2024 at 10:54:29PM +1100, Michael Ellerman wrote:
> Gautam Menghani <gautam@linux.ibm.com> writes:
> > As per the kernel documentation[1], hardlockup detector should be
> > disabled in KVM guests as it may give false positives. On PPC, hardlockup
> > detector is broken inside KVM guests because disable_hardlockup_detector()
>  
> Isn't it the opposite? Inside KVM guests, the hardlockup detector should
> be *disabled*, but it's not it's *enabled*, due to this bug.
> 
> ie. it's not broken, it's working, but that's the bug.

Yes right, will change the description in v2.

> 
> > is marked as early_initcall and it uses is_kvm_guest(), which is
> > initialized by check_kvm_guest() later during boot as it is a
> > core_initcall. check_kvm_guest() is also called in pSeries_smp_probe(),
> > which is called before initcalls, but it is skipped if KVM guest does
> > not have doorbell support or if the guest is launched with SMT=1.
> 
> I'm wondering how no one has noticed. Most KVM guests have SMT=1.

Looking at the commit history, code around hardlockups and
pSeries_smp_probe() was changed around 2021/2022 timeframe, and I
believe KVM wasn't being actively tested at the time. 
Even I noticed this only after coming across the documentation that said
hardlockups should be disabled. So probably this feature decision isn't
widely known.

> 
> > Move the check_kvm_guest() call in pSeries_smp_probe() to the initial
> > part of function before doorbell/SMT checks so that "kvm_guest" static
> > key is initialized by the time disable_hardlockup_detector() runs.
> 
> check_kvm_guest() is safe to be called multiple times so
> disable_hardlockup_detector() should just call it before it calls
> is_kvm_guest(). That should avoid future breakage when the order of
> calls changes, or someone refactors pSeries_smp_probe().

Yeah I did that initially but in the worst case, that results in 3 calls
to check_kvm_guest() - the core_initcall, pseries_smp_probe() call and 
then disable_hardlockup_detector(). Will that be fine?

> 
> Can you identify the commit that broke this and include a Fixes: tag
> please.

Yes will do

Thanks,
Gautam

