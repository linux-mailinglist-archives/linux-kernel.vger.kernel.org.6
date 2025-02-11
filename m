Return-Path: <linux-kernel+bounces-510167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57952A31926
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0A81885AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189B126A09B;
	Tue, 11 Feb 2025 22:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfNCqprN"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F35268FFA;
	Tue, 11 Feb 2025 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739314730; cv=none; b=cLwD93b1VfuOHjpUp5Vs4sIa0LQc8PX7gMRmE+MhVkdszZvFYvUPEyTEZXN2+IJYVQWJaPunyX5hjsYlc8eVAEkUtIkXYjJrTQ0rj2qcD2Qh84mNTPcmKx2OsAJ1ZKSxX9DwQgvBwVqJ/ypPwu+5X8eG8gH4jLH/+LD25i+y/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739314730; c=relaxed/simple;
	bh=9IiabNlZOwbWR0KxMdhX1H4jsvCWScoh399ys98j62E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=demKW9DOrpztz088mENAnYcgvCe/1e7lCGZgmKR4fZZAKh0KA0l+GBnVfod060aWJVDDsLo3dOxxWo96lrKP2I32nIB0UGWSiiqBUgRVlQVCDIQEBbsUp+6EQD9vVg8Ej1i7w3UkWIuqSD9C2x5my3RUsRTnrAkuQQWjySEqM4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfNCqprN; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7b7250256so469067866b.0;
        Tue, 11 Feb 2025 14:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739314727; x=1739919527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPQUrHxbPl4glK9O9eU6ywBBPx1I7T/6JYnYhIuuFKk=;
        b=DfNCqprNAzSuCva42sYMh37Q2V7h5BUoDbWWWVqMa601aeV+KfbCjqiwP81k88GnRB
         QfZJ4lU9KbD/6vYiQk7U3wzDI7MzgmMGX12vxWRbBsPhs3GSxe/KHub3wdi9suG9MNOa
         XFuOMgUF3tAcHGjMGXQuHrDoDFXh5wSCHz6AX7WfCk16n3rnwfLD4ru7aUF0lodHsnlF
         sKAUpT82ipm74H8nORnbNJU6vITaiiS7PDaoEqxPBJ7Ha94vAqecJf9O1uS9oL5BG/Cv
         TDoUZwzeuRWqX+ajvoopd9wLLIPayWfeCCSskw6PM+GOdCc62gI7t7xLFvsMLDSio7Of
         hDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739314727; x=1739919527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPQUrHxbPl4glK9O9eU6ywBBPx1I7T/6JYnYhIuuFKk=;
        b=kasAK62HgJO6o18HRzdeETvCKCcPpbv963zAhAqnPwgZlBU1Xsb7Z8OJDRk/vRqGyJ
         m+FN8mBoKMapKJdvhjx6LMDSeVFt3Ae3QQhr3MFBnxvOfoHirrormZDevDSrm3wP+hES
         HOv9m2XzpvkgN90g11K4HXRepB6xtdRkm7h1rjPOUnRvDunERDurhjDe/9W9tT9evV1h
         ms9AkyCUFQMGTkWUwSBUcRsNlXzoeQCWd3rrZ1nCsonwuUv3NYKnpT2qx0HCEb24NHIZ
         jsBCmqMrBr0sXE7MVGdj5uIroxCa3kUJuWvqx2CeDc841dVIpDLqyECMoKaXfLqjSYiK
         ytqg==
X-Forwarded-Encrypted: i=1; AJvYcCUM+G6rHgW2fp2cl2eeMaGpv60DcypDlhkwXd7kQRKKmFfwddq0wkH+rbcSebcNGN10TbdEGbCouZTEnQk=@vger.kernel.org, AJvYcCWw9q6xv7CUQ4108sCIyOwMWnZD1Hk0XhvzHqmQ+iwm4AzaHDRHLaGNRBJL3dy7M+9IVCmL39f7PxE0@vger.kernel.org, AJvYcCXkbkh/WnUCr/BmLxCe732Xz//rWMui6WMYts6c/MunlmUL7hu3YFGuiTHD56nt9N22XCQHzqvGXQmXkSuU@vger.kernel.org
X-Gm-Message-State: AOJu0YzG5lpsSKS8FS98j9iGFngUKDJaYI0Bp1FTuUhCjPeQtsXkxMeu
	DVchX1K3YOSH0ouVfakn8Bq0F8tTXycDe9Z6sgUIgTkZ28erUnCd
X-Gm-Gg: ASbGncvqsiVT7PSXWnZGWBUxYaVNWhCrR1oS3jD9CMLTdm4dKcFnk9pAbbdWOpogczw
	2ZO3V0PbBbIHBuPnM0YXGy5OSb7byKT0tYfutmrQXZAEWPdbPdADrJO7K3xXTlxNPWzpfW46ob8
	90AKyG+gVUsCvkNG9JMuILecrrg7qa9Y9yIQPa+IWL25rGZ4eUFQhCfVSz5pySPgh0JRBfh9Hp4
	U5fOKFeJErQO1b0hc5eI8DdhqEpbaMJhmfz298xbMR7e6EJckEB/WB0bHAq8kIYVaKfZb/ECyl+
	KEzmvEeg53LrmBqr3Ms6hZvEyEoo4P1hzfeg+nvZup8ea3EXHS9xyQ==
X-Google-Smtp-Source: AGHT+IEmqE1LOzAGu3QEL/UkzAXihfpx2bG/CuCWu32huCvYMcpoSHU615QU9ED9pRm7TjRqIRBWjA==
X-Received: by 2002:a17:907:7d92:b0:ab7:dec1:b357 with SMTP id a640c23a62f3a-ab7f34a0d2amr68277466b.39.1739314726948;
        Tue, 11 Feb 2025 14:58:46 -0800 (PST)
Received: from playground.localdomain ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7e9fcd99csm131525166b.89.2025.02.11.14.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 14:58:46 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/3] ASoC: dt-bindings: audio-graph-card2: add widgets and hp-det-gpios support
Date: Tue, 11 Feb 2025 17:58:07 -0500
Message-Id: <20250211225808.3050-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211225808.3050-1-laurentiumihalcea111@gmail.com>
References: <20250211225808.3050-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Introduce the 'widgets' property, allowing the creation of widgets from
4 template widgets: Microphone, Line, Headphone, and Speaker. Also
introduce the 'hp-det-gpios' property, which allows using headphone
detection using the specified GPIO.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/audio-graph-card2.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml b/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
index f943f90d8b15..94588353f852 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
@@ -37,6 +37,10 @@ properties:
   codec2codec:
     type: object
     description: Codec to Codec node
+  hp-det-gpios:
+    $ref: audio-graph.yaml#/properties/hp-det-gpios
+  widgets:
+    $ref: audio-graph.yaml#/properties/widgets
 
 required:
   - compatible
-- 
2.34.1


