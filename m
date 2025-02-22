Return-Path: <linux-kernel+bounces-527149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156A0A407EA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2852420594
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BC72080D7;
	Sat, 22 Feb 2025 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QfeyUJqm"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB6420ADD1
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224232; cv=none; b=GVu8CEXEGnurmefDh88w2+K6gcJx1YH7z8x8lcmyZMKWvVHnXoTrx0hfvUjCqkV/R2RWB1KzVQIUEBhy19E/dPZZng+XZhkVkUwPRBl0zuy6tfHR/tyLfoZT6fX8nz+d1Ti3qhS8ThC0YNeqMclo0/lMQmts1QIPjAdQdoynry8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224232; c=relaxed/simple;
	bh=vPa6bsQdoVt2neoZdgIVEfGdPlop7/NaDEZYB2aHMWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ocfd/RI24DtcHZ8y93JCkkv2YqGmc+Gcrl+I/BWMSttJhOWFqf2ZmQatmvq3jtDRN7BqnejEhmwSYQvaDX8vwiLGlXbeKBTqCtty60SHmupuAudwWD+17vlSynagcR7LAdt0CJtwsO/070+FzItT7O61PYWCJ2DGyZBXQQu08Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QfeyUJqm; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abad214f9c9so54163866b.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 03:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740224228; x=1740829028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYzZY9VGG1+UEcHjX0JPsBC3yWw/xYPSaSipfxGJ82g=;
        b=QfeyUJqmduBi/YlQH92Vpt9Tl3o0b5mRjWgWD+vxaXBmQvNJjTrat1QF+5kTV/4lAW
         +aW3p39bBCpV5M0f6j5Py1Y24fG2GCdRmuSbzGphWzLGdfVmCWzS6VK4AGhiOZpvn7Ww
         Z6vkDht0lTa3C0R+BJoq4ccWtan+HWIMV8hKkfby/ILXWxIOVJDiW/vqfsAsNECfnygQ
         bX96SyqFxKRqm6F6hFRPjoDhS0rKwjLTDPpG7bm1P+PLc9lPwJtPLGirR0qLTBDqXDDZ
         9+JgVr7ZFaDlufbt/1CC5Wy6r/Sct2HYxXHQuo0MK8CIH7mZc+P5W/t5jq3YPv12YNuU
         BMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740224228; x=1740829028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYzZY9VGG1+UEcHjX0JPsBC3yWw/xYPSaSipfxGJ82g=;
        b=uPDKYKhMkEjMJ1ZTIjJBpO+ft4L8ArnBMNiyP0Is39I0TjotLTt41l09C0FJubPYEc
         +LTdh7EX+xCAZNGPCf7CKt0TM7roHLVUGCXeaw/3Iu+uTaMH4MCH/idYBGhP04wJWHKS
         PKdgou3HsX6yem4cvx8N3QYHU4AJdZx6knPMm6VkPoaNWvn+fFx2cmaC5MT8bAzfM8U9
         HHUx0fNZa9F9uKygJN0TSHv1IgOQlG/n0GfG8QuDkNGSdCC+4rbGa52cReDpdpo8ceV3
         RHfmomEIhQVwlrvJeNiEJMD2vm+8rMDtQ9X9BhN4lE/TCGlKmc8hzJUrMRvV9t6ehj99
         p4WA==
X-Gm-Message-State: AOJu0YyHHO7Y++t1OwF7Lg0Ec3oW3oNyQkC+AtMcZqPZ2jKaKDEI5P/p
	ylU/Ab6LdKg+oTN1x2Gq0rm6zTLPeY9gv11bZj6OEb4+Ep5K7fWQ3ri/kFNQTNE=
X-Gm-Gg: ASbGncspVokAS4SEjtQkW3lhaRPQMkfV5emt5TlqVnd7Irs8rKTJM4frGpd4uoab13x
	ocsLtFU4lgHHwzmXKh6cOWRpm5hXKmGUu99H9mkVda+5ht+molS/BCLhzcMpwkE4fKznmtBvnEi
	AUb2le5RbaLcyTw9iSwGAzus2Ta+E2TenbodOT/cgkzHq2R2NlXxoFzMWCagfH1dHdm8Ua2qdWa
	ZI2Ol+a+rNOwbR5La+udKiJqteug9PiIbtYsYN467qISo5NpQZO5q207Mf3G0gtTmWlim8FDh6u
	oV4TX9G2tfCdz6r9UUv+PlrTFUNCCHBqbIm8kB0VplzATza9PT934Vay6PiY9Cc1AAAaB1ObG1v
	n
