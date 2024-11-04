Return-Path: <linux-kernel+bounces-395321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B76C9BBC58
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5AE1C21462
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57041CB9F1;
	Mon,  4 Nov 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlO/b9fZ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C291C9EC9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742632; cv=none; b=k7de5W0tp6WkLuuEVnm0enL9GVxLwEDXEd5GWSsP8K/jnnHH+0u34Gor854ilNn/bmtPBhuHBuQTEgQVLPWqkV/WnaK/2bTjROFOnzK/KvfKpgYGP+Tlox4lOWoIZ9x7yC1nASW8vyaWFs8Hdncn2jEy4COPmG2cK9mg1kFmsDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742632; c=relaxed/simple;
	bh=DbDP9y+Z1Z92uli2XTbO36BvaUcaMIE6LpjBRU0RiLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxVcYZOYhrCR/ITkvymMjB1goNBcvCkSJkFYOQoW4kvVO++ZwUe/E5M8iUbOtTRAoCGoj9g8/5FKKlkg34qVJRPdEsAUeNHstwlax/kDCyFpSjivGJ+1GkGUX1niNWMnYJVByIIRrGndpC3kmYrKa1vnxd+34927sUzEhtOaMyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlO/b9fZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so35215105e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730742629; x=1731347429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajwobQL/OgHCeHlEBCD2gk8z11jb/W4yobyOVkJlzRE=;
        b=dlO/b9fZGuIPKqg8MDL8FbMCKQ8v5rHzcoEK/qKKiKNi6Sp4RrudmaktFf/qAAxNUN
         /PJ20ug+Boe8FZ9b6IwKcl8JBlaEWFKD6ArknG2BJ751te0mm8SnFh4cmFfNZqbSfVbu
         Ks9EeHD66oUK4W8FUo2AXnj4MNNlqOP9z9OMeAJeRIfC6PDSeajG9Xlhb832ZOnIKBIS
         JS/T5zPTSjNpiX7ZvxoZaT8nJEQNPKXK0S96f6oNvhgNdNyrxhm0D8WH+gzaom7aLCiW
         x6wM5zI3+xJMmb+m6+bP+rjvcLqV2g2LJzF6lftvNv61aZNPZGwffl0RCQc1vCHu/A35
         1L5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730742629; x=1731347429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajwobQL/OgHCeHlEBCD2gk8z11jb/W4yobyOVkJlzRE=;
        b=HdYE48k2zJf3qIznq+6kjdu9BHPxeAVSJV60SKYGI/6t38hKONl8SYltg7HMFe1gSw
         lLpiFWVoG2foVP8OPj782KCX10EEnV499MKR9j8UPljVXVJvDXAm5qfKrrDCuFwt0lWW
         QfOQcip08Qm9ZWK46pvp80kOnKmVJ9te5ToqOsZlAsdklN7V6wG+xQtEAZWQobvwkYfs
         wR2a9vqjH3cJ/4KfUpjHReqSFWlILSMLuQ8aqVVz50hikxMCmcAWAP1BdiYxTbkponl8
         5j69IR9o6tYIftu6SItuV1EPOl50Z938r2LY/lMD8zfMnFqEZCiandgzoyZZRldKKs19
         M4Ow==
X-Forwarded-Encrypted: i=1; AJvYcCU+CR/QTAHYhs2od09nZ2qxv+hSWRNysmX8mCEPz7tUKoASM+N18yKua9RPTcH8NLvfuYlIRjcOC1fRjNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLBOGWCPU07WR+ET/bXrClDiOYJ5jcZg+ZYWUoflYC4Zm6zoSk
	5pF3B2Mu+CfoB7Mj10azvgG4AO+FZTq0VhdZJiGS3vncjAk+uqwe
X-Google-Smtp-Source: AGHT+IGfQ7FGigP66UxM4jE7vbTR2gUi72gYyh5y6I0lzwKLSM/mt/Hrbte9btOApFKFU7UAC7a2eg==
X-Received: by 2002:adf:ea89:0:b0:374:b6f3:728d with SMTP id ffacd0b85a97d-381b70f06e5mr13351906f8f.46.1730742628908;
        Mon, 04 Nov 2024 09:50:28 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7f80sm13839821f8f.20.2024.11.04.09.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:50:28 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH v3 05/12] staging: gpib: Fix MODULES_DESCRIPTION
Date: Mon,  4 Nov 2024 18:50:06 +0100
Message-ID: <20241104175014.12317-6-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241104175014.12317-1-dpenkler@gmail.com>
References: <20241104175014.12317-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use plural for adapters

Fixes: ad59cf382cd5 ("staging: gpib: add module descriptions")
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/agilent_82357a/agilent_82357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
index ca9c938284c9..02c6ec9a42a0 100644
--- a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
+++ b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
@@ -15,7 +15,7 @@
 #include "tms9914.h"
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("GPIB driver for Agilent 82357A/B usb adapter");
+MODULE_DESCRIPTION("GPIB driver for Agilent 82357A/B usb adapters");
 
 #define MAX_NUM_82357A_INTERFACES 128
 static struct usb_interface *agilent_82357a_driver_interfaces[MAX_NUM_82357A_INTERFACES];
-- 
2.46.2


