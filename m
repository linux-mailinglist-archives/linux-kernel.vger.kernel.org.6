Return-Path: <linux-kernel+bounces-413324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E639D175E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE14282FB9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110CA1BD4F1;
	Mon, 18 Nov 2024 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F41sbmBw"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99A813E8AE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731951962; cv=none; b=E5R+Xb2FYmvymuEHQRTY2ZwW1RHFrForSiqgLoZSq1dGKFWuVuaBIHmLCD8yHJBcNqwWfVBE5LWFRni18oM4DqCEVrwHSZH6fRMbeg+pgSu2GOlokuAs7HwfnqER1MjgGOxBhkeeN8EW3K1uREoq+6ZqbDpUAYWUZrUMDqw1CmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731951962; c=relaxed/simple;
	bh=fAtlA9ku7fsv9PdvR9l1AlQLWY1RmkdcaesUzZZqODc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NBAwVWNXocJzuZjm2PigwHGAYd/F5f4qY7OiujtB+AxoEyXqFZlzh0utxHUnhqsXMT9KY5E2nfPiBgZPcC9ZyA5nVv3LBLWyT7qQNdaamEN7o7AoJF3ct9Zg3hAspEjiMH5Ryv4sfr17TwDMwjBdOd62YmMOsBYjEkX1p8NCJLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F41sbmBw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-382423e1f7aso1047525f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731951958; x=1732556758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lN8mdU/PvrwtFhg6Vv1FTi18HrGsuIFzHvLdRZu/hnU=;
        b=F41sbmBwtH624TbBpsLkN/+ZHM9N6mKY5zpNU5nZfFOvcsKmLxIp/QeHJWVZ1eIY3u
         1dvMnAY47k4K3/TYao3CvKu2yDg942bbdUZde5/drRsLmejW9Ef0zkfUVj5akwdqb7FQ
         9ZqGPpewEMzz0jcWGe1vNtlgAEN+j6U/oQ+SBm8tDNqforcdsvuOLanzzEXDeqD0xRyX
         uPH41Y75/Ug8d54sNMaFRWouaWX9YC1TGFyud0sfDkD5heRIzykxIW6Yg0/Yu5SFKtiq
         yGlXG297HARPEdcNlhBGPZG63Yte3KLBizHjHGTfHRSgO20snLrr8quAzWmqTAbaiciQ
         s80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731951958; x=1732556758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lN8mdU/PvrwtFhg6Vv1FTi18HrGsuIFzHvLdRZu/hnU=;
        b=fpMTIbY/rw0J1u1gm9Zpd/FHBdj3Ovhdzn2OVfn62s7m0NBgpm8eQaV1jy7PSr+0sA
         lvNNNo651D2ALp4tt5BK8wUwAhbFRdnhf4ks+ty0K4L8I9soTRl69oL6YwTriDBskllG
         ivZ6XwVvd+dXLy4l2ev7X6guYmlt0rp2/mfx+/tYfazG/H0IRAqgnxip3IOwI/HBVIeN
         QTe2W5jPUsogeNIy4BipYF9l2xvMx/s4t747ebuGwztbKyXnQZfZ5lyTvQhCbpAk5VuO
         0blhAkR8Q4tTYiQbEjq3JG+sgkX1hfZsR6RsLaWS8vx1OjzX53y7uMmH2bZn/KeU7yNX
         Js9w==
X-Forwarded-Encrypted: i=1; AJvYcCWWFaFhGB4EpKjDb52fgDr0GsKfcox/8um51uoPw3Aj396D8Z3V2+B4BJQNguX26Rpx0IVvBU2FOFfUevw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdUumC5XQRJq6VuikHf46+/9844H7sbMQSjbecJZAYoWDRftAt
	cPk36a/C+iLIm1sFkwX8BBR9q6yEXxzDaVw+pmlqDZoBzvHWMX3Z
X-Google-Smtp-Source: AGHT+IFjKGnDApHvfEGGAfyAJi2ApxyN1G0vfARZ4Jw+ls4fxxxZ/my4kL3gfc168SN/B7gVziOWwg==
X-Received: by 2002:a5d:59ab:0:b0:382:1b44:9e5e with SMTP id ffacd0b85a97d-3822590f23cmr8892277f8f.19.1731951958021;
        Mon, 18 Nov 2024 09:45:58 -0800 (PST)
Received: from localhost.localdomain (93.red-83-53-134.dynamicip.rima-tde.net. [83.53.134.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382488f784esm3341577f8f.14.2024.11.18.09.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 09:45:57 -0800 (PST)
From: =?UTF-8?q?Daniel=20Mart=C3=ADn=20G=C3=B3mez?= <dalmemail@gmail.com>
To: dalmemail@gmail.com
Cc: Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] befs: Fix incorrect superblock consistency check
Date: Mon, 18 Nov 2024 18:45:19 +0100
Message-Id: <20241118174519.17951-1-dalmemail@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The check assumes that blocks_per_ag records the number
of blocks in an allocation group, but section 4.5 of
Practical File System Design with the Be File System
states that "The blocks_per_ag field of the superblock
refers to the number of bitmap blocks that are in each
allocation group". This causes befs driver to write an
error to the log each time a volume is mounted. Change
the check to correctly compute the number of blocks on
each allocation group using blocks_per_ag.

Signed-off-by: Daniel Martín Gómez <dalmemail@gmail.com>
---
 fs/befs/super.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/befs/super.c b/fs/befs/super.c
index 7c50025c99d8..a900ef8402af 100644
--- a/fs/befs/super.c
+++ b/fs/befs/super.c
@@ -101,9 +101,12 @@ befs_check_sb(struct super_block *sb)
 
 
 	/* ag_shift also encodes the same information as blocks_per_ag in a
-	 * different way, non-fatal consistency check
+	 * different way, non-fatal consistency check.
+	 * Beware that blocks_per_ag holds the number of bitmap blocks in
+	 * each allocation group.
 	 */
-	if ((1 << befs_sb->ag_shift) != befs_sb->blocks_per_ag)
+	if ((1 << befs_sb->ag_shift) !=
+	    befs_sb->blocks_per_ag * befs_sb->block_size * 8)
 		befs_error(sb, "ag_shift disagrees with blocks_per_ag.");
 
 	if (befs_sb->log_start != befs_sb->log_end ||
-- 
2.39.5


