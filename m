Return-Path: <linux-kernel+bounces-357243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 072E7996E5C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3915D1C20FB4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE22A1A0B06;
	Wed,  9 Oct 2024 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Y6orSiGL"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37680198833
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484902; cv=none; b=d1bMLwUGaxbLDa6m4VAemwUhWQlURgvh5+Wz9PygB5Bw8EwifwSorXaVEHNiqQu48Qk+BK4qitGLhayvEhASNdSJcaXZdc7XrD9Nq9tVzgisQiNOBUWZOj1CWsuQXl3VVEr0yAU/ldj40gOvfwZ3sQB7ogbMkNNCRH12wQWp6NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484902; c=relaxed/simple;
	bh=ZkMXaGXK3vOYJa0SvIWW1dfqffTI0W6YThAuMAv9htE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kSuspMPEcuIS7E+GzkP5DVarjI+w0aqnQ9B0RpuVr+eoAeYRGzHYIGSkbclAEcaofi8RCM/P6PMewxGfkS66lkZ+v8pO1IKYI/1Bv5berokylHvLpHxU78pS6pvsq2pqZvVkYlv4Fa2ebfsP/wcH3O/90cF1N8yRN+JimTcgspI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Y6orSiGL; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea06275ef2so2385422a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 07:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1728484899; x=1729089699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIiaKwpes0nmcRx/K3u+SN5+YvMoD90XzWrUKk6r3qs=;
        b=Y6orSiGLd/BlwnPnhKtKJcmg06qSANR5CGxijQTMHgMMMCHkniGq/DQTBTpGc3oBFg
         VOYmh48+RvkhOEAlXCs1hkvAnvCO1KJaOrCQIPGwX5AIH0VM+XOcOe8vjkvgxcqbCF/a
         aKTMt4/6/yu/FHOY+UeOBQ/erdBERoStcZwYhAs5RDo6UiIu5bL408P+aQVi1v5I2u8N
         sbzD6osvAD/GgcU4yZMrJlijfDiQDoJH8ag6z8unSMKhkqSzWPIWEw6+MkpjV7cpEpyG
         CcD8fTevU8xBXl6Ue38HVhCN7u0b2uTWg8Ecvr5+YxIJZ2hhC2LhUBaZ9z6WAErD4TRM
         PdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728484899; x=1729089699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIiaKwpes0nmcRx/K3u+SN5+YvMoD90XzWrUKk6r3qs=;
        b=kZ66W7O5eUigMkK2otKZ9AyBiAXL2u8gLpyh/l9MlYvH+avrD69uhE5s/Fz8MhwPbM
         c+nho2fW5IOHNEFXdh3ZU2JFz5GgmfkjVcsfrO1i9o0sZZoRuZdawzt5CTuQ6ojC0QCP
         DxnUVU4g+ona/EUacdO6v/ql1Lpb+ya1T1qMV4i71Q+g46u2WA5NfUR8+LkYIbQTMBxh
         9oObjq+MfEXlbapfeHeimnY3sIMicHWxDPHEWx1yvG0Wdh9L/9X203HD587vOtQThuYu
         j7S50F4VBoOh3GQU9CZ/g8CEx6+RArO4Q54T4a4SZS14e547l4+UdMvZQZts9aeZou8q
         EIrA==
X-Gm-Message-State: AOJu0YwS0v1p9mtOGTcwd5IS8/+95/zTOXa9jjW30AV/bAXfbf/iaRm8
	eAqqTxbav3lYahOVNa0dzIQx92atLRtW6GqxBObIvPAHeAS1PsPM/lK14z1XmxY=
X-Google-Smtp-Source: AGHT+IEaZ/prco7C4oF5lCWqhRZLR0ygJ+Go+pa+KiOBjSGAm0bDYgzb9+GyjYftuCC7qtA8vT67yw==
X-Received: by 2002:a05:6a20:c791:b0:1d2:e94d:45a6 with SMTP id adf61e73a8af0-1d8a3bfec45mr5025125637.14.1728484899516;
        Wed, 09 Oct 2024 07:41:39 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccdb64sm7852764b3a.48.2024.10.09.07.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 07:41:39 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: jack@suse.cz,
	hch@infradead.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v3 1/2] mm/page-writeback.c: Update comment for BANDWIDTH_INTERVAL
Date: Wed,  9 Oct 2024 23:17:27 +0800
Message-Id: <20241009151728.300477-2-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009151728.300477-1-yizhou.tang@shopee.com>
References: <20241009151728.300477-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

The name of the BANDWIDTH_INTERVAL macro is misleading, as it is not
only used in the bandwidth update functions wb_update_bandwidth() and
__wb_update_bandwidth(), but also in the dirty limit update function
domain_update_dirty_limit().

Currently, we haven't found an ideal name, so update the comment only.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index fcd4c1439cb9..c7c6b58a8461 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -54,7 +54,7 @@
 #define DIRTY_POLL_THRESH	(128 >> (PAGE_SHIFT - 10))
 
 /*
- * Estimate write bandwidth at 200ms intervals.
+ * Estimate write bandwidth or update dirty limit at 200ms intervals.
  */
 #define BANDWIDTH_INTERVAL	max(HZ/5, 1)
 
-- 
2.25.1


