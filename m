Return-Path: <linux-kernel+bounces-231564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043B1919A15
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11811F21A18
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC44F194C7E;
	Wed, 26 Jun 2024 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yuhcTIjS"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF093194C73
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719438379; cv=none; b=AJ6FfVQU01hami3PL1gIdNgEYwfROx+i3JLOBwVOZ7XRxD7ne5D4QL9+obWyfLmImmtd497QVfRzjHif4Uz0LHUn74HYrpB8jhHbaXC25OSZ1R2cnKE/syekyg70ykN1aT1g7YQU2Kc4suZCShdgqhd4R08KAbljRJhO5cvaIAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719438379; c=relaxed/simple;
	bh=eEJvD1LxPrQrE2+bV2Gb2aZ/2mj6knY0BTuucbpbbko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QYhaEcSgOFERx8xYy+RPeOvg0Ei6k231SQkPfPLVMh7Yn5SYHGVUsBxhL8DJzh+XjtoaNWURGAIlKfja5VnF/k85Y00bISJNbXBu9FtCVIsP4S9o9OHMMaMisJBOnOCgcFr6ZFyKwgG+sHcSUR0yhGrfRpmkjPRWv92SwNyVeRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yuhcTIjS; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebe6495aedso77600781fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719438375; x=1720043175; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1yr/14qrVQ/kYRjN6UH7sAJcJ6ZPXNM+nWCpzFkpGA=;
        b=yuhcTIjSDxxB0Rrvj6fbW1cDqVmO6DsYE7R3WL5wWlFINFy8W4vHQzFcRIj1Y/TI9S
         063C+HkpimmbhNZVgfFDSEs3LSae5GeMUWtfSBRz+wY1G0BPq/yP1TO9Y9X3uQN78TTO
         sM+ywKIc/ZLnFJQggSzy3MNG8gmbN8zoRPMjo+IrONnnlr7LIA5H96ua39KNdKVzRcBI
         heE/AY6rkLThneL8vJ1eQ2FC0LRH7tSFpEmyMrgyVHnjXfBpiVX4NzlikH5mZVmSOE2+
         OEDNqHLmv6CpKNfTzNf46aqyhILWj7CEYs9vZbjWWRxoq+Ys9auJqzyZilj7gxDgYSfB
         sHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719438375; x=1720043175;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1yr/14qrVQ/kYRjN6UH7sAJcJ6ZPXNM+nWCpzFkpGA=;
        b=ADl2XTTGLAKqlhCV3cpo7kj8vEfS7N3lXQ4SOpKNksdeYmXthl4BS82vWfSVcYENlY
         wXXxdIpmCYAdchGhwubesygPGuJeIX6nZokY045BS7xmArhjbDlutRVzZysnQ8GKO7ge
         a8OgRSf5tK7EvkVIP2r2i1EwKejvNxPby3upr1fg/ZrmbGsP52OgtaRd9fjL3U/nf88q
         DbxL2m9G0x8BE4wdF2dQPGVxyPWzeiLDuaDFxFqB/XyQQe6a1rc7WovfrAFp9BnRijVf
         wPvd6ZejpVAHQjvCrh8qwC44NnRc/rSHQSTHwUtfOXmkZEFAlQoB7UPc/0F8IvsUtXRT
         QEsg==
X-Forwarded-Encrypted: i=1; AJvYcCVLm+F2BCoMbVUpOQLujZ4+y3u//3mgPBa/9mGcvD02WA3b40JBYFqRG/QQ+pBZzxuvX1VKudY7RExjGfD2o+lgfJ9Mwglq9eIrJs0O
X-Gm-Message-State: AOJu0Yx7A/mK7K4hsqb8OSjed8sGi0qXlk28sdma784ttofd/hbYOtO3
	pWVV1cZN3zEQouob7LgpHgsXbQTBozBGK4oGFx6A2D8avUA7rpDxO5jVSXIJ1MrJBaEJpdSM0gh
	5nUY=
X-Google-Smtp-Source: AGHT+IEjuMjBrK+rXfyXxF8hbNJfQANvpjcRm271/Z+9lFiuoS/ksY9Q8TulAVC4m5zzVOlPgVgzaQ==
X-Received: by 2002:a2e:321a:0:b0:2eb:f472:e7d3 with SMTP id 38308e7fff4ca-2ec5b2840fdmr67894431fa.6.1719438375097;
        Wed, 26 Jun 2024 14:46:15 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a350d96sm23201fa.49.2024.06.26.14.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 14:46:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Jun 2024 00:46:06 +0300
Subject: [PATCH v5 12/12] drm/msm/dpu: include SSPP allocation state into
 the dumped state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-dpu-virtual-wide-v5-12-5efb90cbb8be@linaro.org>
References: <20240627-dpu-virtual-wide-v5-0-5efb90cbb8be@linaro.org>
In-Reply-To: <20240627-dpu-virtual-wide-v5-0-5efb90cbb8be@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=eEJvD1LxPrQrE2+bV2Gb2aZ/2mj6knY0BTuucbpbbko=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmfIwZkyt5CzRwY3hfsGPrmhjoZC7H00MHWqkks
 GnB6wan0WSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZnyMGQAKCRCLPIo+Aiko
 1XUsCACGQ+zsNDJAcL2Bw2/6RRgLe/mxiy/25t541pd6McAGXfdLlKyKlvpgn/FvjEdp1kRVZoE
 Vgx89cQD8WzLjs30HcTBToiSa/zZ+FpJOOk9CN00h+ttZrS41M3chOqvuvWLFGehdUDKud4lup7
 tf33yO0k7VszARMOwQ3sWgNDHL/kiySr5oIsskVLvTyV2iz6t7s1tgbs2k1GKowVTWn6o7oUSGx
 qM/p8o5TW+rU+Yu2vdrkH6nFU6LzV7tCdH0tllE49FDUNMAhPpzHG3H2qM7YJcJanHUg04qCsz2
 ObPQOKuwU9MBta3iru/e5vM43Un2xj1W6U0sRoMmSfc8GStG
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Make dpu_rm_print_state() also output the SSPP allocation state.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index dbf1f7229e45..3e3b6b8daa5c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -890,4 +890,11 @@ void dpu_rm_print_state(struct drm_printer *p,
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
2.39.2


