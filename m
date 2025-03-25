Return-Path: <linux-kernel+bounces-575253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBB1A6FAA2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34D2189402A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E1F2571D3;
	Tue, 25 Mar 2025 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bbvY6w29"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1875F256C88
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903950; cv=none; b=aDezQdN1ryeNbfLAjs0o4zhudFEwoEsqbJF0A+kZZU1iENJAA/L3IKoXD6/Q7SamlYAiZBuWAEMAOE1uIAJWOguYP/IvZzAWtolQLI01lE7R3jSWWC4b0Jk6xqoKykpZamCndX3GOYwuLbfKdMxGPylKjfIPPGE2zG7O/PpPE8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903950; c=relaxed/simple;
	bh=fPnW4Nbi7NIwckU9JyFLvNAVY6fjNlM4PPwRoMGIOmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dC/ORZOUVI+nkVWVb1mfPRyhSE21MXvTj+t97yHDSFvd9n9FMnyV7O6mp0FrosCEjGzuuz8KXKDf6r8/y63KNMWhHcxMwlxpdl9HKGUMbHuoUi78J90sw08bxRBhwsxKjBz7jeuyF4sI3U8zqbR3pwLxmW7go62UVASso/Bqino=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bbvY6w29; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso3193132f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 04:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742903947; x=1743508747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xzlt1Rzvb520tIYWakwAX5OIfk/gS8FgIjZQBtZ1BQw=;
        b=bbvY6w2938Rnh3EtuSGzJ1OTy/H6u/go176x8YgDkhbvnqS8kmx1kmFR/5+c6twzBb
         RXj92dDr0zNV/APEBQtU4JwW5fdLTy1KSWTIb5IhUG5GuucVE1yR9LY+ZVDc4XK4P1Fr
         dep2qR2U69wbkcEzTG6zGc4P9N6KsPLZD4AHsWABQNlki6TSHgu8/khk/FZfZrw2/ZOS
         pxDBEYPGAHR8yTiJqPdjqvSjL2xxPQ3RDroTcouWBXngeqrXPMyjg3KkJoYMs2ldQcCt
         8Zt95k/xtrKdvfLzQIfdYuZ/FjqkclK1D9yxWQ4dlJLeFZ19AXswbjJDarW2BHQBlFXI
         WCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742903947; x=1743508747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xzlt1Rzvb520tIYWakwAX5OIfk/gS8FgIjZQBtZ1BQw=;
        b=cew9b76Z5BUystnLTERLY3ZMVOKQ6Q/rqB/79+LjU26ATgN/y7An1pgKt54ilDK+Fn
         L0L2f4H+5jNHBUq3WP/Ha4WD5CAti3Htwy+Xwwt/5HL8TjqZFyn2UoxVM6BM71sbDQiw
         xSiORuzH+dMXkKWxs0c2sgRoU1x7a0UHj4M9GvfCEIdwejR0dcYb8IOnpsly/cYYfnPF
         WfWpI8AdaMAfcFIhKwfcLaZ7SRF3ZEfSs4WO3E+GYb//L+xdNaofoO0qu1hcfivC4pMe
         Don/jD6zkA/9RWhl/8/oV93CyW2Cks8WpEFrXlQiEFzhiqpZ4CGJhrPvxS+kNL6OBkKE
         THdg==
X-Forwarded-Encrypted: i=1; AJvYcCU/TTgdZ16Wyrf3i0MU/XnU5R31/getMoVPsy6jGnTukef7qABo51p7MJgwKWKW1FCIwmqfd8SBUB0m+W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtJsuPNXRL4Y9SScEEddwockTGs1Bjul2uOSFkF8vvNprX9Y3Q
	L+nOPVnRD8dukN7JIGfJ8ykmMhV2X93Q16nHzwOulojj/SDoyOXFi6UEHGIofd4=
X-Gm-Gg: ASbGnct0tjdg+cZ07oR/epkEMhEsTPJ2Ks3LPXdrw9xUikuDqZCt/Jc0y2q1f0iovRK
	yYZfW45TlfMcPrLKlQx27iVsY+Y9sZUCfLZpFHRv7ug6khGPOY3xl4Hl+NQcUofn1Wg5VxCKqY3
	XhYUuCjk/oZlD35/6BliQLFK/IxkdLTvgxRY39m9uQD8JNRPjb1O/c6TjXolIo8du1UDleRBD2V
	YjBqxMNo5MCgkFD12G8to1Hrwy1FRSfCcTLL9oAQmxNNUp1u5YOKH6WEN1sHA/EvOtcc8Bse6Nl
	n5NfoxQyLNIR/1GO+x90o4hfFHZlnIG0mQG/9Q1Fr7AdUU3z
X-Google-Smtp-Source: AGHT+IHmwU3sf2ERC5YZs23ogMiMNFDMx/Jl+ToaspZF/hgfKgGiiw1uVFM9CO8NyhGifaNlqugPWQ==
X-Received: by 2002:a5d:47a4:0:b0:39a:ca40:7bfb with SMTP id ffacd0b85a97d-39aca407e6dmr1134175f8f.54.1742903947366;
        Tue, 25 Mar 2025 04:59:07 -0700 (PDT)
Received: from [10.42.0.1] ([145.224.90.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6676sm13687169f8f.62.2025.03.25.04.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 04:59:06 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 25 Mar 2025 11:58:47 +0000
Subject: [PATCH v4 2/7] coresight: Only check bottom two claim bits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-james-coresight-claim-tags-v4-2-dfbd3822b2e5@linaro.org>
References: <20250325-james-coresight-claim-tags-v4-0-dfbd3822b2e5@linaro.org>
In-Reply-To: <20250325-james-coresight-claim-tags-v4-0-dfbd3822b2e5@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Suzuki.Poulose@arm.com, 
 leo.yan@arm.com
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.14.0

The use of the whole register and == could break the claim mechanism if
any of the other bits are used in the future. The referenced doc "PSCI -
ARM DEN 0022D" also says to only read and clear the bottom two bits.

Use FIELD_GET() to extract only the relevant part.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 3 ++-
 drivers/hwtracing/coresight/coresight-priv.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index d895815dee1d..e0638e5de0e0 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -131,7 +131,8 @@ coresight_find_out_connection(struct coresight_device *csdev,
 
 static inline u32 coresight_read_claim_tags_unlocked(struct coresight_device *csdev)
 {
-	return csdev_access_relaxed_read32(&csdev->access, CORESIGHT_CLAIMCLR);
+	return FIELD_GET(CORESIGHT_CLAIM_MASK,
+			 csdev_access_relaxed_read32(&csdev->access, CORESIGHT_CLAIMCLR));
 }
 
 static inline bool coresight_is_claimed_self_hosted(struct coresight_device *csdev)
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 82644aff8d2b..38bb4e8b50ef 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -35,6 +35,7 @@ extern const struct device_type coresight_dev_type[];
  * Coresight device CLAIM protocol.
  * See PSCI - ARM DEN 0022D, Section: 6.8.1 Debug and Trace save and restore.
  */
+#define CORESIGHT_CLAIM_MASK		GENMASK(1, 0)
 #define CORESIGHT_CLAIM_SELF_HOSTED	BIT(1)
 
 #define TIMEOUT_US		100

-- 
2.34.1


