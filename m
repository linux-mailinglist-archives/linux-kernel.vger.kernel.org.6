Return-Path: <linux-kernel+bounces-197996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39408D71C9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 22:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921AE1F21B10
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 20:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552D3154BF9;
	Sat,  1 Jun 2024 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="RNP20Vz2"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64007219E7
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717273463; cv=none; b=FuN/Cgh1XR6uZWE4YkvgcEPtIQ1UrVeWOqv25ncA+RwL01wzktB2pjGMANGMwwmh0o7+PKZ0+NF27jchqSiUsveXvMGmVw1nl/LpFEw9hrS6XK5jmNl6aVuBe/Rt4girxVtRwzlQYVs40GwQAtP9+VdhPcEZtPHDAfDY8SdxC4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717273463; c=relaxed/simple;
	bh=YXg0sJEHG1JNmDmWn+3aihlbT685eZ8lKy+1vssih1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WjWQuZo6VrMManxb0feaLTyLUmKILFc5CyLWCJ2I2f+92AlI10+ny+JYQ0GwpJXmwx4FKVBojvSA58NA+PHYXx4OFgLpDun3IUFKjcadH8g2t8++9svHRyg2Das9FBSx1icAtk3lEl5MPtcYanGrlcL7rbIWQL2t3MvDdIPLmLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=RNP20Vz2; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e95a1d5ee2so51026131fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 13:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717273458; x=1717878258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lE82Snz8MzIXw9HxE7ksfPmYVUidTWq9kb5E7IW25jI=;
        b=RNP20Vz2RoqwnsODkshjpfwgVupIQufIkbGSFnVHsilxyEIyi8vUGcueugAgB6eaf1
         Ot44Spjl3X15J+8pQaFVBl5eHTQmrlIOPSOn1z1HRhxicRacbQV1IKrweoQZ3PhdPqbJ
         saobC21vg9WyKuthf7lmE5BNI97pC6+2cF29Nz8HjftG4BFoeq8Cl7vPkVb16rdyDMC0
         kozbTO6heK83K2ATnj0HppvDfH3UhVcwUP0OHl3ufj0MpKJoCc6RbjuCR1iuQYulXa1F
         Q6xuyByg2LpA6t4BbByKB84cyeu54RwOIgS2gHgxAzIZ18D+9N8YQaULui7eSI0ywDrj
         pmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717273458; x=1717878258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lE82Snz8MzIXw9HxE7ksfPmYVUidTWq9kb5E7IW25jI=;
        b=cka3bZItqX6dyWg0nzoZp6evI+yzZ0EFmmaZ6gbnqHzx2XDKNHxxoJgiKPPuMzlo/C
         OVPFAyk8Etln1yWIvnj7VCTGzZGziM6P1PZojPsZuziq2xe2VbjMgxcUhKKtofpw8EnW
         SFzqeMIJ+Dc6G0M9wSxWk00hNUvn5MJ1vtcwngDUXYm6+0LCv9gBebmgSsVrUHyWzrI9
         d3Jjm9HUgAct2PCsvRf7TBT+oI0icD0n+033dMz7nEnvW7oRn4gil7uNVoT7NVKdMXey
         0M07qg9x2m+1/ncC8i5Rc12tT8MBOFIybvRKZRYu7UfmvSQoaa22QB3nptYVoTVsNKDl
         1ONg==
X-Forwarded-Encrypted: i=1; AJvYcCWSw8/g4KLMdSoaaeicfv1JBm7tqBanEUx0rxM0kXrZnnkPbb3UapAnSDWSIpKgKnVVM68+Dbei81zS1qwcAuQSDMHwmcm5fJFF/Cm3
X-Gm-Message-State: AOJu0YxNAXJE+UQGE1ynQMLRPPD76fPq2imvJh4coZhM9ofEDbtz+r2R
	EGmnoua0KI0GaWMdiaS8ekejhypNf7FL2zFRYQ9HhmknkQxqNswDdEYj5JHqwss=
X-Google-Smtp-Source: AGHT+IFLsoaIiImdFPdqMk9Owuiby/QeuscoKOAaWhgAQWdntLqPGCtlswpdzpAqz2qUzWDXU4U/YA==
X-Received: by 2002:a2e:9d1a:0:b0:2ea:81cb:5532 with SMTP id 38308e7fff4ca-2ea9520a217mr41188441fa.52.1717273458251;
        Sat, 01 Jun 2024 13:24:18 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68ed647945sm4229766b.9.2024.06.01.13.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 13:24:17 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] null_blk: fix validation of block size
Date: Sat,  1 Jun 2024 22:23:51 +0200
Message-ID: <20240601202351.691952-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Block size should be between 512 and 4096 and be a power of 2. The current
check does not validate this, so update the check.

Without this patch, null_blk would Oops due to a null pointer deref when
loaded with bs=1536 [1].

Link: https://lore.kernel.org/all/87wmn8mocd.fsf@metaspace.dk/

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 drivers/block/null_blk/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index eb023d267369..6a26888c52bb 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1823,8 +1823,10 @@ static int null_validate_conf(struct nullb_device *dev)
 		dev->queue_mode = NULL_Q_MQ;
 	}
 
-	dev->blocksize = round_down(dev->blocksize, 512);
-	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
+	if ((dev->blocksize < 512 || dev->blocksize > 4096) ||
+	    ((dev->blocksize & (dev->blocksize - 1)) != 0)) {
+		return -EINVAL;
+	}
 
 	if (dev->use_per_node_hctx) {
 		if (dev->submit_queues != nr_online_nodes)

base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.45.1


