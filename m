Return-Path: <linux-kernel+bounces-573019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DA8A6D198
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57AC61887BEF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8DF1DE2BB;
	Sun, 23 Mar 2025 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ljwy1hg0"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315C61C84BB
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769570; cv=none; b=dzJFbW6A5+S3lysoC+nRjBf/DZ5XEL2lChH48Q9G4SLGdJulFDI2Gt1jk59wMesvo2bJi7ScN0pu9JQbzGN+KSQ6d0g4feCr5RgQOPY5CzZGB7V5BHJLnTay5nTMZGx5/MOv3mpuSafosBn55NNcooW1V1ZC9YWrVPCsvmWJoGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769570; c=relaxed/simple;
	bh=UZVJoMISWFvF9aHFwyrjWSN+7tVwoe3JXUCgzfVpa24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IAg0aJ3z4wO79qkh+EOuoZ/W3wER7zKN4WOchwszoHdedfN42IUtB2MfDfzpW7rW1r3RyAHan7C3o5WjFIx2ST9ni+Xz/btZ7QmvrBCWYcyBokG3iBWHUKEbQdGd3jKB6P3At0joEUuXNYNGExHeBjD5WEgXfwST24IyPbN5kg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ljwy1hg0; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abec8b750ebso702071866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742769566; x=1743374366; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vE10aUiMRjd8RDkwLK4ZfbXWjVS481xd07k1tbR4ePA=;
        b=ljwy1hg0w7d08uwjQpIVjewXX//G/+dGER5okwBKZPEiZNQ6YK2oBUxFG3GXFLe29P
         OCvtpzvntIqjjr8U0w09CAFbhy2Ky7AvBjD5Kdvi+aTV4sN0KpidNYNx4nJig1k4I+oi
         9S+ucAq5kUlkX2JN1J+hGhC6zSta+NuKWQugSMNj+Q4cpVztQ8RD4okNJq1qRz1a7wXa
         /72AML98KCLC8/+/+qqDE3OtktZiNIgZcKCUrF4cnyLkuszV0LPBvCDP2hfZxholBsRd
         HWDaloMWO1W217gfhKlAozTvBtCPG7zvFoAGID3n5sqKgByC1zG7iIKzToYofx5b+udG
         GlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769566; x=1743374366;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vE10aUiMRjd8RDkwLK4ZfbXWjVS481xd07k1tbR4ePA=;
        b=EttG1WlIEUVc3z5+N38IUKUlwa50oqd2wPoPliBhfnMqnSUrZuGBbdVDpUXWbaUGdF
         6k4IErtAGy8eZJwBVGErZ0ZOLUIdU5KpigJ2vZ0dpr6AvK+6sDjTrjfyI5COcRysOB2Z
         H1I6SmWzX8zQIx/MWx5CfMCGI+jSY8skS6ThrUtasWJgTjUKetbjCjZ0yEtEOV/DveWc
         u2jahpbVLXkH/WyAzp23O4SFZk8mT0Hm2ACzNR3/CHo5npwMIOg3TEhlKOoivByDGOaY
         QyCeSDm4yrpTI1KUE6HBszfzmUK1xjDp+AYzP5uitG6s3uLA+s4HryWRa8WptRHgP9/E
         VEhw==
X-Forwarded-Encrypted: i=1; AJvYcCXnrjUJ8oLCInSI3UatiZL5rBRCe2X25F/8ctV+eqWT85aBybsOew/En1LxHSWlyXknJ6p0jpZd4kZTdq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpTTTghJSrj3vRGRML4Pexxs6SxJfW4kavRUiE5+d8PWEdsX7b
	59ApeEysDKqHFpkRqEk+X7kwpV5i5ncSFyurDSH4MTFEsz+e21FqKR9/2dlGqmg=
X-Gm-Gg: ASbGnct6PEygvCYdLa80t2vNqBzuVjXDVzPU4P8lnjIlpa4MAxulSOyPHACcLPwpvW1
	0VOgWgmecJ0FVnXJ6K/vG8H6FITI8pBLYGJVs8Nl8ZtsgHdHdwVaVhUS9YYtItk1GQaki8a1qMz
	NSByfDRPefnhkzBOCQ/9T4aaUIy87bJjEvq4uyykdnzfrrU46BMF9jdiP7emXpqmcOietcBxsM+
	bX9tepFIjzrXNKSKLwFEU/UBHDd7RCeWtaVVPkJRQUMe77fDdw3+uT7dZZDyzNF5y7IZZ+UI+PM
	k90VjzLwWPG/tu3utC+LTBLe5QpDHTVGN7nhmkziNgU2VMF8AHcMEPQy62Nf1RUvFogu0TYKRRt
	//qxEI2A/wU72oHPJDxJvpAUmarMS
X-Google-Smtp-Source: AGHT+IGpWEO6t55UagtbffDf7jAwBntYjANUq6862eIF7eGvrz/eDXOggCL/0jo6AVynnVDx8dSnbA==
X-Received: by 2002:a17:907:97cd:b0:ac3:8988:deda with SMTP id a640c23a62f3a-ac3f24d7916mr1017581866b.40.1742769565973;
        Sun, 23 Mar 2025 15:39:25 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm559686666b.31.2025.03.23.15.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 15:39:25 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Sun, 23 Mar 2025 22:39:20 +0000
Subject: [PATCH 04/34] mfd: sec: drop non-existing forward declarations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250323-s2mpg10-v1-4-d08943702707@linaro.org>
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

sec_irq_resume() was removed in commit 6445b84abf91 ("mfd: Add s2mps11
irq driver") and sec_irq_exit() in commit 3dc6f4aaafbe ("mfd: sec: Use
devm_mfd_add_devices and devm_regmap_add_irq_chip") while the
prototypes were left. They should be removed.

Do so.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 include/linux/mfd/samsung/core.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
index f35314458fd22e43fa13034439406bea17a155c9..b7008b50392ab857751b89e0a05d2c27f6306906 100644
--- a/include/linux/mfd/samsung/core.h
+++ b/include/linux/mfd/samsung/core.h
@@ -72,8 +72,6 @@ struct sec_pmic_dev {
 };
 
 int sec_irq_init(struct sec_pmic_dev *sec_pmic);
-void sec_irq_exit(struct sec_pmic_dev *sec_pmic);
-int sec_irq_resume(struct sec_pmic_dev *sec_pmic);
 
 struct sec_platform_data {
 	struct sec_regulator_data	*regulators;

-- 
2.49.0.395.g12beb8f557-goog


