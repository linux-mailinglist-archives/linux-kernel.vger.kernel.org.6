Return-Path: <linux-kernel+bounces-219643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46DA90D5FC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A2F282AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D47915AD9B;
	Tue, 18 Jun 2024 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="63ok91ig"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AAD1F17B;
	Tue, 18 Jun 2024 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721748; cv=none; b=WISGP0liS75+MJxD2y2PNXVOK8iBaMQ5O4ppgFChvng8S+kNfsjbYSN/8vpx2KtNM+MHPqiRQgE8ilJOQneSAlTepLMAB9Q4PwvNfE1DMYUgc7yJ36uaxsOBpE3VmH5xU8NDegBlGw/ZLsSr1hcYeZO6YUofOldUkz/DsjxYvzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721748; c=relaxed/simple;
	bh=J3QMGBZqzIP+aJelogfRoS0tAFI7qSxgroNsPoMsx+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eym9p77vsXcmUW65teIPGUMTt1QuhAjSaM45CYSHJ21BIaVWVx0uYYj40L9xRu4hFGITeQjnWXNSB6dzPgGgFGGH17Cu7weZS0jLryYU/V3+GgZDLTFfukGEbTBXZpaO7yMH7rqkiCPI2i5l5b/l8getaKaowwz9swdkiFUjhSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=63ok91ig; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355092.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IBkGKC002088;
	Tue, 18 Jun 2024 14:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=ezwWQXmivCwqBRYERK7BZUh
	3xDdPWSaca1WBI9VsK/Q=; b=63ok91igM9aGiEEBMeMzFg5e2fnYqPPTXSMShHM
	8N1gRUJqcMTc+GQqkI4iu5qfSwof0HNHrqzcR6rwua+Ndvq3bV5TEV2D/7yBG7Tq
	9mIDeeyV563EHgBl0TYfuwOwUCFF90/bgx9eVd16kiwuyPHqAzUWz9nOAcv0Yz7f
	riIdLZWRo4rAldszEdiXfM3jTTSJVpdx1xpY4hxM2gQn1aC7RI02rekC6VRRGpe2
	iTTg6jnMaoAWACDhrQ9NAJ6XHGj/l8KWMtRCq+lsNfOO+QwBo9i3+F5YdT3vD2on
	EepZda0hQwKf2NbJsxyo7ks8XT5D8VNn/rMMrb2sPnsdh6Q==
Received: from va32lpfpp02.lenovo.com ([104.232.228.22])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3yss9d6hk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:42:10 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp02.lenovo.com (Postfix) with ESMTPS id 4W3Twy1Qvtz50TkT;
	Tue, 18 Jun 2024 14:42:10 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4W3Twy07LJz3p6jp;
	Tue, 18 Jun 2024 14:42:10 +0000 (UTC)
Date: Tue, 18 Jun 2024 09:42:08 -0500
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
Subject: [PATCH v4 3/5] arm64: indent ptdump by level, aligning attributes
Message-ID: <zyhvjj66drbmqfeccpph3b53fltry4smxoocjr7i5hdtqzkoap@i4xidbzzmb6p>
References: <aw675dhrbplkitj3szjut2vyidsxokogkjj3vi76wl2x4wybtg@5rhk5ca5zpmv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aw675dhrbplkitj3szjut2vyidsxokogkjj3vi76wl2x4wybtg@5rhk5ca5zpmv>
X-Proofpoint-ORIG-GUID: Y_evLIlZBS663m3UA_uhG0DNOEs7VpPu
X-Proofpoint-GUID: Y_evLIlZBS663m3UA_uhG0DNOEs7VpPu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180110

Outputs each level of the page table with two additional spaces for
parsers, distinction, and readability while maintaining the alignment of
region size and attributes.

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
 arch/arm64/mm/ptdump.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 8f0b459c13ed..2ec16b523043 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -336,6 +336,10 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 		   addr >= st->marker[1].start_address) {
 		const char *unit = units;
 		unsigned long delta;
+		unsigned int i;
+
+		for (i = 0; i < st->level; i++)
+			pt_dump_seq_printf(st->seq, "  ");
 
 		if (st->current_prot) {
 			note_prot_uxn(st, addr);
@@ -362,6 +366,10 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 					   st->start_address, addr);
 		}
 
+		/* Align region information regardlesss of level */
+		for (i = st->level; i < 4; i++)
+			pt_dump_seq_printf(st->seq, "  ");
+
 		delta >>= 10;
 		while (!(delta & 1023) && unit[1]) {
 			delta >>= 10;
@@ -369,6 +377,7 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 		}
 		pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
 				   pg_level[st->level].name);
+
 		if (st->current_prot && pg_level[st->level].bits)
 			dump_prot(st, pg_level[st->level].bits,
 				  pg_level[st->level].num);
-- 
2.39.2



