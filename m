Return-Path: <linux-kernel+bounces-304599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCECA962251
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657C41F248AD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E9A15CD6E;
	Wed, 28 Aug 2024 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SW9r9xMU"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB415B984
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833790; cv=none; b=cGfHUGwzmiFqi1LTioiKisOTNogoti/X7ItB8R3UhTRcGxtgHO7wexPHwhvDAhau+/IBzvX0x7VDabslEqJVGTY0jjcFlTz6ElBA1reNa7+pZVE4F4xKerqRko/A2egpKAUXiTz57+hKtqz1aBIv3HjtqeNzPdRQJuwTfW1sP0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833790; c=relaxed/simple;
	bh=lH0JUoaogPNZeArNaajzdEVnjxOdXb0pQ9xe5QMFhqc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jmuDKs2mnO/68GCqm3tbd35pMcrHu9Tf1GOwC1K7ID0DRlkpGXzRkgNbJ85B0dTG3yL/cjRloVdmmpCz+Pm+clyc+irzY2w2678f5ktLfk9UyTDg5Xwcc6UCAXKafyaHeVVlwze74eNk0RfSbzKu2xr9Y2/+KjUGXWuNsnG4Qqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SW9r9xMU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7141b04e7b5so3980153b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 01:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724833788; x=1725438588; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxhRZ1h+j0dbjbcPThYnjdsx7lav8ugYYLKcysaTxyQ=;
        b=SW9r9xMUO/P0E1uw+8yEwwZYwk3801QbhD0XCt+jiq7Sy80NL1u5rJYOU//lWO7dK2
         qfwzk5otlc3C4/8jV+F0Ql8KNmTpb3bTcdlUMjwZ3VMrDAOnjng0lDqhSqjBce3Ny9QG
         2YBaP1g7z2IxhTjLgtSW5NwwLfQMyKLpuc7Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724833788; x=1725438588;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxhRZ1h+j0dbjbcPThYnjdsx7lav8ugYYLKcysaTxyQ=;
        b=e+o/nJFuhQcLAg+TRZmDBGizQAddY/0lkcK0QDKR3ruJ15pPAM/v06q+Wj8/Ml97zv
         aYO01NmKLBD7mzypSfh4WF/e0LXUseWuce6wSuEVssGT/Rjhxgb1hD/SziMPWgOSaY4M
         BfBjkRVXc1IatZIj+AGoP1cuehg/oLj2TIQYpipwGVKXZo5FqwNQjhY42FT7BTPRqMbQ
         ++QfOQHESU4+t4R20XTL4BjWk7+5c0U21H7IugUtFX4AjDHRAl51CKrfvsgRXYXbJ6Gb
         iFdfyaQDxaw2CUXR60T6L38/BFDZnS+KWd1H5HfVvuThkjYRMX2j8lK6/VAkZ+bLAwUt
         U8MA==
X-Forwarded-Encrypted: i=1; AJvYcCWSHrfm1kn24XRuLM8PDunCE4SuUaDbUfhaRHHDEmyuEPg1pk3PYRaf6uLgfXQzTwVq6qzl9FSq5hzkkqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8sWa7mc8/jZm4WPwAjDbmdizsZjON6u385jJdvJcd5FhNPWsv
	/3FlzgP3EB/rkdmukkaZDl2Cb+t3x1t0YwLSJDHNwic7Wt8zDm+sVeNTwfYbAg==
X-Google-Smtp-Source: AGHT+IFjEjdpgIEVnUhx2ej6u1HsyozqDRSPIdIIFfYpkP3l/Nxh+aH6L9FcUI8iawXwDrUfbfJctQ==
X-Received: by 2002:a05:6a00:91cf:b0:714:3831:ec91 with SMTP id d2e1a72fcca58-714458b2fe1mr16370822b3a.25.1724833787768;
        Wed, 28 Aug 2024 01:29:47 -0700 (PDT)
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714351aee05sm9856257b3a.91.2024.08.28.01.29.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2024 01:29:47 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: axboe@kernel.dk,
	niklas.cassel@wdc.com,
	dlemoal@kernel.org,
	hare@suse.de,
	martin.petersen@oracle.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com
Subject: [PATCH] block: Fix validation of ioprio level
Date: Wed, 28 Aug 2024 13:58:15 +0530
Message-Id: <1724833695-22194-1-git-send-email-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The commit eca2040972b4 introduced a backward compatibility issue in
the function ioprio_check_cap.

Before the change, if ioprio contains a level greater than 0x7, it was
treated as -EINVAL:

    data = ioprio & 0x1FFF
    if data >= 0x7, return -EINVAL 

Since the change, if ioprio contains a level greater than 0x7 say 0x8
it is calculated as 0x0:

    level = ioprio & 0x7

To maintain backward compatibility the kernel should return -EINVAL in
the above case as well.

Fixes: eca2040972b4 ("scsi: block: ioprio: Clean up interface definition")
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 block/ioprio.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/ioprio.c b/block/ioprio.c
index 73301a2..f08e76b 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -30,6 +30,15 @@
 #include <linux/security.h>
 #include <linux/pid_namespace.h>
 
+static inline int ioprio_check_level(int ioprio, int max_level)
+{
+	int data = IOPRIO_PRIO_DATA(ioprio);
+
+	if (IOPRIO_BAD_VALUE(data, max_level))
+		return -EINVAL;
+	return 0;
+}
+
 int ioprio_check_cap(int ioprio)
 {
 	int class = IOPRIO_PRIO_CLASS(ioprio);
@@ -49,7 +58,7 @@ int ioprio_check_cap(int ioprio)
 			fallthrough;
 			/* rt has prio field too */
 		case IOPRIO_CLASS_BE:
-			if (level >= IOPRIO_NR_LEVELS)
+			if (ioprio_check_level(ioprio, IOPRIO_NR_LEVELS))
 				return -EINVAL;
 			break;
 		case IOPRIO_CLASS_IDLE:
-- 
2.45.1

