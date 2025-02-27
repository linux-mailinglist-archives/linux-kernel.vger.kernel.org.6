Return-Path: <linux-kernel+bounces-536304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1E7A47DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3C2172908
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3DF22B8AF;
	Thu, 27 Feb 2025 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FrxGrIna"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8EA22D7B2
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659837; cv=none; b=ZlfvrHiSMXlR0B1Tx7w3FL/3BHpWMjKC+Gozcr6ixNMeP9UOK9Aickgccnl0piptcF4vDmOBHIzm9sxojbu8FqcbTjJpj/bKhD7XtOF1o8WyGpPBFyYb85bCCESkrfNF52t8GKLR0Iz77oj6bAL5dXoRxOcbgFS4MS0Re0f2sdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659837; c=relaxed/simple;
	bh=nwb9jXPHNocc0BR85JL7p0Pq9kLj9IODjbMJ59HBlc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNcy0ijfPtBYozSIGllrLm/IRZbm7ZAiCHL7SRovOMeVlhNQ3XwBGSkK8bqCMm3aiIszWPzfzrIoHcNfJgfh3A55sDsJdIXZWaJ5Ssw2iEBYIZSZuUSzkCgds5Ngq5kVQ2J3ra7+yEP3txTj+zNDnKJmDiPyH1N2cqnD/XGfx7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=FrxGrIna; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-221057b6ac4so12741935ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659835; x=1741264635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNRn4grONdQPyJNJQgM7dzqjQjDGa6sfyVxFxG4j7Yo=;
        b=FrxGrInaEMo2o+tNyEgcDBM/rqIyuObzmxmjHxzGGm1WeD/h9+FEz0P5Q8th6tnPHt
         KbZCSleoKgCVflj4glTlmecBuaYMf/46rnlRvnbmh/MiDbbuymDrFnW6ECnIoYCANAy7
         b5uHOgZJQOTpGVHLRKq5V6HFFGef7n5k1CXvnOGEYULRH7axeh6nWH0XaP0EyKtT9YMN
         Gi/eE1rf5ENt6TKsBy3sxI5mGGeMqQQDrzJ+Yu3OOVSBU2vb/Z0et4jHcIUAQ5v9lNcs
         I/fKbxgQVKRwWq9JeGDDsTuzwH6bin9anKJUl+Ima9wR/3PzewQZGAL1MXVPKAiKm9e1
         +iSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659835; x=1741264635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNRn4grONdQPyJNJQgM7dzqjQjDGa6sfyVxFxG4j7Yo=;
        b=Ncibc9Qu2pqxbdj1cW7SJS2Hb1bWOCD0zs7LyxJMwhONi3Yu3e5jEYR61B85upM2/S
         o1WaS09N61RbqCkNWIcFMKZlXWzREWZHSnKRZVHvZ6LoRyo27/7hv1TfjE9Pp/RaVnmZ
         Abigj0WbacjJVL2uMy2QMdbV8HOsCAufyCgFomES3StmbIe95rU5zHL6N4DSD/YsCRsS
         4Sdz0IRDXqwug+sCS3RhD88SXu5N+XSgRLGeIZCDDE745oupQnaWE90EA47WRdNqS3Xj
         gJHBX0LwUX1aZXLkh0ML79gy34v7N5YlvhcAdwPz8lACFiq/dHwb9l1Xmsz1fQgI0fcJ
         PWmA==
X-Forwarded-Encrypted: i=1; AJvYcCWBigcqjIvdK8I200UJjn5OH6q7LnpL/tv9Ytn/hBMaAUWgxntvHoF5JY3X1ESSuN469eHzC9hL3oT37kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaTPm6vqX0/1bt43+PhozfKKyjdUWFN9dRGIEbg6ip0i2hu5ar
	yi8RK7qU9zt7b04FjAPOwHGXiWpLoMNCD4qwV3McMJipacekQ4uaeBlLl2FzGcU=
X-Gm-Gg: ASbGncvoDDhqm+V6nFs9s9+D1cHh9jxdZsn6/b5xz2dw/aeL/zyK70CYfwwy3lvjvsn
	jruUfT/vpS3BVwJSqHa+7Bn0dm0bie6LWSCiLI9Y6aEXM1ul5q+dJ39sODkTXMpmpoxJ3aBjO7f
	LUah8o+3YPnL3cjbLwJ8/ZqeTYzonftTu90e29BTnEOnYs0TqHA0dqxPv5mDsqNR5NHtvfyYX54
	k6MTvGlYCVZ1X1GHxuLgecPERIl1M0e8+vXIRuRCrzQdMYXuGlnyHFYjW/XO/gNNjwwSqLIb33t
	pbCewmf2sNx6zRVUnCSJ5i6ePTGFMf3VuT99
X-Google-Smtp-Source: AGHT+IG53PBDiu6FVTVuBFXKbMl/pH0m+lbJmkXDl+xjPCROuVKlD+c6+Y7yRaOAw5SWzcbapXcaKA==
X-Received: by 2002:a17:902:e752:b0:223:3bf6:7e6a with SMTP id d9443c01a7336-2233bf6806bmr72051025ad.12.1740659834816;
        Thu, 27 Feb 2025 04:37:14 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:37:14 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v1 07/10] riscv: Add RISC-V entries in processor type and ISA strings
Date: Thu, 27 Feb 2025 18:06:25 +0530
Message-ID: <20250227123628.2931490-8-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Add RISCV in processor type
- Add RISCV32/64 in ISA

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/firmware/efi/cper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index b69e68ef3f02..f2908296a48f 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -110,6 +110,7 @@ static const char * const proc_type_strs[] = {
 	"IA32/X64",
 	"IA64",
 	"ARM",
+	"RISCV",
 };
 
 static const char * const proc_isa_strs[] = {
@@ -118,6 +119,8 @@ static const char * const proc_isa_strs[] = {
 	"X64",
 	"ARM A32/T32",
 	"ARM A64",
+	"RISCV32",
+	"RISCV64",
 };
 
 const char * const cper_proc_error_type_strs[] = {
-- 
2.43.0


