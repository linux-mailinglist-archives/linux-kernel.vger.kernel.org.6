Return-Path: <linux-kernel+bounces-229321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A816916E46
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ECEC1F25482
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D618B17623D;
	Tue, 25 Jun 2024 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5UODf9e"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F83176225
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333739; cv=none; b=Kb7K7tomQqKWd2v2+AHyC4gGRxtAkJlTgtEWXZMSAvgunEaRH6hvb9pDmmeB1NdFd5+N4znvKiyoHIHYfRJBoPMfxFEnUjgmK6StwU+boS2H23t8HMWcU1ABv7VkPUU7yNANMDqUOhKL54yU5MVMT1d65D0pqwu06EBDm36bnnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333739; c=relaxed/simple;
	bh=FyiCzW6XIb2gfdf8H6OEDN9PU6g+1OS/36+lF7aFa08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J4eFCrqVxmmwczTwMLqGkNpHrAtVKsLrrhp0c1aGM6v6mgSIv3aacaPm+jRhCKgJPUkgR+JBgzuCi233kG/zyfPoMiR4Fa8dYh69rEGpK1vxp0GNmObyJa8Jxv+03NQxeOqOfcc2OYP2U479MkuEQrsAr3FH9UQz74FfCrjObVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5UODf9e; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-645808a3294so20466367b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719333737; x=1719938537; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gJYda0ZTUkWw1q6d9Psi0GAgd/bxpCi7wNXv0O0kijw=;
        b=L5UODf9eXIFbrhin7dk348zOlKMIvaN4b7VtK+ReSK+A4BstCJDhY9MorktKxl/O/O
         u/ak2mXsx1rCjWn4bvJCLSqEzAB/81/xztzrLt/5zzsT2lGjq7jeYiBs6HziTpDq/RVa
         fVIGSQK3HjKd5sd2ka0q9JGYkuz4FQLmtpvaNRi7V1zJDsiaPC/V+4mU+MuUHux/ej7R
         CB9WmVuFsZnVaZVDXgeligWPKbqw78ltif4TeQOMThakCHnHSX7ckuwelsqP2CrS0ofr
         Ixa7I9dYcloYKrnObuhhhEsJyeeBOtop2P/wo1p+eyJn5osKjOqYRZ9CqD7cxLxKJsY2
         oQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719333737; x=1719938537;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJYda0ZTUkWw1q6d9Psi0GAgd/bxpCi7wNXv0O0kijw=;
        b=qrZIFkEJhBDNrISH36073LwSHCkTF3+Ni8Wexb8/0ToRE60TNcYw8rmgk6LJ2/NeMR
         AT2UtQcrwJVJAKiAhXOf7vews5vtVQ3E+l6cVrHOfjR4ejRPXrn035jlOGOKQn3aPU0G
         8beJH7ma4xirdCz6wHxqTxG3RhTbMDYvAR6E3n3LX25Ien88llv4ealqZUlaE4tMXEBS
         IbD3+0pdDRTylOm/RgC7kz4UaWRW5ecP9qB4gcoFwUoOIyFXl42se/Fm46WiXjDxSjFM
         PZ8CAb4H/TpsspOFncz4W7flpbUu3t3J6q8/W9e+oJujbuJyN3ZYgZOVb5bypnqClmwW
         atjA==
X-Forwarded-Encrypted: i=1; AJvYcCXlKLUEBv8tyS3LGjIRme3GSxLonDIrBuA61zEKXp6Rik8/lCeg5LwnRNJkDZMgFEL0i/swqG1KNOgOOrpvjoIsolxQWMNGh1ThmxTq
X-Gm-Message-State: AOJu0Yy7s+AShiwCQMoYslCr8VNStTcjMummh2eknd0nFy+IN+meTtMD
	5VZl2VPo+YKVDFhys7iTSIk23S9DsvrXFatiXMbgq78k9FlD7TPF
X-Google-Smtp-Source: AGHT+IHmv54640JtdzVgVBjNMW3oCfT6iQTauLr2MlR8ij38PaWAvmUXPYq6zM09d8NDYmlZcgoGLQ==
X-Received: by 2002:a05:690c:ed2:b0:643:9333:9836 with SMTP id 00721157ae682-64393339b44mr102451277b3.38.1719333736635;
        Tue, 25 Jun 2024 09:42:16 -0700 (PDT)
Received: from [127.0.1.1] (107-197-105-120.lightspeed.sntcca.sbcglobal.net. [107.197.105.120])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-63f14c265f7sm35548717b3.81.2024.06.25.09.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:42:16 -0700 (PDT)
From: Pei Li <peili.dev@gmail.com>
Date: Tue, 25 Jun 2024 09:42:05 -0700
Subject: [PATCH] jfs: Fix shift-out-of-bounds in dbDiscardAG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-bug0-v1-1-fcee34ac00a7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFzzemYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyNT3aTSdANdQ8NUC0uDNBMTy8Q0JaDSgqLUtMwKsDHRsbW1AOG2xBt
 WAAAA
To: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linuxfoundation.org, 
 syzkaller-bugs@googlegroups.com, skhan@linuxfoundation.org, 
 peili.dev@gmail.com, syzbot+61be3359d2ee3467e7e4@syzkaller.appspotmail.com
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719333735; l=1360;
 i=peili.dev@gmail.com; s=20240625; h=from:subject:message-id;
 bh=FyiCzW6XIb2gfdf8H6OEDN9PU6g+1OS/36+lF7aFa08=;
 b=RHhyssi0fbYov9jrA3a91QuJwBYuK5ttGQw7Q+tUA71JkjGPbQqu+8lbVfowuUcM9Av9AQw13
 NAh7gfVjZdTBfHeo1WTFpunsWiqiIUhGhod/tNPKklDpQROSelUGrG0
X-Developer-Key: i=peili.dev@gmail.com; a=ed25519;
 pk=I6GWb2uGzELGH5iqJTSK9VwaErhEZ2z2abryRD6a+4Q=

When searching for the next smaller log2 block, BLKSTOL2() returned 0,
causing shift exponent -1 to be negative.

This patch fixes the issue by exiting the loop directly when negative
shift is found.

Reported-by: syzbot+61be3359d2ee3467e7e4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=61be3359d2ee3467e7e4
Signed-off-by: Pei Li <peili.dev@gmail.com>
---
Syzbot reported the following error:
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:1629:18
shift exponent -1 is negative

If BLKSTOL2() returned 0, the shift exponent will be -1.

The solution is to check the exponent and if it is smaller than 0,
exit the loop directly.
---
 fs/jfs/jfs_dmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index cb3cda1390ad..5713994328cb 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1626,6 +1626,8 @@ s64 dbDiscardAG(struct inode *ip, int agno, s64 minlen)
 		} else if (rc == -ENOSPC) {
 			/* search for next smaller log2 block */
 			l2nb = BLKSTOL2(nblocks) - 1;
+			if (unlikely(l2nb < 0))
+				break;
 			nblocks = 1LL << l2nb;
 		} else {
 			/* Trim any already allocated blocks */

---
base-commit: 2ccbdf43d5e758f8493a95252073cf9078a5fea5
change-id: 20240625-bug0-11e890f449af

Best regards,
-- 
Pei Li <peili.dev@gmail.com>


