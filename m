Return-Path: <linux-kernel+bounces-332641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847A497BC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2892827CC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C21E189900;
	Wed, 18 Sep 2024 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcx9q3Gg"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1175A176FA7;
	Wed, 18 Sep 2024 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726663182; cv=none; b=XhMKfphe0WNRPR7UQCBImWmydJyYQaCPaaTEGV3rGYifNtPdCTTWpOKc7hLFFY8620CMtbJkmqlPIdZFnfdYdnhumw8tBJOHTA/VaPD+jtJitLoC/HRs5UeehYBt9EMtrvFZp7lx+nsW3m5U5RVuqDfB2y9evI8NvewL/NwLu1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726663182; c=relaxed/simple;
	bh=zHSCkLBbHvxeaweQ+w3KKgu2flmd7IQg7nm+C+PPzAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DXWAzItBnQG8LEW7jB0bBoUfZ7UeNH+y5hulvXimOryl/Mu7A8qtczCo2BpnZTzwsFchkcZVob+w4xXQqmVkOhuLmFySgOd6LItRYp36ixUTqLjjCHuMUKyB9LOG3VCAK+i0/06hkY8Ta9yHUxG45l2zzsuAATCK2qbd55Nr0Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcx9q3Gg; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6dddca05a60so7029567b3.0;
        Wed, 18 Sep 2024 05:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726663180; x=1727267980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yohxMWQQzG9Yvh0JnaHxDE74VTtOz+kSVjviSCcxYOM=;
        b=bcx9q3Gg1ROzHoGbV4QC/2JH01Rj7N/QDrrHSdhODyrQJS+LI7S9fuDyOKJTKAdbcq
         QPpmKxCuRAAXxRjk+C9VvPzDmSawjE9ilcbTT+537th49Urymy1EFDoHV/W5TNB4NQpU
         F+bOpOc3yQOYe0tr7+IMc49tnAQ/ecJ1wGJ/XTbhH1dsfBha80yFkB5J/LK9JkwRzBb9
         7JO9M1lI3qnLatfMLXKwK62GR//DKgzbPrGQCVVmQwSUJxpXSNQkQbNaRs/Psoj+mD9d
         GK6J5yFHk6IyDvEaRM3zEGvSvHHoS3Eso6EwJX5sgjLOKdOtJ2iJjCKVWVwrJ9PnM6Ie
         ArGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726663180; x=1727267980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yohxMWQQzG9Yvh0JnaHxDE74VTtOz+kSVjviSCcxYOM=;
        b=M+EoN0Otmx7QMfuLKS29phw0me32iunKvSTN9s1iU1E3XHteqsf9rqA3Cdem8ufye7
         8vh3mTH19SiQxKVLyRDuaTNBV7BtIL6x1y7rVHhKYsucLMwxUrE01Nteq+kfN1WiZDEN
         5WHb1LZx8Dzj9uiAPd/f+ArSVwIdPXpPkOL0yeGonS1vlX0hlxvWS4W4ijUQdHHevQ4L
         zMpHBuPgmAt6uoMXZzhE2z1ZGGAtgduo1F+k4NauIdKONMx1g2Ta9eQbklBvbGFUHMYk
         mSMYDxhv+KPJB8RuF6eW0vLyb197d2EN8Z5pK9dKG+zJYVMBTUMfKu6VHsKwYTQM7bjP
         MxgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGyVeFaDmqBQEJUboSq+Qr4Pxfi4pihvigydAXrUuX1N2cnhOO01I8CaLXt7H69wKKjZ4O3trmAKA4j+Zk@vger.kernel.org, AJvYcCVoli6515X8qk/X8CU8Ka6Mo3P2bKfLadOyiPwsgcbL9z9DhLzo4D349FRvhNOA0ANHtfoauQngL34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTOvcTpmzqV3Q44jo9ZllThyER0PgbM9eQADYm6MIQv/YJVIHg
	4sl8LqJy8AOrOSZP7vEmXzSvibwxEMr0wvQioZTMy+9t+p14c0nnFNpuOg==
X-Google-Smtp-Source: AGHT+IG002jAs5oeAqIDjeSQ5SV1OXrDk3gre1xyD7dcxrivorEh+vkIJFGBtj6OGra92Wh/VnfZcg==
X-Received: by 2002:a05:690c:6906:b0:6dd:ba98:5c9b with SMTP id 00721157ae682-6ddba985e7amr87723827b3.22.1726663180021;
        Wed, 18 Sep 2024 05:39:40 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6dbe2e0da2asm17691817b3.36.2024.09.18.05.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:39:39 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: David Hunter <david.hunter.linux@gmail.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	shuah@kernel.org
Subject: [PATCH v3 1/1] clk: clk-qoriq: Replace of_node_put() with __free()
Date: Wed, 18 Sep 2024 08:39:23 -0400
Message-ID: <20240918123925.41511-1-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use __free() to have automatic cleanup instead of calling of_node_put()
manually.

Compiled without errors or warnings.

Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
---
The following commit has information on _free(device_node):
9448e55d032d99af8e23487f51a542d51b2f1a48

v3
	- Changed subject
v2 -  https://lore.kernel.org/all/20240821010739.15293-1-david.hunter.linux@gmail.com/
	- Improved message body 
	- Use change log to give more information about __free()
v1 - https://lore.kernel.org/all/20240820013550.4906-1-david.hunter.linux@gmail.com/
---
 drivers/clk/clk-qoriq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 4dcde305944c..a560edeb4b55 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
@@ -1065,11 +1066,8 @@ static void __init _clockgen_init(struct device_node *np, bool legacy);
 static void __init legacy_init_clockgen(struct device_node *np)
 {
 	if (!clockgen.node) {
-		struct device_node *parent_np;
-
-		parent_np = of_get_parent(np);
+		struct device_node *parent_np __free(device_node) = of_get_parent(np);
 		_clockgen_init(parent_np, true);
-		of_node_put(parent_np);
 	}
 }
 
-- 
2.43.0


