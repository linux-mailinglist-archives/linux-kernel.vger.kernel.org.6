Return-Path: <linux-kernel+bounces-393985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9959BA84A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 22:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3DC28147B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 21:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C20218C02B;
	Sun,  3 Nov 2024 21:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ijk5hPiG"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8C518BC0B
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730669191; cv=none; b=uDD2RU4b49sZHz8RmYnnwxGmET8E2g5/J+OtdPjM/JtqdjY/lf/ocyuWq8hi/dRoyP9I2NE4i6uuNzlayG/QO/CiDI3ZpkiojtvZgej2yHxEadnbLZ3BXWk+Z6GVEmTyZLOy/hg80qAO0ODHk73z3suCeAuir6BRvahK+7iBEvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730669191; c=relaxed/simple;
	bh=Yuzlz/gAXGepN585boJbCqwkRBFgUVeNpMhTrcpSlGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okGiBUKP+WDzZnD3OF6rVHbP6X9J6KrFiI0sckukbqxI40PpMs4SLOgsa3J4+1whm/aAfne6Mz5aUqPAzF5OrcC+UdMqs4+3P1DSjDcWzXkVqPFCFNcgUiZglq0exn/3p5TKa6MUWCBovNLT3T1VL/akG+LeafAUMaFaTFm9ius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ijk5hPiG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so27745155e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 13:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730669188; x=1731273988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tM1Vc6LIKdr1UuGOL4gln8Hsis7ai+S2TMSH9A6g84A=;
        b=Ijk5hPiGcL8zPG6d+i79dLdYEjrdwQiZLov8QiL2MFW0/6J9r9wydg6OhKNFuN0GzA
         p+buh9miaIEuazZqVTMuYPqgZjQrIZsn35+qchVqeLxU6D/Y8QTzbOrLi6vvFG7Fe13m
         nI2hG0nDtqJx3z4fqqzYLZptRGm6b0ihOh/xUN8ymhAPVH0xoo0b4XkDDWSnBogJ7Rms
         0xsjdfRZK3U8nQHtQIKhA4VFk7WYsjuuujXuHomXKQRTkRYrWOVK0yVPfSao7jjWCCOV
         Ix54OEFsU+0bFL+XSKR0KGt4zNRFchaL9qJbUNcMyMxoCuHWmy0Fi+jWWHO7wAAbAFeu
         TdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730669188; x=1731273988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tM1Vc6LIKdr1UuGOL4gln8Hsis7ai+S2TMSH9A6g84A=;
        b=knG5p8NK6P9fQfJxdKJg1hqB0nkzRZN9byjrosvZ2ski7OQ7xR9yGP60v80zOZuRFk
         JhfAckIHFK0Ka26/t0PPpprQ7Te/0DJxFzKL5NjzseyuAcjjrujcTnOpnkX7QrdJ5EVf
         BQ/sBrj7KCYehSvoWre17InPyn/B4Kyt4w9ED/uv3cYDPS+CZJvfWdey50QNVJkfErU0
         X70Dkssq5gVyw5h/CcFOESQ6YK/gRh2NkwnPwycFZNLZ+a2ZGnaxGY0pu/qZ9vVlOktR
         BqEFDWbTkIMc8WrlzOdsnVGk3+iafQnhh0ko4dY8zJTZImmuOWe6NCuxhStn8cCHN1We
         H6wA==
X-Forwarded-Encrypted: i=1; AJvYcCWSqcuwtORiXL3aCATix4Kn8zjqd640++Xer86Na8+ifYCyt+WlaCQG9260qgaB6zIikcXI0OXPKbTM2kY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytYFQBBfqNDfn65SRCPQqVkSCjPl87/YNq3MZWiwPAfHn61Phv
	95Dre7/vxUw6Y5euxkgEzICVqfy4veV5vsLLOQ6+vhZEe1aoOU4D
X-Google-Smtp-Source: AGHT+IFojVtE41iWXpVMT2O1EgAjvXjJ70TlGkI7FFNeVh9Mpf2fdD8FqQqpW+PVFuNXtKxlk02OCg==
X-Received: by 2002:a05:600c:5250:b0:42f:8ac6:4f34 with SMTP id 5b1f17b1804b1-431bb9e6047mr144722865e9.35.1730669187553;
        Sun, 03 Nov 2024 13:26:27 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd910718sm166150385e9.12.2024.11.03.13.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 13:26:27 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 01/11] staging: gpib: Fix buffer overflow in ni_usb_init
Date: Sun,  3 Nov 2024 22:26:07 +0100
Message-ID: <20241103212617.13076-2-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241103212617.13076-1-dpenkler@gmail.com>
References: <20241103212617.13076-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The writes buffer size was not taking into account the number of
entries in the array which was causing random oopses.

Fixes: 4e127de14fa7 ("staging: gpib: Add National Instruments USB GPIB driver")
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 571f07800c9a..b7550a937f15 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -1726,7 +1726,7 @@ static int ni_usb_init(gpib_board_t *board)
 	unsigned int ibsta;
 	int writes_len;
 
-	writes = kmalloc(sizeof(*writes), GFP_KERNEL);
+	writes = kmalloc_array(NUM_INIT_WRITES, sizeof(*writes), GFP_KERNEL);
 	if (!writes)
 		return -ENOMEM;
 
-- 
2.46.2


