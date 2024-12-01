Return-Path: <linux-kernel+bounces-426658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E04849DF654
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57902817AF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 16:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0F41D7999;
	Sun,  1 Dec 2024 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOCk5e/Q"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA831D799D;
	Sun,  1 Dec 2024 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733068849; cv=none; b=YIxokZ9CXeNCtQVBPEf9V2X7ep8G9/s3yiYuYXOYf9QAbujGuX75zUqWL4GkObwo5DYSLdDWZGCsfxj1vsViA3aKmeWuxE5wsynuvhxC/wdvRA9CxH1z73qEHxioY3sjbxplQbE98agOZvX8jhAMkxnFtL1BEzwyfIphsy0pVDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733068849; c=relaxed/simple;
	bh=JMWpSydVPFwLIP7hwqHVLy9mm0uOzzCuwbbtgb+K8o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuphyJcHsxR0DH353FuIDS2Bl3lsADKlyuXMjRuSlUMe39kOh4mYTsPF8IeuAgD0UsSe79gxhiu/ydvlHF4cjucTHklnzPBf5rhik4IexT2dIF56oHj2y5+rdL36d5KWu1IbV6rXi7RgLwj37wMY8PoRwLtq6Q/IRlAakjIRwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOCk5e/Q; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ee51d9ae30so2147953a12.1;
        Sun, 01 Dec 2024 08:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733068847; x=1733673647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TDeoespPvIrlTOx8hDFrx88LNZsHxk3XgRr9sFcF/k=;
        b=SOCk5e/QUJUQuRvSXl+bGrjWotC/xL5XToXSRlCgu7B7FZM+cORn7M2fNZd1P3hHMa
         orRtkYXsa0VYODlseiCbnHJ+BJjzW8IkT5LDW5UM6WiymVfdxbtGSbGSP+2cz+NoQJe8
         xb5v1GDDbJLbJyCAvn6eQsEUQWWy91lmcDYYvNTMTV8Y0R8RM5d6MA8gyJZUCMb8VlMn
         sjLHr2fvrMsW2mYaLeKJmi057XGYaf3U8f54QZ3Qp2feN9NKFTWhpqhA+4YTDC0Q1vSf
         CNvLAdu3M5Qs0NoOMSnhcUU57EbHP1XYhColmg1dLo7+AjOtfxWHoUmiYmvVv1bGHnGX
         p9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733068847; x=1733673647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TDeoespPvIrlTOx8hDFrx88LNZsHxk3XgRr9sFcF/k=;
        b=cyJGKq4WuEbH1qiXLMM4V6AtAUUfq+adCJuWYlQm36gobjejNmL5Jlam/4I+TYT5gX
         zfpSkkkWaMJPW+Ne1JhjnBZdcF2hIf9ZQKVYodv8y0xhT10eRQKN8WYhKWelHwI8vboq
         Ux4dZFO/B0TWceu8D2K4K2lG4i6lTFIFWqLVyFlrj/5swMJJCwP3FOrxCT4PWalXeBZ8
         EZILIjtlix+H50gwozUgFMwj/qQHQ4Aitekzxwld1rP9xRD7rLDhZ/7Z3gB62hJaYIIp
         boH8sCvXe0c5/hAnzprmXzwo3fhGVc/N8yak/GuSN6T8qm0MSq2lyDtup0Z8VnVlcXbE
         CUVA==
X-Forwarded-Encrypted: i=1; AJvYcCUaLOOX/hV8u643qJlyxCBrd2T1jouEwCMiBkQCEHBIWRWJ9eHeraFN8d2kZSDMjGcswtApzoRS+sbAQe/V@vger.kernel.org, AJvYcCVC26dk2SSCIhELBtx+3XxZoJH+FliWUxbQbd0ZMxG5F0tf/cMdXLA7EpKJ13O1xkpl99nOGYAVS8Np@vger.kernel.org
X-Gm-Message-State: AOJu0YydVztflqV8l2tvBmdr+eT5oG+aUn1OHwo0GABkI40X8qjIV8qQ
	DjPro1PTNaM9jCbuPXJ8MvIT6Ih4B2KA3zXFEeekGm53KRf5V7wq
X-Gm-Gg: ASbGncssgYxtZRCdyj6UG5NQ3Vym7/zATWbyfuf7lRXsmyOmpOM7lWzd9U0S7xbvP4I
	lEYdFsDw4K+qa0bz+GtIVyWNlHfG7Ia2igzqvvCOFNyqkn9p6ErFHkhImXrfmpzxec1EQcNnj2R
	S+d6niY10U1UXQKFRANDvSQt9xNGlMGYa/ZQLibDm0MeC0TuxlFLFZA7EdMzLrgFxfaCizietcJ
	2PONtE1809ePo/0gu/B8fpeonURu9TjUC0P3lzhg2XaES826otkeQ2foShCDcW/Ew==
X-Google-Smtp-Source: AGHT+IGrv3hVqmAY6jnCNt/owtSORP/V6bWy622k5imkOMd+IKJHnRO+Fqx1Qyrr4NmirwD+yWdaMA==
X-Received: by 2002:a17:90b:2252:b0:2ea:8b06:ffcb with SMTP id 98e67ed59e1d1-2ee08eb2b91mr24578454a91.14.1733068847505;
        Sun, 01 Dec 2024 08:00:47 -0800 (PST)
Received: from localhost.localdomain ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2ee6ebc4a73sm2395173a91.0.2024.12.01.08.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 08:00:46 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nick Chan <towinchenmi@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 02/10] dt-bindings: arm: apple: apple,pmgr-pwrstate: Add A7-A11 compatibles
Date: Sun,  1 Dec 2024 23:56:39 +0800
Message-ID: <20241201155820.29259-3-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241201155820.29259-1-towinchenmi@gmail.com>
References: <20241201155820.29259-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blocks found on Apple A7-A11 SoCs are compatible with the existing
driver so add their per-SoC compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/power/apple,pmgr-pwrstate.yaml       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
index 59a6af735a21..6e9a670eaf56 100644
--- a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
+++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
@@ -31,6 +31,11 @@ properties:
   compatible:
     items:
       - enum:
+          - apple,s5l8960x-pmgr-pwrstate
+          - apple,t7000-pmgr-pwrstate
+          - apple,s8000-pmgr-pwrstate
+          - apple,t8010-pmgr-pwrstate
+          - apple,t8015-pmgr-pwrstate
           - apple,t8103-pmgr-pwrstate
           - apple,t8112-pmgr-pwrstate
           - apple,t6000-pmgr-pwrstate
-- 
2.47.1


