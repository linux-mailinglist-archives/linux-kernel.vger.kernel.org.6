Return-Path: <linux-kernel+bounces-322456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545BF972926
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04365B23ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D8E172BA8;
	Tue, 10 Sep 2024 05:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrCFqvci"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE4617BB08
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947889; cv=none; b=PteGQJjcbX9KV4jldKQ0l45QfkClnrW0qmCWuRoXFy9yUFTRHjll5VvUo7MR/VAu17ntS8AbrWUXkv4sHNda9mQv/K8outGH6HcVmhgkyZUq0gjWX5GWqHwZI4FGGce7tOp4hOrQ/EcUgujF/fYuMVip4rcNqdLn1ds0aAHv5Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947889; c=relaxed/simple;
	bh=XbUDZ8IUfkfJObJ2330aHQhyoCJXctwLXkp6mrx3Vhc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i08kBCkWKHYdyE2vGDS5oppADoNX4ON4iDiHVRysr1t0ndrDQ4DBFnB0G7GKR0TraETxyNMVoeNzPT1aWEFAP2rdUO7guAznb+NumQF5FuQ5JHPCvk5bL06EUrq+vqidygg3ZoKwN+LUHqsJZHbSRyGZ/UCT+bCnoN4YbHDN+Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrCFqvci; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c275491c61so6401647a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 22:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725947886; x=1726552686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gymUfn5xiGysGwdz/oGmzYjODxt8QZ59eag7p59pDaQ=;
        b=ZrCFqvcivLmnKFH+LV4mmteqkwVfQo9DLO3oXfyRCFR49Eq+AWsn1DcQm+FZFRqB9F
         5/eJNvvGXbG/rryhyauY4rjEjT0COmxaNT/AxLZPCoiWNH6f0Ud6o+8Wa2qUIZpSkhiC
         apBX3bT3/z/UI9NBRKg/JBU4InMd3DDph0u4kde/S8xjHBVQRPf7622oPZMEhu67Af10
         x3MYgKU4xTCF4ycvVS9hCsBFINNttgtD7itkJ2gCc+5enUlKZxUL72aFm8gfOhUjY4GR
         RbaXPi0rkf2fLidDZLcgJcHBHxBmDhZ8CsAV5Tl1M/r9hzZ1luo0UBTSF5qsOXnYTZ9c
         ErUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725947886; x=1726552686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gymUfn5xiGysGwdz/oGmzYjODxt8QZ59eag7p59pDaQ=;
        b=ABIdPGqgzTkODFI4n8Jm7tvkpEtuecS/vrL/LSNIhGO3wDv+jiudazYlEsUowt8QDc
         YTGiQoG5fI28oIMxnBtMyaTVh6uzDr6WSu1OkIWdDfNkWsEs+x8Mm8Q8Bqo2yhP5DrUK
         qVQ8N/k1n1ylwFKE4s0y2MwMJ6AHo2urq1aig8e1vH5/k7P9XkrnhXlKfLPnqiesT0op
         /j15lVw49E7xDsg4zy6kfPnGbuWGYmvWkE2Xex1A9H9pHH9tyx4cUkv4e/43/OGUkeOk
         lRQujK4zfAta25E2hfBGwLUcAV+iJbv9SXVxs22ZxJoAhtlsBv7eIkT0jBAgILZJXKZU
         CGhw==
X-Forwarded-Encrypted: i=1; AJvYcCVAHMAPaSwyCstKyu5zitfc6q5dTqxl7eyuI6H+YUGv49fblG4phEaPyaO6a7FQCGcS0OKf5o8FpLDB56w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDantw/OoaCR++owiywxwyz3ngn3pQxdpJtUVBJC3uuY3D8X/+
	EO1o/k8plKfEEu65+TQxk6nHHOOnTzAw8WsgP9MYjqw7ARe8QD+r
X-Google-Smtp-Source: AGHT+IFwh6iTk9qx3mUae71uO243EOgHfbIaTK31+auI1yyebCID3qhRzK8HuXwMTLz8FNnuofuIKQ==
X-Received: by 2002:a17:907:72c7:b0:a7a:a0c2:8be9 with SMTP id a640c23a62f3a-a8d1bfcb437mr1355333766b.18.1725947886117;
        Mon, 09 Sep 2024 22:58:06 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p200300c78f2a8598b80c2d4e9a813f29.dip0.t-ipconnect.de. [2003:c7:8f2a:8598:b80c:2d4e:9a81:3f29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2583f73asm431679466b.7.2024.09.09.22.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 22:58:05 -0700 (PDT)
Date: Tue, 10 Sep 2024 07:58:04 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] staging: rtl8723bs: Remove unused file rtw_rf.c
Message-ID: <2a31866e3e6f65e90d612f7473501066f6bc5937.1725826273.git.philipp.g.hortmann@gmail.com>
References: <cover.1725826273.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725826273.git.philipp.g.hortmann@gmail.com>

Remove unused file rtw_rf.c

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/Makefile      | 1 -
 drivers/staging/rtl8723bs/core/rtw_rf.c | 9 ---------
 2 files changed, 10 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/core/rtw_rf.c

diff --git a/drivers/staging/rtl8723bs/Makefile b/drivers/staging/rtl8723bs/Makefile
index dbe6ed3b9f0c..ba200ee669f3 100644
--- a/drivers/staging/rtl8723bs/Makefile
+++ b/drivers/staging/rtl8723bs/Makefile
@@ -11,7 +11,6 @@ r8723bs-y = \
 		core/rtw_mlme_ext.o \
 		core/rtw_pwrctrl.o \
 		core/rtw_recv.o \
-		core/rtw_rf.o \
 		core/rtw_security.o \
 		core/rtw_sta_mgt.o \
 		core/rtw_wlan_util.o \
diff --git a/drivers/staging/rtl8723bs/core/rtw_rf.c b/drivers/staging/rtl8723bs/core/rtw_rf.c
deleted file mode 100644
index 2aca45de298e..000000000000
--- a/drivers/staging/rtl8723bs/core/rtw_rf.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-
-#include <drv_types.h>
-#include <linux/kernel.h>
-- 
2.46.0


