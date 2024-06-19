Return-Path: <linux-kernel+bounces-220642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BD190E4DB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8048A282D63
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148FD73514;
	Wed, 19 Jun 2024 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ulgggEqW"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46FC1BF50
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783380; cv=none; b=FbNjz7djN8N1ZI2X3UXt3ZiDfKc6ikCiuInrLNrdYsHCti9QNLAWcuPjwubuBJ/mqwbb3svnbHQqyYYXRBHu8wXvo+Y0PmHN9h4IYhgqb2DNZXTEJmqre6yzZY4tBshRpqPdKbRKSKMqt+wtrE7JWJX2TxjgzrqIJIhYeu+rl2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783380; c=relaxed/simple;
	bh=AMUv1k1JZA441LqC8JGNtb6ibewwI30cR2GFUhuMYYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DmbO/xVOdfP6yBbcu4qJ55Zrg8Tad0S78Coqy+ZD5lFsyXXM9ljeMkJtQtSlIRg9FXzVi0ZF0cDArwtMZ/ozCUoqdkk1xGvyIAJ3PNxD3o5oVJl2gB1PPhFoFeUYoukRlsKie8mmG0Sa7aB1T7r+gLm1t1mocN7+JG1b1alXUiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ulgggEqW; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2318B3F2B3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718783376;
	bh=CM0tJabmgofzChC2Jf92TOGwoJKVUZCa/x4U+pACuQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=ulgggEqW/Q2TnCo/u+gTMHU0ocAc48aR0ZDfI3KKXMrruJQ7v15ueqXWnrQmEVJcC
	 jquzgJCesgFGrlIuIfAYVzYVx+roObBhZMzj2ab54y9aOoCOhcnlWu6S3Z6FUeSx9R
	 f6SH6OYO6Hxzknoua7VnQ/JfTAz2q68rcKomiq7kAqtqlaC0qxALGso8qJjZD5WBPo
	 5aC1iklvMa0mL7RBgkJZdeZOlj3W748DqEgB4BrxLerIT65y7s6uoUWWQbT5DuA8VC
	 9ZxcjWDIxPwv4jf9QN8Ig0xgK0vnub3xinhkvKtmKGNaNO8rm9NCz+Insfycqtpy0O
	 0dFGIIiKce8Mw==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6e231ed9e5aso5724706a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 00:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718783375; x=1719388175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CM0tJabmgofzChC2Jf92TOGwoJKVUZCa/x4U+pACuQQ=;
        b=XY0FPTySfclSZclAxqW1mMYCbnuVpw51x4oRXesMFClhNL3lQ4j+TuitADn/iHB51j
         3MEUbC3w3wjSVYKi4q+VJ07uFX7px51/qdVDd5Qs2PewoTxNG+mc4m1+wgtgdrZBi5ls
         BYm3XfKovYjQWlwFRYaiUYhad37NhJWiiJR/rG+6ktaunoSKALwB4DJ2HxICoQGdaxJ8
         h5Ev5tZ6oYvyJxYLkOh9bdOGz3Oiw86RCT03F9Mp1gGOAQ7tnxdMELt6DVDdSpJ3vSZj
         Q+e89GBNBVQYBZZrX6EPeqmqGJLzFVt4YSL0lwKZKBuB/TpRJgodEsA3HkgDv2mr0cYg
         vTAA==
X-Forwarded-Encrypted: i=1; AJvYcCVl6S5Fg/u27YcFT9brKsHmBPmwr0i6sa4LuVQc89fg/LYF0v0sePJoNdGvfVKlmV9Lv57VvgDjt7qfk8xp9kvga+Gw9ak6vTZwQw5M
X-Gm-Message-State: AOJu0YwLaTx2B936ONsoCISQGvt3Lz6vMj2qhVZLNuS6MLIUaS+x4EsD
	ukWmCcwpp/CDWV1+K//xl5lXTUNYbFhTYSL9IqPNVf/BtL3CQP3yotWRU7Ex3oo9y94pdvkt6Op
	oEq20+H/1ihPC8fsmj6K2D8+uUKaBswJ561gPbnlvLU3RN+ol400UGlzZ1aXsp2D2FodqoMEvsP
	LLFA==
X-Received: by 2002:a05:6a21:7898:b0:1b6:3fc5:d08b with SMTP id adf61e73a8af0-1bcbb5f69b3mr2061137637.40.1718783374841;
        Wed, 19 Jun 2024 00:49:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFueb25CpMA0VBGCJYkQ2zZBzAZ9sDnZv2oTRH0EbyjQXTFuYV8CxfuiByai7Dd1DCYSMiqZA==
X-Received: by 2002:a05:6a21:7898:b0:1b6:3fc5:d08b with SMTP id adf61e73a8af0-1bcbb5f69b3mr2061100637.40.1718783373464;
        Wed, 19 Jun 2024 00:49:33 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1.. ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3cdc6sm10076908b3a.138.2024.06.19.00.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:49:33 -0700 (PDT)
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: kuan-ying.lee@canonical.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] scripts/gdb: redefine MAX_ORDER sanely
Date: Wed, 19 Jun 2024 15:49:06 +0800
Message-Id: <20240619074911.100434-2-kuan-ying.lee@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619074911.100434-1-kuan-ying.lee@canonical.com>
References: <20240619074911.100434-1-kuan-ying.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the definition of MAX_ORDER to be inclusive.

Fixes: 23baf831a32c ("mm, treewide: redefine MAX_ORDER sanely")
Signed-off-by: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
---
 scripts/gdb/linux/mm.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/gdb/linux/mm.py b/scripts/gdb/linux/mm.py
index 515730fd4c9d..30738f174fe2 100644
--- a/scripts/gdb/linux/mm.py
+++ b/scripts/gdb/linux/mm.py
@@ -59,9 +59,9 @@ class aarch64_page_ops():
         if str(constants.LX_CONFIG_ARCH_FORCE_MAX_ORDER).isdigit():
             self.MAX_ORDER = constants.LX_CONFIG_ARCH_FORCE_MAX_ORDER
         else:
-            self.MAX_ORDER = 11
+            self.MAX_ORDER = 10
 
-        self.MAX_ORDER_NR_PAGES = 1 << (self.MAX_ORDER - 1)
+        self.MAX_ORDER_NR_PAGES = 1 << (self.MAX_ORDER)
         self.PFN_SECTION_SHIFT = self.SECTION_SIZE_BITS - self.PAGE_SHIFT
         self.NR_MEM_SECTIONS = 1 << self.SECTIONS_SHIFT
         self.PAGES_PER_SECTION = 1 << self.PFN_SECTION_SHIFT
-- 
2.34.1


