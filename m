Return-Path: <linux-kernel+bounces-364391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2F199D408
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8411F23B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B68F1C233E;
	Mon, 14 Oct 2024 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+xWKeOS"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2E91BF81B;
	Mon, 14 Oct 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921392; cv=none; b=CKRlRKoLNu8O6WdXdXhQBYab8PfZ2WJnGlXoCzlKtV83V4IK2rJP9NKKjZmJGOO6S7pK/ZCCDY3YrwiqlaAyAllvNvDSMYZgI22l0xaCNdDVsi8OOG/XESQ/mfO1QDRXaExrma43LJcSzO49qlLbUa7FDz7kuOClYieV4S1+22s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921392; c=relaxed/simple;
	bh=vBiVR5RWvydOo3uoWV5/L0Dxd0mDdOOkmDf86g7wkXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h+alXM1eh2tTiOobeVsaOAQdqjNKjyVkdog/voyQ1bSY8F08RQ55BXjsm0LVxdCgtIVlP0IxoCzfpTCS3pyzosb7nlsWK8S52DeumytcaWOuLoO7RVNIJZW1lcF+cBAchm6L45hbOzedzSAU1tA3sIbJlxBqvFFjIaMeZkEStsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+xWKeOS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c7b9087c4so1687075ad.1;
        Mon, 14 Oct 2024 08:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728921391; x=1729526191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BH5HGN/lxU0eugjYDBTylsmIM0AthElLci7xGONaZ4=;
        b=C+xWKeOSed0w13Xo/rD6zSwqyhlXbzCOtbyFJ9JpY3fXOgG3n9u7OsgkC7yTQwtUT5
         8hi8ywrXt8HWShnp2d38cOOcilTnl8dvuuP5Mv+cbg0P7N6mG0nYspVe3AZqChQ+DubX
         1nh5EMDxR+qJ4Dm1e0/MHaH1Nwk1oVfON4ewCGSw0Gr3OoKf8GsbSGTzClnmbpXbKWJN
         xjOipwC29TnRskTRI8kKzqIZm+cfCSReGkT0TZbmgJ56R7H+6580VA0RP8oq/JtNWGJe
         uRqvAdDgEwlOXp3B0z20ZSxambine4n3CVjYFUOgnKSLdtmGipuGx2VcEtCFomQvnkRP
         JZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728921391; x=1729526191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BH5HGN/lxU0eugjYDBTylsmIM0AthElLci7xGONaZ4=;
        b=dzxJ3WoIjgM/iTYtwe3kyhRxETSa8YLo2rKKEh4tnd2Qik3bcIqKcc0yaQi5sV0+Iy
         hdQB7TRwbWI/Ui/c2ful4wqRoB8r5qkjYDO/QB2M2ndSjBazXN8SRr8qj6W5AIJj4EP3
         2oXcE4k+7PUlF6Un7iY+34aiNJ1OVbVC3J3MVYcnnb0T96P1mvcBa0vX9cKcXmMfkUoP
         GrFpI/mB63zU6Ch8kJ1oE+q98Vzb8S25gAtfLlo5sk73ZI0JnzW0N3SBha3/5gk/UeQZ
         9ljBr/P2hv+uBGu9ztgbo9lB4Wgg4OYyZMKR06zshZyZ5t4jDcPC/hsR42/UWb0g8eqn
         DqIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsY/AfvjoaPSN9YL3TLji2cRS0wmBeLItYKIQuds0cMzQUb7UfOtYaMCkPFILTEns2O+RReWyHi3Uk0ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLMK5jiXDeFJXFgFdEbsw8eWeHWQ/PPXH4/2R/gd+iIk8UnVE/
	JPve+MmpVg2Yw/D619C75oU4ULD6hZaoLkNGIjS+7sgIoLAsvkOa
X-Google-Smtp-Source: AGHT+IE+5ZUoNEfcv+vKrBuhgMuHJrjusFdF3vLKAxjNfqfnJl0D8AJ+7awUaBLphbufZ2eDjzkRPg==
X-Received: by 2002:a17:902:e741:b0:20c:bb35:dae5 with SMTP id d9443c01a7336-20cbb35dd69mr49548155ad.11.1728921390696;
        Mon, 14 Oct 2024 08:56:30 -0700 (PDT)
Received: from aizome.localdomain ([117.172.223.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d00363205sm11168485ad.53.2024.10.14.08.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 08:56:30 -0700 (PDT)
From: Pengyu Zhang <zpenya1314@gmail.com>
To: alexs@kernel.org,
	siyanteng@loongson.cn,
	corbet@lwn.net,
	seakeel@gmail.com,
	si.yanteng@linux.dev
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zpenya1314@gmail.com,
	yaxin_wang_uestc@163.com,
	zenghui.yu@linux.dev,
	Mike Rapoport <rppt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v5 2/3] Docs/mm: Fix a mistake for pfn in page_tables.rst
Date: Mon, 14 Oct 2024 23:55:25 +0800
Message-Id: <20241014155526.17065-3-zpenya1314@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241014155526.17065-1-zpenya1314@gmail.com>
References: <20241014155526.17065-1-zpenya1314@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation incorrectly calculate the pfn value as 0x3fffff,
which should be 0x3ffff instead. It is obtained by right-shifting
0xffffc000 by 14 bits.

This patch corrects the value to prevent any potential confusion
for developers referencing this document.

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>
Signed-off-by: Pengyu Zhang <zpenya1314@gmail.com>
---
 Documentation/mm/page_tables.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/page_tables.rst b/Documentation/mm/page_tables.rst
index be47b192a596..e7c69cc32493 100644
--- a/Documentation/mm/page_tables.rst
+++ b/Documentation/mm/page_tables.rst
@@ -29,7 +29,7 @@ address.
 With a page granularity of 4KB and a address range of 32 bits, pfn 0 is at
 address 0x00000000, pfn 1 is at address 0x00001000, pfn 2 is at 0x00002000
 and so on until we reach pfn 0xfffff at 0xfffff000. With 16KB pages pfs are
-at 0x00004000, 0x00008000 ... 0xffffc000 and pfn goes from 0 to 0x3fffff.
+at 0x00004000, 0x00008000 ... 0xffffc000 and pfn goes from 0 to 0x3ffff.
 
 As you can see, with 4KB pages the page base address uses bits 12-31 of the
 address, and this is why `PAGE_SHIFT` in this case is defined as 12 and
-- 
2.25.1


