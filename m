Return-Path: <linux-kernel+bounces-351662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E996991468
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 07:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A7AB235A4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 05:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAF754670;
	Sat,  5 Oct 2024 05:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8QJl+Vk"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5740C15;
	Sat,  5 Oct 2024 05:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728104682; cv=none; b=HBIDInufi95+Wq7BM6J46HnXbP5TPg7nU1v2ED6AqvZFWsyPMxzW3biLfWlDDW6+MZFAnl/qGkav4ujQGQzsMp33YtO6m2fEKXQ4Nx64IdlOrvXxWBeL8Tf97Ui2iJnhSrztK8gflatefAz6e0EPyXIgoBoT8avSLRPrYe9EKhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728104682; c=relaxed/simple;
	bh=cvzFHQlg2fQZzE+UmnCGUvZn0y2LLPfFyxkZMxa5ZEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWI+y2YLGe2olFhtM+/7a0urlvjCIe995A3ylmCqKrCw4Yy9S4uRtyCzAkI2AjPuWsl19+4f3PKswqzZI34rHRJs5+WLEtnNhtpT2VSTML0P8LBn6Zu+FspZ5o/k2bJ1wozNlx2TSUk6jGGb0MZg689WO4I919f02AXgXHRbozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8QJl+Vk; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e109539aedso2401834a91.0;
        Fri, 04 Oct 2024 22:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728104680; x=1728709480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhYJFY/3ez6e12f4SS2gZFove6N9JarO3wcT3pL3TYY=;
        b=W8QJl+VkiGeeoUBHxonQVyP0iq74+bEXN9Gxy7sbyc9AhBavEvWcA1UEHwQlkXG7uK
         GC+5SL6WHgnVb29j+hpfRuUDVBnOd02EwoXT08213xc1rI27JLV79XtJlNbh4/Pbbfep
         X6ajIgP6GN7tj5w5eWIyCzSN3NA3giCk9Ym5+NgCjSkd7C2/mCklZfvzqxZZz0lu4ItS
         IVS9BuG/Zh4xU9SnkT4D5xR/Y8jLgjrNW2kJ8cdJnLTZui9vwWoKQa4KrDVNDUL+uQUo
         PDzUnSEo1+jvA0gQUngGad3O+wlld8od+9d+vZZDXGGcpmZPcYGWubAcVWrM1pddas5H
         gnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728104680; x=1728709480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhYJFY/3ez6e12f4SS2gZFove6N9JarO3wcT3pL3TYY=;
        b=nDg2CBbYVMs70b8S1J/sF9ennQA++DCufhYT5MMi5nPF/z9amMtPJKtnlZuJ9CxeAG
         Ag/A+wzxL3oQ8oGAUF10gMM8WsbTYUkKSNVCnStOSIRnmv/9pLBpqDFQMkvg9LOcsukZ
         NEgXzF+wiAypRSI9KSIN6nLDVLNT8T3gTm2V680t49+GbQ3InyF5CDXBEEjoPcqNfhPz
         XSK1Sss2HEe1l2k+v7egoUFnflzXXP0VbhkhdKbSGU7SNP6KeTR5FXMalNvx2IRPzSz5
         y7xhDV5qzEmFfZtRHqgpYKkj1yWXjMKU7Ive4JDy00Uf9de0GrmU2eXF/eMA/NQRlu0o
         6/sA==
X-Forwarded-Encrypted: i=1; AJvYcCVGdIvJQ1leQoXy8/Xswux00YOb0sqJgZDuBnemcVpHgpO9/B+YG8f9YMDm3DM4gjTqiKurRetcAUFGwTBH@vger.kernel.org, AJvYcCXRa87Yxq6P6zMggXtPfP4xeAl88PAYCFZ4Ss7Jo7Yp17+ZOoHWvk7aLMBF0PmhCbJPVZMLkZlcxZuJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzuITDCFLMer53+slfG3TG+bjCbMGOUqcnQVRgci6zjuzqu4ROy
	ZnFea6G7qD5Vtr4rdrr6r63m0Sy1cDdK/yuFTimBPu/tugdjf9Xo
X-Google-Smtp-Source: AGHT+IFqU/bD9owh44BLnO7Dt8lW7NUUiiNoXHDfrVl05qMKf92usq8r5t6nJNkTf762XBPm1PCy4A==
X-Received: by 2002:a17:90a:7085:b0:2e0:a931:cb11 with SMTP id 98e67ed59e1d1-2e1e6213282mr6114447a91.4.1728104680268;
        Fri, 04 Oct 2024 22:04:40 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:ed3:4cda:b368:ce98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85db34fsm2625744a91.33.2024.10.04.22.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 22:04:39 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 2/2] arm64: dts: broadcom: bcmbca: bcm4908: Protect cpu-release-addr
Date: Fri,  4 Oct 2024 22:01:55 -0700
Message-ID: <20241005050155.61103-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20241005050155.61103-1-CFSworks@gmail.com>
References: <20241005050155.61103-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `cpu-release-addr` property is relevant only when the "spin-table"
enable method is used. It is the physical address where the bootloader
expects Linux to write the secondary CPU entry point's physical address.
On this platform, only the CFE bootloader uses this method: U-Boot uses
PSCI instead.

CFE actually walks the FDT to learn this address, so we're free to put
it wherever we want. We only need to make sure that it goes in a
reserved-memory block so that writing to it during early boot does not
risk conflicting with an unrelated memory allocation: this was not done.

Since the previous patch reserved the first page of memory for CFE's
secondary-CPU init stub, which is actually much smaller than a page,
just put this address at the end of that page and it shall be so
protected.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
index c51b92387fad..613ba7ee43d6 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
@@ -30,7 +30,7 @@ cpu0: cpu@0 {
 			compatible = "brcm,brahma-b53";
 			reg = <0x0>;
 			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0xfff8>;
+			cpu-release-addr = <0x0 0xff8>;
 			next-level-cache = <&l2>;
 		};
 
@@ -39,7 +39,7 @@ cpu1: cpu@1 {
 			compatible = "brcm,brahma-b53";
 			reg = <0x1>;
 			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0xfff8>;
+			cpu-release-addr = <0x0 0xff8>;
 			next-level-cache = <&l2>;
 		};
 
@@ -48,7 +48,7 @@ cpu2: cpu@2 {
 			compatible = "brcm,brahma-b53";
 			reg = <0x2>;
 			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0xfff8>;
+			cpu-release-addr = <0x0 0xff8>;
 			next-level-cache = <&l2>;
 		};
 
@@ -57,7 +57,7 @@ cpu3: cpu@3 {
 			compatible = "brcm,brahma-b53";
 			reg = <0x3>;
 			enable-method = "spin-table";
-			cpu-release-addr = <0x0 0xfff8>;
+			cpu-release-addr = <0x0 0xff8>;
 			next-level-cache = <&l2>;
 		};
 
-- 
2.44.2


