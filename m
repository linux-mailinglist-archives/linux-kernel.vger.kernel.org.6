Return-Path: <linux-kernel+bounces-527148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB0DA407E9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0056619C4E3E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41EE20A5D8;
	Sat, 22 Feb 2025 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2HrigOm"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FBA206F3B
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224228; cv=none; b=OfcyWeCfqJ/FN4Bkb65xFsv08jIaGU4d8Felz+Q/FZ7dQz1lgBSOwbpS2RPjmnHHj3qz6kUTYVGKo+8NI6xP3rEv3qIQT/dhq3F2eWvzAekCSbKPyJXWh14JjunrM2FOGVrXaQgqM11jlxlfhv+tYLlJYZsjp3/XetY3MXWA6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224228; c=relaxed/simple;
	bh=engwHYjDHUvj5xuN0uVA1wy0mwimzTOyn6troBr6yjE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Kjnspymg6mlF6jM5UJNQCEz88/rBDVbtIrT3gBct9i4uJYWcRagrqahTyHXQcUMvSfrnib9SlEVJaJ4WUd2pUPEr88obDOu/YlMebEUJwZ/6YUMWZj96UDFLEQS02d5LtS1XvRGwZVfHRji91VbU8Pw5beYcefThLTQnHDc0KJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j2HrigOm; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ded500589aso520963a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 03:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740224224; x=1740829024; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B/Sh5oQxHFbDw+IPrUqtkewc2J8yrZ1ZQ0Og1f9xPRU=;
        b=j2HrigOmj/KNTv2NX1UfXkwhHi9cl7wFECX0fqy6durlh7oZwnZRmcuHw4yUj7OdA2
         mqpPZaOmYpg47NU/5yWjYm2FYMfKTIeQNzfvVXJw/R1NQOsv9Mo8IWR/x84fFUYV2VYS
         45omuJaD0c5FUi0S2v5zJ6iZIpGjpUNq6NdqnOF7B70c3PO+v1jGiIw3dBBShkTVo2O+
         ET3wQjDB/JNPiXkrqRjaNS/Lcr4XhH+BF1GWn34JC7dWUcYOnaQSJLy34CQpD4gGE1z2
         9O1THgCFVT9kCOWKHa/ejly8qExdJxBQ2taq6l+Pbw9ZlZygwK+ISvByZ9i59tXw3WDO
         U6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740224224; x=1740829024;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/Sh5oQxHFbDw+IPrUqtkewc2J8yrZ1ZQ0Og1f9xPRU=;
        b=LKvW8dD6mhDFPJF/JV5EWlphEY5qhwbLjQ4Mc+v2go4Za1R00lXppTVA5CAz7q3CIX
         ud8rl09joH82GMd/sM/rmKNlBBx02dS47y6amoiAjgavqSQtHX1wFvtstQwESwKX0fBv
         U1Zq5EpAd5+IbmyefFqOvhAACPaq/YX+oPrK1XaLMPOGlbDJTBrkxlVGVEVRRaEFtT7x
         cwtrD6wbqfnQ9xQ47Cq68i0Whpo3pU0cI0EGy7uYV3uxtkVOcE/D85sDEn6Ilttvw/K4
         br3U1pREo9NV/gQjvVXwqRsf32GWU09zT+Wy4mGi3EFgUjVU1HIc9Ibh7nXAmSfDfpO/
         ychw==
X-Gm-Message-State: AOJu0YzP4i63fQ8mOVuJbWTmHc1vbOa8EiERymvp7VG3fxr8CZUMV0ih
	w2ajWuS0UCZ0KeT0GzNdR65S3igXT+MCUC8i+g7wIjuvC1vGsOxXlc3vEj47sTs=
X-Gm-Gg: ASbGncvjIjozqYRVJQrvtBHGG+dmMTB3hv6mw1agcIbh6X8Dmk2Xq8OUI7XMbpverWa
	1wmgO93/wz/V5Ac0c0/A/MjoUmkEDklYuftSuRKcICNo8tKahL3EhtqQDxqq4RaSNbtmfPaDRkb
	zLnMPs1ja3+xKWTnfoNwfraa3WgaS90tFEVgYsMSC6iI9YDDWy35WXQOMuJui3a0fppLLsLZ5uU
	M+ywIx5oXHEKCCuJCqNhCLH12w0M15GEhrexLUAGTosO4W6Rm9FcLdj3TA2yKNyTyWzaFSvN5wJ
	+uiSXUH0EeXW9o7glFfquuf+zc9G01rsi44P4L4SNTux0yGFJdDjazsxsxoJjoy7xZ7IzGcGNa0
	5
