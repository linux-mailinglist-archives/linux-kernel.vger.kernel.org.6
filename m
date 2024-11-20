Return-Path: <linux-kernel+bounces-416003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633C89D3EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23583282CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711A41BD9F3;
	Wed, 20 Nov 2024 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dRa/p3ND"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E67D1A7AFD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116390; cv=none; b=mCjkcoq56B/e0A+8CGselDjOsXaNvgOZFsf1x4Kld40TNxhAzOw/xotTo76eO6Zx+Kf9L+LHyHKf0kG1neQfjEE+9uDpIRV27o04fpSldkEXYNeGCE2/+RxE6G8gB4rDo39OYB19ND/LtoLrperxzOflbhvlXGfucTp0PIyZEAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116390; c=relaxed/simple;
	bh=M/gA3D3/PEohHHGD7twZZ4eTIuUXSFiVAx9/7Idj14A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Mh7usokA4eAORjqs/2BmToHFijFaEz6Bt6/ulhb6zyTYXrSaBFwt7gH7MUGt1XFT7v6KZcHaKIlt4mgrr0+xJXaEFi3SQbUtid+5j/CdGX9SJ95lg4pyhOv6Kk7ivQ3GyvPi3BOmsBgn9y3WDlb79izJ+pdQywrXlQFNMgMbXrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dRa/p3ND; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4609e784352so48046281cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 07:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732116386; x=1732721186; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vE+BXocT0XfTGY6UcV4G2Ny85HIEhrlBaBHHHlLGmps=;
        b=dRa/p3NDFv1fb6P2J9WlYr9kKlo9EFSz5KbeJ7qNKOjuEIaohAE73net4aDPz7LhQO
         F5pW0S9AZYGEgJp45pnaFHDaR5gf0kkFgYW840yp0iozwcak4jkqlP0dj6taPk+Vzt1j
         YP+ZtE9yd/Nq5GdeKwYwd+X+58dyqqcWPu01c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732116386; x=1732721186;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vE+BXocT0XfTGY6UcV4G2Ny85HIEhrlBaBHHHlLGmps=;
        b=wI+cS70xxCIvwJlf/9xif2l1oBbdCuHQtwLMlYsA735Dn2RGDAemR/MapfbjRzaefU
         np16D37Uw4LGp2p37HbPC31bRsitd0xyWdutHnjhfIxKy15ilGemkW2Wg3YFg9xO4kgY
         lFGWj2jYkTWEvTETbUzkOBuVuiHmh0mGs7OS+kQLjClQHMDNn4VpxOsyoipIYqNbg73R
         8bOKPOV6vHm8VCayIeAnYPCUX871Egn/WxEXARATslafpZ0R1Ub5XtWGOP7LBY0NDLzn
         Etnj5Jfx5EEbsiF/ikb/0ZoOSy4BncOgfYNBYZ7XVLVMJULRc5ruI9r7cxpHdBIG7BBM
         JVwA==
X-Forwarded-Encrypted: i=1; AJvYcCXqh6ZV5dJKOMP00Y7QgmCkE4D2atEW6OuQzuuzj6Wbz4tEyLuOkfRcpaZforplAqntNkDivhYd1erbhMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKAcrEYx6CKafv+HJWWjX7AbR7LwSn2UDiOiGqcOnOAJN+7A4M
	cgFdxks6IuaFrKo38XfWmIPMBNpe2Ksf6jRM5Q4nelELVdAEkl+zq4sFz3FvMA==
X-Google-Smtp-Source: AGHT+IHfVZXqaA4KfAr5rHaVjZIKPtu/E7t7p6yF3EvHm6mv+koel8mMGqxFKK2BssUBTGL6IhCF4Q==
X-Received: by 2002:a05:622a:5b9b:b0:464:94cf:9778 with SMTP id d75a77b69052e-46494cf99a0mr29838471cf.41.1732116384778;
        Wed, 20 Nov 2024 07:26:24 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46467fd76e2sm11207321cf.12.2024.11.20.07.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 07:26:24 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 0/2] media: uvcvideo: Support partial control reads and
 minor changes
Date: Wed, 20 Nov 2024 15:26:18 +0000
Message-Id: <20241120-uvc-readless-v4-0-4672dbef3d46@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJr/PWcC/33M0Q6CIBiG4VtxHEfjByzsqPtoHSD8KltKg2Q15
 72HnrS56vD7tuedSMTgMJJTMZGAyUXnhzzkriCm00OL1Nm8CWdcAmOKjsnQgNreMEbKRVPVymj
 LakEyuQds3HPNXa55dy4+fHit9QTL+yOUgDLKJNdGlgoaKc+mC753Y7/3oSVLK/F/nq/eVrYEj
 Vgevnjx8QBbL7K31dGAFkxJyzZ+nuc3IYg1disBAAA=
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

Some cameras do not return all the bytes requested from a control
if it can fit in less bytes. Eg: returning 0xab instead of 0x00ab.
Support these devices.

Also, now that we are at it, improve uvc_query_ctrl() logging.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v4:
- Improve comment.
- Keep old likely(ret == size)
- Link to v3: https://lore.kernel.org/r/20241118-uvc-readless-v3-0-d97c1a3084d0@chromium.org

Changes in v3:
- Improve documentation.
- Do not change return sequence.
- Use dev_ratelimit and dev_warn_once
- Link to v2: https://lore.kernel.org/r/20241008-uvc-readless-v2-0-04d9d51aee56@chromium.org

Changes in v2:
- Rewrite error handling (Thanks Sakari)
- Discard 2/3. It is not needed after rewriting the error handling.
- Link to v1: https://lore.kernel.org/r/20241008-uvc-readless-v1-0-042ac4581f44@chromium.org

---
Ricardo Ribalda (2):
      media: uvcvideo: Support partial control reads
      media: uvcvideo: Add more logging to uvc_query_ctrl()

 drivers/media/usb/uvc/uvc_video.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241008-uvc-readless-23f9b8cad0b3

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


