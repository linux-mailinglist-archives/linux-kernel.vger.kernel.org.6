Return-Path: <linux-kernel+bounces-565225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EAFA66401
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B15417D734
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D480C3596A;
	Tue, 18 Mar 2025 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HJMjpjZZ"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA631C28E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742258438; cv=none; b=F6IhbGJu9MnaZoKFMXYSvwPQN49g9TN6O4DrfaNbGtINBF13gIRCGK5qbNNoKH4bYC27gUvxv++6KoCUyGda2WPPEfgE6c5g4fV85iyAjQLkak6pB89akdT3vAnt8ff0+glQw2vmuwGfkBpj4wPjF7IOLrr2PS70Lam3TlHgx6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742258438; c=relaxed/simple;
	bh=aF1eAkjgcCapdV4LaVeUeqIvJD+3wVpYt9I5HsPkM5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WgO7AO71mt3d3bkNayDdyvOSNW6xsnY2V6iy/YEf6bR3lBOpAY2d6Ok+GsP/XRsb/EApWoy7FiNSc7OHuD3GLfs3QrUl0YYU1nu11UuCxFc5b1BPd8xbiLTC+EN0fUwigv/tp3npU2fwPY8n0qj+ro6WCTbTjc0su0Zw7Q6Fct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HJMjpjZZ; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-601b1132110so2401640eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742258435; x=1742863235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9vQclP5cvHTI1P3oWqFAri9BqwPEN+gIHprekZKw4CY=;
        b=HJMjpjZZ4FE6tODfEa019mQeBfjY96cDWvitTUJ3JpH/Bn4AE4XjHzA/76aPW6UlTL
         Qomlw+Wr6oFj3JdPdSorri91vK86EIOjhZWSQqHi4paueT1POxdTWxQF49HvrhDrd2eK
         vF3REaOn/uQy8G7fO8jdsPIMLRoxlIHN3LrE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742258435; x=1742863235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vQclP5cvHTI1P3oWqFAri9BqwPEN+gIHprekZKw4CY=;
        b=wsYFCfsZY2pwQDOrY1OFpZy1Qromg7gNDe4F5gZsiAVzgXx7EesuN/1iykoE6C3woZ
         FNhCVzgG6k6Eh3em1Wx8aFy3BCa8HZQWAmBWsikIVIAOB5c5UR87QRTYLxTiPqnilKyq
         ZwkJhIMLZCDwOt29mecXZgYuOymKdeiIuDnYEnIQ9LGpBBEsnxOZSx2WMYDdsxALyLxv
         xy6d7Aae5ay5UJ4L93FWsQMp/sszRYCJeMaR/BKC0kHWK35EZFPUJrCCzlNsPyV7596W
         MGFprgiF7ON4t7Gjo/FNLI4kkBK2KDeJldZ51a2d1/iKiPRgLOdmx+WwdZR4FhAX2BOP
         fiiw==
X-Gm-Message-State: AOJu0Yzg8Uz2RJBxtWuR1zDxpDGg+5buZmlNuOUDVYCz0HHIB6TwpyYH
	QZ0Hja3mJ/+hLShhcSxn/JGY8szfPVswvsOC+b0kiy5n0LwseoffFctiGHUU5f3bbP3jHrJXMGo
	SfTt1bXS6M38EooQap30agWvkz/JHknlx6/fAo6nSgWG9bFfB1Lj0OpF77YclSX5ItBkCn3iRh1
	Hl5J6sPSAg33BzV0b+7caDoM57sI05OmwSJJAFcptTEhqvi6xeT8Ps
X-Gm-Gg: ASbGncv+dWLS+OiomVxdaE/veCiHUOxsMSMmxXOTNqTBitRnfWSGe4ETaXelstw53pN
	qh4AVIvkWosrJXhaBNnGJcGIqvgJnsq+hJa2CRrd+mM7pKo9jSefNCetyLdUK06cg5StKzGlVBY
	lC18x3a3yueeaJWzhdalJ/sMz2f4oj5yTQlAkGn5HfRLSwN1ct7gSEDQ/fV92EuD693zhhpr+lU
	I/S7UixvU3ABCLBKjx5IC4NLl4C2KAdZ/b0GCSU9Nayczoq1avq+wFRwxs9g0TxQoYxqLIBxU/5
	PnqfFyrORtrleEcr8mSDZnISdCWF38pvmjxgVWmzuFhh8ciomFvbQ34o6eKMH+ldUHML0gxS5Mb
	6oiS0mVRvG5qOuYE8NIKlK7oYrw==
X-Google-Smtp-Source: AGHT+IHIaAa69q2Z8ANXe30r/tizHQHT896S2VWLzIZ4VMEnQe4ojb43pU2xocXU645TgXl4SoKLuw==
X-Received: by 2002:a05:6808:38cf:b0:3f8:cf10:f113 with SMTP id 5614622812f47-3fdee36f68fmr8838131b6e.5.1742258435416;
        Mon, 17 Mar 2025 17:40:35 -0700 (PDT)
Received: from amakhalov-build-vm.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fcd5c0007esm1999044b6e.37.2025.03.17.17.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 17:40:34 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: gregkh@linuxfoundation.org,
	bp@alien8.de,
	ajay.kaher@broadcom.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: [PATCH] MAINTAINERS: update Alexey Makhalov's email address
Date: Tue, 18 Mar 2025 00:40:31 +0000
Message-Id: <20250318004031.2703923-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in an email address.

Cc: stable@vger.kernel.org
Reported-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Closes: https://lore.kernel.org/all/20240925-rational-succinct-vulture-cca9fb@lemur/T/
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9763412a508..c2eb78c1ab75 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17945,7 +17945,7 @@ F:	include/uapi/linux/ppdev.h
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
 R:	Ajay Kaher <ajay.kaher@broadcom.com>
-R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
@@ -25341,7 +25341,7 @@ F:	drivers/misc/vmw_balloon.c
 
 VMWARE HYPERVISOR INTERFACE
 M:	Ajay Kaher <ajay.kaher@broadcom.com>
-M:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+M:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
@@ -25369,7 +25369,7 @@ F:	drivers/scsi/vmw_pvscsi.h
 VMWARE VIRTUAL PTP CLOCK DRIVER
 M:	Nick Shi <nick.shi@broadcom.com>
 R:	Ajay Kaher <ajay.kaher@broadcom.com>
-R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-- 
2.39.4


