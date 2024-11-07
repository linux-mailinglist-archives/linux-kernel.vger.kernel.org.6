Return-Path: <linux-kernel+bounces-399231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AF29BFC5B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E49A1C2298C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA36A80603;
	Thu,  7 Nov 2024 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpbptNCq"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A2217BCA;
	Thu,  7 Nov 2024 02:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945333; cv=none; b=PwoJ32M7nK6hJU9Eq5/QK9T/wdF5BbVrEo00W+UDCVB1TGYyjcqvrJzXFqsdwlr6etC+MbePOOqqrIwpsrH+dL7NbAFDtQFbSLW2W0XfHSnYEwGVgZbQVHkW6hO9UDYbaySYgVrvV+C2uZTN/zmpQ71RqxOdVFjbhKnon7uSK6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945333; c=relaxed/simple;
	bh=tCzl4sLcDtNPTi7ell42zZZmjIKm71zOm6VxpxOjylM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUXC8G4uhReVfT+8Lw+odaN8kAZbgKWRHAvGscJIasB8CruUMVLHWrcimYtM46H8Xn1fcK0XZReTsIY+f7Y+AdvUqcjFgdQIxxJl4Iq8w2rvtZr/SGMonfbsEaHcBsGBAb+KC1hnZTMiqsmna39lU9PcYFSDR+kNNKYd4qWRmdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpbptNCq; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7f3da2c2cb5so414968a12.2;
        Wed, 06 Nov 2024 18:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730945331; x=1731550131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lfZIgu31R4zQkJW6U15q/+sPg565w1qMTJ664MZPho=;
        b=hpbptNCq/4hD7i1wegL8K1uH+mjFYM/s8qSy81vLcv+uT+RILFOUBslbsTLQi5dHYI
         pVXy85mWQZWYCNGRd/dE6ZEYthQTnQeaHeuqYma6o7AOiKV1cip38WDRCSwkdrQI0uuT
         ZbM+nGrLL7AAFuWCkKIufCIJ7uTIyIiRzMzobYP3LPRl2QPEuLj/OWHhW+j9QVAjDyAB
         Tblb0JXWpjvFXHNTfYMdEgvtfiueEg03e87BPRacdB5i6ekoSibzoxACm0dVoO0ccEZk
         bU4TCzeYxvVTtg8Q0BdbqEK25BxrIMou3Sxit9+SkSE5a0vKjiIlRNSvgTtRIyGN5EAc
         wnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945331; x=1731550131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lfZIgu31R4zQkJW6U15q/+sPg565w1qMTJ664MZPho=;
        b=dES1r9lshsLKTuQrA4GL9Bpu1AKd1g+2Yiusef6KQBkIpoXCiiCeqmdzT3n3RuizxX
         azF8QmIAnc1lZgXCXaxvQxI7+nMqQs2EQZoVSltPKFXiQ4OB/UlNw1T4jq4T1nabMzCf
         gD5MwJF+j7Iy5yjbgRvtvXHTwjCXBX+wq2En3b0YDwS/7GjAsBHGijvuIcsaY+MDN9P4
         Yxc6KlcuNOd0L+G5PJ5K1hn/1lfZ8OyICYbjzjPUKsTpezJPL8xJLyXuaHDYLOgdo4Tf
         ELBtuQfneg2caIZOPMZWYBH/HSl3lETfjVQLgqfeWY+MNJVkJvXefUHdyUm8VLCIe1VF
         FbGg==
X-Forwarded-Encrypted: i=1; AJvYcCXHn5HoW3Cf2+Z8sg8tG6kkgxjVeer0k0y21z4hdBch7iuE1JG7y8O5PPrpqCX+hPN0D3qidrXNPXSxdjU=@vger.kernel.org, AJvYcCXkulQ5v4d6DWvOw4LDCWTm/qIwoVisRNCf9Btdkub4+EhXvUHtjKwYSCLCyMf8m4Tsc77VZIWCxkoS184cOkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwJQx5BrDLLU0Dplrr7vCwQMO8ySkzcDb1s97fUL6vAxa4qQjB
	sKsu6Xw4JEMwHUCUlq6Z0vzavq0oRdBAsmJuodbTnpTI4KKr1XF7
X-Google-Smtp-Source: AGHT+IHGj1wdDUsqzubqhkc8CYCtJemPUQeUQAaVouT8cy98UksrEoROzmpDUMk7J2PgBQN0XACVFg==
X-Received: by 2002:a17:90b:3ec9:b0:2e2:bf7f:3369 with SMTP id 98e67ed59e1d1-2e8f105811emr46004701a91.5.1730945331057;
        Wed, 06 Nov 2024 18:08:51 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f98b3sm2549916a91.32.2024.11.06.18.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 18:08:50 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	bjorn3_gh@protonmail.com,
	alistair.francis@wdc.com,
	me@kloenk.dev,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	boqun.feng@gmail.com,
	aliceryhl@google.com
Cc: alistair23@gmail.com
Subject: [PATCH 02/13] rust: helpers: Remove blk helper
Date: Thu,  7 Nov 2024 12:08:20 +1000
Message-ID: <20241107020831.1561063-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107020831.1561063-1-alistair.francis@wdc.com>
References: <20241107020831.1561063-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helper.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindgen_static_functions |  1 +
 rust/helpers/blk.c            | 14 --------------
 rust/helpers/helpers.c        |  1 -
 3 files changed, 1 insertion(+), 15 deletions(-)
 delete mode 100644 rust/helpers/blk.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 1f24360daeb38..42e45ce342211 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -4,3 +4,4 @@
 --blocklist-type '.*'
 
 --allowlist-function blk_mq_rq_to_pdu
+--allowlist-function blk_mq_rq_from_pdu
diff --git a/rust/helpers/blk.c b/rust/helpers/blk.c
deleted file mode 100644
index cc9f4e6a2d234..0000000000000
--- a/rust/helpers/blk.c
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/blk-mq.h>
-#include <linux/blkdev.h>
-
-void *rust_helper_blk_mq_rq_to_pdu(struct request *rq)
-{
-	return blk_mq_rq_to_pdu(rq);
-}
-
-struct request *rust_helper_blk_mq_rq_from_pdu(void *pdu)
-{
-	return blk_mq_rq_from_pdu(pdu);
-}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 30f40149f3a96..1df56294cad46 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -7,7 +7,6 @@
  * Sorted alphabetically.
  */
 
-#include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
 #include "build_bug.c"
-- 
2.47.0


