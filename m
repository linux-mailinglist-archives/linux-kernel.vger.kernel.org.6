Return-Path: <linux-kernel+bounces-251947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC37930C06
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 00:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF5EEB2108C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 22:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5350142623;
	Sun, 14 Jul 2024 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aoJgT2xo"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785B713D50E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 22:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720997637; cv=none; b=Nu3MfRkDfns2mCTui+XPfyVUiJLmSj7OWXfGiuLuC+Mg+dI7ETQ4A59SwzfCD9bnbd4NDPDqcB62aYtwHIkWZHIUr3uZy+ECRzkyFmP8VRJwledeG8JmQVPnDTBRdiyabRrkeRDKcGzt9KdK1SHstQaTOwLKwqv6DypbKalaKiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720997637; c=relaxed/simple;
	bh=XFGhcwTu/Mz6wrqwi1h5k63gW/YSFiytfhyYe9UGJXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OpmdLrWDhLcmFiqFPL18l0fjX7Cab5ws7DL6Mfcpwg++v3dR0TQuILaCNOQt9biCwdEwMvgz4FYDmLEuzrLC1MVID+CcxNLdnYfNk6lqRrpxL2FGH8BLwnZKXTNi0klnn4skcHsbZxUrbK+FVwVOfVJcyLn1/OKh0Be+eQVBkLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aoJgT2xo; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266fd39527so26910355e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 15:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720997634; x=1721602434; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzeclMxKxNLzIyOYlAy8CqRPm2NMzdjyMjfNK8U4cd4=;
        b=aoJgT2xog0Zf3aw7opTnF63IFwPTKch3CF1EpNyz27Sb5RfIM0EICNENqsEYmuDZOa
         9EdhxSUTJ3hXhyfSK89PEb3bKstJX19Nmv9wJxXsM4t8QY9+1Wt5RvDsQ2E3BYXyELk+
         FmWfmO+D0WKylCYR7YQbeT60NfF4x0CXb41JUA/wRaXG1mwusYNRwoCRoNoKVgzCK5pU
         LftI0OFNSek0nYFrrO175Emy4VJYFeEEatuHPpAjLKE234fM0ib6L86WRGV8xnHXlPhL
         Bwwg6brCnYs30yvnVpzJfxTj8epgAoZuicqdEn0SCdNCMBjr1/8ZsSeTLoZfM0hpGhn5
         DkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720997634; x=1721602434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzeclMxKxNLzIyOYlAy8CqRPm2NMzdjyMjfNK8U4cd4=;
        b=ZNU2iBGyGq//Zfg+dBrGy2FxICfPWur9bpwnD1nXQDVtX9IFlYNz8C70XITY4QEiFp
         qG5/XiiZft2VVpikx3etuO1oxpt8fCGcbzsyi0M+HT8+02XTLzjN8k107x/aA6Z6Fq8L
         Hmi3YY7D+YZw9DFACQGIK7dr/8cWmQlrUxe5mcW47lIDQpUIZqYRc3ANBx67Bt/vnT2D
         Lot+8Um9qZHxtk02b2N6glFuh7KgGcQxXPR12BZ0lV7n08wis1QVJggjU07JKJxVlng6
         o5ZNeG9LwIw6cRh95sHBl4CTEe770UuZwAS2KmTIpT29jm2JWUcak8JGdU439Xekp3Cu
         gu3A==
X-Forwarded-Encrypted: i=1; AJvYcCW/RT9Dol8goksqiNifbkYOBZxtzwVnaVUp3ImTIxUDVjO3iEMrLEuE0hLJJGr8ksf7ZMj8EoRFP1WL5bEV+TCPNNHrVwaiyzgUxvrE
X-Gm-Message-State: AOJu0Yywmv0zqa2m6UeQ5ox1aSahWUgCiLcOEg0kjT3yyN+vM5S1Uh6z
	JHroYX/7tJfKhxgDZEp6BPorNdpOrpuSGKDDIkAi5qeYo1VCFmx0IxuYnOGXUSI=
X-Google-Smtp-Source: AGHT+IG85V00IMooWyrtdiKFFfGK6QkfieuC3gLw5Jf+m2YrK3JSLDsYd7PsB4evQgrl4Jn0mVna4A==
X-Received: by 2002:a05:600c:2284:b0:426:5e91:391e with SMTP id 5b1f17b1804b1-426707f81a5mr109514495e9.26.1720997633942;
        Sun, 14 Jul 2024 15:53:53 -0700 (PDT)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279dae34casm40632445e9.0.2024.07.14.15.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 15:53:53 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Sun, 14 Jul 2024 23:53:59 +0100
Subject: [PATCH 2/2] media: qcom: camss: Fix ordering of pm_runtime_enable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240714-linux-next-24-07-13-camss-fixes-v1-2-8f8954bc8c85@linaro.org>
References: <20240714-linux-next-24-07-13-camss-fixes-v1-0-8f8954bc8c85@linaro.org>
In-Reply-To: <20240714-linux-next-24-07-13-camss-fixes-v1-0-8f8954bc8c85@linaro.org>
To: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hansverk@cisco.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Milen Mitkov <quic_mmitkov@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-13183

pm_runtime_enable() should happen prior to vfe_get() since vfe_get() calls
pm_runtime_resume_and_get().

This is a basic race condition that doesn't show up for most users so is
not widely reported. If you blacklist qcom-camss in modules.d and then
subsequently modprobe the module post-boot it is possible to reliably show
this error up.

Fixes: 02afa816dbbf ("media: camss: Add basic runtime PM support")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 51b1d3550421..d64985ca6e88 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -2283,6 +2283,8 @@ static int camss_probe(struct platform_device *pdev)
 
 	v4l2_async_nf_init(&camss->notifier, &camss->v4l2_dev);
 
+	pm_runtime_enable(dev);
+
 	num_subdevs = camss_of_parse_ports(camss);
 	if (num_subdevs < 0) {
 		ret = num_subdevs;
@@ -2323,8 +2325,6 @@ static int camss_probe(struct platform_device *pdev)
 		}
 	}
 
-	pm_runtime_enable(dev);
-
 	return 0;
 
 err_register_subdevs:
@@ -2332,6 +2332,7 @@ static int camss_probe(struct platform_device *pdev)
 err_v4l2_device_unregister:
 	v4l2_device_unregister(&camss->v4l2_dev);
 	v4l2_async_nf_cleanup(&camss->notifier);
+	pm_runtime_disable(dev);
 err_genpd_cleanup:
 	camss_genpd_cleanup(camss);
 

-- 
2.45.2


