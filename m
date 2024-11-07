Return-Path: <linux-kernel+bounces-399232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CBD9BFC5C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77868288BC7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0764F13635F;
	Thu,  7 Nov 2024 02:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QydKNGtM"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1250217BCA;
	Thu,  7 Nov 2024 02:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945338; cv=none; b=FvzX500DnCOXNHla9eSNzsP4pUiEI8VJS2xgyS0PAlMwCSkd9Wh3d3Hf6tMLYOXU9N0QZJgdAbbIhdt0jYKiyD8aHG2ws5zZWxF/AQdbLf6Z6oIou9NBsQ0VOKNByCvxbZXi20zO8eTWbO8CYJQ3DIIAcr9jpLzoGztE/DP4n0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945338; c=relaxed/simple;
	bh=GFjIOlmW5cYspF3RYOvDHrimMS95IsTapsdaD7UAObU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0xRsZI9jzreyMNuLkSMxAy/GIJNip393j256i2Rc2/zHtvg1OtjpvGr/8Ojbn3cTuZv0Lv6bs89Tr+t+PNf69nuluUUD6n34hkvBqdmp/PXJL5Bvb7/LnWZfdp/osC3VvmRAJz4BQ3agA8bHqKyf9A9AROecN6a+3wUhzuEozA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QydKNGtM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2e6a1042dso358320a91.2;
        Wed, 06 Nov 2024 18:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730945336; x=1731550136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECpNhgje1W38COAl3ahJTUVL/UpVGUVi4I7zpfAWrY4=;
        b=QydKNGtMvy31TT6rkD7e8t7JJZhxxlumtisCWDlROaE48FvOx689PNFvbyn5ZU7zos
         VnbDB6qJzNPtfzXk9MkhNt44Vg/Cv3RcoF8yCrfQHCuKTTMo1zrg8AYzeWW4Jd5eNJA4
         BZ/drapSDCA7/MANyF7FInSTE0ExACSMaCeLITqEb1qoRl8eitCLIQl+7xi1xifq5uf3
         xG6jKXQW23ATCdFYg1tgbgQ2h/ydhzHr4lJQXi3JZn9lGCXn7dPUrVCCNYHizbLvT5ml
         +WUEZ2QKSRK2WA5+suDErC5VXMfgLx1VMiSMewAj5LNEjSqtl/NiyeI4/hiKgemCawfV
         SaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945336; x=1731550136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECpNhgje1W38COAl3ahJTUVL/UpVGUVi4I7zpfAWrY4=;
        b=p7B6BvIbn2YJXYBnqpJfXXuiC5GW0mGcf/IRJwH1azJ5HWA+yvpkbpoQbL7fQjPALO
         yJxC9Rr5BWzYiGPoikCcSpUUgNIs91CBl9mQOxhlR32S57pU0eSlFZqoD16sNGpNjYIa
         nOQW6Uyb3zMSeNmRp0pmqJi79gx4C0/ZK0z04Cx6S05cIyjrLfxCiOAvS94BPcmyphzO
         TARzS/SAssUpujaizks6iXXuZeNZbry/DArzGp6YroLSNn4oQDcv7ih08OBAdubZH1UT
         hOJlBBE9QmGZs8QA5ewKXIOXyuisdMzgFR70OD7WQeHweJ3jCO//D+hzI0Jkqgkgw86i
         M8Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVlLcv4KGMdm6cc6ytIT7ghUN4buvjUR+fwDc9Cf4uy2NoOuH0HUQqa89L+s7Q56z2kd34lLZHAdU7nRzs=@vger.kernel.org, AJvYcCXH6eBNEfZVUdCCKEBB+uKftuJeA7ZCmdO8dPUwp1ZWa+LbB8w6QJuJsCjULVDyRRphyl/tPyB4DD6GtAAlXv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyKAOVXBwaydPE8vp7+k3qH3sdLpG322W+pahwkTl33uow0lJG
	SphEmAz47XUA0WfyxhFYYFs98hgsOsIgYIwJU4r4LIoP1Xcun4K7
X-Google-Smtp-Source: AGHT+IG3DEWlNL3zFemQErhcj1ZfEJuWNBY/fnKjyRre1KIHVIY4X0GLsPXlRK+dSukbH0uvlKQ4ag==
X-Received: by 2002:a17:90b:35cd:b0:2e2:ef25:ed35 with SMTP id 98e67ed59e1d1-2e94bdfdedemr29550898a91.0.1730945336328;
        Wed, 06 Nov 2024 18:08:56 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f98b3sm2549916a91.32.2024.11.06.18.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 18:08:55 -0800 (PST)
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
Subject: [PATCH 03/13] rust: helpers: Remove build_bug helper
Date: Thu,  7 Nov 2024 12:08:21 +1000
Message-ID: <20241107020831.1561063-4-alistair.francis@wdc.com>
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

This doesn't seem to be required.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/helpers/build_bug.c | 9 ---------
 rust/helpers/helpers.c   | 1 -
 2 files changed, 10 deletions(-)
 delete mode 100644 rust/helpers/build_bug.c

diff --git a/rust/helpers/build_bug.c b/rust/helpers/build_bug.c
deleted file mode 100644
index e994f7b5928c0..0000000000000
--- a/rust/helpers/build_bug.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/export.h>
-#include <linux/errname.h>
-
-const char *rust_helper_errname(int err)
-{
-	return errname(err);
-}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 1df56294cad46..0f0c16c1e8149 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -9,7 +9,6 @@
 
 #include "bug.c"
 #include "build_assert.c"
-#include "build_bug.c"
 #include "err.c"
 #include "kunit.c"
 #include "mutex.c"
-- 
2.47.0


