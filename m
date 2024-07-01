Return-Path: <linux-kernel+bounces-236414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6100091E1EA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147A2287459
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5749D43144;
	Mon,  1 Jul 2024 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x0XdF2/S"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE631607B9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843035; cv=none; b=oUrbbAQHIAu/Hn7v3e2iQrQsdCR4wYq+3DQsoIdaEjjhCHPNWxZogGqiNG8HDnW7UYKqugipju+4o0jEQN8dOxtpcRNo2NCIRq17d0wgajalaIA1voI0iv2JmRYHKFr+pd71KJ71ubYnuhrgPzMGln2X1nt7JDQj/pndjtodGmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843035; c=relaxed/simple;
	bh=l8Ualwom2J8JwCI+Zf8Aiq40+waFGySB881xmXf1eP4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=us4/OewYPXGpnHEFgiPRQazR4RnfHfA2onmkOHC3lu27DRs2bWH3pbc+EqT2xArQNB7/pUFjC2+RkxdKzOGnsjbVEFd6+vo1Id40XWQ0w6C2FRSsB0RVa3WtWnrSN2WxWUWnfo1zJ91gVpp9jU+KXY4dQEwcMo/x9pZYEqveIHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x0XdF2/S; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-364b75a8194so1962287f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 07:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719843032; x=1720447832; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=83i245u7toDjlY+7ig/slTXd44Gu7U3/g62W19tTjqs=;
        b=x0XdF2/SGlIyM7n4DgvTXcwkqZUO7tmj0rrIDgk4Jsc6eeec7ltnbhjdSfWGJgTpEQ
         Mm9oVK77YRJ+RaO+r0boAJF/GnCgY5LbZyGhLvlYyziumprDlIpNk/R24KNDlDIqNaLj
         7df5jlKHSaPSZF4FjddKL3TPq+iGABtr9xaktmBeo1f0HirqDGsmnUxj8b3tAse2XmgF
         p0eFtxsaDwrxAU/uojc/9+RlINvClo7Tp022vLM3hcvFWbfIs3wNkMjwn1ox0EgBPuFU
         nKiaGNBVdzvA8s4BAmtX+rwN3T7kH0bz88iNzl75iy7c/qsNQOTsEGfrvHGBezBVN/1a
         vDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719843032; x=1720447832;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83i245u7toDjlY+7ig/slTXd44Gu7U3/g62W19tTjqs=;
        b=XCk0BAxAyqONALGC1ahohmxfUEaUOtrKi5QRodu7fAuwcyfs3ES2daRsIciAdCY6yt
         zYQvf7QBE49UbiUEAGYvR77AYM7ecvE43qVPMn/RtBJMRqMdKMe9+W76yNAO5WpXWlXK
         +JYl3/ODOqtWn6q+GU3XTy4jhJhmTNMKSnnaxEdmclmk/ONuldpfCnJnwAmFFo9Gxad3
         7nSlH1UqaogGqFzq5QGQLzUlr43UK/RX3kZV/ikjctxh5S4rvJPyvxQPi/tOlm7CLn2n
         z5RVoZaYGbXk6DTvc9wwsm6Q6vwRp8Zj0RfgAhg+A61mFpg32IWA4SNiZjfDSYcIHuGS
         Jr6w==
X-Gm-Message-State: AOJu0YykAHxHEPY36m42QiHNHP0b20boEph5/zJCo9UtqQ4Jmc7sFR+N
	PL2Djx/GRwZlh+NNuQ2zQDRwSRkd1UQ1Fntvl4js9MdGN3eptpSsLM5DsCDj2YFTDC/Mig==
X-Google-Smtp-Source: AGHT+IEyUOS2qvddIR+vf8YFoD0CSmbKuw1dZ0cB+7G6AtRCr17Yg+XzRC0+YIDnxu724eN8PT+xfzKd
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:d91:b0:35f:195f:bbe8 with SMTP id
 ffacd0b85a97d-367756b7e8bmr10484f8f.7.1719843031971; Mon, 01 Jul 2024
 07:10:31 -0700 (PDT)
