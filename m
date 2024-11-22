Return-Path: <linux-kernel+bounces-418055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245EF9D5C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B157C282137
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0A21DE2A5;
	Fri, 22 Nov 2024 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mooEh93M"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7815C1D88D1;
	Fri, 22 Nov 2024 09:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732269280; cv=none; b=ayMk9oO14Oi1Yxmc+PLMKBUA/UWCG8FCwwqSgv2Yab6Qb4l/1jYJUcqnGdBINYaRfmSqnyfCVW6tru53qZUZ96zHrw3Zj5WGAwmHBZC7RYsf60UxR29R/mwhjasYVv3O/i+JuSIcvPmlLQ5nG/bJJDrcXpRnVWYEbYXjenmcvGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732269280; c=relaxed/simple;
	bh=XEarR1V/wSScu1ltyWhNi5l0HHJogogwRXsmiHTLBfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2ArbrAu5WrLt9szfSdG1u5AACaMOTbQ9iGuz4bwcRg5kJ53X9DqXdgM7vCn5VU5WiEaxnDyGzI5ZeTg3mbT07ZNDagShc7zFCD/Ml9seTaw3dxb74rvcjHNBaU3YNQQYzxIWU4FKikOMjx4zjjNmGLG2awdRTmCYCewxBGnvBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mooEh93M; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ee645cf763so1024845eaf.2;
        Fri, 22 Nov 2024 01:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732269278; x=1732874078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7y+F0NAVhdE2hhGdAP0Oqd3utvxnAK6BbO2jtHkbzc=;
        b=mooEh93M1pxSIroXeKxJh6vhou1sGgH6jh31HA4oLpicGj/5+64RFwbilyRTNkkQhX
         KhPE/QFioy14uqbSFzPE/HZny+evJswrrDVamEfVfkez9epMjmZgR2JfQhJHA3PezavO
         Mi8oY5YCRoNDmku/fev5VzONAO8G6URaVqIIoUaMyC7Isjcs5Y3nJVVQ5kAgmri65kOH
         RB82BjxTmet45yEfvjIqAUHOwdKfhb4yiKYc8Rsbcnj1H96UqUHtLqbdwPb+iMyImQTm
         xLeRCuYubbYIs0qSeYPEcyuJ6aIP/I8RNpLeWYZjIXBEs5tZr8WMaGdWydE5nCmxtEjk
         il1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732269278; x=1732874078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7y+F0NAVhdE2hhGdAP0Oqd3utvxnAK6BbO2jtHkbzc=;
        b=hDD69RT8dBLzclFwFpB+33lDk9iwa/O79NEpf9e2FC6cyt25++wrbLLufJxXZp0H50
         yW7BP5XaHCu8RAqbic77nqD1crUOwjw5BKImSYdCt4belUaUD69xFhwYtnPujWMBrzn4
         EOn5f+UaRx3J8o6N57K5XokdXcaM+40oieqMuEWaRhrUZHO3Wh/PDDz/ArjlCWSNzwi2
         cI0TDIe87PUeDVQecXl+XOf325rCj/a9SqcfxilaHZv5Cn0JUN84YgNv5hxRv9AUlWCb
         puLiKFB+CUF9aI4PTziKB6c1yeV5Df9aSsTpnEpp2cQ+C16dkfVYUcbzzgOa6dj6BR4n
         6cVg==
X-Forwarded-Encrypted: i=1; AJvYcCVTKW1wLiSXpKYaeIyBx5e8jnkkAiA7sK6ILjaXclMknMSr5D7fUBr0aLBj3c4VW5thxv6DKkAa8wN1kwzp@vger.kernel.org, AJvYcCW7hKWiKzcZxJNRO8DIhAZYR/85eBF2hSDWUcuu7dZ6uPJnxMjL61t2hfpcszjVfDVxlUWdmQA8TKnK@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/jpAYp4PayRwRUCBDCpH+kMrQXsUj59xGuMmBZOg/NVk8D85d
	lIHgXZbFWvA0YMKwNzxHJdEcZl9gawarwCbkR7ExwxUz5uvfgx4v
X-Gm-Gg: ASbGncvLG4ePxdxLowlDRspfjdszETBXLUUQpwtOsUaBzClSgzw3RWnLVzLYlDeojWn
	C6wd2KQZXwfqGfW6QIvvlrCPmxrGlTjTnw7zRIVyHA1jM2d1I0IlvHHJJZuxT1Fl7/+1ILlDZq0
	zg7SwSsTWuacNlVzlyGf9iMUASg3JO0uvUtw5DE9/1mpVziMIsCsI9Vh6WmyyM/9S0ML0Zmk82A
	nYq7slugc8P3Ikgk/5Za2IV5gwuv3BiZVMVu0AyTvLB+6q8vSJVoKsIu8zlT83/Uk0=
X-Google-Smtp-Source: AGHT+IE+gh3BSpZEe1CgwhnQPRowDufm7Rsfvh11La7niwtoGa5rKSayhi65ZAq/xM9Jk3gdgp3t1g==
X-Received: by 2002:a05:6358:7251:b0:1bc:59a1:5bb8 with SMTP id e5c5f4694b2df-1ca7970d006mr180191155d.6.1732269278502;
        Fri, 22 Nov 2024 01:54:38 -0800 (PST)
Received: from localhost.localdomain ([182.152.110.125])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7fbcc218a87sm1236332a12.39.2024.11.22.01.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:54:38 -0800 (PST)
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
Subject: [PATCH v3 RESEND 01/10] dt-bindings: arm: apple: apple,pmgr: Add A7-A11 compatibles
Date: Fri, 22 Nov 2024 17:50:30 +0800
Message-ID: <20241122095136.35046-2-towinchenmi@gmail.com>
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


