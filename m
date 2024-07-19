Return-Path: <linux-kernel+bounces-256954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EA3937316
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30EA282359
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 04:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1AE36AF2;
	Fri, 19 Jul 2024 04:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cUMJnpS/"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7012A1C9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 04:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721365116; cv=none; b=GxeYNhUZ4DniUpiJ9KNtJz68Oks+oOrHAqm4lM8Z3yiPRwb1h+uglS6msPMITykq+wGl4e5Gl8YCohl/4y8+4PsbfjCC94Sw0OZRM4jzXf5unGEyJies10KusNdA24+C0QyeNFc+OM88jr8Cgx5I5v8E58Zy0r1pyur7PmobLP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721365116; c=relaxed/simple;
	bh=5grUOfL+eh719ngtKJNkvdJNeKiogylOPeMvpQawcDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VmdUjENG8q/i6/4v54oivl1MGOnSJHPlPXrCK5xVsfqB2r/No11oEHgeUJ5mLrvof920wUpebSloNI9nF0N5BRptLr6k4zpEg5Nw2GE7APbNpkfz+hAYPVJZHWz+OrEmZolPiudsFLPxkKAk+3SfPsLHT5zFU5EmZoPdr/0CRc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cUMJnpS/; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c9cc681e4fso855917b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 21:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721365114; x=1721969914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HvPAyIWQtNqLx7WUlcX5/vDSF7IPzDdVVmoFWrTiQJU=;
        b=cUMJnpS/0gWmzD4Q3+mcgCwiOGe9Dc1OtOhIjXRYovVCCUY7I3VYCn+gnm7Xno/JV9
         1wu7acjXYpSCJIUDO+2nf91MHKhP7xhX9wET0uzUXQDejeGWMENYsV8HkIcpL91msBdO
         NkEvDrI2guvRGI6sFod2e/+1kAGYYBB2fdvkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721365114; x=1721969914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvPAyIWQtNqLx7WUlcX5/vDSF7IPzDdVVmoFWrTiQJU=;
        b=JEk90mKs3Z3GAGZ/S4RDIzMSGaPJUm/KL2AIcQ4PV3OGeeRgZEw01cc1Du7moSkh80
         CdzFVRgdVQxjbVcAO2J3lLj0snvoCvSiVh3iut8yUUKYVnVQrjxM1F6LS6xN8CoNIPqn
         SvKtSueygewwjo/JsNArO4iK/3Co3OKxFp1g57fIhnkHgExATIN956ygUenmZd/7BPXL
         e6MBNeQmsWujhhrTzEra/HSkR+geQRYdihCVCxevg+QGS9pSqdabw0D8pxGXqhRyfF0H
         I7U7oDHrCTlsm6/2ma0pHi/VTKMoOy7cUv35+JQpUb2UZJnfY/pL/fmgQUTr+PwPGBBc
         0fGA==
X-Forwarded-Encrypted: i=1; AJvYcCWOC4Dd/teVtJXabkXtKiCa5KLqq01g9zJdJiqvcXxpda1FU6iQ/Ni/hJt9gyHF4Z1gRUyrQ46xL8WKovfsaqvUoUmXOwzAtyGIzWjJ
X-Gm-Message-State: AOJu0YzL5CkEp1n33V7NDHWHbCULfqJZfC00S/pE8oWE+JpiDrKqAwme
	40Bt4nrjz30A/twqRxuuqS3kR5Hdj/CyQrWjxEg2fNXvdxyjytFdCoRzamBwCg==
X-Google-Smtp-Source: AGHT+IGpiUr+CwP2dyLNoFMb2Gyi+iGSCs3Az6ihXhSH1HtJoGXSvzeVXRwA6MyZOfyivrJ/f6qmBA==
X-Received: by 2002:a05:6808:300f:b0:3d9:dd2c:f1e3 with SMTP id 5614622812f47-3dad521abd7mr7316927b6e.25.1721365114323;
        Thu, 18 Jul 2024 21:58:34 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:4760:1d59:4f13:7c6f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79db9fc1dd8sm422310a12.84.2024.07.18.21.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 21:58:33 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] arm64: dts: mediatek: mt8186-corsola: Update ADSP reserved memory region
Date: Fri, 19 Jul 2024 12:58:04 +0800
Message-ID: <20240719045823.3264974-1-fshao@chromium.org>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corsola firmware reserves the memory region of [0x60000000, 0x61100000)
exclusively for ADSP usage.
But in fact, a 6 MB "hole" of [0x60A00000, 0x61000000) didn't get
assigned to the ADSP node in the Corsola device tree, meaning no audio
tasks can access and utilize that memory section.

Update the reserved ADSP memory region to fill the gap.

Fixes: 8855d01fb81f ("arm64: dts: mediatek: Add MT8186 Krabby platform based Tentacruel / Tentacool")
Signed-off-by: Fei Shao <fshao@chromium.org>
---

 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
index afdab5724eaa..0c4a26117428 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
@@ -169,7 +169,7 @@ adsp_dma_mem: memory@61000000 {
 
 		adsp_mem: memory@60000000 {
 			compatible = "shared-dma-pool";
-			reg = <0 0x60000000 0 0xA00000>;
+			reg = <0 0x60000000 0 0x1000000>;
 			no-map;
 		};
 
-- 
2.45.2.1089.g2a221341d9-goog


