Return-Path: <linux-kernel+bounces-551720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDC3A56FD6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914BF189A5A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E4824503A;
	Fri,  7 Mar 2025 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ukyNkgER"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9899024395C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370280; cv=none; b=DJj04JdDR6RGwXfyXGbJN2eUYGD/TbKxWp/coGVfyhKxDtlT7OOW37O2A20/kxSXwKZHQfEzfLxV7xmiUzjLJaQYoVbeEMfpFQx9xoIifVZwanL7F7ErO2xoYsMMQODXaczmWDUKr3iIIiDXyfd5n/ryFoaypL2GCXi5YBM+PLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370280; c=relaxed/simple;
	bh=R0iwPCFv2TxOgUfGPaJWLwsVCF8ZMsJL2tVBboocnFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cbuyFSgo9xz8PYftugFZ4U9j1BLsl6d3iWJSquVmKmbrXFDTQbHLbcCj1wtWtnOnjwHT6YU2oICESkVgZ0EYwboOjBzV0vLyyMxZOWPrnYZWR/Eojhq6DhGV38tmp4s224lBYRJOugGebS7As/SUEGjyJJqcjSZTPe2xsHazN8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ukyNkgER; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e04cb346eeso3677134a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741370277; x=1741975077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRtX0Tco56vW4mGmeM52+vQurVKi/ujaJalKa4Y92rc=;
        b=ukyNkgERPNcLGrGKvroGwk1LfdwU1P+3gBkJZukd+VXrLPjj8Z4PBsrI8gYxhKkm5U
         l/WnEFtCsFDYHQ3KpH1jk60+C0ep/kJtv7dxUAvdgc3m0SF+CZPMrh61PTwAGT/Y7nHC
         2WsRvK/aB5cd0AeGXUHR0PjB7cdeBew6Vou+3o9Rj5xYZhGmnNIYxjCQNxnQe2y+remD
         sqO2dttdO/5HThVN2R0JY1wZz6eP/XXhyD/jwZyLJ4gy3TWhRZ+9lbn0RWCazc4sK4xC
         XnVQvsKqFnDC6g7W96ptSzqkmO4X1LCEsftBMxHS4OWNHowkX+4OfSmM5Z3qKAojdd7Q
         owgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741370277; x=1741975077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRtX0Tco56vW4mGmeM52+vQurVKi/ujaJalKa4Y92rc=;
        b=frmTxt0zyLiP6L8tI8sHc/igD/IWTv3oYVLX9G6Jbr9rvIJWuBaeO3itZwVsK0tAp8
         uNKLpOCyR6f61jGmd5FL3i8ncZrZ3TnmHTh4pOR9AJP0eFZvYk2GhPn36hP9dGhC7ay6
         D6uTVv+2qOTrtrQgxR5ETYgvbrG6qsu3xAeLxjmJz6ANzGriU7Bn3Md7sHwMrxa2Dy7S
         9iPN7YLBT2hWrnNPozhvHtjFYdNkp6R2tnzHvGQ9jXxhSzBSAA0ly9KgUNqbrLiwAcH2
         o7zScu2ukeJVWMm7NcOwzau70zazKX80TGwdoeggMvcQwuxO9wqrtFQXIfDmHzx0l8C7
         QZgA==
X-Gm-Message-State: AOJu0Yy9p61nYo6uJrx9PQA4sscFKymLfythHb5REBpj0bPzDYTt9kPr
	hc1H12DxfnrcJ8p90tqcBSJIP9+43V0Sav3Fj8qMhvMMYHuXE0p3rJrsIqd4AB0=
X-Gm-Gg: ASbGncuIwHkKzmWVnNNb57Z35tcOekP8yvMgloVCT5zuMbYoeotlpmmqLtHOOr0t5vF
	+5h/XYi8GKCIx4um2K8j8X/Tn7GBuw+hTkXXkkOiAb9bnER49Cp4lx7WvUIOneaG7JBvg37Ytr3
	q6Sba/NA02+p0NUQsKjEgdZCms2z+h9eFg5afoJA8xs/0KkKbSJ9NEjzzeCTe+gYJ2eKfPnvmd4
	YodImYpc/JNVGl6+cfFajuN1bpXANQZ/EdYpwHFOACqm10/oMehu+fTMrkE5n0HdwkUclxe0ykV
	CcCrFLQ/pUiNZF/rOF5wkMfqmTa1y3Rng0CVeTqNpPWKKItnuZcpFxUHbhAPZAlJgsJYAg==
X-Google-Smtp-Source: AGHT+IF/ccsziXtaWywVBgR5tMuHd8WLF+/O+0Fu4FcmA3Os5zdzdmDWc6EZ3mOvKO/z9PnXTQpQeg==
X-Received: by 2002:a05:6402:2750:b0:5e5:ba3e:ab04 with SMTP id 4fb4d7f45d1cf-5e5e24ad95fmr5901293a12.26.1741370276841;
        Fri, 07 Mar 2025 09:57:56 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c745c5afsm2803622a12.18.2025.03.07.09.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:57:56 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 07/14] dt-bindings: nvmem: fixed-cell: increase bits start value to 31
Date: Fri,  7 Mar 2025 17:57:17 +0000
Message-Id: <20250307175724.15068-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
References: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=vvMLJHbQfUn7pa1OVJZqJEDv122+kRbgZS1YYVxpPyU=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnyzN9sbTHVoHKZK3CWDl2/UfwjN0TVxhNXstCm pNyqWWbYtaJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ8szfQAKCRB6of1ZxzRV NwclB/wOvTgmQgvx8S6l57NCMyq0KBjTi5XZjIWb1OgWKnf375YD4Wq0C8Bb+DMH19BXS34SPy0 yiISmL0KgDqDxMC2DBdbShVVGT56E2B1rl3w+SmxsAYnuemNFBKbXD+HeF0gkR1FXYBS8i8ze0W 6Xa4QgCIFL8i9s7D9AG+u44bSN4HSO89vYolJHI6oLBTVaZ6ZQ7y0Pn7VMR7Q4zywR0K/KKnSCG nau1pS8WsjmKbIuE/ijXfgnkjQ61yZtibsFzQptN5jQKa3dsJ7zBcH/Y4Z8/zVDROor0zV7Xa4A x6BrXEj8lFOl0saffRJioYHhc/K1sx0m9fQCOrTrJFdsw1Cx
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

If NVMEM uses a data stride bigger than a byte, the starting bit of the
cell might be bigger than a byte (e.g. if the data comes in the second
byte of the 4-byte word). Allow the staring bit to be 8 or greater to
reflect such usecases.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
index 8b3826243ddd..38e3ad50ff4f 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
@@ -27,7 +27,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     items:
       - minimum: 0
-        maximum: 7
+        maximum: 31
         description:
           Offset in bit within the address range specified by reg.
       - minimum: 1
-- 
2.25.1


