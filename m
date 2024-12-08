Return-Path: <linux-kernel+bounces-436521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CB49E8710
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 18:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFDE28135F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 17:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FD7170A15;
	Sun,  8 Dec 2024 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQC+WJCo"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702F01662EF
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733678959; cv=none; b=dvnCzlaxciBoc8vKEkz/1Ser45aCiDYYd1+aBi0JfP6NPgSIlQ6Oc9U0ZHKhmwavYXnCXN1sXNpv5eelf8fZsJoyBYuFjaLL+oTW25aEbx0venGrcqAQqg292A6IiLsD/SFJNMHR07IopbS0F+iNQqPgSNa7xEE66f66T//FgxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733678959; c=relaxed/simple;
	bh=l0e+YjJJLUTTCME2U2RfwtoWLrRTp83OMNrgSpxIf3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UCm463d0LNsF+qBM6xpySB9UMpXOmTSkGSVvdPF+xvHnmoh28JIUhdxqbt5bzFHkgeU4+g0Rt2/9Li7iT6wczaKRsbukdTuVVbtGvqGBBfyAEQrGaD8L2RDJ4rXCogwecj9dE2SkqjU2ATnVWJm1DDh0ulykevjrTqOWZk8lacM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DQC+WJCo; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53f22fd6832so1035567e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 09:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733678954; x=1734283754; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/tzoYaJ92Gqbh47fpsJMbKGuzwxMycmsQJXhBU4UoPU=;
        b=DQC+WJCo9cPS1F50ICY+x5OBxiGD3hFK6sBm5PFZvXDa5IbWUtsuJLm3C34sGT57Lj
         /IVCjnxSyUbP9WYWkkhmIbApFHNlauufJFloyxERpaToMsWBNmRF6tRANpZi/dV9mnpE
         h0mPfbe+UyJJZbdTcPpikwI9STxkc6Js3bJM1+B0pY8cFe4C39f0MqKf8TEHZgQNtQ9/
         ohLRevIV1u3T6ccwV4jNkS7GM13AzbgVQc+UwlTn5JuwyK5PD8hu2a5Q4nLNCoKsOQVa
         UBpOmvGf8LF24lnkg1MbNCJVn5gnvqr9yPM55NkOhFIUlZjYWl018PhvJxApsb+PDA9M
         7STg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733678954; x=1734283754;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/tzoYaJ92Gqbh47fpsJMbKGuzwxMycmsQJXhBU4UoPU=;
        b=T8g2l+yjrXGFpuq5HlT6ktcSp+NGm7jDO9xdIeu6cDm3acRQzdCfTihVv/4lS1DUgQ
         1x/LdfoGe0i5jdsEO22+57Blm5Q8BJbp+Ij0wN4KE8CeyANrBtQYBOjSwIsbDlcgy5Hh
         B5cDzpmudwOKLlPKshd6gaRjecH+pRw92Zbg19TJeOD5XIGg+/HRL2KUfRJcau/lp1BE
         Inau/pFPv391IzBlvnYg2szYI85CqXDX52dkbt/zILzqXnqufCEw6+sph7+ZZO6/o13U
         lUsLAUOZCERB0TLTdn908wqOcSLzLHQgOVo/+QX+0rZDJ4w3+luwFxQJ8siXQho6Riam
         I9hg==
X-Forwarded-Encrypted: i=1; AJvYcCXS01wo7ACm4VKGNq5FfWJm+oeTFhCfhGatz6w5lz2kU0AROpTbPf4W6HqkVpOK624+TZzGn2H6V4KdAp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoqG2mmgyNBGgw5xBuLN8lQ9dbtreGxQgctVEtvr4VwMg9osdB
	AqJWMnm4UzqhEi863aHTGKvgLwdMOgmTQ4oANinfG/p4cXIEbtKOcgZ0VlpchdI=
X-Gm-Gg: ASbGncs/1EQgjcWl1pdvu9Tucg0pmSnjR5T/GzRZDILwHlGkW8aAi/Wu3NvGm4lYSeM
	iV5EbJjbG6BURTLJnol5yoONy9RGolqux83Ym78aX/KLxpJj3obpPGWWLnyHyQhwkgnJR04x776
	giutbWq0r3EMiVK7OnaRG3VosK1IROBvc3WaEifcThJg6VqFZDFFWzCG6KLbEEZ28dIrnGAwOr7
	sXNe0laATCmth6OBYZTjnHu5oBPaBoxF7nMKaZKtNDhYXtABQLXajbVMw==
