Return-Path: <linux-kernel+bounces-436013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0DB9E7FE3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 13:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8631884551
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9B3146A6C;
	Sat,  7 Dec 2024 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyYEtqsP"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBAF4E1CA
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733575064; cv=none; b=rU56QPaSW7dvlSHVW5A02a04IglnbdXdJBM4VdPLiE9rzjExP2Ppjd1HrFpuZXvTYgNXXtxHTJS2O5/gO9W8xulAlhKYMya0s/1L4AGL45jSOwNjY8L7HgbhbrJW+rm6C66gYFo1TXDWEr5PrArY9ZnnjzhhPJOuxRlUZTVfyTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733575064; c=relaxed/simple;
	bh=gAx2GsIKUg/y/jNLoObi1Q9vAfzx51AqCld5wFLpLaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dPvqEl3ekCQBczgrj3PVLM587lnSFWxkrmKnnAvgmYLh0UuH2nvh144OhGr2x1XHQaZcyEBwXVEkQf83ki0M5SqkTpSMDqLqWiCxHOAS1M76td3ooJgDF0VVLu3oe/nG1blLenTrcdEYNsjA0lfVgS18UGGAwvE8foLOSadKr+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyYEtqsP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38632b8ae71so613157f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 04:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733575061; x=1734179861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jmtD4L1/SX4Fv/KBhC5LSYN3L3RfR4TRHNghsMrCU4w=;
        b=FyYEtqsPu82C04ApW1p2gJ3PhSd+LDXS4WEqxEU67IydRmxmqWStpILQJ6iQ+T5NB7
         cTsoGtNg4To/UVIrGK3ABGV4h7KxRRY/cbwbVzjr0SW5wfy6JePzupJINytKrKGdNanK
         SNCKgYL6Kcjm2YdLTaskomF9PvGdieIMABKtXq7b/BOk3KI35UlJv8JFP1iWwisTvxgm
         tFKjAzIHvMJz9emPddovrCu1EoqLfBbn8AHEd/jozKeO6im6QPNjG/CkGFhB+QiPdu7K
         rKpSXf3Wf+s4PVpURT/HxheEeiDp0AqYH4iq2Vtxcvz/eCHYc5UYkiYm4noJEyd7hUyP
         DoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733575061; x=1734179861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmtD4L1/SX4Fv/KBhC5LSYN3L3RfR4TRHNghsMrCU4w=;
        b=hfjGvrn8BmAaakd4S4VdauB2TcfX1b3NXRZM2OHU316gwQzgeHuEhaz882uwiz5HWt
         HuwJZiWeaJnb0h/t4aFnhy9Y6D6h8bwt2w/ZZwstpaXR7wCvKKJC8LdH91AvM+wLyPy1
         2EbfWEYyFPOLtyne9c9VkhJLc2bEC5+4NwK2SU13hf4QXD0D9EgSEyhttpsRFlSKNdDa
         qlzCenFfrd85iuOQzRFXpYIyPL/1CPNq4isGeW7mKRAneYR+16Ao0h5XTrJRUkDeJLOf
         Tzrbcz6olxy/MZFejcFIv4hD+90x1XVrFQBwEC1c+dzuGGrQ/TmuIMwbs8oOs+K2gwJ2
         SI4w==
X-Forwarded-Encrypted: i=1; AJvYcCXJQh50j6fuRKQT13dURbxIabKZ9dtaOyD94820tYFqL0RVhNJlDmpm7xREG7M+ig1hneTTvsbSyUUWORI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPRH+v18tlrJvxBR9Xacp3JE4cAh4PnqlUDjrmPZ62shyVlwMw
	PG5AA5fiYdYWay0ZCTN/a/Oh0Gg21d63I6FDyAHCkly5xk4IHHjQ
X-Gm-Gg: ASbGncsCp2S/tGJJeAL5pjFcX8Eb/djFTD7nyZ+ugtgzN1bZdmYD4SXnaQ8m7KE0adv
	DDFv9U10MK4RhOB9RK1g98eO59ivCkzcp4qDO1qvknF2Dfrd9EQLQE/wfnwiSaQg7STnmPo44MK
	QNQD+NbVTiqYGfSeyaTsJuwsWLKdPQfF5g9m4b3M9lsq7P60HT2pquzMHFfPG3k+VtaxtXz95nZ
	609fp08XOxVH9FYIUSkhxK08croIr7MIjJTDk5h7BgqwwYTce8Zg8pLpvZ/Bl3pD70PBEY9z12w
	C550Mk98qg==
X-Google-Smtp-Source: AGHT+IF4kmrsXWCslu/q1LRta0lEfN+z67D6i2YlSKQPoUjkULf74sFamCgkUBJV+DRNNtozWYE/6A==
X-Received: by 2002:a05:6000:1787:b0:385:f7d2:7e55 with SMTP id ffacd0b85a97d-3862b355a26mr5148854f8f.19.1733575061246;
        Sat, 07 Dec 2024 04:37:41 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526b14csm124615875e9.2.2024.12.07.04.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 04:37:39 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] staging: gpib: Add lower bound check for secondary address
Date: Sat,  7 Dec 2024 13:34:10 +0100
Message-ID: <20241207123410.28759-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 9dde4559e939 ("staging: gpib: Add GPIB common core driver")
from Sep 18, 2024 (linux-next), leads to the following Smatch static
checker warning:

	drivers/staging/gpib/common/gpib_os.c:541 dvrsp()
	warn: no lower bound on 'sad' rl='s32min-30'

The value -1 was introduced in user land to signify No secondary address
to the driver so that a lower bound check could be added.

This patch adds that check.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-staging/4efd91f3-4259-4e95-a4e0-925853b98858@stanley.mountain/

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/common/gpib_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/staging/gpib/common/gpib_os.c
index 405237d8cb47..f25e7c458581 100644
--- a/drivers/staging/gpib/common/gpib_os.c
+++ b/drivers/staging/gpib/common/gpib_os.c
@@ -536,7 +536,7 @@ int dvrsp(gpib_board_t *board, unsigned int pad, int sad,
 		return -1;
 	}
 
-	if (pad > MAX_GPIB_PRIMARY_ADDRESS || sad > MAX_GPIB_SECONDARY_ADDRESS) {
+	if (pad > MAX_GPIB_PRIMARY_ADDRESS || sad > MAX_GPIB_SECONDARY_ADDRESS || sad < -1) {
 		pr_err("gpib: bad address for serial poll");
 		return -1;
 	}
-- 
2.47.1


