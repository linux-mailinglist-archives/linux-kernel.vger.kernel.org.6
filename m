Return-Path: <linux-kernel+bounces-575772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DADA7070A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE645176FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA1625EFB9;
	Tue, 25 Mar 2025 16:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jonbwN5g"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BEB25D91E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920372; cv=none; b=cB2AkNSr/wmNSTDMWqzF8SIM+L1B94ZsHcynqf1ATfkykBj543SpZd+WF6YH2lG9J/BJYidROlmwTuB5pC7CVfPC90hQeKH9dKvNmcKaOt+AVljldQ4oTy25FDRllP2jy9+RVRzfynDpCPGlr/D1LTYA3BkenFMGBrmeFnK1Uvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920372; c=relaxed/simple;
	bh=NSec+iBcn7Q/AJxbbFrWQy9WdryMOTeKoH6dL/cAgaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BvLyHCpasSz6OWQX19h/8hXLzt20ccpNQFGNl6gmdudF/BBCHOqv1POMgGMryWUFxOXajJO4DcDIqg0IaHhuj+jNsuZcT7Pgx8hFXvnFyDeUstSTegP3CkDkacd7QkyDiGnJEQ7oNFFA6lB5mnhylBWZkC+K7GLhSd86uS/N7IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jonbwN5g; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e8be1bdb7bso9161353a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742920369; x=1743525169; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4odgKTupI6gjEJZNLy+RWifMVtAgdHPam3xHzX2/tcs=;
        b=jonbwN5gg+cGVLHEdKFljZjUVpHzPCr8Wh/CWCxCCy+cApKmwdtds7xFT++RVoW7Om
         JARUJQV0OIY182AeJZe/hw2+CBpnXGomuuluNfCsVpwgoMyxkgut/EEO6Q2tg7bdqYmH
         kzKzI1sSUNMzm3+XnnmnCEt0aNIh/xKCvsI+YMsSOt6T4uy3hVX6YGoEBD6s3qSQ9653
         3GcDt6LvhOJBVTkiJjCZ6n9AsJEptqsGY1HQrOJxfiiB7pKJ3wrl02bFhpjtrt7r5dQn
         Ygf7zENNUFqD5cI7ID9Wu1Zk+sWJpHE6k7fejwnxEucTJoFLbiApf0RctQGtPC7FpPYq
         m5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742920369; x=1743525169;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4odgKTupI6gjEJZNLy+RWifMVtAgdHPam3xHzX2/tcs=;
        b=ODSVvulLzZs8A5fpfQrJD409OGn+4qx5qbRpfWFZaS/+J2JBCgZ6khnz3GOBUMcHeC
         Rj6fB2ZBbOVqxPCQBjXbqd/M/B7HUsGNRb6raTrkme31PK3NPaQD9u2VZb0GHnq2HFYB
         dcvbpXffdHBN9OnvjkqDKm834RQZ3sib3SGd2GmvsT8LzeB4PuaNeSZ3qGWJECaNvrG9
         rZvEA629LhFT2WA/VQe7j7+31c2wvNzN+34/A3oH0gxRK4SLm0Vogzf87i8UVtj0yRlY
         rVP4psGX88i0MQDqcclXsJ8BYaBLhyQ06OzkntuMG9bqpYLQdWJNZLY9KASzgfLmdpI0
         qZqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBfC9H7j2pIiUP+bx9O9INTxC+1kQhZmLOgCjsxiGEo0+gtfy4nJaAWRIlWOmXEHg9ZgHVaj7NjhzRRmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoqqL+ur/n4sWTREPPEKYZlo/S8ZAVDWJaw6tzC2OyhOicLBpO
	yPcOu0TFQutvTqHvTUzM2IzFX1so464rbvfggVldlqQsaeBh5CHVzue0scgm
X-Gm-Gg: ASbGnctcVhQglPDVRTcJnPxy3SdgGyoCUupq6cHVRTVBGL5NCuvUPQ0NMXSLt4T0uMO
	dOJUVZZ1aBajfAg3iZrfYRynDHj+LE+zAs5E4PYTiUDEatNrLtrwMYf5vMMWpvPl2orxY9qQfQj
	YpnnD5z4nysXoZTdeF1GxB20kuPVAlK87vIuWPyTCdn/f1KFANyFCD1KBfBq0rWvAl3GhNPB3NB
	4/reiSdY/bspNSt6br3Tek6PGUY+YA03YvbYIiPDiyQoozlVWTKadJmk+1cPoTXpN8hEuf7Akk1
	LWOin6O4GVBoIm9NKtAw9hNIbt3JfXGgnIXn9qCPECCPSkzevA==
X-Google-Smtp-Source: AGHT+IHVgHE8zQfANSq9zhdazHfrmTIr8aqswsXlpCS61/JJ0ZXz7XZidItYALPPaLUJjU2St1EgHA==
X-Received: by 2002:a05:6402:13d0:b0:5eb:9673:feb with SMTP id 4fb4d7f45d1cf-5ebcd4f8250mr15323553a12.25.1742920368472;
        Tue, 25 Mar 2025 09:32:48 -0700 (PDT)
Received: from HP-650 ([105.112.117.141])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0c7157sm8011720a12.60.2025.03.25.09.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 09:32:48 -0700 (PDT)
Date: Tue, 25 Mar 2025 17:32:31 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	outreachy@lists.linux.dev, Julia Lawall <julia.lawal@inria.fr>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: remove braces around single statements
Message-ID: <Z+Lan0xeQd3m5ejY@HP-650>
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
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index c60e179bb2e1..b17b295e8d3c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -56,9 +56,9 @@ int _ips_leave(struct adapter *padapter)
 		pwrpriv->ips_leave_cnts++;
 
 		result = rtw_ips_pwr_up(padapter);
-		if (result == _SUCCESS) {
+		if (result == _SUCCESS)
 			pwrpriv->rf_pwrstate = rf_on;
-		}
+
 		pwrpriv->bips_processing = false;
 
 		pwrpriv->bkeepfwalive = false;
@@ -549,9 +549,8 @@ void LeaveAllPowerSaveMode(struct adapter *Adapter)
 
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


