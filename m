Return-Path: <linux-kernel+bounces-541665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84A1A4BFC8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE73516B70D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9FB20E6F8;
	Mon,  3 Mar 2025 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBIrQNjA"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C294D20E03E;
	Mon,  3 Mar 2025 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003514; cv=none; b=gdu3J80nI0InykgLKw2ajj6mdwY6Eyjjmcuc24SavTiU7yB6Jm+J/EJDIKSXkbV6aIjwCiy5nOq4+TRcRTIg3M8ZLPRi9071yK7z9I/S/0zg0jJ2XMXXekMg9+mtxtY65btCUfL88tlLcrKCwqQdejMfGo+bYY+zf1sjTmYgGLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003514; c=relaxed/simple;
	bh=Yjs5VELuXzugavuZ2MYDFB7lDyQ6YMgi2xeSBBjSkdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txrY1ymv9qmgHPaRmBTwKhelJfU45VNQmUsNJuw1yXBpVuMvOgGhAQYd60fmDSfWjHgITA/ZK1j3LejMS00ovr5k98dEXyHCb0y5wUIrffAXeQbrUtsdTpCtKR1g6rYRuQ6S0HAPlAHBtSsQ4EcXWalil/AXuw9toF6FT1hjQL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBIrQNjA; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-549662705ffso1178048e87.0;
        Mon, 03 Mar 2025 04:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741003511; x=1741608311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZbRg4EAl+//ILxj7dao5FHZeWZVMErRSC6VDwPgGXM=;
        b=OBIrQNjAy0glP8uKNyLiccTmITUEKTMxD5LjaWzFYJN+CLZD+6hDTDG9JQy5P8MBaq
         X7yWrY7Av7pWnihjOaQcRB/tPJQV/cORVGPMpHR60ABgtZbvWgANlL6cU4jbvHW77FhP
         wN3Cdjfm5OePMaI6O8o2sA6UaeVKYBJepd1xBSohCoxH6qPSWgkcbI5jx7D9CXfNibSK
         Igl9SLViz8j5eZQ+bll/jO5Pbib5KTH7tr10sPzi5/HF2XGpZqneionJ6AC36Id7NEKI
         jaaGIgI2zGfPKmg7LUY0rln6SiZt76uCxNJrGGpvbVgpIbC2LmvOl0uAyxLo474U7ETP
         0nQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741003511; x=1741608311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZbRg4EAl+//ILxj7dao5FHZeWZVMErRSC6VDwPgGXM=;
        b=J26PZXQkE/FgJ7wqyl0CePiJPUAqI/7eAxKWVOgriYr3Y8jdJ8LCy3RsFOvHBjoZY3
         owI1DHJNlgSTvyHWsjmdGFp8aYCNWlN2Ey8AGHfBStj9Z5CzVPDhNBboegMiXtRQHEj0
         x4Q9vxVF1hkLjuzwUEtBcPDGDAqMqaw0HOhyhj/3U1193pyEWx7PE/a1HqWnq/5m+YPO
         U4yLJYF6yYEIwitb6+xXGVTYlZLMF2KUCf15e6/7akg57+XmtCa86OsfEWkGeuj9owFP
         S8OW7VyXseXSlxn0oG+y1jINmHgfxlbLs3NmM8HsobyMGtbTP1onk+Kps9sS9Of5ohex
         xaoA==
X-Forwarded-Encrypted: i=1; AJvYcCUwOMe1XjiI/9dGMmDUwY3mmE2a/7X4C3PwMidIdykzkRFnE2zykJL6AtpEdKLXSmdm5NP4aGXsOCCG@vger.kernel.org, AJvYcCWnNP5jSEHjZ9Wy6unLFQavnSWmNHtSSbIsnrZT2qEnXdXaWWxBDkG8Jx/rtIHRkbwT3cUUhhB//n4grx+R@vger.kernel.org
X-Gm-Message-State: AOJu0YxvPe1cNo+Oi7dxrSy4hPTX/jg6E7qxec+26GgpWgtCCHC3+Axp
	SRU8VXaH1DzPbTGHm0yAQ+nse/ZuIdGOqwSCPOj33SCGi8htkecg
X-Gm-Gg: ASbGncsb3hxlHYD8soWXgnxZ63SEZQ4s+bakqFcmkvfm3pV4tueckd/2kOUVf9I5gmf
	NdwymN0y+46A6H940tGGoYMdvjv1TIU55zDi5A7Vg46l/zyZYY03mekW+G2PTEF3pnRUfc8W79g
	gPzLDr4qs9qnh6+M64D/TP/ybPflnKgiq7C+rua8juzR2pAbpAJY0gnX2ffDpwE1l6I8+uN+mBD
	3JKdMTMcWsT5uluiH1qPK9KaGmFl3Uw2bFI8487et4GVIvMJrbk3HhvAa5J1RzEMy0k7Mpv425t
	h/mgoK0nEH9AKRSmB1ven8xNICvjvoncC6QW
X-Google-Smtp-Source: AGHT+IF/Q0oGm1Q9MPyNXdByKkwXSQ32YjxUslcjcvqDeHAcJMc0URzg5RQfPoQyXKBi8STKc7rvQw==
X-Received: by 2002:a05:6512:230c:b0:549:66c9:d0d9 with SMTP id 2adb3069b0e04-54966c9d394mr1256627e87.53.1741003510684;
        Mon, 03 Mar 2025 04:05:10 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549576b88d9sm869095e87.12.2025.03.03.04.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 04:05:10 -0800 (PST)
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
Subject: [PATCH v3 1/3] dt-bindings: display: extend the LVDS codec with Triple 10-BIT LVDS Transmitter
Date: Mon,  3 Mar 2025 14:04:53 +0200
Message-ID: <20250303120455.90156-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303120455.90156-1-clamor95@gmail.com>
References: <20250303120455.90156-1-clamor95@gmail.com>
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


