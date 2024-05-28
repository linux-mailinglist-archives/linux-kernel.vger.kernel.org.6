Return-Path: <linux-kernel+bounces-191792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C04F8D1424
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E311C21827
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FA367A0D;
	Tue, 28 May 2024 06:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="3rppQj6c"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EDD37165;
	Tue, 28 May 2024 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716876094; cv=none; b=T0UMKTEYDbqxmjDEBxiojsLlXnVlWLzwCf+YnrulKM06hCwdzkNCBaf2W1t54WWN5IyyfoyxMp4S7/4N/c98a12I99Nfy0PJMhhxeX3YR2BTkFn/gEboe+CoO7FzjccmDVf9DRVpR4DIWE9tF/KyND54DmNzdjmT8H7a/f3MOoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716876094; c=relaxed/simple;
	bh=vj5iTVNnr0LltL75dJySY0TkZeBZ96BYbyS8soMrNtU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iy/66M+PCEtlM5j08sduf9Cv/0GSlSMgnKTm5c/zqFO085f9VXVr2oa5wPJoH7O7kxUH3phawNyUCL2lgn+F6a91uyEOMGonevN07Y/ZpKOKxUaF8h75S/Ax/TeIq9C7WgP+gyZQAqmWV8c+0R0K473ASl3ty5PZrtdijc8toeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=3rppQj6c; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1716876090;
	bh=4FZFc/ldoEBTquoVTySNzI9r+bg5+rvsd53z2bgulQA=; l=1600;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=3rppQj6c9DjXEqoUvcskLCiqUGHFsRdkaGyAGUmf/VV8oI38S3TTFFJSDRANkv8ks
	 r36qcjnyVbdqQozWtOHLHbKc7BWNPlJ4rqlCc1r8mPrN9Dmqr2o04NZFPVMCP6ShJS
	 0m5920C6qqkheAvzxhvkFs/m7BadSlj0U/kIX5ua3PBgZJJ+NeQeuKv4ZHJYHyRRjL
	 KbowaEq7tcbUFIVNoGBHbAnEd1vJDyzmfsnEBdbGq7n2h0VJWDrQIcaFJ1M5VodEoe
	 PYRA0/N9siRCcLFA4T8H4acZ132vfbzhjIIgepWEWMeIVsaFPhHcx24UBXVlnUNZWT
	 o5KgeWhQA8MKg==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3213198:0:AUTH_RELAY)
	(envelope-from <alina_yu@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 28 May 2024 14:01:22 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 14:01:22 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 28 May 2024 14:01:22 +0800
From: Alina Yu <alina_yu@richtek.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<alina_yu@richtek.com>, <cy_huang@richtek.com>
Subject: [RESEND 4/4] regulator: dt-bindings: rtq2208: Add specified fixed LDO VOUT property
Date: Tue, 28 May 2024 14:01:16 +0800
Message-ID: <c6cb218f6338291525a29ed89a88a42c175127ad.1716870419.git.alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1716870419.git.alina_yu@richtek.com>
References: <cover.1716870419.git.alina_yu@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

As the fixed voltage for the LDO is outside the range of the adjustable voltage mode,
the constraints for this scenario are not suitable to represent both modes.
Therefore, A property is added to specify the fixed LDO VOUT.

Examples of fixed LDO VOUT and adjustable LDO VOUT is also added to this version.

Signed-off-by: Alina Yu <alina_yu@richtek.com>
---
 .../devicetree/bindings/regulator/richtek,rtq2208.yaml        | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
index 609c066..87accc6 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
@@ -75,6 +75,12 @@ properties:
         description:
           regulator description for ldo[1-2].
 
+        properties:
+          richtek,fixed-microvolt:
+            description: |
+              This property can be used to set a fixed operating voltage that lies outside
+              the range of the regulator's adjustable mode.
+
 required:
   - compatible
   - reg
@@ -177,6 +183,8 @@ examples:
             };
           };
           ldo1 {
+            /* Fixed LDO VOUT */
+            richtek,fixed-microvolt = <1200000>;
             regulator-min-microvolt = <1200000>;
             regulator-max-microvolt = <1200000>;
             regulator-always-on;
@@ -185,7 +193,8 @@ examples:
             };
           };
           ldo2 {
-            regulator-min-microvolt = <3300000>;
+            /* Adjustable LDO VOUT */
+            regulator-min-microvolt = <1800000>;
             regulator-max-microvolt = <3300000>;
             regulator-always-on;
             regulator-state-mem {
-- 
2.7.4