X-Google-Smtp-Source: AGHT+IEtxaVNbvHvTozfZ7ub06KTWPC+g4j6jyXuZK4fTJ+jxnn3KqwwZBisoJEqObnGkUswxOnUZA==
X-Received: by 2002:a05:6402:34c6:b0:5e0:8275:e9dc with SMTP id 4fb4d7f45d1cf-5e0b70bc3c3mr2106285a12.1.1740224224515;
        Sat, 22 Feb 2025 03:37:04 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d369esm15011493a12.37.2025.02.22.03.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 03:37:03 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/5] mailbox: Minor const fixes
Date: Sat, 22 Feb 2025 12:36:16 +0100
Message-Id: <20250222-mailbox-const-arm-id-v1-0-d60589215a24@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALC2uWcC/x2M0QpAQBAAf0X7bOssh/yKPJyz2OJOd5KSf3d5n
 JqZByIH4Qhd9kDgS6J4l6DIM7CrcQujTImBFGlFRLgb2UZ/o/UunmjCngRsyrrUVWsVNxpSegS
 e5f63/fC+H2ZSaEJmAAAA
X-Change-ID: 20250222-mailbox-const-arm-id-7363548c0e75
To: Jassi Brar <jassisinghbrar@gmail.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Tushar Khandelwal <Tushar.Khandelwal@arm.com>
Cc: linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=762;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=engwHYjDHUvj5xuN0uVA1wy0mwimzTOyn6troBr6yjE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnubaxJ15rCOHU00Kk3RjDpaoIZjoY3QbFDRMn7
 jXWdgWaQdGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7m2sQAKCRDBN2bmhouD
 19RuD/0avAOcnkXWQnKEHI53LRU6CRIzjH/67r6txmXxfeugRMjSbmgoyjjjTGV2Di36U/m/Ox7
 KZ8567iNVnBUNpMX7R+c8+gEqEm4K/6xmf4lf/40+ahD18dbGd1B4zHSCQw6jrzZIIA8vXJDeNe
 OQUQQpemmYhpiucjuZ0ZW74oBc3w/HDQUe32Kckf9Xa5c1bvh14dUnjhXGki3aS5VhVMTqUboaR
 jbyHQslQjS5F1S8zRHfSUwEXDzCOS58sWG74Wix99mqgK0heNuRmTi4v3Ukr7zmbEmThYYGqPYM
 yI4gG13aPL1OBSM0OycImyLjI4vwSlCLqyx+A2+dspDvEtgoweBAmixVnG3V8ykWtQ6MY5zr9Qj
 rT24gwjrc7K0qqFq7i+g+P/4o5wAJ+vkPKT7rmGqVY4PBsoGp9LMmYt9bDHrSbdATAazSMY+Pf4
 i1fSbDTR48PTodrLVoCXnbYHOmxZ3wEKOFol8igADUvj47hvCki8WBLFQR4CuyyQd1k59TfPN6S
 wtO0ul1V6V8XnonqEzDkPulECk1bP3elAf03R6XME9Wog+BxB+1kRwWFp/CDe42ECjbUTunaQjA
 QoJ3Qf17oT0PFzmgnO/fFuBp8XAfBUX13SXP0PpRLCkn8Y3ATnzLcUABq/8uJxMoBZ4RCndNwZf
 04+3ZCf4gKNNp4w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Just few improvements.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (5):
      mailbox: pl320-ipc: Drop unused xxx_destination functions
      mailbox: pl320-ipc: Constify amba_id table
      mailbox: arm_mhu: Constify amba_id table
      mailbox: arm_mhu_db: Constify amba_id table
      mailbox: arm_mhuv2: Constify amba_id table

 drivers/mailbox/arm_mhu.c    |  2 +-
 drivers/mailbox/arm_mhu_db.c |  2 +-
 drivers/mailbox/arm_mhuv2.c  |  2 +-
 drivers/mailbox/pl320-ipc.c  | 14 +-------------
 4 files changed, 4 insertions(+), 16 deletions(-)
---
base-commit: 8936cec5cb6e27649b86fabf383d7ce4113bba49
change-id: 20250222-mailbox-const-arm-id-7363548c0e75

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


