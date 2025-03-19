Return-Path: <linux-kernel+bounces-567330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F20A6849F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E061819C315C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1658624EAA4;
	Wed, 19 Mar 2025 05:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HP6KktEG"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7A520C46B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742362709; cv=none; b=OD2WfUS1TmzhJ8kKO+03e5IgoeUzY+kGnip6t1nNB1WrAsQsNcYWmZHlWcVOXjBb7Qu97nHFkWs6bsFVug9keU2SlavWvsZLakyTlWQbcM6xItC3xe2EDZj+xR6EF08CuA1+gKVfgSlRrDmn2cEqJh9k/XKWJlYZXtMgfUgZ3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742362709; c=relaxed/simple;
	bh=4727X8BB/UFkI7GNXf3VvnzSOro/EFeFrwgWraWKOgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZI5mq48/rX/ag7OKzTTLweooTdf17kDhl/AgbkoHdsLy9LHIQKzK/+WbkV7sbnM6F4o2kXPg/ZBvVf1CDcTNuV/4AWddAsJj3r7d4dpO3zITjf7TqYmrtxFkDQFhQiAH7i4uQkn3ZvLouoOwz87vtiji1TEDumwCy6I1uh+tfz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HP6KktEG; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e6ff035e9aso11930314a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742362706; x=1742967506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UgsA375lt/C9JoBeIh+flIPjgZNxw7BBlg6E3CmnWA0=;
        b=HP6KktEGg5C7n2V/yeTszAb55E+MRiCKkujWvSVAx1Zc6DiYTt61M5XrxgIWoBUrpJ
         JE4GVIQ++l/L0KcRlmFhz9dG8V4XRjhVQiPSRCVvvuI0ul8RN+0uqYhbhyxMUopkFdbx
         bGpgIkrAsHP5edueU4oPuyHhVxs1HCebm5BIdspBPgmyhX0lYoFirRHf4SIl5IPgdKDu
         RJXbOuNVR6Z20Lx+ST2KdLvMOr6UyUxHJq+laj9y3UutSSZSUBJjQhRyyNr8fPkLrlLa
         2/Djje/B6f7/Rqj+mJoRJv5qxy4nWL4DLJOBbtEWG5a9WdFDWvET/avPrQzOq9fxN5/W
         C5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742362706; x=1742967506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgsA375lt/C9JoBeIh+flIPjgZNxw7BBlg6E3CmnWA0=;
        b=kxL/3c5AwElqX1nPf7SuLY0LAwxTwjrVykEfpzcv/NdPeDRs5z3yTY8HzXyigmNZ1B
         G+LJ9dJ3hcTdMI9vM8ad8YSPheWAhHfHYT3k1owRSseYq701LxnK0i4cf9wKE/ekrjvu
         RFmBArKNNpJvZPCa/O0+0gpHpX1rCM5QEYsAE65Cz04vaXUmWUHfJ0M1NCuujYLvYk7s
         D33faD5vfRxtqU1ki4FQY7MCa/cGYy8ybwa7HQHH9/xMU8/he5YhYAyFY3+/Bdk+Y8+A
         43LEfXUkEXXZIwDDkgGaJs5vth30TmLwepGngSc94nIEBMxAB0BXIgtYloBStnebrFRK
         YvbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfUzAcgKtCMhqDi55A6yFxpCwir06WO8+9rrABsqwFY4Mj+zhb8ajQSpUa3fic++B69p/+elXSWNO3oVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWfTIdHPNCJ/DsmJv2PJtCvq5BQpJodWyDav4o/KMEr0srq2RG
	C2UKpIrZrx62C6XuqddDgLTkksFyYMtLOiCGH4BQQ67gIlhDyvmcwyYUlQfaN2c=
X-Gm-Gg: ASbGncsk/ih0zzXKUzAH3gxai6IZjq583mSo5TU92kvrqZM/+l4GKbh2HNKwofnGCS7
	ZgAvr93UQis/G/CHFO0UG7GFobW0P1b88jpLPBQ9nXnIEJZTzh+x+uZyFEsn/h1Xa6or8E8fauP
	mfIdFuDBMHbi/bQphwyAQZm+Hka0kMBzC+x4PIge98s3cYB8rvyelbbK1x35vlOb603wtno0Y8H
	k12z9WvHAfdLWB4JeoWX8cOQY5FAFQ7H3vFjMiM7e4nTbAVqQPy5zsrlMpdue8k6IXPT2gZ19lE
	tiPCI1IQcQ+oHGgl15f/ze0F+6XWyCqZoaLYRE+nzrR1fGXgR6hoZOLGOCip+MtadMA33zblmX+
	i5Bcn13YreuRdIVVMrtK6pKQgi3lS
