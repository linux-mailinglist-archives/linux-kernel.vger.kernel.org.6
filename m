Return-Path: <linux-kernel+bounces-423126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620539DA332
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1561816529F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1B0185B62;
	Wed, 27 Nov 2024 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuVdFAlV"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D731547C0;
	Wed, 27 Nov 2024 07:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732692990; cv=none; b=l+TmIU7sFBtIArH4sHkZX6jW95WL3uLtqYazzSDEv5z6jiGFwa//lo+kobzEt26Kmrh6ZWr9Sv+Dgh6U+P2HETwuogbRPS1Mir+kvDHIjEgUn5OfH3HvlWm1p+ETnFO4qVrnsy6u4RxPUjJtAkknbopLVAG4wObIHD0znBCEWeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732692990; c=relaxed/simple;
	bh=QpyK+s01Lxhi8NEMyuaegdg89/DBEY+s4MsxWQu0ff4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jYQZdbijvH8QqTswBA2wPJ5pggXFrcl5nOYGjFvnaOalGnxHJgXsYljrKEVbrqGRIxCEWZQWt3+pVFfKi2YNZ2CRGEp1P5aG8IKrxuqNBt2/rmekSX6SGDaHUTQ51DQAMuVyvIZczv5cOGi9mh8Db1DXcWtG5LArojsLVGxpyoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuVdFAlV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2124ccf03edso65025095ad.2;
        Tue, 26 Nov 2024 23:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732692988; x=1733297788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tb+EnpOEWqbg5iCLmnC0J7ea39+1VY/WhLbt5ileqoQ=;
        b=HuVdFAlVthaau8rEm0ZUmbupXSuXwiqJQiJB4MYwHfiN8Xk30qShKRMLd/e+PgTviL
         5uHVJlw8BBOf5UB/RiJ82s+nBeOnmCoJJgdeZGyaijZIIoI2sjz/fj+BjICUyi1XWAhs
         J/S+wDMn+Vdi+5wciMaCv/BP8SAgR/riwjFq4utl+/PxVB/E0NZozEwyCHXbZCkHFD2t
         mM+FeNcO9xzz/4Tu/+W4fRcekWTmIffMPE7WaX5N5gHeWEBYkwNY4T1npfZAXyWlF5x+
         l7km4/1f5YZIG72jkzOf1z/isjAVeCQIUGAF50lb6B275g3uYYaESeWfUSti/23T6CE/
         0YEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732692988; x=1733297788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tb+EnpOEWqbg5iCLmnC0J7ea39+1VY/WhLbt5ileqoQ=;
        b=PXR/WFlCH37JrKayzqykGdi1h6lpDNr85Vd4A1rAsHnoOgZG5TegwDOwnBozLh+zMh
         MXvozYIMsXMtFJdc/5yjTVPGTZckso2jgQ12sQZCThaGRiiBg2WSTrAGzrIxAnnETlLa
         qcPOSN8hHKqzdWyP1dmgQyZRe1DmY2MxB+MpzicVuEwV8joQOLJgSYjbeA+vzQkcsH9Y
         +/9NPFUzkYQ3DZh7L4Fr2P0XQG7SCgft6/zuqiUnMMtrLB56PjkdSn/DVfK082iZ6+/9
         ynGIFE3dIJGDLWSU5FpE1No2+zHP+rLAbswxxI+iUSFjwcj2NLryTGqqoWmtgrQuUNx1
         tdIA==
X-Forwarded-Encrypted: i=1; AJvYcCV8Kz+Fyks3nqu8mRRpVDBNMo4k4r2BvwQkahXNZ7XsbeCl9RketgEODgE72mY6rXey6Y4I7krkQUu3@vger.kernel.org, AJvYcCVwsckD4Uf+1EXWu14Ts+VjZH/quF9gEcxiE92GVp6FSdh6TkHKA3oCaMzIVCMhwCB8vL7FhJ/sH+hq9LSB@vger.kernel.org
X-Gm-Message-State: AOJu0YxLGQKCKbRij8x8LR3ujWDHWcxApS+9csp+8eKb3eDHe8Bowuc+
	MbPqBus2XMHp1Jl0Ax/DWjhyr1PsONAU6KxRjHigUpZRQTpRy2CeQep5XKZK
X-Gm-Gg: ASbGncvbhF2MpmQZXKZS0rVPRgxSUj1puQfKsX03yVYOCAL9ZXbB290WcwTS72OC8Ye
	0yNHZZmXuvJeGVVDed3IaLnmz5eKmhMIDJF+S4JRnS5AluZ/1vdxwdHjTLVs7NP57GCSGR1ZyxG
	vlwbRZLhFzRu4uxZ3TqzTilqFcir9iBFrriDbbtFn4sFaCKCGIjzmIklGPdgEgMgDe1qXJmmnm0
	6V1pJuQOFpbzGrbHWCmlr1hH3H+FnomCWreqoWpG2P9dj+9+jjgy+Z4x2UazSNw8s3LvEsG69xE
	/jrb7q3o4B4YbY68SCXvUfB2ZJVJV79GRVCbmgVxEBglbMu2lS4UN1w1CqxAJQ7r
X-Google-Smtp-Source: AGHT+IG1U89chfNV0r2N/Ys958Tsn/VJWbzzAzfyPeysRKC6V5+dBYw2Af9LPTvoIkumGYTgKdkwoA==
X-Received: by 2002:a17:902:cf06:b0:20b:79cb:492f with SMTP id d9443c01a7336-21501b63d30mr28773365ad.43.1732692987950;
        Tue, 26 Nov 2024 23:36:27 -0800 (PST)
Received: from jason-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8c645sm96597095ad.16.2024.11.26.23.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 23:36:27 -0800 (PST)
From: Jason Hsu <jasonhell19@gmail.com>
X-Google-Original-From: Jason Hsu <jason-hsu@quantatw.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: yang.chen@quantatw.com,
	jerry.lin@quantatw.com,
	Jason-Hsu <jasonhell19@gmail.com>
Subject: [PATCH v5 1/2] dt-bindings: arm: aspeed: add Meta Ventura board
Date: Wed, 27 Nov 2024 15:34:08 +0800
Message-Id: <20241127073409.147714-2-jason-hsu@quantatw.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127073409.147714-1-jason-hsu@quantatw.com>
References: <20241127073409.147714-1-jason-hsu@quantatw.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason-Hsu <jasonhell19@gmail.com>

Document the new compatibles used on Meta Ventura.
Add subject prefix for the patch.

Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 2f92b8ab08fa..98ea2b3e0eb1 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -86,6 +86,7 @@ properties:
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
+              - facebook,ventura-rmc
               - facebook,yosemite4-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
-- 
2.34.1


