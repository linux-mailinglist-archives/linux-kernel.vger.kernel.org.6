Return-Path: <linux-kernel+bounces-190385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818568CFD90
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B319D1C21339
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F10713AD04;
	Mon, 27 May 2024 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XH3BduKH"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A9713AA5A
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803765; cv=none; b=s1zrJ7gjjl2svHV4GjT8QYUs6DM0ryPlsoxVekXIJveWLpGi2W4kwfrHf3AXcYCoAhChvs6kRuSjNOPx01GjpZN0nalRWxQBWH/xSSrX8Mkl663Wv0MspoFdHeMk9ZgZxdNHV+Lmgs0vlj9FSLpEhXrf8oaGhkXZB1JrkL7KTw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803765; c=relaxed/simple;
	bh=ssYNAyM+Wrm3A/wzKcQOiFbguT4msW3A8pkK6v4qL2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFCstxhFyj9cb6lOECfXi6U4B5r8MeWelEp9dGygM/OIUolp+8Fp5TOrRSkvODjmRdxUlOrqyCqoPZDztR8pvlIr7gBnfCdM2tex4mp1iHeaqH11BgwJ5SCt2St0C1ahhv2e7ajAaRShK8cJduNxL/oYRYWCYDg3ysPKlLKmFPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XH3BduKH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f8edde1013so2430439b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716803762; x=1717408562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hri39nzdsLHFaL5eQSVV2RnGvDJQcNHW5cuOIUxzRm8=;
        b=XH3BduKHJeRnFMEZNgHcA9yDQFXNrxTn1hZQWaUpmU+ASma4IBrhvHM7L7bokermtr
         B5fxGunVt6M39+9TQ9YJoSTwnAzFEvzw7QAyooa0SFLrSVKTWdL9nKaaNPd/0kdAhT7i
         D8kYvzIAqfClOLL3pJJT0I1M3BgJjgUmYInic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716803762; x=1717408562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hri39nzdsLHFaL5eQSVV2RnGvDJQcNHW5cuOIUxzRm8=;
        b=u1jMHIph72Ot13aumbY4/1JovE6HvZ9BhUulVOXUnLHu0nhIEmOBnrPUfERMyMTykn
         l7S0iHnWkTrB+cqXDnbyJwKnVuiNEjxHHdAYJvHMBzVb8XGF3j9HLgjCfXI56ccmjz5I
         Lc55HN4GiIUo0bgNB4qn54eKjRi6pjqjMKru9UfCJ1Qluf0MElPUOgjkMgCn1ajxBhOg
         shQSJ3EVu36GaSoB0iAq1n08TX9WCQ9PdAzHaOjoeawaqmMB9hcEnE+riM+EFkwZnITH
         ZQlAWoZghfvE9FynBwctB0gICb5J3gIvnU1MwdJn0iIqNqonsVDeiTIF3FyXnNcvmmnS
         k4wg==
X-Gm-Message-State: AOJu0Yxuz/6G8sUOGlj4Ym85yce7Z6LT27IbD4WM4SjW/pa343NT/4em
	xBiuW7UQ1XbDgH+Q4oFOoYebThqP832O115pUhQsrzAQURImRNYG25nNIaFxpg==
X-Google-Smtp-Source: AGHT+IHUc2Oe5f9342JCi3pcCnVsTBNJ/kRwkv7ILoAyjRnszeU3ZyL9Go0bULUqzpA/VnM1VSbEhQ==
X-Received: by 2002:a05:6a00:8013:b0:6e7:3939:505e with SMTP id d2e1a72fcca58-6f8f2c6dd6cmr8236318b3a.2.1716803762447;
        Mon, 27 May 2024 02:56:02 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:a9ab:23f:9d2d:dc0e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6fd94372addsm2951616b3a.186.2024.05.27.02.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:56:02 -0700 (PDT)
From: Pin-yen Lin <treapking@chromium.org>
To: Douglas Anderson <dianders@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH 1/2] drm/panel-edp: Add support for several panels
Date: Mon, 27 May 2024 17:54:49 +0800
Message-ID: <20240527095511.719825-2-treapking@chromium.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240527095511.719825-1-treapking@chromium.org>
References: <20240527095511.719825-1-treapking@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the following models:
AUO B140HTN02.0
BOE NT116WHM-N21 V4.1
BOE NT116WHM-N21

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 drivers/gpu/drm/panel/panel-edp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 01e26b5a2388..2688ff1eb14f 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1985,6 +1985,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x145c, &delay_200_500_e50, "B116XAB01.4"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133UAN02.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116XAK01.6"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x203d, &delay_200_500_e50, "B140HTN02.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x208d, &delay_200_500_e50, "B140HTN02.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x235c, &delay_200_500_e50, "B116XTN02.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x239b, &delay_200_500_e50, "B116XAN06.1"),
@@ -2005,6 +2006,7 @@ static const struct edp_panel_entry edp_panels[] = {
 
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0607, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0608, &delay_200_500_e50, "NT116WHM-N11"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0609, &delay_200_500_e50_po2e200, "NT116WHM-N21 V4.1"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0668, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x068f, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x06e5, &delay_200_500_e200, "Unknown"),
@@ -2020,6 +2022,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0771, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0786, &delay_200_500_p2e80, "NV116WHM-T01"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0797, &delay_200_500_e200, "Unknown"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x07a8, &delay_200_500_e50_po2e200, "NT116WHM-N21"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x07d1, &boe_nv133fhm_n61.delay, "NV133FHM-N61"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x07d3, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x07f6, &delay_200_500_e200, "NT140FHM-N44"),
-- 
2.45.1.288.g0e0cd299f1-goog


