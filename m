Return-Path: <linux-kernel+bounces-295887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EAD95A293
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E252B1C20C89
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F11C14EC40;
	Wed, 21 Aug 2024 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrDn43Lw"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1963F13C914
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256952; cv=none; b=ctfZr8Y9+ItUJdhkCsMwlYsaJdntlsXMnVik+7t5mv6SrfLmuShNxVZ2tKSDuwws24rWssSGdBWo+uD02bvevgxy34O3ApNr1U1o8vnKULn4LTJNJ2RpJZldVFWTSzOewGV3hDEtD0fKr9f8HplSnVDrMta3P21jY8votRbui68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256952; c=relaxed/simple;
	bh=ajQ927Pb0rRwjB0K7eVY42NiEVjiBVQnaXpL41206mQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=peFW9I7Fc8J774G2ZGjcnVtbAIqSXYc4SI5v/N3olGqWfPEPZtm4GPs4yZ7yMN1jx9S2CJBgy2qVxNXKT9140IEoY0yWBR3RuOqEZQTpKZidu+mQQBVnToYiyGusEWZPhcrsN8O0Ft38UNmueJ4RVE/6PWNqpCTxDzMJglehNXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrDn43Lw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7142e4dddbfso342576b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724256950; x=1724861750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rr+fhns5nZq73IrYJsaPCOONeBzEFwA/rzWZTaQJx3I=;
        b=CrDn43Lwpe+UTWBWK0PbJuJKYJV7plaMEtqr4zMgMCFjikKotpIneRsRgfQeU4E3Qm
         xeoStwMqS1quD17CNNA3vp/W+e2nBLWoGJjgDyUxKZjeUChbG6cVAAaeqFU8Zs29GNQC
         0QhWMSImiSGowym2eapH46/tMdqEGlhTqhJnA31WXnqKBedfEu8wPrbaE9Bm1DRjrFlK
         TB1YmEthIIfMs8BOQDVaxscyTquakUIHE9CQL6MsjAJQLtXyv1xCdrVq26a3rtJEzEjP
         htvxqoz9zzt3j9ieykjJvn1/lW5Iik+kYubCD1/ihyWkmsoutDPben4ZSHPtBwkfRApg
         3nCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724256950; x=1724861750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rr+fhns5nZq73IrYJsaPCOONeBzEFwA/rzWZTaQJx3I=;
        b=A6rhFXzyK44uW5i9w+FvWy0mgeRUBA71uC7XawByH3ARWXjjiCdwA7a1lwqe6sgXGA
         NbiOI6blo90rji6ksCS8PRQR/unCwkm94jwl3Qg3/JhdUG40xwh/nQOQgloU5xyzbHB6
         6mITE1IdpVPOMgfDcPUM+J9gfy110ODLeaQbuQ2BtFtTJPcn/AFqPRw+Wd3LnrzblrcW
         EEGUg0XZ+UC6NH1JTmkyRzfQJgOyuXh43GQShDSJQ7ppOXVQUfsmX601RcTBDzpT61eP
         9qtiiOpoL5D3gZIuKZws6PUicI0kiJW+WeO8PZlkO93tfxBMdC7+omTY10NBwA+jBy4c
         QFfA==
X-Forwarded-Encrypted: i=1; AJvYcCVlsuoJir26G2YM7neDamcB053rswBOrMjoQGHRSX3lS0y4iKy5C+DLgp3UDQj0iVzdyHS29Kv/LoWWrrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpoVK+tnj46lNa+3gft655g12fqbi5ufLZXGv8Cf5FmXOXpqk+
	WOhHctYDAwY9dqO9DEi8AZPQK/ys2ZJ1j3TpdRFd/amjP30K5zL+
X-Google-Smtp-Source: AGHT+IFpSl0kSozJkaX1WSqpP7j+yZpHNRpsY89nwg8ap0SYYXTGBkRXrTQ8iddezaxO2fC9rgsHDQ==
X-Received: by 2002:a05:6a21:386:b0:1c3:b234:d10f with SMTP id adf61e73a8af0-1cad82248demr3182045637.47.1724256949942;
        Wed, 21 Aug 2024 09:15:49 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([103.57.173.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add726esm10166213b3a.37.2024.08.21.09.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:15:49 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: philipp.g.hortmann@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	abid-sayyad <sayyad.abid16@gmail.com>
Subject: [PATCH]The patch fixes the following warning generated by running the
Date: Wed, 21 Aug 2024 21:45:39 +0530
Message-Id: <20240821161539.541062-1-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: abid-sayyad <sayyad.abid16@gmail.com>

drivers/staging/vt6656/Kconfig

WARNING: please write a help paragraph that fully describes the config symbol
2: FILE: drivers/staging/vt6656/Kconfig:2:
config VT6656
	tristate "VIA Technologies VT6656 support"
	depends on MAC80211 && USB && WLAN && m
	select FW_LOADER
	help

total: 0 errors, 1 warnings, 0 checks, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
   mechanically convert to the typical style using --fix or --fix-inplace.

drivers/staging/vt6656/Kconfig has style problems, please review.


Signed-off-by: abid-sayyad <sayyad.abid16@gmail.com>
---

 drivers/staging/vt6656/Kconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vt6656/Kconfig b/drivers/staging/vt6656/Kconfig
index f52a3f1d9a2e..a37dc3c921ea 100644
--- a/drivers/staging/vt6656/Kconfig
+++ b/drivers/staging/vt6656/Kconfig
@@ -4,4 +4,10 @@ config VT6656
 	depends on MAC80211 && USB && WLAN && m
 	select FW_LOADER
 	help
-	  This is a vendor-written driver for VIA VT6656.
+	  This is a vendor-written driver for VIA VT6656. VIA Technology VT6656
+	  is a wireless network controller that operates on the 2.4GHz band.
+
+	  If you have this hardware and wish to use it, set 'Y' or 'M' here to
+	  compile the driver either directly in the kernel or as a module
+	  respectively. If you are unsure, it is safe to set it to 'M'.
+	  If enabled it loads the firmware for the mentioned device.
--
2.39.2


