Return-Path: <linux-kernel+bounces-400960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10FA9C1473
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1058F1C22204
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A0819340C;
	Fri,  8 Nov 2024 03:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx9xbjac"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A71219309B;
	Fri,  8 Nov 2024 03:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731035452; cv=none; b=pIwOse2zTWXpcRew/VmBJyjOHZkBF75Ywjr5ASRCYBABXJS25u2R/4EKQP8nZqYypls6wYWwtQAY7UBZzoLdntDYj777Qw6ab98N/UqIde5JlVwIAEIwcN2IX8j5yQDRG1zLIMTiN85RPYZ9XhCf/s20k3Gv+bUl8ttyKVjccK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731035452; c=relaxed/simple;
	bh=+vqxO1GXcIVdrjHp8T5/6AWrkGDb0PY8YJ8HRS59Iag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f878SMRCtrBWRLhmqq1O8/TqmLiDjNkCRgZaJPNIMbh6jyxv0gsbrERjlDJ+oWmrCvYcxSTD4D3oErjELlmDwKn7AQREfrvVf011+PuZjBCNKIZ3mKQ5Bu4bGSfjyiHu1vPBUL52HBMpIHo/xHB8il7ZQgxLIef63/euw/N/tFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mx9xbjac; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ee020ec76dso1318526a12.3;
        Thu, 07 Nov 2024 19:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731035450; x=1731640250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30GkkVZhKrnsambHP9iDZ8ayA2V/oCtZtM0dOqtjVM8=;
        b=mx9xbjacV6e+Efq6qazBziLGenUPhOjbtjk9t9NpJkzPvT9/hGb8Ze3aamUKcREkD7
         THhKNM2G+92LgXwbmWmK9F5KG8sqInurA+j0cq+X0AKmUvv7Mzubpr6cPClBpSlv8c4e
         C1eGHBP6FuyCP6W6tRYqEhoEsy52x0BF6R/J3QU+xwu6RtqLmhaCBNf0lmyGOa5OEaAa
         E/FPc/1Qi6xxWPB94X1hKkosZSvk/xzjepu8KOoL/blHvDgc6Q79f6Q2qfdo+oqrYrpI
         +aTOLs4mLYHsljAHtCO6W5QuVa1zNMTyboKEyKCHAmTlW7XnVKlAgKSeQxv+X8qtofFV
         Lt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731035450; x=1731640250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30GkkVZhKrnsambHP9iDZ8ayA2V/oCtZtM0dOqtjVM8=;
        b=Fdw2SBx5M33pdH0H/kzgutP6kExuYCnV7GjIotkYK1eKBUNuJZnluvRhwZ3w7cXQe+
         6m5RMOHFK2zSa9DY3bX5rZhFzVGqEZTQjabOWooo7ovQZGtKxRfR+F14JCC+yoThOoR3
         mE9zldAOtXtbHj+GB5IFu1KUjYjr1K4ksSxl41fR44aUknMP2OP+Q/qAvkFtPIB4FIjL
         VXgrQSX2ecoNNbIvB0zamOfMBaIunpvWdY8vfM/m2dsJ9fyu9OXfbAACpUug/70B5/mB
         VA73npHKvWhjWg3Tejor+FolYjJ/eBO8nDr0GtS8wUC/Ke5RbuN6ISZ2BuDOJ+3tRyWs
         XFeg==
X-Forwarded-Encrypted: i=1; AJvYcCVySE9zC1OdISsFUAki9bP+jwAqwmKr02pLIQ+6rbdZcQLsYdQYpXEbeqSQI6Y07Wdc+feqSD1JnSsGP1s=@vger.kernel.org, AJvYcCXkkj2aBi87DZZfLuwZ4Ta3dRTPdgtnBJs6wdWM3097Tz0ngrPmARbZ6q9TlihbZ6XV02RMQxxSUI+BH6m8ERg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4A9I6GxeqR0cHxP6an73Qgfo14llH0gXoVFuLAmqP/46nzQbI
	Soaz54YypSUP0O64BKgA1j9oppgJjIW0XrL+rSma/1gOpJd9e/29
X-Google-Smtp-Source: AGHT+IHZ4aebn5/pBNtZAWuSot5EIpR7gcBfFm58mQh1NQHtwjnwfh0uS/EciecTrjvhpDC3hBZyew==
X-Received: by 2002:a05:6300:6f81:b0:1db:eef0:ce9e with SMTP id adf61e73a8af0-1dc229d3f2bmr1213476637.22.1731035450316;
        Thu, 07 Nov 2024 19:10:50 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa86dsm2589816b3a.127.2024.11.07.19.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 19:10:49 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: a.hindborg@kernel.org,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	alistair.francis@wdc.com,
	rust-for-linux@vger.kernel.org,
	me@kloenk.dev,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	tmgross@umich.edu,
	linux-kernel@vger.kernel.org,
	alex.gaynor@gmail.com,
	ojeda@kernel.org,
	gary@garyguo.net
Cc: alistair23@gmail.com
Subject: [PATCH v2 05/11] rust: helpers: Remove some page helpers
Date: Fri,  8 Nov 2024 13:10:06 +1000
Message-ID: <20241108031012.335203-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108031012.335203-1-alistair.francis@wdc.com>
References: <20241108031012.335203-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helpers.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindgen_static_functions   | 2 ++
 rust/bindings/bindings_helper.h | 1 +
 rust/helpers/page.c             | 5 -----
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index b4032d277e72..ded5b816f304 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -11,3 +11,5 @@
 --allowlist-function PTR_ERR
 
 --allowlist-function kunit_get_current_test
+
+--allowlist-function kmap_local_page
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index a80783fcbe04..791172b0ddeb 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -13,6 +13,7 @@
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/firmware.h>
+#include <linux/highmem.h>
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
diff --git a/rust/helpers/page.c b/rust/helpers/page.c
index b3f2b8fbf87f..52ebec9d7186 100644
--- a/rust/helpers/page.c
+++ b/rust/helpers/page.c
@@ -8,11 +8,6 @@ struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
 	return alloc_pages(gfp_mask, order);
 }
 
-void *rust_helper_kmap_local_page(struct page *page)
-{
-	return kmap_local_page(page);
-}
-
 void rust_helper_kunmap_local(const void *addr)
 {
 	kunmap_local(addr);
-- 
2.47.0


