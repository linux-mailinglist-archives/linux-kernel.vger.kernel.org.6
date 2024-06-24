Return-Path: <linux-kernel+bounces-228013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461659159B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE46F2830EC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDFE1A2C1E;
	Mon, 24 Jun 2024 22:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="qLG2XGve"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41031A0B10;
	Mon, 24 Jun 2024 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267275; cv=none; b=hwhZpmFaSmlhrkbrj9FYw3P2k60HS6Jezece9JJmQ4mtgTWo/GMIlOAOn947/dxZdu1TIUTbK6RNdt7eNzjJOQelgb+Aa2w/IXljZvP6StzbJDUvbiCBFqJpyVgoN6uSvcIe2/QY7XKogj+/4X7Zd4DI7ini6IOrsz9h8EzSvv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267275; c=relaxed/simple;
	bh=ErJbRlyX7bQ5VYWHXatO0nKSqLRtJZWlTtxijuUVqv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLt/UUccKN1ik7obfM8F91l9KG9xCZbPboLLx4IZgfiOlRuI6qeBQMPiCi4HZ8ztfnhMVVR6+Hao9RkClXoYCh2P491TSvRA1dSUVMWIJEREkR4JPHIvpkHFHFGIpFDw6k8tA6n9ssKgCVQKJcd3dnqCIIAUR9X+Y+CikbAEtPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=qLG2XGve; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355089.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OECFp0020826;
	Mon, 24 Jun 2024 22:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=UiwKK45/t5jj3tMLvalGcwh
	elM3iqP5MoGXJmfeqrwA=; b=qLG2XGve7gX0Q3i8oHiLN/RdaUHDml4sGRQ9Pd+
	uuEz12ZcyubhrXAe5Yy3dBsKslQCBLoAXxVlqe+HDHGZLhjUlbxsx2MkLdKmFU0+
	iTsh91+URFRoH/t0zR+u+9uA0UCgoQp3WXWBpXIOTb60NZ/7a5wH0XkucSrG0bFY
	1ceIaFh7WW3+/oxqqIO8gZ2wtHNMW+1/fxkov+npU2wTIgo8HYLa4ERxIXrHZAXC
	fNzp8AyK7wxFdkKEaDOcsGTmQhQJzu8JcuMbg6rIDDTLB9eDc2V+jwKiu+pawPkU
	ccint8utNf0RVlNLeQ5ZTOjQfSWzsRStuKUzwB3843wG8Hw==
Received: from va32lpfpp03.lenovo.com ([104.232.228.23])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3yxb5m309d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 22:14:19 +0000 (GMT)
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp03.lenovo.com (Postfix) with ESMTPS id 4W7Mgv1ymdz4ygtQ;
	Mon, 24 Jun 2024 22:14:19 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4W7Mgv070Zz2VbbV;
	Mon, 24 Jun 2024 22:14:19 +0000 (UTC)
Date: Mon, 24 Jun 2024 17:14:17 -0500
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
Subject: [PATCH v5 4/6] arm64: indent ptdump by level, aligning attributes
Message-ID: <ljxg7ngvwq7xahdwkwwxczbnzec26xf2bqd7tmacmjaqaelgg7@jwh467j73dfa>
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
X-Proofpoint-GUID: 6hlKYHvbG4vu8qcSLMuNk0BF1XTe_Bhy
X-Proofpoint-ORIG-GUID: 6hlKYHvbG4vu8qcSLMuNk0BF1XTe_Bhy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_19,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240177

Outputs each level of the page table with two additional spaces for
parsers, distinction, and readability while maintaining the alignment of
region size and attributes.

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
 arch/arm64/mm/ptdump.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 33ca6d182a6a..0660b74413a2 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -303,6 +303,10 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 		   addr >= st->marker[1].start_address) {
 		const char *unit = units;
 		unsigned long delta;
+		unsigned int i;
+
+		for (i = 0; i < st->level; i++)
+			pt_dump_seq_printf(st->seq, "  ");
 
 		if (st->current_prot) {
 			note_prot_uxn(st, addr);
@@ -323,6 +327,10 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 					   st->start_address, addr);
 		}
 
+		/* Align region information regardlesss of level */
+		for (i = st->level; i < 4; i++)
+			pt_dump_seq_printf(st->seq, "  ");
+
 		delta >>= 10;
 		while (!(delta & 1023) && unit[1]) {
 			delta >>= 10;
-- 
2.43.0



