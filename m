Return-Path: <linux-kernel+bounces-263931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89B793DC87
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15CB31C20990
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 00:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9198FEA4;
	Sat, 27 Jul 2024 00:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AoWHWe68"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55017195
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 00:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722039878; cv=none; b=PyI78mTEzZK9dSip7UCGVBU8Tyc2IBFMJj12P7AeM4rp9wBIwb+hE5Lz4bJx1ICDX7BFdli/Vx/1HfRAYPled7EptxO/X6fWfsnwRXV9+6rpgczLxmmVfQUHMmEs1ffm6eJDQ0v1Nexma82JNZs2+us3cktQ+Hv70ssfxB782z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722039878; c=relaxed/simple;
	bh=Ndp4bAkXYF/K4IQwJ7+ZYrFKk1x51BhCGMUzpEpODxE=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7E4Hw/q2o+e2k+HDy/T9r5OBzqHEr1MrSmMEYoprlzmiPkh3eVavo6Po2CG5r7Ns3Q1olL5d9BjrPhCQLDzwvPnAcBTw/m+f8ZP4HAjToUpNfKSdVW1l0fPKWuCdJjlQ89CMONnbvwNsLQ1K+JewcFkzKmMyFkJwfSb1Mi4zh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AoWHWe68; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b791cddfcbso6198016d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722039876; x=1722644676; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07ogrVS5x8lpQcrfQ9VX3T1kjP2RfniPU+x1JGxiSQI=;
        b=AoWHWe68+5YY+0+oIoHmTNw2Zv8QsJgqZc03WaOlTf54NSrl9+rI7nFJVSmsAuLCYu
         C6nviqqlDT07P990LRPCxrkn/1i8a2/qj0La9fd3klsk6xaGcdT+1WTzChOZm6ibLGTD
         brgRQVpwE1Hx4zmDcsi8/GFYu2VrWpChDquD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722039876; x=1722644676;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07ogrVS5x8lpQcrfQ9VX3T1kjP2RfniPU+x1JGxiSQI=;
        b=gYgXP/sDA1PfUAry+sy/b2Qanl5TDqYpe95IIuUfo9rUDrtPcAgEXPWZfbhXNsVFkz
         WtnrNWM9CZuwRn7IQxKnd5mLgmJBhjDk+IxmaG6c0eqa45ESKBWgV6rbbFWafs0gbnr4
         ZOSS9Jd+1anGsBrmy5Vu41KScYC5I5t5j//eZ4UsPE1Dq2YXmkAwIFR2ddGtSnWaQN/z
         Rh5KJiEe2e9p+uG0xFTr50Dw0rTaeXaaKz/xmoXTAtysXbs58qq48GgMeIfQfTqMZX90
         LR0J199MdmP/jXbDTeCTv1XRL9Y5p3AJN67id990jncqzOs7PaKDEU803S82y8P4w7Qu
         w3MA==
X-Forwarded-Encrypted: i=1; AJvYcCUtW540NOZXF0tkwVfubpbJBMBf84khnYjNFSb82luwzj8gX7tgiO5qOEggnmZMkVWAF0v8ZFILjDgJ+wC/mt7LnTAV3Scfe5mQAJyw
X-Gm-Message-State: AOJu0Yzmrk/o5iJy5keeunpCWl6JHKc41bNXdvVnUbriTHMOQoVOGiQb
	GuUdzaUkXjdu8CFtos4CLnASAO2KSlXc16VFoxehbanQvPGuqP0kv0WxPrWzCLPg225djQPBjgz
	yf0IZ2mA9SPIU8USxm5LgKSZ7fdAamqKR1fid
X-Google-Smtp-Source: AGHT+IHpnZkC5VzVD/9wtOuDbyMsVbJocHHwdfZb7aYI9KRRHqHEMH/h3Uk7GOcJxPPS3XvCEOHVuSYaA8p7WV7saKw=
X-Received: by 2002:a05:6214:19c7:b0:6b5:6b1:6c with SMTP id
 6a1803df08f44-6bb55a1533dmr19000576d6.24.1722039876063; Fri, 26 Jul 2024
 17:24:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 17:24:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240725220320.130916-1-quic_abhinavk@quicinc.com>
References: <20240725220320.130916-1-quic_abhinavk@quicinc.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Fri, 26 Jul 2024 17:24:35 -0700
Message-ID: <CAE-0n50mBEX98HH+5BurM-uRyzrxcPXFJ7yLg__hFJHfYjm67Q@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: fix the max supported bpp logic
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Guenter Roeck <groeck@chromium.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Tanmay Shah <tanmay@codeaurora.org>, Vara Reddy <quic_varar@quicinc.com>, 
	freedreno@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org, quic_khsieh@quicinc.com, 
	Rob Clark <robdclark@chromium.org>, Chandan Uddaraju <chandanu@codeaurora.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Abhinav Kumar (2024-07-25 15:03:19)
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
> index a916b5f3b317..56ce5e4008f8 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
> @@ -423,8 +424,10 @@ int dp_panel_init_panel_info(struct dp_panel *dp_panel)
>                                 drm_mode->clock);
>         drm_dbg_dp(panel->drm_dev, "bpp = %d\n", dp_panel->dp_mode.bpp);
>
> -       dp_panel->dp_mode.bpp = max_t(u32, 18,
> -                               min_t(u32, dp_panel->dp_mode.bpp, 30));
> +       max_supported_bpp = dp_panel_get_mode_bpp(dp_panel, dp_panel->dp_mode.bpp,
> +                                                 dp_panel->dp_mode.drm_mode.clock);
> +       dp_panel->dp_mode.bpp = max_t(u32, 18, max_supported_bpp);

Is the max_t() usage still required once 'max_supported_bpp' is also a
u32? Also, what is 18? Shouldn't that be some sort of define so we know
what it represents?

Or maybe none of that is required? From what I can tell,
dp_panel_get_mode_bpp() calls dp_panel_get_supported_bpp() which will
essentially clamp the bpp range between 18 and 30, unless
dp_panel->dp_mode.bpp is between 30 and 18 but not divisible by 6, e.g.
29. Perhaps this patch can be included and the max_t above dropped.

---8<--
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c
b/drivers/gpu/drm/msm/dp/dp_panel.c
index 07db8f37cd06..5cd7c138afd3 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -90,22 +90,22 @@ static int dp_panel_read_dpcd(struct dp_panel *dp_panel)
 static u32 dp_panel_get_supported_bpp(struct dp_panel *dp_panel,
 		u32 mode_edid_bpp, u32 mode_pclk_khz)
 {
-	struct dp_link_info *link_info;
+	const struct dp_link_info *link_info;
 	const u32 max_supported_bpp = 30, min_supported_bpp = 18;
-	u32 bpp = 0, data_rate_khz = 0;
+	u32 bpp, data_rate_khz;

 	bpp = min_t(u32, mode_edid_bpp, max_supported_bpp);

 	link_info = &dp_panel->link_info;
 	data_rate_khz = link_info->num_lanes * link_info->rate * 8;

-	while (bpp > min_supported_bpp) {
+	do {
 		if (mode_pclk_khz * bpp <= data_rate_khz)
-			break;
+			return bpp;
 		bpp -= 6;
-	}
+	} while (bpp > min_supported_bpp);

-	return bpp;
+	return min_supported_bpp;
 }

 static int dp_panel_update_modes(struct drm_connector *connector,

