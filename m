Return-Path: <linux-kernel+bounces-352289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623E3991CFA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 09:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8E18B21ECE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 07:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18737166F34;
	Sun,  6 Oct 2024 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9cOTVPC"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C92554F95
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728199473; cv=none; b=o4cW3qOjLIJ9A/r1EAT7C8qyRT7kzzbsKDi4jXZEZ6zgiqHoTYBcBfkp7rllV2znHPKeXdzRQQniO7t00ZWeZhrljbhcZ3j8hNwNOUWOLnb/mz6D852L6o8oQMTpLuoHIxj5+3GxA6yCW0wyZqkUlxX8bvwA606XyBsCcTJ4fRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728199473; c=relaxed/simple;
	bh=zIvAoAIzHGlsXnSv/kdkXrgwDSyL4iJ0xQOzUAdLztg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QLe9rfiV+upGQYA6e2bdM5tjraCCkLsbguB/AE7B8ouK2HKNHUj5FZRpYej5swEUEoHVZpuvztSKF7ZHHjbAfOjSJhyvQbafsuDML7N7tIp4KvpQMCsXGhQsxmq/RqEpax+Cng1c4mhCoiJini3Kh2kEG0/aumHOc6hQO+g25Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9cOTVPC; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7e9fd82f1a5so353893a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 00:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728199471; x=1728804271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e6xlP6dNCtgWEzSxYrVuRfCWcrNWwEhg70Yoit08Scw=;
        b=N9cOTVPCCDj7UbXsHMB71fgN/MMftJYKs/jIED0B+oALFDjEcoN0OVoMTH7g710e7Z
         iYy2OKoWbxN3AMWInJw2f5sCNYBUhfDG38mZRDR4iATWCR5Bb0XNP2vEX9pJjT+8QwCi
         lIjwnYMu64PRbUnxhYmL1RAq5XhH15dyfgp3EQrknsBMdS2akxFFeFiLLrcIqROvf0yS
         hGe3VFY1Bo/emVzh3H5ayktadnEFQpY6mrVDeBUCeUNirtTfjYwdXVq1DUZ/2y94ggc6
         dya3Pno33fpeFtRq5a3BmwbBCmSCUH4tuA3LnRXO6ckOZOPl5YfBHSA7gynJ+hftijeS
         KLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728199471; x=1728804271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6xlP6dNCtgWEzSxYrVuRfCWcrNWwEhg70Yoit08Scw=;
        b=YupLZ0kKRIzhknQQit5F1VtfQU5ZX+Mn2P6Y0sPPdb1wnSQxe+Dt1lnYkd4PZYh5UV
         f/4m1qqtE9e36/CM7YmY9mIfE/wdXSKY/gfxyrwYveQyhzX3eKCdNPdY11+XNVBM24m8
         qjvX9fbbA7o/gGZWCWY5pogcp2ZLYPxUe/rE9JEF4mT2b/r13sK4sOgx/PEw89vmPr7S
         4okfDJF3Cefg7kibuuX1Fr7WWTuDyvnUsjdmOZnQjhYjufLkydWMLcFAE1r34DBW8IS+
         cptGcDUAvSXLg9ye+aJrWLrN6gXFj2es7n44NTVupcKPJqkDASjG2zWh+nYHcm+E4cvY
         vJVA==
X-Gm-Message-State: AOJu0YxFYEzFQ+gjAXYVj57lBBPtsv98zcW9bOvHDj7u74YxajvADT/m
	S97cm2raejrcJe79ng89R63DLH4IkVHj2NhCGXMC9H2gKjOWZOZ0SpQNj4Yz
X-Google-Smtp-Source: AGHT+IG78BXRTTg08bmnilGOaApFPJ0kMg9wUOtiEadsNMqvCh8osRnbCq+RKDT3Wmc68k1G8D25FA==
X-Received: by 2002:a17:903:41c9:b0:20b:ad74:c84a with SMTP id d9443c01a7336-20bff194f20mr86986115ad.61.1728199471403;
        Sun, 06 Oct 2024 00:24:31 -0700 (PDT)
Received: from vishnu-pc ([120.61.77.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13939c3bsm21845905ad.151.2024.10.06.00.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 00:24:31 -0700 (PDT)
From: Vishnu Sanal T <t.v.s10123@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	lasse.collin@tukaani.org,
	Vishnu Sanal T <t.v.s10123@gmail.com>
Subject: [PATCH] fix: possible memory leak in unxz()
Date: Sun,  6 Oct 2024 12:55:43 +0530
Message-ID: <20241006072542.66442-2-t.v.s10123@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes possible memory leak in the function unxz() in
lib/decompress_unxz.c forgets to free the pointer 'in', when
the statement if (fill == NULL && flush == NULL) is true.

Signed-off-by: Vishnu Sanal T <t.v.s10123@gmail.com>
---
 lib/decompress_unxz.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/decompress_unxz.c b/lib/decompress_unxz.c
index 32138bb8ef77..8d58207ca1db 100644
--- a/lib/decompress_unxz.c
+++ b/lib/decompress_unxz.c
@@ -343,13 +343,13 @@ STATIC int INIT unxz(unsigned char *in, long in_size,
 			}
 		} while (ret == XZ_OK);
 
-		if (must_free_in)
-			free(in);
-
 		if (flush != NULL)
 			free(b.out);
 	}
 
+	if (must_free_in)
+		free(in);
+
 	if (in_used != NULL)
 		*in_used += b.in_pos;
 
-- 
2.46.2


