Return-Path: <linux-kernel+bounces-286483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF0B951B87
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5811F245E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2017E1B1512;
	Wed, 14 Aug 2024 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="KT4zjpKV"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC21B14F6;
	Wed, 14 Aug 2024 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641054; cv=none; b=eoQ2eigvZJo3cMoc2I1D75LLq9bBQdINweW+wSorrVddu3qOzAydooR/4ZdHJEdMrv47BULHVNMmg2lmZolSY3Y0hFvI4oiPpdNZ2Ic0zUiliv1Fl+ZTufbRFQ3s4b3ktLWWUT+O8zwz3ceyNCFnfPavNWzJ7lxNFv2EENKnffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641054; c=relaxed/simple;
	bh=85liRaEpl2I8niazgGfo1LURcRMDZrJ2sJ8OrSt3uNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eidniyJ33LpKHEKPGd9mFIVBu28tQRo+R3OJqduJtf6EzoFYT5/8v7nvTW0oT56/JWz7yqf43gtRMPjwgHhB8MS2d85jZUn67HvvzK0OtOM8dLHATIlGjPIczGdRrUC1pOoxeBZJ2ZbsyHuTuYI7JwXkMBIKp8B+eSi1YJWxzMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=KT4zjpKV; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6cpVotNXuvb07HW/+C7ruuxkNz/vHRVa4M+bUyvesUY=; b=KT4zjpKVr6jp2f1ocymeKtNDR3
	jb1bf8VvhnsQrhRVH+qE+NQQWyG4jZ52AXJpilaZu8iXjeL4akn4TJ93KP35P5bD4qTb7ft1FZxZr
	p8NNBfIvkHNjqx4/cZO1DYdorE+UAcmtCGG1Nakz+7B396arq6frA8cFC6SdqyXLLEzElRCFZqr6d
	p3KNK447e0lnU++yT5lJ9zJddk2THwl8qsxJaESQUcdMtXA83tK/LnpiW9m0q3qxOkQU+s496ZeU3
	7wMuw+LHs+i5sAQ9xh9CMhw97jL8TsWkMjgx7C3EOb2Hyj6PyZLN/kOWn4hn8huzzKo8CMH1Xn3nZ
	X0yI8tww==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1seDm2-0009GM-Di; Wed, 14 Aug 2024 15:10:46 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1seDm1-000H8L-34;
	Wed, 14 Aug 2024 15:10:46 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 14 Aug 2024 15:10:35 +0200
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add JMO Tech
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-drm-panel-ili9881c-lcm-jm800wx-v1-1-22a5e58599be@geanix.com>
References: <20240814-drm-panel-ili9881c-lcm-jm800wx-v1-0-22a5e58599be@geanix.com>
In-Reply-To: <20240814-drm-panel-ili9881c-lcm-jm800wx-v1-0-22a5e58599be@geanix.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723641045; l=769;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=85liRaEpl2I8niazgGfo1LURcRMDZrJ2sJ8OrSt3uNI=;
 b=2GEtZwBTcuB5RBMQIIOjy7fYIgcSMNBbiQ+5C96Lq3rtQuVDhv4zMG52wGPO2Opr6X5UkH3av
 SlwYnuNAw1aAKVksRkrGtBGBtgB7IBLJXwklBY3S0LoYPfqKPIlkHho
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27367/Wed Aug 14 10:36:34 2024)

Add vendor prefix for JMO Tech CO., LTD. (http://www.jmolcd.com/).

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a70ce43b3dc0..5d2ada6cfa61 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -758,6 +758,8 @@ patternProperties:
     description: Jiandangjing Technology Co., Ltd.
   "^jide,.*":
     description: Jide Tech
+  "^jmo,.*":
+    description: JMO Tech
   "^joz,.*":
     description: JOZ BV
   "^kam,.*":

-- 
2.46.0


