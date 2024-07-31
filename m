Return-Path: <linux-kernel+bounces-269318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA59A94316F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968742815E9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DCD1B29CF;
	Wed, 31 Jul 2024 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="D7+ci7i0"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5436B1B14E4
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722434089; cv=none; b=mtyIGKpR1CFrfDyRb8FOqdwsAhT8QCz6P3vrnWNOr8Iwh3xCLVEtii/XmvthifBK9u3Rfynt4GWkgygyqf5Gy0jj1iqJE7ixESgicXlW48LUOGTFXAvsmcFrsSJu+QLllLoN0zVpjZtjFJ+2JN05C5P1npcUZEvciQDjDGspnOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722434089; c=relaxed/simple;
	bh=8cZ7LKFs7mJeGc+v4+iPls/B4S37umLa96hNuJxowA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lHJZMMPUgKxKkJ3pqSYOCd6icTZ1cExBJ58ywlszRvIf5xWilolqqfv1cWK5r2HDhIywmM4QqPIuvqDF/7ub09KUN3Md1hTfIl4PcoEVPdUINkTnX0Kxd79kXPL3USFztf9AbBLMVAuVY2NbEt45EwqR5+NSAsGRsyTMf7CSmis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=D7+ci7i0; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-367940c57ddso2872604f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722434086; x=1723038886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RoJJmKmlb6pOf2w0Io+9nkBW5fd81cjrd3TmeWughbw=;
        b=D7+ci7i0qkk1W7JJPY3XtBF7Flg+HJUUhpchMeYJWxBS/YGGJvWpKpSMuxXE26i1fW
         5IrtFjxh+aPW1V/ioomkI6TDGhxXl+sHC+Ho43TkgwiAtPgHaA1eFbISuSoKhy3pW3fM
         rqv1TJdSduH4QHLzLKJJN1CNkf5j3qyuBktGuloBya/weQe4Sly8eAsgAWK4soCrKR9w
         0KYvjUO9+7JeGZm27HwHezbLhSqxcQRZBbBsyYYYtkoEq5cCjBZoI2wVRZdIN65ZPDxC
         fa/X4fwaZt4L7xWlNH/ephdzwzT2dx5x7Yc7pNaLh4qClpp94gv9MBGUof5/Px+Ezmbh
         6cRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722434086; x=1723038886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RoJJmKmlb6pOf2w0Io+9nkBW5fd81cjrd3TmeWughbw=;
        b=mdA8RpNt0//Ws7Z8EEKHMz1abHrlrT33FILaIXKIsdGU0RgdkGQgRIKEeWouvlNPPU
         muvmgiOzpD2Xn6BVgsyA5w4j4fHDfiOBi01SoDr2ZoPKDJWRWYaWH33H7aKejbVzb2F9
         NaWGMifmzOv4K/1l/ORE2MWueWtMfEcqntxgvWSkX4rmDNi16PqlJjAsUYqnrT0ZOIqF
         WbkjdX/OO8UwhUFSGX1znUimtX7SGagdTJziNhnG2bMzHbyg6gO36L2lKgPm6Cpn2X1s
         FVkgL+4a78pteAYCA6AbgrOx52KtXBe5Lhd4OQv2qgNK0RgEGedXUS2MkYIeYNow1Nxw
         9C2g==
X-Forwarded-Encrypted: i=1; AJvYcCV8smnW4SOZE7QzObT48ViDAA14JeNi6Dvy4LLCliFZdP5Xc0WTmQGOLuK95r0uhQQlx9naA1X89VX742PmaatWiZy0kOYBkJm4aUwF
X-Gm-Message-State: AOJu0YwA5/iKKTtmTBsqH5o2pFOKpFZvUiIkcAnYyojCp8EH7jiRzLul
	N5IwO+cL3afmJyowefcdo4L/L9HGTWKvI3lqRhF/BU1nzKh05s2OjpK+ecINB9c=
X-Google-Smtp-Source: AGHT+IHUO/t8tbBPVuGLNpykHjNyPFsLLPMW/WZZS8E6EuBjBA0hdH54GNHam3w9GuGi7t3kslP7qA==
X-Received: by 2002:a05:6000:1c4:b0:367:96a1:3c91 with SMTP id ffacd0b85a97d-36b5d0d1478mr8875813f8f.62.1722434086539;
        Wed, 31 Jul 2024 06:54:46 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b3686fdc5sm16938028f8f.114.2024.07.31.06.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:54:46 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] fs/ntfs3: Use swap() to improve code
Date: Wed, 31 Jul 2024 15:54:04 +0200
Message-ID: <20240731135403.80805-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
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
 fs/ntfs3/lib/lzx_decompress.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ntfs3/lib/lzx_decompress.c b/fs/ntfs3/lib/lzx_decompress.c
index 6b16f07073c1..d9adb290acba 100644
--- a/fs/ntfs3/lib/lzx_decompress.c
+++ b/fs/ntfs3/lib/lzx_decompress.c
@@ -511,9 +511,7 @@ static int lzx_decompress_block(const struct lzx_decompressor *d,
 			 * quirk allows all 3 recent offsets to be handled by
 			 * the same code.  (For R0, the swap is a no-op.)
 			 */
-			match_offset = recent_offsets[offset_slot];
-			recent_offsets[offset_slot] = recent_offsets[0];
-			recent_offsets[0] = match_offset;
+			swap(recent_offsets[offset_slot], recent_offsets[0]);
 		} else {
 			/* Explicit offset  */
 
-- 
2.45.2


