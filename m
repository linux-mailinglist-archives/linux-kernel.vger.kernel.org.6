Return-Path: <linux-kernel+bounces-446039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 371159F1EF6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 14:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6172B18897C2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 13:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6218519939E;
	Sat, 14 Dec 2024 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OY3pCGyS"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732B71946AA
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734183440; cv=none; b=S/DHOrD875re15YkO2CBZflVyYPqttMIKxCAxMY0iGxsjePsa9zNC/5liP4o6kARBVdSvQPTyARk1MDmcEXHy/W76MpSSRw3uMtdgwkaSAdo3bJp18jQvxKPuym4OQLYh8q2LgWdIfVA0AMkTGZazC7eUt13rvxxPKLU1DRnxYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734183440; c=relaxed/simple;
	bh=ZBQ31V6liiRq6vidYEbRih6I4hmj1n9WetjDV7X3pNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KZQELmp0EhhZwKYb2/vDIrzNrnjKFyKN5zW9U1Qzt6+0+20BONDGAXT3xemuKqUZU1SQ5kS0pfA28uED4OevvyPbk3JQIGUixZ/nppgySD7AemZ7+Tg1hgz/QS9FAYBG4SSN0lgRvJwjUqN+LndRssJPEbvBiFLxZv4hBB7vQiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OY3pCGyS; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30219437e63so39661081fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 05:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734183437; x=1734788237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdwpibg0RRPk6EpwAQK84EDSpk8VUe5onS1+M5umUds=;
        b=OY3pCGySGBDFuNifo0BULnr0GzMejSUdm/FBcMmIdw/uG2dlkc7SURt/+OKNGx63h7
         JZZpwcWk+LXdH3Q2WcpHJ9tEfWknaONzAE0b9ScB93urBzZRLqaVKbiVv1EqOwRyIeBA
         4e5TM/x5alXlU8VLdUNTOMIVBOWUcp6zGhSPEQe/XjCgsd4lxah011X2Yryqcrshl8RS
         u4xM6IeKCZ91KnLGrOJmYJRQVnltdJ4aDTLc/gROeclDOYohJgncP+Oh0AHCDyTCjgp1
         1r/1xctOToXcYn8aBYNCB7LJDuooeNIQpSEyM95OgqoEg8cqlK9+xwT4p5QV2HBGXYBj
         PT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734183437; x=1734788237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdwpibg0RRPk6EpwAQK84EDSpk8VUe5onS1+M5umUds=;
        b=wLbLpIiqbxLY7X5AqPhZOl7QISnV1NLhtHxzlX2xSDucfcbcZSZw3QcasZYZBq1TUp
         +HZf7Z/0tXRrdR64VD1p820mkMEPEivZLIpHHCRiLkoUcEFmtktGRZbIEWQYC8CGBQgd
         rGgBLiVv1i0z1hN6aSvc2zK9P/wyGp4W6QcfvGNaLTdHP0kZd/kQqgXTF5XOLgzUanOy
         u9cncGIfepDb6WB9+3hI7Z7CVuzmWOLP8FVKb9YcvJR4/nfJtQEeKiLaqr6nNeJB4XUZ
         3Agwv/ehPtccB/Mtrf1EEH3SvKjHY6tIM1I/O3OoDghiTJB8fenY5RTh9LJIPuRcLGIV
         L2Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWKd91leVGyZjjOhyU8zSkGNS4f4AHwdefuWIu4MYTaL9kqWWleubmbI42sfYbqPl1DME9JzBrtrA9p660=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjRDYBVMZRUgkerU38tlUOXUhdagoYYkQimtANzP0jRRYiFDHD
	aCrn1vBYWTL9kPmvUYtB1t3V5H7FUiQqqBSXCxSUc3xobxEX1DmiRLks7aD7E70=
X-Gm-Gg: ASbGnculbkDnHDBGkexxUBX0DlctRoWUay6POEkMcOvIb98ljQJCqb/s4efU4upE1+x
	pcIv+gUKTk5sNn3eWiyEXfeZWLz1JxeoTFxUbquLD8OlvwVj0CG14hR/xSDFGx2yUME76L6xru/
	DLF3nZ/PJCP4tYD/wZ9m6mGsIIJEOvV+5nvlae/+yCf/P/R4o9DcbYK+9W1qdg1G/cBlxca6p/y
	AanzHpVhKkmoit6P3Zv7h0eGNzBBEKVrJcsjpOvQi7um+AZ9xlEkk88YbVsN3hz
