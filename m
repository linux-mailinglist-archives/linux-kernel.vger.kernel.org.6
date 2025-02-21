Return-Path: <linux-kernel+bounces-525165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AD1A3EBEB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17AC119C5B48
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 04:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200D91FBC9A;
	Fri, 21 Feb 2025 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TwdRa2E2"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B251CD1E1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 04:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740112830; cv=none; b=kiIVwnJUK9M7Hj1CqtjdjLi+/BpobCXjlxEVobSeJZSTfPV30D8oZy7QoWOWq3I+u6lXjlybDKLnGVNrxlhJ5gA6vAH6pbvqE5rmXihNJy4rs+fTC18JPwFkiNI2AukW7GC1BJe3PgW5Idr+G03LD6uDa3imn1K1lo5nxI/v6VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740112830; c=relaxed/simple;
	bh=A370FwgmOcGxdQpV0Y3cC3Eh1VAs/X7rXfoHTYBE+vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c27XvsiF9qBSzzt56ciSFmhkoiEDbGwIqW8OKD1iRDWvUHj4JVeGytsvGoQADSKtsDs9+T8Mw/t1hThOnfEFhqZ/SfeJGBL4o8b7aEEAt3UJOmwbEbTOCUKYnrZVQv7+S8sWjT7nffWIXFduaCs1UFdvJula6WtMbe6yXcCar4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TwdRa2E2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4399a1eada3so14441565e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740112827; x=1740717627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dUxQ8JHeZTOHPECNht+upnWJNGmFSV4ta5CH2/NFhzA=;
        b=TwdRa2E2FgdYdAtyqMcPFqPuo0MSIr7+RJaRe4wls56hcgiWr8Y/NKCQhViJ8mcxvZ
         tsyI+5t8ZhSEDFXUmrKoKijK+p6N6ECwfzWYSeiHFc3Vb0LeGA/0VVsIvl0s9XCQJSGC
         iKiDx7/V1p+u4/ImWVaCjqkqTIOr8QTFiXvDGaPo9oPvXfzyYYwO5Afk14SexuLMkM6g
         5NgjukzjXAD+Z7+J7P3pFMv0INDG4xeng0RSUnhrfg7UaGpWY0JUwUDlRjdKul8+un6C
         ZCKENt0oniKziiLGEZaLUIHybIVNLr/njTb3uhQQICKQdauOnANQVu5w81oqdOKm776o
         P+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740112827; x=1740717627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUxQ8JHeZTOHPECNht+upnWJNGmFSV4ta5CH2/NFhzA=;
        b=fQqjG/f8rzhhjAZP5I1YcmufldUprYtc+9wBKBjlm90H4tlFP6+DYASQ8rw0CPXe0a
         Ms1UKPbmPmoMknc+FFau6Is38ozWButXDkUPV29m0J6T57TTotmi8KsCz4YAaij0hzFc
         7U4o04osGHecvwWDTe/+TdotiLw07SxPSaF9X8NwoK61DlKTVB9FsWbSvaF7BYmrHsrB
         3RfcrdxY525fGsNBIUf7sJUOCJ2cDqken8j3rBgjr+rjsmUGe99siv/CXxwnPDGfXF1l
         Yg2bc58qiQkoiwmUGj1MvwpP581IM2roc/LZHAzdxZWG92qbAXFKGDNZBOcZPR7W2rQb
         6Mpw==
X-Forwarded-Encrypted: i=1; AJvYcCXyxhIcTZ1ZXpn+ch51LA16FUyoz56gpgg9LsoC/3WtLTOOEzqpznhGgGHkUwxC9Wwqf/n3mTiu53Gf794=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywar/rdby20/jPfm+4ubMZMG4fQSCJY5RnDr60USrY2mt+W0xB2
	Xi43D3AoNyGrnnS4HIPZ1CZoY5z3lZ6HeuvMW8QN2gIoDLq89u9Adg5xfacvr6g=
