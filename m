Return-Path: <linux-kernel+bounces-182203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8218C8803
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28978287A88
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4041626DF;
	Fri, 17 May 2024 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hCAAGTvD"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37E05EE82
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715955772; cv=none; b=DEJPcfpwws7avrxp5jpVIiOr0YbneqTt3cJrUVZ27KW7kB0RjMyHP8eCigbrb6j8BumEaECtc68sJ+vsK6/8iErhNCmxCU8UnubcGzibya4I8LyorYyG7uEUAvteIzcE0xQOdVnECQQny3sxtFGoRFpFIaJetoZf/NShuEqZAjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715955772; c=relaxed/simple;
	bh=3HO4qcYXJgZg4FhjGTJW3cruo/JKZwmUPV9ToBYsSAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EDYHGeB+J3m5PtpsHgi9aK5coSbFmSjr7aCZTrJQZl2vg+XZzUcUknc+hniyYV3wskph4d9berZ8tjgzVmboK7tjJ4W7rrMi4rQdDhZpdOofAQOh6xxpNjj1DUEfHVO9mW12GbmyAITlIy560Y+yIIpFDjr8Ap5Pb3TE3ZRJXF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hCAAGTvD; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so4902188a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 07:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715955768; x=1716560568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wof1SP6Ref2uPP1r74EXX3SjtI/nnHeBDVdJ5oPu2bE=;
        b=hCAAGTvDgjrhIms6gFi5YbRnJFYWE33SskuofW9QFge6pabMYIOKG3ax1z50604RHO
         cUNiQj4GRFWQFF+4Q/08w40uvi4AvsNzh3jQxi4yXSbcnHoYmAyOKryYRDhpylUouhqb
         WzDKMWbigNKWp0SGBH5gUAVMxNVt/uUWzFcItRA9puBQYqHt5juiohiRRPLG1nDQUGXi
         0NWQMNoS/tY3OSkiTHpu8Mk30fXiwDWNSEZOaqzhsHjVhuqLoXGEqjujQ+VguSmYD9V4
         9tGcIhjyhashpviINBhxrfODMyBC85oF/pJn+LrdJ3BNkh8ljVQR/o9BTRmZabHS6fgY
         d/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715955768; x=1716560568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wof1SP6Ref2uPP1r74EXX3SjtI/nnHeBDVdJ5oPu2bE=;
        b=GhkBMD6J8S/hbCCRWIb+XJT8DmFbIT/HfXVR3iYyoF6N4PSw/6AUoJ6zBLLPi91YW/
         OTEghCZ7ejR+q1x+4OZND7v6Jfr+oKPdKu6i/SpdCwTxX9sjC3/SHAg54kYoSF0Cl5j3
         0vQMELZSHdLqRkmNkGu405QHh0pC1AnxMzwR4yTBjPGfDwoJjSQBsHIqfMjjx1a6erW2
         LTr9f5m+xSeGuDjYi+M7hvidvjW4KEmbMQywkE6dJ8w2kE/0Z/mHzno4y2ooZK3IxbEt
         wp8FAoCiaCzybqps6VC1NkpXVB3GbfJVWknFWPaOf1kXW1k56lEvp2mPgxNjTOsAdRIt
         e54Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLhPd+90I/itR3uzu7Syxrk9Kqo+TyaKbpahA4JnSPMKDEKNYtNQrwqEy85tPwO2VQehV96Ds3nUCMomrz94b/OvLnlfiBW763EcML
X-Gm-Message-State: AOJu0YxmNZFtdXD54BuKCt7gNdI+LFhUbwvJNCFnpSMqrJ0Vo6aWoyS5
	bka2MvdgaUT9gu10RXtgkftA6cWAied81rJszFKtDTCJ+SufPw/SstYqOM9xh2VpsSAPeTSQDlJ
	t62k=
X-Google-Smtp-Source: AGHT+IEkGFHVxFI3gRZzrlJGe980Qfv7LG73mPGQFgV214HRmjJFEmkOWFb/l5SnJ8wpr5zF8KkFKw==
X-Received: by 2002:a50:cdcd:0:b0:575:954:7ef with SMTP id 4fb4d7f45d1cf-57509540de0mr3627635a12.3.1715955768236;
        Fri, 17 May 2024 07:22:48 -0700 (PDT)
Received: from krzk-bin.. ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea65aasm12016784a12.5.2024.05.17.07.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 07:22:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: soc: sti: st,sti-syscon: document codec node
Date: Fri, 17 May 2024 16:22:45 +0200
Message-ID: <20240517142245.178556-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

st,stih407-core-syscfg syscon block comes with a child - the audio
codec, whose binding is still in TXT format.  Document the child to fix
dtbs_check validation errors, while allowing later the binding to be
converted to DT schema:

  stih410-b2260.dtb: core-syscfg@92b0000: 'sti-sasg-codec' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/soc/sti/st,sti-syscon.yaml       | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/sti/st,sti-syscon.yaml b/Documentation/devicetree/bindings/soc/sti/st,sti-syscon.yaml
index 5f97d9ff17fb..fc933d70d138 100644
--- a/Documentation/devicetree/bindings/soc/sti/st,sti-syscon.yaml
+++ b/Documentation/devicetree/bindings/soc/sti/st,sti-syscon.yaml
@@ -30,6 +30,15 @@ properties:
   reg:
     maxItems: 1
 
+  sti-sasg-codec:
+    description: STi internal audio codec
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: st,stih407-sas-codec
+
 required:
   - compatible
   - reg
-- 
2.43.0


