Return-Path: <linux-kernel+bounces-175005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D5C8C1892
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D28D1C21DDB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 21:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87B9128826;
	Thu,  9 May 2024 21:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="eTVqphzn"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BB085264
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715290933; cv=none; b=APdez6dlGzOEXbeYZpmosF1e0D7ASqwS6XgsvZ+lXKch014u04Zu07C6XAVr9LL7mt8M81SpjbBZzuUFYxn3ri8V7VGHMuXmNLBGUIFhhUps2MQoj0iZajHkMDFyJgeayphfmCToQZyEf2AOWyHFUT488zSy43R6Mtg/owes8lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715290933; c=relaxed/simple;
	bh=wP+7wj0GQxTLjS1RBn+5MHXwXji8frVrT0a+yqSGftI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6HeQkGeMqiVttMja5U9JJsY7lU3+LteCqzmxVXZgYJxBfeRsgYgpNOI/SfxnXpsTu/2fnlVTmoexjko+vsdib5oZPju/FGfxAUdqP8zSvP2cyjP+YfQ1jSAuuea6/FubhuCMI7FJfDsdkH2JUYEZh+r+VmrZWnSM4xPeZfX//k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=eTVqphzn; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a352bbd9so241514966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 14:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715290929; x=1715895729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWiEw6OZOjWrMlF7JIfpMQ4VjNqi64jS5UnPYz95OZ8=;
        b=eTVqphznEInDiS0VczP2VH9UF64/BJfL7J8XhAWxO57KqR8nM9Y+bdEcdMyBeRLpGO
         FqEih12Qf+pWy1tJ2TEspOFyl9IxqiNMAFJzzLNsNizHu4HFP9edfEJH1+1/RrYTe2al
         HGveGpWjcynEkH5L1g2f71izsxYZPr/dSUcxfmiTma3KYoaZqKmxyNeh926LdoF3xVoD
         nFTI124ZrMkDlYKeq1MMFQK8bw1ihoIbXkdCd3xQw9GPp2UoVapytDiYmFCe+dTetnF8
         JAbu9x4GGg4+cLPMWElH6S1V/ob93h1wuOwzdyTq4PDR7ZGKg7yMvgdnCZY9PB42FWPJ
         KXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715290929; x=1715895729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWiEw6OZOjWrMlF7JIfpMQ4VjNqi64jS5UnPYz95OZ8=;
        b=NcVLRDup3thOTNA9jShSE/MFGj6mkoizmXwob+FmwNXSATpaVom3DvA8NReAJagx3f
         VWXquMt6dO2M0htFIQkc/WKL4ArhDhLYIyGLC368r2gR3DG8xcPtv5uxsDJDpF4vQazH
         lMuZ3HKQ8N1cFPoeswhT7NMDipWrX6MOShlhEN2E/FrUlEH5JSSxwZ7RdCx9Yax4ojXB
         10nGPaafmVakj+0u3bPCiJdVMeBNXXuGXpkvTOl6n/eiPAqLFAUhCTT8rZ2vOzFjgY4c
         tE2j0u1t4VWBm8EwWX0wFJRfT4Zhlx6UFyJ2bszalkcqkCpILDB9sZt6Z4L2a9+SGaOo
         rxKw==
X-Forwarded-Encrypted: i=1; AJvYcCUq40TGPzjtpJauxTC0wV4zUicH64Dx8NXn4q5Qg5CopUd6Mn91gSHO2re9LuebPfAjjFC9OTysC7UZvAbubiGfePbXBYWmri+WUzGV
X-Gm-Message-State: AOJu0YyOBtJa1LW1rM0LL6T737kyDiest/IzmzFHZK9BFoR6DeaYQ9eV
	hk0GM/d1k1C3suvpBW75FaNPUc60jdKuMTRQul4hnQaqV/NCCkVQk4YZxUEY3pg=
X-Google-Smtp-Source: AGHT+IGTpPDGkQCDLZt6tcLLMFMDJc5KKSgY3+50vm30L4sanYzfyVqp2bPZ6X5+JuA63Tj/y5DeVA==
X-Received: by 2002:a17:906:5613:b0:a59:ccc3:544 with SMTP id a640c23a62f3a-a5a1155b4f4mr356392966b.2.1715290929531;
        Thu, 09 May 2024 14:42:09 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01598sm116496666b.178.2024.05.09.14.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 14:42:09 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: arnd@arndb.de
Cc: davem@davemloft.net,
	edumazet@google.com,
	gerg@linux-m68k.org,
	glaubitz@physik.fu-berlin.de,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	nico@fluxnic.net,
	pabeni@redhat.com,
	thorsten.blum@toblux.com,
	andrew@lunn.ch
Subject: [PATCH v2] net: smc91x: Fix m68k kernel compilation for ColdFire CPU
Date: Thu,  9 May 2024 23:37:45 +0200
Message-ID: <20240509213743.175221-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <2ef3df08-ffc7-4925-82bf-0813c8b0b439@app.fastmail.com>
References: <2ef3df08-ffc7-4925-82bf-0813c8b0b439@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Compiling the m68k kernel with support for the ColdFire CPU family fails
with the following error:

In file included from drivers/net/ethernet/smsc/smc91x.c:80:
drivers/net/ethernet/smsc/smc91x.c: In function ‘smc_reset’:
drivers/net/ethernet/smsc/smc91x.h:160:40: error: implicit declaration of function ‘_swapw’; did you mean ‘swap’? [-Werror=implicit-function-declaration]
  160 | #define SMC_outw(lp, v, a, r)   writew(_swapw(v), (a) + (r))
      |                                        ^~~~~~
drivers/net/ethernet/smsc/smc91x.h:904:25: note: in expansion of macro ‘SMC_outw’
  904 |                         SMC_outw(lp, x, ioaddr, BANK_SELECT);           \
      |                         ^~~~~~~~
drivers/net/ethernet/smsc/smc91x.c:250:9: note: in expansion of macro ‘SMC_SELECT_BANK’
  250 |         SMC_SELECT_BANK(lp, 2);
      |         ^~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

The function _swapw() was removed in commit d97cf70af097 ("m68k: use
asm-generic/io.h for non-MMU io access functions"), but is still used in
drivers/net/ethernet/smsc/smc91x.h.

Use ioread16be() and iowrite16be() to resolve the error.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Use ioread16be() and iowrite16be() directly instead of re-adding
  _swapw() as suggested by Arnd Bergmann and Andrew Lunn
---
 drivers/net/ethernet/smsc/smc91x.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index 46eee747c699..45ef5ac0788a 100644
--- a/drivers/net/ethernet/smsc/smc91x.h
+++ b/drivers/net/ethernet/smsc/smc91x.h
@@ -156,8 +156,8 @@ static inline void mcf_outsw(void *a, unsigned char *p, int l)
 		writew(*wp++, a);
 }
 
-#define SMC_inw(a, r)		_swapw(readw((a) + (r)))
-#define SMC_outw(lp, v, a, r)	writew(_swapw(v), (a) + (r))
+#define SMC_inw(a, r)		ioread16be((a) + (r))
+#define SMC_outw(lp, v, a, r)	iowrite16be(v, (a) + (r))
 #define SMC_insw(a, r, p, l)	mcf_insw(a + r, p, l)
 #define SMC_outsw(a, r, p, l)	mcf_outsw(a + r, p, l)
 
-- 
2.45.0


