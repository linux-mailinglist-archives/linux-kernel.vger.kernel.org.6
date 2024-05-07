Return-Path: <linux-kernel+bounces-171409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A3C8BE3F6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364671F22366
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDB8171E44;
	Tue,  7 May 2024 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mkE1ZY08"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A9D16F0F0
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087927; cv=none; b=kVYf20bZPOx9OFoZOjintIzvO/ElZKGcGqVZgC4qNyotkId+Zmtoi5QY60o8JWhp4vx9Eb6pozRypMPTJmQJhxIk51OSC8UCGlKxxEHwNGBYK3elR1AhaaDHK6CktoXDD3FZI87vcHKC3dA/mLrhvFCidJUt7Yo6qdTSLGij+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087927; c=relaxed/simple;
	bh=NAI8v6owc4vhrxHrnDBAOrLbBtSLWdHrs5V1XLgw6yE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PcaEt9ZRAzd/3x/JMkPDhgZzf9ye/hGig6Pyaz7tGSfGbbZUw+b3uFyWUgFAqhwhotfkS77QKmu8djye0TuDgv082PJIJkLfzv3+X5WeOutWLAosTphFikO6l0e+EKg+srt4Y4rcLeZ/rkWbOaJs4qWBAcdmiVDDxhhznPaigMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mkE1ZY08; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43b06b803c4so21011671cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715087924; x=1715692724; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksOWhtvDjU4SOAc5LYb/tmHPugkENGAwplW75xl0q6I=;
        b=mkE1ZY08WgFx5e9j3ZW6XfmX1UhPu3Oup76tcm/uSloODw+9SZu/D/pbdfy3EsNT4y
         87Kfrmr9CEv/JFxXQgOdWTsOcJYquFZt5puPdTQeUMuAOC1dnmQ4pDIPVzrVBZNBqok5
         KACSkAzkfY/LSexeSVmgj44XuGexd81Of1hfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715087924; x=1715692724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksOWhtvDjU4SOAc5LYb/tmHPugkENGAwplW75xl0q6I=;
        b=tjcFZHt4MG3qCsJmwOEDDoVQSwZVG4ZB2E9C/Vxnye+sMI3Z1OJUaQzwHmiG3doJWQ
         YRMwtK0mpRPsQkdb1GTq/4Ry+Hae24G7t64ezjqU6ddC9PgnaRU6mn28pRIzegDI59RF
         1uEojcOOduPLuKvdidtNx+mtIIjSHLsDkaYbEnIt2wJx6rZQsTkiPOa+KWNVyns/6Es0
         K2oY9FV4akMFNoqoVSa+R5T5SBLmkAHGkAfB9XdyLg0lCzpGIg5uKR4UR0vF1vpBbC8R
         fFre+822Ivxa3/GnJRECXa8zA2Ufkbe3qkvVB2CFqkcHAn4MiBHJGp5KFbEFvV3Xpx8I
         yoAA==
X-Forwarded-Encrypted: i=1; AJvYcCX/rrDZzN2agpEsn3CsPVmI+ALNCRxOnPQjZ+Q8Ho5QfCLSu7iuoS2RiIkauoxxz73CMQZF4VeWGg+D/PIEcJMBPCEfoOc8aBWEzJY+
X-Gm-Message-State: AOJu0YydUq651IEvWRMBmzpQlAbgJgYWpO0Vwfw1if15vpO1tZs0Pr3B
	HgVmHLkWUVAXDxJuzlxIl/rxAU8T8SaKXIkJBW2UaYlx7Jv/rsYbY37zO3347A==
X-Google-Smtp-Source: AGHT+IGtSin+RqjeeAuWjhc+2Qu533gps/bRqdwUKUS9So7G1IUcL44UetlZwIWAlGuPmz38aWSKJQ==
X-Received: by 2002:a05:6214:d63:b0:6a0:c117:372e with SMTP id 3-20020a0562140d6300b006a0c117372emr15802826qvs.12.1715087924051;
        Tue, 07 May 2024 06:18:44 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id t15-20020a05621405cf00b006a0d19c3139sm4655105qvz.118.2024.05.07.06.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:18:43 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 07 May 2024 13:18:41 +0000
Subject: [PATCH 15/18] media: venus: Refactor
 hfi_session_empty_buffer_compressed_pkt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240507-cocci-flexarray-v1-15-4a421c21fd06@chromium.org>
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

The single element array data[1] is never used. Replace it with a
padding field of the same size.

This fixes the following cocci warning:
drivers/media/platform/qcom/venus/hfi_cmds.h:146:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index 15271b3f2b49..02e9a073d0c1 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -143,7 +143,7 @@ struct hfi_session_empty_buffer_compressed_pkt {
 	u32 input_tag;
 	u32 packet_buffer;
 	u32 extradata_buffer;
-	u32 data[1];
+	u32 padding;
 };
 
 struct hfi_session_empty_buffer_uncompressed_plane0_pkt {

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