X-Google-Smtp-Source: AGHT+IFDFHsf0YSq3F9U24ZzRaZqLHjwAZuUnskSeXvaHoyC4Tfjr1H/Oi+lGDIZJQoDaEfr8W2dtQ==
X-Received: by 2002:a05:6512:1591:b0:540:20c5:f847 with SMTP id 2adb3069b0e04-5408ad76276mr1606863e87.22.1734183436550;
        Sat, 14 Dec 2024 05:37:16 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120baa474sm220131e87.90.2024.12.14.05.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 05:37:16 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 14 Dec 2024 15:37:06 +0200
Subject: [PATCH v2 2/5] drm/amdgpu: don't change mode in
 amdgpu_dm_connector_mode_valid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241214-drm-connector-mode-valid-const-v2-2-4f9498a4c822@linaro.org>
References: <20241214-drm-connector-mode-valid-const-v2-0-4f9498a4c822@linaro.org>
In-Reply-To: <20241214-drm-connector-mode-valid-const-v2-0-4f9498a4c822@linaro.org>
To: Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@redhat.com>, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Peter Senna Tschudin <peter.senna@gmail.com>, Ian Ray <ian.ray@ge.com>, 
 Martyn Welch <martyn.welch@collabora.co.uk>, 
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Stefan Agner <stefan@agner.ch>, 
 Alison Wang <alison.wang@nxp.com>, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@csie.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, Zack Rusin <zack.rusin@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, virtualization@lists.linux.dev, 
 spice-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1822;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ZBQ31V6liiRq6vidYEbRih6I4hmj1n9WetjDV7X3pNY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnXYoEN8DdEbQT15+majQu+ePNp1xNEKgZhouhG
 e8cSSkRWPuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ12KBAAKCRCLPIo+Aiko
 1bo9CACKI34mpGW7I5SEIWTnqccfI1E5Dtim4SK/n6/h7bhcZ4fIdi1jPZNDeFfoInJlcQC8kND
 J2yGE2Waz+dJVLeD9HrrAIss+FWiq5KGvzYWgYBmjLuJJCE3PKkqoV+6+sFD44LUIBLxdTRdh6F
 1T4gKfvqmlDPQFnUhlG3DwphgtSkVOEHHExB8YC0ysIBaeNXz7rClOEu0mGlIZuDjJS/sjgrall
 atWiYOaDofYW+7dTZ9u0SDpxMVllsbKKomyCy6kf/BSVOIp9veKIrgbybIWQXyNIZgk95KFTa4/
 BfCF2//Diwl9V4b6EJ2CMV1tWTpGoVbvzyIZV/xfq0Bc89tB
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Make amdgpu_dm_connector_mode_valid() duplicate the mode during the
test rather than modifying the passed mode. This is a preparation to
converting the mode_valid() callback of drm_connector to take a const
struct drm_display_mode argument.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5a503104e38d1514103914a4d012969105877e52..0d9d2e1c4b4fd48baa19f16fb832a9ce5ed09108 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7420,6 +7420,7 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connec
 {
 	int result = MODE_ERROR;
 	struct dc_sink *dc_sink;
+	struct drm_display_mode *test_mode;
 	/* TODO: Unhardcode stream count */
 	struct dc_stream_state *stream;
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
@@ -7444,11 +7445,16 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connec
 		goto fail;
 	}
 
-	drm_mode_set_crtcinfo(mode, 0);
+	test_mode = drm_mode_duplicate(connector->dev, mode);
+	if (!test_mode)
+		goto fail;
+
+	drm_mode_set_crtcinfo(test_mode, 0);
 
-	stream = create_validate_stream_for_sink(aconnector, mode,
+	stream = create_validate_stream_for_sink(aconnector, test_mode,
 						 to_dm_connector_state(connector->state),
 						 NULL);
+	drm_mode_destroy(connector->dev, test_mode);
 	if (stream) {
 		dc_stream_release(stream);
 		result = MODE_OK;

-- 
2.39.5


