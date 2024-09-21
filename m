Return-Path: <linux-kernel+bounces-334820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E7B97DCED
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 13:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982CF28200F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 11:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120A0156F34;
	Sat, 21 Sep 2024 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuYuNGtJ"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3969A15383D
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726917620; cv=none; b=QW0aC1wx1HypA5SJy6bJbSgdARtN+JD5AOVKhSFEenKCk8YdjQIDXvHh5K1ym1EzoFL8DEII2psnrcAKm1ZS3nvhobw46XSI/fqoBxlNQ3U5eu5sNvc4XWHkQ1aXWj8Puge2SEzJoZicI5KlK+RMUAHMZ1BHBrgUu6mcH9mZCE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726917620; c=relaxed/simple;
	bh=Bb7WnT91dz2LpBQEoUL9VmGPUkyU6koguA2TBJJKwQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e5BWwqMcK2iPamSju4iKAU9z+QtkxqEglzJ2WgLn50AHpZAHVOfTxdomW5yKvkpNd24Y7M8ZI7paVYT/nAze10iXIeyTS9IQkit9ZVim1eDXwjDSmWVrqJAC8QJS7q/TSaCGl8H1hY1vYOIR4EOco1EsrVmSq/ogz6NSD8n2w/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuYuNGtJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71923d87be4so2179418b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726917618; x=1727522418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg6hb0MI1gjugCnRz1hV6Vil+K4JKzjv1S1dEXvrA9I=;
        b=NuYuNGtJ+ooO2DZTeXl3URUf6EIYaLAapU+dJeRyIRj0MzudGJGt1GyPd4mFUYZv3/
         AX3nSALtDi21J6z3ynyyqh5+CQfH2mHQFs8q+HdC+G1buEYLwZUhArS4obmTyeloL9gw
         TJa8sUUXu9eOTVk/iEVzhcnWlVML5W+2qoCd5D48VkM2miYZqCkmo1Eb8Kg84DSnfzbp
         R2oVyAlbXfz8QK5UHDkyDASHoqbgloKyer3vvX0COplIju2/VR9FDBRvgxpiueagsG2q
         hpgIPU9YfH7FWeUFL/XUEjpHGzmIWtZu+DDiheU/Z14tTdFQTsAW462NsREY6hPhJsAA
         7irQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726917618; x=1727522418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yg6hb0MI1gjugCnRz1hV6Vil+K4JKzjv1S1dEXvrA9I=;
        b=C7t7jCikuDLoNmXQo8cZ8YOGM1tibQI8eRSTEoAcRAU9toHrNcaX3C7mhx+VkoJ1ax
         TEQuztzUL9KzZdu3mgH+NQJ59gEDC7smmtd9ZEHPCRyHdPgY5izo1tt/brkSqfcWuAdV
         cc6GmoSCpwBPA/zGlQedk81SOkJdirxJ2byYG0V2XZ/LO2uDLtQ9hWq5Vi5QlrTe0gOe
         Em+VD+8JRHOK1X0gXgzBrs1udxdtyQtFPydODsnJ2Gz6fqIf3UdaIxxS3tMFCrOwKY9e
         Lk8gNZMaAu8S7e7E1KLv2sEiVEJ5hvWttH9I48KX4Imp9tB2mCzvtbldOYzLeZ20v8tG
         PMwQ==
X-Gm-Message-State: AOJu0YwCUS/6PnaIGih691TTuZYwARiABfB2Wpy4DjYlVO+e9Gh0y13p
	urjrD9fDXFLliGsCsT67n5kv06A8PojjGbTOrB42ldJs58SyUzJdop9CuSXp
X-Google-Smtp-Source: AGHT+IFpLxASGpd2aX2nSGDPqIymEcdIsfnR/TltVE/y8LwnzbKOi4vIlMJxzZR/zIK43IVKM9NVZQ==
X-Received: by 2002:a05:6a21:e8f:b0:1d0:7df3:25cf with SMTP id adf61e73a8af0-1d30a967c68mr8792547637.19.1726917618289;
        Sat, 21 Sep 2024 04:20:18 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab50fcsm11096818b3a.69.2024.09.21.04.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 04:20:17 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+37757dc11ee77ef850bb@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ide?] general protection fault in ata_msense_control
Date: Sat, 21 Sep 2024 20:20:13 +0900
Message-Id: <20240921112013.81961-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <66ed9589.050a0220.2abe4d.0019.GAE@google.com>
References: <66ed9589.050a0220.2abe4d.0019.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/ata/libata-scsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3328a6febc13..6f5527f12b0e 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2442,7 +2442,9 @@ static unsigned int ata_scsiop_mode_sense(struct ata_scsi_args *args, u8 *rbuf)
 	if (spg) {
 		switch (spg) {
 		case ALL_SUB_MPAGES:
-			break;
+			if (dev->flags & ATA_DFLAG_CDL)
+				break;
+			fallthrough;
 		case CDL_T2A_SUB_MPAGE:
 		case CDL_T2B_SUB_MPAGE:
 		case ATA_FEATURE_SUB_MPAGE:
--

