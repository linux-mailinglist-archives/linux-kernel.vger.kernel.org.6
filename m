Return-Path: <linux-kernel+bounces-440943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E1A9EC6C1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263991676A3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBC11D88CA;
	Wed, 11 Dec 2024 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yQ4maqbK"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7986B1D31A5
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904944; cv=none; b=q9wbvAlvWSCR3gWo/M3LOszn5W5vSpfwqUyDzdcS5IHaSQcMISCEseauw/L4eoXdVfl9M/n0CsHF3AovXAhU84QALJjLPIZnUA2sE6Pg+F+SM+xfTxk35tCCReYa/bGAJ7NRvhWds/VA6lvWPQGPxXPSMyNLpZUEYCHx31QEE4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904944; c=relaxed/simple;
	bh=4v3oOoQWSli7YbuAxSISycLPKQIV86edayFLunvbPT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SkVJSVvVBhPyQMGps094S7Mxh/KCkshBDn7kZXI3afwOQU9HqIO2uChBwa3Q43KSfUNITxn6JAhoIp09Sdcx/4QMXBkFNlx/rMceZlPN35Lp0hlG8zXP+ASmhTCU97G3EWsN8oU+Ta7cXkCVZKP/giuUL+hIwI4y9R3jYFoTSh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yQ4maqbK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a736518eso71156475e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733904941; x=1734509741; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=faYUbZmk+oO0+fwkL0PaNbJ1ed0r1J41R6DIwAiEqhI=;
        b=yQ4maqbKrkd8Nhfm4PmVgTstboD+YAFo64fa51QHgH+o09IqSYJqy5PM5MuLSiFJTO
         fhMM5SoJJ0p6bue3wixlUr0NUtApYjbKDQPgMbCtkzU6JL1p0hvdHzGE2Qrymuv3654M
         V/aJfzyVDESk7H9IGv4h6koTRvSJh43sMazVPPd7lTko9+OyEC4aUwBNaZKMelxSgHbl
         P7dr6xzCm8W66K8StlfjHv8SFVs6M/DhfIwvg0OV/lH3xJyHzKE1ZRikAUFapP3B11pI
         +nCba2sgeAb+kwx5EDTTSxlC1Buycon3pD4p5UU0em6lJFK2hOrXIFiEh26yub2bv4HC
         PZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733904941; x=1734509741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faYUbZmk+oO0+fwkL0PaNbJ1ed0r1J41R6DIwAiEqhI=;
        b=LT0GYR4e63yqfUzLnbu4vKdbyL4PtKE7gA5w/vUvclNmijrn2duOUZsqLo3o798j7Y
         6FvnTN2xS7gmrXflXh4df9V37DhPZ3Z3vC3Nsu45D2dYny+AjZQO0x4tXM2ojMmoGwr5
         HOQF5lWYJcgIUVCtpioYsXIh/RWVAlP+PTjsRoL4D/o4LgWX7DYAUYoQt6Ib/7vo2CUQ
         gCurQtUmUyGBYIIPjfCyQItxnVXUsT6YVKx0GSS1Jh+8/MlxrSqXhbbW5a1oKF6TtBhW
         /o+mOw9quo66N4cr+qMDtXf5l2YmXjeygHB+PLzCazUT3aJLiEc3EbWy1JtYpTySzHoP
         xuPg==
X-Forwarded-Encrypted: i=1; AJvYcCXNdyGg/+u4tqXqNgCl54HNggbasyNcqcZzcwCWFixXjFk+zt4GCwYvBzXYt5tQifvoGW67RM2JpbzZOFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZxAcInWCCIU6wSiWxuPkIWeuHVA2P0UCaA29xA2gX/hpaKgrL
	2Ccob8BCOfpFABY4xodEgbp4Tg74IUfJ2Y5y6lzGqFdjY1qJ/fKTgv2r8WRS87cqPUkoJDq8yg0
	Lxxk=
