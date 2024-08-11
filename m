Return-Path: <linux-kernel+bounces-282100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7606094DFAD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30901284071
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0E1482DD;
	Sun, 11 Aug 2024 02:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="RYaNEoET"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59067D53C
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343162; cv=none; b=X6P0O7rr2Y1P+8mtkls6gXyjDuM/93MqSrbCuo8VHnkF+biC2fkM6pkCqV0L+b8La8daIs9pDqpDHzKtrZaVIuo8WUMbDxkpAgq8sds++CyIxdtGT6d8z5VRKepFmcsFXbpgnz/RlWkdk4gfSiB9Mcej9X2VMOBXTfchWSoxX0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343162; c=relaxed/simple;
	bh=ZJu/AMtK8InRDxefOIKBxnk0Ozab+dYq4YflThpPSqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b7xjY09eHVID6gUPRnsY3ieZgjDdLiCASiSj9LUr6B/a0lyzUSRhj8F+d8pBO4j6au4PgaPw0oCgYBX2v2UlTAOUsxGCwwZk+pbl1kk3A7o2M7jMWAS40yUf0E3YfENM4FWXvmDjt4KFthBk1gjWzmVrX3/71tKt+fN9XGiHEEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=RYaNEoET; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343160;
	bh=KwXSfJnHBSShhgwmiK7TmseTrjzJIFByxJ2mQE/22MY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=RYaNEoETsFK1Hldn63995N2k7CNcgjsYrd0MMufC7iCG+LjrkKHBfYcPpicSuzgVx
	 gWhVSCtBkNwbwNsJ/W4FlXhbtOmlT7r3kBofH7PubimlSPwLGVqEtyrPOYVjOJEOVM
	 xy6nFVna6+dSFnKhbH2qo04VhKXnSRTzVCluAujIR+LZvY8NbVfeNUPlqzAjFXDQfZ
	 Y/R9UPd+Yfp4hL1aPutod6pFQ+1TBID8RmJIfN76ZfOEkGAgjY4vpvfFiyeA6oVnCr
	 FbxXY5SnlXAheUCVupiKp7GhSVK6U1id8U6kFiWUR/Yc5ONYGutVhW9g0SOPc6hoCK
	 F/Af7qe4s0Ysw==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 70F781349BB3;
	Sun, 11 Aug 2024 02:25:56 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:25:03 +0800
Subject: [PATCH 12/27] range.h: Make range_contains() take const struct
 range * as parameter type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-12-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: D8_pxuciPPMGZUW5BONk0bzP4qrRoBdA
X-Proofpoint-ORIG-GUID: D8_pxuciPPMGZUW5BONk0bzP4qrRoBdA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Make range_contains() take const struct range * as parameter type since
it does not modify these caller's ranges.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 include/linux/range.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/range.h b/include/linux/range.h
index 6ad0b73cb7ad..7dc5e835e079 100644
--- a/include/linux/range.h
+++ b/include/linux/range.h
@@ -13,7 +13,8 @@ static inline u64 range_len(const struct range *range)
 	return range->end - range->start + 1;
 }
 
-static inline bool range_contains(struct range *r1, struct range *r2)
+static inline bool range_contains(const struct range *r1,
+				  const struct range *r2)
 {
 	return r1->start <= r2->start && r1->end >= r2->end;
 }

-- 
2.34.1


