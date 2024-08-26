Return-Path: <linux-kernel+bounces-301284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B5995EEA3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA87A284CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EEE14A617;
	Mon, 26 Aug 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="piBz4p7h"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E8E14A09F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724668845; cv=none; b=SoeBqzT3uhitg8A9nS6dsA+LdrrptjRJep8dj9CmDab0IVk3vgdvScgZJtgDTBOLvkRQvHy88lPG0tSuZXhpsTQ5Gxr2Vsw1EKhGLuvwjrm3zvJi3e2ezcn8E7l50N0i+2me/ajNwY7w215XrTo2U+AW3QRF/H//NnqvX/yonuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724668845; c=relaxed/simple;
	bh=6g/oV404bW5QFuPJUxPuEebiANjYNEz6eUT4NbDeGy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k4zC08j0Owkobc7/ud/UBbmp9gIoMfbkUjLrkMVMwfcFiGQ+81avX4zRmGIe3zQB2ECVNjDYLRHMhva1PrV0lsXWKMohPxEdA768PEUDKCbPF2I3tHdJLU2a1Sk0TDeJ2sTz35f/Ltwo3Dl4gK4QB01z1VOfjk2gnk7p6zaqIKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=piBz4p7h; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bebc865578so694639a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 03:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724668842; x=1725273642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JjbeKVSi31WzRxhWlL+Ld03XcZ51OwPUH+uTO2cw8Zk=;
        b=piBz4p7hLE3Tw4XJILBxfB0gEad/LUn+s5+3xVCsGAcLosAvABMjZb1KOG728jcUjW
         MVea/B0yIqjOE6nfO2M68ttpvVS35i9TG/+B5EoGbR20M8mSqQgf29E9vHMp5VIzeuuO
         hInbxJUsvw19EjueJgsy9Miz2Mr27kXqylUMR6d37zk8p74D+ZMvHQQeu0iayWf9qjIT
         1fuCFs1V+fedS3KclgALUSBklrQGsAvybiBTzTocW/dFCOhUTLAg3RH/j6mq99VU/nML
         p/HxHwbATbwD/p8YYjoqG/iHl/Y9tdsxiACKHtPrFWq3rFtzimZZQmgssDuxaSjePGC7
         IGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724668842; x=1725273642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JjbeKVSi31WzRxhWlL+Ld03XcZ51OwPUH+uTO2cw8Zk=;
        b=iAG3n3e8EtIbxO+7oxKQeGSn+Aj9iteF/PB5LW/ql9uqrKrDvGZOL4MJTlJcrIjzT5
         Wq7N/b27ZZ4DkbGz5yx+/jjEJhYK1jsKLDUX2VsD50c3UBx+pEhxY9ihpq0ujMiEAQ2o
         SH6c6deVPKqjALr6/SXtO7J9FjvzBLfDjI2RNpXn05OVPK48umPhLqg+UtcwIudPS2ZU
         +d5JTpjQmOFZnZThnVrpFVVA+YIywhkve4tT4xhZ4T9L7arLcHHeohTWZm4Spa77ifU3
         uidRWwBEPdJnNI4yX7+cNkaRX8SFeeC8ZOWxaNjS8cpklCqvwe+cYnJ9eKEHfGvaW9vC
         +iSA==
X-Forwarded-Encrypted: i=1; AJvYcCUfOy5omZx/h0/7p/tIqQp/MsSRgdsV3o9ehogFoARrPvceEmBsiXayKt70dzX+jIB4sRomrb5llJnk1cI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv5tTEm8/wgpV1vDTT4vBVnQpqpw8/+Y1jQ+d/cmJItsl4nS00
	oAb4p/c6Q0k8OQ1JI0Gq/5Scaa/orvlETOy6o6bB8hqgkYdDcMtsIQIagWp2gGU=
X-Google-Smtp-Source: AGHT+IF3/CR9+PS5ME8Zc2H/zaAuxXs2zJ+J6nyz7JzpsWcXVfSGLWtplzdX2HeAajXOJbeQRQeKfg==
X-Received: by 2002:a05:6402:2695:b0:58b:e3b:c5de with SMTP id 4fb4d7f45d1cf-5c0891b5c97mr3571705a12.4.1724668841917;
        Mon, 26 Aug 2024 03:40:41 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3eaa90sm5407427a12.45.2024.08.26.03.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 03:40:41 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: almaz.alexandrovich@paragon-software.com,
	dan.carpenter@linaro.org
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v2] fs/ntfs3: Use swap() to improve code
Date: Mon, 26 Aug 2024 12:39:40 +0200
Message-ID: <20240826103939.63548-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the swap() macro to simplify the code and improve its readability.

Fixes the following Coccinelle/coccicheck warning reported by
swap.cocci:

  WARNING opportunity for swap()

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Address kernel test robot feedback and assign match_offset as before
- Link to v1: https://lore.kernel.org/linux-kernel/20240731135403.80805-2-thorsten.blum@toblux.com/
---
 fs/ntfs3/lib/lzx_decompress.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ntfs3/lib/lzx_decompress.c b/fs/ntfs3/lib/lzx_decompress.c
index 6b16f07073c1..4d5701024f83 100644
--- a/fs/ntfs3/lib/lzx_decompress.c
+++ b/fs/ntfs3/lib/lzx_decompress.c
@@ -512,8 +512,7 @@ static int lzx_decompress_block(const struct lzx_decompressor *d,
 			 * the same code.  (For R0, the swap is a no-op.)
 			 */
 			match_offset = recent_offsets[offset_slot];
-			recent_offsets[offset_slot] = recent_offsets[0];
-			recent_offsets[0] = match_offset;
+			swap(recent_offsets[offset_slot], recent_offsets[0]);
 		} else {
 			/* Explicit offset  */
 
-- 
2.46.0


