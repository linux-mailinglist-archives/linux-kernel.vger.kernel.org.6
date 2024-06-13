Return-Path: <linux-kernel+bounces-213651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4E2907860
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CECC8B21779
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65361494CD;
	Thu, 13 Jun 2024 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vvw7fxJT"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B314C130A79
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296446; cv=none; b=kYrjMYmPMzr6VBhne00oORfjx77dwRK+uVxtZNb1gJU9t8eHQnsDGiZad1gsW3cT+dQQg4PFaXlFoSiGCTVeNMKnVptG2solVW97qalVBYOC6EaryS0R6T6b46jkVFVA0oXF8aS5PWu3ir7u4U7nxftEB8F8naU8BYvjxM5YMwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296446; c=relaxed/simple;
	bh=9Oy2rhgmMbROnThGOyXo7UyCu8RbyWradi7uQ/YWriE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NV+HO6Zjx1XO2oF/DxcxLwtvA/JgV4wj73AomgvnHk5+VsIPuRVBB0vy2Fq3f7clHdFQMdBg21TmaKlzrDZplJDDf204jRrI/X/pZQN6bykDUgKKat126+BDtiNnaKohdqic5ei9sI2o64IBL7TyjKprdzfoiGFPqh2U9mjmHAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vvw7fxJT; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso19590081fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718296439; x=1718901239; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zHgrY4xIc9CPVKKUbUHFPFlrW7UpxJwbiRlbNkc9MGM=;
        b=Vvw7fxJTyKLNWc06vMoV0eWV2yh1+U7IdO/+dkyZBnpi4hF1Nqb/nqehJwZBGbtWBx
         S8EYcXMps7CHcQpktHj4+12Kk+SmZTg0mWlWl/HAtmaThJW9mEgYweumdTW6c6FJmAry
         83ljjJEs7aljkTMPxYHwk04Fexzagbv1o+Q07Qlwo8M5CWM4QZOjhyr+SDcXhT3MH91p
         Ki66b45AzyPM3DJ5nKK/vkyne7wJnG+EsbPrTnKlfA8lRA08wu5ZPDDTZwUPOXZFUwrg
         bd1wpdAq5YYyTU7b0PqrKM160ek7w7u76RoM/HdPgmCzVG57mLYFLH8Kw7+Tp8C9SuUq
         FQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718296439; x=1718901239;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHgrY4xIc9CPVKKUbUHFPFlrW7UpxJwbiRlbNkc9MGM=;
        b=MlyzfoexjOwL6GCTbArXJ8h9y2mO+sjASPBTS+BmfcyIRgi2Nt2kRs4Pgtlf7iyGtD
         tPGp1AotYC9pJolPqdRMR0eTDItHoEZHx4ioF5XWaio0nrlfuPEt0k0P//EAl3MX3mnG
         W37Sq2XlJSKViaMljS0bQC66OnHI1Q3G6Lqa7MjZxllVypYimJWaL1hSLCYREwxVE8tg
         6M5ewrIntLmlTqbgENDwd5dtNPQOtyUVm4CDc3/KuwfEs6Adqf0sysFsAeLOTb5EVZoi
         m6KhE4O7lB2NhoaQ6+t+5FaUpMFYrvTBCvaoFLodSfadyA1R3eod5VIuNTdWKqEJ9qGE
         YkYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL0A+QIh4JY/2ENaGvmUw2Fa1InJxFXRoeXylgvHtId/vA0ZJNG9EKzY//V1ZJZXwE00Yx3md+CYVDPu/JcwsAJMUiPKGOoFTrcH/Y
X-Gm-Message-State: AOJu0Yzn/dWhkxTdZvyYmR4z0tOXKg/2kKLQRvkRSSNYpe+SiZ9FvjqK
	DaBI9hfX5rABwAICzQiLBUfCLmQo+s+qOjncXNTYmNvRS8KINsvQ+yJ9oreeeWM=
