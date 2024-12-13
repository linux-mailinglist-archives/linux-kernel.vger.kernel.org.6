Return-Path: <linux-kernel+bounces-445200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E619F12AC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0423188CE21
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC8A1F1316;
	Fri, 13 Dec 2024 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dK/lmBeW"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7191F12E6
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108323; cv=none; b=EKgt2W+5o47v9lTAiovbjEm8kXxtKW3RjOf1OvrSmXLRgj7VPZL9ZlcyT72EZjima8ppZ5l3Qi2O6Os3Zkmw8ArFZfxzl4zgOZoRRA/hlWXjIY9HWgq/LSOjhhaMnZDO88FjNHNA7Ld3aN1KUyasvjcZEk7Ovc4GC+Ok6MbCoRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108323; c=relaxed/simple;
	bh=aKfOXqQGDukFzONr0CiKY/knEiGL73lWVm8HRLM5iLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WC1mLSVj0nhaA+tOP2UvVedsck/dp+J2R3mGQYNHcNRL5W5Vv69WHgC0JF6hJ7+5vhWeg7lIpXm/wTw6Ym5QHlAyPdaM40SqyseTzkdCzQtpKD2+W1Cl1d630UpFwaZiWZH1lW2HdgTYGVjsGeHoeFEKL20QcY9Nn0d0Vs5CFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dK/lmBeW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361815b96cso13411035e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734108320; x=1734713120; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjlzbWl9chiW3b1bcyAnwj9F/eAWfXtVDjTLB3PlhTI=;
        b=dK/lmBeWYzVB96j68wSXz7NTHH8yN2Q3C8satwswpIYXVj24cbbebbdloRYaqdO4bI
         5idimxWX0oksvOOZpV5fuq4H+KWvBlmFb7otXz7JgIhOozRN5vx2alaNjq0u7EDQ7ZAL
         brCKbRjHlMZElh6rqDqLK//2XE9aDRNW8CkANVLLzgg/DaHa4btvJyabTM8KsFvL+aGG
         SEhOToSWOjEXuxdgl7T+KOlDdnRtd5PyqbtRnjbS5T3Y4ZqYbuFl/N/Id6ElZNjPtJR6
         xqBpOzqudXK+HjMNlPmA1j9urZ4Pjxsy5pJA4Tw14/1LtcE9eU00litMdacrc720WQCn
         sHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734108320; x=1734713120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjlzbWl9chiW3b1bcyAnwj9F/eAWfXtVDjTLB3PlhTI=;
        b=bE9glmhp1mjbzr/LFFRYWQy/AZtrlUApIGShpe/SqIRVO00/K8A6+xVjQVX4g0cqdW
         hU70nBKxb6TicER9opW0BiFVX1QOkhdUDPpbC1XoqUsO528oM/IQTQiSecrzqR6iR0hr
         gkqjwmf5kjxQcDarBzGzxVl6km2n8XlvUgOD5M2juH4H+kKp17/Nwc6SDgX9CheaT66W
         ytRjlyummMea6ODa13ywCNrLwbeB3UCExkkZdJx1mEZlBrinPZyUctZMxR23FGpns9B1
         GdNuA1fbhW1RkYeQ6gC4DbfGse6P2arB9OH1IWGS0whDWwYDBcxHl9vT0PFYVGP7F01n
         zt+g==
X-Forwarded-Encrypted: i=1; AJvYcCWbYt7+vSgatmSrf8fnARacI+sHWw83TnvzxZmleUVOxmTqev00afNJ4KRiQHYUNYLnX6W4plYZsxWResk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnQm10CUBXXnZr2wf7ZRdBdwWV3ZIFIGdMczfs9EF1sdOG42ll
	r0Onb4fbYqevSmSyWLHolvi7DKK42qIzSJTobmp18npfu6/icKPvA9YftYCyoQE=
X-Gm-Gg: ASbGncs7qeyvD4aKZV37Hs4UcxChEipyMPqkja2CqnsegAHE3lkojvxHH1QFoaO1yjs
	nN/Hir7qhuq75u7wH0oyW1MRCK++P7db7YdWm8QtodKilORc396s/pu6mONGpoerC+rx/eLVd2Q
	UyrJUhEb0Dny7jaVLfV5Vp1PJ0ILvDqyOgbbzfsxYtQcbpNCxZydqzgF4z2dypXIzeCSokgUFBp
	R0jknQfTT4GfW/7kpmvnjjsPtW5uU+PjA5ExlcuOK4+3o/wBbrF4zWWWy0HDrHKp2plNqikPH9I
	r+BxyTAqIg==
