Return-Path: <linux-kernel+bounces-227208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99572914A47
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233AB1F244D2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81A313C691;
	Mon, 24 Jun 2024 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ce2ghYeE"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1230513C677
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719232660; cv=none; b=TU0nxo+ytwxappldEBgwAg/EZrjryDnERQl/rB962TaikzX2FM85/O/qwj56ZfAsUFGM4myVTDsT+x5hY1q+nE0AurxCrr+i5/uKOvq8vOLnzMnEpW25iQUYQOAOdm3TchGvIFCpOpRwFvY7uXokHXQ/wD7F8ZghCj7XHAwOTjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719232660; c=relaxed/simple;
	bh=AGLh0mCZVAHIVQnbT+2CMSPmBmKwQS7W7bGUoC892PU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=AHPbx9US4+VwpzT2uKC1qkZpDxWEpkNdzmM8Ca7vQr4Xw3yXTslOJWKLQuNokLToLAoJHGS6RcXupWpZUsWVOzPa3TYMHwy4j2uKN83pgUVSOeknn6OCdrwDCJMn9UbpBufWaaQJM0NQNudazdGTarRN5EXYeA8Rhj0Zj2JVnxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ce2ghYeE; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240624123729epoutp03af0742d6da9442a1e72e100def10c2eb~b8Pxedxqf1868618686epoutp030
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:37:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240624123729epoutp03af0742d6da9442a1e72e100def10c2eb~b8Pxedxqf1868618686epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719232649;
	bh=ri7wdu64gSWYmP2l89d/GFh4T9WZnY3idv8cAGVv6/I=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=ce2ghYeExJS9z/AvOKVx7zSUzDbr/Z8ROfIoOlWI84nemBXJzNP+lvcNaCx+gvY5r
	 dUn2DTOmd/nCF80B8H5MWqXVEl1+BKxs73oYYaGQXTFldNstHS2NVvbQyIXEz5/wyi
	 oXwo6uGV9s4ebZu0RvI9xMo1v5HvNVU+LHxTQlw4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240624123728epcas1p4f721181189790142d45374b875016fee~b8Pw8ZC5G1634916349epcas1p4F;
	Mon, 24 Jun 2024 12:37:28 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.226]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4W76tJ5p3Nz4x9Ps; Mon, 24 Jun
	2024 12:37:28 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	05.13.09561.88869766; Mon, 24 Jun 2024 21:37:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240624123727epcas1p494dc14631fd4d2ebeb52c704bda0dd91~b8PvuCuKx1448014480epcas1p4O;
	Mon, 24 Jun 2024 12:37:27 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240624123727epsmtrp241f45d9592bea2119c433d00263f0465~b8PvtVWiA1055610556epsmtrp2e;
	Mon, 24 Jun 2024 12:37:27 +0000 (GMT)
