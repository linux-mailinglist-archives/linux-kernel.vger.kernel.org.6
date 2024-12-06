Return-Path: <linux-kernel+bounces-435066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD5C9E6EEF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F06281C06
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046C52066DC;
	Fri,  6 Dec 2024 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m4LMBlNZ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9140220103B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490566; cv=none; b=tx0U+z1yJWuawUvi8zf+6/DfLVvctOp2WOi8kyGu4ZzucvkdvSTRBdej2vCcwABb7TCEOZdHSy9jnxqCNKroZWgMitRqNAMZP5MH2w6bw0k9Kupgdg+BiINGOk7XTL1M1+tzWRm4T6znUXNxEIHU3udj9lMLlJFXVedLPIqFnds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490566; c=relaxed/simple;
	bh=Hk+8FdCJyJ2RtcsWXsbcyvBWzUyxa4peO3nujhwWwz0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SFTLS6wiHaWbWYWaKRGVWps4RuTqrbIXd6J3ShoM5scARxoLX0/0hj53qQ4K/QAOR9zvNa5a0N2KR40rk8Z7MMrMq9EUM2ipmoI/bKn6QKNFkGW2w8xHnu7u6orwmg47xqXTIuCYJu6uG8Kc5Xww86jlheydiIueMgXMkW4G3Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m4LMBlNZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434acf1f9abso20101805e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 05:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733490563; x=1734095363; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/SGgSgGbGfS4qal8H23FKyEqnU45LmUqMyclprxKRY=;
        b=m4LMBlNZ/oEep3zcGJu0K5tRl1lx77q+YjT5h53ZZcw4Wyl44rACj6eL5bFj6NSGvf
         CDd/SOkRS3ahS9FDqfEdN5pBOeGmC/L3AkAfhdopoJSqvrgwTI5mqribBO/Ls3NQinM9
         Mfyx9u+id8ldl7wfMUTEVfGvG7j2SMvuyYcOugabNgzfqgCRQLknngBI2pz7FiJRJWKe
         hIxbRbz6zHNdoTzfMz2t8vBt/4W/0m2iV9qV6OtgK1OVaMUTCSV1TjZUjnm/3eaCKbkK
         h8LW3L5cenuZWGMFNI5H7Rst0eyJ4mvzzkFKmd6k7P8MQ7kVZZYUvynOp2CR/SEGya/+
         fsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733490563; x=1734095363;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/SGgSgGbGfS4qal8H23FKyEqnU45LmUqMyclprxKRY=;
        b=I27C3e/w/mtA9VOQ3VHZEL1PDJXFqh87tW4OMTZaszo+LcovbBU2Q137XQXH12DU9y
         FZzXJS/AwhvpnNiLOfZ5teoGYzETi95u3Bm+FTi1ffMP/Aq3JvyqDOpRZef5bRK6jqS9
         oVCd5vfIG7Capzeilxgm0Jh04pFmTTIf1Bt1V2CGW3SDg1G+GqNKTeaQg/l/qjmqE1Al
         C16lwG95SZqWZB/Y8HWG/hHJ38TIQQC7ZreL3LHvuGzFDLxt1NcoZSobiIcQwvJpqb+H
         ZVCacRyX7XhZBVgYDddfJmL+2HFlB8gqQgSFX8MfMHhnhl4XVe41PAi//o7qwPQWP9uH
         iA5g==
X-Forwarded-Encrypted: i=1; AJvYcCUYxUE85/qwCpxUh/jUvzw3UclqmiABgUeTXf+/ziPNgdm875LvLwAPDGywwg2cDqguDD05iXtL83wA1Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk1Msaz2j9U4Z1K7qoMUaT6uL3eI3/dH+ubA+FSnBAqcFu3S9h
	eVD/NFQ0Qpzla/pxVaaUc0vNbmLRAG687cpNH4lcC+r6zRw/Q8EVRkbVRilvQj4=
X-Gm-Gg: ASbGnculTs4UMpp8ccdX8B9tdhWXBpuLJl3byQUh14TGO5UZF8BQtYOzb9G4cV5WjXn
	Ptc1L9J8k8TvA4Ru9Eh7y5goyus8gyO6/f7Rj6Nj3U0iVtb/nhHKK914/423kwCDi64Nyk6rtCF
	AjrXWguVR+rl5SLnT0HKjOBKI8Y+JpWvqfcSlm8MWyHFOQH2yb6tA7ti6zMTxiRXNeSib+2Zx8Q
	V6IIyzuEbNRSgP4IBF2y4GffS5uPirJtkGKqSvLcEeFXg5RdPCsWH4=
X-Google-Smtp-Source: AGHT+IEe8eUou/A//oG9K2iNOUpaAPFb7T+EAvrirPkHn2z8KIBCuyQ60MWJalATbJ02kxAAUHl+dg==
X-Received: by 2002:a05:600c:3b99:b0:431:52da:9d67 with SMTP id 5b1f17b1804b1-434ddeacf25mr27975715e9.3.1733490562877;
        Fri, 06 Dec 2024 05:09:22 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0da4a1sm57254375e9.19.2024.12.06.05.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 05:09:22 -0800 (PST)
Date: Fri, 6 Dec 2024 16:09:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] usb: typec: tcpm/tcpci_maxim: fix error code in
 max_contaminant_read_resistance_kohm()
Message-ID: <f1bf3768-419e-40dd-989c-f7f455d6c824@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If max_contaminant_read_adc_mv() fails, then return the error code.  Don't
return zero.

Fixes: 02b332a06397 ("usb: typec: maxim_contaminant: Implement check_contaminant callback")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/usb/typec/tcpm/maxim_contaminant.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
index 22163d8f9eb0..0cdda06592fd 100644
--- a/drivers/usb/typec/tcpm/maxim_contaminant.c
+++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
@@ -135,7 +135,7 @@ static int max_contaminant_read_resistance_kohm(struct max_tcpci_chip *chip,
 
 		mv = max_contaminant_read_adc_mv(chip, channel, sleep_msec, raw, true);
 		if (mv < 0)
-			return ret;
+			return mv;
 
 		/* OVP enable */
 		ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCOVPDIS, 0);
@@ -157,7 +157,7 @@ static int max_contaminant_read_resistance_kohm(struct max_tcpci_chip *chip,
 
 	mv = max_contaminant_read_adc_mv(chip, channel, sleep_msec, raw, true);
 	if (mv < 0)
-		return ret;
+		return mv;
 	/* Disable current source */
 	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, SBURPCTRL, 0);
 	if (ret < 0)
-- 
2.45.2


