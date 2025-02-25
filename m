Return-Path: <linux-kernel+bounces-530740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3483FA437B7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E53E67A9BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CEF260A2C;
	Tue, 25 Feb 2025 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeA1hMLv"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800251C8607;
	Tue, 25 Feb 2025 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472454; cv=none; b=WQ15NvL0Cu2s9zAXt4tdAcdh8o907EseE7s32SRmhOC1CzpKFeLllwFE3ckCwa1RVewwJSvwfgoXcpECUsG1MdZf+Df2jIkAqjrmsdwHlSLLq4CEXeGbAcdyZ72Xy+a+zEbRyaif4AMeoeKlv0dnGf7kyYMUm401na959GclJgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472454; c=relaxed/simple;
	bh=Yjs5VELuXzugavuZ2MYDFB7lDyQ6YMgi2xeSBBjSkdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ov0ewxE5QHIYK1GXSHmEGhve8ST54cRepECaphJmi6geQT7Izi6uYNB9ZFPY0JWoKOwSA3bou80fQ7P8z8c71dybVmngWD1ZCnvtT3JhkEYxU8ayWwHr6hHsB8nyjTnK8Xz7egUmf6I2oABQ0Tx1D8qH6UBc8cKg7b/oQoly7gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeA1hMLv; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abbdf897503so1096690566b.0;
        Tue, 25 Feb 2025 00:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740472451; x=1741077251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZbRg4EAl+//ILxj7dao5FHZeWZVMErRSC6VDwPgGXM=;
        b=GeA1hMLvLoV4VU3f8h9ZmatgRs929Wa2hcqTsqyTIcoAThJODS/LtGsQmi8csqB6Gi
         PD2m5g4J5NuD/VlNz4U22UMR/rc34/pYKgsX+XaRUy+t0AGg3TZkxtu9PM60HT1XznO+
         L0j9OZUcp54BqsqKHlCJIcuGPYtLZgwZGLYdcHE9Z1XLLGpRupVpY6OOTcNIU4dPQ6Gw
         ktQRbHfXxFUj5oS6GiUnzWld+RfVshTkGIZT+tSFeEz9aanw8jlNK+IlmJYuOkejq4mD
         7UUCDYSqWBcpJ2BvZStgJZJvMPu/i4gkCyTGhhezc+8e7pm+n2jXb77TCRBKEWaqAk6U
         ToYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740472451; x=1741077251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZbRg4EAl+//ILxj7dao5FHZeWZVMErRSC6VDwPgGXM=;
        b=gRAXa79hQqQZyBsLx5OrW008Zx/7AOb2lpi9z7rOkPmV+c4Q3qt2OITB7B6l3lypmZ
         pBdpjYH+Te1RIkde538TpavNBN1dqDi/kNFOX2TiuR1/yBKAeWX0/dJffCHkvcM+7rcN
         nkl5ybGHD+jx+lrMDrVHCGOtVhrvSgE/LFE+nOo1ZeVfI5lKIpJinpZiWkFpv2Sz/HVX
         UAQVl9xvU60Trd/AORc2/7FOPvlbYb2S9cFdyJOgWL7PRNS7A1IYsd3w0vmgE5SlmHqD
         eZcScoMYDWO2UhZ4ql/Vz8k7NP6OE0nYiwI4SlAwOmtefy3Ug8/lAnSMK1I63MOojEH3
         iocA==
X-Forwarded-Encrypted: i=1; AJvYcCUCxmQwLkiHoSUVS20rn72h/+ZiPCwIQhvXGDG3l7nFxvrPhsB+IFGHUvTZkNO14lZotfkZV33BRmbL@vger.kernel.org, AJvYcCWuUKKWuSekMEh4//MO20qR3BuwhlaygJPWbZuwQQMqfEEhZSQk1mvNha8D7l7Ro3Xf5NqMP5B7Y+BwA0aC@vger.kernel.org
X-Gm-Message-State: AOJu0YxRiluHCm4mbrGhYJJE6PL6cUOPzcvHho2vzQHNC/xkLWo+g0DY
	E49Fyw+28DRlgpRkS74qahIzHSFa20zZToafYdckG089I9i/0B7tEe164A==
X-Gm-Gg: ASbGncutVR8l9q1/W04arsC5hy+hzFSuYHaPBquNFjfI2JoJt9Sd1zES6tW05qsM2dB
	TkGmoKVJX8a8TsooyyERFSEJ9lEWzRK8u4KjB+n9h97MQD9rU8fU8nXwQQidYgkaZesh66SjuIc
	J+pcCJmxSj+OM2+fGmuPv9BAsVdGReFgLQLGFO6X5KAW83VBgfBzhhkzhJ+WqGq793USGQEpJr9
	zBE95Uj2aNJzO9Kt4I+MSjlRbKXeKYOyjVF+pAn6zaFyS0fPk9RiLn19haIiTU+m+L+XLxHIJR0
	/BXn0Ziy67iuvCeGVw==
X-Google-Smtp-Source: AGHT+IEGBF5qqkRZGyZTUbFHisgJbw5448A9giydmOMQQcC5CE642ZPcPZEgDt4yKKSrKj8gOlui4g==
X-Received: by 2002:a17:907:c48f:b0:ab7:cd14:2472 with SMTP id a640c23a62f3a-abc0b0386cemr1310102866b.23.1740472450559;
        Tue, 25 Feb 2025 00:34:10 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdbe0asm102660766b.36.2025.02.25.00.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 00:34:10 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindigs: display: extend the LVDS codec with Triple 10-BIT LVDS Transmitter
Date: Tue, 25 Feb 2025 10:33:42 +0200
Message-ID: <20250225083344.13195-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225083344.13195-1-clamor95@gmail.com>
References: <20250225083344.13195-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Heidelberg <david@ixit.cz>

LVDS transmitter used in the Microsoft Surface RT.

Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
index 6ceeed76e88e..24e89c1d0c76 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
@@ -33,6 +33,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - idt,v103      # For the Triple 10-BIT LVDS Transmitter
               - ti,ds90c185   # For the TI DS90C185 FPD-Link Serializer
               - ti,ds90c187   # For the TI DS90C187 FPD-Link Serializer
               - ti,sn75lvds83 # For the TI SN75LVDS83 FlatLink transmitter
-- 
2.43.0


