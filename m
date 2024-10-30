Return-Path: <linux-kernel+bounces-389596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76089B6ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CAD9280D52
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85200217678;
	Wed, 30 Oct 2024 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n+5wlwnL"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F60217479
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323750; cv=none; b=YQ6z9/GODoglP05laalN8t71tW8g5H38MGN18GDFI0zp6qnnvph56rcFPg5sns2VknbjFcptBDQ4Tde42ip9cvsztUMe/CbcHVMgLOdxh1LlMju8JPsfaGBjmn3AYWA2Tqi7/Eiu8uxpnbFn9xs5dpvc7kh2olTv814MWOMegW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323750; c=relaxed/simple;
	bh=pmjvhjw4ANaGJaaJIPAfAMKeQBbfRAJ7IKjlQWEKmyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSc5U/mfA9TV0R8/lChwWvLibM03LszzrYwuqpUYtYXJ7sAZ0rFZS4CSYro7kCCkXOVn13fnn5VVPseuq/ar40mtH2AHvbkEsLzrr5r8vLRZ1GIslm+CYA3BdEPPDB6EoNA7y0RaUGo3woFd7KmGDIuDA9utzCsrWFEqe02XSkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n+5wlwnL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so1149912b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730323748; x=1730928548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKi+NPRYmwJ2A38UY9R/topls2qQmTfhUwGCoXEdFfM=;
        b=n+5wlwnL51JeGpdUzmEOdLsoUSmXp/u1l7KD5Ei2qVQkSMpMIJ1G6rbtoMYYbChAGl
         8BKffZXmXroVpd0OmyDuMhfoJCtNZaSsFT1N5QPZL1KB4btElOwpUBOkK16QhcOu3y1e
         vkPeyjAzfmFm04Z0NqB38BVkFQcWc08BnC06o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730323748; x=1730928548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKi+NPRYmwJ2A38UY9R/topls2qQmTfhUwGCoXEdFfM=;
        b=fwOwjKJIWYKHD0Mg8zTZSly1LONGbSdDTDc6BEFdBXVms7MxBJh7nvSZKCjJn76i25
         XXHJfqNtTyfx3ObbPZcGEfdzJuaEFe0AgjRwQugUeps97qvrJXTurBX7MIDxOaRx0Qyz
         3Oa4Q/S0bzXMKBNNaDQhsDCLxYpct8edLmsnStJnObjAap+SsOOq17EzAdjXZfdrKEg6
         XrhLJlUk+vZ082YAHwbwXZy5iTr0vWpoiiYsD0cyYCbA5PUr+tI+NXK6OdlXzpY3rvGp
         IHxCzkr7wv8fHPQhKsYxhOOT0f4OjSKWILIR4lxgZ2MzQ7C60KrxMAN17VGwUsmlgldu
         0ksQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/RHcltUviFYMl3o5sCYQEU9LIkfOjeRHQmw2E5KsZR4v3Jnmz7+DWRAaed0N9aHIURSaZ5B3EV/TnlTg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvb+cOuahYO2Y6fEDDjAXVMKxPaWDd4lqqQf44A6YfrHJ0u2j4
	V6DWG1uaUQQE7kinVBDP1Sm/wGfYcim1ieaSlg8BxpgqVeVhu0DbPEnCLSsnHA==
X-Google-Smtp-Source: AGHT+IFzsx/2nziVzAA3aVi8a7q+nlWhb2DtVPBhQAAbTqwOb89dC8jOYaMI05+lY1hky0mFR4od6w==
X-Received: by 2002:a05:6a00:2383:b0:71e:735f:692a with SMTP id d2e1a72fcca58-720bd1a046amr139794b3a.14.1730323748323;
        Wed, 30 Oct 2024 14:29:08 -0700 (PDT)
Received: from localhost (198.103.247.35.bc.googleusercontent.com. [35.247.103.198])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7ee452979e4sm36885a12.9.2024.10.30.14.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 14:29:08 -0700 (PDT)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: dmitry.baryshkov@linaro.org,
	jthies@google.com,
	akuchynski@google.com,
	pmalani@chromium.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] usb: typec: Only use SVID for matching altmodes
Date: Wed, 30 Oct 2024 14:28:33 -0700
Message-ID: <20241030142833.v2.2.Ie0d37646f18461234777d88b4c3e21faed92ed4f@changeid>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241030212854.998318-1-abhishekpandit@chromium.org>
References: <20241030212854.998318-1-abhishekpandit@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mode in struct typec_altmode is used to indicate the index of the
altmode on a port, partner or plug. When searching for altmodes, it
doesn't make sense to use the mode as a criteria since it could be any
value depending on the enumeration order of the driver.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v2:
- Update altmode_match to ignore mode entirely
- Also apply the same behavior to typec_match

 drivers/usb/typec/bus.c   | 3 +--
 drivers/usb/typec/class.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index aa879253d3b8..a5cb4bbb877d 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -454,8 +454,7 @@ static int typec_match(struct device *dev, const struct device_driver *driver)
 	const struct typec_device_id *id;
 
 	for (id = drv->id_table; id->svid; id++)
-		if (id->svid == altmode->svid &&
-		    (id->mode == TYPEC_ANY_MODE || id->mode == altmode->mode))
+		if (id->svid == altmode->svid)
 			return 1;
 	return 0;
 }
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index bd41abceb050..85494b9f7502 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -237,7 +237,7 @@ static int altmode_match(struct device *dev, void *data)
 	if (!is_typec_altmode(dev))
 		return 0;
 
-	return ((adev->svid == id->svid) && (adev->mode == id->mode));
+	return (adev->svid == id->svid);
 }
 
 static void typec_altmode_set_partner(struct altmode *altmode)
-- 
2.47.0.163.g1226f6d8fa-goog