X-Google-Smtp-Source: AGHT+IGpl4LZsuCLYc4o6t6jeFwINzov0q8HwajESXX2p2xRlg9YhxiyKZwpcpZtqT6qPbhArxAsDg==
X-Received: by 2002:a05:6512:39d1:b0:53e:27d5:85db with SMTP id 2adb3069b0e04-53e2c2b1ab8mr3133570e87.12.1733678954527;
        Sun, 08 Dec 2024 09:29:14 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3160ebe8sm783253e87.180.2024.12.08.09.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 09:29:13 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 08 Dec 2024 19:29:11 +0200
Subject: [PATCH v3] drm/msm/dpu1: don't choke on disabling the writeback
 connector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241208-dpu-fix-wb-v3-1-a1de69ce4a1b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGbXVWcC/22MwQ6CMBAFf4Xs2ZrSFime/A/jgbYLbGIoabVqC
 P9u4WJIPM57mZkhYiCMcC5mCJgokh8zyEMBdmjHHhm5zCC4ULzmDXPTk3X0Zi/DTtZVNUo0pRa
 QhSlgfrbY9ZZ5oPjw4bO1U7mufzOpZJwppaXSpnPKmsudxjb4ow89rJ0kfq7mYueK7NbY2gaNR
 t1UO3dZli/ruPa24QAAAA==
X-Change-ID: 20240709-dpu-fix-wb-6cd57e3eb182
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Leonard Lausen <leonard@lausen.nl>, 
 =?utf-8?q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>, 
 Johan Hovold <johan+linaro@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2341;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=l0e+YjJJLUTTCME2U2RfwtoWLrRTp83OMNrgSpxIf3U=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnVddoeaOWxNJOEBGnhGweCcRBMxR3mJut6WFda
 BRnKILovEqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1XXaAAKCRCLPIo+Aiko
 1c1SCACznZ0DjA+m7Xyt+NmXA+EGu7YA91e/a5pV0heywojgc9cKCkh4DnloshzjCdKmzf+Y6r5
 3dMN62m79U+sfGHXhZ9YKSB/7lZOL8lR15ewqPtxcbiyiqG3gC/xBPnIXJfD66fXZGqlUSkrs87
 QLHEPRb8cjqR2Y3Mw4ktwFlFoLLz0ZqCoQ50S+kMRLLZJPsT2qtiTli42NG+9l0hLN7iIIGYpuU
 yBErwWqTg3wON4+gRHEV4wdcjcs+GZ95SzsYvFBKVfaCkisiiDfVfHoxn5gDK1+qFB24fgF663u
 D1BLlaBUdwTfdgtRLOj27qHXQnwSYPaW+n+Np5C9UXzVKEiP
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

During suspend/resume process all connectors are explicitly disabled and
then reenabled. However resume fails because of the connector_status check:

[ 1185.831970] [dpu error]connector not connected 3

It doesn't make sense to check for the Writeback connected status (and
other drivers don't perform such check), so drop the check.

Fixes: 71174f362d67 ("drm/msm/dpu: move writeback's atomic_check to dpu_writeback.c")
Cc: stable@vger.kernel.org
Reported-by: Leonard Lausen <leonard@lausen.nl>
Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/57
Tested-by: Leonard Lausen <leonard@lausen.nl> # on sc7180 lazor
Tested-by: György Kurucz <me@kuruczgy.com>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Leonard Lausen reported an issue with suspend/resume of the sc7180
devices. Fix the WB atomic check, which caused the issue.
---
Changes in v3:
- Rebased on top of msm-fixes
- Link to v2: https://lore.kernel.org/r/20240802-dpu-fix-wb-v2-0-7eac9eb8e895@linaro.org

Changes in v2:
- Reworked the writeback to just drop the connector->status check.
- Expanded commit message for the debugging patch.
- Link to v1: https://lore.kernel.org/r/20240709-dpu-fix-wb-v1-0-448348bfd4cb@linaro.org
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
index 16f144cbc0c986ee266412223d9e605b01f9fb8c..8ff496082902b1ee713e806140f39b4730ed256a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
@@ -42,9 +42,6 @@ static int dpu_wb_conn_atomic_check(struct drm_connector *connector,
 	if (!conn_state || !conn_state->connector) {
 		DPU_ERROR("invalid connector state\n");
 		return -EINVAL;
-	} else if (conn_state->connector->status != connector_status_connected) {
-		DPU_ERROR("connector not connected %d\n", conn_state->connector->status);
-		return -EINVAL;
 	}
 
 	crtc = conn_state->crtc;

---
base-commit: 86313a9cd152330c634b25d826a281c6a002eb77
change-id: 20240709-dpu-fix-wb-6cd57e3eb182

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


