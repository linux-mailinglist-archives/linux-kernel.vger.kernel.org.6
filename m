Return-Path: <linux-kernel+bounces-446397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D6F9F23DA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920C518858F9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5761918DF93;
	Sun, 15 Dec 2024 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rPfNr1cl"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4B418CC13
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734266432; cv=none; b=XhMMMGkKvbLX7TkC0fPc3iIqqnz+wbaTgkj7R5cFCuOSlc1Hb5/4xxAEpjR/TLCE/KDjJ4vh0i5wPWt3/7LgpkNgvozoKuXhcpz3VqD2K18KDYDeWRxKl6+xiJEwBv5dfu5l771siFSdFOMsaExM51fWLNYhCP4Uyyrtnu+hJkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734266432; c=relaxed/simple;
	bh=rtLNZvWI4/c1Z6JTypcd/rzPjp3y7gPITQRLIp73VhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y9wa7kKWv9eXN1vD9iIggSVB0LqucS3yFzmt6n5n6hPxoM7eKj2J9UvjXPWiEJgRLXdSAbs714kpAnKjxABPgtDBWnVlpT++2Y1bxwnR+IqYipsXOtKL36oKxfpLdXTDp1bGWra5AnnUVLABGfz/HZoPpIieQkIxorL0gWUI+uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rPfNr1cl; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-540254357c8so2920291e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 04:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734266429; x=1734871229; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKqGEI95SPDDmcPKpKKR/7dRWUBLgzZRIDEydq7WGYo=;
        b=rPfNr1cl/OtciG5hd3bXPLzHfuWFk/JK76AAklymqoWg+R35sueUQljXF9mEY+57Wn
         WXPmFhkl4KUkRORSKBaLneGotb/BCRnKMwlnh/JM4cokwKvhlm8LErnNWGrDuqM2SFl1
         AHIbrriplE4XGOH37PmOlKQoictU/OdkxMiOwHD0JFRQZ/H/hqpsY+2FRcDZZc529GQr
         0ozzdlxGKjDw6FVtE5tVN9WkspffS0j/guar1D7YeoBbq+9owazGt26vHLHaC0HA5c9q
         km/1Y7fYYOAAw2oedSZSSyzLY5NoxJAd3BIPnyPhv6m4jC71ZxASpChlEgIf/IItFlmK
         kWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734266429; x=1734871229;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKqGEI95SPDDmcPKpKKR/7dRWUBLgzZRIDEydq7WGYo=;
        b=IIgq4TcZLdMcbNCwrxiAhCAh8ZtGcH/k3/IoB70CdWS9X9+PVRZiG60lf+N+rpFRce
         sm0e6BvVMDAiv/C+DNz/kzjPfm+Ra+ndGTKSuPRnY4p38qAGqnH5KXAX6JieVsF5/L7c
         KgOpuF5m2Qf7i9IZ+N0fUadpYj9vlXPnufOjfKYhaMcc5wWoAj6y9rFvQA3iqHG7a6RY
         JyiTyGdZ+GJA4dcGrPAoTIyp1S40dFL86M+rQBIJmTGBu4PT7Ej0is4IxKDciMnYBg1h
         1OMJ03ozUfuW1A/drT0GLE+e8TjOmtoWoOcITCsd/OxTJFbTridkCvQ/SFGxXq9Wb0Z2
         C0ww==
X-Forwarded-Encrypted: i=1; AJvYcCUwpEhquINNdMTyocfFO5/yXkle9o5l3TihluN6Cz9Esq03K4JposfW36YHwzZrS7UMjSSuseO9c/wvaNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsG19gMiBaD9pycRuSlOgcOqz2H8Rq6LhqMuPztRwNzHsUowbK
	L3E2LW1Y3SwErD5kuH33MxEJftdU5dnKA5jWdONUVhJXu8NFDe+LxtvKvdSqGGw90cYJAWPgZXc
	z
X-Gm-Gg: ASbGncvOcKXU22z+6ahQg4Wl5AC7aZ7qunbKTjLVXCwpVb1mZTI6FYCKEnw9QM+Msxh
	tIUoehqkpYXx7ULHtqMAbmopkthqWtMjTYoYxr5lxphXKrxt1ZCcyTmCTcxquA/RlRaUgQ/XYfw
	owTNI6QqwEfiaHZcjMlZg6udIAeAxj7EYXq2/I3MOdvjZZAuUyMmWiLglrfuemEr43SXlOcfAtc
	tblKpTpx4sC8I58Q/ozkctP9VmyTzV8okfK5W2FujWYgbs2tbiGBrOLVDV3lmlw
X-Google-Smtp-Source: AGHT+IHmwjv0eptuZxFT2gpCHkWuQYV+04StJGmgC+Z4JEQQCD20hv3AqzkFpjgizuTHMQMM+eyw5Q==
X-Received: by 2002:a05:6512:2356:b0:53e:3c3a:2032 with SMTP id 2adb3069b0e04-54099b72f79mr3223549e87.57.1734266428987;
        Sun, 15 Dec 2024 04:40:28 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c13be2sm491481e87.195.2024.12.15.04.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 04:40:28 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 15 Dec 2024 14:40:18 +0200
Subject: [PATCH v8 3/3] drm/msm/dpu: include SSPP allocation state into the
 dumped state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-dpu-virtual-wide-v8-3-65221f213ce1@linaro.org>
References: <20241215-dpu-virtual-wide-v8-0-65221f213ce1@linaro.org>
In-Reply-To: <20241215-dpu-virtual-wide-v8-0-65221f213ce1@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1066;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=rtLNZvWI4/c1Z6JTypcd/rzPjp3y7gPITQRLIp73VhE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnXs4zHmqv+4KEvs+fxhU8HXyTshs00svWF3yCZ
 T6ZvsMWzTaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ17OMwAKCRCLPIo+Aiko
 1a/7B/41SmL6WXZHL42KtlTVJqEfm4JwzZrRiO7+EugrG1qKC+8+k1TQMOS8fjmtA9SfefGuwTe
 qlhWq3y18LWzTMHxLh+BKbguLUrLIP9RsaHzEKF4S6Q5qYrM5BKzKJbYn4AgxOPCKn5ScLAvPqZ
 jj2K93ctOcK01v9sLQp0bdcIvZWqnhc1algDaWSmFrdpv8FBR+5zOXJnM8nzHbhnU9bqkYieebx
 4OvZq2H6wtpipdUTg4Qb2pUkSwjY+ehAhxsL8q07t2SBEfjM7+L53yeF2Y0kuTd/BN0SntNMCSj
 O9byED58fAcpKgEQr/2GVjwyOMcvx7vR9goNc1p/+p4TDG+p
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Make dpu_rm_print_state() also output the SSPP allocation state.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index 2c325bcd328aa475cba9b9a2146ee3e009816551..17b5d53297f23169aba3537f85f02f04421ac9e7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -941,4 +941,11 @@ void dpu_rm_print_state(struct drm_printer *p,
 	dpu_rm_print_state_helper(p, rm->cdm_blk,
 				  global_state->cdm_to_enc_id);
 	drm_puts(p, "\n");
+
+	drm_puts(p, "\tsspp=");
+	/* skip SSPP_NONE and start from the next index */
+	for (i = SSPP_NONE + 1; i < ARRAY_SIZE(global_state->sspp_to_crtc_id); i++)
+		dpu_rm_print_state_helper(p, rm->hw_sspp[i] ? &rm->hw_sspp[i]->base : NULL,
+					  global_state->sspp_to_crtc_id[i]);
+	drm_puts(p, "\n");
 }

-- 
2.39.5


