Return-Path: <linux-kernel+bounces-527152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41532A407EB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2088C4204EA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F7420B21A;
	Sat, 22 Feb 2025 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qGCcxyAC"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B9820AF8B
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224238; cv=none; b=Ph60mtdRyYT/nEWdk5JrMtsX5oDwwzR45MMqCZbBfGs3HUx6S7MuW2oDgoH04GFRYQFnRLOJVX8cpHvjyW2L3rXoNpiEIgLdv9I0c8FF5qBKNsdpJSwDXoxLSz1+5Vqrk0xuHQ2XIkZG1mMdVAqQ6aPGP97eqAOULtpjsTV8J9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224238; c=relaxed/simple;
	bh=lWmGCPfiCnWpgbML3E0SWeIl17zZyI7vd4dR+shv2ZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M7OIunX/bfZmpeKgqpID+MvnnQ3Swzv2KvtF7u0sejeqWmoZX1EIEVxpwre4FDIziiKor4EQ5VuUq5//dBKRk8PYf8DFlPvxvlabR25wLSmbqDHYMTwz2ahbKA7eZ00q3cJJomS98v7WtWS2I8GMpDWxjYkjZhZQAslyo/Ob5LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qGCcxyAC; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dc050e6a9dso651650a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 03:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740224234; x=1740829034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TIeShVgyd6piRg3wBZoaFeKQF9Q8uPoDmPYuvvCOtnE=;
        b=qGCcxyACWLEjlRF1IELs0b06odNs7ZEdjqvfokvtkEZ+cMBuG6gC+GGS/J77ACS/EK
         DWaEgmFGfsXjZWnyMPK5LeJmA1U2HjD9FTGp8VAEApsaxOVdvrlKUFKbKDHBxss8AR9i
         +9PBT6mytcEa87UFVOtWy765MuBGa4uL1Ua0BiYYeY2l49ljYebkQwcD7G5JEydJ7FmH
         x3xzVONW9dfohDXsMD3Flae+AypNzxVtjpvmtCUwiYmTXbZH+5G+H/2mLh5thn949juj
         mXRqgvPSJjIePz1Z0+B99QOHj0W7IM/xaWJRU8evZLa5xvU6Sw8Uc9BnNH4+KAZMnFs1
         U78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740224234; x=1740829034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIeShVgyd6piRg3wBZoaFeKQF9Q8uPoDmPYuvvCOtnE=;
        b=DCDqoZ3UgdRaVPEpjMAw/NAA9dsF2ghXo3ojFH+2PtjgoeDox5v5KU4Xq5VuX/REbi
         VDqIV/3HOyz7SepNxg+/pEdTmUkMZADLR3ZYg21mJdR1gAYvzgkfUJIwra3HgA5FgpA8
         /fJljOrfpxAx51nvqQYz8//zptJ9nEdjj85yrS32egYEqBLUSH4gKciiRymNwyo0X7dB
         +fh+yc417TgVfbMYO97i25xHvo2nRWvecsEAvzrTEsfPqO6t/JluTzJ9+V5/f+k/yXfO
         9TCy5hX3oRWTzWmLNtKVoCaafcORzaOXANj7X9EocwUdBvsBmvEqgTR0nuCHYO4kUhnw
         iktw==
X-Gm-Message-State: AOJu0Yy2KDSzUVizmgWptAbMV/BOUlBTBHw6muhhMUmtKbs5DP6nLPqR
	ku3BGO1IO4Mvi3EVvLascZlT57RwX5uMmXDQD9uQ+nomc/6GnRFDORKIfSGA1pQ=
X-Gm-Gg: ASbGncvbIQAPuO6NDgGZD/lVM73QGREAyG4TRYSQJQxD5NKnmBVsWPt2m0c2Tcoq1WT
	+uRjAgYYCn/QyGQizDPasI4TQRTHsoCUHkm6wB+9Cd9WvVZ9Ki/8G02ZBog2h2FstaDlZtIqaNz
	vXF54x2OYE4wxEXldamSryn3/9BhaKkpPORCMJfqPE72Tl1W7/ZUwkDma47IS3GiHE17SCvdPZk
	W81gn9OQRP3W7+PKjrlgo1QZoQ6GY67RXYVpL0l+k6UiiJRRe2lnmiuEDICWzoifEtSw9cRFcXh
	fFaDrg8Dh9mQAidjvxut0Eil24QQiQPOmF+TOJNpeU/PkzyrtaSXWJNdxGrAfAEENZBnJ6OYBwl
	b
