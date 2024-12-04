Return-Path: <linux-kernel+bounces-431447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 093DD9E3E20
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1FC3B360C3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B532F20B7E4;
	Wed,  4 Dec 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoF8Z6HD"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E4D1B87C6
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324262; cv=none; b=iVfXE/9YTWfA2qmWNUCij5GtuA1HHjT496Hhi8gF9zs5nZOXmSTtMYFEu2gQGFb409SZucn60csXucD8eZHSoRkRXFOiKZjw6j55DlhIaM4XIwD36K9UClUnBNnyPaa+BGysIoEYC4meFqS1zC/nDYCEKFudNZeTOboJZZDq+gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324262; c=relaxed/simple;
	bh=zFemeNdsXzisgsvq89lAZ24CodpGYNFEybzOY0BuMW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drjCSOSOet8xUFCLcb7KuFBbGmO3KTdnuiVuMqJSJA8ASPAXqhoGzrRyd8xkRQ/ATxH4/q4vH0uhINP01qwY0A+K1sMAoP/Y8VDTnBrvf87HdWwlzz18ZZ4hQe8cQfm9vDiw1VEE4j+8nDkVSfndhEDnEuAKqQEBGm1BkKe6B/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoF8Z6HD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso60071595e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733324259; x=1733929059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXFeRuSiyz1DRjRD/WJqw7AW44WiOtldoytIzy/FhN4=;
        b=hoF8Z6HDdmhcsB7TU5srL8zpUlC9hbgs+ydkFbI/jrcdVkdQNrHyLUzSmLNZH+qYCp
         3eQGSB9eXGagS5JDsOiHEwWFiAmsl2Kw6VhGIuAwAJmWmH2g2ZccSAlcS/MkCl5cEta+
         KDw08ZyRdu6MbOoRcJ2Nmuy8nzP1/KFr9x+gM0ikZ4W8eY9VR69cB6zgMFFFvfZwTz2a
         N0s2Wn+OdRv98tCs2AUrEtoFuF2i0XW+J6cyyRWwIy4CYwJ/h2uYIBHcprWX9Tz9gr9K
         KbIXGDYQPk1LGlR8QxIraK1gbG7BAp5/jfC8J6bvz9aN1tF+Dkq7rxJt7CGJoP2rS8XC
         CuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733324259; x=1733929059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXFeRuSiyz1DRjRD/WJqw7AW44WiOtldoytIzy/FhN4=;
        b=MNiYrvmSKkmOFMfCyuxg6kQ1IESkdd/V+BXMOX6+xaDoFs0gyYLc0Hm/xVIwljmvIj
         BWG3Smxt8U4tUOgP+gWttdBJ87o/+aY8AiMKMzc27/wFTqnEondFGn0nUCCtQfX2VtAA
         kBWRpZAy6piJ+vRrtjOETVwgOgUF2oMhf/WjAHUfOgJWSQ+m4u+EIEMwLN7rnrJKitC0
         sYqscWtevl/ris6rKYjyq+/Im+L3YBXnEiYRhz47CaYbaDYHKYs1ul0+kr8zsUX4VVmC
         wMVaW5k7kGkb95QkjA6UiUETQpjnSw1LI4kbOAj3cw8TQBSGGr8a34lyPjSQGvV0KZAQ
         gYLw==
X-Forwarded-Encrypted: i=1; AJvYcCVBJXZ84iBgyyR5tsmrJWS5YR/60QlOV5J8WzeCm7VHniApu2NdQYCf+eUdMjQIZNSJxcoy7vYha+EhOu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY5+BGxQ5yQaaSHkHzOdpT4S7IE6lGTaOWriowA6u/Nnw922Fc
	RShRnKa1aCF7g8DDDeAVBH/8l8cYcx34PmhjCjBGj/Ag4B0Cz1NB
X-Gm-Gg: ASbGncuOuclof+3B3WTZFaVOwHCogSGikpmtsMcsL0OxHAdlQxPk18NEe84yU5w/655
	WpSnvNYHX69NrztahP4sKZBERQQuibtJAtndtQ+0zGSh14gy0B+3nNeAOYS36r/1D8jQiRRRg2x
	UEOZLcIS39hl3hGLQK0r1uLGbJTuqSHfsFdYROOAwICRxFp9V8LAlvC+5vBygMpLg1wMHAaDhEN
	FqDyIpscGVQKwqu0//YJI1srAWqLN+eq6XOcvZWRVlwMBsYo8UDkgoryzwfZSBrbG5gVuXRidc5
	+MIhrn7YGQ==
X-Google-Smtp-Source: AGHT+IG8q8m21NtDLtnT0gBHFFs2L12/0kB0ww+aIagP3w4RBI0B8SsVIBLeWzwN5TQVY0ufkyKGeQ==
X-Received: by 2002:a05:600c:4e8b:b0:434:ba13:e545 with SMTP id 5b1f17b1804b1-434d0a1505dmr57315045e9.29.1733324258485;
        Wed, 04 Dec 2024 06:57:38 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d527e8besm26678955e9.13.2024.12.04.06.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 06:57:37 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 2/4] staging: gpib: Remove duplicate include
Date: Wed,  4 Dec 2024 15:57:11 +0100
Message-ID: <20241204145713.11889-3-dpenkler@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204145713.11889-1-dpenkler@gmail.com>
References: <20241204145713.11889-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

linux/uaccess.h is included more than once.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410110406.mQENnj09-lkp@intel.com/
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 9a3271e885d2..47db17418a74 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -24,7 +24,6 @@
 #include <linux/timer.h>
 #include <linux/delay.h>
 #include <linux/sched/signal.h>
-#include <linux/uaccess.h>
 #include <linux/usb.h>
 
 #include "gpibP.h"
-- 
2.47.1


