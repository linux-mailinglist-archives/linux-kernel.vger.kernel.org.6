Return-Path: <linux-kernel+bounces-380530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A83379AF052
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A48E1F2254F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD745216A24;
	Thu, 24 Oct 2024 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e9jBZG34"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20F7216A36
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729796661; cv=none; b=YslTjl1c2P9FVZqa3S6NP3d/33YvMU8EvNdhYZWTbfDWMtFfVMdbekJ/DjO97WJOkRH6MUtUxPZZWXFxDbTSiKyIS61FG0/cs0WjlJSiZoru1zMk23Vpy8BiFk+YMuVBEiZ4AaAIJav14bFlTJALyc5VWqdn08H3joviQ6SU1V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729796661; c=relaxed/simple;
	bh=8rBpL9HO3evkxdqEdF1FGHYN0tKTg9C/ud7tbTcMFWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPCvQ2tYZRNyMwu3gyMUluyuUztVTGihkgy4awbY6wvAcKdY1C8Ol9V8iviOqoXgIV1/b9bFJ++NITbMO9G1JkoRESTrAAlHPRJ2aqXQ6ooNTtK6K5c/m8fPCSKLbKROjxeueggY/RgfMZhLMHGc8+bCRtr+POAxn1EJS95Cikw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e9jBZG34; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OHv14Y027239;
	Thu, 24 Oct 2024 19:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=l21sLo5cBKHhKQZbxqHQ0o1y5AwOln
	0Y8A7pbBbsCRg=; b=e9jBZG34NxMFJrsN1PkDGRJYKqlCC7auEee7FoL35fb0mN
	pGJMg8ocYfPR5K1XXBOqGjKajvojqVvjdBt93ZZXNj43zB37fkmV8yOa9a1WpdGC
	eQVXwfx+BUoYg1Tgkhyptz1zFrVlRsFfQt2ULLAaUsXT2ftVTUfs90K3Ob/pENI3
	sQ3qnbNygMLLAc5odK4pZHpBb5CEw55SHMEPCfHwp/kg7SOAAqnygF2ryrSDa9Py
	2To7FwTevgy7eLEys3x7z+DeJyzFSlumQmb0ChU3rVbQUp2IY4VWIMH10tYsepLG
	M3osu+u0RCtkN5C19gbp8vA+D0oaIFIWOsqTjX/Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fhxnubna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 19:03:52 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49OJ3pxT013321;
	Thu, 24 Oct 2024 19:03:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fhxnubn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 19:03:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49OI4CcI014317;
	Thu, 24 Oct 2024 19:03:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emhfsytk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 19:03:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49OJ3kN956295764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 19:03:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EF702004B;
	Thu, 24 Oct 2024 19:03:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CA8620040;
	Thu, 24 Oct 2024 19:03:44 +0000 (GMT)
Received: from li-e1dea04c-3555-11b2-a85c-f57333552245.ibm.com (unknown [9.43.37.181])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Oct 2024 19:03:44 +0000 (GMT)
Date: Fri, 25 Oct 2024 00:33:41 +0530
From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
        maddy@linux.ibm.com, peterx@redhat.com, groug@kaod.org,
        sshegde@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/xmon: symbol lookup length fixed
Message-ID: <zkm6fcxaef4gnvvsvykv7po7joytakyhqnmt2j72ej3r4wffn2@j5p6h6h2bwnw>
References: <20241023212225.1306609-2-mchauras@linux.ibm.com>
 <878que2u2i.fsf@mail.lhotse>
 <nxdkjwqtd7s3fcxebwod6lrfu7rngrj7fa4kk433hgypha66w5@6ahbuz7o2qmu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nxdkjwqtd7s3fcxebwod6lrfu7rngrj7fa4kk433hgypha66w5@6ahbuz7o2qmu>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0VTzArYxw5O5bXZIGNwCNtIsbZoXoOta
X-Proofpoint-GUID: S-PZJ0GqJwWwPjZRXQp9sTiBqIl8WrnE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240155

On Thu, Oct 24, 2024 at 10:42:12AM +0530, Mukesh Kumar Chaurasiya wrote:
> On Thu, Oct 24, 2024 at 12:00:53PM +1100, Michael Ellerman wrote:
> > Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com> writes:
> > > Currently xmon cannot lookup symbol beyond 64 characters in some cases.
> > 
> > Can you mention which commands? It looks like it's "ls" and "lp".
> Sure.
> > 
> > > Fix this by using KSYM_NAME_LEN instead of fixed 64 characters.
> > >
> > > Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
> > > ---
> > >  arch/powerpc/xmon/xmon.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> > > index e6cddbb2305f..22b8b5cc4df0 100644
> > > --- a/arch/powerpc/xmon/xmon.c
> > > +++ b/arch/powerpc/xmon/xmon.c
> > > @@ -3662,7 +3662,7 @@ symbol_lookup(void)
> > >  	int type = inchar();
> > >  	unsigned long addr, cpu;
> > >  	void __percpu *ptr = NULL;
> > > -	static char tmp[64];
> > > +	static char tmp[KSYM_NAME_LEN];
> >   
> > I think you could use the existing tmpstr buffer.
> > 
> > It is global so it's a little hard to track down all the users, but I
> > think it's only used briefly in get_function_bounds(),
> > xmon_print_symbol() and scanhex(). ie. none of the uses persist across
> > function calls.
> > 
> > We don't want to have two 512 byte static arrays lying around if we can
> > get by with one.
> > 
> > cheers
> Sure.
For now i don't think so we can get by with only one. There is a lookup being
done when the scanhex is using the tmpstr for another lookup.

I'll send a V2 with commit message change.
> 
> Will send out V2.
> > >  	switch (type) {
> > >  	case 'a':
> > > @@ -3671,7 +3671,7 @@ symbol_lookup(void)
> > >  		termch = 0;
> > >  		break;
> > >  	case 's':
> > > -		getstring(tmp, 64);
> > > +		getstring(tmp, KSYM_NAME_LEN);
> > >  		if (setjmp(bus_error_jmp) == 0) {
> > >  			catch_memory_errors = 1;
> > >  			sync();
> > > @@ -3686,7 +3686,7 @@ symbol_lookup(void)
> > >  		termch = 0;
> > >  		break;
> > >  	case 'p':
> > > -		getstring(tmp, 64);
> > > +		getstring(tmp, KSYM_NAME_LEN);
> > >  		if (setjmp(bus_error_jmp) == 0) {
> > >  			catch_memory_errors = 1;
> > >  			sync();
> > > -- 
> > > 2.47.0
> 

