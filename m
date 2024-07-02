Return-Path: <linux-kernel+bounces-237969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 165F592416B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A9E2885B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52141BA071;
	Tue,  2 Jul 2024 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a/j11lhy"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BED1BA896
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931974; cv=none; b=Bp0hf9liw18RjQGqP79lovQWO+V9CL8qYZSeekZ6jUCufzBnTDLglO1vtiZyrE71bV1zn9zET56wej2x0PVnxFpHrbIZNoGYHQmEad1fp/SmK0GFlDUKFrA+50Gi8B2rF15TNSaZtwItX3Lt3YB92o830lgasMa9dU3oOTdbLyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931974; c=relaxed/simple;
	bh=s2/SN+aY294KJBk46ApgAbGwP+XkttNkKRk5A23rcOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BDOeyjh1mL5OboEpM7as1QQmBSSGin1ZnYiBgFYCpvKmYTy1ix5uojMcfiA9Od0XrIisI29AlxGOQgssVgO4IXc2K/LMoRVVUAm1wiIz2kPfUBlIjrGkKCe547s839LROYHJwaTl1iibXjzLo2K47enXtiLxTgnVvOMVAgf/3CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a/j11lhy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42565670e20so32114435e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 07:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719931971; x=1720536771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cqZRZ5JDAvuLJzijPzrtSFCWbmFBLmXDFXM1EkI0A84=;
        b=a/j11lhyKrL3SQqEFkjo0RH+Ed7/lCjnDCLkuPe5hdG9mm02/gmMXC7+91ejsKP0X4
         p071mue58al6hQt3ffr4g5dOUR2XXPmb0zrtazQ7b4AovXjC15jpw4NsnPR3cEVlLXw9
         xFDcwtGuVjicYsOTDeMRvOmdXwsnY+kTFl5wliJp3rPZmEU8fPByGWG7ti/DfreZXH1B
         3R/9xfiGOqfTPve7ioTCxxauNXGEdLCAUZTXOVJVdzy8vs1C2ieMn4jHctM3+p+X0WkD
         2MgdXhdTGwiKh2o5anjc8sCYxtE8OMeiNvOWr7l3wG5/2tjFcXNGUgNlBNqjyYy89DAj
         NWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719931971; x=1720536771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqZRZ5JDAvuLJzijPzrtSFCWbmFBLmXDFXM1EkI0A84=;
        b=VYkLkcAsyI3oO56tQG7OWoVsvxW3J1fySTXL3A0kmLdYbkFAgRIqgDvMo7WMnRP3+D
         IH5htXF9jxiUh+PuhDGjGenMIzHt7M3rFH1XwvMapMQLcZHF6wkQT0XznSF61N4Puccx
         f49jdoBrw0mEmpEIH9GTJqQKu6jBvkfBCriBNQwbDeilwegSGNlt9+RCxowPGs9atO1+
         UkXPP3bOcPiHOoSAs4lMWWw4xzpn1bgR1WPS/rUOx+9uciIyP4h0DqMO9SoNnVflR6lu
         AmLIDpmH5352HU+qBCx1q1Dx0jV8FkXuCq5Ln+KVh/VgekV76lAL9xTsVu2qXtcIPwRU
         K6Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWO8EL6V4k0klz7ZTwtqaTH1uG4FimbvhIFDc4960pvSJhz93vpw0a++QjtDWDx6+Vamy0i3wWcFPjixM4TsQXdgu0ejcqmgqmdvdjt
X-Gm-Message-State: AOJu0YxRRdjB/Jx7VXoeON5542cqe4uERS0qIfZvMNNzkbWNXIwcbCum
	ikOWexSwx6kkJ8+ArUBNMFJmsI+GGBEdsI5NYRc3LNGwUMEoTFcol2aKfdDbwcs=
X-Google-Smtp-Source: AGHT+IGrmxHz8Jxtr4a4AWna5zv+DQYMBNjG5ZT83E29iudMDCAjgjL8DXgVHasB+X4Bhig1Sha5Qg==
X-Received: by 2002:a5d:484e:0:b0:360:9e8b:e849 with SMTP id ffacd0b85a97d-36774f935f4mr6734918f8f.31.1719931970887;
        Tue, 02 Jul 2024 07:52:50 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd712sm13468483f8f.20.2024.07.02.07.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:52:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Amit Kucheria <amit.kucheria@linaro.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] dt-bindings: thermal: correct thermal zone node name limit
Date: Tue,  2 Jul 2024 16:52:48 +0200
Message-ID: <20240702145248.47184-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linux kernel uses thermal zone node name during registering thermal
zones and has a hard-coded limit of 20 characters, including terminating
NUL byte.  The bindings expect node names to finish with '-thermal'
which is eight bytes long, thus we have only 11 characters for the reset
of the node name (thus 10 for the pattern after leading fixed character).

Reported-by: Rob Herring <robh@kernel.org>
Closes: https://lore.kernel.org/all/CAL_JsqKogbT_4DPd1n94xqeHaU_J8ve5K09WOyVsRX3jxxUW3w@mail.gmail.com/
Fixes: 1202a442a31f ("dt-bindings: thermal: Add yaml bindings for thermal zones")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Shorten the pattern and mention source of size requirement (Rob).
---
 Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 68398e7e8655..606b80965a44 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -49,7 +49,10 @@ properties:
       to take when the temperature crosses those thresholds.
 
 patternProperties:
-  "^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$":
+  # Node name is limited in size due to Linux kernel requirements - 19
+  # characters in total (see THERMAL_NAME_LENGTH, including terminating NUL
+  # byte):
+  "^[a-zA-Z][a-zA-Z0-9\\-]{1,10}-thermal$":
     type: object
     description:
       Each thermal zone node contains information about how frequently it
-- 
2.43.0


