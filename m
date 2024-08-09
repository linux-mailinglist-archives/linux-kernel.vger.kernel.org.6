Return-Path: <linux-kernel+bounces-280946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 282D694D13C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B57EAB232B3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B575919580F;
	Fri,  9 Aug 2024 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KVXHPUhw"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C236194C86
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210127; cv=none; b=IAuNDaEo6Ergkt1kRe4A69Cf724nVIz4qzBags+2uzbrRcqNLAawJTZd0x1HnMJK7z/9oNbrVbJUw+e6i0zzGkyfp+OJrlb6TujtWWkaNQg5qzOb1RiLkKRv0U366HB5wnqHkdDZTjt+UrIM/nsc7LmxJXfD3n/lv9U0qSKZPNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210127; c=relaxed/simple;
	bh=TKrlbvQ2RBE1CAygDIaFqr2REf5/DdScuXMZOsqWBGY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Vj292IX7diNGTcnXHHMwLNL6pglejC92tVWnjvEM1yLk1Mv2Y7ULa4NuL58NFpc60g/mdY5kFIYy9fXEhk3uHEMlon0bAohe78/JX4Xdapg8S4ca242ttRl2iOrmEtcoRUiW7ZLnA4OgYgkiqT5SK/CpDhOBwjdS+uQjiYUilgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KVXHPUhw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035949cc4eso4116814276.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 06:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723210125; x=1723814925; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mEjC4VEg02CeBQFpnsdd9qSm0bn37HEVzOCrEJrAluY=;
        b=KVXHPUhwhEP2K/9reE0fmUUzuIqeWzuM3hnDvv/X7ggF2NGtV2jijyqOMhZVhhn2p/
         NRL3+P0ddmKlHlCKmshqq2P+BXoJOv4pFE3ueppSTTLSN6i7C2BTXLvGGFHo1twutpo3
         2GTG4qTH51kZn3EgOZojjxJ9yEYYMDUISSrlxBPp4SmHH+4UYI+Xp7K4843Kn/sX4zaU
         CaE+hAiUYxAIKOt9bwJi1oXHGf4rTVlHevwXIPCVYBNzS+qu3bSzS9matGEA093OuBwh
         OgaFJf7kWJs00UNS/g3WY/Xkiq1VXRIX+97GbusCQtOIV244hFs9JdWcMqQctaHclzZz
         KjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723210125; x=1723814925;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEjC4VEg02CeBQFpnsdd9qSm0bn37HEVzOCrEJrAluY=;
        b=KPZq9SJNvdytWTbvnoM++pUDLYB/Q7kfXfg2Bybt3PVBEYLb4ukj6Sw6U/iHCwR68x
         i6lK4hIVxhqlpQkWUn46+LHrBDSYqW5QFWpp9C2OOowS9lxTbOE3ybByElE31FghJsLD
         5NdHsu6mYc8LCUETdJ3MsPcMWe7s1g/Juyu6xlqJUJ0NjjBGS57md273/tw+MQ03rLww
         9JHsSgMVV2wvu/l5iluTwjBTiJl8cnaREa/1e2J6yNrgUgsEoUVW0KKzbrvEH1WyX080
         FAqL1cvixKVPtBad1jC99a7j1E0rRSJGfm38uegCTsmSRnBDRyB8ZvV2XbfUvPwBZtnY
         F5aA==
X-Forwarded-Encrypted: i=1; AJvYcCV3IOgV5nA8wsLV4Yn+Ak+MkWUU/rpjKojpc+IpqClWXb/QuSpi7jm6i0n3F7WvY2Xej4YdvH+hBawp0LXTYp8IohS1ba7A06lpsAlM
X-Gm-Message-State: AOJu0YyRloeGy+CeRmG6c4915Vz9X04hOlhEa2b4iXLgJqKJGGZAv8vv
	v6tka+lLURDMiNXL5V4l5dJSRwhddeKXJWPv1xQXNF+x2vMHnSG5XJCfgxXxsWipFGCy/XEnKmd
	tEYESZiS4nSDF+Q==
