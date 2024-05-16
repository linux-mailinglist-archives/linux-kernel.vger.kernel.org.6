Return-Path: <linux-kernel+bounces-180986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9FF8C75D0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D38D281546
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B17145FE7;
	Thu, 16 May 2024 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="RGpXtDKj"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686D0145A17
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715861837; cv=none; b=f1vHM5bxEzVPA9VkjjfY+UzibHJ8CNxfz9O0zJwbxmo/307JLATDAiaGEINifNoDIo3lwiShGpRpELoReP6rLrwkoxmyr1rSfCcqVNkGq6Ljosr+1mK1cWAqC1zy7lmJDZW1aU1cJ/a/7yGvC07ydN+nCVyv2FeLGtzpIisYdHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715861837; c=relaxed/simple;
	bh=KpnpffMw/zV9M94V6D2IMJp2nHOR7rwVMpIX7KRb9uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LjzemUXe7nOcW+NpkJ/Tfn34A6RAt9W1SJUX+PK3SewYANf8trqbM9iYaCRU4enyOTQD993BkakNVojI1Ms/WVpqZtOmpz1gSuHNXRBjQYMX9U6mSjR8xb2Wu/3kUdp5icnH5FyA2+4uUkwFBnvA9Gxhw+i1SVvoOT+UaHLe1Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=RGpXtDKj; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34d7b0dac54so4646278f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 05:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715861833; x=1716466633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ilq7lKFCVHfwaQa9v1DKZAjf9jpI5Ux70zIrHahyMJE=;
        b=RGpXtDKj3etCYOopf0WxDXlfjhtlTfLufSroPbZIdolSnVpgnVWO1QAAbZ3EMUrfkH
         As1IWwI7LZyDecywkD08SgrOjn9neCkuHvGEKULMCZ37nATzyOocSkrHWHmKeyGdnmtH
         Ku40srRui3Z3F6+wcz3s9HQsORx4BIO9hErW25aawzkkvuB2cbIOPOMHOYJJ7bFIsUxM
         RJCp7G77bhv7kZrB94lmiuRM7HYVparmOZZXDCDD8G0BSWbEzDitFmEn8Sz6R3I/gZ+j
         mED+L/O9MN3g1TYnzK7OvEzmL4nAEczzQzfSWoSjzf8UkWDR2UOu2KkXjAljBTuxgqI9
         mDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715861833; x=1716466633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilq7lKFCVHfwaQa9v1DKZAjf9jpI5Ux70zIrHahyMJE=;
        b=PEymCCTMIg0otQ4MSNq+4C0YLtvcxVEoAw1Gr78L766xxNpxMXnzqT5ed1R/hIKwGw
         IzCKM7T0idzgBFDiofuHGuI+8Gs+9JtAq+ihouGRdPEk6rCOEegnp9UB6yasB2uOSP/0
         T1UpCD5yS5j5Kj0aNewtK3UkVr8E/ZB9kmW2B2yjERLARRm/jDYDcPJCHP3jHopHXjDT
         tK08kIKHUaSbt2WJEZLWgHB3pOb88JuOf+ObVh1TQkCqt0rTGWW2j2+KhPtNP264/gvL
         KVWwpSIOYRjRG3fRvQn15ANMw3NNLNnJ0D8/2z2IyGfdLk1CwbrWb0QbYG+uJauURE89
         IQHg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Eddd8BKJjRAJZXcZS1Vm8ZWJASi7On9W5Ght7KCU7tE6fLaPuTti0EPaZdGTGAra+woxD92YTT5UMtN3z5alF+weTyVOsaWD9MRA
X-Gm-Message-State: AOJu0Yz4qenOmL8ZLyUy8k4A05Wm7RBlMpR3bqf7Hk8TkhP56SgavxU3
	Z2yzX7DdquPEEykTG+CkBy19m2gejkp0aaW8QKpCmp+DRvobqm8E+khVR6tuwM43TrSHAp2qv1X
	aJu0=
X-Google-Smtp-Source: AGHT+IG+jutgYcanPkm0bGfkBLLAmRJ7zUaSHQ7gx7yUUsMQWt2I4apeCk8rBQ6v330P9e142vHfkw==
X-Received: by 2002:a5d:40c4:0:b0:350:2ba9:ca03 with SMTP id ffacd0b85a97d-3502ba9cadfmr19491063f8f.23.1715861832617;
        Thu, 16 May 2024 05:17:12 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351d95d47e7sm1468751f8f.117.2024.05.16.05.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 05:17:11 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Nicolas Pitre <nico@fluxnic.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] net: smc91x: Fix pointer types
