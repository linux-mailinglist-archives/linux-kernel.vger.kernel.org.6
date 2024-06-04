Return-Path: <linux-kernel+bounces-199911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6628FA7B5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A151C21C4E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0DB13D295;
	Tue,  4 Jun 2024 01:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSHG+sdb"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E324A07
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 01:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717465458; cv=none; b=mzwT64AlbKoHqPY0X2MQx/US5hpDPPPBqTg4HZ0Tw5k5IzW6Ba2fM9tRqKfpKYSyEAcwJufbaQJBY2Kzf4TWxcbRbLtUfUUhPz+o5PP89gdJch3VDNTm0SPQ1G5K6i1La1ujRHNyHKFwr9npBEJdiGnOefiCnyF7Pk3b7Hgp7Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717465458; c=relaxed/simple;
	bh=tgQUXAbqpX3U94aO6x/D2MmQFKzuA8RjZ0MFTCQwJeQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=few3HV6OtOY+QPYrHQYiMBCb8i9FWDWUJfvKGPM6C3vRFRJUhPUFctP6U1BcHHQ7zictfQscas2ghwVLdX/5QFp/pg7uMIeUbViQPn6Q/NuVEYI3RyYSTigrBRdVmr+lsNnhfmAEqDSHmmKn9sIJYimGtMfN26ifSS86Uy/QGbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSHG+sdb; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b9c7ae2c98so304941eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 18:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717465455; x=1718070255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=H6Tf1Riu9q7Xz/KLQjcwHxW5z7Z6dmOlmlHHwP+1DzQ=;
        b=XSHG+sdbuyhnT6k1lcZdsEL8k7ryIEzJmw5PEEhfbVYx4IGJGJQsn0BYMFk1zITazP
         I/eUF7Upc7ADtFvq+O2yZ/bEZXg6LWXpXDP5xPFBINKyxWEbsqKuiCCO/MSBGu+wDwPX
         JfeRCulnR9JE/lTM40ojce8Q6ERZZ8bI6pgQtGaNZ0D7W7sVlklj+JkS0azKOK+W3qFv
         DRLIqPYfPvgqhNYr1RclU6+FY3FuOE0AWJnHJxjDJHoZi3bd3WDFFWLgNDuotnWU0JxS
         iKNLqQ6JOO2PCTp5UC5W3hGrqKsvTIk0N3L8ujiSRs3L2AsOR0ABhm1lE4Kgf1T+e89I
         1L9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717465455; x=1718070255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6Tf1Riu9q7Xz/KLQjcwHxW5z7Z6dmOlmlHHwP+1DzQ=;
        b=LooW2/bf6fOxAT/YVqFdb6TokhyENH4l1aN/TdjGT/nUjjUlmFmTgJRVOfe/8iHBbc
         PEWUAZIB3F12YsIs1Mu4WIb+G5ccdBNHg3JR2lWqWRS7b8VHDptYamo+F4GSx1e9oxBx
         L8pfGnE8eXH/f3zcWWsvkPnX5vKkoN7+J9X6roHiDeT5yfM5x7WezUHN6R2sbiFjZeJ1
         cs3M5uk5QfKcp5o7uLViA6u/y2+XksGGgjnlMGPZR/5ZcG/uzJnp2i7jgHRTcyDEOpiT
         fp3ssu6Kz7x3jn1vPLf70dVhuKEyMtzv3Rd0bBNmKn9l89jh680gXqcb61LqL3iJUVlV
         /LUg==
X-Forwarded-Encrypted: i=1; AJvYcCUNqB3d238q2qjImACpNZxmEt8TZbgMsKZOSEd27E+Gbh9k7ADh0/ljxoXI8Kp0d0OMrQgRUzJXjbla50HnfF+pv/uj+YtVKyxR8+jI
X-Gm-Message-State: AOJu0YyINoootQ+ykwQM64IKD7j9heyQK8GnAxyq8vO/dbs8EMiMccj8
	D91ZxRIfy5Gueh27+tqAXjNgR+tWWxknYr+pldUsFhlrtdtXo1Gg
X-Google-Smtp-Source: AGHT+IHg/JFcUuz2AUiLGiqLFNWljeAABlL3rDAWzagbYkbHWtbG05YWsnyfegyOQuXYTrNV5YJu4w==
X-Received: by 2002:a05:6358:708:b0:197:8ee2:4ce2 with SMTP id e5c5f4694b2df-19b490d719fmr1345888555d.21.1717465455211;
        Mon, 03 Jun 2024 18:44:15 -0700 (PDT)
Received: from localhost (220-135-95-34.hinet-ip.hinet.net. [220.135.95.34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6cb90510a45sm2396637a12.29.2024.06.03.18.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 18:44:14 -0700 (PDT)
Sender: AceLan Kao <acelan@gmail.com>
From: AceLan Kao <acelan.kao@canonical.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm: Simplify conditionals in PGD synchronization functions
Date: Tue,  4 Jun 2024 09:44:13 +0800
Message-Id: <20240604014413.694442-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>

This patch streamlines the conditional checks within the sync_global_pgds_l5
and sync_global_pgds_l4 functions. Previously, the code redundantly checked
both reference and target PGD/P4D entries for existence before proceeding
with further actions. This redundancy is unnecessary since the existence of
the reference entries is implied by earlier checks in the code flow.

By assuming the reference PGD/P4D entries (*pgd_ref and *p4d_ref) are always
valid within these conditional checks, we simplify the logic to only check
the target entries (*pgd and *p4d). This change makes the code easier to read
and understand while maintaining its original functionality.

Modifications:
- In sync_global_pgds_l5, removed the redundant check for pgd_none(*pgd_ref)
  when asserting or setting *pgd entries.
- Applied a similar simplification in sync_global_pgds_l4 for *p4d and *p4d_ref
  checks.

This patch does not alter the functionality of these functions but improves
the clarity and efficiency of the code by removing unnecessary conditions.

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 arch/x86/mm/init_64.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a0dffaca6d2b..ed964bd081f8 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -155,10 +155,9 @@ static void sync_global_pgds_l5(unsigned long start, unsigned long end)
 			pgt_lock = &pgd_page_get_mm(page)->page_table_lock;
 			spin_lock(pgt_lock);
 
-			if (!pgd_none(*pgd_ref) && !pgd_none(*pgd))
+			if (!pgd_none(*pgd))
 				BUG_ON(pgd_page_vaddr(*pgd) != pgd_page_vaddr(*pgd_ref));
-
-			if (pgd_none(*pgd))
+			else
 				set_pgd(pgd, *pgd_ref);
 
 			spin_unlock(pgt_lock);
@@ -198,11 +197,10 @@ static void sync_global_pgds_l4(unsigned long start, unsigned long end)
 			pgt_lock = &pgd_page_get_mm(page)->page_table_lock;
 			spin_lock(pgt_lock);
 
-			if (!p4d_none(*p4d_ref) && !p4d_none(*p4d))
+			if (!p4d_none(*p4d))
 				BUG_ON(p4d_pgtable(*p4d)
 				       != p4d_pgtable(*p4d_ref));
-
-			if (p4d_none(*p4d))
+			else
 				set_p4d(p4d, *p4d_ref);
 
 			spin_unlock(pgt_lock);
-- 
2.34.1


