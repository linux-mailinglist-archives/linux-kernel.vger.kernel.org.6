Return-Path: <linux-kernel+bounces-219647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C804290D604
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D231F22136
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF31815B96C;
	Tue, 18 Jun 2024 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="wvP/R0rX"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9407315443F;
	Tue, 18 Jun 2024 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721795; cv=none; b=URWikavOOMti3RTtGS/ryrSJPFRA1pJaZZM1CCeQXEHaN40EELV37WRYUb6VJjQYhx2bDIWHYrjtJ6YK/va0S//TwB9KfkPPPURcmQHmBUEIYGqhGIXRw30WXScBFgNfeQT2t1PLEyOHQtFppGc5pOP5h+cKgkk6X7v7H6Rp6cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721795; c=relaxed/simple;
	bh=+A5fEnwsn8wJ0yrjqe3VxaNXE674cwgEAhGpvjluXEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjJKqAc/8wReOg7+0lxVJ6tfxvc7OLOdShsl7na2cBD8+cohyZaaMqlm/eQs8MYq88O2MMSUH9r/77GO5Iz9FVIbaz33CWvTV0a+E96ZlAuKb8ZjdjPeY7LGidJzKcjZrV5+BKG6duAbD8HlyMEwRORyS7PYX1D6/8UTaMvm2b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=wvP/R0rX; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355086.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IDF1Ec018084;
	Tue, 18 Jun 2024 14:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=k7mR/1SYybA1E3VAkvQonOe
	ZDJRDOYjJN4T4w1geSnY=; b=wvP/R0rX9a8dgx5FDpQnFK1jCQK+H4ZG2fYy7Cd
	Mykjl4BJafMvBub/tcH9tDgOBl3/wwmJ49aWM69M0GBjRl/jOoH/GUGHfugjUTHa
	sAUDYiIWPEO7CSJLTwCa1Bk2G4j/u+Kaq6kXToN4Z7esMnB31aUD/TPxXS0FQTqS
	kYQ6YmvXIqXXhA1ae7MxS837nWBAT5/wWkRwt01qulCHG++C5uXn7rsgsxOByr1N
	tik4nW1LhEuKFDr6/VmUaMrjQDRbyLPWLSvMrN05ncPDMwVS1aqV/OwW0NpjUICa
	KQPuBItc6I8fBgAodSNFwdM/L+7iuLA4CKC1gbotYVSxO1w==
Received: from va32lpfpp01.lenovo.com ([104.232.228.21])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3ysrqk6n1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 14:42:58 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp01.lenovo.com (Postfix) with ESMTPS id 4W3Txr6TbMzfBb1;
	Tue, 18 Jun 2024 14:42:56 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4W3Txr5H2Bz3p6jp;
	Tue, 18 Jun 2024 14:42:56 +0000 (UTC)
Date: Tue, 18 Jun 2024 09:42:55 -0500
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
Subject: [PATCH v4 4/5] arm64: exclusive upper bound for ptdump entries
Message-ID: <hb7v5p6y4aqydsecsnla2ystu3kocevngekyhdbn4kuwboetjq@s3uaiuwd73wl>
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
X-Proofpoint-ORIG-GUID: lUW5eH0wfVUKzgqnNwLox3eS303p6jMG
X-Proofpoint-GUID: lUW5eH0wfVUKzgqnNwLox3eS303p6jMG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 spamscore=0 mlxlogscore=941 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180110

Update the upper bound of all ptdump entries to not include the byte
which is actually governed by the next entry. As the lowest byte is
included and governed, this makes the size specifications exact.

Signed-off-by: Maxwell Bland <mbland@motorola.com>
---
 arch/arm64/mm/ptdump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 2ec16b523043..63f17c08c406 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -359,11 +359,11 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
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
2.39.2



