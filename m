Return-Path: <linux-kernel+bounces-379191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9482C9ADB42
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4895E283A05
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4FE1741C3;
	Thu, 24 Oct 2024 05:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JXdMcrVX"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C361714CA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 05:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729746770; cv=none; b=HZ0xEuUvqvaFYTFVy+g1/C1rDL6jZXfjb+mWDManX8J46vjML4OxJYFlZTDrm1qK4n3MXWoO1hUkhvtZyZ5Qyejj8z/bSbOgZwqWWeqLDTOtMWfXWgrFU6/S/C6CIXGn7w3Y4OFI665Y7BvIRQbSZu9EtM6ps6gfDeOv8BzPqBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729746770; c=relaxed/simple;
	bh=HFMnO8jII8SiRaB/mtxi//F4sTuWYT+ZtczSewdaJ0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lw17rNeU026LkYCoW6Uf6qwz4T9CTyIgfpQeWZCybWnQ5qdfW1sh/iUAR8NMc8qXDNtpQyAgrQOy4wJhR51DDdKNZ5W/98GZwRIaLtHZkOPx0AsevJg8JgM/hGoCp21zadn4aED9uKyRTrY9/0oEAjfkxCECNss3zcbFnK3614Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JXdMcrVX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O0dowS011407;
	Thu, 24 Oct 2024 05:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=TXFrdIm5p9Wa64yKLDT0F/rOY1g3HY
	H3e1sYJFUmAdM=; b=JXdMcrVXFhZDRxOcZMJTimxjatGyOBHlC2IZdccze1GpLe
	q5+cawG8r0oEVkTiUJgf9hPCFB5LgT/L1XdwNJEYm127C3O5wbVPLqbhwkd6zT6n
	UE9LUeDJt9Ki4ILfDX5/viaJvvZsHySnzkL3mZ8ker/Q4sZpUAiFN6Sz/ClF4rF8
	Hk5mbiJoE9ujzappVUgtgKO6R+aRMAPQBaxlLrMAZQKKuCNrywBhuTnb32tbYOlT
	weq4a3DwnASDr3e0kx4UZTqhdo14O+eMLtyLa0UX42DOFvQ5T4rFas0VCjC/DgIN
	3zZG/dbmaZBKGwp/kqOtc9TpQnq9bk6CuHFq4aWQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fbw40srm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 05:12:24 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49O5CNXi027273;
	Thu, 24 Oct 2024 05:12:23 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42fbw40srh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 05:12:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49O2x3AI001557;
	Thu, 24 Oct 2024 05:12:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emk9ep1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 05:12:22 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49O5CJpg53215552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 05:12:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 373C42004B;
	Thu, 24 Oct 2024 05:12:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D9EE2004D;
	Thu, 24 Oct 2024 05:12:17 +0000 (GMT)
Received: from li-e1dea04c-3555-11b2-a85c-f57333552245.ibm.com (unknown [9.109.206.223])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Oct 2024 05:12:17 +0000 (GMT)
Date: Thu, 24 Oct 2024 10:42:12 +0530
From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
        maddy@linux.ibm.com, peterx@redhat.com, groug@kaod.org,
        sshegde@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/xmon: symbol lookup length fixed
Message-ID: <nxdkjwqtd7s3fcxebwod6lrfu7rngrj7fa4kk433hgypha66w5@6ahbuz7o2qmu>
References: <20241023212225.1306609-2-mchauras@linux.ibm.com>
 <878que2u2i.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878que2u2i.fsf@mail.lhotse>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S4k4vbJKJ1uQiIHCG4BnOcFlWjM9nE9x
X-Proofpoint-GUID: orM-ET8bwJOf1MPkLNUECZ6RZVGrJ22t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 malwarescore=0
 mlxlogscore=931 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240034

On Thu, Oct 24, 2024 at 12:00:53PM +1100, Michael Ellerman wrote:
> Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com> writes:
> > Currently xmon cannot lookup symbol beyond 64 characters in some cases.
> 
> Can you mention which commands? It looks like it's "ls" and "lp".
Sure.
> 
> > Fix this by using KSYM_NAME_LEN instead of fixed 64 characters.
> >
> > Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
> > ---
> >  arch/powerpc/xmon/xmon.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> > index e6cddbb2305f..22b8b5cc4df0 100644
> > --- a/arch/powerpc/xmon/xmon.c
> > +++ b/arch/powerpc/xmon/xmon.c
> > @@ -3662,7 +3662,7 @@ symbol_lookup(void)
> >  	int type = inchar();
> >  	unsigned long addr, cpu;
> >  	void __percpu *ptr = NULL;
> > -	static char tmp[64];
> > +	static char tmp[KSYM_NAME_LEN];
>   
> I think you could use the existing tmpstr buffer.
> 
> It is global so it's a little hard to track down all the users, but I
> think it's only used briefly in get_function_bounds(),
> xmon_print_symbol() and scanhex(). ie. none of the uses persist across
> function calls.
> 
> We don't want to have two 512 byte static arrays lying around if we can
> get by with one.
> 
> cheers
Sure.

Will send out V2.
> >  	switch (type) {
> >  	case 'a':
> > @@ -3671,7 +3671,7 @@ symbol_lookup(void)
> >  		termch = 0;
> >  		break;
> >  	case 's':
> > -		getstring(tmp, 64);
> > +		getstring(tmp, KSYM_NAME_LEN);
> >  		if (setjmp(bus_error_jmp) == 0) {
> >  			catch_memory_errors = 1;
> >  			sync();
> > @@ -3686,7 +3686,7 @@ symbol_lookup(void)
> >  		termch = 0;
> >  		break;
> >  	case 'p':
> > -		getstring(tmp, 64);
> > +		getstring(tmp, KSYM_NAME_LEN);
> >  		if (setjmp(bus_error_jmp) == 0) {
> >  			catch_memory_errors = 1;
> >  			sync();
> > -- 
> > 2.47.0

