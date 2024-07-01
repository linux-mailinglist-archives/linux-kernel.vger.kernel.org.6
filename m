Return-Path: <linux-kernel+bounces-236415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5DB91E1EC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151C8287762
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE221649BF;
	Mon,  1 Jul 2024 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nzcnSLtY"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B080416131A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843037; cv=none; b=r50UUQGWLiipJSe9a2YE/uhXzMdJqR3AZSKYriZUXBZ45xVUqc8SJFWA0qaZJ1aUVjlHwybz09vAppCmFPdVm4KNkuFi4lOCw4LFxFBPtWj1z5P+tOL9NFre62CftsvoHpwK9hQin5stALKukkgsH2KY7mg8uJtBVK3Y1ju2hiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843037; c=relaxed/simple;
	bh=jtq96ZNNa/AfL1Dtt/3ZyrKLiA4kq1Yax8bQ6F664ks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nzcJvXe58d9VdBYHaYXDa3FdeSAGbVOK6MflDWYyjTzydUaPEn1IbIL6d9A7kwely4jD0PnHgD9MYCphV4KVuzW6L/IIaFBdmEJTuzJ1aLtsqqmDQBbMzwL8yJAQ+K/o9RqXfxxGUrsdiNRG6vwmVCMyhCz1VcBDcSpJGDKtBbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nzcnSLtY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035f7b5976so4764157276.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 07:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719843035; x=1720447835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+M8qUhS2HMIvcqxK7I8+OHEMcY7HHmB9uXa0ioB0Jc0=;
        b=nzcnSLtYQhNN1+kZhPy4F75oEen61VEmA4eyuutp1nnz2Cgkh+2f5teJiw33AYH939
         Fmem+nNUQUZH0II23Lq65vd3V5SxeILG0lmAo2gNBmnMr7Hpmkq83pYSj7MIgRbWJPdc
         EwYQpFit6vPf17R66w4nUENPOjHP2wUyNGHaowrIEtYudnD0AVIpoBiigkyHl7ZBnSnz
         DpXhhvLMaad9NlpQQr8zIz9z/Ef6iFtezagt28uU0R6XQvzkHDBrh5/2KTh+uQL8Ga6y
         0SmSlerTP79ruD/SBK4BFyLMyRNwXHsejjTO9asRugma7lBwXtR4G9sNv0ehAnQbMdJF
         N+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719843035; x=1720447835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+M8qUhS2HMIvcqxK7I8+OHEMcY7HHmB9uXa0ioB0Jc0=;
        b=XQf9NfNl/YlQgNRhXduRCWBREBXGah4YRAzgOpGMF+WXa0T8MDJUkpBtLIuVj5/Gnq
         oqxEE+dh8thqe5UNQpDbdb3KJXRONt8yZe3/7rszK/lPgyz7iDndCQbVzuAvCumcW7Nj
         U3LLL/Sx2UxsGeUyy1yUzk8TUDUTsFK12tIS6NLONNCW+y9gfO1FdFszBcZzEG5vOGvX
         UmLN1EmWrk98LOE5PBoC8ly+HVzy0kY1GlEnhW3u7O5q8xLdxmcosIm5ZXq12OGtKdn/
         0DxYQrxxuX9PmoaX35CWBgF4HlGsQtALgfSb8DnnR8s8b5KAqxkvdQThe8jUWPrhhP/i
         c5IQ==
X-Gm-Message-State: AOJu0YyB7wo8M0NGxAGmter+zLIUiBkvbqeQtEZOl1TtUt1hYv12eSE9
	DcSiD3IylwHSnjVYe4LwU6Q0/grQMEV3fMW+4L9fPdKUmbpC8fD3PEufTYN5173tFCkvRg==
X-Google-Smtp-Source: AGHT+IHU6faq5swLr4VM252V1u8YtN9Qbf/vghFX8u/Fc1vyU3GUlL+ZgwhlUrHD4zGvuLhP4J5U2oFr
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:124b:b0:e02:f35c:d398 with SMTP id
 3f1490d57ef6-e036dafd3dcmr657209276.0.1719843034670; Mon, 01 Jul 2024
 07:10:34 -0700 (PDT)
Date: Mon,  1 Jul 2024 16:09:43 +0200
In-Reply-To: <20240701140940.2340297-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240701140940.2340297-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4798; i=ardb@kernel.org;
 h=from:subject; bh=XckN2TD4yRzsK8t8+e7/l7CLqJsGkKaE+dxkRz+/EXQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIa1px/KX4c+0/V6VfPsanLpEbnbjjtJ07ZMi74M0zu1M+
 8F/cnFGRwkLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZhIy0FGhsPnN4kyGC67zbGR
 Qeav+JKrfCH5P12kD5sWmT6s+fdYaDbDj/lh3Y8+rrdwCUw+zciXtD3CYtcEHnfb3SnMh28xnHP kBwA=
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701140940.2340297-6-ardb+git@google.com>
Subject: [PATCH v3 2/2] x86/efistub: Call Apple set_os protocol on dual GPU
 Intel Macs
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Aditya Garg <gargaditya08@live.com>, Hans de Goede <hdegoede@redhat.com>, 
	Lukas Wunner <lukas@wunner.de>, Kerem Karabay <kekrby@gmail.com>, 
	Orlando Chamberlain <orlandoch.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Aditya Garg <gargaditya08@live.com>