X-Google-Smtp-Source: AGHT+IFhPkSX4arFZVxfmCknNV75exeBowe3iFO2iPGRwr9I5E7GBwi1+h3ISvKyUximqYRz+7sMLcahCRDmMkU=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:d307:0:b0:e0b:958a:3344 with SMTP id
 3f1490d57ef6-e0eb9a27b3emr37724276.10.1723210125238; Fri, 09 Aug 2024
 06:28:45 -0700 (PDT)
Date: Fri,  9 Aug 2024 13:28:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1382; i=aliceryhl@google.com;
 h=from:subject; bh=TKrlbvQ2RBE1CAygDIaFqr2REf5/DdScuXMZOsqWBGY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmthkVGeukdJHM4rXEjs2fvGiX8fDwDb74qbeAC
 NLHqH9dKJCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrYZFQAKCRAEWL7uWMY5
 RopxD/9rjsU5witSF5p+HQFTk/IrWKnpZECfiU0QeqIfbvMGKe6flARIcFMcAC3aP/RbIE7QnAg
 rDQ8swBeQT8kjgNJWZveU8CLrwrztKuk9l9ytFFDTiSa64XS671+ftwAo6JhCWmKCPyElJvGniU
 XUrX0r1Ww9IBhCsjnm1dM8q1Wa/6BAtxXBB9ECIC1q53N4TXFXvaV8fKcqq0e9G4CCeITiY7D6m
 VvhW85siOY7itusPxInWsHW0IDlvTadkk+blz/THctXT7h8EmqsC9RPWZJXMAZ5ueVfNId5tdmE
 Z98BrLKpnLpQKXWRlyx1mAEOdjT+M0KFvLUJbPNGVQVHgzWJF/O/f9h9xmMbf6k8TiKw1SzOtsT
 SU3lMG6axUD00Ocy0nTDyZ1NEw0Khp3mL1VIh/tjBdNkFtbvj4a4hntM+8gaaI2Sn/8H9xEze8f
 2N1NK3aRf80wjoxOvf5zAfE3XX314E8PgUsO7FUV0ff0yGQN3exkVd8Zj0tUFAFCoA3dbqMiNt+
 fQB1jbc8sks+6aDlH+bhpcpKrZG4tybBbvA3PO2hZzQEIDB58URud3dG0XX9+pH8bwF6gfSl1tG
 jAIAllDF/SSWCdhpLp7xIr780pScLU1VaVUc+NiSfGmepnlPIOoZVFI2x+9GR7oOhxIBFZswUe/ nNOsse3CJQ7Rmuw==
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809132835.274603-1-aliceryhl@google.com>
Subject: [PATCH v2] rust: sort blk includes in bindings_helper.h
From: Alice Ryhl <aliceryhl@google.com>
To: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

The headers in this file are sorted alphabetically, which makes it
easy to quickly resolve conflicts by selecting all of the headers and
invoking :'<,'>sort to sort them. To keep this technique to resolve
conflicts working, also apply sorting to symbols that are not letters.

This file is very prone to merge conflicts, so I think keeping conflict
resolution really easy is more important than not messing with git blame
history.

These includes were originally introduced in commit 3253aba3408a ("rust:
block: introduce `kernel::block::mq` module").

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes since v1:
- Reword commit message.

v1: https://lore.kernel.org/r/20240809064222.3527881-1-aliceryhl@google.com

 rust/bindings/bindings_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index b940a5777330..ae82e9c941af 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -6,9 +6,9 @@
  * Sorted alphabetically.
  */
 
 #include <kunit/test.h>
-#include <linux/blk_types.h>
 #include <linux/blk-mq.h>
+#include <linux/blk_types.h>
 #include <linux/blkdev.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>

base-commit: de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
-- 
2.46.0.76.ge559c4bf1a-goog


