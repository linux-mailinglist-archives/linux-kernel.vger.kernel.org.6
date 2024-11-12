Return-Path: <linux-kernel+bounces-406880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 252539C657F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21881F25A4B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4EE21CF82;
	Tue, 12 Nov 2024 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cE2mp39U"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795A721A6EE
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731455432; cv=none; b=XCLbeFH06MBHT446HiTt5MOFS8mI8MUeEoK/CMqGOXetKSgDkugdX4xxjBSbLhAgeGnEt0HWch+vfXjP7BS/8Vt8Y0nnoReROqrHPX6vMPUXENG/rmTlyQIb+5qQw9k09zphJLQYdeDjra1EzlQBJMp5RibDUx2cDBpMmeguGPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731455432; c=relaxed/simple;
	bh=jGUpsTFomPWWXjw46qZdwcX2deTWeyqCjUsdBykdJDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FNYUhXfCrHFL0yXgRAvnWVt/FOM71RU0FrdUG+FW1aH8zhM3/3eTkjCLtJ35GI3RaGvtl6M1fKy33n3aEoQ86Um3miI+h1MCqswiBsu7j+Jf31wl4o1CZUI83i4I0hyKSl1j//iftABdUP/eLXPFgSzzNNTVobwhqE1fhAlLAbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cE2mp39U; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b1539faa0bso406552585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731455429; x=1732060229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW4qOuulsceYOUAjEJcoBjEr83Bo1JfDsK+YY4/2dLw=;
        b=cE2mp39UmruhVSbqSdTUKP3ZntEeFK3I/bIBI+xCdVxM36dsMSXY8Fgl9Q7H0wiZar
         9eKOxy5hKMaTQNNoRPNhhIDW4MN1rPCpJFQV8/YVnomW/GZsxNgq1kHrcweAo8HKu794
         TDTF8jic3hUlrlRCZy5M32Mye1MUXPl6+ToN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731455429; x=1732060229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pW4qOuulsceYOUAjEJcoBjEr83Bo1JfDsK+YY4/2dLw=;
        b=gbSQ8eueHi+aQO9e9RjU+C9ZuWj0XJTQ8oLos33VEUQeQvu24jRF/cpIl6o6D+dKAN
         WDgHPlpk4axdycNi63FqeZnuQoI12EofpngAhudHH6MyTPi41IfcP/W5GuAP68egHy0O
         2+oZD8D4kc+Y7un7aRPj5VqnbnFvu3ggLZg1m6VXUiDQhKjgnexxHQUQ8ASkbvgLhczl
         hjOfeL6wl3Uzwz6o9ECooQRTE5UvAmyEQjvPQG3PxBG2PAcBBhepcN93khbOgyFpaDih
         XUlS+XmbJHyVcOXbQ3N/6ByH8kAH5IWL7HQMTup2TeoHRu8u+lrrZgFEZGGk4WH0ZwYe
         vTLg==
X-Gm-Message-State: AOJu0YxYM2PpSrWNHULwNIjxDxzjPZ4bW9tFSltJCWwf+rTx845yUklU
	Z7BmKzYBuA45aqz2QIl3dD2J3QOUfqJJm2OI8DVpaMJTRnUiMSDZoWiu2xIzL1em4KQU8AELhj6
	VfbDMEZsdxA67xvaw53JNU3MfMxQXk/ukrYPa8g8YwknWngNDhwYusZk/jI5sFOQVqKtnDzTLnL
	kaE3P8skFxEdL9Xik+0RcCU2M+PfjqCv/aKM2XEJPEjjX6rcEdxqDT
X-Google-Smtp-Source: AGHT+IHGZMFCkebkrnfaoDI+6pcdjcBsJC+I6PNu9SuimG9cg17ChQxVCcXVN8XZtd0cIcvmhI+yKw==
X-Received: by 2002:a05:620a:4482:b0:7a1:df6f:3625 with SMTP id af79cd13be357-7b3528cf50fmr98703885a.37.1731455428946;
        Tue, 12 Nov 2024 15:50:28 -0800 (PST)
Received: from amakhalov-build-vm.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32acae4d6sm640019485a.79.2024.11.12.15.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:50:28 -0800 (PST)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: ajay.kaher@broadcom.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: [PATCH] MAINTAINERS: update Alexey Makhalov's email address
Date: Tue, 12 Nov 2024 23:50:13 +0000
Message-Id: <20241112235013.331902-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20240926174337.1139107-1-alexey.makhalov@broadcom.com>
References: <20240926174337.1139107-1-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in an email address.

Reported-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Closes: https://lore.kernel.org/all/20240925-rational-succinct-vulture-cca9fb@lemur/T/
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 21fdaa19229a..bfc902d7925a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17503,7 +17503,7 @@ F:	include/uapi/linux/ppdev.h
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
 R:	Ajay Kaher <ajay.kaher@broadcom.com>
-R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
@@ -24691,7 +24691,7 @@ F:	drivers/misc/vmw_balloon.c
 
 VMWARE HYPERVISOR INTERFACE
 M:	Ajay Kaher <ajay.kaher@broadcom.com>
-M:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+M:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
@@ -24719,7 +24719,7 @@ F:	drivers/scsi/vmw_pvscsi.h
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


