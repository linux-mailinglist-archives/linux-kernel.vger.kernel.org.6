Return-Path: <linux-kernel+bounces-275525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5682E9486D9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D6F1C2233B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CFA79C0;
	Tue,  6 Aug 2024 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2V6Jsvf"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B4D63CB
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722906214; cv=none; b=YskUgIhu4dfcq+gbOKngIXV4jph3dqXYojVTxZk00yhg0nlVEksNItNsObazUlNueZpEE5mEq4A/ZYVMBZeISWZOQTiU58Hqs7LzO5lSQ/dY/5DyMR7E0ku/JrgerAEusQWxYiLhF8onnOLiB3Dz4yBfpnFLOf73BJF866eEVWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722906214; c=relaxed/simple;
	bh=N91BVUJUQpc0/42Kk/EtdI5XI1Dxco4Mt6SymW4QFBc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GTV693vBaeDp2gkCXkp5is8H23H6hdD9am3Q1fyF2trOZtl1s0dOjTEGOMV31ar9Z9FMPQPOL+u1MrEVTu6m/LEHDJeBRYrbro5AnEdpJ5kFfARlORWcueIAf0JxhY+IgvJCrPayLRf0BZN22LiH/UZK36AR7Pmzhe3/iI3lNKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2V6Jsvf; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa63so269589a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 18:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722906212; x=1723511012; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlBLE24Vf8x82Lx7cHw6i6pfO3iWZul0LPn3B5Z/Ssg=;
        b=R2V6Jsvf9miO2LqJSXg7RChTSUCKxRhWQPEStZwN1pzxlL5bHtUtnVImOt5aGQVhYM
         y/SlEeDb7f664h2+MrUOeCFGAQpNh80VtbMA0715s/YzAHUDt8i8Q+i69Fzgyng19TbO
         FEIPa4MaoU+R3+VNhoPOP1gY+vT0QXxQpeXShTMv2+e441BzYR9Oa3DmI4IULxGY+Xfn
         QusLpSjuXgsTTVT2LscPBjo1z3yMroZolj8kuA0gTiuiiea882ZdzAZW85mHj4/I0nLg
         egYnbTXSF7FQiiFseXH668gKEWNPoB1SC5PGX74ezyVwTS+dj4152s+A7fUsFqqikCaz
         lcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722906212; x=1723511012;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlBLE24Vf8x82Lx7cHw6i6pfO3iWZul0LPn3B5Z/Ssg=;
        b=JQJMe1qNwhoikqCAWi0oeodD0rRUe3e7akHkoCjTvxKiA+BKIeoKsp2T1LpcxBHqcq
         pb2w9kJ2CBzkzKt154GSGGPRaFIJ/9Nevx/mYECfBX8V18fmUgwcbZZ6xUoA1M1VKqii
         2COKN4uH+sMC2ScyETwFZLboI0h82+FF2XvEuIsabEKzQFSyvvgFCXHGW91h62Kh45Kq
         hiRHy+wDybwsd/uL3/EosZ/2i1lqV76MV17qMkpYIoq5SB/XHVQt6myeZyrBDECYz+yg
         +3+Ezjc6ldDX/bYvahM9zhT0CCXgBnYFHwZ8KwJ33+UjOVl1WomBKF/LvzJzEfJW7/Hf
         +lLA==
X-Gm-Message-State: AOJu0YzqG0ccYsyVnHCWAEAdBPqdy6qKhq/nOHw/u8oFRKMMD0CBKPXg
	XyZFsja+/u4vlnSyn2OtMnP5smVykRZY7zMi458cZzAhsr7/B1JH
X-Google-Smtp-Source: AGHT+IFEb0c3XKnS+5AeW4mcUBerkQ0nLN/+crG/fVNCjco/xxVrkDP0BEGB53GnKBdJSL6aqOXrEQ==
X-Received: by 2002:a17:906:6a13:b0:a72:5f9a:159a with SMTP id a640c23a62f3a-a7dc4db4952mr889243766b.2.1722906211430;
        Mon, 05 Aug 2024 18:03:31 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc9d95sm506859566b.10.2024.08.05.18.03.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2024 18:03:30 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	richard.weiyang@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v4 1/5] memblock test: fix implicit declaration of function 'virt_to_phys'
Date: Tue,  6 Aug 2024 01:03:15 +0000
Message-Id: <20240806010319.29194-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 94ff46de4a73 ("memblock: Move late alloc warning down to phys
alloc") introduce the usage of virt_to_phys(), which is not defined in
memblock tests.

Define it in mm.h to fix the build error.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

---
v4: fix return type
v3: use static inline as phys_to_virt
v2: move definition to mm.h
---
 tools/include/linux/mm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
index cad4f2927983..677c37e4a18c 100644
--- a/tools/include/linux/mm.h
+++ b/tools/include/linux/mm.h
@@ -25,6 +25,12 @@ static inline void *phys_to_virt(unsigned long address)
 	return __va(address);
 }
 
+#define virt_to_phys virt_to_phys
+static inline phys_addr_t virt_to_phys(volatile void *address)
+{
+	return (phys_addr_t)address;
+}
+
 void reserve_bootmem_region(phys_addr_t start, phys_addr_t end, int nid);
 
 static inline void totalram_pages_inc(void)
-- 
2.34.1