X-Google-Smtp-Source: AGHT+IGEMv1e/DIXO21O5MsRQ5xu7AvkX9VSUgw7Z5GjjX9HSgSRS8PPK1Q/zoWIWgCKahnDrQunCQ==
X-Received: by 2002:a05:600c:510c:b0:436:1c04:aa8e with SMTP id 5b1f17b1804b1-4362aa3e398mr33232645e9.16.1734108319836;
        Fri, 13 Dec 2024 08:45:19 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([145.224.66.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625550523sm53900665e9.7.2024.12.13.08.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 08:45:18 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 13 Dec 2024 16:44:39 +0000
Subject: [PATCH 2/4] dt-bindings: mfd: syscon: allow two reg regions for
 gs101-pmu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-v1-2-c72978f63713@linaro.org>
References: <20241213-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-v1-0-c72978f63713@linaro.org>
In-Reply-To: <20241213-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-v1-0-c72978f63713@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 tudor.ambarus@linaro.org, andre.draszik@linaro.org, willmcvicker@google.com, 
 kernel-team@android.com, Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1498;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=aKfOXqQGDukFzONr0CiKY/knEiGL73lWVm8HRLM5iLs=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBnXGSa4bgZiEwGnt8X8V7Vmo0R6b2jQKykl5ebV
 3aqYK3KqAyJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCZ1xkmgAKCRDO6LjWAjRy
 utM+D/9Lk7ruFKfWr5gVg4qeHtniwokKKn/WAgFmW2kqL04Q3frRnu3hIB8xkoQ7CTPjR7CizPf
 6UPCsN88uZ1a7nBp93Gs1M3goA2x963JhBm+AEQs+zh1Y16BBMWQIwdfExz6Nc7o5fe+igiYYu1
 LtrTWgFHIlOPvlCEN0MtjZn6RWT7aMfU88pln7puSgEe+CrY+eIiL/tCKRmsee5oLjFM5tvNWoE
 5a+tCA7o4zU3t93z95vwF/DJOucolzwDyeabj/6uMXvakh/umqYYsCIHgkHCStcPGXiW02IwmSn
 v8y5eLd099K8jyA2GQzmXNQQPNFXtXz4oVmo5bWAsWTh9qSeO0qbwPEeUJ+D0X1kzXx4c2OiF+v
 irhcrq+TtLF67/20GIpZlhrZKv0vs02CqH1VjdspQtJFKApzxMzs3x8kcoSAZFgtvp6bTCFNywk
 a+fyOEzNidOvBSAc3IGCLlJWD2pkD7XUc9i6Fy9K1wFpuGwIBsweqrejFIf/arD6z/sGKleAxfx
 laB+rnMD391eqZJGamVXGNA485w01JVITKcfxQMYWN/sABgS4bCxw8CUvSJtD+8mrjnuJKXfYHC
 oDxsOUbrO7nM3BCrS0ao6/NjDiB4yMcAjY4Kt+iB4vcJsP+IDzJh82FOP3GwxBaj8nhM4//Q2+9
 BjKjkQz0D3wdIvg==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

To avoid dtschema warnings allow google,gs101-pmu to have
two reg regions.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
I don't really like this patch, but also didn't want to submit the series
with a dtschema warning ;-)

Possibly a better solution is when Robs patch
`mfd: syscon: Allow syscon nodes without a "syscon" compatible` [1]

gets updated with a v2, we could remove syscon compatible from
gs101.dtsi (an ABI issue). If I understood his patch correctly,
it would mean this yaml update would then no longer be required.

Let me know your thoughts

[1] https://lore.kernel.org/lkml/20241211-syscon-fixes-v1-0-b5ac8c219e96@kernel.org/T/#m5ad1ed5c69f693d2a5cc54342a87fbdf3df756d2
---
 Documentation/devicetree/bindings/mfd/syscon-common.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon-common.yaml b/Documentation/devicetree/bindings/mfd/syscon-common.yaml
index 451cbad467a3..9cd9739d5e97 100644
--- a/Documentation/devicetree/bindings/mfd/syscon-common.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon-common.yaml
@@ -59,6 +59,16 @@ allOf:
         compatible:
           minItems: 3
           maxItems: 5
+  - if:
+      properties:
+        compatible:
+          contains:
+            const:
+              - google,gs101-pmu
+  then:
+    properties:
+      reg:
+        maxItems: 2
 
 additionalProperties: true
 

-- 
2.47.1.613.gc27f4b7a9f-goog


