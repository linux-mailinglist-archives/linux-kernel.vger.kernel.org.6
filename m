Return-Path: <linux-kernel+bounces-210032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84392903E58
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02BE3B21D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3725917D37F;
	Tue, 11 Jun 2024 14:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQChe+ad"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EB71DDF4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114718; cv=none; b=ur/mk1VuxplB5Z+Q8ggVHq9O4oggJrdLgYb6W20iMkz6j2o4YTdZulw7CYOSbwGU4LYOjlBSdqYtW3J8JGbqrLFS0ahTGecUycMSqleIZaYi/L1vSCOdo30LliLCJRIGlPxtDXEoeBxk2WBEvbN8qUnsDrLfKBa7RepDTiv2KN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114718; c=relaxed/simple;
	bh=uD4M2vuWvnr/FYqJKUEwIRqZV+qIYFXFrcZIZ3XUa4k=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=l+MmB9Sy8AWnBAsSXBZVZmhY1XQYuPZX99FqDPbAp8OXfFth55Xp4FrOCd7XkLkElf7iSpm/Y7PHg3/qMpCV0VgzygSbbEx8rtQ+GMn6BLWKt636GsMRIv8eonbLMPHxS7e73M8YcUTGW4ph5mP6WxwqX92KZcufFIWXuS1OhDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQChe+ad; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7041082a80aso3460684b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718114716; x=1718719516; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38tu7OukSsob3gjFMMjlwZapLvS+XgxyUoOOKJ0vVdk=;
        b=QQChe+admChP/5T0dhgo8Eq04gwHjwCv+/YO2+zouO4ANOaofZpsufDei6g6KmFThQ
         xLYjlVpZDBkOSxbTAlDchT6/W9PRF917b3mo6lpaxjZYaJxQLf4LH49iwF/TIddYOXZt
         p6wfNvTgoxBQ5JstGr0xmAQ4iTASbnYRWyufdDILYBJApJ9Zgjh0+/B542Is70jJKCGE
         qpu/h6YwIBQzQ6RSq4hZmEYSgU0CJze+prkv7LeUMab0J9Y/qb0MHvJhMPT1HH2a2lyV
         6uI+UMOrneZ5+U8jFSAMANET8oZMSuJfzR1Kz3LOzGayBlSrjQzeZLqh3KcorOQlXICI
         DVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718114716; x=1718719516;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=38tu7OukSsob3gjFMMjlwZapLvS+XgxyUoOOKJ0vVdk=;
        b=eSKP1APeMJVNln6aZyQBt4eKVV/e9r2Co3y7vRVys0OB37dfvFYIGP2NSNOZt2RONa
         vtzozu8Iv9qjIJnDfz7qGklgcW48q4JrZ2ssGcruCQ0q5Qr4Bg4R+ajvLeTDoQUsi/qE
         RK4dUb4zHSVlpF+VtlVPmPWdxYxeXDKQWOOG0kgSvCUcujNfZ6vPr70bBWK/MQ7Fc7oT
         FAfKOmiLOZyB9HQSY+96PuqW2kPgtcw/qdCw1CQt/gd3gOFOVf0c8DiaQ5HOvFVVyoSV
         eGkxaHYCtgCg6Wav+u6gJx8YtgvFTb4M5+S6VQdgZG98zZtDETKcwAmBTmkAACTSpjdn
         9VEg==
X-Forwarded-Encrypted: i=1; AJvYcCUqj3D6aEkkR3es2s5KVNrRuKVrHF7BaeZQUGo6kVqcE/gYK6+1D0Wi/aY8RjyF723pVTKjI9Pi/beCfSoF+Rr0XzKS2xEFsIucAR0B
X-Gm-Message-State: AOJu0YzefWyo7mv/Dd4BogwcieXKLgraWfYTSj7EsojkGfC6qvUxjll5
	45doGZ2Enf9ucncop7Dyf3dNOI1G7nm5IgVY94V/4wo/1oknbITH
X-Google-Smtp-Source: AGHT+IEVS+sMNyFBjvo2nPo59Rw+Yitrzl0X6ZQnPzDXsQRp1kcRfQtAKLgM+0aFOze8xPVBJashnQ==
X-Received: by 2002:a05:6a20:8408:b0:1af:dae8:5eac with SMTP id adf61e73a8af0-1b2f9cb8dabmr13394713637.46.1718114716341;
        Tue, 11 Jun 2024 07:05:16 -0700 (PDT)
Received: from [192.168.0.105] ([103.246.195.195])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705b3198eddsm828917b3a.192.2024.06.11.07.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 07:05:16 -0700 (PDT)
Message-ID: <1b7c19ec-536f-4f28-a68f-b03c1b51b99b@gmail.com>
Date: Tue, 11 Jun 2024 19:35:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com
From: Tejas Vipin <tejasvipin76@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/panel : himax-hx83102: fix incorrect argument to
 mipi_dsi_msleep
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

mipi_dsi_msleep expects struct mipi_dsi_multi_context to be passed as a
value and not as a reference.

Fixes: a2ab7cb169da ("drm/panel: himax-hx83102: use wrapped MIPI DCS functions")

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---

Changes in v2:
    - Add Fixes tag

v1: https://lore.kernel.org/all/d9f4546f-c2f9-456d-ba75-85cc195dd9b8@gmail.com/

---
 drivers/gpu/drm/panel/panel-himax-hx83102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index 6009a3fe1b8f..ab00fd92cce0 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -479,7 +479,7 @@ static int hx83102_disable(struct drm_panel *panel)
 	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
-	mipi_dsi_msleep(&dsi_ctx, 150);
+	mipi_dsi_msleep(dsi_ctx, 150);
 
 	return dsi_ctx.accum_err;
 }
-- 
2.45.2


