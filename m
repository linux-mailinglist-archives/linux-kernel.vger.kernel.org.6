Return-Path: <linux-kernel+bounces-200669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D778FB32B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2EC1F24055
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299F9146013;
	Tue,  4 Jun 2024 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1NncuGe"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C3A146012
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506440; cv=none; b=XZVQE+ahq32Ui4FMeaRupllWACHspGpR4rihretQL5TBdoAiB9ebx+sSEH4i3Pp1PLbUooQH5U7geuyTzC0wZrQRDncapYoy1n7XcvRDFO1KcIjp+/CN9J52AuWH/HyZnX9EDPD3+Cdf4ADVNmq0ZANBYVdZR4Npr2OcQpbO6cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506440; c=relaxed/simple;
	bh=L2/y78fs3Ls4EwfkbLjyb/X63FzWFtm4d8pkiRLS8Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZcjQAh7sMS0oVPhQlXFdBBOxG3ETCJnnFF/xeF4m2TcS6x0ppW9Dnhqt//meTijzMFAUSsoRr0lYDdoJekdTOF7x9bgrK/EA5Dt2T5q+Q/jwUGM85BHoFkY8juKwY1tfY0GDWA14/uoQHi21fzXUcAT0onUW9paFmwrzz72hB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q1NncuGe; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e73359b8fbso76989541fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717506436; x=1718111236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6JJxWa/1zoPOcHlTccLV+MlOQAo4FcwAYphEzwxysY0=;
        b=q1NncuGe7l5VMjnvjp8md7rszgcX3WG3XtXesb++Z5zVZJagh2Zi8UU/XL4fOyv6Hb
         2LHCK9cI1kYgui+vyro4jXxfTR8vdVzSUqUhsonKdBDMRqNi+cPxYihk0Rl7qByES3Mv
         exUtaLFdWYbguR36Bn2qiQ4xFEAJCnHXxd5bA9Noz641f7gSOb8PVAaWE/MlHOIPLQjx
         jAwOHqUhYbMJuOjpNAiNzSb/Vo+kz1hhoPK39iO77IeRGEqFOsfW0+t9EkjNM/7EUWGn
         b7gO4p52XZ1vMRlpyx131D+Yf2jzG3ffu/h9out+mqTqs33xBeIs4f4HSVQic8+1GHaH
         bFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717506436; x=1718111236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JJxWa/1zoPOcHlTccLV+MlOQAo4FcwAYphEzwxysY0=;
        b=iZlUIIDfXbhsQokgZFlYTqHGzfYrArPfr2PCxLpOW3CELhRQ+ZuEEARYEIHu69VbPX
         0zrD5dnw0VnYAZ5j+D56h8X+cP5H9I+fhQpM1S7Whwt1F2/Fl6HcqkER9cHCGJNQm8wm
         hRhzI/vPQWN0djI7Z6jCywFgFRWEIgMe2jIHGkgyozVdSDlpddFC6HapSu4GL0IWYf9E
         tAnocUmcns7ONn8fKV4Ag+CVS5uwbW+CHuCpdU+iJ/4lGUfiPZoicEASQREIxJrv5l3k
         98RgnP+PJeq9E+1jGbZ+yqawndNtkjMG6Spwzy6UYL5nz7DOnGfvY8xZqd/GIOtd3OLS
         +dXg==
X-Forwarded-Encrypted: i=1; AJvYcCXnzyDkvrhf9+b5eJEbNyYLp5UBErs7vg28HKOW7RR7IvdSS4KY+TotCxG//kkMuKfYZfBUJwiV+E7sC4mBamPiJpOTb0vtA+aQ3QD9
X-Gm-Message-State: AOJu0YwHduxTbAiGL6iGFmO8/EGr2SiqYXK89FvvI2s4wZ7ZSaKkh3Gf
	Jx01IemN8Y1JKTOEeJMV2k5xhkCunQ41pP1dpmUJbtTji+Ilh0KULZAHTjK7q9A=
X-Google-Smtp-Source: AGHT+IFmOwVhp5MCRgtqHuZ+/NrUtbmCP/7CKOxeR+X4MTadpuAQolbr6ss96NjVUrIKAcClNYifhQ==
X-Received: by 2002:a05:6512:3599:b0:52b:67cb:280c with SMTP id 2adb3069b0e04-52b89573691mr9128600e87.18.1717506436352;
        Tue, 04 Jun 2024 06:07:16 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd064affasm11516562f8f.106.2024.06.04.06.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 06:07:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH] dmaengine: ti: k3-udma: fix module autoloading
Date: Tue,  4 Jun 2024 15:07:14 +0200
Message-ID: <20240604130714.185681-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzk@kernel.org>

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/dma/ti/k3-udma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 6400d06588a2..d7259caa0200 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4405,6 +4405,7 @@ static const struct of_device_id udma_of_match[] = {
 	},
 	{ /* Sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, udma_of_match);
 
 static struct udma_soc_data am654_soc_data = {
 	.oes = {
-- 
2.43.0


