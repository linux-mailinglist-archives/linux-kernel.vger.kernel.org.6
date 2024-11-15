Return-Path: <linux-kernel+bounces-411487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8059CFAD2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628A82817E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC97D1925BA;
	Fri, 15 Nov 2024 23:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mPZwAxMG"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD12B18BBB0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731711915; cv=none; b=PbJ/RFBHVn7YNl2m2juYtD3UHBCf+O5V3KLZRtMWhGRUpmuwrY3ro13fxPuUxY4vEtSRChsVoRwF5wsZvvvvD6RpWrlxuEfhnn+z/nVvGCMUWCenIULYmhxzj+uG2Wv+A5YsSDTsMZWqnDxtU4hvVZOEjLi3w3gn+cV63Y4H7Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731711915; c=relaxed/simple;
	bh=fD1g73Ei/gvILVxRAisFNu5pjG+yc26UD1b0nE/9rIc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=aR4t2/cp0R/uvCKZNpbtRqdgA1uq/WjzZ/0ODXb+Tu+fbKmI8xiWxgLw1AJKQRsfJFfboEz2GaUVzyuLhGAu4AFi2PDkPzEciOLiyTl0wj99H+OBayGYAXEr/T1wvvoTfa7Iz9Ptc3HnkmYuTbzpdsvlVpXtFp/so12wXYO4QOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mPZwAxMG; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e387e8e8426so258156276.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731711913; x=1732316713; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CsVAl5B+i/AdvjgTpeYu3dfcSyizK6Yc98NoL+FMGlg=;
        b=mPZwAxMGXs/a9WyJgdRCJ4M7VO0lc0CzvpENjkinQofVDQqSfaBgo8XLhoDr8nvfMh
         hL4RVz3qrEwPQb+aGbtnv/f7rp0A1qpHmftb+jQSBcQQOx/5XfoyvTATRQBVv2VAjC4x
         hC3OBwP34CcdLT2sylITMGJVulfbrZsW60ARuP8jBzjRpFuC30PS/PiuWmCSB71vbYCL
         VSrZbbcL0/6e13axgcdgfrDw4W73lAAepbRv6z8Zq8v4Xdoo8ishFIW+l0u+g+OALngK
         YwDpYfz5cZeRi57M2eQMc78g+4XMfpfTPq/d752hyCBPO14XDjPvAFh4xzVoa42cxHYp
         GhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731711913; x=1732316713;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CsVAl5B+i/AdvjgTpeYu3dfcSyizK6Yc98NoL+FMGlg=;
        b=G1kNglEpPAW6tpms11d18XpFXO6naibvvklz9pQYsLQ7mpGvITUa/gjpuK+ckOJ0PP
         LvRP7Yhm/Htk17mgHv2GV2Xsmvut1c1ud6b+uGLrcScZ0Ono5d8fnA/pebl3xw2GOyvu
         ynHDRHprS32KwrkmLUjqH8UUc/x884j4Bx01UyIcSyO1FPqdWT0UOtj/x7l8OFjS0cLi
         VKrs2fRXkPJ2qMEnRXJ+ZK2YTIGTwRMSoLWkXdh/zguL1GeSBUq56hBPjF53tFITKJmU
         BeNxYPT5nAfJXojWcq0cQCqyGByCCFcUcqFKUMt6traTSouIXoAqW8TKS2bgmPYw4PQ+
         qp1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAF76DS94mQi+WEQ77O8QeghCY7jtAJET+YF1AGvtK24F+iLqISO/bFY+gmr6XxMoYa/YYtUlZ6h93jxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAPFNVxx5P5bt04iufmP8wwocitxFFtI24Z6w6w3QGXrFGBWvo
	cKwXXYPWgAQV0qiVsdbojYm/h4MvztFRHGnw/C5RInGA1+sWHkYgh7eKBd+nZWhVInP8a0EUa+7
	qt0dSAx4+IYti3A==
X-Google-Smtp-Source: AGHT+IFIG0gC6T9675dCmegtaY0L5BmkaAGeW2VFfFaytKhag7Dsd/K9/9UQu4Fc/DMzpiBiGGv/ALcBuZgksDA=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:8eb7:e10b:a91a:5384])
 (user=saravanak job=sendgmr) by 2002:a05:6902:2808:b0:e26:3788:9ea2 with SMTP
 id 3f1490d57ef6-e3824775f45mr170710276.0.1731711912865; Fri, 15 Nov 2024
 15:05:12 -0800 (PST)
Date: Fri, 15 Nov 2024 15:05:07 -0800
Message-Id: <20241115230509.1793191-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1] spmi: Set fwnode for spmi devices
From: Saravana Kannan <saravanak@google.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This allows fw_devlink to do proper dependency tracking for SPMI
devices. So, better deferred probe handling, async probing, async
suspend/resume, etc.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/spmi/spmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index fb0101da1485..3cf8d9bd4566 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -517,7 +517,7 @@ static void of_spmi_register_devices(struct spmi_controller *ctrl)
 		if (!sdev)
 			continue;
 
-		sdev->dev.of_node = node;
+		device_set_node(&sdev->dev, of_fwnode_handle(node));
 		sdev->usid = (u8)reg[0];
 
 		err = spmi_device_add(sdev);
-- 
2.47.0.338.g60cca15819-goog


