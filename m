Return-Path: <linux-kernel+bounces-320546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BF9970BD1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BF71C218B6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 02:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BD6433C0;
	Mon,  9 Sep 2024 02:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="h1Tng62F"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6408C1C6B5
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 02:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725849128; cv=none; b=rzpjHhMjq3xFDyfy38iQTwLaO1gkUb+nrE77IF3e6ZkVtVXybxnolPYdqUsxcTve2Tnr/oROdVAF2z8yjoPeyGFfwOeLm2v0pHxQBh6hsK83bUX7ytsGRU67gSTz9pdgWdM7u9lsWFJPbxqlhJuxDOR06lKo/OlDFV+IZaAYU3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725849128; c=relaxed/simple;
	bh=OwOHhZtP4O5Aqpkmnf53b1CXrn+W1J5cN1DD0oomSmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F659TEKkDth0M4PlxrYcHy86FS0Fngu+pO6gCuiL0fLyWNrHQFNDFV/amBi1+oVifbwkSAUEnJHHcwniar8lJgJxr789PGewFIMOdad7KLQarbqqwdeoXlHbGlCvZThHgY0Uy64fkJgF8PRIj6PP/dARWQEn+bz3qgmJZ9apydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=h1Tng62F; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d86f713557so2508221a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 19:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1725849126; x=1726453926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ai6i40gtLi8KkfaAdRGfJKbTUS/9SVUXMlQmPGbzRSI=;
        b=h1Tng62F01eyKwmpTFHaRbRj4pIvvFMDpTR19GtLseg1et5T5mn80ooERnDJxbKLn4
         FTQOYxytQbR70k6JYOLpSC27NOFWS+NYa0wcPmM7ps1an76HSr/HtTyRZ1ux8XgKHQRl
         2hHwFiDdIb5inK8dBbc9P0wBoouO0a8LM2xeaGvZgE961tYt/QD7ap5M3rvCLxGAbUpc
         dmyel1nWU1csLiFtU9GvmSCYC9j0CVAq61D3AnH3+e8Trc5wXlTdcucgbpnSQwEknNqz
         f1Lfk7soRiancxeXAkxgViJnI31GufYuSKeqgh/DLFrPkkfmpCdkTk6/ux0tS2Vd0fmR
         h7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725849126; x=1726453926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ai6i40gtLi8KkfaAdRGfJKbTUS/9SVUXMlQmPGbzRSI=;
        b=X+gbAOgmIvVaK6hNANEbjb8yHmeW178hInnWX2k+V0Vtc8qGmTish4bcI9vyCc2dUz
         Tm0DtPZ8StdZQZXlcYG3MLrrnpyxgCTWeMAojmGmll3ByYNnOCPGv7Gy9j6PFXG12i/v
         ERk2VC2TWGeXXL/aeyIc3aFP52mp62KTUUgay2+ucXROxgCfraVCzaypWrhyAOMr1L8S
         hayTjyfOq011qG4Oo4IUgGOUW34ho0A5IxXwl/6sIU52MlwSD1ugU+IJbFr5FOc9FPfS
         AZMLEA9TDHM02MUqDjSrbaeaI1pEayIEhAuqH1fJiJuOE1U0YX56TnIraKKlhIizjwO8
         /3iQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4/L/osd1WXsVlxa5+MRXKVU9OYkTC/Fp8/RJAtf1S6mG7Ti7ps+yvLArGSrWWvDNR4fWKVjVhCGmec/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdMvFHBExPGCBpJ1LyCW9gJYk9t7I9T9CqKOWAq0ZZKmbwT3wa
	MEJzeGivL3grpGUpFNNo8Uz31hIK4JiLfYbOe7DqU8em6iRBXK6PJ4j4sw5uM2A=
X-Google-Smtp-Source: AGHT+IGgNx7WABZhDETOCChw3HAPeP3YssU06NrA2tHr9bsZ2XDn3kY71U0vqFahzzAqH5lBWek1ow==
X-Received: by 2002:a17:90b:196:b0:2d3:c664:e253 with SMTP id 98e67ed59e1d1-2dad4ef6033mr13296275a91.10.1725849125363;
        Sun, 08 Sep 2024 19:32:05 -0700 (PDT)
Received: from zjn.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db049873b0sm3323645a91.47.2024.09.08.19.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 19:32:05 -0700 (PDT)
From: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
To: hsinyi@chromium.org
Cc: angelogioacchino.delregno@collabora.com,
	cengjianeng@huaqin.corp-partner.google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	hsinyi@google.com,
	knoxchiou@google.com,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	robh@kernel.org
Subject: [PATCH v5 1/2] dt-bindings: arm: mediatek: Add MT8186 Ponyta Chromebook
Date: Mon,  9 Sep 2024 10:31:47 +0800
Message-Id: <20240909023148.1677936-2-cengjianeng@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909023148.1677936-1-cengjianeng@huaqin.corp-partner.google.com>
References: <CAJMQK-imYrDTuycVzQxkfbkZuHehE8uwc+qS2w=UDShETsBvEw@mail.gmail.com>
 <20240909023148.1677936-1-cengjianeng@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ponyta is a custom label Chromebook based on MT8186. It is a
self-developed project of Huaqin and has no fixed OEM.

Signed-off-by: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
---
Changes in v5:
- PATCH 1/2: Remove sku2147483647.
- Link to v4:https://lore.kernel.org/all/20240906085739.1322676-2-cengjianeng@huaqin.corp-partner.google.com/

Changes in v4:
- PATCH 1/2: Add more info for Ponyta custom label in commit.
- Link to v3:https://lore.kernel.org/all/20240904081501.2060933-1-cengjianeng@huaqin.corp-partner.google.com/

Changes in v3:
- PATCH 1/2: Modify lable to label.
- Link to v2:https://lore.kernel.org/all/20240903061603.3007289-1-cengjianeng@huaqin.corp-partner.google.com/

Chage since V2:
- No change.

---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 1d4bb50fcd8d..43a824bee1b6 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -257,6 +257,16 @@ properties:
           - const: google,steelix-sku393218
           - const: google,steelix
           - const: mediatek,mt8186
+      - description: Google Ponyta (Custom label)
+        items:
+          - const: google,ponyta-sku0
+          - const: google,ponyta
+          - const: mediatek,mt8186
+      - description: Google Ponyta (Custom label)
+        items:
+          - const: google,ponyta-sku1
+          - const: google,ponyta
+          - const: mediatek,mt8186
       - description: Google Rusty (Lenovo 100e Chromebook Gen 4)
         items:
           - const: google,steelix-sku196609
-- 
2.34.1


