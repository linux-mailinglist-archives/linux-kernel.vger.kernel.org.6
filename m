Return-Path: <linux-kernel+bounces-341553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B779C988189
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E813A1C22122
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2A71BC08E;
	Fri, 27 Sep 2024 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cbwUDazH"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3831BBBD8
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430146; cv=none; b=jZ9O7KY254vWntSYEc1eYCS26BSM4mewidWdwkXKW6FS1oo5pMqmqs8H/npc5vtByEyXCACR5HwnlzTibnjSGGTXBIq0cDleFGr6JrDLbaY6nVJXpTy3DOJPKTcSfDnizm7jTCj1BPiEfr2NQ/6pXDy+emRxRTk5gkGHH8CGEVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430146; c=relaxed/simple;
	bh=VyNnQQDdJJNeW/LwMh2KTy2Bsd63Uen2yuUOk3ftr40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U7Ifapjt9b/VicV/NrkPUuEgL3rIS+MzDkIS24qsJKkDjJUYPa5F5vtjZDC5BOA3t4NbHeK+Y7BWTxLY5y+lIdlQjLD+pfEozX1AlPkji+f8SYHgZ1VgseIM42VhtFOlr5JrAc1nAiJ4afI46Tep3AG4jRApGCEYLncSQZpX/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cbwUDazH; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cb259e2eafso16682266d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 02:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727430143; x=1728034943; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5LcjuiiFLMydGICnxC7Y1POK5qtShnTkO1KY/L5xYc=;
        b=cbwUDazH20b8HMp8EGF0fOP96luAgSBMpuH1hE0sevSaIbuiNgkKpr5ftXbh9Jhn2T
         MeKCtMsHrH1+ulUYePGX975CYMBrOqcY4IXqEW4yTTro+PlWVn6CkBb3/kinKDk3AwMw
         qYU3P5cUtXASC9KeVP8Dp3j5bJFKKIHsmEXqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727430143; x=1728034943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5LcjuiiFLMydGICnxC7Y1POK5qtShnTkO1KY/L5xYc=;
        b=EOwEZxgmpokSO59Npt7lncrwh+pQYLETMvauk0bXufkmCt7z9mKHVw3vZv0m+ZXxx1
         LllMT3C3q+ojMzjaFrkej/873Rtm58er8Jbj2H9klPTVKuO/OWvMqoSTypAkb/n2Dd6M
         T3TqlPrTR0DFZFPUGpnoqKj4fy+ozl4SgjQFECO1ZWVv2UpPOdU4AdXImBAAlu2ZKSnY
         ixgUok78UqmdAr34XSSdnmLQ5c92vk7jsD9VPJsJi4BnS//7cT6yPDn9RCv/B/Exgc5b
         45adUtwL1kaumOHhPgNkkoGO5eDbKIL7Wotr/MAhv6byn0wd3vpZbwj6YrkHNEY1GC4n
         Ps+w==
X-Forwarded-Encrypted: i=1; AJvYcCUZXGFv+nfPa8A/h2HroSBoNFDUDB7OuLNOkRK2HiI9ObbCFAmbrd04OabXZ0o69yXsMBwXdjFRrhpumwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAjEpyp8zAOMPz/8UZNl+C6S2+j92A/g8LCEdsKpF30LCZKWOL
	mV8+jz8pP1I5goHE1qXK+xkyOQCcMs2MPBPYocw6GN0BVKHtio9Xtum4hr+zJA==
X-Google-Smtp-Source: AGHT+IHqAWy4X2erODR4y6wB6ll6Vg8M7MrsnkD9K4fU/rxNaepW2iQICN+JlQ+jvD6Nif1cTzZ8/A==
X-Received: by 2002:a05:6214:2583:b0:6cb:46b4:5771 with SMTP id 6a1803df08f44-6cb46b45b01mr7123196d6.13.1727430143583;
        Fri, 27 Sep 2024 02:42:23 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b5ff594sm7231606d6.14.2024.09.27.02.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 02:42:21 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 27 Sep 2024 09:42:15 +0000
Subject: [PATCH 3/3] media: atomisp: Use max() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240927-cocci-6-12-v1-3-a318d4e6a19d@chromium.org>
References: <20240927-cocci-6-12-v1-0-a318d4e6a19d@chromium.org>
In-Reply-To: <20240927-cocci-6-12-v1-0-a318d4e6a19d@chromium.org>
To: Benoit Parrot <bparrot@ti.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-staging@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The max() macro produce nicer code and also fixes the following cocci
errors:

drivers/staging/media/atomisp/pci/sh_css_frac.h:40:17-18: WARNING opportunity for max()
drivers/staging/media/atomisp/pci/sh_css_frac.h:50:17-18: WARNING opportunity for max()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/atomisp/pci/sh_css_frac.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_frac.h b/drivers/staging/media/atomisp/pci/sh_css_frac.h
index 8ba65161f7a9..9642506d2388 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_frac.h
+++ b/drivers/staging/media/atomisp/pci/sh_css_frac.h
@@ -37,7 +37,7 @@ static inline int sDIGIT_FITTING(int v, int a, int b)
 	int fit_shift = sFRACTION_BITS_FITTING(a) - b;
 
 	v >>= sSHIFT;
-	v >>= fit_shift > 0 ? fit_shift : 0;
+	v >>= max(fit_shift, 0);
 
 	return clamp_t(int, v, sISP_VAL_MIN, sISP_VAL_MAX);
 }
@@ -47,7 +47,7 @@ static inline unsigned int uDIGIT_FITTING(unsigned int v, int a, int b)
 	int fit_shift = uFRACTION_BITS_FITTING(a) - b;
 
 	v >>= uSHIFT;
-	v >>= fit_shift > 0 ? fit_shift : 0;
+	v >>= max(fit_shift, 0);
 
 	return clamp_t(unsigned int, v, uISP_VAL_MIN, uISP_VAL_MAX);
 }

-- 
2.46.1.824.gd892dcdcdd-goog


