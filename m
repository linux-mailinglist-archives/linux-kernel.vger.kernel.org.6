Return-Path: <linux-kernel+bounces-390343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2C49B78A2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37E8282711
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F169B199238;
	Thu, 31 Oct 2024 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETjDk1SF"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20F41940BC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730370438; cv=none; b=odhKxUkQ2/VvNXlDeo1ZPIqNzafmJtY6xJkTRk+/USlaiHHH3pF6QqC+j0MpoZAVOljGa/JSHClR/c3s2UAljQxh+/jkwOCDBpxJqWYZ8JbbPjtgTR6Z23h0Rg6+ZPSLUUMCSvZ8OwnZ7+hO3+y6p7v8kq1J3hdCpyWlTm/j2K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730370438; c=relaxed/simple;
	bh=cYqRl7ujIimBpwSgJx1V1AB6P61Md5CRNLPpxb1PPj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OnfHwB8MhfPoTcEiCPAbliEkPPlnrwGxCPcGDZ0bsIcwNlia5nfa+NsFBQhTmSBbWR0MO1428J17HJfxJKmtY98X9zJxAJZkTpX7kVC05epfMXC/Qhp4m1gb/vNmV2d3PXZeRC98iMeRW1H3kHWNjnoc/2gldDcd6edyg2XaRLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETjDk1SF; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cb89a4e4cso6002545ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730370436; x=1730975236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z3ZugE99LtSXQE5Vb/qD42v3zeWQYKRSifIMEBMyrqw=;
        b=ETjDk1SF3wS2Erl/KRp7A3bY7RQ3fOQX+DppH54DS5bRub9MFfaX1hlMg7wHKYLzS4
         Fy3mIC5dSW4xoqHnb92ZsmWqQ3d160p3Q/sgdHh7PBIirASQSSrg5Adxd8WlwPEBvBcM
         avH5Nl0sUaTNQVuRsMNxQ9ONmj68AD70CoNxblpXQOKlgS7lOwo6BHLIjG/fpJmrj80D
         flVPh4pTmPqana1s+EByfhRYRSdQ2c0sHMOOeUxKlQs+2GaZ41qssaI6evj5qQBy9IP3
         xNzK4E1682O/31bZSzbXW5VajF7nOR2RoXz25fCH7ZSvhTPYW7iFE3Rgt/EbSAxW/nym
         NDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730370436; x=1730975236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3ZugE99LtSXQE5Vb/qD42v3zeWQYKRSifIMEBMyrqw=;
        b=uf9RgWjJ3Q8Frh2CX2x2eHlktUodC+JlaPBKxd/f5FoqYIH+zPlPKn3io6pOokifPk
         FpbjyP5y2KRT2XPKw4baLZgFuD4m84yBD0M0iztu9DGycHL2NHqtvETasj4Z6gDEhAHt
         IauUzFo429L+bKEjvNDlyh3VBtuYAkLI2E1Uf5lSAtm1NaxX6AbgIhu1G0RhZVE4pP2T
         tTzOJe+EVr4oZ3t1aABQbrRb/Z+Q5mx0PnkNLvvYN9BUoBaRHFFxUnD6ZtSE8c6ZiWPE
         FGiZeNJQh8uk+2dDxdPYFuOykUMhgRzWXfqPsc3HL4ypqaaq4tFu2PJTkFwG4R+TiRkQ
         j4jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxyupQBLoDlpFpGn9xGJKdfuu4nFunJ7E5mhIOiPdRQvFfxcERa1jXeAHobCtCCN42pEunxOUNbBvNd5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1gjTcFRqfAz20ElIjbVX0Jk6mbPBU9pBBdpWD8B7+KhdQKmwA
	Brf+WUskjEzGu1bwzZERCQURkWL3DCPpSuZp+PrK4CU/OeyF2C0=
X-Google-Smtp-Source: AGHT+IEBcE8vj39grKtLpz9CgfafRH/GRYskQDZM1Eebvb/oBlT4YNE+QgxON3pgrEz10Q1ePPPlEQ==
X-Received: by 2002:a17:903:187:b0:20d:345a:9641 with SMTP id d9443c01a7336-210c69ea999mr202558035ad.27.1730370435818;
        Thu, 31 Oct 2024 03:27:15 -0700 (PDT)
Received: from localhost.localdomain (114-45-152-127.dynamic-ip.hinet.net. [114.45.152.127])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a2f08sm7082385ad.154.2024.10.31.03.27.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 31 Oct 2024 03:27:15 -0700 (PDT)
From: Ssuhung Yeh <ssuhung@gmail.com>
To: snitzer@kernel.org
Cc: agk@redhat.com,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ssuhung Yeh <ssuhung@gmail.com>
Subject: [PATCH] dm: Fix typo in error message
Date: Thu, 31 Oct 2024 18:25:59 +0800
Message-Id: <20241031102559.33162-1-ssuhung@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the redundant "i" at the beginning of the error message. This "i"
came from commit 1c1318866928 ("dm: prefer
'"%s...", __func__'"), the "i" is accidentally left.

Signed-off-by: Ssuhung Yeh <ssuhung@gmail.com>
---
 drivers/md/persistent-data/dm-space-map-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/persistent-data/dm-space-map-common.c b/drivers/md/persistent-data/dm-space-map-common.c
index 3a19124ee279..22a551c407da 100644
--- a/drivers/md/persistent-data/dm-space-map-common.c
+++ b/drivers/md/persistent-data/dm-space-map-common.c
@@ -51,7 +51,7 @@ static int index_check(const struct dm_block_validator *v,
 					       block_size - sizeof(__le32),
 					       INDEX_CSUM_XOR));
 	if (csum_disk != mi_le->csum) {
-		DMERR_LIMIT("i%s failed: csum %u != wanted %u", __func__,
+		DMERR_LIMIT("%s failed: csum %u != wanted %u", __func__,
 			    le32_to_cpu(csum_disk), le32_to_cpu(mi_le->csum));
 		return -EILSEQ;
 	}
-- 
2.39.5 (Apple Git-154)


