Return-Path: <linux-kernel+bounces-215232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2EC909019
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10AFE1C2295E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECF316F0EB;
	Fri, 14 Jun 2024 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7IwX6O5"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C66E16D9CF
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382252; cv=none; b=gFz/teq4D8gq+8TEShuw6EuHbVYTwP3sffGC5f6Z/vPCpF9loB0gR+rQG2gDUFSrjnlnXrg33ktpv9FuvIJ73ikD5QJL6GsSiB7NbKh2JZH0Ku0YwpciBDgh/rea6+mexaq/hgns1x99I0ZtwqkNuGZTZlK+mVdYmX22nYxNHC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382252; c=relaxed/simple;
	bh=rLr1JBmyf4h8ZfpUwJNjeawg01+mTkoSSeFi6OYtlE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ToF6uGxow1HTtgnqWiHlcGjhhjFIWDNv1W9aJ3AWCHsHaqTVz6HLLiumjjqXwJbpwZ+wSmpos7FKYSFp6AwJ0VTe5yGxeyrkCbh8/j4f7IeSmkBMxWTPO1G77L/erUFnFPH+6Xszrc9mdVPhTRrMyxkhnTXTJ2EaqP6u/H2fAgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h7IwX6O5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35f188e09a8so1886189f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718382249; x=1718987049; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqVF7q4lvJozPubshiqMpT2VHbao70PEnYzL/muuYWc=;
        b=h7IwX6O5hqbPbjR7weIBMCINK4JZ55qaDqhx9RiBoAUVDQeNy2tWrIausVy+yyNH5g
         8Rhij/LFl093+tXRyLPcweDHxApZpH8Yyd8GmhgM8QCPf8zTifpG2MbvjulN2Joj/7Up
         gAwPy6AnWdgXfxUp3Ga2/eN/j6bMMko+RudOkUWWN50KtaXMEySqzw9HdUh65Q/mQa3o
         YHDRo51BP1CgeJ/tDtPJDS6kemG+IhKpogNAXXpdFQPkjziRBHUhm4DBVFfE/4moM9a6
         eK6P7gv3fT7uYxSzeGsnP/nqFsGZNMtpvF8y1CFAV55Smm5eXv7M9g3IHsg79BLOrTeV
         9aaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382249; x=1718987049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqVF7q4lvJozPubshiqMpT2VHbao70PEnYzL/muuYWc=;
        b=WsFZ3fB6z5NYr7Y3m6cQcG8qo2/Gqjho3Yc5F1qKqCi2moyuFE2Wh7tKjHpvPc5NB0
         AOQsKE1i8cdDIqChS2F0zayQ6kQSr7KCOcEX95Rrpv+e96Mx5izKTXHs36NBUCTWCwDJ
         tJ2pZmXi2D7RRY7qrRmmuukL/KIjz98G55+gZtl+8vgD33DC+Tegz7oiESivUa0go7wN
         8UIsTvqKqgAvpnwGS/JJ//aBCKio5CMfWm4eH8z3IGpn9Opmv7J3o5iKG2jrExsHdmRf
         3znXwO4HZFVkqdMUboN1D908ZQL4rXAaGE8gLUmIWTn2oY1MwMFpAiIqz+FdRcGubDes
         oBuw==
X-Forwarded-Encrypted: i=1; AJvYcCXK/0D9ccBnBz60rWpZNt9CtY4F9GmLIaImuD4brqnEUL/d7QDmSkOq60BofbnljjEDQdMOAl2SFP//UOXDSbJ1Z/u+tPg2QoPgME2x
X-Gm-Message-State: AOJu0YwJMEnbvW+1PgCj3xZH6aXrzFwWHohVjmYfidS9omCVY7oRi6iV
	qPVxZ3oVZYlZZxJaCMlidD3SL8qf12dbsmE10DD4t5PmlKMbFFcRdbWe0RcKiiQ=
