Return-Path: <linux-kernel+bounces-321254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C7B971676
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB9C28299E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8D21B86F3;
	Mon,  9 Sep 2024 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ecDAWjIn"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06AD1B86F5
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880688; cv=none; b=Z1ldlCk8D5Jh+cHwL80mYMlHqz65azn5qye4hp1D4jxg7An0Nlm4cH7L+S3qqbKZ5cOBJBnIi7rkuvYaNmiMCAs79K8Zd9zyjnvFSKjacb3h3jesQq2aEpq1iJaOj4GvNrvMr19pHc8BmhkC0n/TOWDEHk34aWNiXhC4QGlyrjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880688; c=relaxed/simple;
	bh=JEpAwMhJHIRZLG/U57b8gcPI8NCibdGpWsCEG3Eoi2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dg6MrqcGUMTu4WjQ8mzqW4IfctzMuIdxqFpml+y1Uhj1fYqDbzcTBQcdc0bYNZXiMkbEf12SBjjFTwxOw/rWOJ3klex0DShHfjeTUUyDSF7wCu1yE7uW5ztJdDDBFuPU0UkVIqH8Q5ZEQR0h9pta/pXnq2c1cvju+TeM5NPmYE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ecDAWjIn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2055a3f80a4so30317815ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 04:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725880686; x=1726485486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6ySKWEzCsAiAa/TsjxPZ6peBrSGtqkTqiQKSlr9U20=;
        b=ecDAWjInYTdLpqnjD4eEXUxvLZLy/Njmk543E9BA9v6Yr47+iusSE+NMqXPsTAfd3s
         Nm3/1HhAOKGxduW3JfN0V1XtvAVnRFKCT3nyY6ZRfCKxchYG+jZCmKan1SAx+14rftjT
         mBlxmvN07oe9xIl7yD442J5XB9Ieou34WKBZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725880686; x=1726485486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6ySKWEzCsAiAa/TsjxPZ6peBrSGtqkTqiQKSlr9U20=;
        b=FCnDDPTY+gz0cEn/9ZsOiSJxdddEEYwe4Rn3g63ErKS/eXdCjfXdaYv8yZyxwOIxcE
         QyQL+bD3DRrEWUPM4gaEER+Fqt0FXOre+hF5KTGkVKPo5twzmdL1d7Qj9omNCphXeDu9
         rVR4wUmhK/B6jTyg3BMXGAfwVWghBZmfJxb2zbOnpW/JVIYVRiNYdy+Qh67sUK+2Z+8C
         k/QwL5dRR17ep9otOJjrwlW22NCO60rHKDxbJLWxm6QUIDnkoosdRF3zimxJ0NI3VggU
         /sIBa5kF/snIScWQ37SDqdLIIlgZNHKdNS6fq0fzuXO1zai84YzGcnV4ej4Qld7dMCd8
         5MtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0vr7AwoKQ9tAzTgj7GUSRVbqbCGm6K7AYnQpWGsttrqmzoHE1MwGZdSqyzn4k6Co4csQ+tNfBxxlks8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwefpT7q5gIg1hpB4FdL4lOrWvjPXUH8S54GwC8j3CwDRjhGoDk
	YDX+yAeV+toN+K8TYAlZvSlQ7zHs8C+Fcz7Qj+p4e2rrNYaxTjfS2yEsPzdlkQ==
X-Google-Smtp-Source: AGHT+IEtPOD3nWUNQpY+7PlvHwLnD7f1Wes3G0ale4Gg3bhBQDbwb+Q3fTCcQ8bAAZ8Ozw65h4c4OQ==
X-Received: by 2002:a17:903:1c5:b0:205:8b9e:964b with SMTP id d9443c01a7336-206f0612c09mr132152285ad.39.1725880686059;
        Mon, 09 Sep 2024 04:18:06 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:6647:6d5f:dd48:8f5c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f1dc55sm32039745ad.186.2024.09.09.04.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 04:18:05 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabien Parent <fparent@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	MandyJH Liu <mandyjh.liu@mediatek.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 07/13] dt-bindings: power: mediatek: Add another nested power-domain layer
Date: Mon,  9 Sep 2024 19:14:20 +0800
Message-ID: <20240909111535.528624-8-fshao@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240909111535.528624-1-fshao@chromium.org>
References: <20240909111535.528624-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8188 SoC has a more in-depth power-domain tree, and the
CHECK_DTBS=y check could fail because the current MediaTek power
dt-binding is insufficient to cover its CAM_SUBA and CAM_SUBB
sub-domains.

Add one more nested power-domain layer to pass the check.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 .../devicetree/bindings/power/mediatek,power-controller.yaml  | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 8985e2df8a56..a7df4041b745 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -54,6 +54,10 @@ patternProperties:
             patternProperties:
               "^power-domain@[0-9a-f]+$":
                 $ref: "#/$defs/power-domain-node"
+                patternProperties:
+                  "^power-domain@[0-9a-f]+$":
+                    $ref: "#/$defs/power-domain-node"
+                    unevaluatedProperties: false
                 unevaluatedProperties: false
             unevaluatedProperties: false
         unevaluatedProperties: false
-- 
2.46.0.469.g59c65b2a67-goog


