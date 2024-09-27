Return-Path: <linux-kernel+bounces-341594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C6198822E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4157A1F23687
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686081BC063;
	Fri, 27 Sep 2024 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WxQPytC6"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BBB1BD01D
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727431370; cv=none; b=ctwHbo4MyZFJxTNCS7fMyLMmSrLsITzSCGXqOSKaFFjcBl1g9EF267ifdCb0rh/ixBly4mtzaxaQCJzRCK4LYNQCzSIhjN9lrgVgUs6amWc8fAEIJzaolSwkwMXz18V8suUsFoITnBuSmOoZoUnCiQ2qbWGIJJDnMEfQB8KVW54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727431370; c=relaxed/simple;
	bh=uw0K97JV9fivxdnVN2cUQwyp6nbgfNRKN3h76jkLFYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lCULFzq55HSBWsGcK/j9qQI+CgS/GyQiJwXb+19E64Ep6wjoOHhZ7AuqL7kpoAxEVSDJn0sMUIUa6alanYDYKIfwJpEWRy7DHcRIXSLhLjzMqmWcaTRc84DnU+xHiOGbp/l6MRvLiA/1kjsx3+8LakmIrHWpt/VQAe+0mFWNsL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WxQPytC6; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cb29ff33c5so15746256d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 03:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727431368; x=1728036168; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSjw1khDQimJSSBzxeMp5r4khGbQqGrktSmSipAyKGM=;
        b=WxQPytC6OZ04vlGKZs5Eg8aZM1+av+9SLcNLIeygjg1vxW5uOCmI/2ZvUDtUr/6Zcc
         NM9ql9qHlbmWUxxFRnGnhP71ses9FDo5Cqi6fdHGWN5CR6vM04i5aVlLjiZmxk4ZaQmF
         O9hbm/zC4b4QeqRFoEVRs92NUW2JEmeTY4gN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727431368; x=1728036168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSjw1khDQimJSSBzxeMp5r4khGbQqGrktSmSipAyKGM=;
        b=Kl08Ko4ZjetszP+SUtJ+Sl2jlubuTep7vPnsEfnp2LASL98yF3dA9WY0XATvR16+jZ
         IFUK30TzmyAdLkW/WyIUEykjRNvVvaJEi2xiFR71Td+tijKTz0281aS+Ddnt2jvFI2No
         yp+DRDjQ4BmikqQM2fMDrSY+ueAGUrxeDjFTsqf97P3Uy4R42uRA82Vmm2L3IBy/lv2r
         18w5gTJKYgt58YAb5ksg53GHHesw1I3GWo84IuaPkqbV8rR6B/KSTrVtb/c0s2YLOObB
         WLOeip10KUGoKz4NheLUTbiLjZMRGFj/EX5g5JADKPy9UK6LYe/M4cc2QIj66G0KDIan
         SPTg==
X-Forwarded-Encrypted: i=1; AJvYcCX/pELBHW+tUpXbTsSalBjoxA9781lhSdmImNGwbkCY9mHM8k0S8QiG+5xbG++BfqKnwXzNLhx6uxS9hbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaxsr3nNvhjyyXMIIlB1Ao1EmyG41uVX/Ygid/klpnRpLxps/q
	Hpzn/zqddFwLrHgcruG9FoeHkKuO05wl5rff1S78JQxyUm8ypw53pwA/T9/z6w==
X-Google-Smtp-Source: AGHT+IGmj2VIw5fwcR7lMfdlhGfeKlUZ5ZB5sGNgsSChCVQ89YCG0Pdjs36ucyYbgh9Wu38SUEf4+Q==
X-Received: by 2002:a05:6214:3d8a:b0:6c5:3123:4efd with SMTP id 6a1803df08f44-6cb3b5b663bmr52445036d6.1.1727431367752;
        Fri, 27 Sep 2024 03:02:47 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f353f08sm6341091cf.94.2024.09.27.03.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 03:02:46 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 27 Sep 2024 10:02:34 +0000
Subject: [PATCH v2 3/3] media: atomisp: Use max() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240927-cocci-6-12-v2-3-1c6ad931959b@chromium.org>
References: <20240927-cocci-6-12-v2-0-1c6ad931959b@chromium.org>
In-Reply-To: <20240927-cocci-6-12-v2-0-1c6ad931959b@chromium.org>
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
 drivers/staging/media/atomisp/pci/sh_css_frac.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_frac.h b/drivers/staging/media/atomisp/pci/sh_css_frac.h
index 8ba65161f7a9..3191d2858f59 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_frac.h
+++ b/drivers/staging/media/atomisp/pci/sh_css_frac.h
@@ -37,7 +37,8 @@ static inline int sDIGIT_FITTING(int v, int a, int b)
 	int fit_shift = sFRACTION_BITS_FITTING(a) - b;
 
 	v >>= sSHIFT;
-	v >>= fit_shift > 0 ? fit_shift : 0;
+	if (fit_shift > 0)
+		v >>= fit_shift;
 
 	return clamp_t(int, v, sISP_VAL_MIN, sISP_VAL_MAX);
 }
@@ -47,7 +48,8 @@ static inline unsigned int uDIGIT_FITTING(unsigned int v, int a, int b)
 	int fit_shift = uFRACTION_BITS_FITTING(a) - b;
 
 	v >>= uSHIFT;
-	v >>= fit_shift > 0 ? fit_shift : 0;
+	if (fit_shift > 0)
+		v >>= fit_shift;
 
 	return clamp_t(unsigned int, v, uISP_VAL_MIN, uISP_VAL_MAX);
 }

-- 
2.46.1.824.gd892dcdcdd-goog


