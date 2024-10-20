Return-Path: <linux-kernel+bounces-373406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3559A5656
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19301F223AE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E6E19D08F;
	Sun, 20 Oct 2024 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3f8LfTZ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F56819C57D;
	Sun, 20 Oct 2024 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453256; cv=none; b=hMQ+k9xe7HxxEb55O/hsUebjZSQsqK/zvF1GqMRbELDXe+4rLYwqQEc4ekEW+X+ejzBqKm676IhIJT4YF02EcPEe1wLfFD6rDbEuo+1+hXnzCCbtEllHXz7zlEotgE0q6y5pcRaQ0te/BfsTD21xYbRD7rUe9MgJC/KGpmmW9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453256; c=relaxed/simple;
	bh=819NosqfkSAbFrLKxQjmiTT7JQCrpX+fWRMXMGxsoDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PFI91M03Yo5E4sgvbrta8Nr7XyFP/LtSO+iMCRq/6uBOLWO1c/AjwztKWpMf+s3IDCdb/JZ2uN81IwZiF9/bO6JlB2SkhiNAJy6fGq+7QHe6BWyHiUrGRZ/S1PKJIMoAiRyHo/pPIfx9S5j3Hwm2sPkIxyhdnpe8afb75B1pLiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3f8LfTZ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99f9fa66fdso41532466b.0;
        Sun, 20 Oct 2024 12:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453252; x=1730058052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laSjold0DNTkgXt/1NlCSiBRhyOvYLJj+uvWIs9qojg=;
        b=V3f8LfTZQxfjvQHLsL2xvN8N1wy/14jD04IoFn8+KfpmN5dT10wvQMZXRu8PaOTyWs
         ReTjQ2WHPvOKYSDTGrWMYEcSnK593S+oin5VBTAor3RNzFrFZnDULGANSrI7xoC6l5Gz
         UEO8wsfqhlZj0bJeGSs2eBWgaFCFs4TovdGQJP7YanG1zF3AYpP4ygh+xWvKcuCsmXLW
         xgZrHqLzK0z8r8y8Oq1JY75xaA+aoc5fLM+25R4OUpfa47fDeG6c+IDMllov0zf+oE+5
         SKV1JGuoVUTupNHY3ZGZOikLnImHTA/pW5oIpm0zkjlRBazHI8XF0gXaZH2a2n60ldVt
         TETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453252; x=1730058052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laSjold0DNTkgXt/1NlCSiBRhyOvYLJj+uvWIs9qojg=;
        b=geRkcqeXCfnD6CYTlvb3Cd/TdTgPSOz1sbHuoiP3/P/X4fEA1g9FMm5Mf+vIkO+Fv3
         mYxA+rwc9afCBRQSKsOYBD2R7gYvsAYFyxaCjtH1fpXzPDvwY8QjfrzyU+1YHVWmksSl
         p0bspQglT4hcklwQjtvfbudOq4IgNC8Kn3idniFWeTrpI1SNQahM3pR9YNqBuYdmUCEQ
         x6GhaHPL5+zuCBu7yHlldAuxcMlYTBDuwKHj5GMcRRCcoSUUZuci9ozFUQNCG1rJLECW
         3S2/Nqvr5xxwWc/IlYLuijctEy1PT4CHqbtFacKyUmzxIiH7HYaro5bPyhjxl2o6HW+q
         arMA==
X-Forwarded-Encrypted: i=1; AJvYcCW2LKbgveAIO/U41OIEZyvyL0gOYT0th+axYq/zomOzY0tsH8epkll72PehTHosP46lMDIaEUlAQnk1@vger.kernel.org, AJvYcCXZexHotAIhXIFYOgZTbJwJwpGWI1M5GI/RQOLFBZcpx79v04lHn0uPL6TyqCNgzh7cN5nZQ8HWk4EIDLGT@vger.kernel.org
X-Gm-Message-State: AOJu0YypEeKdiyorr+CK2q9K7IwR76dc/BsHkytOYpoZnP3wyQCyBCzT
	PLeiC9c2TFlAnTqp0asI8F21qomtwJRqN8nPutgKQNNUnD3oXk9nd332XQ==
X-Google-Smtp-Source: AGHT+IGE5glT59qi5fcUmZCrfkdrHDdLiJBnn9D8o0Oi+aJptotj8LPh+fxAh1qKnnJ4Sf2cnB3eaA==
X-Received: by 2002:a17:907:7d92:b0:a8d:2623:dd16 with SMTP id a640c23a62f3a-a9a69c684ffmr419109666b.11.1729453252338;
        Sun, 20 Oct 2024 12:40:52 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:40:52 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de
Cc: l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 16/23] dt-bindings: altera: add Enclustra Mercury SA1
Date: Sun, 20 Oct 2024 19:40:21 +0000
Message-Id: <20241020194028.2272371-17-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241020194028.2272371-1-l.rubusch@gmail.com>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the DT binding for the Enclustra Mercury+ SA1 SoM

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 8c7575455..87a22d2a4 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -51,6 +51,16 @@ properties:
           - const: altr,socfpga-cyclone5
           - const: altr,socfpga
 
+      - description: Mercury SA1 boards
+        items:
+          - enum:
+              - enclustra,mercury-sa1-pe1
+              - enclustra,mercury-sa1-pe3
+              - enclustra,mercury-sa1-st1
+          - const: enclustra,mercury-sa1
+          - const: altr,socfpga-cyclone5
+          - const: altr,socfpga
+
       - description: Stratix 10 boards
         items:
           - enum:
-- 
2.25.1


