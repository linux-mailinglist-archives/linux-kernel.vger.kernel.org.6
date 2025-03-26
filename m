Return-Path: <linux-kernel+bounces-576971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90926A716D0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A99D47A5B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC3B1E1E10;
	Wed, 26 Mar 2025 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPENa9Ws"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB91E1DEC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992823; cv=none; b=pXCDK7rl8ScHQXwR0Tqp3av6o35xlRhJJQTeqjsa0/rXaIl93w/pBkwuRL4gcHqyS/0SMkQice/r5D2je1QLmJUmzyT11+HD4UmnqkXxg+e8q0HjsZPIO2AxNsVl66Kg4rUwXse+xHCWLhIsog6xr1e64aTJcInKOhJ3ehhsxYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992823; c=relaxed/simple;
	bh=EidWf1smEcccrMWZMH5+INfITris3Gt4B5G1RWuRqyw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pK+TzNqGrayNBoVzqTW/NPkRe/UYWBZzJ/f0HFywnevt1+HpyH0wSerNmHyWybouopYMb5MSsAqNleX1kAUV1KN4Wo86zbCHPahRgTt4kKdg12l646wQh3/wWvksAqK6e0wl/4ULY6oZQ/wKjlJQGzvtYQyKqm3t3qblaT+aM7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPENa9Ws; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so76273566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742992820; x=1743597620; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57GGOAaZN1XoYLh8BKnwS9BMIWEfDl/68HkmO3s4Tj4=;
        b=JPENa9WsF4s6hGGEk3Gz1wOMe3mwLfwdr8/sFRWZ4zRs6hbKvyzQHIyo2ff4jzGYDw
         jWVo784rIMD5XQEtuzwYFzgDZRTKdhTHPYwCeTruqwffO+Y44tSbpc8Ebxb4mK7cDVjA
         3e21TE2l4MQN/BKkCCyKPfr8o72KjNv70cHwGJnMOCTdFxAh0RtK2FBWdWk+UMMd9sFy
         bVJ9EGfFqfY/NNLPFak36QzTC1qlGqK8wejPD9/MCKfsEmpyUUvvODQzYAMFSvS7fBi7
         ZwHMYmi9M28FzRIKf3w2tS0W/Hsi/t6PfCGh5eo9DGxjMEHQJcfYUh/FYPjBHghpvWiP
         tMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992820; x=1743597620;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57GGOAaZN1XoYLh8BKnwS9BMIWEfDl/68HkmO3s4Tj4=;
        b=LwAkW8PvNTLjsscNeIoWOl1CX81CSbGwsabH+t7IbfSto+zRHd29zKI2F9kNygtImc
         idlWsYtpmwAN1I42bed5iAAOkAxRvn5XN3y7MtKnUE5CCx/UWVO4wFz/c1SB1UUyLXIH
         jovqWEVapiIsVfe8LAecbrE38wXpx/s86wzEW1tns+sn8SURG3280VkLMRIqReMH4fl6
         X5iGhnrnVydCtVwlKwsivDh186HQ1ovDw7/LFuMdT5BFJ0xAdNfPoOn4AOj9P0Nb2fPn
         ynr/UMfgn8Yhra0qpalIYGFrV/WIHxSDaaSbWEpdhv2kHCOyvyW5/GW8lWc9b9bMHe5j
         /Wcg==
X-Forwarded-Encrypted: i=1; AJvYcCUk10vd+QHduQ3TYniiTzxWbhKUMEH7kSrKSHc2Kf7B+XaW3Vw0aQtlxEemUubhP33kHArXyRegRvUuvHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf+Cb8pnk6BHzGg/n6ccGiepfzgERSKmjTzvE1tQ3Bg9i0IT0j
	VwF/0GWeUh8kmH/INYbR4NAmU3gKkzh7TlvLxOUKqJr/jW9ju9jE+sU1jEHQ
X-Gm-Gg: ASbGncsgQN0sMfL8Ye00IwbEVhfvOE7UwQ8RtKfT6HD36miE15175Tei8KEk3XRtlua
	AWY3qb1VpEB0+0P+q7OgGY+M11L9k6lOiiXvaJUjLbaoiwC01s2UXPthpAOWZq5CAbKzcfisAZo
	rExbJ0CyqdF7lohqHznA1K0jzdfCWrGcM6G1HStysqGUOHsmQQFqaJ55iK4+b+dNe2Zb2ShBs5z
	Hd86db9kAYYjJtHIAFowClFEjLnw3TQQTFKicLGFx/y9AbM+QOzjARAF/rkOR6QpC7sQwKkWG9Z
	7EbjchcKZHrFwgJsVOF+pdJKcgyrnZLrlJjFO6DOlkKD6On/wg==
X-Google-Smtp-Source: AGHT+IGYAScV+oczm6r/JGUZSx4iBrHklfsgOR7nh1Ox+2Mbys7FxPkGsbq+bEKXPKTG0i7XEVIsFQ==
X-Received: by 2002:a17:907:7295:b0:ac6:dd5c:bdfc with SMTP id a640c23a62f3a-ac6dd5cec3cmr454680066b.50.1742992819282;
        Wed, 26 Mar 2025 05:40:19 -0700 (PDT)
Received: from HP-650 ([105.112.229.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac6d28d26dcsm211942966b.60.2025.03.26.05.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 05:40:18 -0700 (PDT)
Date: Wed, 26 Mar 2025 13:40:05 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	outreachy@lists.linux.dev, Julia Lawall <julia.lawall@inria.fr>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: rtl8723bs: remove braces around single statements
Message-ID: <Z+P1pfLSKpiRtpaF@HP-650>
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
Changes since v2:
	- Add more patch recipent

Changes since v1:
	- Remove extra blank line
---
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


