Return-Path: <linux-kernel+bounces-445714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256759F1A38
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EAA2188E0D6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5041C3BE1;
	Fri, 13 Dec 2024 23:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kPq9dz6y"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C575B1F03C3
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132964; cv=none; b=PExwp2tyO2G0LY+BOcVDkfWvQc2mbocxrLlCogfJjSDInB1KPkG5XmlNSSOEVaTk/Fa82S/5ANmFiu5sLgVZ9sahqrYw1w5PYtCJ8aGZ0K6g04g3N5TL9A6Fr3Ar8p/VAo0WFvGL1VKbsXWAlYQpLbOFwMXRDd4azwMbS7VXJHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132964; c=relaxed/simple;
	bh=bC3ASIgFU8+jf99/fkIhb8slZurZDJG8FhuOc/gydBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCNzx1Lp3IQwEdbwbvG5WLmb52OTbW9cLrlGBw1dTkgII6ghJ0vyuJCChR8AJw9k6tqohnOpC+KHw+wZx3e+fi4+jUoiATKnP5OoeIaU/VZWeockVykjzGOm1jVQu86H47pZXoaSvp7TjMh8IOeDSWEV8jlKi/yLwSr57x6R5+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kPq9dz6y; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21644e6140cso21424055ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734132962; x=1734737762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=py5tiwOmlBmtYEMtNIBu6hO+Zuc2fcdnOeR4Wv1Ac/o=;
        b=kPq9dz6y5F4r0Gis/Nu47Ijapv2cj0gnf1sk3YOtiH12roAbUzDby5rf6EXj9Q1nQ8
         y+DhzaDOS4bnDEE9OeS0fyB2OjFFAfShSHdeEAqNgfD63ayLLlf5J7S6KfqiVgfocgJ9
         YALeBP66RXvQfR5h/xu4R8QULqoDeUp+x2OOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132962; x=1734737762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=py5tiwOmlBmtYEMtNIBu6hO+Zuc2fcdnOeR4Wv1Ac/o=;
        b=iWpxB0B+rXJ8Z12vymLOq1/5p4iBpUOCN6p9ykptqf4Thsfj74q4WWFlwSpH6nSdZJ
         KoZqM43QEDDs9o/p7M9BO8YJkJt133a/GV9K2zS+gIMDsAsrf8yTFsbcHrFPWLE5qfzR
         n57OHPiuZb9sHctp86HJMsbzxHicHpm7+M9hCmKbvOy4IDZG83KZMp1KLKnqJrp33E2k
         2dUo9BA/OS2T14nN+mp4TLT/nrE5XikP4S1HLoUe3Rv1Dn2OP8aeTu14I0BKlcEaKZ1S
         uaMG6VUR9oWmAZZIuC38qEC29YCcnzpaN1Nzc8I4Akb+/BXdLDspxEhe94H4/KytKFTY
         DuUA==
X-Forwarded-Encrypted: i=1; AJvYcCU+ev21Yj7xD/olwVP48c+Kid2IikFRLocwpXe9eW87HV3IxHoyjoCcPxHr6tjvmpjeeY6mQb1eU9z0ZVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXzbl1VvIcmxf5JblVTZA+mSuXQkzzrdFdBXMUGoikt1LLdAFY
	Vh6lSMzgt7CKu/6H7NuQgyecPW0+lfZkxSm4UkBfbmacsTt3VadQCoc9DXCfKg==
X-Gm-Gg: ASbGncs379Unf6Kqq3Z6+fVQeG7XjF7NMTQpJKXRbtkhlWFXAarr6GBCqb1lXFjdsQA
	Bc25OM6kvvBoJdH2omMEbphnFrREjz4m5SYVo6ErR8uR6cVGvK6Hvth5wyeBzi0Lx86l4M0gDLp
	nvHRaUbkq/Wxqf7c+ss71me8gkTeX1tSG8uPYVQ0UIIAa0i0iAvIbbMiyUVw9QPwAi0uNbyMJmo
	BKThODggciHOWgo+eiWjhi3tsXrHawwpOuR1bJTrg8APzADGqFM0vb/uvFpBbCSgCI2org6Oc+L
	PJc7aJOJpeC13aixpU8SusOefkrBUn0=
X-Google-Smtp-Source: AGHT+IEUZ/6o1cO9iUcIyo1p1TtmFetHKWo3k/+ZY2PI6TucwmSTRM8JHLezHdDWh5JZ20Y9zHM9uw==
X-Received: by 2002:a17:902:e890:b0:215:94eb:adb6 with SMTP id d9443c01a7336-21892ab81demr76675885ad.40.1734132962220;
        Fri, 13 Dec 2024 15:36:02 -0800 (PST)
Received: from localhost (227.180.227.35.bc.googleusercontent.com. [35.227.180.227])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-218a1e5499dsm2824495ad.126.2024.12.13.15.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 15:36:01 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: heikki.krogerus@linux.intel.com,
	tzungbi@kernel.org,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: akuchynski@google.com,
	sboyd@kernel.org,
	pmalani@chromium.org,
	badhri@google.com,
	rdbabiera@google.com,
	dmitry.baryshkov@linaro.org,
	jthies@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 8/8] platform/chrome: cros_ec_typec: Disable tbt on port
Date: Fri, 13 Dec 2024 15:35:49 -0800
Message-ID: <20241213153543.v5.8.Ic14738918e3d026fa2d85e95fb68f8e07a0828d0@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241213233552.451927-1-abhishekpandit@chromium.org>
References: <20241213233552.451927-1-abhishekpandit@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Altmodes with cros_ec are either automatically entered by the EC or
entered by the AP if TBT or USB4 are supported on the system. Due to the
security risk of PCIe tunneling, TBT modes should not be auto entered by
the kernel at this time and will require user intervention.

With this change, a userspace program will need to explicitly activate
the thunderbolt mode on the port and partner in order to enter the mode
and the thunderbolt driver will not automatically enter when a partner
is connected.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

(no changes since v3)

Changes in v3:
- Set port.inactive = true instead of auto-enter.

Changes in v2:
- Only disable auto-enter for Thunderbolt
- Update commit message to clearly indicate the need for userspace
  intervention to enter TBT mode

 drivers/platform/chrome/cros_ec_typec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 1ac5798d887f..6ee182101bc9 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -311,6 +311,7 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
 		memset(&desc, 0, sizeof(desc));
 		desc.svid = USB_TYPEC_TBT_SID;
 		desc.mode = TBT_MODE;
+		desc.inactive = true;
 		amode = cros_typec_register_thunderbolt(port, &desc);
 		if (IS_ERR(amode))
 			return PTR_ERR(amode);
-- 
2.47.1.613.gc27f4b7a9f-goog


