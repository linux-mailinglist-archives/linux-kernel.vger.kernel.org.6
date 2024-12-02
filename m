Return-Path: <linux-kernel+bounces-427214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2049DFE3E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8446D281CB8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF08F1FCD0D;
	Mon,  2 Dec 2024 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oLoDT+kJ"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A171FC7E8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134007; cv=none; b=IXcVlQ568R5fuycWJ5lqSSrwFd6ZouSB6uETbjeXlsV3aW3TgjbjsssHj32als0ANLLTxu8MUtvvnefeJjyjohec5j57J4Q0SRBbiQ+l4JfqlHdNIzKiXLrFHYba2bbevqu9bwL+EXp6PpU/myoSGvO5mvEMAyaFoYsgKobF6lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134007; c=relaxed/simple;
	bh=seU/qFWMvLHvWiegGcXpCvQCH3cViw/am9kIPpe7Qr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g+mPnq1uUo57esfOj69bmp2UbRSpmfWHpbESy4iOnsdYiPJTcDMwwxyMmTuijOJOI6fhGtNfg/s68uSQxHrlr4FZjxtzM0Cjh+zn/faxGSJyhtZC2rVMeLu2dPOAJCDyG0zlEwRU1Dq3u/wfKMspEFZAznczZLD3GtnFvBXvaOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oLoDT+kJ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ffe4569fbeso34424251fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 02:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733134003; x=1733738803; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpP/jDICY2hpp1Wi2eVuCCK8pET/RTw6Zo8ra1xdvcU=;
        b=oLoDT+kJBfJa+jmD/JXpvbgQw1bsof83GfTBevFjn+0/xY9o9erg9j1kjOIFJRtWNR
         69sPhHXjv5O0/9Eam3wUoM8WssSalMmCbgdLgawheRtF9dIhDIHt+fTKnXO8ehPETEah
         Xu6rTNehSf9sfedRZUbK26z1nJVDobofK1ZIy1PLjYhRqgi9dAv/AcvnMUZiU+eM9Bpt
         +LLS8KDSp/ZhrdZlk2AuNlnhHqrjxSeuM5Vgdsa5R58U2W+VjyZKrtL6gbD7xcOsh+s4
         j+4jBc8ok7+yXDZJWm0X4Cw2rxgB8/4UI4KnrTqkfV1IGZy7OJcEWRabO1OqaymiS4rC
         /j8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733134003; x=1733738803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpP/jDICY2hpp1Wi2eVuCCK8pET/RTw6Zo8ra1xdvcU=;
        b=RoZ2Rs+pjDrOnyDFohIfGDcGtuSXk5riHs0nJBar7/72jXyD8FN5OMrYcEm3RAq4dX
         4nCvZjnZIDFlNQFzkTwAZ+Ye6GVLqqbU05FtEeOHXQF7RUM1L+9JzSN/QAlLR4/J9U9a
         6Emchw/BntOV7JyHLyutLEG8qjeS5b+ifxSNx9c+dnTTKcL2HImq9+/qLoRAF3LfsVU0
         WfCupkoondps9rM7nxSEY/ZLX1iUJC+iYIh/yeFSn82WIU6utREw7DfL8eM5RtY69MBl
         f/+pD1eaFbd0GIHyN3OwwVyym28iT0IF5h3coCydaCDu3jOQTOfL4EBgv1SUw/B6Ieg6
         emCw==
X-Forwarded-Encrypted: i=1; AJvYcCXsGRBo2fmZ3837fHPwF3tuD4CfFodNjG8phBNmRXFWFPgc50dMTEe61mgO5yl46H7mFmEJDUu7hJU5WpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7uJYI0Y2kL8P6Jw1Y5fkRfJHDqeAyaO8uy2y6CbNrCqm/XSmi
	rFWHERdAjA5MtdE+6VTukxWb31y6LvIR1h6VgADjwMOImaPdWO2IwM4+Uh5q4zM=
X-Gm-Gg: ASbGncuYJZt0y+Y3cBFzvmpyZXJL0Qlhl80bj654nfVlKxhis/MK3Ycl+PQFt03IXh2
	ABrSHWBQRp3xyv9HMQsQ1TuKswhTtZG0IRRurG/xBl8L5eWGq4Yxx4tUjA/mMz0YCwQ0f/UgZFc
	RnOSR+NE8z4GOPisfSLOWvB0UxHf30UHDOa7MYnqdj9ePM/9TBQPijaUdZ3WTVR+iyNDhC4UN+5
	QhlEJtX2odStAB5tQZsnBGjLVijA8WQJ4U+0SnbJ2wz0nnsohAMGT5cww==
X-Google-Smtp-Source: AGHT+IHR1XbTCgy2WlNGTzdkokyS02qyiNwD8cSSXZMg2NLjd+KSaeHQUq34euLM0FAR+CHBZ3OXzw==
X-Received: by 2002:a05:6512:1048:b0:53d:fa8e:4527 with SMTP id 2adb3069b0e04-53dfa8e4618mr4381179e87.18.1733134002837;
        Mon, 02 Dec 2024 02:06:42 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f191sm1418314e87.136.2024.12.02.02.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 02:06:41 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 02 Dec 2024 12:06:31 +0200
Subject: [PATCH v2 01/14] drm/msm/dp: set safe_to_exit_level before
 printing it
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-fd-dp-audio-fixup-v2-1-d9187ea96dad@linaro.org>
References: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org>
In-Reply-To: <20241202-fd-dp-audio-fixup-v2-0-d9187ea96dad@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paloma Arellano <quic_parellan@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
 Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=seU/qFWMvLHvWiegGcXpCvQCH3cViw/am9kIPpe7Qr4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnTYasoqQkSYAgQkH6Oq8RJFLU+slePXaZWDFJx
 hQ7SxVKrKuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ02GrAAKCRCLPIo+Aiko
 1UgJB/0YLDxXIUrtc4QQ30IMt8vb2S3Kjbb8rYT88XXuS2mARVxvKcvmrvu+z9aqqpI/Z/UIKjV
 OBvyR5H5lrRgLb8stPFwaBZWJZdJM4j6nNyQrb298uJRMs3NjBf1jZy2HOQcFn1+7OeLjMH2hO3
 H28Nxu7uPIOxvEOHltVa2I1vJu4pzi26csFUwyGnlm+TI6fv4xsc86ET5fDW0pMjPugYEJ+N3Qr
 333EZkQstqPePjfg7HbctJoARDjXkL9hpU9sef34b6B1iAfBYbjQsoAcCrpqXLSEZAJCZNde1eM
 urLUW3D7xmS6ZE6GS0OZPNVYz5uuIF0yVRt5Z3cYBeQO/1ek
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Rather than printing random garbage from stack and pretending that it is
the default safe_to_exit_level, set the variable beforehand.

Fixes: d13e36d7d222 ("drm/msm/dp: add audio support for Display Port on MSM")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411081748.0PPL9MIj-lkp@intel.com/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index 74e01a5dd4195d5e0e04250663886f1116f25711..5cbb11986460d1e4ed1890bdf66d0913e013083c 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -329,10 +329,10 @@ static void msm_dp_audio_safe_to_exit_level(struct msm_dp_audio_private *audio)
 		safe_to_exit_level = 5;
 		break;
 	default:
+		safe_to_exit_level = 14;
 		drm_dbg_dp(audio->drm_dev,
 				"setting the default safe_to_exit_level = %u\n",
 				safe_to_exit_level);
-		safe_to_exit_level = 14;
 		break;
 	}
 

-- 
2.39.5


