Return-Path: <linux-kernel+bounces-193241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209488D28ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 01:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3822873C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCBF140368;
	Tue, 28 May 2024 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NKCl2XaV"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBF713D89A
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 23:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716940380; cv=none; b=htohYIKHJsMYLQjE/kIQFyZxZ7KDGCSR7BpUCdNxxxln+OVzkJWOStuCAucS7kMJm+B/hzNbutbZGJiig41+dW/mqNHNO1y8P/bUVEJWV7HEOW9QPN/H9TojFmwP2K8hEjOOvg89ybM31KP10rbgyzDxkZWTNo3NGX4PP6pyLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716940380; c=relaxed/simple;
	bh=oHBezVlQg7OYkDqf0mCnlNvzfcQLRXocxgcJNJ+SMzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J3L5ct+bWdIXsiQuf+VNWhw0mAQHIK64vo+QoGFxwnyR/MFa9pWJyerBDLd75jjCvhGEcILpos9L4dLs1Ew5rQjOyMJ+1mEIgd1cfU0gDM6T5cuQ9Vl/pHJ+CgsYYi6pybj80xCkRgCA4MRhZF7LpCWyYOA0Uvea6ucj+A67LKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NKCl2XaV; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52ab1d7243fso258877e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716940376; x=1717545176; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJH0eGHL0S44S4VAoT3//wXsK4IwPG7MFQf/QTWKdP4=;
        b=NKCl2XaVwsESEt4ABXS1SAYGYsmINaIMFOsQjcxH0rIiPkvFIV4Y3QOO9YXspucAdh
         BkyO5o5wVjwOnVG/00KUk1tKE4XKw/IMiFo11I4hZV2NpWN/1BecZeTJkHNHoLtsjvRE
         DcstDrWntBuSoQYzbjDGyhXW0za985s80qJVOYkRtxWNXPAcB/dvNn0zcvRXJnBmnH8Z
         E7UgQYRqBr4ePhYtt2sXKdvUr4Uq5hKktnp0Puwd2swRt5RAraeNKTyXmxHIgy2QHpfR
         ztiGvmAMMGCjFt5tgz6dNHRtXTjqplRkgj4Sb6S2gxbZT4Urzt5JajC+OxuE9BVy4OpM
         ztog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716940376; x=1717545176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJH0eGHL0S44S4VAoT3//wXsK4IwPG7MFQf/QTWKdP4=;
        b=B2gKEK27C4czFF3s6sbkSAIQo7BSZjqorZD6uArVd+RPOzS2L51sWhmYqQ/7eKvhfj
         7xMdw5m36nnOU5BvZOJYC4/Tz05BARhmrgBflmepMdUHtYG4ULNMN3Os4IsVZJFgX6ni
         Rx7hZ+D00MCXevxXkiIE5AS8SB+LTD0zH11mboghMZfBifKzVUWKqV7qsNNjj/tffT9G
         XkxgZ/Kgu8lLEXUtHtH8mGoSklReq508NByJxpW/f3/K3ptmYVnoc7Z0GRN8hB/rELOZ
         STh0MbwsQxZdyhfTdTHqtfNOE/lB3kbGO7hBoDa1kqPIZndqsDD9ZTG0w2Oj3S/W+Ppy
         NfZw==
X-Forwarded-Encrypted: i=1; AJvYcCXypQMmv64hNsegX7VrPacDSkpagltZ36ounkdau/Bdbw8NkQPU6//s5AwjXWmf3JpvJJXgtkaXQI5X6RWyDaaGKJBuuaia7qxnu71h
X-Gm-Message-State: AOJu0YxD9685EnJnlu1unh2ULVZza76aIkkFlK2oavwHvNqoK2sEUMSO
	BYbFcT1XqBM9SR9fhoNVv6S48YGbFzlpuYod0Qx7NuJZi0Maftye7BgpNBakTaSZCPbJCyX1zhp
	a
X-Google-Smtp-Source: AGHT+IHKPEDMtbU382IuloM5br0imQsgdv1mUmjp0FxW7R0T2RAJksTe4h35WKggq6BRr5HC5ryHeg==
X-Received: by 2002:ac2:5489:0:b0:51c:cd8d:2865 with SMTP id 2adb3069b0e04-529668ca0abmr8397547e87.44.1716940376642;
        Tue, 28 May 2024 16:52:56 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066bd0bsm1099869e87.165.2024.05.28.16.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 16:52:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 29 May 2024 02:52:54 +0300
Subject: [PATCH v2 1/3] drm/panel-edp: add fat warning against adding new
 panel compatibles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-edp-panel-drop-v2-1-fcfc457fc8dd@linaro.org>
References: <20240529-edp-panel-drop-v2-0-fcfc457fc8dd@linaro.org>
In-Reply-To: <20240529-edp-panel-drop-v2-0-fcfc457fc8dd@linaro.org>
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Jeffrey Hugo <quic_jhugo@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1721;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=oHBezVlQg7OYkDqf0mCnlNvzfcQLRXocxgcJNJ+SMzs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmVm5Wy8KAXUnyPDPNQ38w7x0XiXWHodROHzcC5
 9Ghz+NDQeaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlZuVgAKCRCLPIo+Aiko
 1TloB/wL83KX7asFeXg/rcu5X98SE7+vTXoSGNjnqPj9VPGeoqq2Wmbe3dxmO4pvkxjhsEmOaVW
 ZfJNPkXEA/DANbAF1dzzJbzXfug9X60iVc2OCrmClho7C9a2aglx/GXCBGlELGH4KKl3FjjCIpj
 dVkv4MkqLVb9/Si9crgvaWZ9ipUAC1LsxTFaIhseiVRobKAztT9/SEBPr+mBw1TfA84uID3ZCBl
 bUsueVYZuVYTxpLuRf8+5FeTW1vzu5iliu84xQ5oIfcDowqljKp4sbZqhotbCPeXTpFeYj7lQqN
 wIuZLM0kmmY8X7hVpoVQwtq5lEkHkb4/gZ5xOGwimTfExxk1
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add a fat warning against adding new panel compatibles to the panel-edp
driver. All new users of the eDP panels are supposed to use the generic
"edp-panel" compatible device on the AUX bus. The remaining compatibles
are either used by the existing DT or were used previously and are
retained for backwards compatibility.

Suggested-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 6db277efcbb7..95b25ec67168 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1776,7 +1776,23 @@ static const struct of_device_id platform_of_match[] = {
 	{
 		/* Must be first */
 		.compatible = "edp-panel",
-	}, {
+	},
+	/*
+	 * Do not add panels to the list below unless they cannot be handled by
+	 * the generic edp-panel compatible.
+	 *
+	 * The only two valid reasons are:
+	 * - because of the panel issues (e.g. broken EDID or broken
+	 *   identification),
+	 * - because the platform which uses the panel didn't wire up the AUX
+	 *   bus properly.
+	 *
+	 * In all other cases the platform should use the aux-bus and declare
+	 * the panel using the 'edp-panel' compatible as a device on the AUX
+	 * bus. The lack of the aux-bus support is not a valid case. Platforms
+	 * are urged to be converted to declaring panels in a proper way.
+	 */
+	{
 		.compatible = "auo,b101ean01",
 		.data = &auo_b101ean01,
 	}, {

-- 
2.39.2


