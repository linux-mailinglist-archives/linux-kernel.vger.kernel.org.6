Return-Path: <linux-kernel+bounces-536336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE27A47E53
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DD93A3DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1F622DF8F;
	Thu, 27 Feb 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxEvTyJ1"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261CD22D781
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660984; cv=none; b=EmftUwX24BdNOnt5bzBo8D+XE/Af7USw1gZuiuBdm9ujamRh93f4aUj8bUNwSREozLeK+aT8wVQWh+/4ph5f3KhcTmvxHq53TU1CPUOKuAo0lZ6yGf6wCxbb4Mz5X+u/jp4GLL5S7mH2KaByvwuOjV2k9Aqe9qO+ZrpdRQL0WWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660984; c=relaxed/simple;
	bh=X24kJCAW63kwt/yngjpuF5ioK7IYwrTI+eICuuActP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pcmEoDj7q5EubECeNGOHs1/z+AAp58AzNquSCjeKbt3Jgg7I5xfBRL1dK+joD4XiKIQlU2+30B/YHwl71quZgMweCi5s+M9dkDYCjwisY9tLJLLWeB9si07qI8jcQoSbiIbiMx90hG+MGl+QdnE2wrtHW7DvbmmZwNv4SQiGX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxEvTyJ1; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abec925a135so128178366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740660981; x=1741265781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IZ5DXxskPnDqlx9xZzTeFZEyyOTpoguW6dyRF/C8Kj0=;
        b=WxEvTyJ1XEgQLlCVuJtfWwR7SNyOl3IZcN4vLw4bUVwHm5Nf/lAm8nuMJ9OjUQRAX1
         ij3nZBp4XqiJdnQqlkwHGgeOup9LoRkZCDtXAeK/VDcVFVmpZyrBs4tqM9nTQK1Q6qgx
         3LPv2qYRSrYIVHPmiEeMREoSGk0w/6fTczgFtKAXrAwUcmzrDpIlabXZn33bO/zmcsic
         g5SlxxpCV0jlXc2sJcAjFSu1eOVvkYSrjk/sAXKlYB4U1Yj7MLQgbvNIpY+bRdLQW/fE
         2KTFD+UOT9OojULgijFgY1oHRYI+hwOoemq3imeyMbV+g5fVq1xDF5MirB30Z/j4Xm+F
         v7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740660981; x=1741265781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZ5DXxskPnDqlx9xZzTeFZEyyOTpoguW6dyRF/C8Kj0=;
        b=detDnYhUIxj1+dxfjSBVzzXsITnCnDn4C51R4+a7noROiilzGcQ9XbqYKamDTFBc2k
         MeOEQpCsScv+hSt/z+J/hFNUUqR3ikfrSC/KXxlddflF0q0LIHS7dd+OiK2XwGl/6BrQ
         1JSDEUfithK7Iwt8LBGiNF7H3Dw3gfPqhoPuqDepaBPsOW3yRiOmkOtDDSAxLTS6mphR
         QEec8q4E5aH7VcdPglK7hsDp/xmipLOEqO9O96GOx1T0XuV22mQgVgGtB6IeOiMqnTyV
         hgbmf9HGkZVVKF+fto+RqbNyspNYaa6sZAjw3TWD4PM7TblrhxTbvh1dZ1ov6cuSaZ2N
         25Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVffmsgpasnoa+Cr5SuHL7vATSxUo2xf6dUSOF3N6WLynhNgzuo/phuW0JmGB+R62AOEcYTm9vU8BsSlJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5mDXIFLETEYgtDSxwz2sbKkE6n9+yQqQM9JahWvZJKa0C0wtK
	Li4bPMHr5BKc0FPIVb/N+KejS9DHNNFpXyt8UGJn70KjYXHUrCKC
X-Gm-Gg: ASbGnct5dK3JGCoij71y9lUrqymrt8Y+qYK0e5udcNaeQbIFR4Gj+Nze3efPtJT0QBM
	ppkyBHDKx9ADdAlmuSH/gDzB/AphHxn0TMNfUVW5w6bvs9HKopH3VZeUrG5SMAzwg2rDkdYW0us
	bf89g7gGDs6DwrbbTMjj+p01A/aAdg8FiXpq+BFEiRvwNH5rEqLlbKEzIxfIBbr5XYMZ2uzP8uX
	B9Ck84tLb5LQUpcdvnI2WvcOgjiRKmhT2XYcDEBtxZuNsf7mNF3AAXj0u94x+SSPT5DA2ym8Gtq
	kU4TGUTpB3mm0dNL5A==
X-Google-Smtp-Source: AGHT+IFGdlSQUT0+hySlFOKapZBODu6Pz+VIsld5fy1uSnrW4NDcByokUZTEB68twlMXXZmkWp/c7Q==
X-Received: by 2002:a17:906:b2c4:b0:abe:e2ac:62db with SMTP id a640c23a62f3a-abeeed11204mr788819166b.7.1740660981155;
        Thu, 27 Feb 2025 04:56:21 -0800 (PST)
Received: from fedora.. ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf1bef130esm53098666b.40.2025.02.27.04.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:56:20 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Yu-Chun Lin <eleanor15x@gmail.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/bootflag: Replace open-coded parity calculation with parity8()
Date: Thu, 27 Feb 2025 13:55:45 +0100
Message-ID: <20250227125616.2253774-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor parity calculations to use the standard parity8() helper. This
change eliminates redundant implementations and improves code
efficiency.

[ubizjak: Updated the patch to apply to the current source.]

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/lkml/20250223164217.2139331-4-visitorckw@gmail.com/
---
 arch/x86/kernel/bootflag.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/bootflag.c b/arch/x86/kernel/bootflag.c
index b935c3e42bfd..73274d76ce16 100644
--- a/arch/x86/kernel/bootflag.c
+++ b/arch/x86/kernel/bootflag.c
@@ -8,6 +8,7 @@
 #include <linux/string.h>
 #include <linux/spinlock.h>
 #include <linux/acpi.h>
+#include <linux/bitops.h>
 #include <asm/io.h>
 
 #include <linux/mc146818rtc.h>
@@ -20,25 +21,12 @@
 
 int sbf_port __initdata = -1;	/* set via acpi_boot_init() */
 
-static bool __init parity(u8 v)
-{
-	int x = 0;
-	int i;
-
-	for (i = 0; i < 8; i++) {
-		x ^= (v & 1);
-		v >>= 1;
-	}
-
-	return !!x;
-}
-
 static void __init sbf_write(u8 v)
 {
 	unsigned long flags;
 
 	if (sbf_port != -1) {
-		if (!parity(v))
+		if (!parity8(v))
 			v ^= SBF_PARITY;
 
 		printk(KERN_INFO "Simple Boot Flag at 0x%x set to 0x%x\n",
@@ -69,7 +57,7 @@ static bool __init sbf_value_valid(u8 v)
 {
 	if (v & SBF_RESERVED)		/* Reserved bits */
 		return false;
-	if (!parity(v))
+	if (!parity8(v))
 		return false;
 
 	return true;
-- 
2.48.1


