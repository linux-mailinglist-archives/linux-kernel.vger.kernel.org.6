Return-Path: <linux-kernel+bounces-215152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C67908ECE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3361F21F48
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D3D15FA85;
	Fri, 14 Jun 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="8ba0C/x7"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD48E154457;
	Fri, 14 Jun 2024 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379278; cv=none; b=BcKSd4HsqWqPjGBECwzxDLVfQDrRNrocZhx857RamzB34tx3R5uGWwCiQbSYk1kFczzaNBHYiJMqzYc5Qq5ZGx2fHvc83TpH0r36VzXi9hxEoxXp02gCpOXrsF1+f4mtrL/UIrT12yWYI5fG/AqvToA38g4n/84MfAtauwVh5iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379278; c=relaxed/simple;
	bh=v18banXTYDVpix+KbeN27Ilvj7iKBjNLDKFcfhurzgI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kkrB0bkE1SGxHMhDC1Hx9ABSQM6unGfS9zmblhDsdjSkNDo3N3KloXWUwXJVQlm/gfKYRYMffcE9UmhvNvQMw6KuoIBHMuWCsdpzr4RA5QEafgHvVIMp0jVfuU6feqen158JOUC9jdzt3q1gv6I1Hg8srnShCz2AYt1l1sywyew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=8ba0C/x7; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EAWaU2026928;
	Fri, 14 Jun 2024 17:34:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=7riLuqz+hA84DWBGx6XOwv
	cbfBzybdq7BcM57HkoHGI=; b=8ba0C/x7jRpXKP5819oyrl616VIvttD7d6J5v9
	uZmCs2/oH5B2J2y131VZ4vxKo7eI4ZczmOZA8BgtuKI3l4BtiW5Pp4sbptRlU/87
	zKdU0IKeeZv0wEeS+OnsuEJy1UX4KMrYgxLjvmT2s/yd7CBIlosdZSEU0Plfubox
	kcIX4jxZ1PLUkLKnYzFHki4xWwzC2E5tOz6fd851+zjO2MhoQ3ClML6ODa8e3cMb
	9x1GX3fxG8BfpjzUPEe5kg7x068CGB3KB59s3mVi2A4TD8aei++7idxPZfU+OERE
	ss8ZQy4Rkv97DuO6bv4+939qMwonF90NF/fzaz0gTcTKeQ2g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yrfujae6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:34:23 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 04E884002D;
	Fri, 14 Jun 2024 17:34:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 215AB2171F3;
	Fri, 14 Jun 2024 17:33:48 +0200 (CEST)
Received: from localhost (10.48.86.128) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 14 Jun
 2024 17:33:47 +0200
From: Etienne Carriere <etienne.carriere@foss.st.com>
To: <linux-kernel@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, "Lee
 Jones" <lee@kernel.org>,
        Pascal Paillet <p.paillet@st.com>,
        Etienne Carriere
	<etienne.carriere@foss.st.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] dt-bindings: mfd: dual licensing for st,stpmic1 bindings
Date: Fri, 14 Jun 2024 17:33:46 +0200
Message-ID: <20240614153346.2656871-1-etienne.carriere@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_13,2024-06-14_03,2024-05-17_01

Change include/dt-bindings/mfd/st,stpmic1.h license model from GPLv2.0
only to dual GPLv2.0 or BSD-3-Clause. I have every legitimacy to request
this change on behalf of STMicroelectronics. This change clarifies that
this DT binding header file can be shared with software components as
bootloaders and OSes that are not published under GPLv2 terms.

In CC are all the contributors to this header file.

Cc: Pascal Paillet <p.paillet@st.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
 include/dt-bindings/mfd/st,stpmic1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dt-bindings/mfd/st,stpmic1.h b/include/dt-bindings/mfd/st,stpmic1.h
index 321cd08797d9..957c48300cd4 100644
--- a/include/dt-bindings/mfd/st,stpmic1.h
+++ b/include/dt-bindings/mfd/st,stpmic1.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
 /*
  * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
  * Author: Philippe Peurichard <philippe.peurichard@st.com>,
-- 
2.25.1