X-Gm-Gg: ASbGncv+Z0CFrCQUS1HbHRnQM3E/a9/YYSKG7JSB6OaM4Ei5jpxGf7fT1yIgTpB+S0l
	QlCrEAlDeENasnBzZze/uXV6Hlo8DoWjLWN3ehtjX1kby72A8rrkb+DgRSj3V6w44myGBt9PDRs
	eqepgr+o9NRxVk67NyykicB/422pB6cXBQyWWFo/IDMdmoA48pxHga1ssmYFYLX5EzviuRRcS85
	0AsobgKwi5UaPcIeIqwBywGKeOD6Y/Jr2Tn+pEGV/zywMatDULwNLZMZX6DsVm+GY5uDiP6+kU=
X-Google-Smtp-Source: AGHT+IE4S+mxlPucsduby3hxGoJOYZe4dTUNN1LQHvVuaK6BTjme29I5UInUU3EsHl8AVbhn6PWYUQ==
X-Received: by 2002:a05:600c:1f18:b0:434:9ec0:9e4e with SMTP id 5b1f17b1804b1-4361c43dc32mr14094835e9.30.1733904940786;
        Wed, 11 Dec 2024 00:15:40 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361f6d878asm6231805e9.2.2024.12.11.00.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:15:40 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 11 Dec 2024 09:15:37 +0100
Subject: [PATCH v3 2/2] MAINTAINERS: update dlg,da72??.txt to yaml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-topic-misc-da7280-convert-v3-2-4df87ac08881@linaro.org>
References: <20241211-topic-misc-da7280-convert-v3-0-4df87ac08881@linaro.org>
In-Reply-To: <20241211-topic-misc-da7280-convert-v3-0-4df87ac08881@linaro.org>
To: Support Opensource <support.opensource@diasemi.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Roy Im <roy.im.opensource@diasemi.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=4v3oOoQWSli7YbuAxSISycLPKQIV86edayFLunvbPT4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnWUop90QKan0aYnZGtYX9JKYn5D4JQLaPX2NH83m4
 verMwPCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1lKKQAKCRB33NvayMhJ0SeRD/
 9nVqw+ZxeVclqcLK5TFO31t4fKLZo6+mXk91vSrpyT+1txgqHOVT/053MCi8Nt/trcHJHh05sMr2nD
 0TbRjviiiKNl1oB2o/k1e3C8Ssab7UsADan5pAPzsXoePqGt2MGgUklGG/2yp+75ZcVzc2+VVjepcU
 ZkzfkxevXcjVQ+ZDEVdeGdgHzFXVbPWfqubpyBZUfsxxxWR3C81rL/YKjpV0ruz5mpZgWksK18rna+
 PL0R7if8i5sIJKM4BhJpqQRw7ikveTcwwfVb0vX0z05N6PQXwh2DRZmo+n9UiGEeUDl/Rsg/JX88LT
 v8Q0CXWB9RTm5FYDD1Z9lVVnNkJjcll6ZffpXU+sU6ZSY5/lGu9tE4mzCJGubN4y6GsV32+0q8IUww
 iZ1/4oXqDSTUmY+hSDYhsdtG/NeS9LkVqWRL7idn9Q2vT7EV/6DqT2oOALfW8/ftNSHWbxcNPmgOQQ
 zYdZcpxADKLJpcQ7FrJPdUkK6sZH1No3BUn8rLDXBTxzc2O49X9Ia+hGjwJN5PMrJy+ObgwdLwgRdJ
 cTiF548P0DW2PLjWu6UiyJB+i8fCYf7iH9fIUf/f+IdXyYdXEJ/kPQ7CvUwFpc8h/S11i65c0j5kaR
 jre0BZGw+p+yTF5xzPGgOyJ/YCUnJcCkvKAdPJB4K6pPg8EO7fObJAaPburQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Now the dlg,da7280.txt file has been converted to dt-schema,
update the corresponding MAINTAINERS entry.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412070625.zZpw80SM-lkp@intel.com/
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6cca913af7a8b21cbea32e0fa65372e3c18aabe0..a28ee868193a161e6ece558303cb54dfcabf1d94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6684,7 +6684,7 @@ DIALOG SEMICONDUCTOR DRIVERS
 M:	Support Opensource <support.opensource@diasemi.com>
 S:	Supported
 W:	http://www.dialog-semiconductor.com/products
-F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
+F:	Documentation/devicetree/bindings/input/dlg,da72??.yaml
 F:	Documentation/devicetree/bindings/input/dlg,da9062-onkey.yaml
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/mfd/dlg,da90*.yaml

-- 
2.34.1


