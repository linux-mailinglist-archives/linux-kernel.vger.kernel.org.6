Return-Path: <linux-kernel+bounces-538623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E24CA49B07
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E99C1897ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E7A26E16F;
	Fri, 28 Feb 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ONcz5vJx"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E665326B950
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750859; cv=none; b=Fv9F0ceCDdLjCK9U9TBc0EQVD6MarFYyG/LJpcLJYnxCG1+5iC4zXpURMcLDU0m83brl8BOgl0i6geAkVFv1N+s1y3m10dI5nR1xsHgn+Os3i0YK22g/YFzDOvFyGdPwDyaJ3HG1VqDdlpSEJzI0qr4EoAsa4h7UtLDXeMginh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750859; c=relaxed/simple;
	bh=6nQd1xomJJEbRkBicsK3sFU1SOu4he/i1r6HbTBh4CM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=Avfd2e/kDSW9M+59W00gqzqXNXmyx3WVERMLJsw1iFROh6PwYvmNrLUzOR4qqI09Sf+glFKahpovigCwTZ1+VlFJgcgE2y3gU/uDBlynMon1NqWvR/rGeWYx6hlJbKyIAr/WG7EEsM6+zpouIAk15/IeIqQNsoUCt9KcYV0C+T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ONcz5vJx; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250228135414epoutp0427f02e222bbd9123f07bd7499a2a9446~oY63NRquI0697106971epoutp04F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:54:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250228135414epoutp0427f02e222bbd9123f07bd7499a2a9446~oY63NRquI0697106971epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740750854;
	bh=y0i0iP7YFThBflzgZh4OQQwIJEzrlQCTwJu6xXb7Vnk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ONcz5vJxvL4v7sjoPOj8HWNQ2JvtD5Ow1wDWrONLoJUTdZN8th0A7tSZCJCbHeTPA
	 tvdJE1s2Op2jANM0jHpLH5nNUtvGFHGkxsDOb4Cu+UQFKg0Y7O/pQ6Lm4J9L6g3on+
	 bpRUklO8GPytjC5+Hdk0zWGDnYEuvnDHDypetvNY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250228135413epcas5p288532ab265f1ea1a509f6d76adec911a~oY62-RNKv2093120931epcas5p2c;
	Fri, 28 Feb 2025 13:54:13 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Z48nw1vKTz4x9Pp; Fri, 28 Feb
	2025 13:54:12 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	75.86.20052.400C1C76; Fri, 28 Feb 2025 22:54:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250228135411epcas5p1c1bbaea7cec83d32ac8f032817e558b9~oY61I96Gx3181931819epcas5p1v;
	Fri, 28 Feb 2025 13:54:11 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250228135411epsmtrp11a58f7cef9cdf010eb26d457fe05905d~oY61IJ7nG1147611476epsmtrp1B;
	Fri, 28 Feb 2025 13:54:11 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-6d-67c1c0049544
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7C.0C.18949.300C1C76; Fri, 28 Feb 2025 22:54:11 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
	[107.109.115.6]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250228135410epsmtip21949833392c75f9528f2cd26cfc466d6~oY60PLzcQ2326823268epsmtip2a;
	Fri, 28 Feb 2025 13:54:10 +0000 (GMT)
