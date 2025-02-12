Return-Path: <linux-kernel+bounces-510396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 866E0A31C31
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07834188ABAF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB371D516D;
	Wed, 12 Feb 2025 02:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PBDRk/e2"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3432917996
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328104; cv=none; b=eAfPGWqz8zfngR5gs/8Hus9luHWeFHcqREtrnPZuOrI+RrGk1H0yJaGJspZEPajik5A/jrQhyCUdRMO4dUTq2+XVgAa1UZU+ZJTZT+tggJybklPkfwYQYDja9/lNhehrUiF/zxBVT7klY2jcb5LDzr0IrheXtfvIEwEX1NVJcLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328104; c=relaxed/simple;
	bh=bZBx9CAU8LR0Xv0KMuavjoF4oWmvCyQ+7JvUPs86kFc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jTOMyCypxbNBc8lxLVIHC1bqYz0+FK/uk1M+iJMipf2UivqKg64AhhdY0jlobAY/UskamsB/kxN2yZYMUUbIZePMKotGKwcNwK4AX6dgi0l2LwoEiahWwXYxoviKiKcgFGv0CruqULieoQlya5uG+hqwTXpsaKbGQSBensbofkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inventec.corp-partner.google.com; spf=pass smtp.mailfrom=inventec.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PBDRk/e2; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inventec.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inventec.corp-partner.google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso1015912266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 18:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739328101; x=1739932901; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QlMN53vdSR0lP4XAuJiPTJ1FnZZbxWLYxjivwiQiLM4=;
        b=PBDRk/e219zKDWAp3YSWryFWhX9/YOGX4+inDSG8kJiTdk83DArq51qxmTlofpO6JM
         QuROjl+AVuzbaqBUYpuYhF32O9SXZqGXNx0V976qfBr4hwdzfcD2hBw2SrN2cDzoN8G8
         MYSNTYrlJ1CNZpKATg+rnaI78evM90+7klu6WMLe5ummUpURhNvS5xSRRMCU0X+ZiYat
         QCPHDo0pvQ9tVJmEpW3q4W0GEfORoj1jydPLpYvuOjU7Xsnw2qAzxnLX/orMRAIHn9aH
         tY8PunIgjf+T03Slz0BHOH33QWi10WamAEvalKvoXN4eYr222ZkkECvnS3BrXkJjX3mW
         9WwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739328101; x=1739932901;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QlMN53vdSR0lP4XAuJiPTJ1FnZZbxWLYxjivwiQiLM4=;
        b=I16rb8xBMur1Mw48tf0QTdYVCSkBPbqB1PW7TsdJRdseepIvw22U5QOUryCGV3iSA1
         PjCC1talhpyb3ymOeqpr0/uV74seYgTjHYuqR3JZbSdDTAZmRFh562bDQ8TtQja1sAez
         //DCSufdRJ/G/HoaN5Xx+ovcsQvIW+SJOOMbERFwD944OESUR2LMsPpH3edD2EPc9iJw
         /2h1/OCeuPhgPHaNiP8UJAYeTeT+UNPfEPxlJm0NhFy09LKj+9YNrb8i8huGcuGpZPbJ
         ICc8GkM4h+2DJEf9nGYV9AL2wxoxXtm9vt/meB+s4zyjc2AKBb8Bc+oGLYsHkFj2cx5i
         4iVA==
X-Forwarded-Encrypted: i=1; AJvYcCWh0MyUd0SvHfdkALeX1lThWPU9mBKbJGbTHC1XDjH+Rp6/4s6vlADelfyB6rv7N+Ui+KTITXDDpbAeuwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeQhpnf4LNL+fowKCvlDoQC99GEARx0TYjkRDQtccQWfvFNTVJ
	1CIVOcwUbQs73Wpv0tBcA62q+JEz4gfXak/UdgA9uwfgDZvs9F1nwpuo99ML22Xy3REJe65Ob8k
	CPRhAvsT3VRGTelZP5V1Gf+hCHsuabK/uUVm4BA==
X-Gm-Gg: ASbGnctW/mEMnSf3rYyTxWhexkZeasY+Oz8noX0qtwg4T1fp3wKGDyK0qqYHMP2rrLo
	bPd0FxiUvCFz9JIS1K3X/FimRJq9Jues0wYzyHH0AaAQBaUg2KBjquI702ZUSmkg/CN2ZZa4+DA
	==
X-Google-Smtp-Source: AGHT+IG4nQ1YBwxjUH+8FEZ2kuYPxDzK2xxJkRh7kmN4DD4wwtkcfnICDRGWz34gihKENw+iacq8x6K57iMkCNveEuQ=
X-Received: by 2002:a17:907:1909:b0:ab7:8e0d:3d3c with SMTP id
 a640c23a62f3a-ab7f3473720mr117097466b.42.1739328101289; Tue, 11 Feb 2025
 18:41:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kerry Kang <kang.kerry@inventec.corp-partner.google.com>
Date: Wed, 12 Feb 2025 10:41:30 +0800
X-Gm-Features: AWEUYZkwT_8RKgmlbzkwxkUt_zGHP1ABdT6Q62gnQ1rqkOtio7ezLauP1_SImm8
Message-ID: <CALNGHDAN6yvh+F07CuQW6Ru4pCCUeRt_fyRPf_254op8yq-N5A@mail.gmail.com>
Subject: [PATCH] mtd: spi-nor: Add Winbond w25q512jvdtr
To: llvm+subscribe@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Similar to the other ones, different size. The "JV-DTR" suffix is in
the datasheet, I haven't seen mentions of a different one.

The  W25Q512JV-DTR datasheet indicates DUAL and QUAD are supported.

Signed-off-by: Kang.Kerry <kang.kerry@inventec.corp-partner.google.com>
---

This modification is add BIOS W25Q512JV-DTR chip to winbond list

---
 drivers/mtd/spi-nor/winbond.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 8d0a00d69e12..6ce5f70bc11a 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -146,6 +146,11 @@ static const struct flash_info winbond_nor_parts[] = {
  .name = "w25q512jvq",
  .size = SZ_64M,
  .no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+ }, {
+ .id = SNOR_ID(0xef, 0x70, 0x20),
+ .name = "w25q512jvdtr",
+ .szie = SZ_64M,
+ .no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
  }, {
  .id = SNOR_ID(0xef, 0x50, 0x12),
  .name = "w25q20bw",
--
2.43.0

