Return-Path: <linux-kernel+bounces-380792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5BE9AF626
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03886B221D8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 00:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFCC1537C8;
	Fri, 25 Oct 2024 00:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V+UPJgAN"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CA114387B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729815635; cv=none; b=pjGyJjDYAMFt6TEV4D80ex3BwF6Vwxp776k6qs10IykClkBwBr8OYB6EydOV8AhZiBPW2NV5W8FBLCb3OtcQ3wsliZ63JY/+ImD7po1Yt78H3nrjMbZ2xtmXTfEQCURmKLkW6yOfzGxvuZqxI9w86QaqUqaSNPcuBP2cq5V3sVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729815635; c=relaxed/simple;
	bh=/x10ZQOFNnrOHCvquV4PYPO+BtvRCVRen69O3Zo5eJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aBXKmlSmVrChtELqc8glV9vzGZXiFz3+g17BgVQLyaCPXhRk5UTB8cf4NLwop5i01mEW8vCs/CXvvk4nD8SBzTCf848DdiNSWrgmNUax2RdCH7Tebb1GD6hpdj8+Q5+FlU/5NQkzTTW2JzkCCA/fC03wZzsYlLtQFa6zN0W4zHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V+UPJgAN; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e59dadebso1897017e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 17:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729815631; x=1730420431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YnsgcmkfN1od+i3QCrjb0kSya8UAkCFrFzEGNEe+M2o=;
        b=V+UPJgANGBDXWt1+Vloe0g7QCgQoVHsuoiHm3T+eJU5Igoy2yjUluK+ZOqhvcD/bZY
         0SjldmPUtdGdmgMMy8UqJ+igtfW08UpN5ys43jhI9SW9HZdTLQObP767OeHKCN4BU6qd
         Dif2Igcz2KutPK69u5SUesZRSMB4BrOV477ylmq/sXQ0GA0EbyQ3RelTLPrhv+l3HBzx
         9glR0GtR5/3yNE/Ukx6pMFzi7uIUSWVbbxF2YVat9HnUMbagySzpoxDfuP8Xqo4TKqjL
         O3ciyvsVvvW3zAvhk5uQQ90u63kQqf/92+02NFREnc+BkgmxK0JzTt4YyQPUFkwJP0AJ
         wcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729815631; x=1730420431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnsgcmkfN1od+i3QCrjb0kSya8UAkCFrFzEGNEe+M2o=;
        b=hisurlNf1rz3Fj99xtdSG4nvuEhy19mBMUwSJtap/QUfypGwnHh3rCmma0qqEol5O6
         POeKBEPFrZv1O90uhoQX6ebE7cSIxkM4fEZDP2nGx8nHaEOUu5oN76c2gDes6+AOnIns
         KVOhc6ZRAB89Mv4nx19Uxr4WZrqMdLUxGRnEcNCalml43Ncdunhzp8z9Ow9DYFPjm8/l
         GOSov2jQGlQd4OqjodkhKPswsxHLCLIAShOidlQTs8KpdMHG2hCInHTkJd3heCJz/bzh
         35DekYirszsH1X+6d2IFdE8c6WSBDjNziegJecw0BRy6T4q93HQd53zxbBUvQIHeVE/G
         kaQw==
X-Forwarded-Encrypted: i=1; AJvYcCUN1D03OfeMN5p+FeUNNJGC8BmGN2Dx8F18EhRdtkGVJAOv8dlqXaiDN7YZ8hwoYfXULGUU1u0Zxnl5jq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+bQik7JLmiVWUCWsYPmx91VGV1Y71tkBPwl115eiVHDmtoQG/
	fticBVycEutsR35gyqDF8TtmjaY4alklvk6QQxRTCV3M3+0uYdqaxCvQdfLDi4o=
X-Google-Smtp-Source: AGHT+IFjutZORqKbfgc53uyEGbDicErOUwyPgAVT1fb+CcFo4WDQgCGdaVvmQ/aQ+wWA73orPkLUAA==
X-Received: by 2002:a05:6512:3ba5:b0:539:fb56:7790 with SMTP id 2adb3069b0e04-53b23ddcfb2mr2306341e87.6.1729815630768;
        Thu, 24 Oct 2024 17:20:30 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1b05b3sm6227e87.161.2024.10.24.17.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 17:20:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 25 Oct 2024 03:20:16 +0300
Subject: [PATCH v6 9/9] drm/msm/dpu: include SSPP allocation state into the
 dumped state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-dpu-virtual-wide-v6-9-0310fd519765@linaro.org>
References: <20241025-dpu-virtual-wide-v6-0-0310fd519765@linaro.org>
In-Reply-To: <20241025-dpu-virtual-wide-v6-0-0310fd519765@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=/x10ZQOFNnrOHCvquV4PYPO+BtvRCVRen69O3Zo5eJc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnGuQ7xW6fGPhMHL5I5gTlICUHt4HcwMqATO6//
 pP8jQkH9tqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZxrkOwAKCRCLPIo+Aiko
 1YyRB/9FdE4ntc7MI6xk/sYWQY4g1oLbMyWgqCz+ug9khSnwuI00+BqQWK8pmjYQKCK/KkLAsS0
 4XdwWIYeGBXlnMAr8XxsZHhi/x1fX2ozujBDVlhmvpjZ2XwzjZ7DsWj768OZePy5/3A9i2yedJQ
 t5Elq4v31GtxU81W9y97Lq4JdvcFtqjVymbzi+qK0/2X0c6AN2tXteYdPm06/fTpdfBWem5wDAY
 1gj/WtJdRXFpQsvJPT69eoWGf2Lswm0GchikofWrycPcwhhEhfwYyJ2BqYE7kRzGbqL4iiI4d52
 lZhqX0Y4VuJE/1UTe1Jd3laU++EIthXlOjOUvi/m/qj9jUd8
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Make dpu_rm_print_state() also output the SSPP allocation state.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index feeef9d31653..e5b0abe515ff 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -881,4 +881,11 @@ void dpu_rm_print_state(struct drm_printer *p,
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


