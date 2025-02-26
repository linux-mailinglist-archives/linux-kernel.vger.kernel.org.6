Return-Path: <linux-kernel+bounces-534289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19814A46521
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6536E164601
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFBB18D626;
	Wed, 26 Feb 2025 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EliFiViU"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071C13209
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583984; cv=none; b=E0UTdzIdZEqLmwCBltUJaDZyrQqV3rseW15XNdcU/d9DUDnVMNqbYeNSItZ2HQu/RlGmQiEFSYbz0Qh/pk+RQcW2V3l2pcWvlKcwiZ5ubx0ufvrcCYDxGT8Y1aJHhSpX+LjVbVFuZJ4mlSO0POrbZbSdBtIEtxaUKc7RlpRefOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583984; c=relaxed/simple;
	bh=ddfEzWSCkfMka5YMwW6mZE6JEzzDPNpoKkDuvZz6YE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjEDtWAry4V/7yUlKZQGEBGDetrkTEjBtwZ9Zhij+32usL6hMq5ZM1arPJ8iXHAP7r7wbjpKXz8OPmRMs78uxUzbyzxJ2KuIH6Lvz38IAzS48C/XH3XGkd8M7QNfhsFbXGwUqyy7Zs0f2Y/PdMfx7IuHJdrQwJbJmXeEiJ0+k9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EliFiViU; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2232aead21aso2014065ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 07:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740583982; x=1741188782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oLaVxK/peyXmX/hfhFSKRYTEC4hb7vBZQRW6g6goaU=;
        b=EliFiViUxYQsrc+6GPplD3QKw2NONyXJ3uWifcy/DLkfk0RxLNlswxZC09N4l2Y62G
         jlFDtHoAc/pDZWXSXOjO8y185vCZ+zZozUVIhS39B5Vm6Ol/zfRBzGRm7avKRQ1K0M/E
         Xp9gZwCxo7Yjy97varWWgtCPFgS0x8TQA1Dv31W0EfLUG6e0Gd1RPcb7GxOtfH8lwhbN
         6i/F4N7yma9g8EMHf2I0IiMUcagP1WH0+tx+ieIzOoUI6WOyOK10DOE/6LtrxI7WYM+8
         ntNAX6wUhdvoT8o7Bn5GmtSOfESbaHFE3geDcMKQlWFuJYfrQYOdABjbEfA+Ft6f96qG
         lPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740583982; x=1741188782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6oLaVxK/peyXmX/hfhFSKRYTEC4hb7vBZQRW6g6goaU=;
        b=YnvwKxs6KSFZec8Vdi+Zvl7ToEftIZApgaG5FwRUvLR5NFlIUMhdWanRx2PwxEEoW4
         qaqj7cQphVGcrbLoaorm6Qsi7efjKHgu5kqwq0QJnL2JXGfBeDDZ6sh8lz5Vmp5hD/PR
         eRpzneQmZBCL7clBEBdHlLFBKNAZ176MWCw1TOAX8HprZbTQlw7rQdiczPCpD2hHqm1r
         RcPfaVvAYD9FZ2BFoedoEyYN/nnFvivnSe/CKoE36HUJraO1TM6gx7rHCWNklFm6U+wJ
         S1nOpxX4MDk1bapQ7324x/4MQERlPp2z+e712MXKtTLq0jdGPPQhIJbLSILaSd+dfGss
         eKOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0ra3olXXoh+LPUHSXpfnJW1amUyXSH7/woyc39nqzBxHkJxQk4HTzOO2Bqr2651+/bnsxNVeobCIfQGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe7DQfB4DcaBOr2Msq0TDk+zGMdkhtebZ6Qis5U+0W0hbAET8H
	6CBlbzjYJBAdNUe43Bwerl5xGlZPjVC5xd/8+TOAakK3sDzmF/eT
X-Gm-Gg: ASbGncvMD5CG3Y2kL6HZvg85iaGUMYTVOenEJNB2HiNPN6mmfJWi8iIEdiTiRqgZM2D
	HI+pULhq25gXrmxOlbdU/WZgZsV7jDJZ7pcXyb1rWGDAcOLfkdkApu0/HhLUnY0ulEm701qWtgk
	uD46983DTb4QAiPiKTiascf8a3yfeeKcGUo60bhlaTQ4izs0tvvxV1GWHjN+ENe+j1MZidzBGuc
	mmRncKWxSHR2XmtjWE97pFH83/j79hNdSHamYyhlpzZRKw3Z9h9mZ0dzEjYMo8DTqGi9fgzbsgQ
	5dZTUaCPXQvk2IG1RBbdiuOlgXY=
X-Google-Smtp-Source: AGHT+IEF5cukPMgHk1iC0V81Fu/6h3UP1oe65hIXnY53yBkz7HopBDeZIQt7xK2dewuo8IMAsRHdVg==
X-Received: by 2002:a17:902:d508:b0:223:49cb:5ec4 with SMTP id d9443c01a7336-22349cb80ebmr100325ad.3.1740583982196;
        Wed, 26 Feb 2025 07:33:02 -0800 (PST)
Received: from SaltyKitkat.. ([2a12:f8c1:41:1:f0df:d3ff:fe1a:fa0a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a0215f1sm34116485ad.63.2025.02.26.07.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:33:01 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: yosry.ahmed@linux.dev
Cc: Sun YangKai <sunk67188@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	linux-mm@kvack.org (open list:ZSWAP COMPRESSED SWAP CACHING),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mm: zswap: use ATOMIC_LONG_INIT to initialize zswap_stored_pages
Date: Wed, 26 Feb 2025 23:32:43 +0800
Message-ID: <20250226153253.19179-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226124141.22218-1-sunk67188@gmail.com>
References: <20250226124141.22218-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is currently the only atomic_long_t variable initialized by
ATOMIC_INIT macro found in the kernel by using
`grep -r atomic_long_t | grep ATOMIC_INIT`

This was introduced in 6e1fa555ec77, in which we modified
the type of zswap_stored_pages to atomic_long_t,
but didn't change the initialization.

Fixes: 6e1fa555ec77 ("mm: zswap: modify zswap_stored_pages to be atomic_long_t")
Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 mm/zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index ac9d299e7d0c..23365e76a3ce 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -43,7 +43,7 @@
 * statistics
 **********************************/
 /* The number of compressed pages currently stored in zswap */
-atomic_long_t zswap_stored_pages = ATOMIC_INIT(0);
+atomic_long_t zswap_stored_pages = ATOMIC_LONG_INIT(0);
 
 /*
  * The statistics below are not protected from concurrent access for
-- 
2.48.1


