Return-Path: <linux-kernel+bounces-573018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C60A6D18C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B147A4CE9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4961D95B3;
	Sun, 23 Mar 2025 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXVHTe/l"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905271B4248
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769569; cv=none; b=fytx/sA5YiRb66B3TY+xb2KJiCJELLK84+AxXGO/rdwNBlZxR7eDxh6zrJI1/Fwf3jfT2qiJ6mkl7wxhXxU9IpkPPpFURicghjhwBal7H2spJ9aHQ1RiGpNMOfTEqD+EToYI75SUU+gDFqPk5F3ftK8fdx15qMjqppVYBvpD/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769569; c=relaxed/simple;
	bh=ft5MMINeJ0ZFFqsyd4wk/QMt+OACxl4RgJok7sE3LxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fkc3FNI7RpkWYyIbSL/W5JFbbqP5/e6nO3pz5dpC0CDd347VpCjz5g22TR09/noneTvjX255JathQ7AYDn6tcOGsvItTO4GYDa0OxCa1IV2epNQAUSZ9EFGZXXwNRLiChxTETUCu9PXHPzmuDiE5DnvJLa+DAV+wwP/wIO0AONc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bXVHTe/l; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab78e6edb99so552690966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742769565; x=1743374365; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76PH5cHSw8HwRSSvCBVkDwYPjRgUpAN3tWdOoIM1T/Y=;
        b=bXVHTe/lCcytO1CcopVSOr+R+hBF2n7JErX0VIIT7eeqljv3nLzD9yrWhU2FJRKCfq
         nrMVP3DWwwhuP3uNfZr4lsR1IstuIYajHcIuGpOcAZCaNGBrJ5HD4HuDdhBRjsK4UhLq
         qbdb/dpq2m6Hab2PG9Qa1jvC0x2/gTHdDcRsF30MW8rFDTLPkOhKjEg4tXBCZ2b8B5s+
         TwsC1hPhNTMkD7LnUqF/Fv4no0EQ7/SZf6wuR5uiA9EntK7eI8CPloNZTWPs6F301sM7
         NtxzmRhE2IOAs5UjqFaKjDBOJVUmNa0D7LvcOOUA/HBuCoO0J+r+S7g4Oz7idMYVOLAg
         kU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769565; x=1743374365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76PH5cHSw8HwRSSvCBVkDwYPjRgUpAN3tWdOoIM1T/Y=;
        b=LXpi+B2aITcJ2d7VCHYOjY2Onf2pOQ7vx7/7JGHklzced3ByleD+hTQnHHgoumioaZ
         J9Mzb+zSRKQ6LWPF/ZMoVganhqBHPDA4vrpy9CgRjRC8xot+TXSI5I4X4OtkUfuVpiTp
         5XMwVNm84ZfYZ7fIkpvIMeIa5V+7kBhCpxtk1Mh5UiE1EoWkwknPrtDmr/uXC2yZ8JIN
         nD9K2olOOUBXLC/gVP5WViNe3w80/241aQoDJ3tZhBmiPoKNeooa8SKwcefcxAk/WJvp
         0PpBjGAafV/lQoOPRbJh/AwlrhW+XVVXgfxv2iOK248l5X0dhJgR4U63S+ufp+YJovpv
         JnCw==
X-Forwarded-Encrypted: i=1; AJvYcCXJaTzWt+RKf9v1dd7WdYQQnGZX0STrqOaVEYiea5p0w1yAkzhz0HwixfA2W2I+E56ElWUHgjMmew+qjiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNB295SCo66ptcznGyUDyMbwCe0ZmzHQFQdCTyg4LfslXmSV7m
	5drFzpxSXHBNzW3gzkda44AM3vGqPhcjnBw3LtH8xo/1LCQjiFKpOSjJz+Kkqz8=
X-Gm-Gg: ASbGncul3tYiG41CWUbLVHgi1DGEWSqfMm647vZT+qHF0Yrd6M46HsQ2ebqdztFmsop
	XK0hRhpgzLW/0fa4xtHvAxpdm7bh7EKcUdBVe3yGCxRs4eS5Kle33WvoURGbxhdOxtEItpldM6p
	WL5ciDms2oCQKNeVu+6KAGPUK8veNDvJzeNGiGUVOncPAFbQmfNrIMlRwGyI+5AgMBvQQ8Bt8Ni
	uM3f/6DdJ/E7cn12EiSac2srglxqmtJFL3CuezNFrLLOW+5VpM9Dw6YPLU/M1HTYIj1VbuZfYEn
	4acgkwbRmZtN90nkx2DPTT76jADJv1shl6oi+Fxjc7Zz5aUexsXzuCP/IqWg6XE3up17dbs6UTx
	aO93xOIOyDRZYwgwVPMV5QD2NHckt
X-Google-Smtp-Source: AGHT+IEYfWzNbR+K5DYstAqClR9nSakyWw/N8LzTya4wskfRe5KrC67EU110F2zXc4Z6WRaZMMlhIQ==
X-Received: by 2002:a17:907:7292:b0:ab7:6fa9:b0a9 with SMTP id a640c23a62f3a-ac3f208a29emr1120053966b.11.1742769564738;
        Sun, 23 Mar 2025 15:39:24 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm559686666b.31.2025.03.23.15.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:39:24 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Sun, 23 Mar 2025 22:39:18 +0000
Subject: [PATCH 02/34] dt-bindings: clock: samsung,s2mps11: add s2mpg10
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-s2mpg10-v1-2-d08943702707@linaro.org>
References: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
In-Reply-To: <20250323-s2mpg10-v1-0-d08943702707@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The Samsung S2MPG10 clock controller is similar to the existing clock
controllers supported by this binding. Register offsets / layout are
slightly different, so it needs its own compatible.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml b/Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml
index d5296e6053a1881650b8e8ff2524ea01689b7395..91d455155a606a60ed2006e57709466ae8d72664 100644
--- a/Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml
@@ -25,6 +25,7 @@ description: |
 properties:
   compatible:
     enum:
+      - samsung,s2mpg10-clk
       - samsung,s2mps11-clk
       - samsung,s2mps13-clk # S2MPS13 and S2MPS15
       - samsung,s2mps14-clk

-- 
2.49.0.395.g12beb8f557-goog


