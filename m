Return-Path: <linux-kernel+bounces-325149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF0A975597
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CF28B218B6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4A41A3AA5;
	Wed, 11 Sep 2024 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ClJSpsz4"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787831A38D9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065313; cv=none; b=XzDp2bZpff+Vl0C02F8nyzwM7R1Xw80BTah86JItFTmU6vwsTjy20lSyzA2Pu6+agQBP6iObkWC+aAGNQgirTXi662UHi4ky0DwqYOX0Acf6jxOaQkceDG+UCngaUP9OOXpcodx+91TamadJO21IjDtTl9GTBQAqx9hIg20pTEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065313; c=relaxed/simple;
	bh=r9BppIE7R66P1TIPMWs++sO3aD+nAwDYSw3lqZE0RcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7Q2Ztd+nSPdBEAVEQqThGrlL9O0N5zTWMFxYkWsJ3JTbMq0vwlHqtWkCJu8nVVsoF3aOEAUJ1a9B+HhSbYoqb53mOU5+dJikc3997pctIg/bplHxFNxy/310hTZ8FOc7OskIvs5ZX18tLs0e5PWs6tbx0dfmwlz1hq88adjgzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ClJSpsz4; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e04552579cso1581238b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726065311; x=1726670111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnJ313n4mu2c3Gv27Gu48uhKalN/G5CTdU7jzWSbSxk=;
        b=ClJSpsz4iCAbOPqTTGo/j8/4xLR8cnuCvI7MS+oYQTYsIx7vdBFtohn1/sLsmWakeT
         /XljqwWB9I9VBZXuamHpGiWcbFnZnfzykooqQynqysOuERoTdlCjy0w4yC5JFwq3AaKi
         noQhvSjYZZ8zb5/2WH2H2GAb33Va9FwdQ2fkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726065311; x=1726670111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnJ313n4mu2c3Gv27Gu48uhKalN/G5CTdU7jzWSbSxk=;
        b=fPwzGyyH9Cz82nQKYbyQM1M4J/qP+NRQm/n2KjTQONgOrZXv8DxY7Asq90/EYPKqQ+
         /i2t7HUymvu+1by1M7vKh2PaVdQdH2X3CQY8sLegRpgr9COjH/3x6HTaKvHtDyIS2rOV
         kwdEGkO5cdgPcAEuxSRAriKtk5zBsLcEQRsjlY1Y2W64LlA+SEUPtBMm45x6b0NnggTD
         JQJWKlaE50JMcAuk19pEXGuVRXGVEp6j7jm7RlAET3L4uQw2XJ+l22ox7cAN7It8dllA
         qnaYQoIJvt72BQ8h4u/HYhbZncwtcn+KUDoHVoLj1aoyTiESSOv1nOqvAkDSxJ/4DoAW
         i8TA==
X-Forwarded-Encrypted: i=1; AJvYcCXFtFxKs3NVF9Furq+HTx26n7YVnCTX57WyHIrrLXpHHHQeLtrSG8oIfIJK4LuDRqRAf0K28MzDIECuwMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuUiEqFiCl04x3Z+rtVeTYZp+MMqSrFaLyZv4DnVWbxn1+Ry+y
	ZqsqnizwWmPqTgFAEnrRCmM57YgbXzMWGJNHAU3ygbv066F2ujeIk80IplVOxQ==
X-Google-Smtp-Source: AGHT+IFMamFHGmhxPFHOGWER3aFhQ1jLAPCLcwDI6yIOXvYykC7XUTDUyt75MOdeg3LnVxx5oP82RA==
X-Received: by 2002:a05:6808:14c7:b0:3e0:3dd9:9053 with SMTP id 5614622812f47-3e03dd994bemr10549858b6e.11.1726065311408;
        Wed, 11 Sep 2024 07:35:11 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:102f:d738:6069:fd4b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbb5901sm46620a12.24.2024.09.11.07.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:35:11 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 1/8] dt-bindings: spmi: spmi-mtk-pmif: Add compatible for MT8188
Date: Wed, 11 Sep 2024 22:33:54 +0800
Message-ID: <20240911143429.850071-2-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240911143429.850071-1-fshao@chromium.org>
References: <20240911143429.850071-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for the SPMI block on MT8188 SoC, which is
compatible with the one used on MT8195.

Acked-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v1)

 Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml b/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
index ac99883a3f29..7f0be0ac644a 100644
--- a/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
+++ b/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
@@ -25,6 +25,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt8186-spmi
+              - mediatek,mt8188-spmi
           - const: mediatek,mt8195-spmi
 
   reg:
-- 
2.46.0.598.g6f2099f65c-goog


