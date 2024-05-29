Return-Path: <linux-kernel+bounces-194287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DBD8D3987
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1AFB288B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEF015A861;
	Wed, 29 May 2024 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="O32m8Npt"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7683159912
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993783; cv=none; b=uNIkXtKD6xHzBdQZbm6DdWnvPKvr2sQL5hzWrD3YsjLV4nZc3FK3qcJMNpYy7B/jQ7qbPt+cL7/SulbX7tIJYOi/g5FF2VkA6i1x3uwwDZXa1xgG3Cj9DArHkhmu6PATIJ5rO89b+NOFITyiurjUUp0MyIbxQCNa6KZ6j0nD8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993783; c=relaxed/simple;
	bh=DYNP86csXlVe1mEXFQLBRJdCoowpQyBb1vDWFXaPUSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lsRZ02i0/2W4PmxcoMFp8QvrvCDTo0zTIeviHvHuq5n4KvoidTFcr2cSBrlDpc5ccaeOm4HGr1KsZSgbm9LkMwG1KqIY5bQRoDjBTJX1VFPKiA74oGU+3whYT8frVSvKgR6Y+82TVENvP+NnWRtoSiJ8TWsu+bUWNq3ijGN8OH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=O32m8Npt; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a61b70394c0so252515566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716993780; x=1717598580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fftQnVeDno68x9iBUrR4R3cYGCa/SUe5rcprLn8zMNE=;
        b=O32m8Nptt83No2H09HJCtf3TSobcontBxIYoXtXd07Ay0DcTzev2Wp4J2b9A/zmMcw
         X2JXvW6UBWmaU33CPMDeZ2HRMXpIFk4JBwn7HcnXdnyFhnTR6Ycb3/HX6ZFMgI6X0/os
         WXD3uimLzpKUohNBHON1k8Jyfj+meZLDJLoFfKghSVSKdK8aUJa78NJI/uCc7VHokwfP
         zaEqBuB++d2rLM+Yr2+gE/GYK5byKi1k5PGYDiJlE+caijd6qnSJLD3ELfi0e0XIqhUV
         77QO4oNfiW/A0klMknBBuiraaEs+YN+gmq8FHEfQ+RtgIoOjFBR7Ld6Yy63aCBsIBo/L
         1H1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716993780; x=1717598580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fftQnVeDno68x9iBUrR4R3cYGCa/SUe5rcprLn8zMNE=;
        b=f67CZ00Wj+ofOyHxwbbhg2179eERUVlKvJICMNDFsz59gtAppaSWK2CiTviQM25AHP
         GZIjrD4kDokReiZvdaOBJQrsrqmbW+xZKTvylfIUPogWquEnGPUiwMGHYJZJDdvCizRY
         HI4flhRcNJN+RPmDSGyrBU/NcSoE30HgRPkpwO9NrqQcMP36lWju9rGXtvvXPhP7Z8hd
         rkD2to6cH2vxRVsL/NZOU57Wxzatf1/IzgMEA9+cCBWUE2TeHprMjjgYfk46jA7AKzEC
         7mK3nioCQI2frI3Te8ncr/Uwhuna2g7vdX3NvmVrPKWWOQPdmh5e0Na3KNBor9OjuK9O
         anIg==
X-Forwarded-Encrypted: i=1; AJvYcCV3aHvAliBBLLi5U7kcO4MXlh+S84jSvG4sER+yRhKWsPneUFMKWFRh9Whreh8iA3hf8S/Hmn4wD26MsMH2UjEQCzBRv6XSnwdjyXHT
X-Gm-Message-State: AOJu0Yx6WaxS1sZolZyN2zDaaZBV6gu4jivdXb05Xj8qgbkDAXWuIbTG
	535V+8GBQ4U2NtfFMqD/N/2U+AgjvwIuPTJbJfl6nysKzMginUgfOKcDH9QQTqE=
X-Google-Smtp-Source: AGHT+IGs+6p/AwUfHoW7Gr/BlZoD5lAEX4gy83IcLlvRpoJh+8M7OUqis8V1yDYCyOK+GQIIT4AhrQ==
X-Received: by 2002:a17:906:f748:b0:a61:4224:c998 with SMTP id a640c23a62f3a-a6264f12995mr966600466b.54.1716993779804;
        Wed, 29 May 2024 07:42:59 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda48e6sm719337466b.203.2024.05.29.07.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:42:59 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Nicolas Pitre <nico@fluxnic.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Arnd Bergmann <arnd@arndb.de>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>,
	kernel test robot <lkp@intel.com>
Subject: [RESEND PATCH net-next v3] net: smc91x: Fix pointer types
Date: Wed, 29 May 2024 16:39:02 +0200
Message-ID: <20240529143859.108201-4-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
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

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405160853.3qyaSj8w-lkp@intel.com/
Acked-by: Nicolas Pitre <nico@fluxnic.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Use lp->base instead of __ioaddr as suggested by Andrew Lunn. They are
 essentially the same, but using lp->base results in a smaller diff
- Remove whitespace only changes as suggested by Andrew Lunn
- Preserve Acked-by: Nicolas Pitre tag
- Link to v1: https://lore.kernel.org/linux-kernel/20240516121142.181934-3-thorsten.blum@toblux.com/

Changes in v3:
- Revert changing the macros as this is unnecessary. Neither the types
  nor the __iomem attributes get lost across macro boundaries
- Preserve Reviewed-by: Andrew Lunn tag
- Link to v2: https://lore.kernel.org/linux-kernel/20240516155610.191612-3-thorsten.blum@toblux.com/
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
2.45.1