Date: Thu, 16 May 2024 14:11:44 +0200
Message-ID: <20240516121142.181934-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use void __iomem pointers as parameters for mcf_insw() and mcf_outsw()
to align with the parameter types of readw() and writew().

Consistently call SMC_outsw(), SMC_outsb(), SMC_insw(), and SMC_insb()
with void __iomem pointers to address the following warnings reported by
kernel test robot:

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
---
 drivers/net/ethernet/smsc/smc91x.h | 34 +++++++++++++++---------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index 45ef5ac0788a..204fbb5c975c 100644
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
@@ -1026,15 +1026,15 @@ static const char * chip_ids[ 16 ] =  {
 		}							\
 	} while (0)
 
-#define SMC_PUSH_DATA(lp, p, l)					\
+#define SMC_PUSH_DATA(lp, p, l)						\
 	do {								\
-		if (SMC_32BIT(lp)) {				\
+		void __iomem *__ioaddr = ioaddr;			\
+		if (SMC_32BIT(lp)) {					\
 			void *__ptr = (p);				\
 			int __len = (l);				\
-			void __iomem *__ioaddr = ioaddr;		\
 			if (__len >= 2 && (unsigned long)__ptr & 2) {	\
 				__len -= 2;				\
-				SMC_outsw(ioaddr, DATA_REG(lp), __ptr, 1); \
+				SMC_outsw(__ioaddr, DATA_REG(lp), __ptr, 1); \
 				__ptr += 2;				\
 			}						\
 			if (SMC_CAN_USE_DATACS && lp->datacs)		\
@@ -1042,20 +1042,20 @@ static const char * chip_ids[ 16 ] =  {
 			SMC_outsl(__ioaddr, DATA_REG(lp), __ptr, __len>>2); \
 			if (__len & 2) {				\
 				__ptr += (__len & ~3);			\
-				SMC_outsw(ioaddr, DATA_REG(lp), __ptr, 1); \
+				SMC_outsw(__ioaddr, DATA_REG(lp), __ptr, 1); \
 			}						\
 		} else if (SMC_16BIT(lp))				\
-			SMC_outsw(ioaddr, DATA_REG(lp), p, (l) >> 1);	\
-		else if (SMC_8BIT(lp))				\
-			SMC_outsb(ioaddr, DATA_REG(lp), p, l);	\
+			SMC_outsw(__ioaddr, DATA_REG(lp), p, (l) >> 1);	\
+		else if (SMC_8BIT(lp))					\
+			SMC_outsb(__ioaddr, DATA_REG(lp), p, l);	\
 	} while (0)
 
-#define SMC_PULL_DATA(lp, p, l)					\
+#define SMC_PULL_DATA(lp, p, l)						\
 	do {								\
-		if (SMC_32BIT(lp)) {				\
+		void __iomem *__ioaddr = ioaddr;			\
+		if (SMC_32BIT(lp)) {					\
 			void *__ptr = (p);				\
 			int __len = (l);				\
-			void __iomem *__ioaddr = ioaddr;		\
 			if ((unsigned long)__ptr & 2) {			\
 				/*					\
 				 * We want 32bit alignment here.	\
@@ -1072,7 +1072,7 @@ static const char * chip_ids[ 16 ] =  {
 				 */					\
 				__ptr -= 2;				\
 				__len += 2;				\
-				SMC_SET_PTR(lp,			\
+				SMC_SET_PTR(lp,				\
 					2|PTR_READ|PTR_RCV|PTR_AUTOINC); \
 			}						\
 			if (SMC_CAN_USE_DATACS && lp->datacs)		\
@@ -1080,9 +1080,9 @@ static const char * chip_ids[ 16 ] =  {
 			__len += 2;					\
 			SMC_insl(__ioaddr, DATA_REG(lp), __ptr, __len>>2); \
 		} else if (SMC_16BIT(lp))				\
-			SMC_insw(ioaddr, DATA_REG(lp), p, (l) >> 1);	\
-		else if (SMC_8BIT(lp))				\
-			SMC_insb(ioaddr, DATA_REG(lp), p, l);		\
+			SMC_insw(__ioaddr, DATA_REG(lp), p, (l) >> 1);	\
+		else if (SMC_8BIT(lp))					\
+			SMC_insb(__ioaddr, DATA_REG(lp), p, l);		\
 	} while (0)
 
 #endif  /* _SMC91X_H_ */
-- 
2.45.0


