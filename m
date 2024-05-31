Return-Path: <linux-kernel+bounces-197419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 227C08D6A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 22:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B999287B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED82F17D341;
	Fri, 31 May 2024 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJg4jqYM"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9717E17D371
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717186054; cv=none; b=WbRMrBwvNoN/hcpOP4ye2+r1knIET6RMX2vuJdyWeBlaCruAwxCK9wX1zOkNvEALq0xBN8y4/cBzGtUaxlkgca2+9wgYDz0VWpl91O8RpsphvdAIiU52GqPYcKmKRwUrWWLbyK+g6nMQDNuNfc4MZq3GrwhKCt0Ajw1Gv2PXJcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717186054; c=relaxed/simple;
	bh=AXQkgT8bLCi+J4VLmDhYURPEkLAsLkNbwsYyTx65pa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qNg5SRAU75yP8QfbVNyK+i53d+A+gzgEhm0uI+70Eq/DIEMwzOjHVyYeXdPa68U7rrtWZhNGuqXHhl8VQueD1qw+Dvt4iM6ZOCZitwxecWog7fHpkUa0V7QlEVmY7NWUbVVot7WP3dTFRdpU6ZMRnARjWdIiNCSkVl8DNFdUQxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hJg4jqYM; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e95a7545bdso24671081fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717186051; x=1717790851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xsWyvZJ7smsYEwcJt3QXuB4RboSifhUzN4Y/+3fVgYs=;
        b=hJg4jqYMRB6/OPS0xylEDzORAYAiZe/o9aK4L2Oei4zja0XlbQtcDYCmic0ha+X4Wz
         c5AxPPoeAHlS98yU253OKF9uCWFCdu1FaWPK9EajjnsBENTVpiyIwsrh1zvAsNhIGaZt
         hefq/wk96DeCDV0RPs+dYSr1fu/+iw5g7k5f6wQUL6BWeIP9kKQ8OL1QDf1i7Rn+frvR
         /waFBOdpMNfXSMKvgypd02uOxdhe/JbTt6oYl9peKYA2Jhi2Rti4LW7tb0yf+AnPcuLB
         uhnK9CGtylUGGVKnSRr27p6DmnFnXx0995nvVztC0Anz3dCbECzHzpy8VES788sps/03
         6isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717186051; x=1717790851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsWyvZJ7smsYEwcJt3QXuB4RboSifhUzN4Y/+3fVgYs=;
        b=quODZw1xBgWg/dQmqzev97/MlujfTEYcMq8Ys6nvrQtbplenZl39H7mMCC/Jq8eLZj
         1wAtS6Vg1KZS32mgZ2E10a706mttOWT4lZeshDDdt5StxMktIgy3jnqzZxdGoa7cnmrh
         Ap43wsuobaEJ/9J1hYbIJYWoS6MEvlkMEA2HzKlwb1hBt4X65z8mSq59+Kbo0r/bFI0H
         SrCoTnk0n14UvFZnVLWaCU3lGe6xMQ4yrIGRztmdcViDj8zdd9Dk09tpEibAKBHtmP7+
         FOwisYJLGF4KIyD58WqojQ/Vsnzx+0vm71EuTuBF6T42Uny8N8Vid91e8Q0mRq0FaprF
         G82A==
X-Forwarded-Encrypted: i=1; AJvYcCXfIw6dDyRMComispfEznq9pzx2TrQu/yvznxeCfoMdTA+m6x4vT4CuyAt0ayMISZABvCF7fFmzduo7YKn4YY9Em+KRJ8mY/897Ld/v
X-Gm-Message-State: AOJu0YxJveyxtga7glfqSDcPxv3S2NIIkk0ZKz9EfW7yfCHrrNJOglR1
	LAFZW7lnxGKCYe+WNHFYO3HgakWJxHPCZfV0sTY0xN7DDn2utLMS8eYDZPuA7g0=
X-Google-Smtp-Source: AGHT+IG1DN5+DBzFiRuDTYEQSvzREpoKSfY1gAB8eFQNpo82N+Nkll6VfEl6SAftfhSSjQ8BLG2yWw==
X-Received: by 2002:a05:651c:1a28:b0:2e1:cb22:a4d with SMTP id 38308e7fff4ca-2ea951e0c9cmr24442131fa.36.1717186050858;
        Fri, 31 May 2024 13:07:30 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91cf0b83sm4022111fa.116.2024.05.31.13.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 13:07:30 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 31 May 2024 23:07:24 +0300
Subject: [PATCH v4 1/9] drm/connector: hdmi: accept NULL for Audio
 Infoframe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-bridge-hdmi-connector-v4-1-5110f7943622@linaro.org>
References: <20240531-bridge-hdmi-connector-v4-0-5110f7943622@linaro.org>
In-Reply-To: <20240531-bridge-hdmi-connector-v4-0-5110f7943622@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1693;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=AXQkgT8bLCi+J4VLmDhYURPEkLAsLkNbwsYyTx65pa0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmWi4A4mslqnmrqRRzX6aSZEDOT1WCm1EzeG9wr
 U/QUtoki1qJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlouAAAKCRCLPIo+Aiko
 1SUjB/0e2GTfiChGvovX7efLQ0j2ffZdGrlSDSwGrLLZc+B6/ZbDne/yndL1jZu8s9RmnWztqwB
 gyZSl06x0cl55ESAcn+6WVktsGPpk8dZKMqFe1OQT25lqL3uyPrIhuigQ64W/EX8+9+KLn2wn08
 9hTe/0RG1CmTUWbzzYL0AiCvqkaU19lt1SvNH3x3XULdutaam97jjHCbJhbwpvIDL/TSCltQ4tY
 mPl51o4WSuBlaVIcumVOiCYt/lpmn1dywPMY31gJl6e+eTGqZFOa9TfDdA86+YHdhQo+CuadVd2
 JaOYarn+U4myQ9cBkESIesfM8s8SMqUBofMb2JCj2rwpgoou
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Allow passing NULL as audio infoframe as a way to disable Audio
Infoframe generation.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index ce96837eea65..5356723d21f5 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -681,7 +681,7 @@ EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_update_infoframes);
 /**
  * drm_atomic_helper_connector_hdmi_update_audio_infoframe - Update the Audio Infoframe
  * @connector: A pointer to the HDMI connector
- * @frame: A pointer to the audio infoframe to write
+ * @frame: A pointer to the audio infoframe to write or NULL to disable sending the frame
  *
  * This function is meant for HDMI connector drivers to update their
  * audio infoframe. It will typically be used in one of the ALSA hooks
@@ -704,10 +704,16 @@ drm_atomic_helper_connector_hdmi_update_audio_infoframe(struct drm_connector *co
 
 	mutex_lock(&connector->hdmi.infoframes.lock);
 
-	memcpy(&infoframe->data, frame, sizeof(infoframe->data));
-	infoframe->set = true;
+	if (frame) {
+		memcpy(&infoframe->data, frame, sizeof(infoframe->data));
+		infoframe->set = true;
+
+		ret = write_infoframe(connector, infoframe);
+	} else {
+		infoframe->set = false;
 
-	ret = write_infoframe(connector, infoframe);
+		ret = clear_infoframe(connector, infoframe);
+	}
 
 	mutex_unlock(&connector->hdmi.infoframes.lock);
 

-- 
2.39.2


