Return-Path: <linux-kernel+bounces-246546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9C992C358
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83C71F24134
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE5D180046;
	Tue,  9 Jul 2024 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="MzRPetDr"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E0E1B86D8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720550229; cv=none; b=UbQTV0PILCg3vA5j6d8uCww+Iv+Y3fdNhnKfNZMpGHggyxrsDdnxuIEQ9c3M3/QvyJ0BzMmnUHqwPRTvbyMbqinRnADOMrS+FqY9q/7AP9rj6BDBWXeyvxGuZFVOUqCyXyZz0kSumlz9cYolBwnLR7IJZVdTtKl8y6OKcElhBs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720550229; c=relaxed/simple;
	bh=PKu3+1feBtqguibN2HU/GNOpO3G17sWxcaCB3calbdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxceCgkZOdcm+HDt3gkhi8k7BLZ5ThGj/fI+KlJdy7i4klA/d+xh5t2TmmgSCqucadfd7gNBp8WQ9KNC/hN19cPm1qPuF0R3+jDds7FpHduwv1tJzKxBMXnPTqyko17UCy4wXXyydqMfkXtMH+8//hnjU1NH2ZdatnF4Y0K4Jd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=MzRPetDr; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469BH2qN020520;
	Tue, 9 Jul 2024 18:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pps0720; bh=KyUSMfzFydxOVmvFJMdy2wP
	Hcfhb8oQUAOvK06S0J04=; b=MzRPetDrMpduVDE7/C/uDLNHX+6LMxFUa+5Dnqo
	WrL/z2umMUDTJfd9CCFTd4Yl+K7zOo7Qea+aCdx/eKek3rA2t10M35F08bd+vTp4
	ZU97bnrAb1W44cSNTGgku0oqCWjyoKQKh7rxlLYcjdVaC1yeofHtGPH+FT10ytza
	JYzl/DOE45Z5M44dhPcpJeyN2+5TK1sDmOXfsDG56KP6hEKAtodTyJGTRSZ3XLgM
	FOB1tZjOOiYuRDKykV4jvX4Tcc26n9gh4S+jducTqT7C2HLnXQ9vfYvxAbBWZ2LG
	SoR0pQSvrcQuFrZh7D184FO4O18K9OvkZ1v9GrvNVopwnHQ==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 40946skp9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 18:36:09 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 54CED80025D;
	Tue,  9 Jul 2024 18:36:07 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id DF6FA805766;
	Tue,  9 Jul 2024 18:36:02 +0000 (UTC)
Date: Tue, 9 Jul 2024 13:36:00 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Steve Wahl <steve.wahl@hpe.com>, Ard Biesheuvel <ardb@kernel.org>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Pavin Joseph <me@pavinjoseph.com>,
        Eric Hagberg <ehagberg@gmail.com>, Simon Horman <horms@verge.net.au>,
        Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>,
        Sarah Brofeldt <srhb@dbc.dk>, Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 0/3] Resolve problems with kexec identity mapping
Message-ID: <Zo2DEOKcEyZNyGkV@swahl-home.5wahls.com>
References: <20240708195810.GKZoxE0pRWHEUljjnQ@fat_crate.local>
 <ZoxOt1_w7nblRQCv@swahl-home.5wahls.com>
 <CAMj1kXGA8zG95WutMgVgeb-M7oQKJrVO6QWNzLi1GMuj1wq=bg@mail.gmail.com>
 <ZoxX9mckeu046zed@swahl-home.5wahls.com>
 <CAMj1kXE5OYTxxBEO38dRyYt_J1FNpU-tdkaU8rxvrMLd_k_beg@mail.gmail.com>
 <20240709103742.GCZo0S9md7YyeevRN-@fat_crate.local>
 <Zo1SRIZEhveMwSPX@swahl-home.5wahls.com>
 <20240709164620.GLZo1pXPiG42JH4ylN@fat_crate.local>
 <Zo1rugBl5WWy-1LJ@swahl-home.5wahls.com>
 <20240709175819.GNZo16OxP7VuZLTKFx@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709175819.GNZo16OxP7VuZLTKFx@fat_crate.local>
X-Proofpoint-ORIG-GUID: Ph4LgLFSEpNa9vaSX03RxXK41aeGSawa
X-Proofpoint-GUID: Ph4LgLFSEpNa9vaSX03RxXK41aeGSawa
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_07,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=508 lowpriorityscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090125

On Tue, Jul 09, 2024 at 07:58:19PM +0200, Borislav Petkov wrote:
> On Tue, Jul 09, 2024 at 11:56:26AM -0500, Steve Wahl wrote:
> > I will add it.
> 
> No, don't add it. This needs to be tested properly first. I'll do a separate
> patch.

OK!

--> Steve
-- 
Steve Wahl, Hewlett Packard Enterprise

