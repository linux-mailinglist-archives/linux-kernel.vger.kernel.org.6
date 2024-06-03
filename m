Return-Path: <linux-kernel+bounces-199640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F308D8A20
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBE91F25A37
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D30137923;
	Mon,  3 Jun 2024 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="VC5X3SyU"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDFB137748
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442821; cv=none; b=tzgbBXE/qg//KlWWSIkruOWL4iUkYJcxn2t73UhOr5wmUlN5Tm+QVl863lIbd0vpD/Vt0+e0I2MuUJW67AUod0fF63ozESlp/pykSulzh6y3RRpYJYs4vq61g5nrUfi+ZXL6W38hhOpT23Di8W2vMEeIQRiSmVu9SB5OMt5UU8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442821; c=relaxed/simple;
	bh=5tryiqGWz7woo9GeAI9cW9IgeIA3mnTyekQazR6n7B4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SuY+SF0VUysyLpcmhAwsUTmqdYAbn/gHhjDBPp+osRt3KYvr034qpLePIHZzGVUok6R5nyQEiRtK/zIQCwQshNunRPEOnbyq8fWmZ7qdxGOyHyRPmAUTNxKoNFuOPCfQI4LPY5hS3zUuBd33MR5EAcNO3IIJkAa+4eivw/4kcFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=VC5X3SyU; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5295e488248so4989129e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 12:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717442818; x=1718047618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bgq00PUjrhCM1KT9z8TW3RB/dgS4Xp/0LzoRpKh5jRs=;
        b=VC5X3SyUAX39DOqxIZieCJeam9lTh7o1tGDRr39FCQjSum+iV0kRiLYJqXbT/XadTx
         Zd4C8geUfvFnvXlVPvq51RbcxsGSgCgw66Y5MB4QdzG9y339gcj3ffadEK262Tqsz9u0
         xE9Hdf6mEAwFJDmCoSEabrpdvHy68D2E9GDv16HAIDqwss6QEFo2Fa84Q6YkfhTVBiCM
         zuc9VxnowYCjcU5h4RX8m7fJIAdq9f5k9LmqmuSJVEBm/MfOc1B2LAKeNAzG3O3GgVb8
         1o3SH6UeVfxCa2/fVPXL1QDHrPb5N+1OHdk9F7Ok/qVXmjwjBvL8mLQ1nHbyxXSZTIO7
         WlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717442818; x=1718047618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bgq00PUjrhCM1KT9z8TW3RB/dgS4Xp/0LzoRpKh5jRs=;
        b=t021imCD9/lMpZmd+idK0sIjz8Kr+uTB68rEZv29B23CwR3wPDIj2zP0yZw8aJuilw
         QNyH0SQ90GUU+3idnV+VnKzppngZi/77zX7oQ6ynjIQhUcUTvAIqVjuZZWJ+42Kb+NKR
         dq61IcGLSQ/ZnhkqDrClOeOAYP5iK+04U5YvuDB9TRHFfzdY7edp7PO7Th8muP2i9NKR
         EtQkOOYcHJVqNROo5jCDWskyjSxSGRx8SNFXh8/B76/G0rMUGMjwtWFxQANm4ApqMBWu
         HRovxVqNMB6CEqs+NQT/5sNRzZBBvSQ7w3naGu8Z/8dGBBVEwtYpM3aV4l5n6Pgq4neJ
         0XTg==
X-Forwarded-Encrypted: i=1; AJvYcCXSGxmDBhf78eRo8X8PCUGNLtKBYLzqa67p06Ah8Z7pEVrTPGqUid8zDfy17F7z9rfNeFbARCKMUhf4xUk+6bUng711exC6O/45vgY1
X-Gm-Message-State: AOJu0YzVZURTDBz0VQ5ZV1VKKJ5qTHZSs4r0NNrBWKvkC9RTAKxW5UO9
	v27Blzq1DDf5qy731Oef4KwhHWsfC1H9n5Iuhr6JsfBgRU5uPNkb38PQgLC74oA=
X-Google-Smtp-Source: AGHT+IEEdiuK70dIt0kRQ6ZqIyfF8/dtIItu00A5a5CGgt7ADEjKNbKwIlbZf+kUgc+loKojBUe4Pw==
X-Received: by 2002:a19:a40a:0:b0:522:3551:35f5 with SMTP id 2adb3069b0e04-52b89564058mr6258471e87.14.1717442817779;
        Mon, 03 Jun 2024 12:26:57 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6900c692b0sm235052066b.151.2024.06.03.12.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 12:26:56 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	John Garry <john.g.garry@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] null_blk: fix validation of block size
Date: Mon,  3 Jun 2024 21:26:45 +0200
Message-ID: <20240603192645.977968-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Block size should be between 512 and PAGE_SIZE and be a power of 2. The current
check does not validate this, so update the check.

Without this patch, null_blk would Oops due to a null pointer deref when
loaded with bs=1536 [1].

Link: https://lore.kernel.org/all/87wmn8mocd.fsf@metaspace.dk/

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---

Changes from v2:

 - Use blk_validate_block_size instead of open coding the check.
 - Change upper bound of chec from 4096 to PAGE_SIZE.

V1: https://lore.kernel.org/all/20240601202351.691952-1-nmi@metaspace.dk/

 drivers/block/null_blk/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index eb023d267369..967d39d191ca 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1823,8 +1823,9 @@ static int null_validate_conf(struct nullb_device *dev)
 		dev->queue_mode = NULL_Q_MQ;
 	}
 
-	dev->blocksize = round_down(dev->blocksize, 512);
-	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
+	if (blk_validate_block_size(dev->blocksize) != 0) {
+		return -EINVAL;
+	}
 
 	if (dev->use_per_node_hctx) {
 		if (dev->submit_queues != nr_online_nodes)

base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.45.1


