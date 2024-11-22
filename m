Return-Path: <linux-kernel+bounces-417909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DD09D5A9B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFB8282B66
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7703189F32;
	Fri, 22 Nov 2024 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jbtec3hm"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB36518787C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732262688; cv=none; b=WNiuJHOtAbvSYpNxT8YAcCB2YdD85iKuMEdS9EHHVZJ5hYrDJDbSyTTT5C7YoXgzVorU75W7ElB3vDdsgC5EyINNTeX6/Qt58xnBxkaE971+M2iyfBktIk+YKaNcPqEUfzCK1jURiR7m2z2YE5NTK5r4Neb23mx9e6uRCZlY0lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732262688; c=relaxed/simple;
	bh=KMMNvpSUMBgpLJwpRYLirsu56PRoVQHdFKvZp8gukOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=flytDhB7eyCSgiW6TC1P2Hs3su6/5UB68+sMxhB1w+LtDwi5m53mFd7qrN2Jk2bOtGHpORjL4D6qbjKTJ+wa6tMwSxUkMYh2P3ugZhBEzAeBJmZPd1O4jj8b1pbS7fQCtbrq72Xnrf2WkrLR8b3AgBS4iAukdzfnUvsSTRIEfZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jbtec3hm; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460a415633fso10309851cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732262686; x=1732867486; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nRSEsk+jnxtZC+QBMSM7CyE8fqgmSJ2RND/ZUIbuhQs=;
        b=jbtec3hmvvub1DXKSDjT3ALLdVidIZKATxdhR5jYi5xnZ0KgYiK7D+fluKkEZyqG0z
         5vC8tXUdhsx0ry1KAWnKkh0HlhcbuLfGcp0IzX8bHZff7yHmBSVrfG525RZbtO0C6dBR
         mHNZEUdXxe2Tm3Lk1odHYbje7+YJuVM58VP4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732262686; x=1732867486;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRSEsk+jnxtZC+QBMSM7CyE8fqgmSJ2RND/ZUIbuhQs=;
        b=Es29w6aCCvUIETvXDt04IzMVS2j4qwM0oHWEOkarDk7/SlS1jv5TwBXHfscziqzPfJ
         6H/0zK1NVrPvcWn7NvT4d4AaVLDYFiFMIvQ18NXWdEPiFo4j3IJUw7+cpl/Hzz/5i4QX
         0biMEDpFKR38RZJs08HvAkizgkmYsmMkwVDxxjMnc6zpTcGxiHTxNZEyaMqndx8GCCpm
         Tc8520szu46pVRLu15kCy7zEdl9sX0ss5fwRDIwS0sCPsdoMi4Hfxy/3+cbwPXaf2h1N
         uhPa3yTyzG/iZYAYglRHEY7PUWfRuW5fM0OX3D+q28tuYYuu15nGQ9iLVQP2Z7J0yR8f
         Qqtw==
X-Forwarded-Encrypted: i=1; AJvYcCVTS2URsLhpfNYVbxqRM3+VEBwP9YK2XNAT912NWmiPZrFpi952Ktth1JIGUjzR/U9TfyPLRwL0iIjTS3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0x386dE42b5HjtkpM38YVm0kIbzae4KWkhSl/GlUfjbC4GeSe
	6nJE8yEmNzmpoMTX4Czun7KBC842w1n3PRus0AtZAperdroa4W60vj0r82r90A==
X-Gm-Gg: ASbGncuEcszgKZnkzJR5Gc0+s8j4QoPK9sDG6wTR4xYhpV02eYtOVOIo1bXIuJGGFXU
	U7uCFXf/GR79nW2epovEesle04FxlOKcjQHP5tvXxyNTWbln8ertoUWGtkySIW9/T93mKg2fDla
	IWRWENXjoa9+HVa0SSFG7JE3FFuxrcHQouCQ3UMOKVE8GqLCDJgw/lZdV5HDwn0OsZLQBrcCEMF
	htTEvHKTfRP5Pq3HHGQGQFV5k/41anGkkM0GmYeVrEhK2Lv25OINNXyYIgwdQltRSkhTPUOeKJ0
	DzDs4LffvEmGQmGrqaJ10SMC
X-Google-Smtp-Source: AGHT+IFRpRVmK/Ci1GiF9yVhFA6k4CWLrX0LrX2/0uhY5wmo4O/l6ydSGyOikiNPDsrYICpyDxTahg==
X-Received: by 2002:a05:622a:4a86:b0:461:17e6:27ae with SMTP id d75a77b69052e-4653d5a6b9cmr29910881cf.24.1732262685728;
        Fri, 22 Nov 2024 00:04:45 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c3ee43esm8570451cf.22.2024.11.22.00.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 00:04:44 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 08:04:42 +0000
Subject: [PATCH] media: ipu-bridge: Fix smatch warning for COMPILE_TEST
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-fix-ipu-v1-1-246e254cb77c@chromium.org>
X-B4-Tracking: v=1; b=H4sIABk7QGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyMj3bTMCt3MglLdRKO0VCMLSwMLSzMTJaDqgqJUoBTYpOjY2loA18M
 e/1kAAAA=
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
throws the following warning:
drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented

Fix it by replacing the condition

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index a0e9a71580b5..be82bc3e27d0 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -774,7 +774,7 @@ static int ipu_bridge_ivsc_is_ready(void)
 
 		for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
 #else
-		while (true) {
+		while (false) {
 			sensor_adev = NULL;
 #endif
 			if (!ACPI_PTR(sensor_adev->status.enabled))

---
base-commit: 72ad4ff638047bbbdf3232178fea4bec1f429319
change-id: 20241122-fix-ipu-a2fe28908964

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


