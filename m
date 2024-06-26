Return-Path: <linux-kernel+bounces-230932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3EC9183EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913DF1C228DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135A3186283;
	Wed, 26 Jun 2024 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRWo4+bO"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8966185E61;
	Wed, 26 Jun 2024 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411894; cv=none; b=ZhrYlmhYcXUlP9Aq1tIM/KOhoqCxxV8WLtImt5BkvT7WLS5rO5kHV5+5BE/sEefNGjWs4AgEAevcheQ58wFpxKjL2A63hCxIWHEm5CyTnb1T7QbJm14Jy8r5eewLR5JTycJuEay/x0ZCcU1ztvvqw/LpiAvI/tphwz7AV9uKfn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411894; c=relaxed/simple;
	bh=5A/LPrJoCxitojeJt7eBlNk3snz2b7ebrhihpRcHwVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JP5oxBRBUtGwiuib304jxXujWapJkSDMjtRuyaNatT5o6ZtFZP109H6kgDJfBE5DNbNfxscTP1NCFWjO7W82lrNj1D0ZsiVCytleCuXYtLc7LGOYPcvFMv6rCCrAUGGjblk/NNhGdZf8mktf1hS2j53N6SbWeWSF8WWeQZCwsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRWo4+bO; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52cd717ec07so6144505e87.0;
        Wed, 26 Jun 2024 07:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719411891; x=1720016691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SI7tOorPKK3iwm2YfS1Q/1Qsuj151Q4jTdztaPUQtFQ=;
        b=jRWo4+bOCmVgEAhNcQI9xelFhKTmlnT7a6B0zYwbxe5jFKVBH9KFJaVjRCldcPH+zw
         8C3B3cGVAMVBmZsMogP66Ke95kfiwbkBL3wFeen8WV1lWhNf0vXWPkTDiYWugBQTUJIA
         6lW45G315eRFEb3O/Q0V/4d6YjhwJqz5OzQw8VWnqGkPXuqfPh2n2t/KMSd4P9mpDmkE
         ivMELWqOZON3u/EZp3Me3hF2k+mR6NJtH74MzzSR5C4m2ji0kbUCxQIr0yRprvWJbPjM
         585f868xK03VtRmjLRIxddsmjDWSL70bh3QCQ8OS5GcAMWM0JrzcGt5XGf7e2xHuxqi9
         2glA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719411891; x=1720016691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SI7tOorPKK3iwm2YfS1Q/1Qsuj151Q4jTdztaPUQtFQ=;
        b=n0TtDZpDDLVfzVPOf4d+powiutVmzeAuwYAYvjyXeAM+H1XSfgxrRX1rL21mtxZVBL
         U7FaO43upxW/8PxfHYshCKVJp5ZWePuc9QiNPLebT/aHC6N5I643vccEeWjhgLV5yGhG
         yvD6ocNuoIsS6Uxw5RFsDlquB/ZGW2GYSQIgmCLzlGzmOowK7c9kW7mxW7yX6Xqr8s+r
         Hnm4eQFJiEkhvuj+IW3+aNgGK/wFaXEP+NDyobr6nNQB61J8Bd3z51fBaoptaw8I9fSf
         T30t/w4rTulNVFh5yKtLprf/IkA6fwospiWniJxRHbi5ti83QhpYTNC2nQ/aKPxioe6Y
         Mb6g==
X-Forwarded-Encrypted: i=1; AJvYcCWuPrdLGQ3QNnt1jqUHZBYzZziSVQS3L0TvQWkTkBYwnY+oLfepp4/JcHNxXxoZDi0l7C8Ma6/bqDKlwJyEU3q1kCxBwddDueUPcKtiY1kXFDLVSWUorWd0F6TuokJwYqACC/5GFTNDcg==
X-Gm-Message-State: AOJu0Yxk2XpYpsfr1awpMjnXrkDSazrpRCaAjF702RLpJ9vlpnU2iWhU
	Jw0i8YuYhp8+43OK7vMKi50zX1ITx8NF/OweJZacVbpUnhhQJ5o0
X-Google-Smtp-Source: AGHT+IG8zpO+JCiXsxXizSvK7r6qfFUwj8kq6cSSw+bYLVfmY8xtSehyJIeuQr4l8KsyE3ox1avFQQ==
X-Received: by 2002:a05:6512:3a8b:b0:52c:e1d4:8ecd with SMTP id 2adb3069b0e04-52ce1d49146mr8869072e87.8.1719411890583;
        Wed, 26 Jun 2024 07:24:50 -0700 (PDT)
Received: from localhost.localdomain ([195.239.203.83])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cda72b401sm1496705e87.136.2024.06.26.07.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 07:24:50 -0700 (PDT)
From: Alex Vdovydchenko <keromvp@gmail.com>
X-Google-Original-From: Alex Vdovydchenko <xzeol@yahoo.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alex Vdovydchenko <xzeol@yahoo.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: hwmon: Add MPS mp5920
Date: Wed, 26 Jun 2024 17:24:33 +0300
Message-ID: <20240626142439.1407175-2-xzeol@yahoo.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626142439.1407175-1-xzeol@yahoo.com>
References: <20240626142439.1407175-1-xzeol@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for MPS mp5920 controller

Signed-off-by: Alex Vdovydchenko <xzeol@yahoo.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index ff70f0926..cb2fc26d9 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -296,6 +296,8 @@ properties:
           - mps,mp2975
             # Monolithic Power Systems Inc. multi-phase controller mp2993
           - mps,mp2993
+            # Monolithic Power Systems Inc. multi-phase hot-swap controller mp5920
+          - mps,mp5920
             # Monolithic Power Systems Inc. multi-phase hot-swap controller mp5990
           - mps,mp5990
             # Monolithic Power Systems Inc. digital step-down converter mp9941
-- 
2.43.0


