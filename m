Return-Path: <linux-kernel+bounces-284773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FFF9504F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6FAEB26974
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6011993A7;
	Tue, 13 Aug 2024 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eQ9EUiEo"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E3A199E93
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552289; cv=none; b=U39KbrA7CGDzqIAy2fvkguGTBiH9QjDEdu9WtGw5FhJzYpjdHvXODHRX3DS4ZnJbee591/oFXYd2DRUNYmTMXdHcLcWkj9En2siTkdmyrjdtI46ySpNpqXlwwIlQ2nM6u+PYiB+waDkipq770w1IyWcmrTvH8fNdeJWOaqFrQgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552289; c=relaxed/simple;
	bh=2hjYCqULrObPbnZbgHzv3uAJ+2uRB9aIgS9bUw6j1Ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mtn4Idn2dwUjjHvhpxe9CC+Y0qrgWAFysoW60HcyumpUSVrwsmuI1VwoK2WgAAyhutO1cshYwxj8sGYJHihyZgrcdwaDvbfnXXrmgMmQC2vxE3g5kuMUt6U19XMpPmxLHTIZJ3o+4mUpe345G7oPSuyuinlQujJC+9DKqpBJLa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eQ9EUiEo; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70945a007f0so3271369a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723552287; x=1724157087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T26HDWEax3Ht99GbJ/5oCiq/G1VLMfwUsOvAjWX6wxI=;
        b=eQ9EUiEoqF3JNSQxYYIv66MNO57vkb+5MRLgZSN4y4G1SLVjTrsHwVyoQYoJ8dyg12
         5eFOKO+bEu4yPkWbCmjhcI1gaQem3uekT/5Pq0ZX58qUBDMCRIvBIn+keFdXIUmmMQG4
         eBinKE0Yahqbp8bUI9IhD9u66dRG2u2z6/1yM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723552287; x=1724157087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T26HDWEax3Ht99GbJ/5oCiq/G1VLMfwUsOvAjWX6wxI=;
        b=iZHxXazQftlVGPKjXlc/Rr4yEBAAVJrl8cipK4Jqp7gSe2p/e6uZUJvs+K9y23JKu4
         CwDXD2tYkWPBpEdtMNmvWRX3Ei8G+WXox0SGVcqDTIU6/8koLGuNQI1lh70btMWuedg7
         brBqH5L/dlbyzyCM6n9OJBjW4okfYOJ6/ZJiw8BMOqWRrcGvnfMHHg+Ismf3XovsZ6a9
         Wmr8uRvbLaBUmbLEXSfS8hFGZcZd+c7oh30UIsVezkB450+L3/mrSfeDjrJpafUHLCaj
         8SLUr8EgBCW8FxnapIXcU77/bpGNCLIimvp1KGGxFBZRlULNrTkhhIX0s6/q8KAUzSX0
         e4Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUZyMHYbJ4j2ehtSBBcMc6scZPA/ww8MjInlaUMeHFW090M5miSYxSVwcR2eYIZzO+AkBh5c3MASkfVG1f2uH4NxKPIWZph6vVl8lwx
X-Gm-Message-State: AOJu0YzsaPbrGqg9h1xcTP9BHPMcQsMjbbUdXj2F7XuXmt7gkLOOJl7U
	VAC7Wxiikhajgtrypkf97WEBrYDjW23O2SUKej7JglTi+sKZe9yQ+1vLfUgCeA==
X-Google-Smtp-Source: AGHT+IEt8IEr4mOSgyEydVS86tXDc+nflK2P9LtnkTrXNE23dIpoewktVCky3idoeTnXKhksyaliGw==
X-Received: by 2002:a05:6358:4287:b0:1a5:dca5:a902 with SMTP id e5c5f4694b2df-1b19d2d037amr358929755d.17.1723552287107;
        Tue, 13 Aug 2024 05:31:27 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d66093sm337126685a.12.2024.08.13.05.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:31:26 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 13 Aug 2024 12:31:21 +0000
Subject: [PATCH v6 01/10] media: venus: Use flex array for
 hfi_session_release_buffer_pkt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-cocci-flexarray-v6-1-de903fd8d988@chromium.org>
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

Replace the old style single element array with a flex array. We do not
allocate this structure, so the size change should not be an issue.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_cmds.h:204:5-16: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index 20acd412ee7b..42825f07939d 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -227,7 +227,7 @@ struct hfi_session_release_buffer_pkt {
 	u32 extradata_size;
 	u32 response_req;
 	u32 num_buffers;
-	u32 buffer_info[1];
+	u32 buffer_info[];
 };
 
 struct hfi_session_release_resources_pkt {

-- 
2.46.0.76.ge559c4bf1a-goog


