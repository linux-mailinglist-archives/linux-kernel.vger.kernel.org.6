Return-Path: <linux-kernel+bounces-393098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FDF9B9BD6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 02:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC931C20EB3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CB58493;
	Sat,  2 Nov 2024 01:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LL7o/4zx"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4FC3B1A1;
	Sat,  2 Nov 2024 01:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730509841; cv=none; b=FDXJzsfhO4EryH4D2760HJtknGcSCb/LvtqKeuooM5+7+1cQb5prcy8l8H1L/0Q1Eqh23uis4ZzmGfrdVZo2xMYjDtieWlrfajqYpQPAlnI/R+hFdmO3ZdCAq6s7sWkJ9XbwwYQ3Vtlyn90w4TXa4y4uv/ODSNcu44niM9irIok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730509841; c=relaxed/simple;
	bh=XEarR1V/wSScu1ltyWhNi5l0HHJogogwRXsmiHTLBfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEtvcOTWNIdps+NQBXTsDbB4S+Qlk+82vTRxbcV6wrxsHStja0eEwIhzguF09M8nmDLRHJmL/nwD5j3TGPiOH3HxzpyYYyoxO/WHmFuOVfq+ooPiJMCneoGHTYQ9fHfMUcOtiZl/5x22J4AuUnOErnWpsuVwmgsTM0Pi/0yeMeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LL7o/4zx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e3fce4a60so2051089b3a.0;
        Fri, 01 Nov 2024 18:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730509839; x=1731114639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7y+F0NAVhdE2hhGdAP0Oqd3utvxnAK6BbO2jtHkbzc=;
        b=LL7o/4zxk+L1lQn0RzNiyJt1cNmuIxzG2rIPLSJnxIed7VQwVDwvyofsDjW5CFgmks
         hrwxefPunAL66zrle4hIKSCu0Ns8K1iZYYYIdF0LoWififjn1bnelcN/9qlRc2+fKv0V
         C4tqiDkGmhytA3S5k1DtbNGNrsNJ1xb6gTL/9tdlkAJOeRXjvZp+xt9q7t7FZ2n68dmY
         MGS6AIcEw8F1dqkRtSro4RgvGo8r/IykO4OrU6BeQFgCldTZ7/1PzKWeLYI6tRya/Owq
         V+BL43XjTLGRb7Jo5QCb0FwtWREV1Jf2929aLhkLSBG0/og41vNB3kmjnisjRoYrrjx5
         lgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730509839; x=1731114639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7y+F0NAVhdE2hhGdAP0Oqd3utvxnAK6BbO2jtHkbzc=;
        b=EJy0Ovlcs2Psu16AGyADTRPaiViGNjXZDkvjZwgT3WZHLTQeh/X0SWpRPvXcmgLt2U
         Sc+B7toU1uOHS/H13CpuulAcQ8qBKzY+c9WfFph/Kkh8L2w+0cgwompJWk0ALzvRAyX4
         MIROGudO7uLFKL8ft++qGUY8JY4iPvjkIEFCTQOFN8jYlCLKaR/urpZGK+zib0I2VsNR
         yazMoExdgBWm6VttplVeUfCqwoIRRkj0e2i5RajsHivl6eVSNXI1xbFSqyoIQf6JjVg7
         I18/c3gB6BgX/oKvKqrFvMN4on5jYAGsQnfSnOC9XgBbUZPQ8SnWkNyzJnedhWsmT2S8
         +szw==
X-Forwarded-Encrypted: i=1; AJvYcCWP/IvAq6fKb8a+SPhDkX5VxbL+xTuPk+twv5Cx9FKh4Aq0ZoLc1E0HneCKAETwOjBBn8G6VrW79P8+@vger.kernel.org, AJvYcCX6svf6KSLFiwnLHLmMtTUbPwwg07WXnJJ4XaO4Tt+/X4u3pvqRDazom1Gt0BOrogAmHyW1lB8BHW4JhOjy@vger.kernel.org
X-Gm-Message-State: AOJu0YzlMj0PY1TdSrUgNyg1WfT5x0qHJ5HmF0s+lQvc4pMKLfgrwsCh
	5wA+hAG+WjeC3sTRw8l5E4witGsj2GoETGglFVkCE1nXe2lf1cF2
X-Google-Smtp-Source: AGHT+IHcjcSgjEuTU6hZ1FVroEwjdUbcKF4FmsEf33q13uuam+xyJW6LtKMG454Bq5g6GFRLp/acrw==
X-Received: by 2002:a05:6a21:6801:b0:1d9:3a26:4396 with SMTP id adf61e73a8af0-1d9a83d6622mr32470596637.12.1730509838976;
        Fri, 01 Nov 2024 18:10:38 -0700 (PDT)
Received: from localhost.localdomain ([49.130.42.137])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-720bc2c38adsm3287708b3a.133.2024.11.01.18.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 18:10:38 -0700 (PDT)
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
Subject: [PATCH v2 01/10] dt-bindings: arm: apple: apple,pmgr: Add A7-A11 compatibles
Date: Sat,  2 Nov 2024 09:08:23 +0800
Message-ID: <20241102011004.59339-2-towinchenmi@gmail.com>
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
driver so add their per-SoC compatibles.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
index 673277a7a224..5001f4d5a0dc 100644
--- a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
+++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
@@ -22,6 +22,11 @@ properties:
   compatible:
     items:
       - enum:
+          - apple,s5l8960x-pmgr
+          - apple,t7000-pmgr
+          - apple,s8000-pmgr
+          - apple,t8010-pmgr
+          - apple,t8015-pmgr
           - apple,t8103-pmgr
           - apple,t8112-pmgr
           - apple,t6000-pmgr
-- 
2.47.0


