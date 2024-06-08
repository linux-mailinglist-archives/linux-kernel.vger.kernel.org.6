Return-Path: <linux-kernel+bounces-206988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C35C8901112
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 11:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6D21F22B46
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAF21552FA;
	Sat,  8 Jun 2024 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTSWXWBs"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B61D520
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717838234; cv=none; b=Y4fB+MsXV1ipgkTCsSOUHbNWyK9EE/vzsfKdBGH3upbPmyqTwC/jjzw1TP4QIW5Ln8xcYaR4YJo5T60BgTgikQ3NH9oKOcZiHKGIw4xGCgKGuXHOkA8J5OFq2P3BoFJWIvZuHQWD4zP2gCBrziMMDyf1KaYQnsdh4DFMXeLsdbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717838234; c=relaxed/simple;
	bh=PiJ+zu82O1Yr/h2y29+smI7m4AO4R2fjy8qWbIMoW/c=;
	h=Message-ID:Date:MIME-Version:To:From:Cc:Subject:Content-Type; b=l94LWw7w4WiYtTFraALmmlVb8NTviNmbAqgQ78x+ATN+Kv3NH70DtEmdE0bYZP2I3Ol+Y/IGGiF76uUfd5axP/c/Gth35B5mx/llCzUN3DuEkTiGkxD6WdVZ3oKAVKgXidElWnudhGnX730MQ5Z3a/yjQfcjsKNRWl/a3SAwc5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTSWXWBs; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2bda9105902so2105405a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717838232; x=1718443032; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDXM+EewCoSYPs6hC+7G17jw1+2eIyZkkdf4bNQYFSY=;
        b=LTSWXWBsxzswLidV5Nxwe5L1lND9V0J92udUg97PIoBJLUi6jRwFnM8f//DcnBNNMU
         Bkswx0gZJ0u6EZkzSLwwQ5r/pogS6p/JkASpSXU5BWm3dFxuNhy52R+WOh+jPlUccwCX
         7WtMF/1Dqkb84nhJlhRH3aiAKEVtsfB8+4T5PttPegvVrnDHIm/FODa+nqvia/FwZo/a
         wi88gpLoGCP9QnNu9dko+uZxMgfpbTvYv0Dwexdg/7yKTFFTuvLB6o/daJ6/E494v3i1
         gvIsTpfcscpf6LDqCQ7HlbbPLhwdhpSaN9w/36LoWuo2rFbe7Xn3qYvPJ+l3IPH82vOv
         4PKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717838232; x=1718443032;
        h=content-transfer-encoding:subject:cc:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hDXM+EewCoSYPs6hC+7G17jw1+2eIyZkkdf4bNQYFSY=;
        b=IXHeDutC2+bI02ZlBO2yF2QRtEGnIurHFUAWzzpuztCUJrrP/n5WoP+i7hbHIc3ASV
         gZ+hV73VpenGBhkn0qUd0FECbCia9leVONNyiUgXjETe/UkWAjKVc1eP8PkEiPVUr1Np
         W52IIy3Bv5pN1kesch8mnXp1CWVC0EYSdk+qVk4VB/SQz2PO/czg6v83C0FDIMf9BehZ
         Tdejl4ebtaDqw+b9aBpgT2lhdZfeTO+nJ8M2mM7bQB7bahyvzmm6O9R0jg+LKz1pNy0I
         31TGRIv7t419b2XnFACGqJo9VT4MoDlsC+Ofrg7DyjLkMEHev7ngrbyssoGFPkJQ0LaZ
         aviA==
X-Forwarded-Encrypted: i=1; AJvYcCVF+B14GIduncqGntOds4LpDuqKRtrHTT282A7FJXe50LURync8CdqYbF/Ebg+60j829SfNzlSTFsLXjlFahgfkh9/XUxmJvH85+Y4Q
X-Gm-Message-State: AOJu0YzCRoRgUiK71Vvgm21MHw6VycXrtIIN3NuviWqLXDZYd5sVbABH
	mlYNKlIzPDugG+CIokVPMjoe4Wlg7q6uCNdD2GKWYFXboL5fvlZI
X-Google-Smtp-Source: AGHT+IGde/oeFABo2VXZ0vdK//U3/3ON137q78IG1uPwtcXXMD7gDn6JH98DnnKWa1WZhV3lHbGg0Q==
X-Received: by 2002:a17:90a:17ce:b0:2c2:cd5c:62b2 with SMTP id 98e67ed59e1d1-2c2cd5c6698mr2713077a91.27.1717838232427;
        Sat, 08 Jun 2024 02:17:12 -0700 (PDT)
Received: from [10.0.0.19] ([122.172.85.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806398afsm6903463a91.1.2024.06.08.02.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jun 2024 02:17:12 -0700 (PDT)
Message-ID: <d9f4546f-c2f9-456d-ba75-85cc195dd9b8@gmail.com>
Date: Sat, 8 Jun 2024 14:47:08 +0530
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
Subject: [PATCH] drm/panel : himax-hx83102: fix incorrect argument to
 mipi_dsi_msleep
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


From: Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH] drm/panel : himax-hx83102: fix incorrect argument to
 mipi_dsi_msleep

mipi_dsi_msleep expects struct mipi_dsi_multi_context to be passed as a
value and not as a reference.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
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


