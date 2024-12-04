Return-Path: <linux-kernel+bounces-430972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2919E37AF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05591694DB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616611B0F36;
	Wed,  4 Dec 2024 10:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QmJLbn4U"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33DB1AE003
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308602; cv=none; b=UofK7MmMW5qSX2NIcEXISzRogXWltMFiPlzdhT6DP9u7m85YCCpM5Klw0KPtyrTCHo1RlFME9e0RLryEVh3/j0o7V5KJ5JcbyvAtZiMO/HjUE2iGddVl9KdrC/d99zoqM3t6a8YSXkXGpWPUOh1izeyY3WDugkBqFcfHC9fSewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308602; c=relaxed/simple;
	bh=peYrt415YULllPSwRUnKU5Qx+NDdGSX6LQbwju+FB9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=naGEkEr+wX2IcwHP78Q9KqqmvXfLqvj4PKYzxSX4XCfKvZUleunj1qB4KtSAOyXsSedu9cDUCr35ixsBuXu7jH+MKzyRJ1Kzt6s7EV9lQ8bIuE96M8TDa3ipb2IQPlJvuGWVRwp1Aoc/kwuBXj5swJxAvlrH4eltj8PoBxtpOWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QmJLbn4U; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385eaecc213so375999f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733308599; x=1733913399; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CEBWDAJs2F15pzwyozxNKYhFYdToRnM6LzIW6iWekBk=;
        b=QmJLbn4Uiqj3a84BcIb4G5O87C3WVKkpwE+AAvZFKZ5k6C6gQWUuRip4cnycZBxhya
         HKckBnsiUGP5Lj5RbumcGpqn7rB4R+p+lvVEDHBtJ1RhlSv4nI/nGnI35v4GjIkC+v3B
         8BIce8cTrwJ8z09IvzWbvogSyhR52OvHGXiLZW3oyaTJdiXCcpPb9tW/s2+9fpfInZvz
         qu0yd2xGLmo1jxrxuTOCFxDcUJ2IH3Mz32JaYLXxAKyoY9D13LbaKlY9mcJvzhcpgVtN
         Obsgc7ZLjmvyLDg6C9b6UenBfhiG58S2mLpXlIZSGXuI4ps50FYT2aU2okY2m8/zWg/l
         DIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733308599; x=1733913399;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CEBWDAJs2F15pzwyozxNKYhFYdToRnM6LzIW6iWekBk=;
        b=OOK0HqElj+Z0wOcXUauX6kYubLuEy3+5uW6D2kWtiLac+Rnn1+mcVQsBOjNhxoSDwm
         4faJhMlUbTL0gHwVQYFsSU91fbOLemTCupdKvyjTFEIyakbrQpquGglRJR6oD9cks2hU
         +vOiEqDvQ4tTAP4d5mZ0Sm5JYGIGiPe5oqidOQYJLbC91zgQ2VlQXNR/ln5ePdGf+DVa
         0G+3+LMAn5ILvnyyhlgvB0FUzWU0RLm4L4Ab8rFbHIFxxLECCHKvWmluRf+GIhHrjEqo
         DVs4fsaFXY9o+spTGLbHXHwDafFIkNJrtlsI0KMFW8+QzgroXWiKmS/dcKvcQXw6O33y
         NZjg==
X-Forwarded-Encrypted: i=1; AJvYcCWLQcppGnJkg+Pk3CyfE78hi1D17N5c5qo/B/PhrsqLhUzQaclWR3Ql5MwSEOw3JlBpHPF2VyDugZQ4T3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjszd0WimkP5McABlHFq+426ROiGmurFT/hTb1a6vjS7efjNm4
	hr0Zi2VJfxMN9lh3EIsX6xyJvXUZQnNBpbp6wCZR6ZM2r97jynwa2YGQkFYAo38=
X-Gm-Gg: ASbGncu+3bs5OMMudc+XBopi331Zdm3fJOOdDylTn9Tu778eg5imfbJwmWg/FKUTBRw
	JlBs2Wd2GnAFOaVm7FE4Kqrc9MQKUsNxHO/qNUMVkPPTdpNwI6bgOjeJED6qDUyayqU5FRXNtGi
	ZPcHqPGnb0E8DIz9SzlRa5NkS+4iqQ7h6SN/ck4iGcNTdTSPP9codpNP7WzqUoLh5Svt5LDZpd3
	wUUHdEl7Gj9h5wVLFOVx7hd+0bLOhWWlDRJiqdTJ69U0cnOas6ett6+1DwRATPBAb3jXWk=
