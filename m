Return-Path: <linux-kernel+bounces-529329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18E0A42307
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C4337AA3E1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5250318CC1C;
	Mon, 24 Feb 2025 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="0IQwydfN"
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D318D65A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407310; cv=none; b=VZS89UnREt8LGpT3+Sd76fksfrXS778yweWdPkUt9LKSX08cvBPFsEbV6Z9cbesyukmN9xBiG6e8GzmES10xGqjXtCL/oEBMdjdcQKEEQvOwPKt0N8lpMwbel/LlILKGAxm/OC12Wfx9bz2eN3vhYChQYSlxErokbxA+B5QcUEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407310; c=relaxed/simple;
	bh=YfyGamYypeZHm+u3B8rqHY41aXzYfX6dgKpGZSgCC88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RFnjtpu98+YW3UUZ97xx+UJElJNMkBIXf92/G51KWJxRuEwqPR+31iuHvaMujmmoHCpVH763NyW7z7rRO35XGWGBXuz8KOyKM0rQLhtEepyY55UDAWYTV1sm4fYQGDtf7+7mhchulI9HhRB+L1DqIHFCkOgsiqBeT0cFUEVPQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=0IQwydfN; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=/1dvoM+wTSEzDssTB34hOCOc8IYnryTOc1nwMu4SUek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=0IQwydfN6THzOtWDrrncsG0Iu25RIaaAUrjT+K1BvoZ4htmGm/dexwTQPLipYMkR1
	 an0c0y0AqAw+b5+znMLIF3nWwHzo0Q32+DDhBo4QSQHNxat31vIx19OS8wFqbKKXMp
	 okY+IBxOGg09tiLq6iUAshgCEFUnrw7578ueBpvmwgj4X6Ts41Fy+JTw8ROKTNvp2N
	 aO58e7gxaYnPs+PiDc2UnQZzuIILDxwxx3Ip6vIG7AA3QML+DnEkQJ/3iS4eFeb9j2
	 Bt8mexjpV+7IMYysC5gqcaB1pVyeb1PmtWHUUFtFcYufTM+/V14vHQo8tNlxeeJAdD
	 hUFufNhV5MVmQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id CA9A74A035F;
	Mon, 24 Feb 2025 14:28:25 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 24 Feb 2025 22:27:57 +0800
Subject: [PATCH 1/5] of: Compare property names by of_prop_cmp() in
 of_alias_scan()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-of_bugfix-v1-1-03640ae8c3a6@quicinc.com>
References: <20250224-of_bugfix-v1-0-03640ae8c3a6@quicinc.com>
In-Reply-To: <20250224-of_bugfix-v1-0-03640ae8c3a6@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: ZUo9YW5lB6eUpVM_SuTsayBnZG1MxgKG
X-Proofpoint-ORIG-GUID: ZUo9YW5lB6eUpVM_SuTsayBnZG1MxgKG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_06,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=851
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502240104
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For these pseudo property names 'name', 'phandle' and 'linux,phandle':

Use dedicated property name comparison macro of_prop_cmp() instead of
strcmp() in of_alias_scan() to:

- Make property name comparison consistent.
- Prepare for introducing private is_pseudo_property() later.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index af6c68bbb4277e4f66deef886a2df8d1b6f114cf..d2d41601136bc8ee2b97e31b83af1b361ba03261 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1855,9 +1855,9 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 		int id, len;
 
 		/* Skip those we do not want to proceed */
-		if (!strcmp(pp->name, "name") ||
-		    !strcmp(pp->name, "phandle") ||
-		    !strcmp(pp->name, "linux,phandle"))
+		if (!of_prop_cmp(pp->name, "name") ||
+		    !of_prop_cmp(pp->name, "phandle") ||
+		    !of_prop_cmp(pp->name, "linux,phandle"))
 			continue;
 
 		np = of_find_node_by_path(pp->value);

-- 
2.34.1


