Return-Path: <linux-kernel+bounces-228031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0215D9159D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20732822BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1051A0B1A;
	Mon, 24 Jun 2024 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="Z6XeTH2v"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B61A0B09;
	Mon, 24 Jun 2024 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267786; cv=none; b=SmRjgPQUoShGGiHlJUeqsko8UMrMXwfrqL6sPVLkcdsEokDIagmx6/+yc7LacbFoY1Y5YeZsDEiTLh7GRFOZh+sc65ttc+jruRcYJBPAerUSiwX+MtTv+WfVO4rJUwyPUiMg2u2kR6Ggl79EYrn98xwP1tDRpoK1s0hal8YbKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267786; c=relaxed/simple;
	bh=fZFHe+bMXVaxyQmVyyZ+gDDb4gSSpHyDCxly4D/b9ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlwkMZRzjkPQmKToZc3kCmMxH6P6RrsU0x8HIYfyl+id5w82ujiZR7lr1GX8Op+too+3pSNzgBwNhnNhoh2WCuxwpD0uzyZ1neXLTKo0+pU9tFs+Zdp6GReT0b420UgxgjLua9Rkuxy008Je2FGCbpImW31EXUNAhhjvluadGiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=Z6XeTH2v; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355085.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ODdgeY005518;
	Mon, 24 Jun 2024 22:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=pBUUwvtnRSkp4rqwILfSpJ2
	gX1Df4NGVmR/X2MtSDl4=; b=Z6XeTH2vPQ67hWnsovPgXtMc+xfchLyIW4dGePp
	Q+18RVK9uXcXVwVFU340GPtH/AmujBZEw4TIqL4QNpXnBVowoIwGjUAM01E96F8Z
	YKdxQyMfjaCjQcTEecTYj8n2+Y63vtYcjgsRsLXUQNk6tnBZS6vO+7IFnhH1E6A+
	NbPfB/6aPYFIzLJ8fLfI4KPsqGr85DVIeIzIUMF+09g8FO52v/6k+XHfJhYS6Jgl
	WHQPCIpfj7uC6UNyeCRtjohiXCLW5zL+aU+boX4fwDKM56+eCtbjnSDC/Anwo00w
	h1zo+/j8I6+aiJON4ymJ1r8FTvUTeNTVYpsNRWv5i7W+73Q==
Received: from ilclpfpp02.lenovo.com ([144.188.128.68])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3yxd4f2xgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:22:48 +0000 (GMT)
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ilclpfpp02.lenovo.com (Postfix) with ESMTPS id 4W7Msg6X7szc3GH;
	Mon, 24 Jun 2024 22:22:47 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4W7Msg3MHXz2VbbV;
	Mon, 24 Jun 2024 22:22:47 +0000 (UTC)
Date: Mon, 24 Jun 2024 17:22:46 -0500
From: Maxwell Bland <mbland@motorola.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] arm64: add attrs and format to ptdump document
Message-ID: <pepilurwqzkqf6jbw4hcnrojwnm7tutmjtwom52ilonf7ydm33@lxqlywiv5qkp>
References: <aw675dhrbplkitj3szjut2vyidsxokogkjj3vi76wl2x4wybtg@5rhk5ca5zpmv>
 <2hhihkaeeyyy3xj22mjdx44zlied2sp4mfewj7y6ffrnakw7cy@3fuds6n7f4ew>
 <b5c1536b-1d8e-4d57-aeda-c5d06a2793bd@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5c1536b-1d8e-4d57-aeda-c5d06a2793bd@infradead.org>
X-Proofpoint-ORIG-GUID: UQaHbq18qHsEHEBuQzcZki-MDdoIe_Eu
X-Proofpoint-GUID: UQaHbq18qHsEHEBuQzcZki-MDdoIe_Eu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_19,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=792 bulkscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240179

On Tue, Jun 18, 2024 at 04:06:57PM GMT, Randy Dunlap wrote:
> On 6/18/24 7:43 AM, Maxwell Bland wrote:
> > +The following attributes are presently supported::
> > +
> > +F		Entry is invalid
> > +USER		Memory is user mapped
> > +ro		Memory is read-only
> > +RW		Memory is read-write
> > +NX		Memory is privileged execute never
> > +x               Memory is privileged executable
> 
> Why lower case x and ro but upper case for the others?
> 
> > +SHD		Memory is shared
> > +AF		Entry accessed flag is set
> > +NG		Entry Not-Global flag is set
> > +CON		Entry contiguous bit is set
> > +UXN		Memory is unprivileged execute never
> > +GP		Memory supports BTI
> 
> Most of the abbreviations make some sense, but not that one (IMHO). ;)

Hi Randy, thanks for the feedback above! I fixed these notes and
polished a few of the other acronyms as a result.

v5 is now here:
https://lore.kernel.org/all/2bcb3htsjhepxdybpw2bwot2jnuezl3p5mnj5rhjwgitlsufe7@xzhkyntridw3/

BRs,
Maxwell

