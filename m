Return-Path: <linux-kernel+bounces-284747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2864E9504B2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A58B3B28851
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE3019CD19;
	Tue, 13 Aug 2024 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kaQqtdws"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A0919AD87
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551239; cv=none; b=qsspBu79k3nspRFAICkx4dYOaJZk7PfY86QBx/GAgmt6JsVmzytvmYB92QD9Zd+rOVo8wqirQmmTZOzhe5PulFDDudU+C1VEmWYJCxKzmdun7EbYGUC4lo44fgLiqMCFVPNblQ5O8HTNDQ473wQsGSQbmYblZsYzEVHl3rZZ6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551239; c=relaxed/simple;
	bh=98X2t2WGiLxxCwmlaq0/ko8VmZHn8l1cDrLmrBX7bbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UWyLnDZ7DAIiMM0gwt602FrfMHp12oKXfo62qK6+DxZkvIw4jjRiyowhXFUi/i6Sm4xwm4NsEUJEUIu8d3dYSaSqoYn/kL27EXtLPdcoQifFJDT4AKgn/rdobFO3BzQEOBYxwoXHs2Zwd+scDupZt5xZY49+4416jNAtfrU8o8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kaQqtdws; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a1dd2004e1so337973885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723551235; x=1724156035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryvSTyFRHLyFB4VqqsDZg/Laqqf7RuuAiNN+vKB3Dic=;
        b=kaQqtdws1n+9WYWkcqyYKwk96e+SvEU8nQkTp/2R5cZS+HQ/Vs6ezvlTmFuPLKiYVT
         hImULzf7ogwbUUvdGVDmev8VruMSo/L+bmQq6AHCc99i3L+54QFg39cBiOiuSkGgtEcT
         h0g846mjMKq9XPun+I/QbC73br7kVmFxMJdow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723551235; x=1724156035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryvSTyFRHLyFB4VqqsDZg/Laqqf7RuuAiNN+vKB3Dic=;
        b=CRGL3TvYMG+vZsRWik4brax5u4ouFJUszml8iERW2iPQ9PT9u0vsHCZWXpf2op9O4v
         6a6jaSFbHK36H5L0pyuGPLJdt5eHCToHIlcenHwNOfAYt/qbjbNyQ6pmUdNFvfcqKvo8
         CshxLoscDv6nPaW3SDFe8tlDMsrEXXtzblSOaO95TCKxE3FhgLqNKRYcVaAZhG3kufR4
         hBmDK9ti6jJemYTh5SyRPZpAH0pfBCuW3YV2izOAMjeudtHK2EsjSjmvS8dyKpEBWfxQ
         KaoYixXAMuCFwnm8he4T1ZDp08BRnmURvMx+l3vvg/vE3By0J4tUVU1ryLtgjFfSATqC
         C+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCX49+x4cMSFvLu8RCN0WFrjxuDtUY++XuyYO3flTB3fGjaz3njY1Ve9QsTPJz+0doKI7i3nXa8BHzNnwD3X3XxL5jLPFWQU/Jq/DO27
X-Gm-Message-State: AOJu0YxFMe+2phGvpCkr+jfutOYsv26NX6+ZzgR95/UqU/N3RoLDmoDO
	/fRzNjXRQ6rUx8TPAk8RD1VlQ4X6n/MzcczJ9LE5FhCW+I3f3MW6nmwgImCGmsGrnw5ELnftoJw
	=
X-Google-Smtp-Source: AGHT+IEOX25WNCrWUaMxc3lkZuEvbZq3/dMLr0NrYO2cFstfRrmQqZhk/+W2xbcY25YibUai9xTEGw==
X-Received: by 2002:a05:620a:31a9:b0:7a1:6062:ed63 with SMTP id af79cd13be357-7a4e15a434dmr379872785a.29.1723551235139;
        Tue, 13 Aug 2024 05:13:55 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d71ca8sm331765485a.50.2024.08.13.05.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:13:54 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 13 Aug 2024 12:13:52 +0000
Subject: [PATCH 5/6] media: meson: vdec_1: Refactor vdec_1_stop()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-smatch-clock-v1-5-664c84295b1c@chromium.org>
References: <20240813-smatch-clock-v1-0-664c84295b1c@chromium.org>
In-Reply-To: <20240813-smatch-clock-v1-0-664c84295b1c@chromium.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 =?utf-8?q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Factor out all the power off logic, except the clk_disable_unprepare(),
to a new function __vdec_1_stop().

This allows vdec_1_start() to explicitly clean-out the clock during the
error-path.

The following smatch warning is fixed:
drivers/staging/media/meson/vdec/vdec_1.c:239 vdec_1_start() warn: 'core->vdec_1_clk' from clk_prepare_enable() not released on lines: 239.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/meson/vdec/vdec_1.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/vdec_1.c b/drivers/staging/media/meson/vdec/vdec_1.c
index 3fe2de0c9331..a65cb4959446 100644
--- a/drivers/staging/media/meson/vdec/vdec_1.c
+++ b/drivers/staging/media/meson/vdec/vdec_1.c
@@ -129,7 +129,7 @@ static u32 vdec_1_vififo_level(struct amvdec_session *sess)
 	return amvdec_read_dos(core, VLD_MEM_VIFIFO_LEVEL);
 }
 
-static int vdec_1_stop(struct amvdec_session *sess)
+static void __vdec_1_stop(struct amvdec_session *sess)
 {
 	struct amvdec_core *core = sess->core;
 	struct amvdec_codec_ops *codec_ops = sess->fmt_out->codec_ops;
@@ -158,10 +158,17 @@ static int vdec_1_stop(struct amvdec_session *sess)
 		regmap_update_bits(core->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
 				   GEN_PWR_VDEC_1, GEN_PWR_VDEC_1);
 
-	clk_disable_unprepare(core->vdec_1_clk);
-
 	if (sess->priv)
 		codec_ops->stop(sess);
+}
+
+static int vdec_1_stop(struct amvdec_session *sess)
+{
+	struct amvdec_core *core = sess->core;
+
+	__vdec_1_stop(sess);
+
+	clk_disable_unprepare(core->vdec_1_clk);
 
 	return 0;
 }
@@ -235,7 +242,8 @@ static int vdec_1_start(struct amvdec_session *sess)
 	return 0;
 
 stop:
-	vdec_1_stop(sess);
+	__vdec_1_stop(sess);
+	clk_disable_unprepare(core->vdec_1_clk);
 	return ret;
 }
 

-- 
2.46.0.76.ge559c4bf1a-goog


