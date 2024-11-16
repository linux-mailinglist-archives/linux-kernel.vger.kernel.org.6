Return-Path: <linux-kernel+bounces-411740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E022A9CFF0D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 14:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 616F1B28039
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 13:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20511BD004;
	Sat, 16 Nov 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nO5DvOn+"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B561B6D00;
	Sat, 16 Nov 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731762641; cv=none; b=l3AdBy3QFAzYY4MicqfCWnZJ/5nyOwZzocVKXy7LvBBC9o+8MQZT0Mk0CBTqLbmdMkiG/VR4pGB/NSJA/s3h5RA9OAcn3WAbPums+7/cqoY6yvxAkJypT60e/h8bx8i1Y5E4EP59hXQ4qm3Ysi1vOIW5a8ZR0VjvUPvbMEGpWbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731762641; c=relaxed/simple;
	bh=bmKG1M5QtMLqS609fYRRFEjJdHqQGPuCq9un4/r5mNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pn/KOVjkKwrf8CmgibmGZ3FKslaa7M0qjuUMUzm3tuuKlROoLK1NfUhHso2yFi1SAOJPpCgfqUCPCVyyMEQsYcR3VVV2yuqPq4lfs3TL80LBsFxrUPOHBqcHkr4wSsNTtMqNJRjajAe004BG2VPgyH12tZK80bCM3OpC6esYDkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nO5DvOn+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315549c4d5so2992255e9.0;
        Sat, 16 Nov 2024 05:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731762638; x=1732367438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzpXc018rB2o00GxlPztdxRwMfbhFYmITkpf2QLlFzU=;
        b=nO5DvOn+0UyrVH9iL8e6sICeIlgm/r3T5IUnDTuXMPN5csHRotxuDvhq1aJDRxL7Fo
         y5ud6zqboAvDBmETg34WjrIczzKvEg4BrqeMTxVpXtBfB7Pu63LO6PTBAPtZnNw6GTol
         YCxAwyL/Rqd1JKwTbeFNw7Fd/HvP40Qa5RuLoooNWmSjTviTpLLA8ZUS7JqsYL+dPDsX
         B5v06B6hO6e8bp29Z7hIxbIPMTFCGttUNSSogLFfWlRVePzOv5rnuPSe4XziW0b/4PwS
         +6DmfdFzjAlEC/Wf7c9Hl1Bp13hxSU+tlfiKO2nXxl/xDvrpYMLT9fDyl62DBOuZU0Sf
         BdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731762638; x=1732367438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzpXc018rB2o00GxlPztdxRwMfbhFYmITkpf2QLlFzU=;
        b=eBa419BazQPR55UaKMkdB9N44iuR/6BaVYgSJM4jzDNByCezBA/P6NZyTdXZhXuser
         J9vc9ZY58AhGkYDxpYABBu4HdrqiPS2BJ+Z0hkRPbvLPJN+RlKZYtT23fF0zQDbpdlPs
         V49yHP19Ixin+AAH6AU691aBLDOqU9fIrOBU47yOHJ5Tsjtopb+Qa2QFqy39yuXXkopH
         IMcMnAliMSIx7YEIU8GmvHtkSXHRZrPm52LGkrH3bW39EoUrrMeoo4kQWNlSMj1hUWiw
         uvjGR0lSdPbb3N1lr7ObXRDVt/ih/T843qyLJHTvW1rGnPRYFdOk9rZfifFlgwohDEQ1
         2OMw==
X-Forwarded-Encrypted: i=1; AJvYcCX4aP8llxYb3GR/IGFGNPmj+LHxEgMsVK05312W+pfNHA2JWo2LqpkS3Y9pUTYDImoHRmouulu7D6Lw4+95@vger.kernel.org, AJvYcCXnoFgkNwt1aGUhIRKktc1i+rXJvEnkfXm9PRP68mTwnm9Kg7/UYcyiqf6W5KYYX6fv7/K9uBs5r03K@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ3/2/Io4xdz//XHuWWKgNhoy5bEMW9VYN05nCRUuUg12Y5kBD
	n34LOE1zheN3AeIvpU5Bk+1LFOVmv7bl5B1B1kWnGiyKMntnumkk
X-Google-Smtp-Source: AGHT+IFFNDO1atNTAGrok23PLW2M7nLj8nDCot2WWFVh1j11h/EvLGWHEPl7rkEX+LhMWos/IkDyQA==
X-Received: by 2002:a05:600c:1c1f:b0:431:4a7e:a121 with SMTP id 5b1f17b1804b1-432df79d180mr22926165e9.9.1731762637791;
        Sat, 16 Nov 2024 05:10:37 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28ba80sm92424375e9.29.2024.11.16.05.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 05:10:36 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org
Cc: marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 08/11] dt-bindings: altera: add Mercury AA1 combinations
Date: Sat, 16 Nov 2024 13:10:22 +0000
Message-Id: <20241116131025.114542-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241116131025.114542-1-l.rubusch@gmail.com>
References: <20241116131025.114542-1-l.rubusch@gmail.com>
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
2.39.2


