Return-Path: <linux-kernel+bounces-297467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 216C995B8AE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC00B1F2450D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D39A1CC158;
	Thu, 22 Aug 2024 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mys4tQkZ"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CBF1CBEB7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337531; cv=none; b=NAkLWOYyVqEbMjSuf8FoKIwNkgjhTcSbLpCB0+9ID4veZ5YQCcf2Rf+rjkv/yy5ELxqZeoBC//ArAWHXNqdc8UXFATeUxPaUmw+rRX01ebTF8l5Rt0+4z1kQtB50Dg00dg54gqJCaOZsnsxYW7qsByES/BMCK/mzsbnnzI0CRQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337531; c=relaxed/simple;
	bh=KWk7S77feO2+Su/Jz6JDlMEwYU/vnPbFufNMPGjuIEM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TRor+5h6zrmjnwGmbgGXjNPL/tclAQYe8xQbBv2pXFLlY7jTvHGHysMYKceCYiO+ny3GLsDrY+h0u1/ybmlofJaMZpfDmYoRIRkagKJUJjQ0Fo+Ao02AvCZ8C9+D/D6mwkVlKZqcQDNWn/MNXIQS+z1qoNQMDpKPRDFc64x3xvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mys4tQkZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20203988f37so8481055ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724337529; x=1724942329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2J+FZcObaK3ET3O6BG+nz121nx0VS8YMKU4mL/dyMXk=;
        b=Mys4tQkZpmBUeSssXoiT+oIdAxUqN8ZfSshdcT360rnzDQlGvuZp0xod0dllZvtVEd
         9fYmU5mKeQdrv6EiN7uyBjQhoa+e0TlADcWMkGSR9AePxy3jo3crMLJyeKs3L/DTc3CP
         F6tkq5IJIVvt3RDmzhj+eJgttwSJw3UzoMo5nfFU+tEhbHp8voHIN9McVrgGF/PwtNx7
         Ccddu8VBBFui3SqFDSUN2LP+m5xOgJunkN2qnQxrSk+f5iFVTuafSKw8yYQ1X7MWAHMT
         47FHZPFAcTri2smcHnctzdwBKC+bSSHNVjI4UYjTs5tx8pqnFpNg7OeiDLrqI1HcNyff
         1log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724337529; x=1724942329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2J+FZcObaK3ET3O6BG+nz121nx0VS8YMKU4mL/dyMXk=;
        b=HLnjK9PLXXYsC+AndtFOhWR/LFa7ZAkTKfp1mh9Zew2ARozw11ZqfAN4wDkVZmXLUT
         KHbQ+5pnF1n/FHvhAHMWm1hlIHZPQgChzSvStysNUqfLqkCnP9jKhHsIuyianbGEODuB
         RsW6XX2EOqkgzgoFU8gJbddCoiowddpUfbsuWpPBNKmSMBR4+Or0GNXjwOkqETI66UvE
         as8O9cGia4kdECbCi1Z7D3dFeuc3nWqn89aTdji3AKGc0zLjBBMsNCKoGKraBrsz4FxS
         6gbM9gz4O1rCTvqOEsA50pttF580m+SrOkt/kAobHdql0vddXP1xp7e8wOrRk0tysdF5
         Mw+A==
X-Forwarded-Encrypted: i=1; AJvYcCXY1faaCJu30PmcmHTCKQqMSFaDLfMDzUV5FTNR6dJWcEXPDqiPmgkKrVoRTcg+BcwXkbsGTlmbYrlQ5wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVRGXPlcBfT6rdi+wO9Eug0kGXFJ5yilURzJE/Jj6wXovg1qpK
	AbZl0pQQTo2PtAQxenvbxB5RtW41olFZ9DN9UiXG+gOLxwOnPl5g
X-Google-Smtp-Source: AGHT+IGOzzZgvEII94d3yJqOtAs7Z7xQu21SDuCClkdjCjlSqW4yfbccwA4nxEvbCSCpUHiDXCeo1w==
X-Received: by 2002:a17:903:1c7:b0:1ff:393d:5e56 with SMTP id d9443c01a7336-2036809745emr73095155ad.36.1724337529310;
        Thu, 22 Aug 2024 07:38:49 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:baa2:9074::1002])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385564adcsm13441005ad.10.2024.08.22.07.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 07:38:48 -0700 (PDT)
From: Hans Buss <hansbh123@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH v3] staging: rtl8192e: Insert spaces around '|'
Date: Thu, 22 Aug 2024 11:36:55 -0300
Message-ID: <20240822143837.37768-1-hansbh123@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hans Buss <hans.buss@mailfence.com>

Insert spaces around '|' to adhre to Linux kernel coding style.

CHECK: spaces preferred around that '|' (ctx:VxV)

Signed-off-by: Hans Buss <hans.buss@mailfence.com>

---
Changes in v3:
 - inserted changes in the correct place

Changes in v2:
 - fixed typo in commit message

 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
index 1b444529b59c..e507593b939c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
@@ -229,7 +229,7 @@ enum _RTL8192PCI_HW {
 				RATR_MCS6 | RATR_MCS7)
 #define RATE_ALL_OFDM_2SS	(RATR_MCS8 | RATR_MCS9 | RATR_MCS10 |	\
 				RATR_MCS11 | RATR_MCS12 | RATR_MCS13 |	\
-				RATR_MCS14|RATR_MCS15)
+				RATR_MCS14 | RATR_MCS15)
 
 	DRIVER_RSSI		= 0x32c,
 	MCS_TXAGC		= 0x340,
-- 
2.46.0