X-Google-Smtp-Source: AGHT+IHQypg8zZBNTZKWsrWVnuwDgWnDA6fOqp593JjdL4ev8fp7n4smC54v2P8iA8QklubSYv4QAg==
X-Received: by 2002:a05:6402:2551:b0:5e0:803c:242a with SMTP id 4fb4d7f45d1cf-5e0b72478a9mr2334612a12.8.1740224234394;
        Sat, 22 Feb 2025 03:37:14 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d369esm15011493a12.37.2025.02.22.03.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 03:37:13 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 22 Feb 2025 12:36:20 +0100
Subject: [PATCH 4/5] mailbox: arm_mhu_db: Constify amba_id table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-mailbox-const-arm-id-v1-4-d60589215a24@linaro.org>
References: <20250222-mailbox-const-arm-id-v1-0-d60589215a24@linaro.org>
In-Reply-To: <20250222-mailbox-const-arm-id-v1-0-d60589215a24@linaro.org>
To: Jassi Brar <jassisinghbrar@gmail.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Tushar Khandelwal <Tushar.Khandelwal@arm.com>
Cc: linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=753;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=lWmGCPfiCnWpgbML3E0SWeIl17zZyI7vd4dR+shv2ZM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnubbc1N+g5l2n6YHAfGirvOdOE+Chy9+Jrl70n
 fX1ih8qhCGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7m23AAKCRDBN2bmhouD
 18suD/9EiXzPL9Fq0fwW7U1Iw3zze1LMPys63oCJvvBRetU+vV0NB+8r/PgDVX36cuiWS1OVp1h
 //2lMq6CVncLioQQ9KWuCu/4PJaGKY/EH7ymkEAfejEdjfCKy5oXXiG6tXzMK0W5elWIZcCaln4
 mo5mf15hm0aOPQq2xOT/F6QK8/akL+U5Cy58fM2Zu+bo9wRv+88+kwTnj8s5lEq2u/+mSXsS0YX
 5oO30ZjdrFWPuJ/XE0ZbksarjEEVgKxnizrbPHeBRc46KGUilluoXFyFRPK+zmfaELAc+W/kvBW
 l5crUx03dRXAeyJLe67aaNMfLH9iJIPnejApi8udydEr8/09CKucEDKiohr0i8ufyBjbuzaFh3c
 5d4pkkn7eygYaIsTwz2fjViaBpD/zmC7S37CuX9tAfT3GsupCgi5yleBlY3MZg8g3d2b1wBW6jL
 scVYLkJO+7fsudw3i8blZDtiP+CyjxVLIAqn+Ggyz1hG0+HDpiHBBX/RbhpeLqOjTb/Dk5E2t2E
 bSQD4SNA77WxhuaRMY6JpO45LwnI0vEJNx4CaZXFCn087Sj3O84ulEqg5/nAUGXOpm/mYRkvRQh
 B7d2B3RghM3+TNNFpeiCEW8d/FA72KqPHNBEM1iPpr1RHwKDrvKgxunqi1VMzx4O4PoegWNYsE+
 uAJmaIy6/WuODAw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct amba_id' table is not modified so can be changed to const for
more safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mailbox/arm_mhu_db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/arm_mhu_db.c b/drivers/mailbox/arm_mhu_db.c
index 27a510d46908236f371c33d40f2265aa5bc55b1f..9e937b09c5fbcee146faa1f954ca82d8404652ef 100644
--- a/drivers/mailbox/arm_mhu_db.c
+++ b/drivers/mailbox/arm_mhu_db.c
@@ -328,7 +328,7 @@ static int mhu_db_probe(struct amba_device *adev, const struct amba_id *id)
 	return 0;
 }
 
-static struct amba_id mhu_ids[] = {
+static const struct amba_id mhu_ids[] = {
 	{
 		.id	= 0x1bb098,
 		.mask	= 0xffffff,

-- 
2.43.0


