Return-Path: <linux-kernel+bounces-568375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA68A6947A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCB7C7A3811
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44461DE4FF;
	Wed, 19 Mar 2025 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b="hy+E5DHK"
Received: from p00-icloudmta-asmtp-us-central-1k-60-percent-6.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (p-east1-cluster5-host12-snip4-2.eps.apple.com [57.103.89.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861141DB55D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.89.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400880; cv=none; b=WK5yXxolwqlaH7amQRdQze4p7+AU+nysDntpHKFeMgoi77lkMry2JMKDw/g+rZ/h+iZlywYCQEZdlqfnz6l0ObV5443IWdEGOecgDvNufdx5Zz1yJeBYTUymgJyrZvBt/6LJnrirHdyK1Q7txOYyqwsVRqpYTh44fi/Rv1IucyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400880; c=relaxed/simple;
	bh=jSYigw9RHd5MXqnBsNMF/i/zXhiUyoQtQhVRk7JevBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vDpUFwnB4u+g/bs/ozwLq+7oWZUlULg9IOQ0Q5iHV7tXX6FuON8YsOFW7v46BCGgpQ30Zlew4m1510ZEKEC6KxpXbhKPEyQEBXaWYJ+cd0lEC6V/TbffIsenRu16176hKAbXfgB4Stw9Iq019yQTxy60QdxhgshbosoHFb39Vuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es; spf=pass smtp.mailfrom=pereznus.es; dkim=pass (2048-bit key) header.d=pereznus.es header.i=@pereznus.es header.b=hy+E5DHK; arc=none smtp.client-ip=57.103.89.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pereznus.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pereznus.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pereznus.es; s=sig1;
	bh=0YAbwE3jUJmjtAF1aTc+Ih0zOeBMB4K71DOpq7By6Pg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=hy+E5DHKdpH56Dy8LdHmdrfXV9j489Vrw73m77JWLDD4TVO9imr3y//mEgFsoyxJx
	 3R9E491+vct35wKGFXO41bGC9x1XZJNMnac5aDd4HSN8bhQJuM5pL+UWMImsuuNCGv
	 QGSeYM6jgtmaRZX+VBSWs0asrGZHWiuNayV6ryocIu0Eb35SPlX6yUIcsFHDXV+nTi
	 JNKeAA38bngWHcwmbTt0aBsrwlCN2Mkw1rhhL9dnna8AuKzknJ2b2Mq8F5hPzMD36a
	 SxOpEu1rIDM33Z8nDSFjE7WUxEEEZw9C7Nb48+uVxWx+i79Ipmf8SIZ4HXhZwRkG6i
	 iF1+J/gMRemjw==
Received: from localhost.localdomain (ci-asmtp-me-k8s.p00.prod.me.com [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-6.p00-icloudmta-asmtp-vip.icloud-mail-production.svc.kube.us-central-1k.k8s.cloud.apple.com (Postfix) with ESMTPSA id 20D9E1800851;
	Wed, 19 Mar 2025 16:14:33 +0000 (UTC)
From: Sergio Perez <sergio@pereznus.es>
To: Tomasz Duszynski <tduszyns@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sergio Perez <sergio@pereznus.es>
Subject: [PATCH v3 1/2] dt-bindings: iio: light: bh1750: Add reset-gpios property
Date: Wed, 19 Mar 2025 17:11:16 +0100
Message-ID: <20250319161117.1780-1-sergio@pereznus.es>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wiQP3Y_JUpN-3SSrwOY1O2K4CbhoPWpX
X-Proofpoint-GUID: wiQP3Y_JUpN-3SSrwOY1O2K4CbhoPWpX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1030 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2503190110

Some BH1750 sensors require a hardware reset via GPIO before they can
be properly detected on the I2C bus. Add a new reset-gpios property
to the binding to support this functionality.

The reset-gpios property allows specifying a GPIO that will be toggled
during driver initialization to reset the sensor.

Signed-off-by: Sergio Perez <sergio@pereznus.es>
---
 Documentation/devicetree/bindings/iio/light/bh1750.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/bh1750.yaml b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
index 1a88b3c253d5..f7a8dcd7d2a1 100644
--- a/Documentation/devicetree/bindings/iio/light/bh1750.yaml
+++ b/Documentation/devicetree/bindings/iio/light/bh1750.yaml
@@ -24,6 +24,10 @@ properties:
   reg:
     maxItems: 1
 
+  reset-gpios:
+    description: GPIO connected to the sensor's reset line (active low)
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -39,6 +43,7 @@ examples:
       light-sensor@23 {
         compatible = "rohm,bh1750";
         reg = <0x23>;
+        reset-gpios = <&gpio2 17 0>;
       };
     };
 
-- 
2.43.0


