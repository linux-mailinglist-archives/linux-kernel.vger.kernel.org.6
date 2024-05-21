Return-Path: <linux-kernel+bounces-184375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6DF8CA63F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 451D3B209A9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C532B15EA2;
	Tue, 21 May 2024 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eu3E5L/p"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B67328FC
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716259215; cv=none; b=XmceUfP7SBU4T7nXHs0Qc+WXvp0JdBRnNdinupa/Ls6caPV582tyhgI4ozlJjAw2pNZ7m+DpmmzW2HZko8EP8fJE7vmU8sTBcBeKXtFkCNE1YAamoDyIpiBVRdUEclsFILV/ANXN/ZeF3X2Tors0MokNSkdHDomu3I6sBMwT6lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716259215; c=relaxed/simple;
	bh=3I0pm9Aq+njPFkMmSW9yxbAlSDk67bKnbUVb2bNyrHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=HThCHynwP8VlvKBo2+O3PARyaJpEeOrncj+UVA3IokZ2JrWaPeXJwPPu0KXdulUPQFE+YxSdRflkBSD+N8HM99tBINSrJRGE0RdgfQZ5bD/OXYLca7dPiFC0qRdyGOQVGXkztBmorUaCKzeXFmzlTRgWXM+wHwu0SbOGVhNct34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eu3E5L/p; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240521024010epoutp022440400aa2a231a12ef83a8ade6889bd~RYKigRqo30461604616epoutp02C
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:40:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240521024010epoutp022440400aa2a231a12ef83a8ade6889bd~RYKigRqo30461604616epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716259210;
	bh=zEBuyZNhF/CL5lPcNah+oRHllxv4MjfsSuOU5w+v1uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eu3E5L/pUZoUnW3GZHjjN+T4eiYopRIR47Dc2o2Tc38FgW+ULbYlL8zoZt6D14DiD
	 ixQU3fgmJcYFOzyU8kUKleXa8ZPICIXBDMBLq8fHLrhJE4LRN5CQhvIiJ03umcSfvg
	 l5GQOBJ19AK1N9Mt4RmYFd4oCRSNLF+BPD2TWtnA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240521024009epcas1p28bd3d0438a305494443a92e585d320ba~RYKiHHtqm0671506715epcas1p21;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.225]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VjzDn4FC1z4x9QJ; Tue, 21 May
	2024 02:40:09 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	8A.40.09663.9890C466; Tue, 21 May 2024 11:40:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240521024009epcas1p3440f857e3b31b319c270e2d658379383~RYKhd4Ike1250112501epcas1p3y;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240521024009epsmtrp19f0c8de878deda13b3a4e6889ec4b12f~RYKhdLe4_2362723627epsmtrp1I;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
X-AuditID: b6c32a37-557fa700000025bf-5d-664c09893051
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0A.54.08390.9890C466; Tue, 21 May 2024 11:40:09 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.104.99]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240521024009epsmtip2409720cc711bae36955b9fba12d29dc8~RYKhSinmk1232612326epsmtip2G;
	Tue, 21 May 2024 02:40:09 +0000 (GMT)
From: Jaewon Kim <jaewon31.kim@samsung.com>
To: rppt@kernel.org, vbabka@suse.cz, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [RESEND PATCH 04/10] memblock: take a region intersecting an
 unknown region
