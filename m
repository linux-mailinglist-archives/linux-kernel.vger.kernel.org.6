Return-Path: <linux-kernel+bounces-171402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936C38BE400
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDD01B2B1D1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421A416F0F4;
	Tue,  7 May 2024 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JtFfH2cG"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C338316DEC2
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087923; cv=none; b=Mp3HQAGYOCaWPgZ5eEFzWZxtoxFyEnmxdU48mhS7uDQt/uwoC672lWdY0cG1Sjcl4X855kX6c9NLY1ScM4vZZ7HoU8QW1y+TQPdrFQecj1FXJB54M410p27f51j4OFnS2fdLhHxaM8VPv/RPKmY5VntOK/sx/6sFYPYNBL8rLko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087923; c=relaxed/simple;
	bh=9NQhYiz/IbLF6F7xrUyCvcZeCyvNKJflJvFw3WrA/2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tdclcvo3tmLMepMf09sDDLEOTnGy/GBB5oOn5OysMH0zfpXOsJ0dSRBt0vSGSchuM5YKNVf81uQIAJEEAZawe+3NLzW39QRSGloFxEG648qCob4Uyd2wpQImWLi8t4TBIxhFpaPncWwE39zcmKOA0L7/ea0Xuo++UTusSWWLNgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JtFfH2cG; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6a04bb4f6d5so20313936d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715087920; x=1715692720; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WR87o59ttHnNvNigBqZHzwph/s3gT6BLw9Ga86sRtPA=;
        b=JtFfH2cGcjafuPkormhgFTXYN5icqyHToRCqOanoGWywBAv15WOhzX7Yr/hNCBbAh9
         UL/9mfYyfkvnseYqsoXooMmkPQFGWZUochXnI59uSMICypEzYxNfS028r6x3qvuXJTtf
         LXfoHLOggxXCMD50eYw4FhGeXCnpuLG2X7ndk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715087920; x=1715692720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WR87o59ttHnNvNigBqZHzwph/s3gT6BLw9Ga86sRtPA=;
        b=YlFyRneQIRPpnbzaiEwZv+c4Ir/+IxTh5EG0nbhnElmz+EvXwL5pT+DhfApUuJ296e
         r8F3RM5ngY4drvcGpIx+D6bC/IFWgqiUOTccq7UfnGMjXqG/t1kJg0BUwgkabVFJMAcx
         tHOQq8BIfwnTQv3LKOO/tcTkSvIg+DeB8PeBW5Ae3yQ2d7c0o5z8txd5ZdYkVy7r9aiL
         A+704OnJRcq5BqNEXuC3HCboBBKRK2qYhEOScmBnxb+5U2j8i12n0lJFG4tmNoHbtOHs
         N4LrjFHU9yg/mtdwX6l8v5fUJkpO43uXQhwaiebQAxfLNe3FifNEVdqdmJZwsEMtiOPa
         965g==
X-Forwarded-Encrypted: i=1; AJvYcCVMRFj+8gUHXZN/WbbANLGN0OpNFg1qTHrLeS94KcG3Xv6mp+0AhGdrGTnz98hz6mNGYcGY53HjoW6uWKjienbplZZNeQ24cqJVb8ld
X-Gm-Message-State: AOJu0Yxbll/VeKY7GrlNCor7RIbRlNRo+WxEUi3X6jguKWyD3ILjT9Vf
	icMCbSlO90w36RrS8fFEY73N/r87r0d/5/JJeYa7xNliXNMEo0sEkph5hWEfmQ==
X-Google-Smtp-Source: AGHT+IGatpIQRwE9h01tY7yyLZRrAcLmql6eJb+YKcxD2Wq6gpUB9pyNvjqWHkivGZUb+9PKsnvIcg==
X-Received: by 2002:a05:6214:c4b:b0:6a0:def6:6c8f with SMTP id r11-20020a0562140c4b00b006a0def66c8fmr15390917qvj.47.1715087919625;
        Tue, 07 May 2024 06:18:39 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id t15-20020a05621405cf00b006a0d19c3139sm4655105qvz.118.2024.05.07.06.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:18:38 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 07 May 2024 13:18:36 +0000
Subject: [PATCH 10/18] media: venus: Use flex array for
 hfi_session_release_buffer_pkt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-cocci-flexarray-v1-10-4a421c21fd06@chromium.org>
References: <20240507-cocci-flexarray-v1-0-4a421c21fd06@chromium.org>
In-Reply-To: <20240507-cocci-flexarray-v1-0-4a421c21fd06@chromium.org>
To: Michael Tretter <m.tretter@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>, Andy Walls <awalls@md.metrocast.net>, 
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Replace the old style single element array with a flex array. We do not
allocate this structure, so the size change should not be an issue.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_cmds.h:204:5-16: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index 41f765eac4d9..6dff949c4402 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -201,7 +201,7 @@ struct hfi_session_release_buffer_pkt {
 	u32 extradata_size;
 	u32 response_req;
 	u32 num_buffers;
-	u32 buffer_info[1];
+	u32 buffer_info[];
 };
 
 struct hfi_session_release_resources_pkt {

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


