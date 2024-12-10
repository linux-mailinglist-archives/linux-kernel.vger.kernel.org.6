Return-Path: <linux-kernel+bounces-439026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A440D9EA9A8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905151883B43
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964C222CBE0;
	Tue, 10 Dec 2024 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lppgcg9E"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB7B22B8D1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733815943; cv=none; b=gRkirZW1ZSwvQUOUhXtp8NypWmXcVfwyUWGCIEYN/kBVmZLCYJKzh2A/rmtXUbBclI0KY8giIWucTomF29IO5BRrSUvfGeTmhzD5oWwgVay2hMeucWOV9rkziKQXcYeSqqVRQoJd6cuHrqGE4A3AGEHJcLyT29yE57odqMIJFxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733815943; c=relaxed/simple;
	bh=hsirGFiU8BzwJ9k9bRXj/aFU0gO5K783nFnr1XHXDe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X47Xl5nUVzSik8dFwKoapJf8DzfUxqDuGK+KSXfE4xTQusPvE5uhHN5zygqyVZxV83so117dffQ5pJt/cjiR4/hP+D5vixTc91LfNdIU/W0x8px1+iicJbI/ejxSR97erPWnHwBKZqwH+8qTpfGBtVeMolnK8+UN0BP99ztQgGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lppgcg9E; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2161eb94cceso23072655ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 23:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733815941; x=1734420741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fU9h1qciZfo1eCFrj9RBOWdEPoZjJk9V1VI96TtLyqU=;
        b=lppgcg9E3wpJVG8vWlDCF3+oOe0ZFP9+e2+dkAGLqdwpnRp/a9Czf7o6P4VqnTQpqM
         wNcox/86N2wR+8S9IdkuDWepzl6qXBG0BkpOmEAC5SLbX+ahxGTHdgyYSB7rwKWgdyMc
         E0kwS23XrCdplorg3eDJ1mFoGBaZ0ttr7vDSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733815941; x=1734420741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fU9h1qciZfo1eCFrj9RBOWdEPoZjJk9V1VI96TtLyqU=;
        b=RVGfF4PEN+Wlebn4obouVA84RsDzWUx2jtPnaO2p8VYGJBL/8QZydlz/CvuIqX7OGI
         32WPjevmjKkwSydFfFnx111IGSNHsRa3BhibVIWs0sYFcwPUlACASQnmlIZh/KNQDpvt
         rXeXEWQMwYFbw43bgPoBByPlXw5fZCNmMV20d9DLgZvMAuAOCXT+t8NZVIgnqM5eiXZw
         vo9i6YDqQuUXqWQSi1IU3wrI+nfuWFwwlRmuj79m4JNydgf4JWMp0llr3TBH1tjCZJnt
         DmTGdS1/4+YZux7EHsT+/27U+d/36oC9yorn0PiWMz2wYL8PPD9HeKrhS4GdVbIqtIvW
         6yfA==
X-Forwarded-Encrypted: i=1; AJvYcCWsYm8z+RDrm6ZucO0X1Ws7TnW16ITaa73e9WPMRnXzsOq6Pyv+9Yz/rsuKlmGmr78Z0cztFKK9abNY+pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycSiW+7qfOjQs1/HWSmppfyCwm33THDdpM7+MwQgBMSxRqYfkS
	ebaqL+V4Kntu1HmOLtI4/gL59zwLzVf4d5Bj5l+STart+NiCbU0T1biL6QASNA==
X-Gm-Gg: ASbGncvkjx2zxJ94iSUBhhfctQVppiKD7uaXK72RUVSk67MsmhuaZHrF9WpuVUcGV6O
	EUsSuIxyDI20fgE9d/ei9/fnReNQCctkkoyVkxYDXmCVpK1nOL8H0PkFgz7k4hyRoqlmFrVA6W+
	9r+2d7/tj2VEAB9eBbVafVn7mo9KjVsbIqsUPmAHUQZi7x1a4vErEx7oJbXwhqgGARdsDyvpRWT
	Xi0whDZSWFXKXZPvmM4zY77V3ymaiN9n1LGX2pGW5bOgQxGQL+QcMQ4GdEboB7krZXiyy3m
X-Google-Smtp-Source: AGHT+IHPmON+PwbNAPPZYDE53KwGnbvTApGQhaNGbUZe2uB605PBpV+ZcftSN2qQ7es0oLZxPl5QBA==
X-Received: by 2002:a17:902:ecc1:b0:216:3876:2cff with SMTP id d9443c01a7336-21638762fcamr152395915ad.54.1733815940983;
        Mon, 09 Dec 2024 23:32:20 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:89ce:2db9:f7d5:156d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f09146sm83693295ad.199.2024.12.09.23.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 23:32:20 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wenbin Mei <wenbin.mei@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Document compatibles that need two register ranges
Date: Tue, 10 Dec 2024 15:32:10 +0800
Message-ID: <20241210073212.3917912-2-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241210073212.3917912-1-wenst@chromium.org>
References: <20241210073212.3917912-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Besides the MT8183's MMC controller and all its compatible derivatives,
the recently added MT7986 and MT8196 also require two register ranges.
This is based on the actual device trees.

Properly enforce this in the binding.

Fixes: 4a8bd2b07d88 ("dt-bindings: mmc: mtk-sd: Add mt7988 SoC")
Fixes: 58927c9dc4ab ("dt-bindings: mmc: mtk-sd: Add support for MT8196")
Cc: Frank Wunderlich <frank-w@public-files.de>
Cc: Andy-ld Lu <andy-ld.lu@mediatek.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index f86ebd81f5a5..0debccbd6519 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -235,11 +235,19 @@ allOf:
       properties:
         compatible:
           contains:
-            const: mediatek,mt8183-mmc
+            enum:
+              - mediatek,mt7986-mmc
+              - mediatek,mt7988-mmc
+              - mediatek,mt8183-mmc
+              - mediatek,mt8196-mmc
     then:
       properties:
         reg:
           minItems: 2
+    else:
+      properties:
+        reg:
+          maxItems: 1
 
   - if:
       properties:
-- 
2.47.0.338.g60cca15819-goog