X-Gm-Gg: ASbGncuhqBPx9zSKcIwFaWNAKgEJfRFloJKMRQv4RlH6iQTS43OwMu87sfWQsLgZXmd
	2eXDT1y4LCuVPWFW/e1DUmIiXkRLWyf+BNBCVmVfdLImJ2Ml6gFwdmi2H2BwRUTwB5iwUe6bzsq
	doyTOG3heTN7krZWC0teCidLzLZqUJjbC1NuqtZuwlqfXTM5kwiCFjVITd665EB5hGeQPSnE6Ne
	Z1QP+G1DD1C1O6qdwJQGZju/ZGytmtk7z2GwTvupWYkrHqA/cEraHK2846ZN/Fs5hohj4a5KSaC
	jSY0lFxk4NnnSsxD9l69FBMc0lmiZK9zwx76YnhywfiX
X-Google-Smtp-Source: AGHT+IFZX2tGs3D96ENsDWlpydZ+9vz8q8gMCtR61BTdHRxHTAdwzjKTs3WtllXebpcvU3jdBD83Ug==
X-Received: by 2002:a05:6000:1546:b0:38f:3c8a:4bf4 with SMTP id ffacd0b85a97d-38f6e7561cdmr1272842f8f.6.1740112826930;
        Thu, 20 Feb 2025 20:40:26 -0800 (PST)
Received: from localhost.localdomain ([2.124.154.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25915688sm22618671f8f.57.2025.02.20.20.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 20:40:25 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: srinivas.kandagatla@linaro.org,
	broonie@kernel.org,
	lgirdwood@gmail.com
Cc: krzysztof.kozlowski@linaro.org,
	abel.vesa@linaro.org,
	neil.armstrong@linaro.org,
	perex@perex.cz,
	tiwai@suse.com,
	jdelvare@suse.com,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH] ASoC: codecs: wsa884x: report temps to hwmon in millidegree of Celsius
Date: Fri, 21 Feb 2025 04:40:24 +0000
Message-ID: <20250221044024.1207921-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Temperatures are reported in units of Celsius however hwmon expects
values to be in millidegree of Celsius. Userspace tools observe values
close to zero and report it as "Not available" or incorrect values like
0C or 1C. Add a simple conversion to fix that.

Before the change:

wsa884x-virtual-0
Adapter: Virtual device
temp1:         +0.0°C
--
wsa884x-virtual-0
Adapter: Virtual device
temp1:         +0.0°C

Also reported as N/A before first amplifier power on.

After this change and initial wsa884x power on:

wsa884x-virtual-0
Adapter: Virtual device
temp1:        +39.0°C
--
wsa884x-virtual-0
Adapter: Virtual device
temp1:        +37.0°C

Tested on sm8550 only.

Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/codecs/wsa884x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wsa884x.c b/sound/soc/codecs/wsa884x.c
index 86df5152c547..560a2c04b695 100644
--- a/sound/soc/codecs/wsa884x.c
+++ b/sound/soc/codecs/wsa884x.c
@@ -1875,7 +1875,7 @@ static int wsa884x_get_temp(struct wsa884x_priv *wsa884x, long *temp)
 		 * Reading temperature is possible only when Power Amplifier is
 		 * off. Report last cached data.
 		 */
-		*temp = wsa884x->temperature;
+		*temp = wsa884x->temperature * 1000;
 		return 0;
 	}
 
@@ -1934,7 +1934,7 @@ static int wsa884x_get_temp(struct wsa884x_priv *wsa884x, long *temp)
 	if ((val > WSA884X_LOW_TEMP_THRESHOLD) &&
 	    (val < WSA884X_HIGH_TEMP_THRESHOLD)) {
 		wsa884x->temperature = val;
-		*temp = val;
+		*temp = val * 1000;
 		ret = 0;
 	} else {
 		ret = -EAGAIN;
-- 
2.47.2