X-Google-Smtp-Source: AGHT+IFYnaf+5rgZ/sPcEHKeTUBhGa2azbnMx/BRcFPt7SXvume6qlcEccJaQcz/vaaoWoci1eBpqQ==
X-Received: by 2002:adf:f60f:0:b0:35f:fa2:3e81 with SMTP id ffacd0b85a97d-3607a788b79mr2258337f8f.63.1718382248812;
        Fri, 14 Jun 2024 09:24:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36074e0e5adsm4931165f8f.0.2024.06.14.09.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 09:24:08 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 14 Jun 2024 18:24:01 +0200
Subject: [PATCH RFC 1/3] ASoC: dt-bindings: amlogic,axg-sound-card:
 document clocks and clock-names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-topic-amlogic-upstream-bindings-fixes-audio-snd-card-v1-1-9f57d9e01834@linaro.org>
References: <20240614-topic-amlogic-upstream-bindings-fixes-audio-snd-card-v1-0-9f57d9e01834@linaro.org>
In-Reply-To: <20240614-topic-amlogic-upstream-bindings-fixes-audio-snd-card-v1-0-9f57d9e01834@linaro.org>
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1805;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=rLr1JBmyf4h8ZfpUwJNjeawg01+mTkoSSeFi6OYtlE4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmbG6lCW1GD+c0W2D0RrxQxor4he3SKfOwZ9JUq1nF
 DUdxVXeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmxupQAKCRB33NvayMhJ0fruEA
 DFKaDVhm7fVnRtNa7JkVplIkxqGF3hliySL3tbgXY+vz/HCL4fngWPHV976mpGon3TfA5W+EysGlla
 nw5NDStdSWFSTjcHLnOc6ax8XkQNPH0zoXPL93wiC0zhxr122GCvP+1EBeMUpBZmSAMKJKwiuUVASd
 RPWI71tJnoDH8W3SVzNktQ8NiRwKME13v8TTjsdmtgRR+w/vH3ia8MpcZpeQDMknfz8iYTlvhtgRIj
 DIS41nwxGxHdBQaZoomdcnIsJ7Ep79AUurh9Ef0bbEzNixGtNTr+D4pAJp4OvVAwVC5Z+fYKICgUD+
 7bAcLO9uexscPpdyq7swOjyG7JNeshoFZPYrpUuYeFBSYJ+Mh5gftd969ZuopkWTgO0klX1j8GKkTS
 l85hXiWFO78C/oKzGQYQZuYKucBLmCH436zbv7HmOYqml1H9jwYuAGh2w9EMRHdu482t1lNXWy/2QN
 Q1SQ2L0Mq2gsXfDdE2Lcpn3GFPo0i5fU71KbthJSX1pxx/snCDyteRFDNdD5kPjvxgO5I00Gs0v1Ty
 NeUhnY9GKWpW+uZnrc497yhY24lNEyjqW768Ydg1b3IdFP1Dzq/R2hynSXb8CPLYc6dZDpNaaZTjsz
 MrAGh0hnHcLVd7DQ6b7X9fn1zk3ngFzeTY/jx+96G0XVQea3sxULd/8/8W2A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The sound card design is based on 3 reference PLL frequencies that
are the root of all clock rates calculations.

Today, those 3 frequencies are specified in DT via assigned-clocks,
because they correspond to the basic audio use-case.

It makes no sense to setup clock rates for a sound card without
referencing the clocks for the sound card, mainly because at
some point more complex audio use cases will be supported
and those root rates would need to change.

To solve this situation, let's legitimize the presence of assigned-clocks
in the sound card by documenting those clocks, as it describes a true
dependency of the sound card and paths the way of more complex
audio uses-cases involving those root frequencies.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/sound/amlogic,axg-sound-card.yaml    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
index 5db718e4d0e7..676ff2731b86 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
@@ -26,6 +26,18 @@ properties:
       A list off component DAPM widget. Each entry is a pair of strings,
       the first being the widget type, the second being the widget name
 
+  clocks:
+    maxItems: 3
+    description:
+      Base PLL clocks of audio susbsytem, used to configure base clock
+      frequencies for different audio use-cases.
+
+  clock-names:
+    items:
+      - const: mpll0
+      - const: mpll1
+      - const: mpll2
+
 patternProperties:
   "^dai-link-[0-9]+$":
     type: object

-- 
2.34.1


