Return-Path: <linux-kernel+bounces-211712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F119055E4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6FF284C32
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A258917FAB7;
	Wed, 12 Jun 2024 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbuqYZ9r"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A820717F37B;
	Wed, 12 Jun 2024 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204098; cv=none; b=r8JrWPQkxSpqcJoV+5umpXZPbyg2x3fm0DqED2fO+u+y1xol7i+0LtsszNMb0WZy44RzoaISX0/Mx3h9nggnmTrMuMctRU9PnSPfbqUr257GQwXXAbqMyYx3JZSDw+J5tQAXSMt+/MqdBy0F/mFIpML5BC+WESdVvG5tCKFxli8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204098; c=relaxed/simple;
	bh=TdnMRlY8eU1gITOGUrVoljnN7uigPURXsJ3psiHrBfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AwiQSStsFQpFa61Tj3Fwni5SaVa5t+CYiMBhSbAqMeGzn4yvLP4rZ+w8PC1FtKXW79sGBONxWAgIwTz/brBMO0JDyhcNy17TPVSP2LR2bC7BDnYXgQhD9ZXadlWl9dE2FldeH3niwyKia2Bo1vSqRZ5OXZU3Vz6DYK9mupwXoxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbuqYZ9r; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6ce533b6409so1846922a12.1;
        Wed, 12 Jun 2024 07:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718204096; x=1718808896; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tfYwhTvzmupicsQsu7JIZ1FN+uaECXqcNKkkP1OPyAw=;
        b=NbuqYZ9rIc9d42IeJzZy/HeQtj/uaP2xBw4s+fUjtYedLUDzjAPIm4Ywo173dwFZ87
         QqLkp4GOcPfVMUDCkur0a04Ll9SOgMMf0JVN99jjWZUBcsq8eIDAkRQDRbP/bR2Qfdh+
         9usFJUSmu9wxEPPY2iSTP66RN+qFuUT9dc9G2uzzY9LQUJvXrd4G8/FSgdfbQge/Ycw2
         0FtUZbG/26NDhS83y+2VbQt75Cc9kkWvlCMabrUKWTzcqgh06PJJG1rdT/Cb+N4Wi4zy
         qAw1gCYBGrsJkChml0p41a0cA3SbTyfMul8i0s++khAF6do9QHpekz6BnTy8HM6OLjpF
         Pcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718204096; x=1718808896;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfYwhTvzmupicsQsu7JIZ1FN+uaECXqcNKkkP1OPyAw=;
        b=N2ZxMOuH9dDHLBP7COduLRkOAZpBMCCb99GVzPoEV4TU2aWWT0iZY8mYEScmjvGaa/
         HOzEjNfFdRjrV7i7Pqr6lhv+Yp9NMYBodcSCXr4CaAcL1nIzC8VJkwqf6/F4S8W4/iGC
         a0Ja68+pMf2U5JZ6LYvl6GycUhsvzuhvAmuTMIE0PU8y6aRiPHLazoDp8jhrPkpw9jtO
         oxmh4PwLTixbV2aBN8gkkMA9mAOd62y9p0TqLkpXARViCSFcxykfThbAheWfuzGXxuUn
         hvm9RZFhExoAfZrH/dZ/htDcalt/5WgwwoHzwyJUIvkXxbSt5/oM0a4ofU2PfJkcyD3p
         uCDg==
X-Forwarded-Encrypted: i=1; AJvYcCVdVydRwGBckEs57d5yyhTG0q5ACZ6TSi8QsRpKlN0LranXoy2Eq0ed3OAV+IPs2tEm9jslz4lD+Op+mAvW2/Hw64QEgosCcjyW/kpKT4r3c5viYMCyyxznEhj6HEnu+RKrf2v5teV2HC5ApAzWCiaL1SiWaXzhiEmOpWahnF9PZD4PqA==
X-Gm-Message-State: AOJu0Yy2YN52vzn0kbSfanYCbc/Ppc5+Ep4A6IEHTSOd29cargfn/pEy
	yy/s69FJwAvb2nl/W3wb66W1PXSxAtQ0nYQLD38BMKnM2uxaZkhQ
X-Google-Smtp-Source: AGHT+IGWUPYM8K3Nnkcka/I8nD/MNSiEar2GaXIc7pu/h7PPkdh9SKZwgNksERpTNh6mAOSYvrCRhg==
X-Received: by 2002:a17:90b:2242:b0:2c3:13dd:fe56 with SMTP id 98e67ed59e1d1-2c4a7629b14mr2214108a91.19.1718204095871;
        Wed, 12 Jun 2024 07:54:55 -0700 (PDT)
Received: from localhost ([113.143.197.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a76d391esm1856733a91.57.2024.06.12.07.54.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2024 07:54:55 -0700 (PDT)
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
Subject: [PATCH v3, 1/3] dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk
Date: Wed, 12 Jun 2024 22:54:48 +0800
Message-Id: <20240612145448.2614-1-joswang1221@gmail.com>
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