Date: Mon,  1 Jul 2024 16:09:42 +0200
In-Reply-To: <20240701140940.2340297-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240701140940.2340297-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3224; i=ardb@kernel.org;
 h=from:subject; bh=rpn41rOAt7Mo+ERBc+rJJUgNYcPSipWWVF2TfCtIHfY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIa1px7KSOI3Gxe3S617Vb05fwnTR2fml8n2F9fVSDhKZy
 uY8ZakdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCJ8ixj+e+Q9mfZoizRP8JG2
 SoZLq2zv1MlrFEtv8d+5rGuX8CRFLkaGF57f1hVEreD50nbwySSLt6U6l9fx/5SZsnLdj71diYr feAA=
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701140940.2340297-5-ardb+git@google.com>
Subject: [PATCH v3 1/2] efistub/x86: Enable SMBIOS protocol handling for x86
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Aditya Garg <gargaditya08@live.com>, Hans de Goede <hdegoede@redhat.com>, 
	Lukas Wunner <lukas@wunner.de>, Kerem Karabay <kekrby@gmail.com>, 
	Orlando Chamberlain <orlandoch.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The smbios.c source file is not currently included in the x86 build, and
before we can do so, it needs some tweaks to build correctly in
combination with the EFI mixed mode support.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile |  2 +-
 drivers/firmware/efi/libstub/smbios.c | 42 +++++++++++++-------
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 06f0428a723c..1f32d6cf98d6 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -76,7 +76,7 @@ lib-$(CONFIG_EFI_GENERIC_STUB)	+= efi-stub.o string.o intrinsics.o systable.o \
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= kaslr.o arm64.o arm64-stub.o smbios.o
-lib-$(CONFIG_X86)		+= x86-stub.o
+lib-$(CONFIG_X86)		+= x86-stub.o smbios.o
 lib-$(CONFIG_X86_64)		+= x86-5lvl.o
 lib-$(CONFIG_RISCV)		+= kaslr.o riscv.o riscv-stub.o
 lib-$(CONFIG_LOONGARCH)		+= loongarch.o loongarch-stub.o
diff --git a/drivers/firmware/efi/libstub/smbios.c b/drivers/firmware/efi/libstub/smbios.c
index c217de2cc8d5..2b54b9c289be 100644
--- a/drivers/firmware/efi/libstub/smbios.c
+++ b/drivers/firmware/efi/libstub/smbios.c
@@ -6,30 +6,42 @@
 
 #include "efistub.h"
 
-typedef struct efi_smbios_protocol efi_smbios_protocol_t;
-
-struct efi_smbios_protocol {
-	efi_status_t (__efiapi *add)(efi_smbios_protocol_t *, efi_handle_t,
-				     u16 *, struct efi_smbios_record *);
-	efi_status_t (__efiapi *update_string)(efi_smbios_protocol_t *, u16 *,
-					       unsigned long *, u8 *);
-	efi_status_t (__efiapi *remove)(efi_smbios_protocol_t *, u16);
-	efi_status_t (__efiapi *get_next)(efi_smbios_protocol_t *, u16 *, u8 *,
-					  struct efi_smbios_record **,
-					  efi_handle_t *);
-
-	u8 major_version;
-	u8 minor_version;
+typedef union efi_smbios_protocol efi_smbios_protocol_t;
+
+union efi_smbios_protocol {
+	struct {
+		efi_status_t (__efiapi *add)(efi_smbios_protocol_t *, efi_handle_t,
+					     u16 *, struct efi_smbios_record *);
+		efi_status_t (__efiapi *update_string)(efi_smbios_protocol_t *, u16 *,
+						       unsigned long *, u8 *);
+		efi_status_t (__efiapi *remove)(efi_smbios_protocol_t *, u16);
+		efi_status_t (__efiapi *get_next)(efi_smbios_protocol_t *, u16 *, u8 *,
+						  struct efi_smbios_record **,
+						  efi_handle_t *);
+
+		u8 major_version;
+		u8 minor_version;
+	};
+	struct {
+		u32 add;
+		u32 update_string;
+		u32 remove;
+		u32 get_next;
+
+		u8 major_version;
+		u8 minor_version;
+	} mixed_mode;
 };
 
 const struct efi_smbios_record *efi_get_smbios_record(u8 type)
 {
+	static const efi_guid_t guid = EFI_SMBIOS_PROTOCOL_GUID;
 	struct efi_smbios_record *record;
 	efi_smbios_protocol_t *smbios;
 	efi_status_t status;
 	u16 handle = 0xfffe;
 
-	status = efi_bs_call(locate_protocol, &EFI_SMBIOS_PROTOCOL_GUID, NULL,
+	status = efi_bs_call(locate_protocol, (efi_guid_t *)&guid, NULL,
 			     (void **)&smbios) ?:
 		 efi_call_proto(smbios, get_next, &handle, &type, &record, NULL);
 	if (status != EFI_SUCCESS)
-- 
2.45.2.803.g4e1b14247a-goog


