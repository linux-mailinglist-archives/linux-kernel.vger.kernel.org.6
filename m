Return-Path: <linux-kernel+bounces-199158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409D28D8338
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0457283BDA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A574A12EBF2;
	Mon,  3 Jun 2024 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJD2rqM3"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9548F12BF32;
	Mon,  3 Jun 2024 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419616; cv=none; b=EJgJ6fHenmvE1bR6iILfTFyvAqxAJs/weGVF3RjqoqoJMtOlOFNljj0Ins6DSPya+4xSM6Y0ZCA+yMHsgtTR4kPxcBUswphXqXQEmtEeX0mjpDDlUFMaGaqk1jrYHBCLu3oodYOmXMyVNIsAUZgVAMjx+sIlzvfuE0tIwsuWgkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419616; c=relaxed/simple;
	bh=k2wgTL18kuSKqyNl5dkcq1HYWU5kQFEoQcxxyP7yN6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Mp6DusrHpeGzWtVGF9vp+t/WYCxBlTbCEma6j8+hwxjqUNVhJSYuY2NDxR4hneKT6EswXTbLs4QEhs9eXitjYwyHwbZDr7iZ7XdHaDZ6hdhNQiDBzPe4fzodzGV+cEF43+JFukG3wskbq1Qozo1G9F/S8X0h/Ckzbb0XZaOAzk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJD2rqM3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f6342c5fa8so22089135ad.1;
        Mon, 03 Jun 2024 06:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717419614; x=1718024414; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H53in9T6bqMlipskp/q0AgS6bzBlQnqYSzHHwGRdlB8=;
        b=KJD2rqM3G2SLpoM6VGFf/+EuKNU5+2plmx9QzHLyj4thpKntdh9hMD68Hbu142O5Pn
         H5jzU/E40f9SDA0MgL469xL3YRRQ87AmN7W9+zVENAS/tS3Fb2BZigr/zuuVKl7mak0F
         xLaV3BcDXkyIxAxXfm5zfOE0TTRScCLPGxGVtuAzrwEf6XlHwTXu1x493slKW+wgvwtv
         z47nOFS0huwNF4cR5gklnd5ye6DT6iN++zxpXwv31B1k+I/EGY5ISlIlu7P+rntyRytE
         1c3QWKzAfr93pY6EMKB6c9Cj2pGFcImwalneUsDYFqr8+lEgDTaZpZGqYzCv0vbdnsPQ
         l4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717419614; x=1718024414;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H53in9T6bqMlipskp/q0AgS6bzBlQnqYSzHHwGRdlB8=;
        b=A8nJ4fJnXcmK3pz7oDE9hehLk79EEhm09Q6JrZNQTLJlTbIA8fcQKV5j5+yDSlRGd6
         6XAITSyUHgwYWk8wawhqf2zSBoPTPiJL5YYEoUphoPXIq4FMsjDcETcEnKVpjMx3EkjS
         OM5xMGLclKfNgnkAs9PteXT6GYxz+AzAdokMGa68rgvktachYEOMTCZy1ZyDjKAz/uzx
         2BrBTSRhuNqeUmgmJUt0a17On7u6lUQiS9u4o3qgCP3CpRp8Q7N6mjEiYESSaA0V6R+5
         FBUtaSr+GapJtNV/oOZwJdE7CiLSSF94cRu1VyVF8OWB2/asNz5gXr9hd7VJi8++d/nD
         dbDA==
X-Forwarded-Encrypted: i=1; AJvYcCXeeBD2dbld8W5fm8/jxgFkAKjXvsIpZpx3Ykk6Lgh0Ctg2pHZrVCJeRosEhWsuc5IsbYBcF785agqm4jvp7a+J7gY/97LQ3HmI+LBDYFXB+r/wA8HomVwMK1ppRy633tukbDVD/1ajbvjFF4PkKGr19m0aZkhfMMaWAMjDAUOtnt3Axw==
X-Gm-Message-State: AOJu0YzYUs5ApTRX5dgpWMTcLVRlYMLvAtaJE2LNsd5yKjiwM90BHBBR
	TbQhi9dsjDfH0MJvlgWO2NUOCWIo/SF2KrR0T21EdKJ/JiQXPYy+
X-Google-Smtp-Source: AGHT+IEuN+ni+k7sWZttBLUG3sRQkp0r0Le5gqTRQZF9jyJjmU1FWhgBWZslNT6ZKtaEwegZmN6ACA==
X-Received: by 2002:a17:902:c781:b0:1f4:6ad9:39e1 with SMTP id d9443c01a7336-1f6370b1218mr68319365ad.54.1717419613692;
        Mon, 03 Jun 2024 06:00:13 -0700 (PDT)
Received: from localhost ([36.45.244.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f665929689sm31205285ad.151.2024.06.03.06.00.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2024 06:00:13 -0700 (PDT)
From: joswang <joswang1221@gmail.com>
To: Thinh.Nguyen@synopsys.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	balbi@kernel.org,
	devicetree@vger.kernel.org,
	joswang <joswang@lenovo.com>
Subject: [PATCH v2, 1/3] dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk
Date: Mon,  3 Jun 2024 21:00:04 +0800
Message-Id: <20240603130004.25662-1-joswang1221@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240601092646.52139-1-joswang1221@gmail.com>
References: <20240601092646.52139-1-joswang1221@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: joswang <joswang@lenovo.com>

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

Signed-off-by: joswang <joswang@lenovo.com>
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


