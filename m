Return-Path: <linux-kernel+bounces-328165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0745977FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796DF1F21560
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5698A1D9323;
	Fri, 13 Sep 2024 12:28:06 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0851C2BF
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230486; cv=none; b=mA7jNV0c/F9uXfqPHTIeas1HK0oiNGS8E2+71084NidK0aklKhJMtKYBYTEDwYVss17kq2jNO4gaLCExbtXTzqDMEpmJqoXDQQTKSxhnZ8zvWTfwepBDSshdiKELhMGh8I7RUkjw2RuEmjtEGnRNJ8d7n9nbczl4DpFaNHfd4nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230486; c=relaxed/simple;
	bh=RK5S3zrgomn9+skT4aQ4j9kXPhojcRKZuS90n34VDEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ptnDjoLLnshC7qgcG2DrtOikgf9KxtR9fAUfZCKIblxTAqrv9oOi0Yhcf6n27xdK7HGXC8YHq7elnIcYgChagQ9bwmh7+/Q6uaPawTO6vFd/GIszoAmN0XF9M2cklX3dpVDR6uWFY9S43Baf2ue4ji5KYl5CSCX6HcrxaO4SwQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso374974166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726230482; x=1726835282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0PdiN7C66G4aok0RazPvpU2qA/vYlEOU5wuWR2Un29M=;
        b=fDuNjmi9dmjod0rEe/c6icon0ZBT1/23AhVEa2pxJJAxoY0kL3if2EvZ7yvof8Li8T
         y97W9Va8F2B0E1GDV4XhH43rEHD7pD0wsDAM4G+ZG3IWnTqcqElIypq9lK/9CJMc/H6A
         hYQkqqgGcdGpYTzRFOuYf/amZLdFLu8mqnxBcL2JkuXDU7pYGu+KXLQjDsIA28Sq3jBC
         p7884Szu9E9GpujqjlvoIIhLQbTxDNjzHWGTyiEZFkrgX+7KmLdCDCBcCITtTWI0YyX6
         1xLfgprG05lIEJYU2iibMT+HAVyQkFM3B44WmY/wjVe5m03mX6+XLKFvoAgGmV+uBTTJ
         52Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXwEqRhGtnk3ICM5i62zC4MibhkXiUfgVa4btrFwyrG9tBAuw0ZfPgqiLvlvMrivBsRtEes/FPn9ycmPmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSZo2nbM6lxplXp+X5XxdhP4Jy4RsHu2oiZoHZ9C5vyahOAjok
	mATwQRMjV/1l9SO/XuNFSBeHhlLd10i4YTZBUTL0vKCyO5GxNEr2
X-Google-Smtp-Source: AGHT+IHp7tyVCxPErikJEy3n9AhquE5p2KZrjNms5Lc1oV9O58Ce5kS9WM+Z1GqkpLzprbDkT8efJA==
X-Received: by 2002:a17:907:9809:b0:a8d:29b7:ece3 with SMTP id a640c23a62f3a-a902a8f0940mr639289866b.33.1726230481932;
        Fri, 13 Sep 2024 05:28:01 -0700 (PDT)
Received: from localhost (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cecc21sm862212966b.166.2024.09.13.05.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:28:01 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: corbet@lwn.net,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH] x86/bugs: Correct RSB terminology in Kconfig
Date: Fri, 13 Sep 2024 05:27:53 -0700
Message-ID: <20240913122754.249306-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RSB stands for "Return Stack Buffer" in industry literature[1]. Update
the kernel Kconfig to use this standard term instead of the current
"Return-Speculation-Buffer".

This change aligns kernel documentation with widely accepted terminology.

The line length reduction triggers text reformatting, but no functional
text is altered.

[1] https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/advisory-guidance/return-stack-buffer-underflow.html

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 007bab9f2a0e..5d87d5d7c6d0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2554,15 +2554,14 @@ config MITIGATION_CALL_DEPTH_TRACKING
 	default y
 	help
 	  Compile the kernel with call depth tracking to mitigate the Intel
-	  SKL Return-Speculation-Buffer (RSB) underflow issue. The
-	  mitigation is off by default and needs to be enabled on the
-	  kernel command line via the retbleed=stuff option. For
-	  non-affected systems the overhead of this option is marginal as
-	  the call depth tracking is using run-time generated call thunks
-	  in a compiler generated padding area and call patching. This
-	  increases text size by ~5%. For non affected systems this space
-	  is unused. On affected SKL systems this results in a significant
-	  performance gain over the IBRS mitigation.
+	  SKL Return-Stack-Buffer (RSB) underflow issue. The mitigation is off
+	  by default and needs to be enabled on the kernel command line via the
+	  retbleed=stuff option. For non-affected systems the overhead of this
+	  option is marginal as the call depth tracking is using run-time
+	  generated call thunks in a compiler generated padding area and call
+	  patching. This increases text size by ~5%. For non affected systems
+	  this space is unused. On affected SKL systems this results in a
+	  significant performance gain over the IBRS mitigation.
 
 config CALL_THUNKS_DEBUG
 	bool "Enable call thunks and call depth tracking debugging"
-- 
2.43.5


