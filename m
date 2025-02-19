Return-Path: <linux-kernel+bounces-520987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503C5A3B245
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCDB16B00A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51A41C330D;
	Wed, 19 Feb 2025 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSRmGPnN"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC551C3029
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739949918; cv=none; b=PB1bpHwKKmupKVo7KSvTJliBMYF/Jxepu9ydQzHgC9Rcw++uFkvKNAoYVF7XFUS46AiGe77mXTYtrF0Uq7kaeH19YXn37hdFSONNyR8147IaqF2PfYWS/ohy6z1zAU/K6QieDHgThY+BIa6FagNsSgCDJwQWhar5q5CJyzeswBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739949918; c=relaxed/simple;
	bh=qUaR8Dt4Kdv1cC1MYP4bbXki7Ifg8k0kJZ9cKL7jJL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aoD6ojWWcXhRo3Mfi5pAc/Kua3Zvij0gJbPyexnUUwv4OonQlcoStZDukHASvlO4XbTtycllS2QjzEcFzdsoTpe9Scpvft2kXQZxINsbM7Ajl6CPDklc0zZv7gqeMnSiyhMWNYRYHe6I8WxeITWbUETs2ZLUxwlPBsYt4XDbbsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSRmGPnN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-546237cd3cbso3033330e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 23:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739949914; x=1740554714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A0ENxof8Q6q1VLO8ooi6Pw3i7LqiiqkWgEE8OJsU2qc=;
        b=SSRmGPnN84TuaV10ZXszkN+g3HvUiT2thXgSVquXfJNtLN/dWWkPuizqIYF18ImDNb
         fUWXQHhPyEu4Byp5BSvi3USpeiWEzixBJncjy4+/pvc7S8ckgMDi1UocJspf2iavVdWB
         f7px/xXvrrdLmeTrLfb0aMYThNSbt7Zv4oC07cbKzAm++svazoqBZRVElLxOHm5WzYQ8
         fe30sBLCNFYqrMIPxcIUrgx/0yvy5aO6Q2WncO1I84B9SJhmBeBZzuMoUHEPg0JK/pK+
         TiKa33RlzeyVKqr5ME1NOr+7VD6hzWq0s9MkUFL7BuWkKYhPl5uoh31HasdRyN2g3oO3
         xopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739949914; x=1740554714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A0ENxof8Q6q1VLO8ooi6Pw3i7LqiiqkWgEE8OJsU2qc=;
        b=LfPN7UoTaCggu4mDLr0Mz6/7NsfGajiIlZyDwL5ovDAisO+BvWPaj2HzijjDD+VIUM
         l+gF6XbxBNAWa/B5s4KxHQiGtvLq4GDqFDLMn0DNfgDA/gLg5bhT122K+YOHYzB2CUMu
         0JS54CoRlrw7V8Y4CIm/SRVc0TkLnjpGvzGDuAW806d+vwQPc2rL8y9TipIAaHVqOFlF
         si13PFkflq1esfp6TGPfB2D0xo6VQ5dqtyrfT8i82eiSvV2ISU5bwU8A/rSMWmQgTVBf
         OhnRJcjxCJslQTYbooJKZ2lA0jzAi9Vs23A66gcdwLR97tU7vyMjLkVEvqVzn+0+G2xa
         F5VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZJ/ALt5Aof9J8QnGKxRLHu0TsoFC0eJH3nEGbWLE3uZ+nBcVjkJ5OQwh0a71gdcQRqoiB44BO5JLaD/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG88UliIbzwUlZf48HTWsJe3a/n3m78J2ehxcWtlAucWVDHpZl
	GdOy4I3SloTwzLzkJRUKaXKvt8eCeOYJ6QoyUhlpwbJWEsNjcUay
X-Gm-Gg: ASbGncvGMTdbIFHo0QFWbt7yMbh6LhUk3bZc03uK9TKhV4vaZirwiVKsac0+yOtozMT
	hBmQoAmN0Da0ZyFsPROQoUS25w0G0LGsXEObtFY8b+KJ1TGTeaBnd50/mawvUixaFq1JUs5vlj4
	EsdZ8KRixOf6xIy4Fkm3V0bT9pcZORXhmJPSgHrOIiRiUe6lTLVPx7DMJVIDMtZL3T4CAor+OGH
	PwI0ZWVarGw/8rRfIJxihrhHlfa1ih5YEtAuW3nIN6/Zrq9qrA+HBzqjnf48wWQjClUC9j9I6Tg
	k991esgQC3hmYLH0I0VlA4HS3qrARbHHt+mPn1pmQzp0E/4KtWM10SQ7tg==
X-Google-Smtp-Source: AGHT+IFg1nLj71evBy1252P5sjW+JPjU9JtEN4hRisyCPSebyAyUpOGhScMn16nbqjWJJiQwgMCMEA==
X-Received: by 2002:a05:6512:1593:b0:545:e2e:8425 with SMTP id 2adb3069b0e04-5452fe904b8mr6084517e87.39.1739949914311;
        Tue, 18 Feb 2025 23:25:14 -0800 (PST)
Received: from rand-ubuntu-development.dl.local (mail.confident.ru. [85.114.29.218])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461ca6f722sm1129423e87.71.2025.02.18.23.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 23:25:14 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	voskresenski.stanislav@confident.ru,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH 5.10.y] fs/jfs: cast inactags to s64 to prevent potential overflow
Date: Wed, 19 Feb 2025 10:25:04 +0300
Message-Id: <20250219072504.1655151-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The expression "inactags << bmp->db_agl2size" in the function
dbFinalizeBmap() is computed using int operands. Although the
values (inactags and db_agl2size) are derived from filesystem
parameters and are usually small, there is a theoretical risk that
the shift could overflow a 32-bit int if extreme values occur.

According to the C standard, shifting a signed 32-bit int can lead
to undefined behavior if the result exceeds its range. In our
case, an overflow could miscalculate free blocks, potentially
leading to erroneous filesystem accounting.

To ensure the arithmetic is performed in 64-bit space, we cast
"inactags" to s64 before shifting. This defensive fix prevents any
risk of overflow and complies with kernel coding best practices.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 fs/jfs/jfs_dmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index eedea23d70ff..3cc10f9bf9f8 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -3728,8 +3728,8 @@ void dbFinalizeBmap(struct inode *ipbmap)
 	 * system size is not a multiple of the group size).
 	 */
 	inactfree = (inactags && ag_rem) ?
-	    ((inactags - 1) << bmp->db_agl2size) + ag_rem
-	    : inactags << bmp->db_agl2size;
+	    (((s64)inactags - 1) << bmp->db_agl2size) + ag_rem
+	    : ((s64)inactags << bmp->db_agl2size);
 
 	/* determine how many free blocks are in the active
 	 * allocation groups plus the average number of free blocks
-- 
2.34.1