X-Google-Smtp-Source: AGHT+IG3tuVguXn8VMgCu6sKWPV/ocanlmbBg3hUDHZimmGHiNDmeLkru9JZ3Nv+KSAa/KV/eaCfAw==
X-Received: by 2002:a05:6402:35d3:b0:5e7:8be5:d189 with SMTP id 4fb4d7f45d1cf-5eb80ca9ce2mr1398560a12.4.1742362705701;
        Tue, 18 Mar 2025 22:38:25 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e81692e6d4sm8511817a12.9.2025.03.18.22.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 22:38:25 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 19 Mar 2025 05:38:23 +0000
Subject: [PATCH v2 1/2] firmware: exynos-acpm: fix reading longer results
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250319-acpm-fixes-v2-1-ac2c1bcf322b@linaro.org>
References: <20250319-acpm-fixes-v2-0-ac2c1bcf322b@linaro.org>
In-Reply-To: <20250319-acpm-fixes-v2-0-ac2c1bcf322b@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

ACPM commands that return more than 8 bytes currently don't work
correctly, as this driver ignores any such returned bytes.

This is evident in at least acpm_pmic_bulk_read(), where up to 8
registers can be read back and those 8 register values are placed
starting at &xfer->rxd[8].

The reason is that xfter->rxlen is initialized with the size of a
pointer (8 bytes), rather than the size of the byte array that pointer
points to (16 bytes)

Update the code such that we set the number of bytes expected to be the
size of the rx buffer.

Note1: While different commands have different lengths rx buffers, we
have to specify the same length for all rx buffers since acpm_get_rx()
assumes they're all the same length.

Note2: The different commands also have different lengths tx buffers,
but before switching the code to use the minimum possible length, some
more testing would have to be done to ensure this works correctly in
all situations. It seems wiser to just apply this fix here without
additional logic changes for now.

Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
issue is in linux-next only afaics at this stage, as driver is not
merged into Linus' tree yet
---
 drivers/firmware/samsung/exynos-acpm-pmic.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm-pmic.c b/drivers/firmware/samsung/exynos-acpm-pmic.c
index 85e90d236da21ed76f7adba59caec165138ad313..39b33a356ebd240506b6390163229a70a2d1fe68 100644
--- a/drivers/firmware/samsung/exynos-acpm-pmic.c
+++ b/drivers/firmware/samsung/exynos-acpm-pmic.c
@@ -43,13 +43,13 @@ static inline u32 acpm_pmic_get_bulk(u32 data, unsigned int i)
 	return (data >> (ACPM_PMIC_BULK_SHIFT * i)) & ACPM_PMIC_BULK_MASK;
 }
 
-static void acpm_pmic_set_xfer(struct acpm_xfer *xfer, u32 *cmd,
+static void acpm_pmic_set_xfer(struct acpm_xfer *xfer, u32 *cmd, size_t cmdlen,
 			       unsigned int acpm_chan_id)
 {
 	xfer->txd = cmd;
 	xfer->rxd = cmd;
-	xfer->txlen = sizeof(cmd);
-	xfer->rxlen = sizeof(cmd);
+	xfer->txlen = cmdlen;
+	xfer->rxlen = cmdlen;
 	xfer->acpm_chan_id = acpm_chan_id;
 }
 
@@ -71,7 +71,7 @@ int acpm_pmic_read_reg(const struct acpm_handle *handle,
 	int ret;
 
 	acpm_pmic_init_read_cmd(cmd, type, reg, chan);
-	acpm_pmic_set_xfer(&xfer, cmd, acpm_chan_id);
+	acpm_pmic_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
@@ -104,7 +104,7 @@ int acpm_pmic_bulk_read(const struct acpm_handle *handle,
 		return -EINVAL;
 
 	acpm_pmic_init_bulk_read_cmd(cmd, type, reg, chan, count);
-	acpm_pmic_set_xfer(&xfer, cmd, acpm_chan_id);
+	acpm_pmic_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
@@ -144,7 +144,7 @@ int acpm_pmic_write_reg(const struct acpm_handle *handle,
 	int ret;
 
 	acpm_pmic_init_write_cmd(cmd, type, reg, chan, value);
-	acpm_pmic_set_xfer(&xfer, cmd, acpm_chan_id);
+	acpm_pmic_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
@@ -184,7 +184,7 @@ int acpm_pmic_bulk_write(const struct acpm_handle *handle,
 		return -EINVAL;
 
 	acpm_pmic_init_bulk_write_cmd(cmd, type, reg, chan, count, buf);
-	acpm_pmic_set_xfer(&xfer, cmd, acpm_chan_id);
+	acpm_pmic_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)
@@ -214,7 +214,7 @@ int acpm_pmic_update_reg(const struct acpm_handle *handle,
 	int ret;
 
 	acpm_pmic_init_update_cmd(cmd, type, reg, chan, value, mask);
-	acpm_pmic_set_xfer(&xfer, cmd, acpm_chan_id);
+	acpm_pmic_set_xfer(&xfer, cmd, sizeof(cmd), acpm_chan_id);
 
 	ret = acpm_do_xfer(handle, &xfer);
 	if (ret)

-- 
2.49.0.rc1.451.g8f38331e32-goog


