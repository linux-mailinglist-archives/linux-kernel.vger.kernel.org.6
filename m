Return-Path: <linux-kernel+bounces-383371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D00D9B1ABF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 22:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D04EB214A7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 20:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8387E1D79B7;
	Sat, 26 Oct 2024 20:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npZSnxPf"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C82F36;
	Sat, 26 Oct 2024 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729974514; cv=none; b=QY9+UdgR59nAQHJwy6STqlLfj/tMPP9vBo1ECyli21q1roxKIjwcwAWHh3/DvxIERBjseSIxuogq/HL7ibe1Sdrl62oeXT+PHWXoxm4rQAiZxnf1L1N9IrzTKIcnxTN1vBnVW03sR1CJFlRe5XlbwiTvgZUWU0Qjxe0fAUv7mas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729974514; c=relaxed/simple;
	bh=pxSfIIbbzDQhlem4rS9n5rwMaU5xP9xgQizC2pOHkCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=id+y+jq30d3TdHX4y2I/3reTcx2j4s624xAbovKrbwME2vH8pLPCBETj+3y1KrXqw352DQmIOjN4RKXTra1qgiMckv+gDy7H5KfFkMT4wfzW6C9T4GOgA6EBErCRGO6ShQkYzIfCmt63nei/pYKBGUdHg2QJNoRVHb/rT4cp5M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npZSnxPf; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso46613451fa.1;
        Sat, 26 Oct 2024 13:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729974510; x=1730579310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYdW0WVK/HUf15o3sRYMMztvU9O/2v/dtyJUieuwwQk=;
        b=npZSnxPfRTljNra8PVvHd7i4PWMTyx5kulHWcSz8JG+xb8mOk4titzV8hGaS8TSbTK
         nSRmXYQIGf8mmeaEeQ+cBIliHmHpc8hFQom4MJheEndic84pLs+eAy9RTqHfUs1RKh4y
         brd4t3/cNaI4ur7F0sSxZHkuf/X7exiq7mLEc4l59hKcoe4ycfAwLcGzBl5TBeahVyIj
         Hlghn896mpUHy2wKoGIJp/hDlfvszx1fTBG6RW2FlWZClYQQVd+2ZOOA7/P+5j9GcX43
         YWaHy7X0saMksZcZ/A13KroHYBrqQgYpjKecuHfTnsuJQakXTgOvA3qYkF+HR/cjEKPC
         RuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729974510; x=1730579310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYdW0WVK/HUf15o3sRYMMztvU9O/2v/dtyJUieuwwQk=;
        b=gSfeHLryOY3NjbC7qm+JAVj1mGBU4QMiT/Kcjp6LklZmNxqNIzqvjVaOLXjRkwHQrV
         P3OxfsGlK3n/SZ71XMwymXV3Kq2FMcJfuJR8kSc4bdxOGXezhLa5bqgIHPhAfHjEEY5H
         xxaebQO6ORyiFm1KZTwMGhrznPEcsC3XwNqzIKtVP7gdLssdY0TyTogQSn6pk+7fpPuJ
         ldfEZdruHZ0s5AhDxX6Dk2Z56/8sEHvFYa+X77zFQu3nyGHTDO2LMGREr+bxNB6qQKDP
         Pw3siJs13wkYgSrS0AqLGIlxJgdVShoN+Fm8xalBGVMEEzV6Y83c44YIm203ykVJl3JU
         QeFw==
X-Forwarded-Encrypted: i=1; AJvYcCVyZd3Mg1NUGP7LNaWCRI+JHyksFrhk81HSpiFXgs817uHTgpEkHZ5/QAyRczzoBgh6LCsQVkgoLZWITz5O@vger.kernel.org, AJvYcCW/qysJT3lMENgexexOJR1csX/VltKgSHm01q1qrjL/qHo39lATl3B1CjloWGP/kuYPuaiwoZQm/Bz9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Bz0WiNm1a102LCAOulZ+73dtk0XtGa5f4omqMlthHUyyjUNY
	15Plei5u+/ForZRF4ymO3r92JTNLHkkRP8YFOqA87yQDR9SJuBei
X-Google-Smtp-Source: AGHT+IGedkOCrp2Ws7gHHAOMm/HoxIvaYQUxFfzfvXpg/O9OiKO8kLi7PH2WqwN8AADLmXnG+ExWzg==
X-Received: by 2002:a2e:b8d2:0:b0:2fb:3960:9667 with SMTP id 38308e7fff4ca-2fcbdf7db23mr19809711fa.14.1729974509867;
        Sat, 26 Oct 2024 13:28:29 -0700 (PDT)
Received: from [192.168.1.105] ([178.136.36.129])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb451a494sm6370421fa.39.2024.10.26.13.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 13:28:29 -0700 (PDT)
From: Markuss Broks <markuss.broks@gmail.com>
Date: Sat, 26 Oct 2024 23:28:08 +0300
Subject: [PATCH 1/2] dt-bindings: arm: pmu: Add Samsung Mongoose core
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241026-mongoose-pmu-v1-1-f1a7448054be@gmail.com>
References: <20241026-mongoose-pmu-v1-0-f1a7448054be@gmail.com>
In-Reply-To: <20241026-mongoose-pmu-v1-0-f1a7448054be@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, 
 Maksym Holovach <nergzd@nergzd723.xyz>, 
 Markuss Broks <markuss.broks@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729974508; l=907;
 i=markuss.broks@gmail.com; s=20241024; h=from:subject:message-id;
 bh=pxSfIIbbzDQhlem4rS9n5rwMaU5xP9xgQizC2pOHkCg=;
 b=G2bpQn6ZjZqyQNJwfwqAC4PfkPkUBEBV1PyoRzw8pi52cGKBGqKDjqX3ONoIK4vfOXmNkFOnx
 sdU3mKxBjSoCSB6Q7mH30fKv5cO9gm+Eti7W1UYrtP7l0Q26VVyuBVT
X-Developer-Key: i=markuss.broks@gmail.com; a=ed25519;
 pk=p3Bh4oPpeCrTpffJvGch5WsWNikteWHJ+4LBICPbZg0=

Add the compatible for the Samsung Mongoose CPU PMU to the schema.

Co-developed-by: Maksym Holovach <nergzd@nergzd723.xyz>
Signed-off-by: Maksym Holovach <nergzd@nergzd723.xyz>
Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 Documentation/devicetree/bindings/arm/pmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
index 528544d0a1614c9f9bddaafa8dac4782d09ac7e9..a148ff54f2b8a92fa3fcfa78c1bcc525dba1c6dd 100644
--- a/Documentation/devicetree/bindings/arm/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -74,6 +74,7 @@ properties:
           - qcom,krait-pmu
           - qcom,scorpion-pmu
           - qcom,scorpion-mp-pmu
+          - samsung,mongoose-pmu
 
   interrupts:
     # Don't know how many CPUs, so no constraints to specify

-- 
2.46.2


