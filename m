Return-Path: <linux-kernel+bounces-418056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0625A9D5C82
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01CF28168B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D226E1DE3DD;
	Fri, 22 Nov 2024 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWXO9rGe"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8441DE2DE;
	Fri, 22 Nov 2024 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732269284; cv=none; b=siGtZURqxw7F2NuW0/oelKRq/Jq1zvwxcxVVOaZ8gAPRVsoyXQfezfGu6syTA04lcYrDF+7d220D3X88f81MkZIBHuDplZpsQWhsV4c3xbD8BNAZI+PrP1bLo2bizRmzGl+xwwIWLu8Haa94FfcNu6OSrBLllbDcMF84EFGF3m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732269284; c=relaxed/simple;
	bh=hDRg0YaHnMb/3mj2Hdxk7ZixHZuwBUovjfJTVCdFUAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgAg7XRBb40kAGD35DeRxteXIZAsPoxMnZhGLM0CADYa5CllkW3hWXebpYEBcZrU8dWECZ7qu8f8+/4a2AH7zWslX/7ceM/1lGZLkEZXFhzrZVbXB0nT0bzV74PyTbs9c96IY7P4Imsx6Z1W9CBqwHtxfP9T8trm2Kk1UNZ5Zq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWXO9rGe; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-724e6c53fe2so227619b3a.3;
        Fri, 22 Nov 2024 01:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732269282; x=1732874082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAhPP1Ue2Iis5GJtsj6WYVFqMLGyqRg1DOrYPcB4peg=;
        b=IWXO9rGenowo38JF3FzEnjjWTOEh0/L1R6xJBHsrLsw1wP2jFA8+DB83/4HXzRpH9/
         YtFKjT1/bxhNzEMI/GVZANhhycoYIqheLXXmbwcGLBvPF8QL0wCKVqU+d5dZApA2zWgy
         oCUQdqSlKrA85Qk6Hh9bY6Yvy+qDltGNs+RDGpY86HEXPX/rUaIXmtO/TdKKGA2HlJ9/
         rMZLMFAC7s1eS7F/iN5RK9UF9G3C3F64JF+Q84jwCKmEgrG4Orl9CCtu7o2smI/h/6Gw
         L/uIaznghUz/raMQWFD6MFrtsNoe4+3eWk9R8/mbcSQEwagh4GVcu/57Ag2n5QJdECJe
         pYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732269282; x=1732874082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAhPP1Ue2Iis5GJtsj6WYVFqMLGyqRg1DOrYPcB4peg=;
        b=BDjAEAzin1BsTfYJv1IDtNShd28ppuSbVshENE45PH7ql3yFAk8Kg3etyM2iPXGlVI
         LRT857Tx9ncRKR7hv3WJhl4LXFwGCOfNRcDQnF8Nk34Xn6ANo0aM0xVaERSnNTRSOKj5
         2WqoVdz8VkxbufkX+o7JPQ8ljajczCmT8r+mznIokJLT+3+keIdbx61YjzyrM3sG458d
         xOM+Apd+QVpw3kxcU3Igkv4VhoM0Uj96Biy1xWGNYGqthpM+Vf2/MFJWPY6lok5OpTej
         eSa3IZT+2agbvpL4iPJsGj/9c8PepuIS4/Q7IeLvJ9xh8NCirdn5i/lnxSIr/FUsWB3H
         UlmA==
X-Forwarded-Encrypted: i=1; AJvYcCVXCb/MasCxzIW6HsFmUIoJsZQts2w3CIRXvb2gWp79gfKC+g1HkhbC6gaKRvgXU2fyskpJxrTKxnwNwDki@vger.kernel.org, AJvYcCVx/VzZ1IJV10F/YLaBfQzVlLyI2jBsgoK61FeQgnm6IPzBNT9AFwXKQf1i+aNygbxV4Kdde4bKLy0J@vger.kernel.org
X-Gm-Message-State: AOJu0YyNE+t1I1EZ9MInt/yBFD5eo0pmFEsW3vSZIWSWg0RWust8SITy
	v4sJb/eGHKPZdtR/xwmU8etiW7IHR9b0GYHO0H7k0yb28fh/4fsI
X-Gm-Gg: ASbGncsq6yBt0h4hEiFYD4mAJdQUDKSVXMDmtmhVb612tRiBJk4mpXD81ihNHSKQzrw
	xfZbVbB/j8JXQVD8GVyYvoN10ehLh9139WZ19kc60q6actvBWfxYIFcyZjRanAQ/CXaksFvurXm
	oFBTRVniOPNatTDiYVz7ZPKUNHc0EcznyhVHeO75HjEPqbXvkfhomA74QxcTPgaWglUyI5nmPJz
	0hJ1mD7q+77Y+g/3l4i0/wGTwWzBMaS12yR+6S1EpLSt5/RDGFM2CLr4kRAXkf9alQ=
X-Google-Smtp-Source: AGHT+IG1mSXwA3TMBrA9RT10+LRaQrL46redGKLRvMQJTuaiKJytNKP6/Q6IsAaMKo5OeafMhXXAtg==
X-Received: by 2002:a05:6a00:98d:b0:721:19bc:4bf4 with SMTP id d2e1a72fcca58-724df696daemr2863138b3a.23.1732269282031;
        Fri, 22 Nov 2024 01:54:42 -0800 (PST)
Received: from localhost.localdomain ([182.152.110.125])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7fbcc218a87sm1236332a12.39.2024.11.22.01.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:54:41 -0800 (PST)
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
Subject: [PATCH v3 RESEND 02/10] dt-bindings: arm: apple: apple,pmgr-pwrstate: Add A7-A11 compatibles
Date: Fri, 22 Nov 2024 17:50:31 +0800
Message-ID: <20241122095136.35046-3-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122095136.35046-1-towinchenmi@gmail.com>
References: <20241122095136.35046-1-towinchenmi@gmail.com>
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
2.47.0


