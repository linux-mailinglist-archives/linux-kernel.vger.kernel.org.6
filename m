Return-Path: <linux-kernel+bounces-284775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2C69504FD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D771FB26E22
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B3C19ADAC;
	Tue, 13 Aug 2024 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QMn15TvD"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E15119AD85
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552292; cv=none; b=k0xhM3qE4/UCEgbErL/9a9tDeiUr5QEoVoSP/Tfj6dAHTDnaqMcTw5pBbtT5Yuz3db7K6lBQagcsvf+XdUQohxe8arkboHHKZ2inki6ycKhf9jaLQlPppNkypfGU16oKJagwbn0rVcj7I5tbsWCkhZrsh43wxX92R/GTFPqbS3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552292; c=relaxed/simple;
	bh=ZL1NQsUr+liQywEoPKyXYweeFBwJ9jb0tSJpH+9ycBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AykOaqATbp2ZbRMF25rP5Ebk+TGwf1r/q9vXsg+aSsxf0kuyfuzrvEVT1Ft+EN7oM9yGVfTjBtKmAMemulRc8yKHuBbZ8k80QDFwoFEQ8VboyZfwXN/edAOqJObX2FFHMTxt9p5hqyh4cqCO7GQ9u0ri6UZjt+S4UCCliSogJ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QMn15TvD; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1d6f47112so324054185a.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723552289; x=1724157089; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPUEi7uFjzY/rlu/HW/qtzhNgJ8EHrsVhU1gvPc5vvQ=;
        b=QMn15TvDv7mlw3QTOAGW/Y5rko3pr7VharwKEr86efGIgyVGIOIi++LbfDZTDGW2IX
         hYsKDB/xGqqZ48QJRuxU3dhXT3iBbSM6zNyYL/P/LGlxHkYh6elIGHo8EIEH+zPDnCZR
         6KKC5Z24qfC5SuEqTDuPkcjKlljfWQidAdaxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723552289; x=1724157089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPUEi7uFjzY/rlu/HW/qtzhNgJ8EHrsVhU1gvPc5vvQ=;
        b=t+ekQGXGKtxMlC/HWdejxI1oPBwW0ufaFlCa8Rj+/Rv0AM5f9c0xJ4gwgJjc6djkDY
         RhXpXl1T8hzcKRUFlWQR0aHkrAdzYFBzzFQdT1Me3X/it2DuNsspOPl3v6TgngcHWr/y
         /6/8WAb0e2UQsefOCRKdDoVpdOQZAQtQA19tYg1v6fXX7Bb8hvwoABtQWDfGl9ESWL8z
         C6gunM8NNan1hHW2xRslJ2v1uWll3FFu2VXYbCenKWoDx4hi3QejTiZSR7A737JgI990
         Cn4UyGmn7zYVWnR58HgRvTYLRTy3D1Ehi51zkGNHMcDnodINpUAmSrP6/c3tDqnC75yq
         JT7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3EkljncKffIcCFqlus8MZ41AfhaKAQOO+/aqenesk0zbxRwJuLjV6hoLmQdh7HuuPaGkYVRIncrzQkjlilyZjzaisdkoaJQ/92ygO
X-Gm-Message-State: AOJu0Yyl5hZTn/FR51Bkqgwc+fZ32tn8ON5dYn0mxIMW3CNX+FW14P+s
	RnxvzowNzRVD1M6iuIblWW+Cju2FkFTy28BXf/9UQKDSF1E/v3UxciH1S1lZew==
X-Google-Smtp-Source: AGHT+IHWcYMugnNAohBPlXl4Q5k2szXJLte2T2nQmFxv7LgGGp8+7SOgzgt3nTX3WjhN51/yObzS/g==
X-Received: by 2002:a05:620a:3193:b0:7a1:d022:a3ae with SMTP id af79cd13be357-7a4e15b9c43mr381001685a.56.1723552289433;
        Tue, 13 Aug 2024 05:31:29 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d66093sm337126685a.12.2024.08.13.05.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:31:28 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 13 Aug 2024 12:31:23 +0000
Subject: [PATCH v6 03/10] media: venus: Refactor struct
 hfi_session_get_property_pkt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-cocci-flexarray-v6-3-de903fd8d988@chromium.org>
References: <20240813-cocci-flexarray-v6-0-de903fd8d988@chromium.org>
In-Reply-To: <20240813-cocci-flexarray-v6-0-de903fd8d988@chromium.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The struct hfi_session_get_property_pkt is always used to fetch a
single property. Make that explicit in the code and avoid a single
element array at the end of the struct.

This change fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_cmds.h:194:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c | 4 ++--
 drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 3418d2dd9371..75f4a3d3e748 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -402,7 +402,7 @@ static int pkt_session_get_property_1x(struct hfi_session_get_property_pkt *pkt,
 	pkt->shdr.hdr.pkt_type = HFI_CMD_SESSION_GET_PROPERTY;
 	pkt->shdr.session_id = hash32_ptr(cookie);
 	pkt->num_properties = 1;
-	pkt->data[0] = ptype;
+	pkt->data = ptype;
 
 	return 0;
 }
@@ -1110,7 +1110,7 @@ pkt_session_get_property_3xx(struct hfi_session_get_property_pkt *pkt,
 
 	switch (ptype) {
 	case HFI_PROPERTY_CONFIG_VDEC_ENTROPY:
-		pkt->data[0] = HFI_PROPERTY_CONFIG_VDEC_ENTROPY;
+		pkt->data = HFI_PROPERTY_CONFIG_VDEC_ENTROPY;
 		break;
 	default:
 		ret = pkt_session_get_property_1x(pkt, cookie, ptype);
diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index 42825f07939d..b158fcd00dd6 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -217,7 +217,7 @@ struct hfi_session_resume_pkt {
 struct hfi_session_get_property_pkt {
 	struct hfi_session_hdr_pkt shdr;
 	u32 num_properties;
-	u32 data[1];
+	u32 data;
 };
 
 struct hfi_session_release_buffer_pkt {

-- 
2.46.0.76.ge559c4bf1a-goog


