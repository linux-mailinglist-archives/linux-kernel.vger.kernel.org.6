Return-Path: <linux-kernel+bounces-540121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC7DA4ADF0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 21:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3525C16CCE2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 20:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AC21EA7CE;
	Sat,  1 Mar 2025 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zWIwj8tS"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE4C1E9B2E
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740861599; cv=none; b=BDVLdLi9NBYK8NArg718fgiZbFZYKzbeV94BRlPoW7DvZFg2TgASep1uU+QVDiG4cbgnutdy2uizQ97mzUd4pQDDlAUIdYahgFYjf00EZ2k+kDRcVhkuj935NraC9oU+tHQuYgJa2lhH7w8yYGWKKBRlxDkRgvsFSPMFkcnehus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740861599; c=relaxed/simple;
	bh=oiT3XieBMSIfrzEMIa7+tHW3r4Yaol9yvhPjl0hzeR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PVI6ztu8OQzQphUOyIwcMxcO6TR6giTytnMnbiFhb7Ses710gklG7IOGEN5XRvWPzUBHhnTUrMUeMJBIZWrT6ZaScayrj7178ZKJoN/wMrneKp0an8GpAy061aq2VIITkjzhf19iixVKtbhAB/x+22M4/MC0Xw7Ri9bCXPS/WF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zWIwj8tS; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30930b0b420so27193721fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 12:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740861596; x=1741466396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lm0hqPFeMjlAJa0zmvxvNTEk2emtnpzkaRSrh6He2DY=;
        b=zWIwj8tSn2uemlpxRIuCzljgwb+uun95ewpUTqvz+L99gpIP3OeM3Y7kmeJaWdKVYv
         f2/u7x7KSP/PtJmrM5slNKX1tcPDBJtLvK/EJf0+3vQCRhK1QLEXx/tZwaGcjqCgBqIv
         JsR5RtDOstoTabilar5n2a8LaVcjzQGr4EfqLA8IBCymhCPpwFKNjJgtkNAn54lkjlGo
         rQ1hSPCcoW+JOd2t+C394IJt4tSOmVlzCpWsWA8tgfMwcMJaUQa6GYccLcnhsLbWjzYv
         xjWHOxyDrg5N9clcPkKvx3gPXR5yxquRxJ2UKn6MMNaBcE/dUQfJdLh/mEflUtDFQNiH
         kFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740861596; x=1741466396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lm0hqPFeMjlAJa0zmvxvNTEk2emtnpzkaRSrh6He2DY=;
        b=RrEtfHs8Ph2NWl8+yWBkQro28srNrss9eQmbS9u2Fu3VKM7t69iqBleJnz0a8xWtA4
         6YKw8BDvOW2oLaVrqy/RTlb3RuPFxyXFi2nEfd+djjDfx+c7E8SqfoaIe74zbFFEwSUD
         JwqgnGQw8KGJ+zi7lEinsib7nNvcaL6jjA1FVmCGLxX45fQeF+Z5kKawcjlgCQB4YEi3
         ikQjg2W7LRw60Tf3lcAdz+QeYmgHwkr9W9IkmV8p8BPLEbsfrUCdH2v/ttJYJ9IaqPje
         ud8oLMeJ4phpFz8X29GioXa1JNkH4P4Oiag4SyZ2wT7knEkPwEzu8908/MheEa8g2JIc
         /Ajg==
X-Forwarded-Encrypted: i=1; AJvYcCVRRAgNsMdwEeFYbQSLXk5EUfM7SNgcobKOJUMs9yRJmgvJBPtZz6KwzTQn60+hj/piP6pXmCfi/sryKss=@vger.kernel.org
X-Gm-Message-State: AOJu0YytGYjx9/kyJAIJFuh4URBG9rqx1zdgefOBjKPkf6INabHSxp97
	uF2F3k+8mb3RJ8QWwWmP62z5LfkncL2lxV0Nq24mUSaWTjbSwz6mhwsQwKiOgrA=
