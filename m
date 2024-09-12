Return-Path: <linux-kernel+bounces-327005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23666976FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252541C23E37
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9F71C0DCB;
	Thu, 12 Sep 2024 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U1Y3vEOI"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780151BF80D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162753; cv=none; b=OBNDnEm+HgRWMr/GnT4/Q/p3l52ZCPg0+XofpIROBDBn4Hxi3dQnl5k9EzQlHHYBnKQ4lxEMx0HdPGsfMv7SzE7IVwLcrJpq4Gyv7xFaQ72hDxcgjaAV/nuPbyC1q3s8m5uJE3I9YEyMGHr4Gmm+v0fdRTXWdxSVGv1m60p2exE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162753; c=relaxed/simple;
	bh=sdvuNJYXbnl+iyClqdVA5O83W4ftzy+TWXXAq64uN7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHVPNd7IeG20NNGBOQopXP6203m16AlQ3CmS9cXTRZtH203o/gxh1BDGD0qYg4Leczi2+ivzxIR8925NJZplSJ9WiNAOf0wMXwbVCdfxI5Mv/vE3YU0IwGWmUnt5Zupe6gHnQ4dKVM7E/3qbeDyO7fSvmRH/2LSIH9wMNm99SBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U1Y3vEOI; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39f49600297so5076515ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726162750; x=1726767550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qECmHjc9dK1dFT5mGpczd6pcWBHqdXTgofYQGynhgPc=;
        b=U1Y3vEOItKe8tEuj3rwDpOKtrApa7FG5bxRYPzR0tof42evGHKbnPzFBXaUQsS6KTT
         znu39CIx0KyRHwig0KURQgTIhGoccC4LB8vDWMzuInXsTft2w3Ggc+qjLR+fzAwEQsgi
         pj+O5eR0jv35WqhXYJX0RAUKTjBJeN4f1nVCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726162750; x=1726767550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qECmHjc9dK1dFT5mGpczd6pcWBHqdXTgofYQGynhgPc=;
        b=LbWOKYeqMw3E+H2ONdrZkeKVGNXY4qaDrTSxKSDxUqdf3NTa1JfuE7uXPSLJsK60Oy
         aG17jK80+1QKoMKcibBkE777Y+4oIGGiiLvs7GP31EC3qsnDjSkGrSMBhVvYNq+vsW5+
         gxGl/zIob4U4Yy0fEZVyKP4trPqwsn70Rlo3VdfVj6QrbHgy5R2dr88ETVZ968BSdnw9
         YYgowFj3I4nwekAsbq+OcibYVukSoN/SZQLSpetngqabpKgU1lByCqvavhhhdLtgE8tm
         zNtVJReco/BJhB+4tzc5tzmkTxLtawmYSe4OtojwNDC2Gr4aLtBp+ZQLJBJjtVprnn+4
         8lHw==
X-Forwarded-Encrypted: i=1; AJvYcCVjKJI32DObioVNoJPycwDT/40pudnv9SZ5qhLPqO/gwvi8tOYJ0hUUTkuyjohnPlCu/XNcwiI6VTmXmn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjTH46JX4VQKSa9IfqciUr7mvLjJIS0iH5z/UbLQPixuFjhBWH
	XVpkYE2/P7fELo+FBxmaMeOPO5X6KYjbDLenzjwVLYMgaddN2f26mNFDmb9hlg==
X-Google-Smtp-Source: AGHT+IHL4MH+QIKEB9bCMel4ROL7d0o5CwGYlEvbEC0U2AMuWF6C9AaGEEJwAGhel0XN8qNUrPvZtg==
X-Received: by 2002:a92:c24d:0:b0:39f:6fcc:fcc with SMTP id e9e14a558f8ab-3a0848ae8c0mr36173705ab.4.1726162750451;
        Thu, 12 Sep 2024 10:39:10 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-226.arvdco.broadband.dynamic.tds.net. [24.56.189.226])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a05900e618sm32570135ab.55.2024.09.12.10.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:39:09 -0700 (PDT)
From: Raul E Rangel <rrangel@chromium.org>
To: linux-serial@vger.kernel.org
Cc: pmladek@suse.com,
	rafael.j.wysocki@intel.com,
	ribalda@chromium.org,
	Raul E Rangel <rrangel@chromium.org>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	acpica-devel@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ACPI: SPCR: Add support for rev 3
Date: Thu, 12 Sep 2024 11:36:21 -0600
Message-ID: <20240912113616.3.I1b7a5033a2191cb0cdbadc2d51666a97f16cc663@changeid>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
In-Reply-To: <20240912173901.3969597-1-rrangel@chromium.org>
References: <20240912173901.3969597-1-rrangel@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revision 3 supports specifying the UART input clock. This allows for
proper computation of the UART divisor when the baud rate is specified.

The earlycon code can accept the following format (See `parse_options`
in `earlycon.c`.):
* <name>,io|mmio|mmio32|mmio32be,<addr>,<baud>,<uartclk>,<options>

This change makes it so the uartclk is passed along if it's defined in
the SPCR table.

Booting with `earlycon` and a SPCR v3 table that has the uartclk and
baud defined:
[    0.028251] ACPI: SPCR: console: uart,mmio32,0xfedc9000,115200,48000000
[    0.028267] earlycon: uart0 at MMIO32 0x00000000fedc9000 (options '115200,48000000')
[    0.028272] printk: legacy bootconsole [uart0] enabled

Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table

Signed-off-by: Raul E Rangel <rrangel@chromium.org>

---

 drivers/acpi/spcr.c   | 5 ++++-
 include/acpi/actbl3.h | 6 +++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index cd36a97b0ea2c7..67ae42afcc59ef 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -209,9 +209,12 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 	if (!baud_rate) {
 		snprintf(opts, sizeof(opts), "%s,%s,0x%llx", uart, iotype,
 			 table->serial_port.address);
-	} else {
+	} else if (table->header.revision <= 2 || !table->uartclk) {
 		snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d", uart, iotype,
 			 table->serial_port.address, baud_rate);
+	} else {
+		snprintf(opts, sizeof(opts), "%s,%s,0x%llx,%d,%d", uart, iotype,
+			 table->serial_port.address, baud_rate, table->uartclk);
 	}
 
 	pr_info("console: %s\n", opts);
diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 8f775e3a08fdfb..afe45a2379866a 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -92,10 +92,10 @@ struct acpi_table_slit {
 /*******************************************************************************
  *
  * SPCR - Serial Port Console Redirection table
- *        Version 2
+ *        Version 3
  *
  * Conforms to "Serial Port Console Redirection Table",
- * Version 1.03, August 10, 2015
+ * Version 1.08, October 7, 2021
  *
  ******************************************************************************/
 
@@ -120,7 +120,7 @@ struct acpi_table_spcr {
 	u8 pci_function;
 	u32 pci_flags;
 	u8 pci_segment;
-	u32 reserved2;
+	u32 uartclk;
 };
 
 /* Masks for pci_flags field above */
-- 
2.46.0.662.g92d0881bb0-goog


