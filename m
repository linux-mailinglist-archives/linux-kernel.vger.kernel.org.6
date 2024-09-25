Return-Path: <linux-kernel+bounces-339715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93278986966
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3EA21C23E18
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C210F1A3ABA;
	Wed, 25 Sep 2024 23:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wdb+9t++"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1051A3BB4;
	Wed, 25 Sep 2024 23:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727306468; cv=none; b=j6DR7hNOdseLCe3+A4oNeS8vHbGmdd0rXVs8pQautazPRvmfIYnq0RzzEpFL+0is4xRGlctoJjRumNP1O6SvmXHYNXnR3qNsMsAaWs0bfKvRjs48kJcoQ5zeJGSx3XpMXjUWmseL4BWgwx8vPFk4UkSlocXCuzTi0Yg+19tiYRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727306468; c=relaxed/simple;
	bh=UZd/1MEL/0YGVQ9XZev+SKB2ICbqx/sGLsFNGZT4cxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=je3PUundHRcCtJgUSQD25RdAGK2PXe+ECWYXp3lppLsuI++ox27B69lSAdFI4twFxtmOCa5XAlMZD+ZaweEP/sys0En4qA20WNiCuwQPw0DIpIuGDGv2z5y9i9pmqpshwd9NhnhGUc4JsKiO6j4LS9pwYuJicUhQoGRDc5TStG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wdb+9t++; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f75aaaade6so4159421fa.1;
        Wed, 25 Sep 2024 16:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727306465; x=1727911265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bogDjOZyEOHR1iFYz6hiM2rDuEVzKCPss7f3ehg4nU=;
        b=Wdb+9t++Fz5V1aW5GexnMm+vM5an/e6KI0NsVqrFZ2qba7rvBrhaqL/elPGI60jZp4
         zuBM6VoUeZ4gDrGcnxo/jZ/HFCOkPXVFwLWnDy236qBasRjUeZRvmXTh75uxRTJQBwM5
         cOlBa+WUETq53HAiMcQ/iIPFKEYljVVcmBP4zHmaWFt/rqOTVovwUDCP5BOs8UCVJWi6
         0Khv4fL9VTEgXakXWsckx2+2vm4W7mc+kElSnHTkkhLKQoBwRXH0F6eHoBB7SPwMQUfm
         37/JmL2cYcDkk5ScT8MzhmPpDGmiyi1rxkSeRVOu2RAJ0Sd5EQ7cyodIPOqBgH3IYMPk
         Nvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727306465; x=1727911265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bogDjOZyEOHR1iFYz6hiM2rDuEVzKCPss7f3ehg4nU=;
        b=XOQ+GH+iFND8Vi+NqYKKNOI5MysJa+k8npxiAHzg3Vsd5BsG3jVltRE1xgFQI4gT+E
         BE8KzgUhfXlQ+8kBHpeYm/MJZ9mzSIeXQbjoV9WoOqcpXz1gFaZg+qI/t+gMYlctjxsH
         SHUeQ9rh1gyKNDLWIFrCjVcpCmHfPmozmFFhGauh8drH/0DwLJ3fY9PmQcA3gfsg0fuI
         TIrixTk3ga2hwsEYH7xsvWL1e7//LX/jovE731gqJqEhXo3g2ZgM8hfnWQPdzofnp5Bg
         rB/qutys8g+2wnrcQQDWGz3oE5B/eXDpNdFXbf28Lx69UwA7KjomIaX5zzFzS3GTtPLt
         GRJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKnfSayk00Lcvocc+1PHu629GlIFitqUKnCQ6v5h4wKU/YaVhAp0/6suKmbcaQxqQR14fnhrthWCZEXRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRykVaXVjct6bkjHIMJmqZ3z8HfKVdYVkEl08Bx36IKjHNI/Tr
	bMa+kXgPXwnYUUpbX5GxkIgzNtKcINC89q7E476RqoQrVBIvxbeo
X-Google-Smtp-Source: AGHT+IFzysiJl1nP11kbexTXDIA+NNLYwV/h5+ijVjWxUUQVRdF/d175iEpJG9U0C5fsGowcn2S/qw==
X-Received: by 2002:a2e:751:0:b0:2f6:593d:36f with SMTP id 38308e7fff4ca-2f91ca46349mr22985561fa.28.1727306464388;
        Wed, 25 Sep 2024 16:21:04 -0700 (PDT)
Received: from playground.localdomain ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf48c315sm2481026a12.15.2024.09.25.16.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 16:21:03 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/6] dt-bindings: arm: arm,mhuv2: remove power domain from example client node
Date: Wed, 25 Sep 2024 19:20:04 -0400
Message-Id: <20240925232008.205802-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925232008.205802-1-laurentiumihalcea111@gmail.com>
References: <20240925232008.205802-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

The number of power domains required for DT nodes using the
'fsl,imx8qxp-dsp' compatible is 3. Remove one power domain from
the example client node using this compatible to align with this.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
index a4f1fe63659a..9e878c028036 100644
--- a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
+++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
@@ -197,7 +197,7 @@ examples:
             reg = <0 0x596e8000 0 0x88000>;
             clocks = <&adma_lpcg 0>, <&adma_lpcg 1>, <&adma_lpcg 2>;
             clock-names = "ipg", "ocram", "core";
-            power-domains = <&pd 0>, <&pd 1>, <&pd 2>, <&pd 3>;
+            power-domains = <&pd 0>, <&pd 1>, <&pd 2>;
             mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
             mboxes = <&mhu_tx 2 0>, //data-transfer protocol with 5 windows, mhu-tx
                      <&mhu_tx 3 0>, //data-transfer protocol with 7 windows, mhu-tx
-- 
2.34.1


