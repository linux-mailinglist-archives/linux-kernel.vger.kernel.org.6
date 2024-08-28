Return-Path: <linux-kernel+bounces-305802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0449634AA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65121B2282E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C24B1ACDE6;
	Wed, 28 Aug 2024 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDh+99WI"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2651AB51F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883946; cv=none; b=Zf7BugrUfOsi2NzH9T/+mlu2g2eRbH1vfLqmKnjQiKMpzBZ1ZnyuJbmwoSkNANxz5ZG/oyr0jdVqSU7Nmdatc26IieYzPNOpEyGg6AMAn34gg2AGoSfrPZaA53dwogPFNDnOG160jYZFYpEwjXJMObRsfLzl/1aYl/u0c+iZx1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883946; c=relaxed/simple;
	bh=NxBXD1LHMPtJRJVa9FufP+3VCVPwh7yiyPstEVnPyhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fer2Rm3u8HknetKYAJwvVJOl5nOmp8j2D7LfipENJhoIwnzmi5LiY82wNAo+i0/Fxe4Lhzes8ZPUDtrPU1MXK9LAO/1sSDCcs/rjFsxMjZxCE5bBDsZK6lM4zXJA4BTicSYnY2ktSVLafADJqcbF7SVAZ7HO4g/chikJdXhgOIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDh+99WI; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d3dc25b1b5so4862875a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724883944; x=1725488744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4KuWpHNVVOIDuI2uNCaQcrmkzfLb+gZ5UqSaZNidUc=;
        b=aDh+99WIN0O9aqc56VGLKUDryE2i9CSMxhqq3promeYKqvJSTr+IgzQszvtOIj8Jgv
         bcJaei5gcz7L0RhktI0I2gdtEaJmhqVh/9PftUw6UkxfI9wHEraYYfeIZQkNuVkPMaw6
         6BQ9hAn2FkzCex9BT5o24fn4f7NYtpRo6zJ5tT7ddP5X1YbCjEAORsUfgc9knzV/lKt/
         RrB50n63n8tUXdwooBj171DvsoWTYyaoejHLQolBr1DrAu9KJtGDTwXJ3ziSJo8BCHos
         b028g2pjFQwLFL8Xs/ytWR+7Yo8Y5OLv7B6UcChDx6SURsJACpiF5dyBiAtqW21Av86W
         LaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724883944; x=1725488744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4KuWpHNVVOIDuI2uNCaQcrmkzfLb+gZ5UqSaZNidUc=;
        b=dLseJ8IB2FXRiXueMjVqkenVz0HU1UM1HE11Ox3/2D+aa3eobN6jSagGCPbiwsvrWm
         vlb1PzJgA6Z9vA9D94D9BkXLtSfWo7UwRRLVU6tnVB5zTa86TLTX+3EuvwiE1MvNTU3X
         FlNlgBqQCay6HB4Mis7yuAzxueXs2NZurJXvf1Q+muf6SyTLRewneE5HwWuXIeoyNIPy
         +35aylDgpyhD3lZkqRYxjzkhWGz2jrx+18cy5awpgzgZkNnzTFkMG/fIVB+bpkxsiI0e
         s2G4RQMz68RLMMtOhY6Xrrh9DuWMPR2idCh9BiHX4qky27oJISQhgSxSg78O+axjYxRl
         XEXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlZMF+sucU6nr8R4E3Cw692iciG0dM1HfGsuu58Z9hiLvSbdX69pa57SOFR3RDIJyXvGs7cJtmAIWG/jA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwavYnaZMGUbec5B0Ga/ob6DIH5ofvPinWftKVPKB+L/rM9if5O
	Xgn9hkfz/vH34XZ5MClCIlBLnIq7MHI96FEXjnZ9fgUWHCaq4YPZ
X-Google-Smtp-Source: AGHT+IFhfDQK9LKNi8Kkw8kWblPJLQsH+F/3qt3zGSOshQUrm3TWKHb1BUm98BHh249k1FpbQY6ZUg==
X-Received: by 2002:a17:90b:286:b0:2c7:f3de:27ef with SMTP id 98e67ed59e1d1-2d856503bd3mr737949a91.42.1724883944584;
        Wed, 28 Aug 2024 15:25:44 -0700 (PDT)
Received: from masingh-thinkpad.. ([49.207.54.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8446f3897sm2460744a91.49.2024.08.28.15.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 15:25:44 -0700 (PDT)
From: Manisha Singh <masingh.linux@gmail.com>
To: florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: philipp.g.hortmann@gmail.com,
	Manisha Singh <masingh.linux@gmail.com>
Subject: [PATCH v3 2/2] staging: rtl8712: Calculate size from pointer
Date: Thu, 29 Aug 2024 03:51:55 +0530
Message-ID: <20240828222153.68062-4-masingh.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828222153.68062-2-masingh.linux@gmail.com>
References: <20240828222153.68062-2-masingh.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calculate the size from the pointer instead of struct to adhere to kernel
coding style.

Signed-off-by: Manisha Singh <masingh.linux@gmail.com>
---
Changes since v2:
        commit message updated.

Changes since v1:
        Broke the patch into 2 different fixes.

 drivers/staging/rtl8712/rtl871x_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl871x_io.c b/drivers/staging/rtl8712/rtl871x_io.c
index 378da0aa7f55..20e080e284dd 100644
--- a/drivers/staging/rtl8712/rtl871x_io.c
+++ b/drivers/staging/rtl8712/rtl871x_io.c
@@ -48,7 +48,7 @@ static uint _init_intf_hdl(struct _adapter *padapter,
 	set_intf_funs = &(r8712_usb_set_intf_funs);
 	set_intf_ops = &r8712_usb_set_intf_ops;
 	init_intf_priv = &r8712_usb_init_intf_priv;
-	pintf_priv = kmalloc(sizeof(struct intf_priv), GFP_ATOMIC);
+	pintf_priv = kmalloc(sizeof(*pintf_priv), GFP_ATOMIC);
 	pintf_hdl->pintfpriv = pintf_priv;
 	if (!pintf_priv)
 		goto _init_intf_hdl_fail;
-- 
2.43.0


