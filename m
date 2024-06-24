Return-Path: <linux-kernel+bounces-228034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA309159DA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093E31F22747
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4181A0B10;
	Mon, 24 Jun 2024 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="wwK9pOYH"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF7173454;
	Mon, 24 Jun 2024 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719268052; cv=none; b=geFbLlZBIhzlh/GulxOFNVxk/PhAZ/JDUl73hKrCCg3jh1TRuja3xR3HVXwuH/7YVsKonB2gXVzPi0w3y7BUt8KaYCeTelruvUZxBlLoq5mT/0nIyfk/ocxve8zO0mG9BwcTmDbYZkGhuYWkomsSGX87sG7j6wXTZ2SjTKR4wp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719268052; c=relaxed/simple;
	bh=j7goHGjZKVe73OSyMsc7txoKfGOGn2nTdzJxZAzZgE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/RZloer851HESMfgGyDk5g9QeChJI0etn1EhUo0+WisDJsLlHAzVxBdSPRyl7kAQZySRdy+Sv4skZj30Alk0zXNKynudDr2kGGgWQwuKkEKLp+YWESNEX1E6TrSx2snXdDK/+y+BjFDRJl896oCSrK4SL6DHMwN6ldcE9ceYoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=wwK9pOYH; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355092.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OELofV002073;
	Mon, 24 Jun 2024 22:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM202306;
	 bh=d5t/WYdlZUdpqHUm+d2a24lfJllUapqToqbJhQmx1NQ=; b=wwK9pOYHwOVd
	ID2yhhEnolMtC4NR652Am7pTWdwAocx2j58F02W+AEAGSd3+FKH4eEpSpNLqra7I
	R49KqrwTGzUMRbDfnMB8evVQCIMveOJGl1v1UXXsFiRHNHS710QLjk3ASUFH/mOp
	O/Q+s/I+I076D/bxMizlJNJ8PkjMLyDAN2iZGFMcegXC8Q2Rubz3fcSkVFZXCz6N
	aK4+dpL98geDetZcDzbVmLARXEiUW6vt10DVXGttDEzYv8lKLbGra1B+cOdYmegd
	SpMqPwKZxcLIZab3dAx5dQvlTHF2b1bSTwz5FKNuPwWcV9UYghLCKGba+fCNub8m
	Mdg9zJ7ceA==
Received: from ilclpfpp01.lenovo.com ([144.188.128.67])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3yxcxf2vym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:27:17 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ilclpfpp01.lenovo.com (Postfix) with ESMTPS id 4W7Myn3rSHzfBZq;
	Mon, 24 Jun 2024 22:27:13 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4W7Myn3HPLz3p6jp;
	Mon, 24 Jun 2024 22:27:13 +0000 (UTC)
Date: Mon, 24 Jun 2024 17:27:12 -0500
From: Maxwell Bland <mbland@motorola.com>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] mm: add ARCH_SUPPORTS_NON_LEAF_PTDUMP
Message-ID: <omqeaa2zv62avwaq7lg53siikp2aheonf3wc3anotmnh2hytx5@bdonyrfokmmx>
References: <aw675dhrbplkitj3szjut2vyidsxokogkjj3vi76wl2x4wybtg@5rhk5ca5zpmv>
 <fgvecau2k64sfzvxbs2yxrhzimseogdt2qk4izboywnrtco4od@ezdoxozrt2yj>
 <194624e9-125e-40aa-b8dc-08895489150e@cs-soprasteria.com>
 <5b5bumqhap3v6tjigekm6cdiv5vjzlk5dhpdwu5so5pk4dz7bd@zeka4bsylxzr>
 <09d8eb0c-bbdd-48a1-bbd6-b80c9b6cf576@cs-soprasteria.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09d8eb0c-bbdd-48a1-bbd6-b80c9b6cf576@cs-soprasteria.com>
X-Proofpoint-GUID: 4Is40vClwl2pVTjA8EdsCH-9YO-ni2PF
X-Proofpoint-ORIG-GUID: 4Is40vClwl2pVTjA8EdsCH-9YO-ni2PF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_19,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=901
 impostorscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240179

On Wed, Jun 19, 2024 at 08:44:21AM GMT, LEROY Christophe wrote:
> Le 18/06/2024 à 21:41, Maxwell Bland a écrit :
> > On Tue, Jun 18, 2024 at 06:38:24PM GMT, LEROY Christophe wrote:
> >> Le 18/06/2024 à 16:40, Maxwell Bland a écrit :
> >> Don't you mean pmd_leaf() here instead of pgd_leaf() ?
> > thank you for catching these, will fix in v5.
> 
> Maybe we could have a nicer code with something like:
> 
> static inline bool has_non_leaf_ptdump()
> {
> 	return IS_ENABLED(CONFIG_ARCH_SUPPORTS_NON_LEAF_PTDUMP);
> }
> 
> static int ptdump_p4d_entry(...)
> {
> 	...
> 	if (has_non_leaf_ptdump() || pgd_leaf(val))
> 		...
> }

Hi Christophe, nice, thank you! I incorporated this critique as well.

Forward pointer to v5:
https://lore.kernel.org/all/2bcb3htsjhepxdybpw2bwot2jnuezl3p5mnj5rhjwgitlsufe7@xzhkyntridw3/#t

Maxwell 

