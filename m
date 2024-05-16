Return-Path: <linux-kernel+bounces-181610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728DD8C7E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 00:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F191F22421
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 22:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178BE1392;
	Thu, 16 May 2024 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="BzltlsmX"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5DC17C96
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 22:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715898644; cv=none; b=VnmXuDeOYSokcBldJek1T7FooDSuuFAVKTopo6q0K6d8QSsFYnGf96LfsLv0E80Na+f/8jL7MbF6KUI3H5KKL0tSr9NkxkefeIe3A6XIp3zTiZKvpV5omNdhKtJYH2HxhjgM8AGcFs5utwzGU4rE905VmT3Hq9uCdVNUFLVI9qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715898644; c=relaxed/simple;
	bh=ARToXvIE+HNxjlISN2Q5kpBnckBx7xHvzr6gl6pdKeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAi1Raiswwa84N4nBReVdQ5pX3kTYztEjEz5Z0xgM7cCXJsBlpD59ik02TMBpZIFh9RAjGe8dS2st74Rqxe4nh9/elppYhduxqNHvgtxQudUEzg0RNXghsgG/rsoYSEWDHA2qr/1GAH6j5S9k+AA3AuhfLpTm9htC5jP2jl/lnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=BzltlsmX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4202959b060so10560405e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715898641; x=1716503441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/pJoZ2a5YCYk2F2tN9UoeXrlA20slErIO+lZsiZXcs=;
        b=BzltlsmXQ6vi8sVTUq5D2QrxlEpTZJSSdOUf6qHRvrz6CfzxoFH42DmY9HvamiNDuV
         m+zelLoJOt056nQ/K3sBW8NWSsEuIhwNmDukqJIZc5Nd2zjhhINCfPJNz/T4AMGYooT1
         L9Oy2K07gvPZBjRkzoZ6R03tQ87UN/7q0lGgR9gedBhN3csUFp9/mxLXwhyT1SxA4HFQ
         YinqO+67KXEOBI/Xuqds5KMmeU+qTuTQc2J8bSPXHxHJi1OcdPy+yapOZH2mWK7MVt50
         S1s20nbE7HYyLRJlIzrvYDrINclWWRwdKdi/p7T3HHflpdh3Hiz3Rto5K98QSJ/0FkPu
         1e+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715898641; x=1716503441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/pJoZ2a5YCYk2F2tN9UoeXrlA20slErIO+lZsiZXcs=;
        b=DNSMOs/kzhPWUXe5jz28AAkVQV4feKjGRRsrHiubQm3GCpQBb+2R2t7kNp6wS2XvR7
         KUF/wpiCXasK0v7Rc2tR5kCE63CjKgMeOqYqbS8m9x+baCcPRXZ6kjEWvY36H4b7ySau
         dJpRvLAajEMOKaX1G1XDy+GRz8OqGZZssMqddhOwEToEQ3Y6/q7WtEmQuB+Ll/BLJDM4
         4kgZNjDLkMbc0jyBGi+G5Zx73uWDQdGIeMLW4WBNuzeYrIe9XL9UiKjmq54t9wBI8zo2
         /QRMPNoENBYLic7FnO73IyiPY+4ViBhTkHNBaLcuYuurGhF0egEX7AVr4046m7Fa1SaL
         fqhg==
X-Forwarded-Encrypted: i=1; AJvYcCWRrWUivnunHKz1u1ZR2s5KdGEWWcar0ddiHdbNVC2oxTdB1KLeENi4+LKiLygRtLFKwFrksSMVvIGW2v4TW2Sf8r7p1d+Cj8GKPxvD
X-Gm-Message-State: AOJu0YwTXUjO8TbRX3yYLKYThvn69gJ4ad5pbMVfvaolvifmdDpX9mIc
	9YDHGBXbRTxfZBLSw0TVvAscXw+1frDGJpzaLzY8wFk4qC3K73dTUE8XFJLyDJ8=
X-Google-Smtp-Source: AGHT+IHbPX5/3T7ar9n1cgBRC/2xKml4wWUfAaWFjopc3F3/eOT++l7eIvrTF5/7vAE6QEhknFIdkw==
X-Received: by 2002:a1c:4c03:0:b0:41c:5eb:4f8f with SMTP id 5b1f17b1804b1-41feaa38a6bmr148836675e9.15.1715898640745;
        Thu, 16 May 2024 15:30:40 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4200f86ab7csm206682585e9.19.2024.05.16.15.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 15:30:40 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: andrew@lunn.ch
Cc: arnd@arndb.de,
	davem@davemloft.net,
	edumazet@google.com,
	glaubitz@physik.fu-berlin.de,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	lkp@intel.com,
	netdev@vger.kernel.org,
	nico@fluxnic.net,
	pabeni@redhat.com,
	thorsten.blum@toblux.com
Subject: [PATCH v3] net: smc91x: Fix pointer types
Date: Fri, 17 May 2024 00:30:05 +0200
Message-ID: <20240516223004.350368-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <0efd687d-3df5-49dd-b01c-d5bd977ae12e@lunn.ch>
References: <0efd687d-3df5-49dd-b01c-d5bd977ae12e@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use void __iomem pointers as parameters for mcf_insw() and mcf_outsw()
to align with the parameter types of readw() and writew() to fix the
following warnings reported by kernel test robot:

drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect type in argument 1 (different address spaces)
drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] __iomem *
drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect type in argument 1 (different address spaces)
drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] __iomem *
drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect type in argument 1 (different address spaces)
drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void [noderef] __iomem *
drivers/net/ethernet/smsc/smc91x.c:483:17: sparse: warning: incorrect type in argument 1 (different address spaces)
drivers/net/ethernet/smsc/smc91x.c:483:17: sparse:    expected void *a
drivers/net/ethernet/smsc/smc91x.c:483:17: sparse:    got void [noderef] __iomem *

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405160853.3qyaSj8w-lkp@intel.com/
Acked-by: Nicolas Pitre <nico@fluxnic.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes in v2:
- Use lp->base instead of __ioaddr as suggested by Andrew Lunn. They are
 essentially the same, but using lp->base results in a smaller diff
- Remove whitespace only changes as suggested by Andrew Lunn
- Preserve Acked-by: Nicolas Pitre tag (please let me know if you
 somehow disagree with the changes in v2 or v3)

Changes in v3:
- Revert changing the macros as this is unnecessary. Neither the types
  nor the __iomem attributes get lost across macro boundaries
- Preserve Reviewed-by: Andrew Lunn tag (please let me know if you
  somehow disagree with the changes in v3)
---
 drivers/net/ethernet/smsc/smc91x.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index 45ef5ac0788a..38aa4374e813 100644
--- a/drivers/net/ethernet/smsc/smc91x.h
+++ b/drivers/net/ethernet/smsc/smc91x.h
@@ -142,14 +142,14 @@ static inline void _SMC_outw_align4(u16 val, void __iomem *ioaddr, int reg,
 #define SMC_CAN_USE_32BIT	0
 #define SMC_NOWAIT		1
 
-static inline void mcf_insw(void *a, unsigned char *p, int l)
+static inline void mcf_insw(void __iomem *a, unsigned char *p, int l)
 {
 	u16 *wp = (u16 *) p;
 	while (l-- > 0)
 		*wp++ = readw(a);
 }
 
-static inline void mcf_outsw(void *a, unsigned char *p, int l)
+static inline void mcf_outsw(void __iomem *a, unsigned char *p, int l)
 {
 	u16 *wp = (u16 *) p;
 	while (l-- > 0)
-- 
2.45.0