From: Anindya Sundar Gayen <anindya.sg@samsung.com>
To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	daniel.lezcano@linaro.org
Cc: aswani.reddy@samsung.com, pankaj.dubey@samsung.com
Subject: [PATCH] clocksource: exynos_mct: fixed a spelling error
Date: Fri, 28 Feb 2025 18:41:38 +0530
Message-Id: <20250228131138.9208-1-anindya.sg@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7bCmpi7LgYPpBg9u81oc2ryV3WLeZ1mL
	y7vmsFks2vqF3WLzpqnMDqwed67tYfN4d+4cu0ffllWMHp83yQWwRGXbZKQmpqQWKaTmJeen
	ZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gCtVVIoS8wpBQoFJBYXK+nb2RTl
	l5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ1yYdpqxoIOtYlsHVwNj
	M2sXIyeHhICJRP+j44xdjFwcQgK7GSVWn/vDDpIQEvjEKHHpszyE/Y1RYtVzb5iG000r2CAa
	9jJKvHh0kgXCaWaSmHp6MZDDwcEmYCzR9qASpEFEIFDix78jTCA2s4CZxMy7p1lAbGEBB4mH
	C78ygtgsAqoSN95uArN5Bawkvv+8xwaxTF5i9YYDzCDzJQQms0vsenaWHSLhItE3bS8LhC0s
	8er4Fqi4lMTL/jZ2kBskBPIllpzNhgjnSBxY/oAJwraXOHBlDtiZzAKaEut36UOcxifR+/sJ
	E0Qnr0RHmxCEqSIxsYMFZvbsHzuYIWwPiSmPJjNDQidWYknXc/YJjDKzEGYuYGRcxSiZWlCc
	m55abFpgmJdaDo+W5PzcTYzgtKPluYPx7oMPeocYmTgYDzFKcDArifDOij2QLsSbklhZlVqU
	H19UmpNafIjRFBhIE5mlRJPzgYkvryTe0MTSwMTMzMzE0tjMUEmct3lnS7qQQHpiSWp2ampB
	ahFMHxMHp1QDk26zUI/WpRkrT7LejWO4+6RYxcvOPm79nY05bazfrLwXpNRyLE7cNcGhr1/e
	Y39PxcpQa94v+5bfV/DVmPhLPyeFO2Ff/MkbcZv5X1bejoq9unf9GSGmzVL3tM7OyWa9Z90x
	g1tDc4Ni1fK4vS/LbxoHHmgLO8v35Gup2skcH6Ntax8n3N05dep+wdcP278uufg5bZs62w2D
	Pb8SNkjfbDutnvub/8hGAVs7wxVTNqoeuL1zAvf0Sx27TrU+mDZLbCbf12CBjQnXFV6U3Km+
	ILG2ssNxqvfeozvOarFLyK4LWH4s52nAJ0n/4Ntdz5pc/tVLfdt35qffonebnyatX1ty4OKW
	p/Fb5k6OqtV7KzRHiaU4I9FQi7moOBEAIwSWbsQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLJMWRmVeSWpSXmKPExsWy7bCSvC7zgYPpBvcu61gc2ryV3WLeZ1mL
	y7vmsFks2vqF3WLzpqnMDqwed67tYfN4d+4cu0ffllWMHp83yQWwRHHZpKTmZJalFunbJXBl
	XJh2mrGgg61iWwdXA2MzaxcjJ4eEgInE6aYVbF2MXBxCArsZJS43/mSESEhJ3P7fCWULS6z8
	95wdoqiRSeLY698sXYwcHGwCxhJtDypBakQEgiW6b/0Fq2cWsJBYueUgM4gtLOAg8XDhV7A4
	i4CqxI23m8BsXgErie8/77FBzJeXWL3hAPMERp4FjAyrGCVTC4pz03OLDQuM8lLL9YoTc4tL
	89L1kvNzNzGCQ0RLawfjnlUf9A4xMnEwHmKU4GBWEuGdFXsgXYg3JbGyKrUoP76oNCe1+BCj
	NAeLkjjvt9e9KUIC6YklqdmpqQWpRTBZJg5OqQYmrRTDlI+Nat4yVwUzS5Zvkbj5Y43Lw8nN
	D1VS7NkVnT6vfF4b/Kzr9C3d7FVBX3lb5T++f1RpveBBja1jS68B16JPrG99Nfz5xPceSj1W
	v0zN/ciLQxukk19/0fsff+jZ1IuCM1fPrPQ9+LZObJ28y7/5SQe/piz3kmW27iqTW5E8VeoG
	752PTaVassusNq9I/T9PzV2msOOn3MaGFIXY5//F1X6bFZ59ttn5rM7W1t2H7ReXHBVscJkY
	XMjfZj/BwaVkw5UzFgrvtwSs4m3wFlCv4DCZ6HBJs25y9Ca5PPb8gBBZ/628HTx6s+WPJJQK
	BPVv0Gnob3SfNUFyRvAPpvOPF596sHvz0twXok+VWIozEg21mIuKEwEvA4CcgAIAAA==
X-CMS-MailID: 20250228135411epcas5p1c1bbaea7cec83d32ac8f032817e558b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250228135411epcas5p1c1bbaea7cec83d32ac8f032817e558b9
References: <CGME20250228135411epcas5p1c1bbaea7cec83d32ac8f032817e558b9@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Fixed a spelling issue in driver.

Signed-off-by: Anindya Sundar Gayen <anindya.sg@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index e6a02e351d77..da09f467a6bb 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -238,7 +238,7 @@ static cycles_t exynos4_read_current_timer(void)
 static int __init exynos4_clocksource_init(bool frc_shared)
 {
 	/*
-	 * When the frc is shared, the main processer should have already
+	 * When the frc is shared, the main processor should have already
 	 * turned it on and we shouldn't be writing to TCON.
 	 */
 	if (frc_shared)
-- 
2.17.1


