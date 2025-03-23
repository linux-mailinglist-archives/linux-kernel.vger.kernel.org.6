Return-Path: <linux-kernel+bounces-573035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B89A6D220
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 241EF7A5DA2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7903B1F76B6;
	Sun, 23 Mar 2025 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J9mCHJK0"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41BA1C8611
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769582; cv=none; b=Yegsat+rAeu/8epROfJZJ4tlKEq/f1YyS6KmKCkMltSYHAFJfV5J+6CPRnb0oHKddoGCbjlZ7EPXP6ZFcKa0U3OTir6QrdItiEo0OUku9T7ezlZMMULot4gRS4aCke6aa/DaUZGfZ1O+tqoz5nqQDZD+uoNxAAK0nMe0Z9BEaPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769582; c=relaxed/simple;
	bh=oiNyTv54VHVM6a4w1mLQcnbnflOdyihzpGBxsT78Cis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h3qF6TCnXlc9CDeD3i62alNALBIOq46lWydunaxHQGesRPbxv9a2ivN1NciCDtQerxLcF0OeDw11qQXmZ04Wp/MuNAZnrFt7q0WOJH9pymcSdWnr+0N3hdwSvtXxu2+WW07RFixZWDanR1l927sbSvC1b31nNiH1HBvglPehKd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J9mCHJK0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2963dc379so636664566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742769575; x=1743374375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8z5p12enI9RZw66rCmwLiYXfJvqOoZz3UAG+lMt/bw=;
        b=J9mCHJK0F3b8WF6ZmLLg7q5hyFgPf6zbS7q16BOzZDU+pAwZ3GlhbJLSOWlnZ6Ebmg
         +uqjhSOaWBq5ivQCShINdIRk20HL+oZ1+qyRFMLE6ONHP2Q/qzeHrF61SdcI5z2wnwIG
         b193A0osJPN+//5l5D/uMDu+vpM2x8N/46xFyw9cjI/DJZncsPzWIZurGwQt9Ba4m71a
         C9kCAkW7fCWrG6jr0sPO3LjK8rzJCn5UD5sS2/qw4/d6qXWA/Vpm8UxX/27uxj5XguyX
         mCZDrUKbE3gl1ihzh7P3bmj2GCM0eUevK1zbErEo3EGIOt3NKoO8Ck7mMGHV49KbCPxU
         5hnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769575; x=1743374375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8z5p12enI9RZw66rCmwLiYXfJvqOoZz3UAG+lMt/bw=;
        b=ou/4FK7MWaoLIIWPYAACgxFu3Ygrhn4ZeO5wHbJjZW54rXP90yoJDBB2/r5S37+fPF
         CLQ1gGolWUW5P69uDHARaiR91Eho76EOFIBpPeYEoLagMyV5VBIM1g2DJuGYs41iHzt/
         mww+aHR4oNRwwbiLSwgngsk2UPcXfTsGVw9pwq6lL5vlhoQWd95XLqhN9nwpPqqfsTXN
         M8wydBXOna7puTO9OuGiBTj23KRhCqCWsu6PXys2i6n2r+d50kyYoWHuV7b57Idn02VH
         KXyytzJ0jS3Zj0zUEiRYm5nJFmQsXtiwzioqg3xfLREwuVZemop/w1y9kD9bmMuGFedX
         HPow==
X-Forwarded-Encrypted: i=1; AJvYcCU0AgDU4ocQ6qeaLI64nWqY1PaPbPG9AcUcbHxjqn2+5+wXhGtKvq8Lql2gd9cjU/ARGvOzXK/48wD4Rk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAFWLvZ/IFlBgIHA7z68vduAQI0tuhODTIzqPP2nu+Z4qck8XR
	xW5eYjHPRLoAcRhKwHqcEmUYEKKVm/qTZIw7GFWfC+QMwAqg2aS1P7gMqVv5HHk=
X-Gm-Gg: ASbGnctF3odAFNQfjvwu7VNCfZUbZect3gphc4DdF4v1XQkAJMymO4rhGIy9uoyeewt
	EB1Cmp3JiKthVoB07WAw/zimZZX/bREs/nk7ImGgiNAUfhQU4p+S0bNeqwD4G1KS0K0rfdnHJbn
	EjnASmwnU3n2Evori+nm1WH0rwKMRmB+kax5umZBU1W4YtGdNtGystrmIGjQvqajEtv6A+PJoXl
	D5K/9svhxkzCAPyrdyAuRB0A9e9QadRUTZvf7PE+T89wy4l0UgvSUZQaHowHzoWRuq87s/FftsC
	dFaji2/PYHA7pJ9UBfpRN9uJfnyRP5CitVKSBcdHAOtI2tulg6+0/lEGXiJP+1OvKxb/5K7b+06
	a1ANgJdC1G4WDIUhquMTnpDi4qTyS
X-Google-Smtp-Source: AGHT+IGe5qmoAcXMWbaWHDRmab3UauFteJoVt09a7sGbTlNJP0cYBqQFxBHjhU8bkTv1Ztr/PWxw0A==
X-Received: by 2002:a17:907:bac2:b0:ac2:e059:dc03 with SMTP id a640c23a62f3a-ac3f26aee3dmr1087374966b.38.1742769574917;
        Sun, 23 Mar 2025 15:39:34 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm559686666b.31.2025.03.23.15.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:39:34 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Sun, 23 Mar 2025 22:39:35 +0000
Subject: [PATCH 19/34] mfd: sec: don't ignore errors from sec_irq_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-s2mpg10-v1-19-d08943702707@linaro.org>
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

sec_irq_init() can fail, we shouldn't continue and ignore the error in
that case, but actually error out.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/mfd/sec-common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/sec-common.c b/drivers/mfd/sec-common.c
index 5e084e2c389ea6d509393be93f7e2d39a795a60c..bec8f93a03f7fd794beade563d73610534cb96b2 100644
--- a/drivers/mfd/sec-common.c
+++ b/drivers/mfd/sec-common.c
@@ -165,7 +165,9 @@ int sec_pmic_probe(struct device *dev, unsigned long device_type,
 		pdata->disable_wrstbi = probedata->disable_wrstbi;
 	}
 
-	sec_irq_init(sec_pmic);
+	ret = sec_irq_init(sec_pmic);
+	if (ret)
+		return ret;
 
 	pm_runtime_set_active(sec_pmic->dev);
 

-- 
2.49.0.395.g12beb8f557-goog


