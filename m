Return-Path: <linux-kernel+bounces-253108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2073C931C86
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C743A1F224D6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9272C13C9A2;
	Mon, 15 Jul 2024 21:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="aVVAMbjT"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3231804F;
	Mon, 15 Jul 2024 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721078703; cv=none; b=VM/R780TAnhqrTrGMo5kDaW9hrdY074voaP565mSPKAb/YWKsANRWcXmZM678LU269Z1XHr/esdiKgm9bfniltRVSVx+ElkSV/7qN5Rnlxiiz4ngRECXeTw5xf9ZAPRiGLE7G40HIoCWMscTKmf/hyfDT26mDR26cQDrBZEQPV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721078703; c=relaxed/simple;
	bh=EOR6hLpb2QL0HN/C/iiaOi7zohEItObVsEXC/2N1c/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNT2QEO3TRTjfvXM7qoHdARIaXDJ9v2CQWliUzEOdtQiPt+TUDDaXx520P4IG8J/RH6XVkcU1Xh0zAK6cs2DavRQzFfGJDg34TEjpYUgIul1qBwnIVWGbNnP607yNc0pYMaUkeoMRhStWlX20Oi63o9so0ACNf/27+sX8cqmNeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=aVVAMbjT; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355088.ppops.net [127.0.0.1])
	by m0355088.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 46FJCCRi020132;
	Mon, 15 Jul 2024 21:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=BjZA6cqy2VyDO6Dw9aWlEv2
	X8FH5oILJsXW/xzu0lXA=; b=aVVAMbjTlYzZiDF044tztmfGh60RuiitddUwRXH
	bvsb4ZFu3HiZRKRpYRw1fhR/ZVEskDPvx0JmPXAgI0fiyTGF0lPIm+EaS/+iAuHw
	SvYbBBzSqZpuGJ6Tb0a7WPkAhF2mISBMItic3KpGNxxDiT8Xrzm727cS4XOG8QCc
	uBAkKT+M3DJNyYJF+lj859upgPCaQbkgimV17bF4Max5q5PZOpEFeC5jP3Y9TXa9
	Lr67ptiICvTYzeixY0pwN4UFvrzPJUFR2Ov/5KeZkDE7AitQrJKdTN2aZyS3AWiS
	8Pu+raFmacmd4CSET2suMXJ/CTPr1ONyQjp0ZIidq4aZNTg==
Received: from va32lpfpp01.lenovo.com ([104.232.228.21])
	by m0355088.ppops.net (PPS) with ESMTPS id 40c6rt313e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 21:24:28 +0000 (GMT)
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp01.lenovo.com (Postfix) with ESMTPS id 4WNFZg5VHXzfBb1;
	Mon, 15 Jul 2024 21:24:27 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4WNFZg3Gbfz2XqJt;
	Mon, 15 Jul 2024 21:24:27 +0000 (UTC)
Date: Mon, 15 Jul 2024 16:24:26 -0500
From: Maxwell Bland <mbland@motorola.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Maxwell Bland <mbland@motorola.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH v5 1/6] mm: add ARCH_SUPPORTS_NON_LEAF_PTDUMP
Message-ID: <z5rp6yyr6ofr7fgiyt2nxwqszls4otirx6eohq6d3qozxtujzq@72talp4b36tc>
References: <yrgrhwfbl7rnmgekiolmojutaqf24x5zphyrwijakzma5pjhre@3yncjv5tqvar>
 <202407051002.96bf438-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407051002.96bf438-oliver.sang@intel.com>
X-Proofpoint-ORIG-GUID: zDZ_79cIOTAZBVzo0qy3rebeIdidkjtE
X-Proofpoint-GUID: zDZ_79cIOTAZBVzo0qy3rebeIdidkjtE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_15,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 clxscore=1011 adultscore=0 mlxlogscore=960
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150167

On Fri, Jul 05, 2024 at 10:52:26AM GMT, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:at_arch/x86/mm/dump_pagetables.c:#note_page" on:
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240705/202407051002.96bf438-oliver.sang@intel.com
> 

Note this config has CONFIG_ARCH_SUPPORTS_NON_LEAF_PTDUMP=y, added by
this patchset, but x86 does not yet support non-leaf ptdump semantics.

x86 support is on my TODOs, but I am caught up in other work (a LSM
and/or *.ko preventing dynamically-allocated datastructure write
gadgets! (-: ).

Regards,
Maxwell Bland

