Return-Path: <linux-kernel+bounces-576764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC0CA7142C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847E63B3E92
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E7D1A83F5;
	Wed, 26 Mar 2025 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTBozQ01"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7562915C15F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742982843; cv=none; b=NWOJ3kae8YmyvEB7XQixIwKXEZPhuQ2ntMcCwsSF1RUdY1qafzvk/jNIoqMMHddtjl/NJbvT6KdJ/u2J/JFrrkdKF1fr32hk6+mJV69vCO9B1WmV37AVTijjXpZ5BTOogwE8rgW6Bq4c6nTwxqwQZ4VzppwU80s2qXjinFrSwsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742982843; c=relaxed/simple;
	bh=Do401Dto4eRSvtWazEdu6e192DKWa4YpzeqwJ406zZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iuD8DiuxXHqnsnWIr53w9u2AI9tBXXsF5F48QpkEJnwjWGBDzo7nb2SvVXEoQiWL5rFc6vCRPRY7ymnaYyjAFGcEtOTkbol9lDmrBsmCOETy6ukXyc2h2OTx7Iw/ovdbDP3m3+WWhyfRONyg4UV3GWjKFEL6IIQhViK/DpIUer0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTBozQ01; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abbb12bea54so924731766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 02:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742982839; x=1743587639; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yjXPiRIp8YYDhIIaTUKI9YmEVChKDwNiiPGSatLAKIA=;
        b=hTBozQ01hw/r8dhwoRtXPlP0d97h4uIxyLqFJ3OY7R60GK+kKC50ZTpUaRiUizfZhI
         AWjXwP3ZGiPJtrXE8pcOxX1Zthw9b9jA8U/KFTpnDg1P1oBGPTDphj0xwx/QKemBDfre
         8X75ghAfyFhdZjoFSKPRqD0OxThf1r6mSB5Afpua5U1/hRH+qmXNYkT6XXXzlzdhKrj5
         drHwjzaQstyIh0NWpO7VqIAMhqBPupFZemwqgermFoLMDc0skaeF119v8byKRTBYt+Tl
         vPZUxilMD5I+05TX2WEvfd5Nh3jICAMBCPQZJnopPSt3HD4lM5Xv2OcoGu3tGGhT1U/2
         l+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742982839; x=1743587639;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjXPiRIp8YYDhIIaTUKI9YmEVChKDwNiiPGSatLAKIA=;
        b=PTeF31iwhMUp669cRLhBu4Hvl2ap4YZTnLybMrDiqUAOQE4dB1sjqYr/WyhauHbI4Y
         tHTdgygK/FPH5Px1gzKwxCVyoTEZAh5D8Bl7mgMuxpPdOoUgfd/Q1nUr+FWpPE92lJIa
         2pVc8iyb2Sx1YzNKOtpTiQePKm1vzd0lBTtwIAufsVUjUQjf0Hufa8IXo2fYjles7T8b
         rcDFYV3ConLmO5sgLjZ1HmDEhTVzFNG97pnwfm6ObD0zZIqHN5dhMfgA0v9CZIoCHfRC
         FsacR+QAogr11PKqd8kXQEWPlY79gyEQr9bu0Rq3RH8UHUseUbCVJ/neHdeacD+dlcWh
         eOSA==
X-Forwarded-Encrypted: i=1; AJvYcCVVCxDlS+Y91vAwHevWgLpBI5a+bShWXl5NHKaQwBQ+eLwBpSmzUozG+jgFzCGmVvyiZ2n206qU5TgCzJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqwTC/zhAaReMZx72j8hw7zydGzC/vKepzko1ElVf7wG9syHtj
	b1/A8upqlkBva6m+JAcxpdeNvepSYBVM5UyVKovYU2znH04kKt7R1Z8909a5
X-Gm-Gg: ASbGncuUFLwb/2vHxF3/oaDQTNGQg75dtfODvbij3kusW178/V9J5m0FG2xYqow5LlH
	hJXJj5DJCs8SBPGkLYcH/5Xn1iBi41xu/JvSVznZoZkY0TFMblDcFn5HBZQFnYirboit+Dx7sNS
	VE2k4yIObz2RiJ6ROeaIjb+NPPmv/Zl7jaRmHOSvzcoP+kssC6v06a1XVjNO6C1KPNOc/yVl+FQ
	G8hEGNzsJC3fFqzBt/dKpmdQ1NeanKn8vYT0XMysudoswlOqQOXrc8JAeVIqu96OoioFKUuvHKu
	CvwPvNmZeugGMo7m/OzsZtMEK9o89wzjccL3kNW+iqr7mrxIjA==
X-Google-Smtp-Source: AGHT+IFZQfqPmKMBaA5lUpDx8wSPCrGqm+FenqOZLIhKis+yFvTwmUpU0KWJCXNfGlHGxrAzmuiCyg==
X-Received: by 2002:a17:907:7295:b0:ac6:dd5c:bdfc with SMTP id a640c23a62f3a-ac6dd5cec3cmr389055766b.50.1742982839262;
        Wed, 26 Mar 2025 02:53:59 -0700 (PDT)
Received: from HP-650 ([105.112.122.183])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb52c24sm987282466b.114.2025.03.26.02.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 02:53:58 -0700 (PDT)
Date: Wed, 26 Mar 2025 10:53:45 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@inria.fr>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8723bs: remove braces around single statements
Message-ID: <Z+POqQpWsgMRz/UT@HP-650>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The code contains braces around single statements in the if blocks
which are unnecessary according to the Linux kernel coding style.

Remove the braces to improve readability and maintain consistency.

Reported by checkpatch:

WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
Changes in v2:
	- Remove extra blank line

 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index c60e179bb2e1..74a8fcf18e84 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -56,9 +56,8 @@ int _ips_leave(struct adapter *padapter)
 		pwrpriv->ips_leave_cnts++;

 		result = rtw_ips_pwr_up(padapter);
-		if (result == _SUCCESS) {
+		if (result == _SUCCESS)
 			pwrpriv->rf_pwrstate = rf_on;
-		}
 		pwrpriv->bips_processing = false;

 		pwrpriv->bkeepfwalive = false;
@@ -549,9 +548,8 @@ void LeaveAllPowerSaveMode(struct adapter *Adapter)

 		LPS_Leave_check(Adapter);
 	} else {
-		if (adapter_to_pwrctl(Adapter)->rf_pwrstate == rf_off) {
+		if (adapter_to_pwrctl(Adapter)->rf_pwrstate == rf_off)
 			ips_leave(Adapter);
-		}
 	}
 }

--
2.34.1