0c18184de990 ("platform/x86: apple-gmux: support MMIO gmux on T2 Macs")
brought support for T2 Macs in apple-gmux. But in order to use dual GPU,
the integrated GPU has to be enabled. On such dual GPU EFI Macs, the EFI
stub needs to report that it is booting macOS in order to prevent the
firmware from disabling the iGPU.

This patch is also applicable for some non T2 Intel Macs.

Based on this patch for GRUB by Andreas Heider <andreas@heider.io>:
https://lists.gnu.org/archive/html/grub-devel/2013-12/msg00442.html

Credits also goto Kerem Karabay <kekrby@gmail.com> for helping porting
the patch to the Linux kernel.

Cc: Lukas Wunner <lukas@wunner.de>
Cc: Orlando Chamberlain <orlandoch.dev@gmail.com>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
[ardb: limit using list of DMI matches kindly provided by Lukas]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 72 +++++++++++++++++++-
 include/linux/efi.h                     |  1 +
 2 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 68df27bd71c9..4870950c96d5 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -225,6 +225,69 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 	}
 }
 
+static bool apple_match_product_name(void)
+{
+	static const char type1_product_matches[][15] = {
+		"MacBookPro11,3",
+		"MacBookPro11,5",
+		"MacBookPro13,3",
+		"MacBookPro14,3",
+		"MacBookPro15,1",
+		"MacBookPro15,3",
+		"MacBookPro16,1",
+		"MacBookPro16,4",
+	};
+	const struct efi_smbios_type1_record *record;
+	const u8 *product;
+
+	record = (struct efi_smbios_type1_record *)efi_get_smbios_record(1);
+	if (!record)
+		return false;
+
+	product = efi_get_smbios_string(&record->header, 1, product_name);
+	if (!product)
+		return false;
+
+	for (int i = 0; i < ARRAY_SIZE(type1_product_matches); i++) {
+		if (!strcmp(product, type1_product_matches[i]))
+			return true;
+	}
+
+	return false;
+}
+
+static void apple_set_os(void)
+{
+	struct {
+		unsigned long version;
+		efi_status_t (__efiapi *set_os_version)(const char *);
+		efi_status_t (__efiapi *set_os_vendor)(const char *);
+	} *set_os;
+	static const efi_guid_t guid = APPLE_SET_OS_PROTOCOL_GUID;
+	efi_status_t status;
+
+	if (!efi_is_64bit() || !apple_match_product_name())
+		return;
+
+	status = efi_bs_call(locate_protocol, (efi_guid_t *)&guid, NULL,
+			     (void **)&set_os);
+	if (status != EFI_SUCCESS)
+		return;
+
+	if (set_os->version >= 2) {
+		status = set_os->set_os_vendor("Apple Inc.");
+		if (status != EFI_SUCCESS)
+			efi_err("Failed to set OS vendor via apple_set_os\n");
+	}
+
+	if (set_os->version > 0) {
+		/* The version being set doesn't seem to matter */
+		status = set_os->set_os_version("Mac OS X 10.9");
+		if (status != EFI_SUCCESS)
+			efi_err("Failed to set OS version via apple_set_os\n");
+	}
+}
+
 efi_status_t efi_adjust_memory_range_protection(unsigned long start,
 						unsigned long size)
 {
@@ -335,9 +398,12 @@ static const efi_char16_t apple[] = L"Apple";
 
 static void setup_quirks(struct boot_params *boot_params)
 {
-	if (IS_ENABLED(CONFIG_APPLE_PROPERTIES) &&
-	    !memcmp(efistub_fw_vendor(), apple, sizeof(apple)))
-		retrieve_apple_device_properties(boot_params);
+	if (!memcmp(efistub_fw_vendor(), apple, sizeof(apple))) {
+		if (IS_ENABLED(CONFIG_APPLE_PROPERTIES))
+			retrieve_apple_device_properties(boot_params);
+
+		apple_set_os();
+	}
 }
 
 /*
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 418e555459da..e28873eb19ed 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -385,6 +385,7 @@ void efi_native_runtime_setup(void);
 #define EFI_MEMORY_ATTRIBUTES_TABLE_GUID	EFI_GUID(0xdcfa911d, 0x26eb, 0x469f,  0xa2, 0x20, 0x38, 0xb7, 0xdc, 0x46, 0x12, 0x20)
 #define EFI_CONSOLE_OUT_DEVICE_GUID		EFI_GUID(0xd3b36f2c, 0xd551, 0x11d4,  0x9a, 0x46, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
 #define APPLE_PROPERTIES_PROTOCOL_GUID		EFI_GUID(0x91bd12fe, 0xf6c3, 0x44fb,  0xa5, 0xb7, 0x51, 0x22, 0xab, 0x30, 0x3a, 0xe0)
+#define APPLE_SET_OS_PROTOCOL_GUID		EFI_GUID(0xc5c5da95, 0x7d5c, 0x45e6,  0xb2, 0xf1, 0x3f, 0xd5, 0x2b, 0xb1, 0x00, 0x77)
 #define EFI_TCG2_PROTOCOL_GUID			EFI_GUID(0x607f766c, 0x7455, 0x42be,  0x93, 0x0b, 0xe4, 0xd7, 0x6d, 0xb2, 0x72, 0x0f)
 #define EFI_TCG2_FINAL_EVENTS_TABLE_GUID	EFI_GUID(0x1e2ed096, 0x30e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
 #define EFI_LOAD_FILE_PROTOCOL_GUID		EFI_GUID(0x56ec3091, 0x954c, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
-- 
2.45.2.803.g4e1b14247a-goog


