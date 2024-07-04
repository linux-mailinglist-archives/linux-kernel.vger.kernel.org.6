Return-Path: <linux-kernel+bounces-241335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8A99279E3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91301F25985
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DD61B1415;
	Thu,  4 Jul 2024 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBoYolrH"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409421B0132
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106408; cv=none; b=Y4YUUH0DRYz0UJ8rpaUFy/S2KKv5yY+DDGJkbvjkPeQTTZTVlXkXkjVYhs1xMcG4RwGEPLJRZMa9sjXGFTDczPRVHrKzYoeRztdDwWZL8isLD0E7twTP1QasthYs0tfr5oOmeOMkO0nWS0uq7TCAUiBbSgjI4AyJqmuYvfb+0OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106408; c=relaxed/simple;
	bh=LRBnNjsH1CyBlK27vH4HjxzagefLojGK6jhHT2bCEms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IceWCq/3gnhTYi4wIMcHoB1Q/kB2OkGps6SjuD7ZzomomhlKfC2KyBiL9ea5uU1R6ZA1be9a3E6SILea7ttlIoPdwzpsTd/q6CIgupuTeP6MyMKdeMABLMpgmn3cNuWfj1PzqBJg528W9X5zyKu/PwIvEUJK3JezwR03RgVqQ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EBoYolrH; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d850109679so433937b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 08:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720106406; x=1720711206; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3dDOkW0PAFspV1Nsbjh2zbZUyCnV1dEkHmg1HqSY2cw=;
        b=EBoYolrHK3eXkZb2Sao25jmck/Pl/7AVO4kE5vMnRJWfsRHW6YdVW/k07p2yCICN2i
         vYiZjs1W9mL1xR9titcWzYBHRhioXIAP4qsEPe8Y4sAhTRTcgk97ENSwMZwuruRi7Dj5
         lV3kXswDzJA9eZsEWHsZPfn8oA09zpuQjEGRwCcf67QVIxu3P+hbeJ6i/psQXBMHWsql
         lFPnO2i4dJsNgT7pijHNXyqCCICJw3OhXFTpb5XZvHY5R9VWnXdvHy/SHyagVncHThXl
         mRPnDJEK29sn6b4CXoze0hIiyyMYqG4jDb8Xvfg9Pc1MrsthYOhKosj3N12lGaQCXme9
         DD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720106406; x=1720711206;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dDOkW0PAFspV1Nsbjh2zbZUyCnV1dEkHmg1HqSY2cw=;
        b=EFnUZ6EkeksGVeXauIDGTlAah4kdd6Z+TorEjxATv1svQxmc/XF3lUWDE3DeOj5UJc
         GaPruCQ4E71ycKejJlTQwiZyMAKHrtDgoMV3/4V+mPD/hzMQPcWJrCxUxUVRSchT3wFl
         8C6bOPEY86YVFMARhxv9FZKoWgHrm/WAnT4izdbVhhF9qP+lW59p8sTLGVGgP8Y/ML+h
         sDxqmRsVF976Mlm6szkZemB7dWStgW8JbLzBDFqaS3/AsibAzu1i4L8PV6mxgCmAi0KV
         Gd0YLJTk7IAHCJFCpZFFAgk4Mnr4bAiOW+RGK+3DWk55O6NTqXEyG9hh1UqOH//OJaHw
         de6g==
X-Forwarded-Encrypted: i=1; AJvYcCVroGUNKJiwYr7S7VFgDaQfV1V+zuqezIMABAqhftpO3uG81gdOPzX1GDyvX8LKFsFrcYVaS2y8Tth/GVGRYR8DrABwyHXaVy/7e7SD
X-Gm-Message-State: AOJu0YwD7qOhJxTbTlZp2xvbGbOKznxSSxtrT0Ll0NxU/UJqYtqJ3kQq
	hTRNdw//0nyB5tNq8GrhDe3cSueUWIMztEfId6uk6gF+2qcZzmExjiGsSAVPr84=
X-Google-Smtp-Source: AGHT+IHHk3pE4TLFr7KRVvJS5XlXRIKfpvIedOe6u7433gzwuERp8u/tr3qO5KeYVUGyta7Gx3L7RQ==
X-Received: by 2002:a05:6808:1404:b0:3d6:2bab:16ca with SMTP id 5614622812f47-3d915b0c6b5mr771492b6e.13.1720106406264;
        Thu, 04 Jul 2024 08:20:06 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:96a0:e6e9:112e:f4c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d62fb41f77sm2484567b6e.51.2024.07.04.08.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 08:20:05 -0700 (PDT)
Date: Thu, 4 Jul 2024 10:20:03 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Sebastian Reichel <sre@kernel.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, chrome-platform@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] power: supply: cros_charge-control: Fix signedness bug in
 charge_behaviour_store()
Message-ID: <ZoWKEs4mCqeLyTOB@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The C standard is vague about the signedness of enums, but in this case
here, they are treated as unsigned so the error handling does not work.
Use an int type to fix this.

Fixes: c6ed48ef5259 ("power: supply: add ChromeOS EC based charge control driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/power/supply/cros_charge-control.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
index 73d7f2dc0fa3..3183a13eefd0 100644
--- a/drivers/power/supply/cros_charge-control.c
+++ b/drivers/power/supply/cros_charge-control.c
@@ -204,14 +204,13 @@ static ssize_t charge_behaviour_store(struct device *dev, struct device_attribut
 {
 	struct cros_chctl_priv *priv = cros_chctl_attr_to_priv(&attr->attr,
 							       CROS_CHCTL_ATTR_CHARGE_BEHAVIOUR);
-	enum power_supply_charge_behaviour behaviour;
 	int ret;
 
-	behaviour = power_supply_charge_behaviour_parse(EC_CHARGE_CONTROL_BEHAVIOURS, buf);
-	if (behaviour < 0)
-		return behaviour;
+	ret = power_supply_charge_behaviour_parse(EC_CHARGE_CONTROL_BEHAVIOURS, buf);
+	if (ret < 0)
+		return ret;
 
-	priv->current_behaviour = behaviour;
+	priv->current_behaviour = ret;
 
 	ret = cros_chctl_configure_ec(priv);
 	if (ret < 0)
-- 
2.43.0