Date: Tue, 21 May 2024 11:39:51 +0900
Message-Id: <20240521023957.2587005-5-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdljTQLeT0yfN4PJ6RYs569ewWXRvnslo
	0fv+FZPF5V1z2CzurfnPanFk/XYmi9mNfYwO7B47Z91l99i0qpPNY9OnSeweJ2b8ZvHo27KK
	0ePMgiPsHp83yQWwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
	ufgE6Lpl5gAdpKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCvQK07MLS7NS9fL
	Sy2xMjQwMDIFKkzIzmg79JSp4KpQxc2Tf9gaGPfzdTFycEgImEjcW+7bxcjFISSwg1Gi98ts
	dgjnE6PE4zsTgRxOIOcbo8Syfc4gNkjD1CePmSHiexkljh1JgrA/M0rM7U0GsdkEtCXeL5jE
	CmKLCNhJfJt9AMxmFiiVePvmBFivsECYxLxHX8HiLAKqEmeOTgazeQXsJQ4dfM4CsUteYual
	72A3cAo4SMyfspgdokZQ4uTMJywQM+UlmrfOZgY5WkLgJ7vE3J/fmCGaXSTeXjzBBGELS7w6
	voUdwpaSeNnfBmXnS1y4+IoJEhI1EgsnGkKE7SV2fZ3BChJmFtCUWL9LH2IVn8S7rz2sENW8
	Eh1tQhDVahItzyA+kRCQkfj77xlUiYfEkskxkNCczCix4vYR9gmM8rOQPDALyQOzEJYtYGRe
	xSiWWlCcm55abFhgDI/Q5PzcTYzg9KhlvoNx2tsPeocYmTgYDzFKcDArifBu2uKZJsSbklhZ
	lVqUH19UmpNafIjRFBi8E5mlRJPzgQk6ryTe0MTSwMTMyMTC2NLYTEmc98yVslQhgfTEktTs
	1NSC1CKYPiYOTqkGpsKLcTPNZlTe/3ajr+xErlhYVNi/rfWbfmV1cX2oqpNi/aq14dLEH3/a
	P/zItKnd8oMv2XOW/yzDuWkKOuvfaiY7neE/ovPpH2+y3JfaThebOLkcbxvm27mv3jE8DJT4
	eUHCNW/VnpZFwT0m1+45z7u77ufa2qP7ZsVs2hqfzXx9QuqO3ev+L9wQvGRlzZm6+j8lHhfL
	/xyrWB+3QqZSLkpb4//W/xOYtqo7mzz/qpLRqLDreMcMnbzD97dJZ/Gdm8yQnvH148q8XX2n
	ax7ccOm5Y/LYKTeu8shrv/3JqbPM2xpKJGrWJB3deakuJbPokNWtp7esPUqX2/6fqvf7XNTP
	Sfu6Hzxm68pYvcBYcroSS3FGoqEWc1FxIgA2OoY0GAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvG4np0+awdHNnBZz1q9hs+jePJPR
	ovf9KyaLy7vmsFncW/Of1eLI+u1MFrMb+xgd2D12zrrL7rFpVSebx6ZPk9g9Tsz4zeLRt2UV
	o8eZBUfYPT5vkgtgj+KySUnNySxLLdK3S+DKaDv0lKngqlDFzZN/2BoY9/N1MXJySAiYSEx9
	8pi5i5GLQ0hgN6PEqcWrWCESMhJvzj9l6WLkALKFJQ4fLoao+cgo8XvyBUaQGjYBbYn3CyaB
	1YsIOElsuLKaBcRmFqiU+Hf7FlhcWCBEYu/Fk2D1LAKqEmeOTgaL8wrYSxw6+JwFYpe8xMxL
	39lBbE4BB4n5UxaD2UJANWcunYeqF5Q4OfMJ1Hx5ieats5knMArMQpKahSS1gJFpFaNkakFx
	bnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcKBrae1g3LPqg94hRiYOxkOMEhzMSiK8m7Z4pgnx
	piRWVqUW5ccXleakFh9ilOZgURLn/fa6N0VIID2xJDU7NbUgtQgmy8TBKdXAZPey0vLNyRfl
	wtu27XTe/tRb8bevprzSzVoblosLrR+WTXBrZZ03geFoEefF6FuH1pl9VZKfdPSQ/xY2jo/r
	I+cmRrZM9RNS3iH/d/1l68LHe9ZktJ/eonhNZ+lzrttL75kq/xTc9ND8xuaM4EUC0sXP5gTu
	Krl5TLJ3/4c3jLut/lnf2+VvPE/g7OfITcudNjz9qpf2b/3hhMxAidW77+v3Fjy038DyJLGp
	34TvXxjDmxPszCJ3Cr96cG6sarAQb5IX39y9Le4z56SJK5WsH3/eopJ0e34gD9sDWbsF+x55
	95yZsVpy9/bHp29vWz7BtK/l75qOgxPsNh0zeHMjYHds56epH35zXP7wVWWK6rw2JZbijERD
	Leai4kQAvBDQM+MCAAA=
X-CMS-MailID: 20240521024009epcas1p3440f857e3b31b319c270e2d658379383
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240521024009epcas1p3440f857e3b31b319c270e2d658379383
References: <20240521023957.2587005-1-jaewon31.kim@samsung.com>
	<CGME20240521024009epcas1p3440f857e3b31b319c270e2d658379383@epcas1p3.samsung.com>

There is case where reserved regions overlapped with already checked as
unknown regions. To get more information of the name, size, so far we
allowed only regions which are exactly matching with or located within
the unknown region.

For a region intersecting an unknown region, we did not take and just
showed that duplicated information. So total size was not perfect. To
fix this, let's allow to take even the intersecting region.

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 mm/memblock.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 4a0506e14025..9b68ddc4af5e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2081,20 +2081,54 @@ static bool __init_memblock memsize_update_nomap_region(const char *name, phys_a
 	for (i = 0; i < memsize_rgn_count; i++)	{
 		rmem_rgn = &memsize_rgn[i];
 
+		/* skip either !nomap, !unknown, !overlap */
 		if (!rmem_rgn->nomap)
 			continue;
 		if (strcmp(rmem_rgn->name, "unknown"))
 			continue;
-		if (base < rmem_rgn->base)
+		if (base + size <= rmem_rgn->base)
 			continue;
-		if (base + size > rmem_rgn->base + rmem_rgn->size)
+		if (base >= rmem_rgn->base + rmem_rgn->size)
 			continue;
 
+		/* exactly same */
 		if (base == rmem_rgn->base && size == rmem_rgn->size) {
 			memsize_get_valid_name(rmem_rgn->name, name);
 			return true;
 		}
 
+		/* bigger */
+		if (base <= rmem_rgn->base &&
+				base + size >= rmem_rgn->base + rmem_rgn->size) {
+			memsize_get_valid_name(rmem_rgn->name, name);
+			rmem_rgn->base = base;
+			rmem_rgn->size = size;
+			return true;
+		}
+
+		/* intersect */
+		if (base < rmem_rgn->base ||
+				base + size > rmem_rgn->base + rmem_rgn->size) {
+			new_rgn = memsize_get_new_rgn();
+			if (!new_rgn)
+				return true;
+			new_rgn->base = base;
+			new_rgn->size = size;
+			new_rgn->nomap = nomap;
+			new_rgn->reusable = false;
+			memsize_get_valid_name(new_rgn->name, name);
+
+			if (base < rmem_rgn->base) {
+				rmem_rgn->size -= base + size - rmem_rgn->base;
+				rmem_rgn->base = base + size;
+			} else {
+				rmem_rgn->size -= rmem_rgn->base
+							+ rmem_rgn->size - base;
+			}
+			return true;
+		}
+
+		/* smaller */
 		new_rgn = memsize_get_new_rgn();
 		if (!new_rgn)
 			return true;
-- 
2.25.1