X-Google-Smtp-Source: AGHT+IE1eKytGYhN/G2avEbscWDzaqM2N9y7QbNLOqIY3WvlHqBjWYhCRVwGHZqF/ZoYxBdvoZSCOg==
X-Received: by 2002:a5d:6c62:0:b0:385:f010:e5f4 with SMTP id ffacd0b85a97d-385fd9b6c06mr4026493f8f.28.1733308599326;
        Wed, 04 Dec 2024 02:36:39 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385df74157asm15409391f8f.0.2024.12.04.02.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:36:38 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 04 Dec 2024 11:36:37 +0100
Subject: [PATCH] dt-bindings: display: msm: sm8350-mdss: document the third
 interconnect path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-topic-misc-sm8350-mdss-bindings-fix-v1-1-aa492a306bdb@linaro.org>
X-B4-Tracking: v=1; b=H4sIALQwUGcC/x2NwQrCMBAFf6Xs2YVsrFT8FfGQJpv2HZKWrIhQ+
 u8GjzOHmYNMG9ToMRzU9APDVjvIZaC4hrooI3Um7/wo3o383nZELrDIVu7Xm+OSzHhGTaiLcca
 XZXIyh5yjhEC9tDft+n95vs7zB4azNaN1AAAA
X-Change-ID: 20241204-topic-misc-sm8350-mdss-bindings-fix-1701baffc1aa
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=peYrt415YULllPSwRUnKU5Qx+NDdGSX6LQbwju+FB9U=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnUDC1nleUyZQQLS9gEd7//NknovstellbNGR/a7EQ
 eyLt7XiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1AwtQAKCRB33NvayMhJ0YhkD/
 9U3qDvqecaANAURilULho5J/RjI0flxgZwbAVSkj2UH7c2Ifm0TEJm/PNkwLJgE/jIYZ8DP4o7qTt+
 x4TRZVYeu+QVirVM/e4z8PMgI0scaCwmrwkdjy1dyUlUxXxyZc2tUyOSpsnBmBSqmwb8SCvUoOKhSy
 NTXIvoP2J0YLDMTUryjNP0av/W+9k3Tw8wgy7lse1tXil3MhdXbufiSstkS2MZs9bFuYOvz8leUOR7
 8QE3Fa7FTMYdTWEU9dEwIPqnMBcmu4C8yfbXiWRnru075t6rcT2BKyvA57BY/PYjSYFqO3BTOt7HND
 YcHxVfEDXY7pNe0j1mZ+HQce2nCGEjtWyS8LUDPfntDpf3PaySc0ESyeu32Xm6Z1+2fvufXlUds3rV
 +Le2js2U5SQq2nFRXXzxLltckVq+6122EV+MD2N9ElD180lTFrNXXqSxEHHG+S+KlhuYTGRX1pHBKg
 iNrRGeE+97Ueyk9r1QXJ0whDnFsz32k/VHI7OkelttMYUdUm3HXDuTqyDN+7GcJdFgLZXwe6FFbBuN
 sPd5SpFM+y42SNCOMeiXfZ+DoACTRda1hBRWWGk2oO685P2uFJV21NN7b32MOQ9CJ04CXRQi/d26aK
 jvUGV67nUXQyNFkZiU2Ndxm28uPmob6GYdVFptyfrE08LgbJ8tRqnB1fB74A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the missing third "cpu-cfg" interconnect path for the MDSS hardware
found on the Qualcomm SM8350 platform.

This fixes:
display-subsystem@ae00000: interconnects: [[121, 7, 0, 77, 1, 0], [121, 8, 0, 77, 1, 0], [78, 2, 3, 79, 16, 3]] is too long
	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8350-mdss.yaml#
display-subsystem@ae00000: interconnect-names: ['mdp0-mem', 'mdp1-mem', 'cpu-cfg'] is too long
	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8350-mdss.yaml#

Fixes: 430e11f42bff ("dt-bindings: display: msm: Add qcom, sm8350-mdss binding")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml
index 163fc83c1e80cf07383f9aef510f2f58a26e1ecc..cd9c6c78413f887c984b522f83cc7e437ce97d25 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml
@@ -38,12 +38,13 @@ properties:
     maxItems: 1
 
   interconnects:
-    maxItems: 2
+    maxItems: 3
 
   interconnect-names:
     items:
       - const: mdp0-mem
       - const: mdp1-mem
+      - const: cpu-cfg
 
 patternProperties:
   "^display-controller@[0-9a-f]+$":

---
base-commit: 667ff2368867af7000ce32a8b3fc025c2b3226b3
change-id: 20241204-topic-misc-sm8350-mdss-bindings-fix-1701baffc1aa

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


