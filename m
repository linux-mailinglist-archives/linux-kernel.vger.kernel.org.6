Return-Path: <linux-kernel+bounces-542611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E89DEA4CB95
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0EDC18923DA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2603322FE11;
	Mon,  3 Mar 2025 19:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CZHc6xZI"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C55622DFFA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028835; cv=none; b=loYYdnNDd9eUO1kNM09j8vUt7juf1ToMThkLoJFNZ7IeFL9jFsw5L8wyy319fZ/k0RNxkPMXBRIeQdVlM5Lwo5cLvghqyXVfkDeMPnXzAWv3a/z4kTVx8jAMeHa7P1jCeEjwut+28K9fdN3a0GrFTApIxEpAb/BiepJHqxwI4c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028835; c=relaxed/simple;
	bh=C5LwrENTwH2Tgw+FAGkSdZC6DUqgfwq/ejX6RuFexBw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pDS7RpNSWizseB/dV0BTtEH0byUhenvgb9L+4wPb5tCiQbTnJCHlGxFyqCzoZP4x6AnSuqzId6gZ2MOiTDSNT8AylvZwfVKGHNYmmjhJGes+XL4Mo3LMFqTP3eA4aPsVU7DS464HBxTMJftbEtuxsw1DT4Tr/mQ4Or+ix2Sasi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CZHc6xZI; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-46c8474d8f6so43236101cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 11:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741028833; x=1741633633; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RjLrrjbGelu5EpoDPa36UkPc3emrxmZFTLwM+KeGDFs=;
        b=CZHc6xZIykauGXj/jLM8hTQpj7qEHEKmcWNWhoe6NqxrK6EkeVpx2ZD+ZVlIerngAm
         NzIdkncxwxdbLbIDpKUs7tNUbiN8fq0rxvb+31EYrZwFQurrvI+wJM0ezoK/yFBBa1FK
         vDA/PNwPbAzh8EsQ1XBpxhy/0ey2WOQLxtVl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741028833; x=1741633633;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjLrrjbGelu5EpoDPa36UkPc3emrxmZFTLwM+KeGDFs=;
        b=bsEh+jKcjaGbOF6RXUardK6YUJd5oKWabRzdAP2bm+yh2aiPwRKIhzPDrO2CcfSz6b
         aPcoYDYgGLjzPH90mH5+98dcBge4cpbNceC0e/XcuNQAW9zUs+CLwWyxvTYF8AQNw4hD
         j1fgAppup60uiAKywJU7BI1C0b/NyF9Cd3TP3DWnpqWdBPEk2ozv/NtUa5yi4gsIXdkt
         v1B55eh9jeSGTNYPQfE3ZplMp6sRXYBWoLYA3LRapyVBzcLCk5VP9aZMgjGYgeM1EWTW
         MMpDlyvQbGXsmBEYx5MfYh2BpIQM5ddzmB+Ut0CgyKz32IK8uAZq7R1dxqWK4BugNqhN
         Noag==
X-Forwarded-Encrypted: i=1; AJvYcCWtETFGM0E0ZZq+Zsb9bVQtV248v9hZwIBeHY+sHu1XOR4gejGhmt6z5G9zxAxz4L4De3eWmap0XofrIJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz414VUDUcVRvHl4cnD2Vf9IiSWBe2uDjw/2mypOE2luP199zKW
	Etrbmwlgk2Ay9nc555LgoaDFMIQVSkKIw+kGZCsd22SIxMagx2L8/hE2TE/j8w==
X-Gm-Gg: ASbGnctHzUEf40IBqDznl5rnUoacvoTOQrKxSvLqLT9s5HuUVbxjr0d3bh/Vak9AcS0
	ETm2FNKzND+sSWyPnLmpFnlLMdXGnDBYYtHRDtNmqDusEDJzMDH/Cdv1str/Nz7zj2hmdJAw1ew
	/nA3eDJbCztxaYFMPHjck8nhvNAxGBylbCbGJyb3bTCK+rr1KF6xKmoXXNm93kiDclm//jtrsc9
	/F4nH7icPB3PbdAEYMpTLKT9O5KNb4DycxQwjedufmodiyRx/FK1Qth44dpYSMF6UsxVonGilAJ
	NxtVC2DIFRxASP7RG+aHPpnCFNRUZn5ahWJZArpWmPXOisuijksvrkN9GQ+Z12E1fpEHYYDesyI
	0NwZbV5sDjcIeFInG/6o/sA==
X-Google-Smtp-Source: AGHT+IF2YGuMuEJXlAWgencJXcpvywOSAGbUxQNItha2yT6pQgTAh5PRfqEvcqmkUYsgz8PpDfkaLA==
X-Received: by 2002:a05:622a:594:b0:472:744:e273 with SMTP id d75a77b69052e-474bc0ee60emr176696081cf.42.1741028832932;
        Mon, 03 Mar 2025 11:07:12 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474f1b76856sm10218651cf.16.2025.03.03.11.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:07:11 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/2] media: uvcvideo: Fix Fix deferred probing error
Date: Mon, 03 Mar 2025 19:07:07 +0000
Message-Id: <20250303-uvc-eprobedefer-v2-0-be7c987cc3ca@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANv9xWcC/3WNOw6DMBAFr4K2jiN/wFJS5R4RRWwvsAUYrcFKh
 Hz3OPQpZ6Q374CETJjg3hzAmClRXCroSwN+ei0jCgqVQUvdSaVvYs9e4MrRYcABWbgOnWuDs8Z
 7qKuVcaD3WXz2lSdKW+TPeZDVz/5vZSWUsK1x2krjZdAPP3GcaZ+vkUfoSylfq9p0bbEAAAA=
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org, 
 Douglas Anderson <dianders@chromium.org>
X-Mailer: b4 0.14.1

uvc_gpio_parse() can return -EPROBE_DEFER when the GPIOs it depends on
have not yet been probed.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Add follow-up patch for using dev_err_probe
- Avoid error_retcode style
- Link to v1: https://lore.kernel.org/r/20250129-uvc-eprobedefer-v1-1-643b2603c0d2@chromium.org

---
Ricardo Ribalda (2):
      media: uvcvideo: Fix deferred probing error
      media: uvcvideo: Use dev_err_probe for devm_gpiod_get_optional

 drivers/media/usb/uvc/uvc_driver.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)
---
base-commit: f4b211714bcc70effa60c34d9fa613d182e3ef1e
change-id: 20250129-uvc-eprobedefer-b5ebb4db63cc

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


