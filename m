Return-Path: <linux-kernel+bounces-222393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39149100BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505AA2845CD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524991A8C22;
	Thu, 20 Jun 2024 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P+V54A75"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7151A4F33
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718876877; cv=none; b=i5sh4WA2Sf1IYh8GiYVokyWPJlSpd57erq+0b8mlAc2F4U8eZqiX4v1voRLpQGprZeXDSPC7gdKL9xUjnlOgvfcVO7Wa7pDE20frKhKvwTJsMF+PdBwPzT2Yap1h8/5DiQdtYleFyB7bhXIB7DDS73IfPstevdHHz6o25oHMIEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718876877; c=relaxed/simple;
	bh=aZLSIBDUaaXuBxbbGEuyOwyTAI34NhUgnIpR75tQM7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTxm+dBdHCkxS9B73Ylm3YrG5wB1mJtivL3/5eJenYXtOoMC+UjBLsbyna+OBciTJujGmJpRv6BzYLifOm/XRXyFdQYz7q/UZdr/ODrTZsfLDfT0qKAtguGyRoM/EbXmpkEkwUY2ilhOSROgFOkUIFfZ81ZUzKBFOixwZ8se9Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P+V54A75; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7152e097461so85808a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 02:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718876876; x=1719481676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KB2vnbw+59r77dIT1XqZt8Bq4nLOyd8kq/y1e23jiU=;
        b=P+V54A75XlFLu7TfIQhnD0a62cDRFnefS9cVebez4bDIVqclJEsinlIqVBFeE1gvBi
         XrEFs8ckDEnxh9JTZRa1Vqlo4TVNkPm66N+01yb8CHgw57x+4NxLYBIXB6wTyrhfGsH6
         xh7lUhR0XAi7XdFGB4x/Ke82blIDLv8yA2nFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718876876; x=1719481676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KB2vnbw+59r77dIT1XqZt8Bq4nLOyd8kq/y1e23jiU=;
        b=nyYwE8vCNlJw3KqFOQJSyXCgvN1bsZqxSSnMsNsxlz5K0+VFyak3nPvf4IyB43gFMq
         vHMbvrsqWwVhppnS/TiPu2vMVji4C9zMaBfNhfzPZKx2DL2eec0+R4kjNGslutl9zPTU
         9pQC9fe+8b/bvhG0OldsreRGfa+x1ix6T9+PTTiuNUzO/rSlo/YT1eGhRFQ/RlyaL/AY
         DM27Ar6DvS29/9hCeIGUj+j1ALjN1hnaNP7P9ICkxczjuX2n7uPAx5szqp2+anR8hxni
         4jhFQFugAUXvXBw1CbC18canrCP1Jb26kvo6mlxKJd//Xq4LKzWajQm9dUocL170Oup6
         owgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYsleCc1oEajTercktxoNuyZ5l7TeMRic7D1VyAD8DGyJUdFQtmx1GvUUI5wgTKpgRMutJYYrcE3zl1WkThYN0sHTP3L1KPcbozj6V
X-Gm-Message-State: AOJu0Ywj/YJuCqwrEGQaa/iYFrpmSiz14XmcGqqZdfQvIqrnlSMkJioe
	1D+WAWAveikoG4iUACHTXyWU20/ooIRMMFC7sToGo2uVTq0Os1XnBdg9IBm6/A==
X-Google-Smtp-Source: AGHT+IHlxHx3IJjM2Bl6bnv0ofbMIfZvrxY8EfKGaCgMXMCFaU6DcjSHdYJKb67N3HSA7r0ZPxljnw==
X-Received: by 2002:a17:90a:af8f:b0:2c8:62f:de2c with SMTP id 98e67ed59e1d1-2c8062fdf10mr170000a91.15.1718876875679;
        Thu, 20 Jun 2024 02:47:55 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c53a:5326:7f72:759f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-70dbae52920sm4164469a12.42.2024.06.20.02.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:47:55 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: regulator: mt6315: Document MT6319 PMIC
Date: Thu, 20 Jun 2024 17:47:36 +0800
Message-ID: <20240620094746.2404753-2-wenst@chromium.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240620094746.2404753-1-wenst@chromium.org>
References: <20240620094746.2404753-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT6319 is a pin-compatible drop-in replacement for MT6315 with
slightly better electrical characteristics.

It's unclear whether there are any differences, since the downstream
implementation doesn't describe the MT6319 separately. Neither does the
implementation check chip IDs, even though those are available.

Add a new compatible for the MT6319 just in case differences are
discovered later and fall back to the MT6315 compatible.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../devicetree/bindings/regulator/mt6315-regulator.yaml     | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
index 6317daf76d1f..cd4aa27218a1 100644
--- a/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
@@ -16,7 +16,11 @@ description: |
 
 properties:
   compatible:
-    const: mediatek,mt6315-regulator
+    oneOf:
+      - items:
+          - const: mediatek,mt6319-regulator
+          - const: mediatek,mt6315-regulator
+      - const: mediatek,mt6315-regulator
 
   reg:
     maxItems: 1
-- 
2.45.2.741.gdbec12cfda-goog


