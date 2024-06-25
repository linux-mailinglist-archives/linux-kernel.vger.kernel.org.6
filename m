Return-Path: <linux-kernel+bounces-228257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FE7915D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4341C2166C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BB18287F;
	Tue, 25 Jun 2024 03:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YG/symxG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A389373449
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719286485; cv=none; b=AFOcADLSJBYEZXBg1W9CiwkAv7z5yt94ugP8p9yK463My8+2/y5uCXQ5mHoaylPHPwYY9E6W7Fxz7/CYlarh1wQFBevKlCFTuV2zk+JlREtRvyKy+Nth1y110BY7SLlJVmxT1Uzo3CpCJDnSYCW8iUEKX6KSyl8NtaNRC8NMk9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719286485; c=relaxed/simple;
	bh=v+peBGIoF57BoaJXnu6mP9weEMJ3K6JCIJ4fIrLUef4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jnd+47cwElKUBcLKhET83TLHOer7sUjkNmvINotzmgJYBAng5LPhNgeE6F+UXbRkI4ac5alHG9jsmmb6WA6lgQ05fNtiKVxxXIdOOheDX3QPA3VecL0SbpPbux3xxGDHHwek9HYuZDJi/H6icjQe9bKAz2FwfNS7DxjqiIFmY78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YG/symxG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719286482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SGswU3DecNZJwucDpQX2LopVweijkzu4ZQLZyP0kjsM=;
	b=YG/symxGY5HTM2FfP/nVCFPtXjpHQb2wspSP9MP/0zuiJ0jMeFXOTixH6USW1t+WZw+ogr
	13IRPe6kE2a4SSlPNI8yZEVD761q5a2rKgh0rLH5uwoMnQl4S7BfB6tdTmpCCXLiyRzlcs
	zqji2PMwW2942Oc/22C1AlNC8KJgMsk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Z6n5CrHnPmG8VEAB9kT9FA-1; Mon, 24 Jun 2024 23:34:38 -0400
X-MC-Unique: Z6n5CrHnPmG8VEAB9kT9FA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-57d1de50e8dso2314941a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719286477; x=1719891277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGswU3DecNZJwucDpQX2LopVweijkzu4ZQLZyP0kjsM=;
        b=V+kLSJdr1KsZ+dI97w+RYmpg+5deHkqQz+9ok41zqnYagzn31FwritelnhmCsFSHze
         ncLsWWZPZpAIxAc/MHklQ6oFZGxYNDlNV9/qTfE8v++C9INCrsbL/DYvNFwW2roERhnv
         ah7CuVGk8l0JII/FqAl1Cgbt1xM720Ulk3oU3P8Si2PO8wgzvmwuGGehZ0yeyrTamQsC
         XQP9UgynPnugalilxRpWPqWdNjm3byXOh9OB2c1heBysSomq0xL/K9B+Lef2EiCOEcU/
         vd37g7Bq8fAqQ4Y6u0BD7HYun9x8dnyqm8F0MxniojUafkhVhcFdsfhsgWAfgW5vWcTr
         1LQw==
X-Forwarded-Encrypted: i=1; AJvYcCXx6Q3OcjAYxWO5hMu8+TTX0MQmxetediX2R67/fNApZTMOraJEbpYLuF50eQSdcJsg/W0YeYmpgpLyPLMTQZunTChNPVPWTrUs677F
X-Gm-Message-State: AOJu0Yw5d+v0Kk1GSsrxFtfXBb/Mgmq8N9ZYVn1TolYL8ZxmatUDe48S
	Sf9MdVCjhf4XFK5wfLG0mK+zfTfljMRiL2bliyNJVcgku9du4YJr+HLrSdDm3UCDD8a37iZ60eB
	Vr1k38kD5whJJ0RF5xxWMv1mHE1IeLnzbiS/OzqiGg4O6gQJf8zHnrJGCyQeoMA==
X-Received: by 2002:a50:f604:0:b0:57c:aac9:cd8 with SMTP id 4fb4d7f45d1cf-57d4bd5648amr4117229a12.8.1719286477673;
        Mon, 24 Jun 2024 20:34:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+5fJhMOObE/CLVn4hoZPAErdgQ6Q27QwDXYiJwCXvv/sOyyQAaUyJ2xoTNyaljeRrEUGIyA==
X-Received: by 2002:a50:f604:0:b0:57c:aac9:cd8 with SMTP id 4fb4d7f45d1cf-57d4bd5648amr4117220a12.8.1719286477316;
        Mon, 24 Jun 2024 20:34:37 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30427f8fsm5449736a12.34.2024.06.24.20.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 20:34:36 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entries after adding vendor prefix in sound dtbs
Date: Tue, 25 Jun 2024 05:34:19 +0200
Message-ID: <20240625033419.149775-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit ae8fc2948b48 ("ASoC: dt-bindings: add missing vender prefix on
filename") renames a few files in Documentation/devicetree/bindings/sound/,
but misses to adjust the file entries pointing to those files in
MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
broken references.

Adjust the file entries in NXP SGTL5000 DRIVER and TEXAS INSTRUMENTS AUDIO
(ASoC/HDA) DRIVERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 77008faf25ee..0ee7a337cfa9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16334,7 +16334,7 @@ NXP SGTL5000 DRIVER
 M:	Fabio Estevam <festevam@gmail.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/sound/sgtl5000.yaml
+F:	Documentation/devicetree/bindings/sound/fsl,sgtl5000.yaml
 F:	sound/soc/codecs/sgtl5000*
 
 NXP SJA1105 ETHERNET SWITCH DRIVER
@@ -22408,13 +22408,13 @@ M:	Baojun Xu <baojun.xu@ti.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/tas2552.txt
-F:	Documentation/devicetree/bindings/sound/tas2562.yaml
-F:	Documentation/devicetree/bindings/sound/tas2770.yaml
-F:	Documentation/devicetree/bindings/sound/tas27xx.yaml
+F:	Documentation/devicetree/bindings/sound/ti,tas2562.yaml
+F:	Documentation/devicetree/bindings/sound/ti,tas2770.yaml
+F:	Documentation/devicetree/bindings/sound/ti,tas27xx.yaml
 F:	Documentation/devicetree/bindings/sound/ti,pcm1681.yaml
 F:	Documentation/devicetree/bindings/sound/ti,pcm3168a.yaml
 F:	Documentation/devicetree/bindings/sound/ti,tlv320*.yaml
-F:	Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+F:	Documentation/devicetree/bindings/sound/ti,tlv320adcx140.yaml
 F:	Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
 F:	Documentation/devicetree/bindings/sound/tpa6130a2.txt
 F:	include/sound/tas2*.h
-- 
2.45.2


