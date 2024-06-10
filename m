Return-Path: <linux-kernel+bounces-208447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76959902542
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B4B1C233D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834C2146D53;
	Mon, 10 Jun 2024 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCSiqSHb"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFC01422AD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032566; cv=none; b=RKYzyO+HUH+Or577YWVfgNhyTVV8G4wKJyItOE6AzW5i9jZWeb9hwUKYOZhFlVZSmU9gWW2vsUzNDXbKWp87cgCXIDzYFDkZyjydx2AkBAJINbRvMr3jsYIbK7FpMcS1Fov+LtjVN3ElLykmO5+a9VcDrckw4eB1VPYp0IHIGe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032566; c=relaxed/simple;
	bh=X4JtHTKBBPUql6YsZxnJPRHjtdRPv9Gew00ZGGyoQkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P7o5iGqfY+ILQ9PyPq39xUslovSFliqF37X/EfXWM/MpnYmIsj/YBHGLZUvCafKepeTVNpkSIpTtj3L19WppfQY85p6koiRel/dYkNGC2szuKm6y+9xwjnobixrGjZXOE/MvG1/MfChXoIzkmnJI+dzm5uexRK5FZXfig23HR+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCSiqSHb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f6f031549bso18626945ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718032564; x=1718637364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=u3atx2iJ/yoI8yKq05i3Y/SAy7CKrqfXcG/FtiEnceA=;
        b=RCSiqSHb4/BsnycBxESfyE2b1uGQKKz+OeVH5eUt3LyynloK0XZ1959QsW6PcB96ix
         EHugBDeJS1BLMfMOjwxDt+RtAdjLbra25u7wzTIfW3mfsvwOCmJBAL3FcS2K0wATtXrf
         uxWJElQt2Rul0j7OTmjOb4PNFsretkUFU0xgnFiUjXHvsprwTIYlkD5cfTjofZ9ytiNM
         s/lIoPhKMB7ohlZGpf4jVEHBL3xBrMHBAmdRRJwCvzWShHlaQ1zeTRPxxWyZUr4Ooimo
         vyFVbNunWoCa1bhn3L72pVaizfIS3l6+owBJ9umrhwx2Gzxh+cQvNSFMMk2Go/TW0WPV
         GWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718032564; x=1718637364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3atx2iJ/yoI8yKq05i3Y/SAy7CKrqfXcG/FtiEnceA=;
        b=KPngzqX+/sU2QqyK9vF8JpPSSmWTEAaT7zxAsdPOaJVIK8bOUM44r6M0D8a5oEDq/a
         oWoiDAxiOEXgKt164G2Xt4edycDfZR74Hmnq7hnLA3N4A8RIWEuSGqvePALxR8KX9aTk
         L/Q+tSOImWQH1q9NaZTXVOZQgBiA4tVUWxHi2jfDyQph7rOKho9jGw0Eocymcmd14ggO
         BxZ9utCxcD2UAuZqSa8r/cv1vUuKbqx2ff54GRil/hMZBeDwhORPq4sIvGwkhiiNABER
         +wcBy3ozzRe1LXBuaspmMDDldY2fg3R2HA47dhksp7NEOyv/1pDUAArr84LaulQlDN/Y
         LTqg==
X-Forwarded-Encrypted: i=1; AJvYcCX9Vdcq2TSecfhNLAwCpsykNrjsPQBOAsIDAm0tlAyzwJQLYWqEEIZ5ige+LfnjK3Fh8xM41a5vY4j2cXhV23eRZASqZH9ocnPMLnvM
X-Gm-Message-State: AOJu0YzxnnJxI6m2CSUgYYZuvfNOUHd/OlR0YCRWz72kR47+b7BbiL3E
	nn2GhGRK5S+pPVKZEkfm8IhGeFz3dRcdC/FcYncPlG8DiY0BI2Uq
X-Google-Smtp-Source: AGHT+IFu3JEylIFN+CmlzVlSQG94BeMHtKadbl5d4/qtdF/EmBNuEAq9rfzT7KZ3Wbsdvamnl+j8ow==
X-Received: by 2002:a17:902:64c1:b0:1f6:daa6:e774 with SMTP id d9443c01a7336-1f6daa6e87cmr74777125ad.61.1718032564191;
        Mon, 10 Jun 2024 08:16:04 -0700 (PDT)
Received: from SYSOS.. ([115.178.65.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75f2e8sm85378205ad.25.2024.06.10.08.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 08:16:03 -0700 (PDT)
Sender: Leesoo Ahn <yisooan.dev@gmail.com>
From: Leesoo Ahn <lsahn@ooseel.net>
X-Google-Original-From: Leesoo Ahn <lsahn@wewakecorp.com>
To: lsahn@ooseel.net
Cc: rppt@kernel.org,
	Leesoo Ahn <lsahn@wewakecorp.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/sparse: use MEMBLOCK_ALLOC_ACCESSIBLE enum instead of 0
Date: Tue, 11 Jun 2024 00:15:28 +0900
Message-Id: <20240610151528.943680-1-lsahn@wewakecorp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting 'limit' variable to 0 might seem like it means "no limit". But
in the memblock API, 0 actually means the 'MEMBLOCK_ALLOC_ACCESSIBLE'
enum, which limits the physical address range end based on
'memblock.current_limit'. This could be confusing.

Use the enum instead of 0 to make it clear.

Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
---
v1 -> v2: do not rename 'limit' to 'limit_or_flag'
---
 mm/sparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index de40b2c73406..cf93abc542ca 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -351,7 +351,7 @@ sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
 again:
 	usage = memblock_alloc_try_nid(size, SMP_CACHE_BYTES, goal, limit, nid);
 	if (!usage && limit) {
-		limit = 0;
+		limit = MEMBLOCK_ALLOC_ACCESSIBLE;
 		goto again;
 	}
 	return usage;
-- 
2.34.1


