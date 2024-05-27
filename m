Return-Path: <linux-kernel+bounces-190386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD758CFD91
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED421F21F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4B213AA41;
	Mon, 27 May 2024 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ndF2VBlw"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FE513AA5A
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716803771; cv=none; b=qWezbtHolDHE3JNHAELb6Dc20AWABerhKPOuLgE+dixQ4FOfGzH00PZlP1bw63Hq+uvme8YNExMNHF/vj2UtgC5n14U6b78xisE2a/0VgQ9mw8AIFI0gA9CETftnGQ/fCxy9GaT69KIevzl41v6LSqv5GMW0z3jhPijWQdUBNG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716803771; c=relaxed/simple;
	bh=/R7F8alwlIE6tAauaNSMCgabJhCQHv9mseBJgdRN924=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gc/bn8w6nnMAGU0UQEy8jO9wW0WqKcctSuGLIaMirLLhtb117JapTwrPSkKdgOU5pIgeFYtrVjWY9zIFGbNvEEi96Y5HbE5iPFBtVRcTsLl7VIwi8TpoL9g+HgDaweW0VS1pRMNsS2diL7c9S5NwgV5lL4b8FBK3OXKSe2ljGKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ndF2VBlw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f8eaa14512so2399585b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716803769; x=1717408569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYq43fmtb+4UHKmDuikNl6P8Zva6K1Fw4vNwaOjA/dQ=;
        b=ndF2VBlwsGLTmspmbfUSDl1xRF8MpyJEPIFHZAJU39R63O3195Vc1rVRNkC4Opsf96
         xqaVgDX/b6VOywmbEYM3MqZcbA7jJ0yqyTX/9kh6gHeL5KPBD6oIBU+HpD5IO70UKIOg
         8fcwAKLeLc+63obVeStP9qIHjfRE/QH2RLh2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716803769; x=1717408569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYq43fmtb+4UHKmDuikNl6P8Zva6K1Fw4vNwaOjA/dQ=;
        b=wl339Km4O5QWSh/klcB95YoCCXbBIGDCgtqTbVYHwQWu65+skdwZOuuPKOdEODTnoX
         z5uFcaah5n+/qVWZPWDWP5aImLoYMzDO9Lvw+U3hoCBT7iu97VjYENJ2fS1YvrV3mCOa
         9FuFm0yFpM3NsnJb67o6nt5ChtWymh3xjJ23iBOUzQicVNAFxCfwIScydWcdvLVPDVoO
         fL6tcKdJhq6v0eLv0SG0+F5KyRknbdfWw/TO6TueQ2LJsmCU2qjuc5IdcVmv7eoRejUs
         NFTfmpikH7KmpVNaEFQN/lT6UWHiIWorPG0E17w0reuYH5huELgsrZQwABzcMmzOK/Ys
         IsmA==
X-Gm-Message-State: AOJu0YxseAriLyZTzntlVAtdI7Mda8k8KTEseMpAX62uWKEnu5ld8Tph
	7tpuaeDjHp4wSX42jUoVFwkF2Iw0SDZFTk2wWve3XMMJhq9S4NpcwRS0wL+D/A==
X-Google-Smtp-Source: AGHT+IEranJRFgpDe21yNvkr6wFRzulLhbElQ14owwih6Yncq7oSN7VEwSz/jPzabvR4W4a/5GdlXQ==
X-Received: by 2002:a05:6a00:2a03:b0:6f4:490e:6 with SMTP id d2e1a72fcca58-6f8f41b1a5dmr8279151b3a.30.1716803769572;
        Mon, 27 May 2024 02:56:09 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:a9ab:23f:9d2d:dc0e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6fd94372addsm2951616b3a.186.2024.05.27.02.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:56:09 -0700 (PDT)
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
Subject: [PATCH 2/2] drm/panel-edp: Add more panels with conservative timings
Date: Mon, 27 May 2024 17:54:50 +0800
Message-ID: <20240527095511.719825-3-treapking@chromium.org>
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

Same as commit 7c8690d8fc80 ("drm/panel-edp: Add some panels with
conservative timings"), the 3 panels added in this patch are used by
Mediatek MT8173 Chromebooks and they used to work with the downstream
v4.19 kernel without any specified delay.

These panel IDs were found from in-field reports, but their datahseets
are not available. For BOE 0x0623 and SHP 0x153a, their product names
are retrieved from the EDIDs. The EDID of AUO 0x1999 does not contain
such information, so list as "Unknown" in this patch.

Update these entries with less-conservative timings from other panels of
the same vendor.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

 drivers/gpu/drm/panel/panel-edp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 2688ff1eb14f..f5060c9f821d 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1983,6 +1983,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1062, &delay_200_500_e50, "B120XAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x125c, &delay_200_500_e50, "Unknown"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x145c, &delay_200_500_e50, "B116XAB01.4"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1999, &delay_200_500_e50, "Unknown"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133UAN02.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116XAK01.6"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x203d, &delay_200_500_e50, "B140HTN02.0"),
@@ -2007,6 +2008,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0607, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0608, &delay_200_500_e50, "NT116WHM-N11"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0609, &delay_200_500_e50_po2e200, "NT116WHM-N21 V4.1"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0623, &delay_200_500_e200, "NT116WHM-N21 V4.0"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0668, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x068f, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x06e5, &delay_200_500_e200, "Unknown"),
@@ -2118,6 +2120,7 @@ static const struct edp_panel_entry edp_panels[] = {
 
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140M1JW48"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &sharp_lq140m1jw46.delay, "LQ140M1JW46"),
+	EDP_PANEL_ENTRY('S', 'H', 'P', 0x153a, &delay_200_500_e50, "LQ140T1JH01"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x154c, &delay_200_500_p2e100, "LQ116M1JW10"),
 
 	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0100, &delay_100_500_e200, "2081116HHD028001-51D"),
-- 
2.45.1.288.g0e0cd299f1-goog


