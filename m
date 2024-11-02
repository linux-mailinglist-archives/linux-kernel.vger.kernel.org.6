Return-Path: <linux-kernel+bounces-393099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7659B9BD8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 02:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EDE2819CA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098EC12C54B;
	Sat,  2 Nov 2024 01:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uzf3Qbla"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136F773446;
	Sat,  2 Nov 2024 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730509844; cv=none; b=XAwtWfJxrNh/fWwojCHJjG3SUsfvYMm63g6wTDAv5hnBwOvesauk6MrPNX7SNClR6bdP8az06cNkT4L31/i8U1mTL1vyMamWSvb05SjrNQo2KCAP98KkyJA2d/831iNLEG/aa1SrX9O7IV1E2YxVTus+AE8Hws+UBP9bCJLezsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730509844; c=relaxed/simple;
	bh=hDRg0YaHnMb/3mj2Hdxk7ZixHZuwBUovjfJTVCdFUAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CORL9HcQaDOTIffXwLsymbXvfPg4LHyIRvsm8LA7uzQQlsykpZVQkLLrkZyzaflVp8WYj9wP78AlXYt6aW/G7kq3bb0+OanOO0wAvllHO+yW6GLW2/FyzXkq3tVw12dLHqxya4ih2y6KAtH4Vb5kmRYFbFHbn4fDl2RAMO4aHK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uzf3Qbla; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e983487a1so2112196b3a.2;
        Fri, 01 Nov 2024 18:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730509842; x=1731114642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAhPP1Ue2Iis5GJtsj6WYVFqMLGyqRg1DOrYPcB4peg=;
        b=Uzf3QbladD/nN/gshRVp2pNZ7kJabpJ9P6oREUAUUeDk9zwe66edwtjrKyTjQNwfjW
         BaN3Qd1Hr7woYbR/DDNRa6VQFRx4TN0y/vNC5797KANj7pSPNT7tP44fMrsKcTgnh6Mb
         94spX/RjVyidJvszDkNeNIpplXxGdbTBjlwTiS3Oy+BUuXoHFR0UVh2IU53iUgwxupRm
         7fjOcpt/fMkTiCxsBnnrpNbIWq7ibpkRyGD68hoGQB2+bZiGva8R1In1Vr72cLiP8JXp
         nuchFcoF+WqlTnb6QTVm9jx71/lLckrI1q/AmMypLwamN+RaMNxPfcKFQSTbNFKH5YrE
         ryMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730509842; x=1731114642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAhPP1Ue2Iis5GJtsj6WYVFqMLGyqRg1DOrYPcB4peg=;
        b=txwnGHZf3mBmZHCgnNk8ZnR2wR4jMM0i9pQyJ7pIMCrNYpu/MMFdoSH5jmCEEI28+m
         HhbmpVjGAD5dfr0+/bGZJNGY/KwHCahMPk1cSSXAUBQpZzCdTig2AWu0eFl4urPAWYR6
         Ur/svXVkIJw4ZgLuybQ3HxYeNqltIuGu3dBMDLghcKsUD0N1DUK3RKmP0iVP36A0u03C
         PMWV4woSw0uPeftKBd/i4QDRmTg7sVEhC8lDLKAMgCCb6VexRUO0yRtjyuxjCy5DyG44
         9X3yTTRhX8Fpxx+H1fvdBL5SJgRDs7U/0J59mgbAl5JqDQvpQoqJxShNh3+x7XHNPJEM
         fn2w==
X-Forwarded-Encrypted: i=1; AJvYcCU6mi9B8whUtVm0any/ZwWKwUBVf5worUYk10G5uNU9g39yTGayHEVJqjsJecLxh2QDTUjG6HWDSNP3@vger.kernel.org, AJvYcCWnXLtbFTkodyJEEq+ecqQfB4mGitlgHo92vQd7xNfISCtjEnSIvFYQVjE4H0vxGGWNR+faRgAsiGAmCBGh@vger.kernel.org
X-Gm-Message-State: AOJu0YzandRUh6xNmTKaVx5i41gRdGBB5JOpAPt9j2y8KktsRhotECL2
	fb74QTc3ni8g7yx6EujWmKzIKAT2HVOQrVFSAA0WEkYXheLB8ZHoFpO/cw==
X-Google-Smtp-Source: AGHT+IHglVfwgkkjP7njhQl+3LEzj6gkB4V5uSI54EF36HyRqGCWy+P/+5iuFidHPUysoa6ehfZecw==
X-Received: by 2002:a05:6a00:1817:b0:71e:5b92:b036 with SMTP id d2e1a72fcca58-720b9db47b8mr12441036b3a.22.1730509842363;
        Fri, 01 Nov 2024 18:10:42 -0700 (PDT)
Received: from localhost.localdomain ([49.130.42.137])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-720bc2c38adsm3287708b3a.133.2024.11.01.18.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 18:10:41 -0700 (PDT)
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
Subject: [PATCH v2 02/10] dt-bindings: arm: apple: apple,pmgr-pwrstate: Add A7-A11 compatibles
Date: Sat,  2 Nov 2024 09:08:24 +0800
Message-ID: <20241102011004.59339-3-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102011004.59339-1-towinchenmi@gmail.com>
References: <20241102011004.59339-1-towinchenmi@gmail.com>
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


