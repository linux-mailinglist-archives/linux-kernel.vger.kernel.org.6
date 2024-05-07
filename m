Return-Path: <linux-kernel+bounces-171413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AB48BE466
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 139F9B2B07A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FC81802A8;
	Tue,  7 May 2024 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="garPljce"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF12316F85A
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087929; cv=none; b=JJxbwsOSKn5hzPulDxu5Cqv4s4YwBrL3uQoRXFq0CdLLL/lBWnfKuTG0qDEWZGfKR5IemlYrm/X82Ec6Mc9l/8XmYlQR1o5HLKHrz23GpGKUvN5NPKCIs8BlC4m9WGjQVim15TcMbUsK+FtLgtXqOKOyXsVDO1PzTc3Mdc63P4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087929; c=relaxed/simple;
	bh=xx+wxFNs3ZuqK7Hxds/mLdbM5HIFghI8UQG5DaBamLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DAqMtgQYVK3RuQsml70ZmOQbHYT/HK0ox8OJfWF5kLFVmVrEZ978QxoDAXXxc3ozwBX46wd2H+CW9i5dbwWotiiDJPEqyLU1ftzaK1S/HROMIOvl5vNyqPOln6ozQfLa9QLDsLT8VTT3xWwdT9gKAj2+9vX0STacxtZjVSPIuWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=garPljce; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6969388c36fso15048936d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715087926; x=1715692726; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=24yjDTHuOCF+C8SbX9O7bVVIA87jnk99ezK2b/3Gma4=;
        b=garPljcecjdkN6g8mvA+SMMfsdgqxokHgqjgJwXYDnh+7+6pxUpSAk0DUlD95uevNs
         TCt/3xTog5KdLlcGfUR/zheJUzVyYhjYmnE6SQaQP9+qsMZI+sQILhIXBVQG+OLCt7+I
         RnDymbMwEyyBe148rcabRZCSHfxiCz58EKJPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715087926; x=1715692726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24yjDTHuOCF+C8SbX9O7bVVIA87jnk99ezK2b/3Gma4=;
        b=Tv2Wrlw8GwZ9Pe0HWwpOXKAcmRJPQREVVKZ6x1OKw7PDKZCLtv2HlBmucO2fr1pbvO
         fRr8Js1dbwzAuF71sqZ8/39+TB2uRPfVmJdgsZakKsdAzt62Ky5pL4tUVWAYhai9lldH
         x1ec5kWPHZKio8WpqlJDDkK8C5DwQ65L9mEHcATpxd8Bh9YBNoyVlCESsc1U2V5zakOm
         infgV4BwTOzMd2nE+8DBLcsQeeAjgNpJaJCRtIESfRWjpJmJt3XKozln/xHY/IeA43H1
         W00mF20YvRpNigotBiucESscUs6v7HDfWC2rdhdALKMgZjmmJZxhI85C9BOwPo61hpRA
         JR2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUWPR1aBt//zIzk9Yd0YpeQMCZah7pJJOr6ySjcwY37bFOcy8lih2FfOknKyPmc9/VyaVE4e6LGIFK8q7Kqn0nATxeGZWfe0GFnJO0
X-Gm-Message-State: AOJu0Yw8x/eBgE6sE+0Pqg8xQzCLODhjQ6X+Xkg+rqAZgRwm2aFQqvJZ
	WXw05kQrbbvN0Fy3+n955Vv0K2EU0lEZuCm6w5Qviiuy42kuRKp65vYtlCCU+A==
X-Google-Smtp-Source: AGHT+IE6WEUHWsRpAsJ5BK3gENbuRTlCVd8egHvgiFgdym5FLM6gUWkr0leru0COMDpv6wPoQvFI8w==
X-Received: by 2002:a05:6214:d6a:b0:6a0:c903:7243 with SMTP id 10-20020a0562140d6a00b006a0c9037243mr17142784qvs.55.1715087926638;
        Tue, 07 May 2024 06:18:46 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id t15-20020a05621405cf00b006a0d19c3139sm4655105qvz.118.2024.05.07.06.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:18:46 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 07 May 2024 13:18:44 +0000
Subject: [PATCH 18/18] media: venus: Refactor
 hfi_buffer_alloc_mode_supported
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-cocci-flexarray-v1-18-4a421c21fd06@chromium.org>
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

Replace the old style single element array at the end of the struct with
a flex array.

The code does not allocate this structure, so the size change should not
be a problem.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_helper.h:1233:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index dee439ea4d2e..9545c964a428 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -1230,7 +1230,7 @@ struct hfi_interlace_format_supported {
 struct hfi_buffer_alloc_mode_supported {
 	u32 buffer_type;
 	u32 num_entries;
-	u32 data[1];
+	u32 data[];
 };
 
 struct hfi_metadata_pass_through {

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


