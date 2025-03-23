Return-Path: <linux-kernel+bounces-573040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC93EA6D231
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4E23ACFD8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B4E1F7911;
	Sun, 23 Mar 2025 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dPpuqkEj"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE791DE4F3
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769587; cv=none; b=PliHSXm87ZIltzFWPZI/LwbmV9LUVLl7HIqjACsT923kaW9B7dppIj4Nl30gIjBp8RJnts471Q8/X1n7w3+lDYC8dCuN2Woo5snXdHMG2wRkT/l0tj/aPHpmXC2KxRuopPixwDFSwMjFPXKjk6pi6FMOxKhB0b2A5CvI1LyQJJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769587; c=relaxed/simple;
	bh=ANmM5x/He+PE8PRBy0626kbsZRP5OO6JjTlgz9DtHdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BkoAlFJ2KKl+5aKIFMjZWm+LYPp1NZnVa/Eam3XlchqwVPH4OniPp6qRTRsPx9SMtd+pI3+HglIue/hQkYA32r6HLiaX7YQqEdLIK9SxWbkZe1sFQ5w50Cja8/81HyNDGf6BqrPuJSZC7Swl3oMGKkuH/nVaXiF2/eZDTCjd27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dPpuqkEj; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so490803366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742769577; x=1743374377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaAxKK1RdiX9Q5Rykt2k9FAZMFKWbpXqOP1fRVyJN0c=;
        b=dPpuqkEjp6AjZwnV94pKzTW+mqVLGpOch6NK0AK+r1n/E6VLnypm+gFsnPmJ3Qle1P
         rd4CX9OKK8BXaIzsFKYltvDnsT365lCGQkfcRGjv0H6Q13aVB/M2MchKrOOE8D1fUaBI
         PLWDXayWGudf1RZitnKWKNg2mMUqp8Tg+te8ZkfJ75/L6F2VAukjW61vXgdhIBlteLa0
         UrNXkktpa5jWqlf7Rt5Fzr5lmjQj/1WLB6ZXOn973Y1HiDNgmuSxmYQtQkr2xTAHx1eH
         BUObqCLjhMZRkILYVcVY9Pf8cWLcVpy8YuNkUSYbjllxwLG4LaoZzhbWcAcB80MefG7P
         DxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769577; x=1743374377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaAxKK1RdiX9Q5Rykt2k9FAZMFKWbpXqOP1fRVyJN0c=;
        b=gQ8wHfqjLEVj1eqX/QEadMfsM38X5iHSciKZLPxEdQevaCUag8iLThQ0wvYKiWogvR
         xmMPq7DPEvIFScJTNAZLSuj+AH7UakLkF+PylteM+OPBqcyU10P7GoHuX2ISFHt48tCd
         eDw33hZN19UmnYLXmwcCzzY+dKHiS54LlnrIKatXybE8bE8MW2p0+15oKP09d+A9DaRv
         2Kf+DqI1SEXndEph9gI4AyyuHo7YrEZU37fJ7Ls8lUHU3gmO/qYqjHWWfJCDXd15TO6S
         ntkbhaoou/dFfQ+ZfTbAExZ/rmAK+fvk9ghfIPnjCX8WvZ8fT6ChlivYeJ45eV2mCKMp
         tDmA==
X-Forwarded-Encrypted: i=1; AJvYcCUm14MhSpe/NOvGO4x1jgjzVDWweKdqFNCww35WH/63o4VMtwVIbMZ+SBr+zTNp1n6xIyij/SFKSJf1vM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7HFju+eT8KSBdzmumJ+nruHsn6EfTAkzAZb4h9sQXj0Ziek+9
	/0cMcobC8UfJmh+nL0NXjn/FZFl3nW5Yw3HMC6qHck5H44b7kxJHlh4xYdybSEg=
X-Gm-Gg: ASbGnct5yvJfvb+GGFogg4kC69chiBQKbc+5nBBkg4OxpiCwwA/m6ihbjXm0LTQ75iD
	X0vfDXVpa6gqtEhfe0XFoHrGwucZ8qP/eQOVfhN8HMVtglC8rdlDunQXhAT64L4/sBCeEOfl7qY
	LWUjURRKunRnqcmuyS38hpiThoPBIrb4iW5KGWtv5UxmmuamFd8wcuuIjk51BWH4hs/00PjhRXa
	58hqOxJcQ+sdLJrHPhHfR0fdjB4qnRDFHJBD21X3Xawe5OkG5YRNsiPhjikLFuXQOUrHdFJ4mAe
	gvF8NnTch9RvrkpitJumXITqHYCX5SQPkMJPhiRvhPNC4zOisYWMbHvrA6zV9LgP5VdHQEc87kV
	jZBxKmZ50Vmt0K8pucOoEf6prGeNY
X-Google-Smtp-Source: AGHT+IEHAfiBfUB/nsPtj6YObLClfT3lIBDTn7g2B2otGsQqhwkiW+Sr35dDHIHATiseMaWDI7emPQ==
X-Received: by 2002:a17:906:d7cb:b0:ac4:5fd:6e29 with SMTP id a640c23a62f3a-ac405fd6eaamr641943466b.26.1742769577350;
        Sun, 23 Mar 2025 15:39:37 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm559686666b.31.2025.03.23.15.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:39:36 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Sun, 23 Mar 2025 22:39:39 +0000
Subject: [PATCH 23/34] mfd: sec: use sizeof(*var), not sizeof(struct
 type_of_var)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-s2mpg10-v1-23-d08943702707@linaro.org>
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

Using sizeof(*var) is generally preferred over using the size of its
open-coded type when allocating memory.

This helps avoiding bugs when the variable type changes but the memory
allocation isn't updated, and it simplifies renaming of the struct if
ever necessary.

No functional change.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/mfd/sec-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/sec-common.c b/drivers/mfd/sec-common.c
index 90225b683fa083d4df7a20dfaa4f47084051e250..5ebc77d7edacbc1b7a3debb9069bb489109d57d7 100644
--- a/drivers/mfd/sec-common.c
+++ b/drivers/mfd/sec-common.c
@@ -139,7 +139,7 @@ int sec_pmic_probe(struct device *dev, int device_type, unsigned int irq,
 	struct sec_pmic_dev *sec_pmic;
 	int ret, num_sec_devs;
 
-	sec_pmic = devm_kzalloc(dev, sizeof(struct sec_pmic_dev), GFP_KERNEL);
+	sec_pmic = devm_kzalloc(dev, sizeof(*sec_pmic), GFP_KERNEL);
 	if (!sec_pmic)
 		return -ENOMEM;
 

-- 
2.49.0.395.g12beb8f557-goog


