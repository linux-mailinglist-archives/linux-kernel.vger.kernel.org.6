Return-Path: <linux-kernel+bounces-183204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 887E58C95E0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 20:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3940B1F216C3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 18:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26856F06F;
	Sun, 19 May 2024 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yKwztwGk"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1006D1BB
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716144161; cv=none; b=i60EEvDnRBbtTcQko93Sjs7SVNNciqqu1vqEO7WdMiaaatjX8u/mUrW3qAIiHjri1cnCRUGTOcUrSEStGcCraZNsmEfP4SK9uo2c8WVXY8iiZc8kD7BJ3P4G9qLHcbaWqdAT11gkhJXfho7OqIf8fxxbd9djiH4jrCDQxSXzTeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716144161; c=relaxed/simple;
	bh=EqrHKI7VqbulYVlL7ynNasI0rcDDscSlOl3m111YLJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Br6k6hKw9fdfqE1ATfeXSkIZWuOAbxnxFI9aBql7f5DmoDKrBKlBc6vWCLV6XQyKSaNSEb4Meesu+nLjyp7pfvnrcpmPPBriF4dLvPyBvLq/ackTK/b/TUzilfjxsnfddx5uJ3gDwyhFEmmd/eAal71cuvTQygvAjh9nT3B1cqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yKwztwGk; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-571ba432477so7331966a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 11:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716144157; x=1716748957; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpZwSG8AUDPUPcQ/cg7yOTW8I5h5fbBcK+XT13gbyOc=;
        b=yKwztwGkQvymsPkrF3CYlmde7DTcvlbtm6FB5fx0xX/eKt48mVXzfBbjJat/xXNh5A
         e+zlOUGrZOyS79K2VdUAe6tGr7WkQDheuMh65R6QCmS+hycNMhbxANEL9JXzETr62SOs
         QxFKkmNRz8ubbgk2pKy+HkGhvcGeT+wGhsPBzxCPYx2KWy0QsnKd45+KeGuzHlMvSuX4
         UYz3J84P3dSQhpfo3rqtnj5mHAr/XbjhumvChzwy+nC4kYQtdgdQKbWYe09uLlh3gLVT
         354YzBIaG/ZviSpnSbu1yJl7y4OUCN9Ra9oMyKUvp2HWbUMnjBSd7brVszkXmo9viI+J
         etUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716144157; x=1716748957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpZwSG8AUDPUPcQ/cg7yOTW8I5h5fbBcK+XT13gbyOc=;
        b=XkOboLyzM9WGLObVc0XJqa2gK641EDHxgCeOGHMazRUnQ79PiDADC6ooqKYZTHyInG
         J3FppGMyRN76e/W3EFnuyxIEDPCDf2IhiDS+hZaq23pzmRyWmWQf4x3U6XOjiiCAmL/0
         Kk6pMQSZQZZM3taB5C9UEmpSGj74rxa+Hdy4lxrhIQYYyVNqSrNztCPWWZkmIt+isvfI
         Xh02xeEe59dgbdQ68YAtVOht24n1BlA959EA8ewSv2vOw4OvfNXh+Om02ptcRkmK4I7f
         wWcB/BqnsFfZZ+RB13dmp6B4Irux7WuybZS9vjHRjn9YIrhWat20T0oTEsKjcV1lmwD7
         Pmxg==
X-Forwarded-Encrypted: i=1; AJvYcCV67ogWRAPUGl/lO4jhYjN0+Ro+StuUozukdvANoDwHdgtGQFqGPTcqvPoIAEfert5SswUfEEeQzDPFXDFxURjYqAqu4zJFsxWG6hCm
X-Gm-Message-State: AOJu0Yww4O5m7XqJqkMurqOjBoXxLaDqMe9WBfarDUvlY/7KTJ9StrAs
	jLVNQQcxV19ffmuh6g/wgmQy625sLkPBx7Yo+paXL7cNZLjYc5uDBdHq0UTTNBQ=
X-Google-Smtp-Source: AGHT+IGq5QA1nd3Au7MNo1HsMLjHK/fKiObB5dGcnX8+/eslrDY+fDV6uC0IXG4Am+hQUeL97oiW3A==
X-Received: by 2002:a50:ab47:0:b0:572:9984:1921 with SMTP id 4fb4d7f45d1cf-5734d5bec35mr18573696a12.17.1716144156802;
        Sun, 19 May 2024 11:42:36 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-575313d97desm1789397a12.41.2024.05.19.11.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 11:42:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 19 May 2024 20:42:16 +0200
Subject: [PATCH 1/8] dt-bindings: mfd: syscon: Drop hwlocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-dt-bindings-mfd-syscon-split-v1-1-aaf996e2313a@linaro.org>
References: <20240519-dt-bindings-mfd-syscon-split-v1-0-aaf996e2313a@linaro.org>
In-Reply-To: <20240519-dt-bindings-mfd-syscon-split-v1-0-aaf996e2313a@linaro.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Nishanth Menon <nm@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=798;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=EqrHKI7VqbulYVlL7ynNasI0rcDDscSlOl3m111YLJk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmSkgQzbjNRKze4/tMYsq0YCrgQq1HylGQx0Qnm
 fqs4ZngdWKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZkpIEAAKCRDBN2bmhouD
 17QrD/4qpVSOIgs2t0h8pAjNveQargz+qOiw594JnIjDv6W9T5TOx98Bo6TUfs4/dOlgAY5xYli
 0FjQ6Ci8fX580v6LBDTyMzc+nVynHVOmYzmYpvbh4QxfD+Qxra17DEBwcB7F5fg52ZtQGz7lyvh
 rT3LhCwP0H/dp6BAqZRx5X8KCMt2Z7S2w+hbeEMJg6SLOQlIVrS9Uz1kOVGh4hie4ul1I8AXgEr
 PU2JfdPUgI2cRzZyU24CdOD8r3OVy+G+tPKAdU7xcOX+s7C7DpzIt8j1eh9f9wqABaSbUr49cLy
 /MUV00fMYeJD6YUqdtDYuRQdHv5fCRsrb5aqn90Dr85Q10QVChqIHOK5twXFpbodDbxUC2Jm/BQ
 lOfthfNcBxd2CO8POoeiZz1ngZ6ImW5XBCuird02ojDd8Zr8ZQ3KCCnR3AHoIdNCSEpNScROLJY
 SlLcUXAZMj2tCj0/T+cezMOpEsEsUm09HCPuHF1JOOxwth+Ie1zhC8zyxCkEx6Hju1fsNF29jE9
 JK2y1Q5XbOIPL+yOy53hO1EyI9MudcamsNusJ69cRtxodgzP3wJ/IKIyWRmUyc/p+OToz6hDAt4
 SDCiB7zwL1QcJ/K4g2cOnE2bxDuzmviGpLpyoi5X4/+57XZWhBwMDmjr9JyLNoQXLcXABaNQ7U/
 y86LmG1E/OCfb4Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Apparently there is no in-tree DTS syscon node having hwlocks, so drop
the property to simplify the binding.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 4d289935c08f..622ea0f1b08e 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -141,11 +141,6 @@ properties:
   resets:
     maxItems: 1
 
-  hwlocks:
-    maxItems: 1
-    description:
-      Reference to a phandle of a hardware spinlock provider node.
-
 required:
   - compatible
   - reg

-- 
2.43.0


