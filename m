Return-Path: <linux-kernel+bounces-264266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C4C93E0E0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 22:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76871F21701
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 20:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B044186E2E;
	Sat, 27 Jul 2024 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="g33h+S3e"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBE33839C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722111281; cv=none; b=sKybShX3++40hmemdheF4oHNKPTuPKUcImNLY8aHj0cihre2wtatBzaLBZ4PRqdO3f6sC6ogAWmmeKBaCnRKXaffOuCQvQbLEAbH6D8wTbaGrM5qv6kzR7AlPQKDUfwxplAtGQXRBQtHL9h+OOKccZmYvw2QEGGAsNmSvB2CAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722111281; c=relaxed/simple;
	bh=b/bwYa2KaiPMsL7zw8XYW9nhn4IkF5uvVsNPxcJk3z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukLChSkJpZJ4FJw6e/7TeRgWTsKEVjUCyYekksIIO42Vhd1GRx6GzLVlllBukCoJ1NF+Kg8F86HZAB9xQQvJyWFcTQxxoM9OFXD6GE+qjJA6VvpQr38QDwlso4vE8N54gMKce9TVJRDXtoByOXog0ZtW3veZJNiVKVs+5gTXpdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=g33h+S3e; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id B90BD240101
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 22:14:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1722111270; bh=b/bwYa2KaiPMsL7zw8XYW9nhn4IkF5uvVsNPxcJk3z4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=g33h+S3eTfYsgcNXNfrWL2dR3EJo50J0AsZofEjeH2+UMO8cAOCX2u/Nu4jLOz66L
	 ZMl9QYKorfcpO6339yzGOxVc0wIqXRSrtSJ2NLKs54J9M3fbHKP+kn6zf49NwZXWY6
	 DVdElz4KFtaGMv2SaK9r4jNVIOI4OhVIPcwtNjeS/Hit9cfMEyQfesdKqDHdnCfdB8
	 rooQPz92IUzjXZLthjhWfzJns19UuxSuwqjS2zLi/NtjzpXPf52k63gu0vgsvq/NdR
	 RlDShhP1b5AVpUxZ1KE/cLQb8GhL93m/CDXz2nvaRys5qEsX/1zT9xiZhrGBCHM36Q
	 uYwOGYwNr/KAA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4WWbSP3Qs8z6tym;
	Sat, 27 Jul 2024 22:14:29 +0200 (CEST)
From: Alexander Reimelt <alexander.reimelt@posteo.de>
To: andersson@kernel.org,
	petr.vorel@gmail.com,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: arm: qcom: Add LG G4 (h815)
Date: Sat, 27 Jul 2024 20:04:49 +0000
Message-ID: <20240727201413.114317-2-alexander.reimelt@posteo.de>
In-Reply-To: <20240727201413.114317-1-alexander.reimelt@posteo.de>
References: <20240727201413.114317-1-alexander.reimelt@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

International variant of the LG G4 from 2015.

Signed-off-by: Alexander Reimelt <alexander.reimelt@posteo.de>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index f08e13b61172..f79730d02eb7 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -250,6 +250,7 @@ properties:
       - items:
           - enum:
               - lg,bullhead
+              - lg,h815
               - microsoft,talkman
               - xiaomi,libra
           - const: qcom,msm8992
-- 
2.45.2


