Return-Path: <linux-kernel+bounces-341550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 268FA988184
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 909A5B22E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3A31BBBE9;
	Fri, 27 Sep 2024 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YGXwi1ry"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B015B1BB6AB
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430144; cv=none; b=a0DHe61TIcdwHm+AjRRF0MZdWi9hGybEdi3sXCnIwU1HsI8kK5j2RwR7Li0jqmyq1VboKg05SHT3hvjxJpJnNkyFPGVbFbljeEEkN2iAJavsKQCAch5tGV68OmdAEXvKsBRRgCk8ZX0iMzVnuqoRN4fhgMv0lEoBz+QEeg3Vt2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430144; c=relaxed/simple;
	bh=kCl1YSqZuUUZDtGA+QAZtwsRUo5HY0IPZiSWxLVmfm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qwAPCEhjfS7vcatM6wX3oE9fQEf8+3bm5pBjvVnteSGTA4LkAKBCKMvFkFHTajJzKBn8ldywYBHiF8svGhGHM4rYKX3nmMw2XVoR6je87yHhpxPhS9kJPTPu1+bpgCz17G2SkLsbQ0STgXjedraW6ALNzOniWt0ZxZqBKxl+17Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YGXwi1ry; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cb2aaf4a73so15917986d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 02:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727430141; x=1728034941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VINaQxL9vW722McPbfM1p2Q0+fZYKttm/dJVtWO/GI0=;
        b=YGXwi1ryz/iwZd1v/SFBTCTDFiXFExify3cBGmCo0OfzMABIMNt60KaPc7ASh7PzaN
         ZowxDlIk11m91E/gw/vahA2iGqFR4R4EAmyfhCdIQp5NdNLa692lCVF51/NXxMz0LI7+
         Htdhwr4ReSp+veUnh6GLRHuwURaquvGVI3hK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727430141; x=1728034941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VINaQxL9vW722McPbfM1p2Q0+fZYKttm/dJVtWO/GI0=;
        b=cH5oOX07w3/8yw6A5GB1n8OAoOWibqwV0QigaNLdVvtjIo7D6S6+n5WFN6LasW+B66
         JORKNZCCKyr8/d9yCPHUoAt8IjcJZh1ua4XS6T9X/CnFjsw17OG13o5JoF6RqnVKIEkz
         57Jv4kOsDMhA/7cshIOAZKee9VVI7GPpbneuKZF5tZ+dI3LmCJcx6vQqvwL2z2DUmxtn
         0NAehSlMCIUvaSvhG7n1Djp0iEUqsxZo8MYQhXWe7IpGe9Kz2v+z+2lt+fZ+Dy4f5O/Q
         bMaAmuevNpWp+X28rV9ATF0PZ53irVAu/+If72yZetHq9FMx+b+ab8UfTHHIqQw1oqRj
         8bzA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ+SZOa4lUkYjgRuMd/igI6c1k9hXNH3+UFtlIXGxBQ0SBc2Qc8tkBdkLrnSjD/PtSMP0Wbv2Wyeab2i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YysbOaLyOHP+zOpuvzRbMh6+GMIf6atEKfi4Olct1SFjdKrUX10
	LyalsVAWECmqBuKUHHeRJxasu1LFcyfde5CCN1Pxa8VDYgFLPFnNHBH5Zunqww==
X-Google-Smtp-Source: AGHT+IGGsdMZl/i8EG8b5Z1JmOsFAyZ9WklfULMXZz5d7lRQYLgXR1nLV+QVTf216ds3TwRWII3bkw==
X-Received: by 2002:a05:6214:320d:b0:6c3:5a89:9998 with SMTP id 6a1803df08f44-6cb3b60fa9cmr33792876d6.23.1727430141573;
        Fri, 27 Sep 2024 02:42:21 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b5ff594sm7231606d6.14.2024.09.27.02.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 02:42:20 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 27 Sep 2024 09:42:14 +0000
Subject: [PATCH 2/3] staging: media: ipu3:Use str_down_up()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240927-cocci-6-12-v1-2-a318d4e6a19d@chromium.org>
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

The str_down_up() helper simplifies the code and fixes the following cocci
warning:

drivers/staging/media/ipu3/ipu3-css.c:229:18-47: opportunity for str_down_up(state & IMGU_STATE_POWER_DOWN)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/ipu3/ipu3-css.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/ipu3/ipu3-css.c b/drivers/staging/media/ipu3/ipu3-css.c
index 1b0a59b78949..bb22375481a0 100644
--- a/drivers/staging/media/ipu3/ipu3-css.c
+++ b/drivers/staging/media/ipu3/ipu3-css.c
@@ -226,7 +226,7 @@ int imgu_css_set_powerup(struct device *dev, void __iomem *base,
 	state = readl(base + IMGU_REG_STATE);
 
 	dev_dbg(dev, "CSS pm_ctrl 0x%x state 0x%x (power %s)\n",
-		pm_ctrl, state, state & IMGU_STATE_POWER_DOWN ? "down" : "up");
+		pm_ctrl, state, str_down_up(state & IMGU_STATE_POWER_DOWN));
 
 	/* Power up CSS using wrapper */
 	if (state & IMGU_STATE_POWER_DOWN) {

-- 
2.46.1.824.gd892dcdcdd-goog