X-Google-Smtp-Source: AGHT+IG/k97YSd0ppjijIdvQw9b5VlaMKzhGLv1Rw0YZDca1+B540Q3oFVGCENV4Zbu4qVAOt0W1Fw==
X-Received: by 2002:a05:6402:278b:b0:5e0:745c:64c9 with SMTP id 4fb4d7f45d1cf-5e0b70b5eefmr2349357a12.2.1740224227734;
        Sat, 22 Feb 2025 03:37:07 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d369esm15011493a12.37.2025.02.22.03.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 03:37:06 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 22 Feb 2025 12:36:17 +0100
Subject: [PATCH 1/5] mailbox: pl320-ipc: Drop unused xxx_destination
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-mailbox-const-arm-id-v1-1-d60589215a24@linaro.org>
References: <20250222-mailbox-const-arm-id-v1-0-d60589215a24@linaro.org>
In-Reply-To: <20250222-mailbox-const-arm-id-v1-0-d60589215a24@linaro.org>
To: Jassi Brar <jassisinghbrar@gmail.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Tushar Khandelwal <Tushar.Khandelwal@arm.com>
Cc: linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=vPa6bsQdoVt2neoZdgIVEfGdPlop7/NaDEZYB2aHMWA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnubbZtWIfPQtc+LR/GxrOk+raWcyhl+odv/Vhi
 tJwAGpvYn6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7m22QAKCRDBN2bmhouD
 1yFMD/9HKYmjYfsbNySK7t7xv5XwhoCpiVdmQOm9IycbgL6gRcJx09622OlBg9JLU4+9/fkrdHK
 323N3UZO0d+iMGcc84z4EOkbqWoDBZB9ieVVHuNDMExVuoIwyiC3udIExR/Y6zJ2G2z3KDDCI4P
 sjZ8vyNjH3AW1LbMux9KAmrJJVUznoUOrK5lTVHSukj7nEv+pMWa/PWqnrxyrSC2qhcdj97Bpsp
 Qe/j+pwwpyP/HqfXAobx6emZ7UU/22lWzzg12xX6hqgbLocrXENLqXs971U9Ml6Qb47++QuBUWb
 K32g00Ubp+NNQnOZe/JTsPUGJrSm75AF0S81uRFegXNlYhCa8gaWr7UEGGrEq+yuQpd6TjdFL87
 rnvpg7UVF60WOkWrPZdHVnFg4XLqShrd5C0LAOhVeQxiZ+lT/nS1ab4ReaojNW5e2d/GzSQNltg
 uU+8Sj5HKtWXs4ctsi6bBxE7n+bUlcUNVOFtZq5XA4XT1bDdSEAiGM0V+IjZUH8lXI3i/TkSkyC
 T2WHQCjFVdMzI3cJZJwuF8aIX0lQz0zkLjHSH2YJUJP4Fciud+reEYFkv4jJXlti3LvYQ8btEMi
 BP/m4+wV4eUggFAF0DGn3bcNQ3kwux60b9JTdSoa8FPYSgkj0jRwCEUes+fSmZKY8Jz4N5Twqia
 eblHpjDhFR8m2WQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

set_destination() and clear_destination() are static functions not used
anywhere in the code:

  pl320-ipc.c:48:20: error: unused function 'set_destination' [-Werror,-Wunused-function]
  pl320-ipc.c:54:20: error: unused function 'clear_destination' [-Werror,-Wunused-function]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mailbox/pl320-ipc.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/mailbox/pl320-ipc.c b/drivers/mailbox/pl320-ipc.c
index fbcf0793039059b8d46f738e292f200bb7391dbd..0b807bbcbde07255116db40cc9d9028711135fe8 100644
--- a/drivers/mailbox/pl320-ipc.c
+++ b/drivers/mailbox/pl320-ipc.c
@@ -45,18 +45,6 @@ static DEFINE_MUTEX(ipc_m1_lock);
 static DECLARE_COMPLETION(ipc_completion);
 static ATOMIC_NOTIFIER_HEAD(ipc_notifier);
 
-static inline void set_destination(int source, int mbox)
-{
-	writel_relaxed(CHAN_MASK(source), ipc_base + IPCMxDSET(mbox));
-	writel_relaxed(CHAN_MASK(source), ipc_base + IPCMxMSET(mbox));
-}
-
-static inline void clear_destination(int source, int mbox)
-{
-	writel_relaxed(CHAN_MASK(source), ipc_base + IPCMxDCLEAR(mbox));
-	writel_relaxed(CHAN_MASK(source), ipc_base + IPCMxMCLEAR(mbox));
-}
-
 static void __ipc_send(int mbox, u32 *data)
 {
 	int i;

-- 
2.43.0


