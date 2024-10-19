Return-Path: <linux-kernel+bounces-372922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4385C9A4F49
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 17:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41641F2137B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADE518C011;
	Sat, 19 Oct 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU5JBzWi"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A94188A0C;
	Sat, 19 Oct 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729352452; cv=none; b=B7xDKMfL+iZKYL25pMJmm639JvkTW/dleYhGdp4JEMp/h2Sh6W52Rs1W+5hXJfPDYGKZ8yktxWwa5od1MZqvKJGz/0fWJmLB+GRoPNWlSxna28jaKP5+rIPPd6aFcH4BHKJYdgcfZP6mVEGO49cOyILybkFuKNMGomM6SsBCo18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729352452; c=relaxed/simple;
	bh=Ox+0thN9kPglPoXsy/wkj2zaKeHrfkwDa5J9akhvaKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jWM219yx7x+DA7w08ltK6yK0JCdmDXy7msSifBKl9oZp4G+nNddbQGOq4l05cWSv3TE7spkEK86/1cP7MVLwBnrGNJIVt+hvJhmuoaet7NBW0Y0JnssCpMZ8dNSHIl3u+RXoaQW5+Wcpdg9kuXPDVsF684/mR93cdgYbMkCP42g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU5JBzWi; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso2204755a12.0;
        Sat, 19 Oct 2024 08:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729352450; x=1729957250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UeYHqkho8rJuBl15lMa0XKA7XOcPhhBBEGYMU/dbg7E=;
        b=PU5JBzWixWGuUjamaK8NkgWky0Ut4gCoKJVEAmw8QzWu9FiAq9j9GyPmdMnC99e70j
         ipjo4lG4Ur8HYH8NikSsTcvxrvUEtwxKbohdW1NdRxPvrj/2liCNxn7G1gM+mzZGT0O/
         HOhXBJY+CWsfr6iQ4T1fHvHLEHls2doo2+q4ovFZsPEFXfrbcNWYWAirjCBwdsE4odVF
         BmYFgJOsrS1FroYezEGKI8JCVnKC3VAxneNSI4cojJGoqmFFzQXSXfycTd8bEMTbScfW
         se3eHSgIjwKtEP9DcT30GWHiWnwKZa9kT/AUNjy7+M+0eAY4WuquaS3N9Z4/nbNghrkS
         XIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729352450; x=1729957250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeYHqkho8rJuBl15lMa0XKA7XOcPhhBBEGYMU/dbg7E=;
        b=O5mGgYkmzI4sYZE1f02ZnN0q7uRHgJbk5EDGWrXgYVDXgF9Rmixp+BKdPBmlKXZubw
         +adxIPtcvqKq0d6L3VQs3f+d8lMJ3n9i8dWsaqRmvVvO1NHp5RMXfkwxdH9KpCka0B4l
         Mh8SFXETXEQb0ojF8TMxlifOjkYmVePzpp3LleWTe6yUMoCNCMR9uQYHZWWzMmmE0/UO
         Lto+rl3ItPnKR2bIEpVYrOC8s0zJn1owQK8oYDDFZ9I4pepQi2/9ZuJyKG+UgfDf8L+5
         v0vm5TMksWQcaeuNao0bK/6wxFH4BxP4Q92RM+WG7ONK5qCX4pBo105wrR25z9ZNFoFf
         TaHw==
X-Forwarded-Encrypted: i=1; AJvYcCUmAPmZNBvqN/5xrzu6oHYdjurqIN9QuVr6jxpEspSEBr33aa5ySMgWldL+tnZ70r3i+jhOWXQlUPq5@vger.kernel.org, AJvYcCXsbYCZloCHmhpKvPAPUFxoYIqFzoaQXqJTz+WM07z04qhwRaoduMzbib0k4C04BAeAv3eevr9AJC9PQXoD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9pB8cQn+WWOXtAbTZpCNWb2nrnZxW/B6Iu4w0xpsXDM8epL2z
	WCrpIU/yohfY/IyYIsVzSNachWExvP3BaA10pIqR0lXRhzEZdAlK
X-Google-Smtp-Source: AGHT+IEBLE0HR+usOqrbO9kqmBEVegE9Oqw6rqhuhItCAFZ0cYTpP7kQzhXZDecSoyRM44YX4GcfwQ==
X-Received: by 2002:a17:90a:e387:b0:2d8:8430:8a91 with SMTP id 98e67ed59e1d1-2e5616e69b8mr7743161a91.10.1729352450192;
        Sat, 19 Oct 2024 08:40:50 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55d7ade96sm2781319a91.1.2024.10.19.08.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 08:40:49 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Sat, 19 Oct 2024 23:38:04 +0800
Subject: [PATCH 1/2] bindings: ipmi: Add alert GPIO enhancement for SSIF
 BMC driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-ssif-alert-gpios-v1-1-483eee5f99d3@gmail.com>
References: <20241019-ssif-alert-gpios-v1-0-483eee5f99d3@gmail.com>
In-Reply-To: <20241019-ssif-alert-gpios-v1-0-483eee5f99d3@gmail.com>
To: Corey Minyard <minyard@acm.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Quan Nguyen <quan@os.amperecomputing.com>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: openipmi-developer@lists.sourceforge.net, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729352444; l=1060;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=Ox+0thN9kPglPoXsy/wkj2zaKeHrfkwDa5J9akhvaKY=;
 b=kU+lBaa0FelMbNLd7IpLSp/VudEMLnENj7/AG7MzIPWjAjUQkoJVymsT1QBJNjDLKBNS7gGr8
 XCd5d0jNuUdCJnpvMurroC2pUdsBhIo9Ant4UVslZY+G4M8d/USd/H0
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Introduce the `alert-gpios` property to define an alert pin, enabling
the BMC to notify the host when a response is available.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml b/Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml
index 02b662d780bb..104283fa851a 100644
--- a/Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml
+++ b/Documentation/devicetree/bindings/ipmi/ssif-bmc.yaml
@@ -19,6 +19,12 @@ properties:
   reg:
     maxItems: 1
 
+  alert-gpios:
+    description:
+      GPIO pin designated for SSIF alert, used by the BMC to notify the
+      host when a response is available.
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -34,5 +40,6 @@ examples:
         ssif-bmc@10 {
             compatible = "ssif-bmc";
             reg = <0x10>;
+            alert-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;
         };
     };

-- 
2.31.1


