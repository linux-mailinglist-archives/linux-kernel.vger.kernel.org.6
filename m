Return-Path: <linux-kernel+bounces-547619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 542CAA50BA3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D02487A9602
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7609625484C;
	Wed,  5 Mar 2025 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbHwSQGm"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A678253F1A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203488; cv=none; b=KlWVtXf1gz5EerDGfFSEqI5oqclJcX2Cn6/ILSvBmKRqH3LL4WLIyWpJjnHeM/+i9DYgQZq9A2lWZ6rKnYcdUAYK8j89+zpuNIfI5mcbTQ/5QD+fVaQs60eMz7/kDFFr8GKYmPuk/J1cis4NLCC9WYk473tUVP/A06AxTlzsyVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203488; c=relaxed/simple;
	bh=j/iTviw7PJPcpETuVwwtmw6HSTOe+M0fePl8x0v8b/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEOx5q7T5bTZBNHaOnhe5ho3RPkjai7hm03SEH05BD40FzRENMC9sZnenttRB1jIj9XcyeJHV7xqH8toOQT/SmAfehIdMwd/3Cg6vJMgg8zDDqZn/dg7ISQiwReSRAexsAQm/hz+2K8UCpRmdtr2J51gmpVtLdwDxoPaAVRGTpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbHwSQGm; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2feae7e56c6so1881832a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741203487; x=1741808287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7sXbP8vy3+v83lKPy6uZAVEBdTCaE0ovfzAtTI97R0=;
        b=gbHwSQGmCgmUuaFQcCwH2meZbXW/K1VBc6r4qOISuvS3mddy8RQlZWUdEMKbYwyuh3
         0O3VPblYEeNDzEDcIytmzo/QYYetFEpvVaADwvISrCi2FBEwvLBHs36KxRlOO8IUu9t5
         G+HqIgjayoP34CGME9zvKMm+3cdXHSG3XYKICpvLg4/7WUE7p7Bc8rSqejTta6SMJZRA
         M0bH8Z/VYHCd//M4K76UYJKagH9Zh3v6m42OQP5tNJ2IEaki05oG8N6v2P5/ZjbjcCWk
         Sb0daFnf/t28HXBSsa7c2YbzItse8IxiW7jkuiMr0ohOnA4zeRHvdqpw0n1T+7gMYeWM
         sfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741203487; x=1741808287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7sXbP8vy3+v83lKPy6uZAVEBdTCaE0ovfzAtTI97R0=;
        b=mNg1DNNmTA2TK0As0FSXT8d+EWrCX/c/7r29TYkJjneXXctQe01EKTiNnGOitPa2dv
         g4m2Up4FDxHfB4l8lImchB2XHS+/dwtPgpJpbzZ89koydjLEPRVM7u8ckNUjefTmq3E4
         iO43oBVeXDpGqMLFlBfD+Ro512O1HGvEMDKoF0j2FPrj/1ZHSikrN9gtazkI8pIhaW9G
         N6rH56j08XPd3YWQGgve5epNw7sfnPu5A8QUJN8oEZtZOMYuYffP97tlpFwc9GkWBHfa
         /nxuJ9KRt9H85eB37meaSeg2YXf9bEvw0jn7s/TS1diPUw5ykYMZZrARfGkWBL51rw1v
         D2lw==
X-Forwarded-Encrypted: i=1; AJvYcCUk5bafEAl4R24YdrDz+dxjx8HwozBXQ4Mp1GW+anLYREYo3y7ypck0YncY10N06TyW2cRtD8z//zY3Kfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTaQDkhxSV7jPqpPBq0PjLXMFaNvLOMvQqasIzRf1HoxqwtZx1
	VeZTM7mLAnJjPLBFthxAh8riMaLQ7qNZ1AiVS0KW+vU//dxy3tdBVAlHww==
X-Gm-Gg: ASbGncu/ZTKctu2BL0c2UQ2UHzu82wssPrCZyXDOle4ReR+dA1k0Ml+Cb02QRZCnJjE
	xEw/A24T+MkcTQcLThppKyrnpRXXB5JDx59JzNqg9E3STwodrrDkyHwehCXqSS2tkgmQCoEp5Aa
	Eyg4oIZWlPxJDuk2qeKHkKPkNxhB1bRougPS8rF41z6LVmlmI9oBw5hVEDlw0Px2lTJJSacvjGO
	W0GQ8xy3IIqlUaGQX2eW3qK9jYqP2Nk3bjbopxjvwk5fR28WyjP/psaL/b4wCbgfMVWyj4LOXpX
	qim31yQ7ZUJF5ASFouvXAENRwLmhMMXRRY5JJySanZWf7vru9sndlZjZkV5h
X-Google-Smtp-Source: AGHT+IHsjbx1miPTQBNrX7ZjboroAqHyYvjM19R16VWGXNXNp7juxMRcFLx8vf3UD4OuEm12sLJK7g==
X-Received: by 2002:a17:90b:3a91:b0:2fe:b879:b68c with SMTP id 98e67ed59e1d1-2ff49824430mr2883031a91.6.1741203486654;
        Wed, 05 Mar 2025 11:38:06 -0800 (PST)
Received: from localhost.lp.veng.com.ar ([200.10.125.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7a2bbesm1898148a91.37.2025.03.05.11.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:38:06 -0800 (PST)
From: Gaston Gonzalez <gascoar@gmail.com>
To: linux-staging@lists.linux.dev
Cc: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	dan.carpenter@linaro.org,
	arnd@arndb.de,
	niharchaithanya@gmail.com,
	jiapeng.chong@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	Gaston Gonzalez <gascoar@gmail.com>
Subject: [PATCH v2 4/4] staging: gpib: remove commented-out lines
Date: Wed,  5 Mar 2025 16:32:22 -0300
Message-ID: <20250305193614.39604-9-gascoar@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250305193614.39604-1-gascoar@gmail.com>
References: <20250305193614.39604-1-gascoar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove commented-out code in function write_loop().

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
v1 -> v2: no changes in this patch.

 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 4a8e5905daf9..08c64b111a1f 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -217,18 +217,7 @@ static inline int usec_diff(struct timespec64 *a, struct timespec64 *b)
 
 static int write_loop(void *dev, char *msg, int leng)
 {
-//	  int nchar = 0, val;
-
-//	  do {
-
 	return skel_do_write(dev, msg, leng);
-
-//		  if (val < 1) {
-//			  return -EIO;
-//		  }
-//		  nchar +=val;
-//	  } while (nchar < leng);
-//	  return leng;
 }
 
 /**
-- 
2.49.0.rc0


