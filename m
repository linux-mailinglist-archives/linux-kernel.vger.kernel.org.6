Return-Path: <linux-kernel+bounces-383669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EC09B1EE7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912A01F217F2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3953A18E34F;
	Sun, 27 Oct 2024 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7qGsu2I"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811C418CBF1;
	Sun, 27 Oct 2024 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039845; cv=none; b=FhQnv0WoBU9VrUD03fXU2Bc13Jwc1pdm31mA8Wm5pIhnRSdApp85//jtHzOheej6mrfHAO8vmxSNfG3Gx/eg3CD1DT3mQlMOvUYhNW4dweiNKunc55q6+a+GLoQf3JH+8mFGtuY62WTdSBcuNTi6jfqBtqB96YwSh8Ugg9An3Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039845; c=relaxed/simple;
	bh=cR2fgB78HNr71BXUwO5TRA7QH3VDNc3eMnJv2PQZD7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZOZZUSAAY/5uvq4EiJMrGnxbLEP8XDOjA0+tERhQopjO9PiFoHj5jdrUdqnGomDq0IsyfPZZIfkeUZZfR6+sbxDFJyxk3nURdVsONG3537JDxu6b+CTK48zhWA+seiTbhf9qzFsCROAmWWb2uNGazFx963SCoxA2cKcWkKE4Qxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7qGsu2I; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9acedbc767so46524066b.0;
        Sun, 27 Oct 2024 07:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039842; x=1730644642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzwRCpqtu/LaKB65Sh0DA5SNke+63PFskUW28xnczPk=;
        b=T7qGsu2IsAEeSYqxL4I2mhtguIXbK1a+hUDaN9IPJJ7/SFaWDjv2KvWUKlnEtbMNKS
         jHPWPj7u2/x2wACUsA0ejcbL23uhwpyLAJNEv/QnGpJvzHf6G+dFtw4GVFqk6OUFhXjU
         ImcDN8pVVRbg54701265wzmVh1dk+NqqGYKnp/7t1zvkH0lRQf78L13SljvunJJF66Q+
         phGpZ4AFIU1+gbP9JK6LkudqMpVK0vcAAWJahEYQA1rjgio1aK97MxPmof5KhoZKlm3h
         KztWJq31/i5+dihuCCyL2wr1p6fdV0ka8/4TckziA4t5pAif+P3HPz+jss+TnMPFQCji
         e9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039842; x=1730644642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzwRCpqtu/LaKB65Sh0DA5SNke+63PFskUW28xnczPk=;
        b=bKoRyUI6fpbADNat22u/yvAj40azCi2xbJjtDfbQC0aJP9z6UW7tnwYfCHsXEYubkP
         X+yNmuAb9y2bgYOQwk0muhwjEgumDxJp6hQAmifPNyaYnvZ1Qb00J8oOBg8/V6F3Gf/7
         7vrHqUlaZO1ppCzM7Rm37bg7MIllubex1ttHb/9WhyXE4MhfHpoF78KGMU1EPP8+O6va
         I5aDF1CGECJsFBmnYPgVq4nJps+UKCINuDv8VQ595To3hqJLfLscxTIAJfXzEp7cmX34
         nJ/q8dJynjOHDsPwnUf9Tv+KL1wPlVFYB/qSSX597PVbEMWa/6gPW27zV319GW+HGKhh
         wgQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHm1iagqSJSr/MYWBSe7InqTT+y/MQN6FsW4EzWTopaJ0KNSie68RBx/W82r54w5jqAbefpfr4IPno@vger.kernel.org, AJvYcCWBHbLOJUt12PG3F5HQqQsjuGwtOJn5rD0gnipSVEo5JqCxSxj+M0B7a4QwxAJZWYLGD0jhz74CG1cvYnmQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzuYloQRzR/EBqwEMyzkE30xLxO7BstT2Az4dIzVhPfdocs6izx
	7tmp4OeRzAq3t+6rZf3xdaPFpKYkEIZiSzAK2McvB0f6hfZ1fZpR
X-Google-Smtp-Source: AGHT+IH2zIkeVtBXnjW4QXSpauXbI+cO668RHihbN+0pyLOEKCK+PSWS1k5umhqPP6pxxP1cfneylg==
X-Received: by 2002:a17:907:3fa6:b0:a9a:66ca:999a with SMTP id a640c23a62f3a-a9de5a40225mr244534566b.0.1730039841692;
        Sun, 27 Oct 2024 07:37:21 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:37:21 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCHv3 19/22] dt-bindings: altera: add Mercury AA1 combinations
Date: Sun, 27 Oct 2024 14:36:51 +0000
Message-Id: <20241027143654.28474-20-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241027143654.28474-1-l.rubusch@gmail.com>
References: <20241027143654.28474-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update binding with combined .dts for the Mercury+ PE1, PE3 and ST1
carrier boards with the Mercury+ AA1 SoM.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 31af6859d..51f10ff8e 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -32,6 +32,9 @@ properties:
         items:
           - enum:
               - enclustra,mercury-pe1
+              - enclustra,mercury-aa1-pe1
+              - enclustra,mercury-aa1-pe3
+              - enclustra,mercury-aa1-st1
               - google,chameleon-v3
           - const: enclustra,mercury-aa1
           - const: altr,socfpga-arria10
-- 
2.25.1


