Return-Path: <linux-kernel+bounces-242052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DC192831C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0081B253D0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F54E14659C;
	Fri,  5 Jul 2024 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oj6xmLJK"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8A4145B3F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165753; cv=none; b=Gv0ZgCtCRWThhTcy/fvhZg9bYt+n6b1ULRElKOmt0bZgS3v+s5i6Qbanj3aknzif0WHDzQwtk1CNz3jftom+TnbcEUdExj8pAn/1XVcMg7flFPouXcV2Pob+PYbugBcVRkOdIi7si7du0boyQ0YRNBqBWwSRbTNkFGugE/hKaLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165753; c=relaxed/simple;
	bh=OojRvM8EMQNuqwibWkSI63p3C5GhOxbuWf7j5BMLtKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bjy7krKUjUuXs8G7f8LaCGN8jFWhI/m5txV1wqdZN/1r9nh7pJwb2p4kANRVOi++vY7jjVQA9B9aqFlltwQ1gcWlnyFvKVnUcJvqFdASRjxnEmIkxRYEWjnNUGg016ti1mq3q3GMCtIeCpCEnf/+m+U3TTMxg/v44WgSOoTCEQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oj6xmLJK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4255fa23f7bso8982385e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165750; x=1720770550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M5GNsoye/gXXLtZKuNcnq9qrQmnkX3G8AnYSQI/9n4=;
        b=Oj6xmLJKlHVYjBiFO4eejMAMFtw0YJPApu9uHpBSsya0iHmmakm2k/9FM2EMzaVGKD
         JT6gibhvWpt4vFmBldyeDsOuFn2oIM7663bnGkTZfLEJjifgfwXEuc5fWn0L++07Srma
         7n9pve+8uDUcDf/Yk7lXPh3G1b9KoRLWjgRAsH+txwAjUMJWbApB2bgsU6N+puo2G51q
         W7zHmESssZ1i453wGimuD5V+4TZZp/qXt3S6AfKJFT1fOF/BqP34gmQ+5QiKaeu4Q0x2
         jSbHcUiacDhXwskmCJYBP7cHfFmyBlJ2yk7IYae+ccvfUazrbIJgIxyM/+xf21hVLT4R
         xmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165750; x=1720770550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7M5GNsoye/gXXLtZKuNcnq9qrQmnkX3G8AnYSQI/9n4=;
        b=APAGHPhUTJajd3V/tMl6f7hpJxyRtNOhlvrjlIszO2P40yRDJEWVFExnd6LOpzjVe5
         N31aoIu1aOVDIvCOyYmATM8vaIQNzf9KHaJIvvG+joi4rEpQ7Q/1+q0lY1wdNf4HssH/
         5zNCHLgnOkRMuFYHsLnwgm/c7/MFMA72WVYVNqzfbAZrlOCKaqnZ4NZF6/zwysFYoShL
         IBQJ0u+ylfcR+6sXDCZYSkCIqnMZDGqHvwJLDs3iJHT3mszEqMBy8AKhZhP+7UR2vCKI
         f/J9mOOazr01ySISiWWQwiGYeSiOsMuSbCTqPOXkkBdG/zui2k7+rTi92vkIla7IJhKp
         y88A==
X-Gm-Message-State: AOJu0YzdwJGrp8zLQde/2JjWgNDP4AJ8FfCcSZ/kRzHHo4TLeAZecHdV
	JgAnOO2xIlDSC8Z+kB7IRPSswO5pi32z/x3GBDCfPymQ54ECcCiX9iPFBxaFZIw=
X-Google-Smtp-Source: AGHT+IF/E2CnpMiUCpp5VolLY0hzQXNP9TLYiERkH8KQUP4XbubbeDiHz005MoFCqIsHEfsW1wqEvw==
X-Received: by 2002:a05:600c:3286:b0:424:9bfe:6305 with SMTP id 5b1f17b1804b1-4264a3dc8c2mr25708515e9.24.1720165750715;
        Fri, 05 Jul 2024 00:49:10 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8ed0sm20183521f8f.28.2024.07.05.00.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:49:09 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/15] nvmem: rockchip-otp: Set type to OTP
Date: Fri,  5 Jul 2024 08:48:42 +0100
Message-Id: <20240705074852.423202-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
References: <20240705074852.423202-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The Rockchip OTP is obviously an OTP memory, so document this fact.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/rockchip-otp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index 7107d68a2f8c..ebc3f0b24166 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -256,6 +256,7 @@ static struct nvmem_config otp_config = {
 	.name = "rockchip-otp",
 	.owner = THIS_MODULE,
 	.add_legacy_fixed_of_cells = true,
+	.type = NVMEM_TYPE_OTP,
 	.read_only = true,
 	.stride = 1,
 	.word_size = 1,
-- 
2.25.1


