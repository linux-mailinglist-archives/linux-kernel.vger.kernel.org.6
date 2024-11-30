Return-Path: <linux-kernel+bounces-426079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443959DEE8D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A771AB25004
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF4413E022;
	Sat, 30 Nov 2024 01:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OBVepebq"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3A113BACC
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931732; cv=none; b=U3t2TLUEhuSvOoHuBp38QUF0NzSF7AQ6gECc5sk2KzNafp2sUhu94bWbcjs3mTCbOxpH+Nfq3QdMc+7Xj4+zSFS8awVaGIMUPQTjFc6yg4bceGFT96AmJe2vIxsXrg9pY+q2ic6i4+QQg1m2vNLyFhHSbAqPo9NW9LK1tqSS7rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931732; c=relaxed/simple;
	bh=0H6B6m4YfEscj5/eTxfCR+sI5ay0GD8NDcl46LffCeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ooVgQJ7Z6aGTudW0Id6+LffxPDbty6EOcz3Jg7gpK6WNnqStF7vuiYrhhr1FHJTs+y4/lBoT8RIH9qPj+DUJ0K0BLHzpXMgSdHkRLAOUe7qlcAWw7cMJ1Vz6NrkB3dQyAQJmeaumMz/4kMWIdtahFKLlGF3WNW2gJ0FwBiPoPaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OBVepebq; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53dd2fdcebcso2887399e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931729; x=1733536529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IUEcAbfuBPO7l5+gt8OvRpERGEOEeXxRlakeMrm+69Y=;
        b=OBVepebqpxz1zziwtfDCbATItEwTP4VVFB4uJq+BiSGn3HsmwTDojRZ4LFuMyeGTG/
         E+rSHXEBnNQxSLRXeqoNxcG/Mdwtbs1Fvno4AKBpUZ6ko1jh654yXVJhAtCw6JIP9bsB
         SjLQXkMz71n3jY3Vth0XrYLRVpJdbD1GC7eMFn9TpJLZeFNDZHLVI46peBfECiKYEAs+
         wuwKSJkhj18vSNLayIReRlC4azrKtUeae+A+zNOBNpDpYidJ1goEW0IYKQsC6Q3sV1Dw
         dozCsH24/Wdh8+m+uibMwqiEFer5sjoTkzSKprM3OAkjAVHNczB41v4NZHZFKKiOZpN5
         ireg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931729; x=1733536529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUEcAbfuBPO7l5+gt8OvRpERGEOEeXxRlakeMrm+69Y=;
        b=G6QIBd/syN2/iwk3un1tLL+jMvLUKEvSs2c7bVM5FTmS1Xw0GNiWAZPm0B4ZAXiVhf
         /Y/RPlUH24m2rJb4bSgWfYQliq2H1E7V9s+r9xGP+A1sw0cZmFMblBwwihGHWkznkvyA
         6AQuCCkXJOhNOvmUD0XsRX5dYW5MMJChSP/uaOGj76QdhE8YyQUfN5CACLpt4KAtOWAp
         F7laexbo0G7u8nfsG/tfuWVUDHn80BR/3iH3oqZuSHTpM4iNb9B0waVMGSPoJ+Gk+/AG
         0k2vL3VN5/0hbTPSTQl+2l/d1KbJbeAFUDYkUbY65kOLXM9ffVhMIBzTF1icuA/O26sE
         nU3w==
X-Forwarded-Encrypted: i=1; AJvYcCWCT2uHt6Db5vLJBP6iCkhXc94y+vS/+JgTCh6DHPBDw11yJg/7eLLZjiNSoZCyhMaXiDmZpNyTY/oT/iU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgJyGIn4f1+YY9kGZmf/dUa6PU7BBdGrV7EJwZncq+LGa2o969
	sbsdvBrg8VihPk9VAHNNfq6l5Nz40lz2DS8V+enkF4DjsgOZGm7tUQSvMT3n5DQ=
X-Gm-Gg: ASbGncs3VPPMSY0uFDYBkeMySLA4/d2a6+5tMhjNye+OweUN7B7Wcir399Y43hnA/xP
	6IySVuUTVGaF10Y0Ps5XUbGf7ahAlngIhhNLrDhx8jDW+ZrCqGmoCuQjOdQFdj7dR0oIKhb7T1+
	rxN8BrOlJ4vGXinwdOMvOTYKtm5Zksl9Ha9TLnG0W4fGD+6O4QY9DxzDINWZoZc2BBTFJkVE2ck
	MJ4LwcVYZCtN+QjIGGk+dekYUQxmRgmENxSVxfDBr3cpGIXKrl7FThxXQ==
X-Google-Smtp-Source: AGHT+IHOqKLHvt93hDrBLQHJsz24OXfaq0tMtK/gwb31csC9y6TkKpbJBJNrYlaSsNcduvA1snTmhA==
X-Received: by 2002:a05:6512:b9d:b0:53d:dc1c:60e4 with SMTP id 2adb3069b0e04-53df00d112fmr7905016e87.21.1732931729176;
        Fri, 29 Nov 2024 17:55:29 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6430cc8sm635601e87.31.2024.11.29.17.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:55:27 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:55:19 +0200
Subject: [PATCH v7 3/3] drm/msm/dpu: include SSPP allocation state into the
 dumped state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-dpu-virtual-wide-v7-3-991053fcf63c@linaro.org>
References: <20241130-dpu-virtual-wide-v7-0-991053fcf63c@linaro.org>
In-Reply-To: <20241130-dpu-virtual-wide-v7-0-991053fcf63c@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1066;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=0H6B6m4YfEscj5/eTxfCR+sI5ay0GD8NDcl46LffCeo=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ7pXQbvK5u6p0guEDC9uusod3qr5+nq35q6ptWffRLCIi
 hTdiVDsZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBExL04GDZP27Zrs+uNCgef
 WRNuiti6ZDYY8UQ/5Wa5/Jr33rKSpPAiUfm2E9+XdxUXbE1y5hHfpl8SJhEs95P1z9t3nSm+Ijd
 8kvwDr9m55djvE+FkC1q75o3Dm01zjgW2axoZBTx+nfV47adveZYsmqW3DMx6VNNY9biDgh6U9D
 BViva1X78sdMHI7ZNj/PO9k2XjJr+2bFf0Dpyt6leQ+2LnnMUK/YxVu+rUPx2L232wm0Vl24VlK
 25eDXOaxPToq/S86Yk+zwRjJQ+Kt3zpUCq9Z/vpTaPy+usb9e5/cjwUG7c76ucKT4vZe6es/B0S
 kHXu3bPpoclmfz652NdsS3v/t4FFvUWvJeQX4zzrikVbAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Make dpu_rm_print_state() also output the SSPP allocation state.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index 4964aa92ce18f9da3b9ca4e599b13ffb02dd81e4..278ed58004f655e20f8c4d9e84e92d0031f7a105 100644
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


