Return-Path: <linux-kernel+bounces-553169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45103A58521
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A7B188EEDF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079071DEFCD;
	Sun,  9 Mar 2025 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RfKrF/XR"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4FA1DE3DC
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532255; cv=none; b=VaXWWmbIlve+d13Rpl8THxDCDqXAzuYOAeL+yhQdLeoVLCL+AV5yqS2EpINqHQSQJFEyCtiESbNFpM3GN5bQP+LKBv3vggOSzezdeckqjdEpTeQrXYTpgkqPWZWbTGeWiLyWUy1qV704qwHUJqDQUvM6DZ9w3pC+H6uVv8KpVFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532255; c=relaxed/simple;
	bh=4g9wUdzBEHF2DXwrsn4sDVm7Nmec/oEeQKsxWFnBuaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vd5EsU328WuP5FSM5MZsNNkHHzOuXmGcy0L7Rqo293F16C4BbNFRuwhJ5A1DoTkvE6D42epUwHeIAoBcCUQqJnnuyQL4LhZFT6IlsoQ7GPqXKFQdt6dhgD96SHO83jsrvMLuOmRLX0OWLkLbALlEKKug9yZeqet1Sm4/K+ckMSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RfKrF/XR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-391342fc1f6so2406574f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 07:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741532252; x=1742137052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoVQYZpiH0Di4cmCzPcvMx2OkQBw+j3GHZ8ITdSC16E=;
        b=RfKrF/XRwyGKOIGmJKyVlIahabRslv0LUEtSNk+QSAVGXH45BWIvigjHKyYNWBTSaP
         Bocy2ZdsrSxUWJuBDmh3HIIoMmiunczcOnmUfAkB13knimsOlI9QdqNN2FNLdsA4dTWD
         jeDaHX9GESJ3ciJXQENmzUXwtNNuLlpKdXA9n79xkRKZ7IUffqV47lNjRyTvu3ueSSnV
         2ZZH5LkTefGeoGkCx5WTd+p5xGWowx5Pix79d2veQvKTA0GkFX4R7n4AFstDxOqzuqm8
         KtbYZv4L5eK3Ccx41UfZePt4vA0RIgCGqzj6cej4QY7jK1fBQKjwNFe93HG/UtRkm2i/
         p4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741532252; x=1742137052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoVQYZpiH0Di4cmCzPcvMx2OkQBw+j3GHZ8ITdSC16E=;
        b=BkaEu7bDsAOVi599H8n3i764EnqBUDNJ3vhQsmrskB+r3rEhLW3A9JpQKOloWH1vrc
         Fs9eLHcntUioxuX4R01OCvCw+wmezKwaUzlOA5pBCORJuuHFUfJOGpKDtqTWwckHbzKQ
         dyyFmhfQ/lPv3o9zQNu7Yfuk1a4kTcYzVLzBslHe+2sSIrR5ymSVGalWLYo5UH/+8SIP
         F/c1adM7LUd4Hup6clqxMB5VO7kHJzAB0dHi32v5fY10NKlu+EopTyQJKKWlf7Fm0IGK
         e9aHCkCQl1EgvDCNO/Ch4dVfKp6Si5BgsRfTuaUhEoYBTDcYc5KETS+qRn6LJ/Crzaaw
         nq5Q==
X-Gm-Message-State: AOJu0YwFNz0lpOiKlx9b0UcvtU8nT0K6Hb6mvDzssQHApIpdDQEYdIvF
	ITQsIOnqNeISKxWaauNUtnGNLHbjzqPeDQhs5j0pMWl+4M3pO3Mg0noOeGcfhNg=
X-Gm-Gg: ASbGnctiInRFBgmKEh+zNg6J4p5QtA7SnSlelxehdd6eFQpWFkQPELgXDBVILikFV99
	FVqYYl5z70LeI7E8Da6OgB85l7vjQXt2Hp3PtVPAKH4JG2D0Qu1E1ErviQsaOOFdImRvyXY/ngu
	fLzOQrDeJ2cubexxkpakhABGxI8b9d3EQQpvjBD4G4kmHk5s99KaknCfA/mHItbuKJxDnYOvliT
	cuMxyWTnquOxopwdaG6KTV+lm4F8593C2fpbfuXJeytvzRNf/6pg3txXxLPJ67FJT4SvQ1+MD/c
	ek1vz6cRncJ0P9tL9fm9/Vdudj0dNYx4ibqGI8ZNPvR+kKlBD0Rk1/bbJJJCdUNenATAgQ==
X-Google-Smtp-Source: AGHT+IFPk2pjcfPU54BQJ0LRIwCigPHP+muHuICAjK6dFAtTZz8KH4kztEkzRt88gYB9VmelH5i8WA==
X-Received: by 2002:a05:6000:1449:b0:391:466f:314e with SMTP id ffacd0b85a97d-391466f322fmr1383362f8f.16.1741532251866;
        Sun, 09 Mar 2025 07:57:31 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031fdsm11744899f8f.89.2025.03.09.07.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 07:57:29 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 02/13] dt-bindings: nvmem: rockchip,otp: add missing limits for clock-names
Date: Sun,  9 Mar 2025 14:56:52 +0000
Message-Id: <20250309145703.12974-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
References: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1303; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=UQK0J97pNwCPOKGAeMM7qvUdjF+FdCoH8EtiOEwCJys=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnzaw5+g2DzChB+wfimV6C2cDoSMG8RnsgqbIoU f2SZtwwcu+JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ82sOQAKCRB6of1ZxzRV N5LQB/9uyBnLBBZp9eE2lEGChTLg8MG14apMyVaFf5yCLO0p0n4vGnZLjvbtY7kGK1uXZ2fJGhl 6n5LHAvRlE24Itu6SmvDBVpwuNZL60iKofgNmzL/Sh0Y2kcOttEzAPSIYOTpb5uKfCz7L3S0yRj fLvyhTReCQrIKaQdowviQ3SyOYJzMQXc6UFepgAgrEqJXiogFrPYPAJdLMb4wxfURhsrqosn2+c Nw2dAsrE/8ZkPYQcdwLDoTw9sJpUzd76V0Ij+4u3iVIWJytzTVSQgyb7P3rYXyZALDrnXPuKL7f c/F/ceKMJguwxz+8IyLnE5FRKfUb62a0gwEViaEciKGSthf1
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko@sntech.de>

The clocks property correctly declares minItems and maxItems for its
variants, but clock-names does not. Both properties are always used
together, so should declare the same limits.

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
index a44d44b32809..3201ff8f9334 100644
--- a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
@@ -62,6 +62,8 @@ allOf:
       properties:
         clocks:
           maxItems: 3
+        clock-names:
+          maxItems: 3
         resets:
           maxItems: 1
         reset-names:
@@ -78,6 +80,8 @@ allOf:
       properties:
         clocks:
           minItems: 4
+        clock-names:
+          minItems: 4
         resets:
           minItems: 3
         reset-names:
-- 
2.25.1