X-Gm-Gg: ASbGncurwKp+56aSsJXkMS7sxGrZO2LlNd05A1iRH5OBM3lPa5fjaAcU5QZGtieiHsc
	+AupGSceSwm8q7PvE6NLzssu7HTL9sw+iZHAYubxwH8YZOzIW+bUSpyNvFjOj/4YeYNMk126Mt9
	kd6oiJFDTkhNS4IgJAY0FGu4rM5qvuT0SKf+zZMUSYOGjdOrKSs0e2Sb+a66+tGDYSL/pi75VfB
	X5n7Rm2sBimrOkLssbiUIniZIsLP49/NRZeTec5TqmYQRE+UjhbQwBKpHf0dcbdTWxgh1VHTlMQ
	hwplDASyek7fm9OWiDPFQEujtMg5YOf+81Szo6wZhVeP+h8bEqxg
X-Google-Smtp-Source: AGHT+IEmTXK0sA2OkUpupOigZVSjmXwjzqW3fKRIwNjJwyTslP6vQRr4qY7BVPOJdFvgcDcjK+gOIA==
X-Received: by 2002:a2e:b896:0:b0:302:1cdd:73c6 with SMTP id 38308e7fff4ca-30b9326af9bmr30502271fa.20.1740861595853;
        Sat, 01 Mar 2025 12:39:55 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b931524efsm6668921fa.60.2025.03.01.12.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 12:39:54 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 01 Mar 2025 22:39:39 +0200
Subject: [PATCH RFC v2 4/7] drm/display: dp-aux-dev: use new DCPD access
 helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250301-drm-rework-dpcd-access-v2-4-4d92602fc7cd@linaro.org>
References: <20250301-drm-rework-dpcd-access-v2-0-4d92602fc7cd@linaro.org>
In-Reply-To: <20250301-drm-rework-dpcd-access-v2-0-4d92602fc7cd@linaro.org>
To: Lyude Paul <lyude@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 Jani Nikula <jani.nikula@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 Jani Nikula <jani.nikula@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1430;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=oiT3XieBMSIfrzEMIa7+tHW3r4Yaol9yvhPjl0hzeR0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnw3CQKEcLkja2c5fPc4XKGOP4nL47TK+u5bXfS
 KNn90N+yo2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ8NwkAAKCRCLPIo+Aiko
 1UG6CACk3GBifF0q/szx7lNrtLDJrKctDw1YTztUYefU9Y3YIjzg+oBXe4rU31154ET5jAIQEhc
 vUr+oWgIA+hJOAmPNkXvYWBYhXOBMfO6jpjerRnGOTA3mArW7GX+cc1EckkIb+hVgai/PVo/g7o
 OAFQBhPJTA/A67N7ugFi/EqD+Irbp4Ya1yt6VKSkwftQLg5UjPDF4HqBDv9cfM3GFAKi19ageVt
 xGfPppiBwqlSMyq5AFXeuI49x4SSB1fayq9tjEvss07cQfWjtXK6VR7C5eFGXEmKvkA6REGiCra
 m1aBW/rjjQ/Km0TKrKP2ALBrLsxGnA9DkvZzmBAH4Bo9IJCq
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Switch drm_dp_aux_dev.c to use new set of DPCD read / write helpers.

Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_dp_aux_dev.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_aux_dev.c b/drivers/gpu/drm/display/drm_dp_aux_dev.c
index 29555b9f03c8c42681c17c4a01e74a966cf8611f..a31ab3f41efb71fd5f936c24ba5c3b8ebea68a5e 100644
--- a/drivers/gpu/drm/display/drm_dp_aux_dev.c
+++ b/drivers/gpu/drm/display/drm_dp_aux_dev.c
@@ -163,17 +163,16 @@ static ssize_t auxdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			break;
 		}
 
-		res = drm_dp_dpcd_read(aux_dev->aux, pos, buf, todo);
-
+		res = drm_dp_dpcd_read_data(aux_dev->aux, pos, buf, todo);
 		if (res <= 0)
 			break;
 
-		if (copy_to_iter(buf, res, to) != res) {
+		if (copy_to_iter(buf, todo, to) != todo) {
 			res = -EFAULT;
 			break;
 		}
 
-		pos += res;
+		pos += todo;
 	}
 
 	if (pos != iocb->ki_pos)
@@ -211,12 +210,11 @@ static ssize_t auxdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			break;
 		}
 
-		res = drm_dp_dpcd_write(aux_dev->aux, pos, buf, todo);
-
+		res = drm_dp_dpcd_write_data(aux_dev->aux, pos, buf, todo);
 		if (res <= 0)
 			break;
 
-		pos += res;
+		pos += todo;
 	}
 
 	if (pos != iocb->ki_pos)

-- 
2.39.5


