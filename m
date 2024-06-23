Return-Path: <linux-kernel+bounces-226365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E61F913D77
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80CD9B220C5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 17:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11931849FA;
	Sun, 23 Jun 2024 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGr4T6Ct"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1B11836ED
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165437; cv=none; b=Fg5eQajm3QkjjMtAOFd+OUXMICEcCCcVXbhffCdNrZKjrG4WHlb/evA1OSPrGowm3hI+JwHxljTRFUB3R478ChqVT7nbqQYHz3TvacJteGnv9T2XNEFGBQ9TWjQ8vxVQLO+PDSU9GJEh2JGFWpwxX8GL0NAwmPHb0fNrwbD7+hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165437; c=relaxed/simple;
	bh=Oqf2/LX2KvmZtP/r86VKLs2nphv9h8emvJrnjD6FL+w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TG7ycf8O0QweQXgjqY2otiOyzVAjdm4deXdFbWAWlKwtghxQcqNFYlwx5d249lF2qxf22dCfASJVUAtYt2oXrIUNh9WtyPiLL3YcavgZ4wsvdovAL7dyolVZvgnlYB5fnEf/KlX4lyW1tPpGK25br0cwp/kMniRDdZ0fLsMTWto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGr4T6Ct; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-579e1bf599aso469762a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 10:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719165434; x=1719770234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uBnm7LvNgBYrwkaanaOkw1aUgSe3s7OTZa0lQuB6rvY=;
        b=nGr4T6CtLAOx2Zas7E6/mSxndB45LtrrDvT6vQXt9LT3zMTn0rWBgVUOXOWMN/f6WO
         djIMY/u1hsu+BRrQyZ4bM6p9DDoBAwXS1YfRAtuueF2LfAE4cwm/mGUOt4XdchesER9P
         kfXs8Sos4af/sEwlUnnqjAU22AwfpMFeYE9X0Tz1PCM5PufIzwbrL/9s6M03z3XxZu/1
         P32T33OfK3ynFmPXk/RMkOAEdAliE21pJs2GsvoyqmlikyjkHqEd4FM6OirSsD8hO1FH
         2PSSMRmaawWd0Hy/4SQT/W1wC4No3NWC/ZVE7E9YJXiGlgKYdu6scsqPuYoKbsCxs62b
         FK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719165434; x=1719770234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBnm7LvNgBYrwkaanaOkw1aUgSe3s7OTZa0lQuB6rvY=;
        b=NthOXCCcckgG+BDwtxw87ObSiZfn+U9qKclfU+N06/O3cY5cR3PfxBK4lruZSkfR1h
         2ldBFZzwHcuSz2j/3JXbNIG6htliMQ2vQRR+osNM5+bD2cTvnYPcy4380nPTGHCpXTpZ
         sw6qF1L4KAc5nbEwKLwUB2u3FVrQqajxWO+gMOHLACJJHtLWNhfBfyFSXLCB9JsVr6BI
         EZiiC/7KeXhfx+xn6QDUGP8dck1Vc5b4xneXphGeeqP1uR8Gi9JrxiWYdzO3u8SBCGqF
         OsSG4Wp6PKqHD0gsgiBvYMuBSuYgyDQf7ZQgWITrf0u02yy+jFJBD+O2VBKJRE88piLQ
         8rkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWdayX4YlX2Qj7J/6AZ0GIbOBdDkdRefossf3aPsFqTv10RcBuyT8jo+xwdr2PoywYYTt3yvPbOphMs+Rl0iQYxSD6D30Y3ttToXyT
X-Gm-Message-State: AOJu0YwO7vyoauBoRCw1F9Lq19w7sXnNrsRUduXlgxdtO3JKoGbYCSOx
	NkTffVuEm+9ixmCcKLRWzf5zvpgCbnu9Ciay+4rPkpoeV/sd5A4QBmQHLA==
X-Google-Smtp-Source: AGHT+IFxrn9qTyBBQfpSZhcWaD2ZhACotZf6ckydRfDUWHKnU7piVXIWC/5Ll42iH0w3xAop+af6ZQ==
X-Received: by 2002:a50:cc8e:0:b0:578:6959:9d36 with SMTP id 4fb4d7f45d1cf-57d4396a17emr2282888a12.0.1719165433815;
        Sun, 23 Jun 2024 10:57:13 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d303da378sm3684703a12.18.2024.06.23.10.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 10:57:13 -0700 (PDT)
Date: Sun, 23 Jun 2024 19:57:12 +0200
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] staging: rtl8723bs: Remove empty file sdio_osintf.h
Message-ID: <1536950be4d4e4fc4757e10070ffc38c0158f808.1719155208.git.philipp.g.hortmann@gmail.com>
References: <cover.1719155208.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719155208.git.philipp.g.hortmann@gmail.com>

Remove empty file sdio_osintf.h.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h   |  1 -
 drivers/staging/rtl8723bs/include/sdio_osintf.h | 10 ----------
 2 files changed, 11 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/include/sdio_osintf.h

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index ea6bb44c5e1d..9e6ca1dec525 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -490,7 +490,6 @@ static inline u8 *myid(struct eeprom_priv *peepriv)
 }
 
 /*  HCI Related header file */
-#include <sdio_osintf.h>
 #include <sdio_ops.h>
 #include <sdio_hal.h>
 
diff --git a/drivers/staging/rtl8723bs/include/sdio_osintf.h b/drivers/staging/rtl8723bs/include/sdio_osintf.h
deleted file mode 100644
index 198cf3889a27..000000000000
--- a/drivers/staging/rtl8723bs/include/sdio_osintf.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#ifndef __SDIO_OSINTF_H__
-#define __SDIO_OSINTF_H__
-
-#endif
-- 
2.45.2


