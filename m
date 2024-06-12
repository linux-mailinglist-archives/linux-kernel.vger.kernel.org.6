Return-Path: <linux-kernel+bounces-211782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF1F9056BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8871A2830B7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C115D17F504;
	Wed, 12 Jun 2024 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAj0nTFe"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2B93D388;
	Wed, 12 Jun 2024 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205839; cv=none; b=VRzKHCXAlueIbGxo0bgfQqbmQfFXW+WfMVP1L+umt9zsUihcfOoNa1aALK6mdo7LifgJjPOa6o4yipkS3NbtdgAsz03g+/bpt32EsNWulnp8zbplPN7DsVWAs2srCet7Ih8xDJnwV1UzRcVPr045+P1UxPEaVrQghjrZ15CG2Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205839; c=relaxed/simple;
	bh=L0TPxO2068yX+MTAtGA10ZqJ9vRLIVvBQVLw5Xen/7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OQLpAMtfHPs9tW7lrGaQHuZjTqgy2MkIOqo+ghUScDIKRQ90cRNbAKJeDpKHFgUvUjFQPCRhBK5GdE5SI6tZKhWPiIpcG/djQHEBm8Cc/fYdnTCjxOXsVznx2f30IKZ7MrkPU5qpQRpBBPXrJDS3032C/MZrfNkZJKzyi+stPpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAj0nTFe; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6e40ee57f45so1993070a12.0;
        Wed, 12 Jun 2024 08:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718205837; x=1718810637; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O4jqrH4dgrb+nT1o6H+kGr8hXgJ85CBLLo3LyaQhqJs=;
        b=bAj0nTFe/1moXXhh8E4KoeFJeELetH8jqwwMDVL7rgvDOMa/ADBpezXoOAjNjiYrWa
         1oL6xHySUSrS1uunFN7XYrukg835uHiVGRx23btR0YJVny6STt2KMf26hr3fQ+ISlExd
         zrGOkYuE3hUsrkZWq/YfdA2aN4PMTV97jnRob9pxBU8yKUUTOyxghLpKHP5eVCuGFuwL
         R+4Frte+8/8xO7JzpyEF+NJ4Djgdr45SI5uDGUpPC+giN0F6hAgtfLw30MXkhV5qsrBI
         /R/d1MGvfnQYuJwb+ZMNdr+fXgoUYbef2l8Rd01tZkYO+9oXi7EQGrCm2cuUBf3KHyI0
         +7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718205837; x=1718810637;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O4jqrH4dgrb+nT1o6H+kGr8hXgJ85CBLLo3LyaQhqJs=;
        b=P3wYBm6Hwmz49rQc0uuoa50Gk0+DHL7bfeTHJbImzQWUhx4LXzuprzX9up0nFcZ0e+
         RqoQwLijjIhAiGEwpjKr6ll44/IAPH2AOgAQX/e2cK+fT00NcCzAi1yBUI6gMNTVvNP3
         B3N04VmUkY2Zsem12vrCnXyPp6VgeOQvZ1WqDt4br66OKCVLEwSiuj82tcqWnzndkthZ
         h8wF6S87Bqo9WyOeqaPitqncECJWPlblRbEdvMAYlWHrDNQp0iud3D/KN2MPsM5dT1QP
         uooZSY9pN1+9GeQxiuwS66SA4VOrN6WIjI9nZ7dUH90c0GyFeHlaY/+nxy3jwUYScQvr
         3rEA==
X-Forwarded-Encrypted: i=1; AJvYcCXs28otatZ34LudmKhuejpv+wz/KuPg0yPggueEaz5lJnBrEyMFVDk8H5n6JoGzZq99lpVfrlieITVRdYZ7mYp99oCUbr1kjfF6+SIoEKOsuzEyacPW4MYyl5WxCWkE6MGB7yIwXsg0MLg/49nC6bC8vTjYCRa+zzIywYMvTKtS83uCMw==
X-Gm-Message-State: AOJu0Yy4euyVvQkE2wUZZwzcfGszKQarexDj4fpNKsTdHFO5TGMrkClL
	WXB0DuEDwDN7Il1JchGPCufCbKUwshLREm6CuPLRq0wmjEKyS/Bk
X-Google-Smtp-Source: AGHT+IEDmRDRXVDRwArnOlnUYRAAl2gSBdmBtEXCzIi+zGbzqhAF9o5Q24n24snscZYNdnrxP6ZWhg==
X-Received: by 2002:a17:902:ce90:b0:1f6:a96f:225c with SMTP id d9443c01a7336-1f83b60eea6mr25692545ad.28.1718205837039;
        Wed, 12 Jun 2024 08:23:57 -0700 (PDT)
Received: from localhost ([113.143.197.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71790b089sm57540515ad.106.2024.06.12.08.23.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2024 08:23:56 -0700 (PDT)
From: joswang <joswang1221@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: Thinh.Nguyen@synopsys.com,
	gregkh@linuxfoundation.org,
	balbi@kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>
Subject: [PATCH v4, 1/3] dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk
Date: Wed, 12 Jun 2024 23:23:47 +0800
Message-Id: <20240612152347.3192-1-joswang1221@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240601092646.52139-1-joswang1221@gmail.com>
References: <20240601092646.52139-1-joswang1221@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Jos Wang <joswang@lenovo.com>

There is an issue with the DWC31 2.00a and earlier versions
where the controller link power state transition from
P3/P3CPM/P4 to P2 may take longer than expected, ultimately
resulting in the hibernation D3 entering time exceeding the
expected 10ms.

Add a new 'snps,p2p3tranok-quirk' DT quirk to dwc3 core
for enable the controller transitions directly from phy
power state P2 to P3 or from state P3 to P2.

Note that this can only be set if the USB3 PHY supports
direct p3 to p2 or p2 to p3 conversion.

Signed-off-by: Jos Wang <joswang@lenovo.com>
---
v1 -> v2:
- v1 did not add this PATCH
v2 -> v3:
- modify Author Jos Wang
v3 -> v4:
- no change
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 1cd0ca90127d..721927495887 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -242,6 +242,13 @@ properties:
       When set, all HighSpeed bus instances in park mode are disabled.
     type: boolean
 
+  snps,p2p3tranok-quirk:
+    description:
+      When set, the controller transitions directly from phy power state
+      P2 to P3 or from state P3 to P2. Note that this can only be set
+      if the USB3 PHY supports direct p3 to p2 or p2 to p3 conversion.
+    type: boolean
+
   snps,dis_metastability_quirk:
     description:
       When set, disable metastability workaround. CAUTION! Use only if you are
-- 
2.17.1


