Return-Path: <linux-kernel+bounces-284774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C38AE9504FA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4D51F22D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07C7199E81;
	Tue, 13 Aug 2024 12:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BcYGVssX"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3938A199E9F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552290; cv=none; b=IlM5Fuh3qvqNOiAlOJrgKyM5spiGm/UIDa7bM51oid2K8fE5I2/WtDMU+u0U+bwLZv3WVyBkUkt3DLI9RbxG0U/lnOZ5s0GoRqmtYznmh2K+Od1mTiOWb/tC8VWyxiCXHvVgf7GvBvMl/G1p+ROjS5oxqxzKpyOH7wVmUi6+N24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552290; c=relaxed/simple;
	bh=jhEUxn/pes1s4feDivojryv2JX3XefUWasZTSaw7ezk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dlY2dfSfB3Gx9Cad04ZSp3jdYgTUYDVTzzAaVPS2hX1C3V5ojFuU0Dywxv86bv0a45O0AFDeqH622p4+uBYV3Js4GocaeEFLsTkXFv1BhWmx3pFHCPdU7OJkrtSksOi4TaeONSHH9Ye6wXrZN/Bw+lju8dEUFZJgADPWtPzvlW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BcYGVssX; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1dd2004e1so338811385a.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723552288; x=1724157088; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIXlD3Ol1LtfkD9H1UrkUWGH9uBnFxqi4VyzSloENMQ=;
        b=BcYGVssXRm6etUVCMvxxXrRbwwLiXtbPeHpTPHJWaPNuvma1TarNsFEv/X2KjlEhFP
         WXfhgTVD6UtXJmPX6+VoWHL7OsTufmBXvraPCsoNYIm2nyBniNhg+f8Mpm/6Wmq8zw1Y
         nCEusZPDmIjW4Sq/foIol6TUkhg1sGLbGucnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723552288; x=1724157088;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIXlD3Ol1LtfkD9H1UrkUWGH9uBnFxqi4VyzSloENMQ=;
        b=T55G0gebICKYXK3EawfO/pvT7Ofx83TfBObk0kOgevbjqvEax1WoQPnWlrvU0YC44O
         Q7HTCE8jH0l/UsPHnN0q7dxrHB2OXRaWQRaDh2ydNCTetinJFfUPr+/4yzaRSIiPyvn4
         L1aGgrDbFUoX6DBzeVZIUJ94Mmqx9zaDpuT0YT1OPHVYCxA1v/xZuNKUDBJl8aI8JaWl
         ecNqqt21zekr3MKW0cjIYN25xSAqGki7WmGmNc+T/YjaZ1obBQ+tH1uvx9WJLCU/vfZe
         06MP4ZBsUc3Knfdwej5B5sjHG8g9QXYUPg5cpKBtjR4PSpsXjaoqxvSii34h/42DJw3E
         PK8w==
X-Forwarded-Encrypted: i=1; AJvYcCWdTddEXd5xT5fUFKZWuE7sxdYOkQNXoDvpU8ipeSePWkcPeanFj13sxtOzboanjsgHjWtuus3hK6oubbmDknuw17qbzyGS2Sfm2gpf
X-Gm-Message-State: AOJu0YxR1ua25a3YiK41waSvH4QKeBmSecoyQI09IeQmRQBBIY8TLhPU
	m5IDx06NXXN0bWpduUhB1gXadWedKq2GvRllKTbq2E4/lLhJOoLsR/iPvma1Og==
X-Google-Smtp-Source: AGHT+IE2xmMkDbsMy07f7CYEHgKUTqwYARJxNMOEOo1+wr1sMyllp6Sk+ESICy3o68XiwLOXgbyOlw==
X-Received: by 2002:a05:620a:40d0:b0:7a2:275:4841 with SMTP id af79cd13be357-7a4e15ab32bmr328777585a.34.1723552288115;
        Tue, 13 Aug 2024 05:31:28 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d66093sm337126685a.12.2024.08.13.05.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:31:27 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 13 Aug 2024 12:31:22 +0000
Subject: [PATCH v6 02/10] media: venus: Refactor struct
 hfi_uncompressed_plane_info
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-cocci-flexarray-v6-2-de903fd8d988@chromium.org>
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

This field is never used, but if we remove it we would change the size
of the struct and can lead to behavior change. Stay on the safe side by
replacing the single element array with a single element field.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_helper.h:1003:43-60: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index e4c05d62cfc7..5e91f3f6984d 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -1005,7 +1005,7 @@ struct hfi_uncompressed_plane_constraints {
 struct hfi_uncompressed_plane_info {
 	u32 format;
 	u32 num_planes;
-	struct hfi_uncompressed_plane_constraints plane_constraints[1];
+	struct hfi_uncompressed_plane_constraints plane_constraints;
 };
 
 struct hfi_uncompressed_format_supported {

-- 
2.46.0.76.ge559c4bf1a-goog