X-AuditID: b6c32a39-b63ff70000002559-c1-667968886a22
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D2.84.19057.78869766; Mon, 24 Jun 2024 21:37:27 +0900 (KST)
Received: from sgsupark03 (unknown [10.246.147.33]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240624123727epsmtip21e87ac65599fad2d5398f3ed7db78a51~b8Pvdd60B2005420054epsmtip2M;
	Mon, 24 Jun 2024 12:37:27 +0000 (GMT)
From: "Seongsu Park" <sgsu.park@samsung.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <ardb@kernel.org>,
	<mark.rutland@arm.com>
Cc: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<infinite.run@gmail.com>, <'sgsu.park@samsung.com'>
In-Reply-To: 
Subject: RE: [PATCH] arm64: Cleanup __cpu_set_tcr_t0sz()
Date: Mon, 24 Jun 2024 21:37:27 +0900
Message-ID: <000001dac633$45940050$d0bc00f0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH8m0kGjlO3sBEuOPUVgIk9EwDJ9wFU9gUNsWdr81CAIRsxIA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMJsWRmVeSWpSXmKPExsWy7bCmvm5HRmWawZOFuhY/v7xntHi/rIfR
	4s/G3UwWmx5fY7W4vGsOm8XS6xeZLFrumDqwe6yZt4bRY+esu+wem1Z1snlsXlLv8XmTXABr
	VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtARSgpl
	iTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCswK94sTc4tK8dL281BIrQwMDI1OgwoTs
	jMf3DQquiFRMu/WCrYGxV7CLkZNDQsBEYvPydexdjFwcQgI7GCVunXjMDOF8YpQ42fSKEcL5
	xihx5fNvNpiWv8+uQlXtZZQ4feoYE4TzglHi18KlTCBVbAI6Et++TWEBsUUEYiWunp3CBlLE
	LNDIKDHhxnagjRwcnAK8EhP+WYPUCAtYSByb9wdsA4uAqsSMzqdgc3gFLCVmN2xgh7AFJU7O
	fAI2k1lAXmL72znMEBcpSPx8uowVYpeTxPUPN9kgakQkZne2gV0qITCRQ2LL+qtMEA0uEi8X
	XWGEsIUlXh3fwg5hS0l8frcX6s1iiX1f1kAtqJF4MG8PlG0v0fGsjQXkfmYBTYn1u/QhdvFJ
	vPvawwoSlgB6q6NNCMJUlji31RHClJT4s0APYoaHxJb/J1knMCrOQvLXLCR/zUJy/yyEVQsY
	WVYxiqUWFOempxYbFpjCozo5P3cTIzh1alnuYJz+9oPeIUYmDsZDjBIczEoivNPry9KEeFMS
	K6tSi/Lji0pzUosPMZoCQ3ois5Rocj4weeeVxBuaWBqYmBmZWBhbGpspifOeuVKWKiSQnliS
	mp2aWpBaBNPHxMEp1cCkfWXuwpm6TQ/rg7a4rxd3Nk+09Fye43Nrjml66zStL0qZ/gkxW02U
	UqQa0jzmW6StztvvtSStrfyz3eLDG0MnM5d+l7lkZLSnRsR8gqzsm/dZF+JOCVxn4d1infp6
	9Wr2AvZc1fj5tWttP5qqmfGv+c3oqq75z7u79sXUsDuPzQSsc4MzrMwPzHj1QPAWo5VMSveL
	Pw+nBUv77vXitGror7X9aiS15+mhniMef2KUuWUvnUnv2GrReOTckYUpXNmMJglKPHpv5Jrj
	LqXvftvvLXx66c2EjbP3vU+6w/4r5M9yLQePXbN2furxa4juPKO8w/rM5RsZb7T3+rSeqd2e
	XGS+1XGW0uHT/b6G2kosxRmJhlrMRcWJAH6vXtUmBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LZdlhJXrc9ozLN4NtsKYufX94zWrxf1sNo
	8WfjbiaLTY+vsVpc3jWHzWLp9YtMFi13TB3YPdbMW8PosXPWXXaPTas62Tw2L6n3+LxJLoA1
	issmJTUnsyy1SN8ugSvj8X2DgisiFdNuvWBrYOwV7GLk5JAQMJH4++wqcxcjF4eQwG5GiY1N
	q1kgEpIS7e8uA9kcQLawxOHDxRA1zxglnq78BVbDJqAj8e3bFDBbRCBR4sTVvWCDmAVaGSW+
	9XyAmtrHKPHp9A42kEmcArwSE/5ZgzQIC1hIHJv3hw3EZhFQlZjR+ZQJxOYVsJSY3bCBHcIW
	lDg58wnYAmYBbYmnN59C2fIS29/OYYY4VEHi59NlrBBHOElc/3CTDaJGRGJ2ZxvzBEbhWUhG
	zUIyahaSUbOQtCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcSVpaOxj3rPqg
	d4iRiYPxEKMEB7OSCO/0+rI0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzfXvemCAmkJ5akZqem
	FqQWwWSZODilGphSErMPlzHezKu9e2LbceFPFpeLZq74uH5Nd7ub8vbYC4+vzeAuDNM/wf9v
	yyqtFc06x+y72NQ/tKtqeQUKX12437W0TtvD5ZHqdaPiHq+WUPuVnavZ5F4y9On7Xiryvs+f
	IVv9aeGyVRnT/xwq7o584dO0MunjkbDqKZttxRc9cVOZyvJ13e+Z05gXxcyxnTVRVunihwPR
	Tc+Wv/vaJcRml1Vz/8w6JZ6Ya/9fPTVg1k/QPrmwfk0pb+wpvq418SsSDJhesn/7vmPJw7Pn
	J66ZfcZZ3F923olIDSee21tqPjz6ciQ2a8P8NZ/NbJ9cuJXN71q5Tcdk8Ty5ZyrhD3oXv439
	PEfLKPVSjuSJKbPVlViKMxINtZiLihMBmn8qTBMDAAA=
X-CMS-MailID: 20240624123727epcas1p494dc14631fd4d2ebeb52c704bda0dd91
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240523122152epcas1p49d579e40d4ef0c442820cc01f79ab38b
References: <CGME20240523122152epcas1p49d579e40d4ef0c442820cc01f79ab38b@epcas1p4.samsung.com>
	<20240523122146.144483-1-sgsu.park@samsung.com> 

Dear Will,

Could you check this patch?
This patch will make the code more stable.

Thanks.
Seongsu Park.

> -----Original Message-----
> From: Seongsu Park <sgsu.park@samsung.com>
> Sent: Monday, June 3, 2024 8:03 PM
> To: 'catalin.marinas@arm.com' <catalin.marinas@arm.com>; 'will@kernel.org'
> <will@kernel.org>; 'ardb@kernel.org' <ardb@kernel.org>;
> 'mark.rutland@arm.com' <mark.rutland@arm.com>
> Cc: 'linux-arm-kernel@lists.infradead.org' <linux-arm-
> kernel@lists.infradead.org>; 'linux-kernel@vger.kernel.org' <linux-
> kernel@vger.kernel.org>; 'infinite.run@gmail.com' <infinite.run@gmail.com>;
> 'sgsu.park@samsung.com' <sgsu.park@samsung.com>
> Subject: RE: [PATCH] arm64: Cleanup __cpu_set_tcr_t0sz()
> 
> Dear All,
> 
> Please check this patch.
> I think this patch is appropriate.
> 
> Thanks.
> Seongsu Park.
> 
> > -----Original Message-----
> > From: Seongsu Park <sgsu.park@samsung.com>
> > Sent: Thursday, May 23, 2024 9:22 PM
> > To: catalin.marinas@arm.com; will@kernel.org; ardb@kernel.org;
> > mark.rutland@arm.com
> > Cc: linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; infinite.run@gmail.com;
> > sgsu.park@samsung.com
> > Subject: [PATCH] arm64: Cleanup __cpu_set_tcr_t0sz()
> >
> > The T0SZ field of TCR_EL1 occupies bits 0-5 of the register and encode
> > the virtual address space translated by TTBR0_EL1. When updating the
> > field, for example because we are switching to/from the idmap
> > page-table,
> > __cpu_set_tcr_t0sz() erroneously treats its 't0sz' argument as
> > unshifted, resulting in harmless but confusing double shifts by 0 in the
> code.
> >
> > Co-developed-by: Leem ChaeHoon <infinite.run@gmail.com>
> > Signed-off-by: Leem ChaeHoon <infinite.run@gmail.com>
> > Signed-off-by: Seongsu Park <sgsu.park@samsung.com>
> > ---
> >  arch/arm64/include/asm/mmu_context.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/mmu_context.h
> > b/arch/arm64/include/asm/mmu_context.h
> > index c768d16b81a4..bd19f4c758b7 100644
> > --- a/arch/arm64/include/asm/mmu_context.h
> > +++ b/arch/arm64/include/asm/mmu_context.h
> > @@ -72,11 +72,11 @@ static inline void __cpu_set_tcr_t0sz(unsigned
> > long
> > t0sz)  {
> >  	unsigned long tcr = read_sysreg(tcr_el1);
> >
> > -	if ((tcr & TCR_T0SZ_MASK) >> TCR_T0SZ_OFFSET == t0sz)
> > +	if ((tcr & TCR_T0SZ_MASK) == t0sz)
> >  		return;
> >
> >  	tcr &= ~TCR_T0SZ_MASK;
> > -	tcr |= t0sz << TCR_T0SZ_OFFSET;
> > +	tcr |= t0sz;
> >  	write_sysreg(tcr, tcr_el1);
> >  	isb();
> >  }
> > --
> > 2.34.1