X-Google-Smtp-Source: AGHT+IHQjwGnyIBB6w17aMs8YaOjxovU+qzoNkHKK0oqzTbPn4+mi5cAWSa9lQLAGg4Hgz05mK53Qw==
X-Received: by 2002:a2e:9943:0:b0:2eb:eb82:4112 with SMTP id 38308e7fff4ca-2ec0e4826dbmr2994861fa.17.1718296438829;
        Thu, 13 Jun 2024 09:33:58 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c9ae70sm3005621fa.133.2024.06.13.09.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 09:33:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 13 Jun 2024 19:33:57 +0300
Subject: [PATCH] drm/ci: mark kms_addfb_basic@addfb25-bad-modifier as
 passing on msm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-msm-pass-addfb25-bad-modifier-v1-1-23c556e96c8a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHQfa2YC/x3MwQqDMAwA0F+RnBdoOxX0V8YObZNqDq3SwBCk/
 77i8V3eDcpVWGEdbqj8E5WjdNjXAHH3ZWMU6gZn3Ghm+8asGU+vip4oBTdh8IT5IEnCFeM420R
 LNC4E6MdZOcn1/J9va3+GH6EdbwAAAA==
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Helen Koike <helen.koike@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=9Oy2rhgmMbROnThGOyXo7UyCu8RbyWradi7uQ/YWriE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmax91DGbuj22LlXzjIrZ3rzJ7TcRR5ZnaZlaZv
 xDd47ibag+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZmsfdQAKCRCLPIo+Aiko
 1ZRyCACHj5FwfHDMFnICBk6c9bsSibSfFyyQ7foUfaKd0HdH7hkKubcXTIzpfHkQyAnGxQfjHc/
 aqZ1VduL+GHVFdJBw/CZ8pL8YipTrpHrMGaI+vwxGutamsp21f9+8vZv27yn6BgIXzQtDckQd3+
 fWMKZfI0oNHZAKvea59SaFEqG10Q/9x7+yPwkMOLaLgeWU7i8LZVPLHXZ5BsGHt3sq/r5sFFeZf
 1v1NfNOppwJchUxn+3cWWw+lK/S5VNtwBKGC45xchIr/gIfvtKiqFsAw36C41urnMETEhTVGhD1
 aXUxik06RCS2hjyYgJdOTQSRVkM5GgimG0wIZm1P5MTnxcJq
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The commit b228501ff183 ("drm/msm: merge dpu format database to MDP
formats") made get_format take modifiers into account. This makes
kms_addfb_basic@addfb25-bad-modifier pass on MDP4 and MDP5 platforms.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt | 1 -
 drivers/gpu/drm/ci/xfails/msm-apq8096-fails.txt | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt b/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
index 3dfbabdf905e..6e7fd1ccd1e3 100644
--- a/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
@@ -4,7 +4,6 @@ device_reset@unbind-cold-reset-rebind,Fail
 device_reset@unbind-reset-rebind,Fail
 dumb_buffer@invalid-bpp,Fail
 kms_3d,Fail
-kms_addfb_basic@addfb25-bad-modifier,Fail
 kms_cursor_legacy@forked-move,Fail
 kms_cursor_legacy@single-bo,Fail
 kms_cursor_legacy@torture-bo,Fail
diff --git a/drivers/gpu/drm/ci/xfails/msm-apq8096-fails.txt b/drivers/gpu/drm/ci/xfails/msm-apq8096-fails.txt
index 23a5f6f9097f..46ca69ce2ffe 100644
--- a/drivers/gpu/drm/ci/xfails/msm-apq8096-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/msm-apq8096-fails.txt
@@ -4,6 +4,5 @@ device_reset@unbind-cold-reset-rebind,Fail
 device_reset@unbind-reset-rebind,Fail
 dumb_buffer@invalid-bpp,Fail
 kms_3d,Fail
-kms_addfb_basic@addfb25-bad-modifier,Fail
 kms_lease@lease-uevent,Fail
 tools_test@tools_test,Fail

---
base-commit: 6b4468b0c6ba37a16795da567b58dc80bc7fb439
change-id: 20240613-msm-pass-addfb25-bad-modifier-c461fd9c02bb

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


