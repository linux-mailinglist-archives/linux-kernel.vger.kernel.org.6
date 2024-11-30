Return-Path: <linux-kernel+bounces-426174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5D79DEFD9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 11:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2E2163030
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEACC156649;
	Sat, 30 Nov 2024 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MZTWUD4X"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D10D1537CE
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732961305; cv=none; b=hqg/PaJqL0PtSr5pHBKlaPZUsnxvE734DjzoD+BypXwjZH6GXIcdsXfUObrBo6MI9PQ3rFLSJL07gxuOI3qvPYY76DADL/C4ZkSEgGhMnaVvBvFQ6kYL9vzYQwA6XHXuhg+L2gHjM/Ovw29K2AcKFclmibWxkJHkvRyHvSj91GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732961305; c=relaxed/simple;
	bh=yGN0skpZCH/XVXgf1QIShlnVw3a2xJjULCwKrnqKSg8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PxcYc2JSjpFwawBdWSXULAz/xBEaluBN1uDtW76YoGRu9D0etIrPh/pH/DeVRfMfGEoeArb1bBLjlptYdxMYRoZN+YQt1OtXSOpJLodC3bYNLE7KIVu9An3jt1wbQObOH7LMOrT37S605tg+JkEtsfav+Y+3NLuA+TyFbUWRs9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MZTWUD4X; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0c7c8cd6cso1004325a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 02:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732961302; x=1733566102; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Foltdq1wnJptf4CLVy8W4RVoCPqvSVXILCEAnOfXokg=;
        b=MZTWUD4XrpdcLOOg/ncjq550IxAEH9fos0PkNXiSDMfZIBB7EouCckfaKvw+SQvniv
         6BIYMzLjh7/OzNTCbdcXSd00o2z0JkDLP0ENn0KKWU/iXu98W+4j853c5Y1495fUPVly
         tCid7j6+99WpmrAbECIy5MUwKD0buQgnG6CvK6fEv7CwtdE5HSSL2E+kV8tjx1mdBmEF
         mbAQepSnwTujAaZX2EY9WIlXaXk9LRqudY/Wc3nRTQUGq7Wvw+TikBaeRZ+XAeVh79PX
         Qd60dv/o5jdJBs1vttP2+jjy5DiYRboAjOAGn04LfrO9VjIfcaadXLVgbTSGcvYy6M34
         mXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732961302; x=1733566102;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Foltdq1wnJptf4CLVy8W4RVoCPqvSVXILCEAnOfXokg=;
        b=hIsy2GUvOYVjjmXPbor3lU6P1bhlDcVNzrlLTWbtC9AAK4pM3s1poBGwqUeH9cT40U
         +jr9b+yjqxQ4O5h62W7GQMfBmwmHI0xbbvP2My1qRZUz+/kky9RK9CHRDNtjJinTPPvh
         ag61mlo0E/I4zUMuX+ZfWwO2BEYlWM4O8f/seRbPvHYyzLuUoylq9CfCzPQo2d68xnP2
         5fFFRd6g+09Y+6iIORXXR1UXa7WupOeKkGS05iAEEYvQT4Glij5GIATVaqIZ4CxhahLl
         aEAn2K0awYdWKDCl8JuLBkjkH76Df7N3oEH1XonXgZWJGyP+m4wDgytqqLMryTGvzWqy
         G6sw==
X-Forwarded-Encrypted: i=1; AJvYcCXtLLJI0jZt33dY+xrAHqxCFgw1n2iwrAenr1V1KnfGIIot1ZOIFyi9qrzoqhdRprRlShDr36tXHS28jp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy4XtBzoUhVdUNP6W5OnXe/LcNvbOxZNWok9IV9k237VghB2e0
	Z6SgGmxJTsafPdobXVIfMSuFqY9js49/yjO7dBHtRdkyvL7ZuZ3dRu2LPqtVpGQ=
X-Gm-Gg: ASbGncsT+HYA2TmKjLPxOEGqepcBbpOavHhQlPxaIppZIRKTWAsEqLMJ5Xz0VXENsZb
	SLKwI8KXj/eJHEkQevGJsNjgBRMr1Svk4TMCLnWgcYsdmmKV+4b935B/rg2h+X5Hj9HRrgvNB7H
	ULMIQ5tiJPThzwLwoh3ityslf8HsvpXgb8Nyy15AQzQc+RgnomMC+sYVuLA/+q0B77tb1lDkyzD
	RwNt4b77/EKo1DetebqfVx/AWjyObeJ+kpgClq17s5YYjgs4ZyZYSx1QjmRo2eok6VmO4a+
X-Google-Smtp-Source: AGHT+IEpsOjTRBw3ZIvPknkFFjSqYnH4ouKRAqfBsVsF+pma6HwTEfCu8fT9yrQ73+MialO52y3mFg==
X-Received: by 2002:a17:907:7615:b0:aa5:358c:73af with SMTP id a640c23a62f3a-aa5945075fdmr1341277966b.6.1732961302097;
        Sat, 30 Nov 2024 02:08:22 -0800 (PST)
Received: from localhost (h1109.n1.ips.mtn.co.ug. [41.210.145.9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a79bsm264809266b.151.2024.11.30.02.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 02:08:21 -0800 (PST)
Date: Sat, 30 Nov 2024 13:08:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] ALSA: hda/tas2781: Fix error code tas2781_read_acpi()
Message-ID: <ef773f8a-a61d-478b-9e81-41a38a75c77b@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return an error code if acpi_get_subsystem_id() fails.  Don't return
success.

Fixes: 4e7035a75da9 ("ALSA: hda/tas2781: Add speaker id check for ASUS projects")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 sound/pci/hda/tas2781_hda_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 45cfb5a6f309..8ec03bda85f3 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -143,6 +143,7 @@ static int tas2781_read_acpi(struct tasdevice_priv *p, const char *hid)
 	sub = acpi_get_subsystem_id(ACPI_HANDLE(physdev));
 	if (IS_ERR(sub)) {
 		dev_err(p->dev, "Failed to get SUBSYS ID.\n");
+		ret = PTR_ERR(sub);
 		goto err;
 	}
 	/* Speaker id was needed for ASUS projects. */
-- 
2.45.2


