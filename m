Return-Path: <linux-kernel+bounces-228014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F139159B4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6132820FD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8311A0B15;
	Mon, 24 Jun 2024 22:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="6ooSBqzH"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F2619F468;
	Mon, 24 Jun 2024 22:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267325; cv=none; b=sdrwKUyQF/KXgoFPChW/30IKNToXU2GpOIYnoFjTsacJL/APXe2A+geLEgrm5JBupDrgo/yz+gbRD51b5tiTRyn3wrs8uj66ePP5n2mwITe5phvVfccA1UUgxEGbRbj3grwQriHVPPZsdmSPKkr/+r0LiGQOeAOnWb01e8aOLzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267325; c=relaxed/simple;
	bh=NlH90pS7UuOm5hkB0clCXELuVEfJ4ksaSH4ze+jMT4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Efr2fZQvS1HkRTwAMm4hGUBcjIjSswUasNt6zOFz24jl2xapdrMDkveB9dOPK38+rpsGdndZwZo3hqy2A1QxD02n2Y/8dzRtP5SAnVlua2BdoDQiAUideas3A/Kd3i40P3sLN1Vd1IEo5oAYuxMtz4cfEC7V1xKe4FWjpKqnJGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=6ooSBqzH; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355088.ppops.net [127.0.0.1])
	by m0355088.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 45OKhVlf023210;
	Mon, 24 Jun 2024 22:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=Gdo+A9lR32Bwl8rgtzcgwCf
	QAZOYi+4CngAwLwcyHBw=; b=6ooSBqzHdfsXIm3I/BjkKOp8gYuoWZs4Fyhb97i
	668nWAIPp4RLzo2mDzJzaPzXAwXktQvGBd/qw+4P2SYPLP32o3tv8zkybvKkdLkH
	GTN6d84p3ahqd0/wDxHem3s+8QMumwsN0PBd8K+2mBCeHlsBoo/TCFed2mhEjavD
	noS6iFVy2vUC+Kms7MSscXOd4CtBEBnQ8OCU2eoNbPSNKReUbbGuFyr2f6YUe8qZ
	9jVqvTrEWQ6qKmiLKjj9pELujwjw7mYRVQQFtFTrSFA7HZ/qILWZFXoXzVVkkY77
	TLU2LEekm6diH8In2hdb3Bp/JbWxSCWoJSMOrDdzWn3DusA==
Received: from va32lpfpp01.lenovo.com ([104.232.228.21])
	by m0355088.ppops.net (PPS) with ESMTPS id 3yxbstk78d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:15:09 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp01.lenovo.com (Postfix) with ESMTPS id 4W7Mhr3qTGzhWB7;
	Mon, 24 Jun 2024 22:15:08 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4W7Mhr2CBlz3p6jp;
	Mon, 24 Jun 2024 22:15:08 +0000 (UTC)
Date: Mon, 24 Jun 2024 17:15:07 -0500
From: Maxwell Bland <mbland@motorola.com>
To: linux-mm@kvack.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Maxwell Bland <mbland@motorola.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/6] arm64: exclusive upper bound for ptdump entries
Message-ID: <2e6i3jrv7mfd3athc2g4sbv5rirrukj46cnchcym4io5uhle2n@ah3viwbr5bxr>
References: <2bcb3htsjhepxdybpw2bwot2jnuezl3p5mnj5rhjwgitlsufe7@xzhkyntridw3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bcb3htsjhepxdybpw2bwot2jnuezl3p5mnj5rhjwgitlsufe7@xzhkyntridw3>
X-Proofpoint-ORIG-GUID: xJSB6QTklBwCv0gHX8X554KR7Ds_NYcO
X-Proofpoint-GUID: xJSB6QTklBwCv0gHX8X554KR7Ds_NYcO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_19,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015
 mlxlogscore=947 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240178

Update the upper bound of all ptdump entries to not include the byte
which is actually governed by the next entry. As the lowest byte is
included and governed, this makes the size specifications exact.

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
 arch/arm64/mm/ptdump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 0660b74413a2..f13acf9b1cd8 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -320,11 +320,11 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 			else
 				delta = pg_level[st->level].size;
 			pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ",
-					   addr, addr + delta);
+					   addr, addr + delta - 1);
 		} else {
 			delta = (addr - st->start_address);
 			pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ",
-					   st->start_address, addr);
+					   st->start_address, addr - 1);
 		}
 
 		/* Align region information regardlesss of level */
-- 
2.43.0



