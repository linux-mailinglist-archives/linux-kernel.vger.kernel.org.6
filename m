Return-Path: <linux-kernel+bounces-290760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D54AA95584F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 16:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A691F21E1C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 14:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4556B153BF7;
	Sat, 17 Aug 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="kevwTIZs"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076D61E481
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723904489; cv=none; b=UGsZuT2mIbW9pkeROmUIlNxcNj/SHW3GTgQPtSZnN/46FWpe5fkwTk6zpF24vWNXwXjcnZEN5GV81upH8sLHf6bWDI5CI0BsX/z16baWid7DVr2c2fE8Suvn7sUIfz1vvja+RGsURZdg1ZXNaSmlCAgX4XO8TLTpQAmXIEAWKrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723904489; c=relaxed/simple;
	bh=vjjnpzw4xihlbZ0brAqP1VmfV3dyscnLMEfBKjis4LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AbFq0M9cLuPiyX3QGnuytlo6cDXJeZclmjbw+3lxd8qAZkwn6Hb3QdMHjDPUyJQc+4lOuYJKIen9njZqwrKybvM55opTQLDw9q28vLNGPCh+AeREUTmedGcLzb4oaTG0IOt4GuhHRQoZnZ6o6crjQrBrCjRVnjQJRYFHPwcE7Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=kevwTIZs; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3718acbc87fso1349593f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 07:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723904486; x=1724509286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+yIPvpn5RiREIdWEvUL9xddN+rBBaKKA9WfA/vQhO7s=;
        b=kevwTIZsWgb0Qcn2pajoUNJYXd3+lCvWBB/kOAZldjJs+JfystjbSlqbSFjdz4O4MK
         Y4vWHy5BrpH/8SUyf7TmwjoiiJxkSRdHR0HO3IBEP1ckCddjnLnPuTKmn/V93UwPusY4
         A47AyBEWe+biq3jAAg4KSzF3z4jMgJs24wTPveuN53SSUrGuv996w5EFo9GAyRE5+N2m
         cG2v5JvgLVe4R0EodLIhlS19LLQgYHTWZnONHshiaidY8luqkec4rUlWXkxldsZpkHs0
         LkmxfMmmUwtgwNDt9/9F61Ek2Fsyb9jgtrSp+c2MF4qdpaR6fhkEaJFj18FNJ1sWYwQ1
         a/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723904486; x=1724509286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yIPvpn5RiREIdWEvUL9xddN+rBBaKKA9WfA/vQhO7s=;
        b=bgB+miS6/TibyLdww0V2+UKABYNVdtLS+FefgM0Id2n4T/PcaerZRxdvIlJck5r6nf
         VthLAQgAKCJ2gJRqtuhtduI0bSrlKvNycbjMhs3rN7rzc3t4KVB5KYOeg8t2letuIZHJ
         8w70ce8Db+ogOmNCv3iSH86nz0lkIzAMRjH9pqNcEYWjhgQAx+N2F5GYWOPO98OCw879
         o5L8sriB4ImBDnKnf5OU31Yu+G1J52EBLsjDdq2UXgxz53+eum9nYvpmnLfHbCGkTqPG
         GGidsNLvOKLfre8vchl3mA7bnSwUg5ts2V14Lqe0knbDSKFOyUS3dxEFct4jhLs7v5vF
         B/Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWpQncmhYC7tg8/WUOImaFFfVHOS+9kH0l8NEt4Z9K4tqWOT7PL403IgkU1waicR6gs9XIreYcrUu1/B7z+GGiKG8jQYkx4Vk9aTqkd
X-Gm-Message-State: AOJu0YzWecepKhoBcAPHQtPm0nYghkJ7X10ZHAPEpM6xoeEDcML1XjE9
	NpeMsNkHsCC8d7ul7ss4RMGn60tSQ1p6b+4UM8tUzDCLprzUNLBOuk3TgjXQzpU=
X-Google-Smtp-Source: AGHT+IGTnbsZzhgA30HV1nq4jUBYXpBcMACaAMCY4g0TJpzNpkhYWLeLKT8kVFN1sqa4jKwuB/P+pA==
X-Received: by 2002:adf:a2da:0:b0:371:8e8b:39d4 with SMTP id ffacd0b85a97d-3719464cd9dmr4721751f8f.28.1723904486056;
        Sat, 17 Aug 2024 07:21:26 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a397sm6008530f8f.24.2024.08.17.07.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 07:21:25 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: anna@kernel.org,
	jlayton@kernel.org,
	bcodding@redhat.com,
	kolga@netapp.com,
	josef@toxicpanda.com,
	gustavoars@kernel.org,
	kees@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] NFS/flexfiles: Replace one-element array with flexible-array member
Date: Sat, 17 Aug 2024 16:20:23 +0200
Message-ID: <20240817142022.68411-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated one-element array with a modern flexible-array
member in the struct nfs4_flexfile_layoutreturn_args.

Adjust the struct size accordingly.

There are no binary differences after this conversion.

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 2 +-
 fs/nfs/flexfilelayout/flexfilelayout.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 39ba9f4208aa..fc698fa9aaea 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -2224,7 +2224,7 @@ ff_layout_prepare_layoutreturn(struct nfs4_layoutreturn_args *args)
 	struct nfs4_flexfile_layoutreturn_args *ff_args;
 	struct nfs4_flexfile_layout *ff_layout = FF_LAYOUT_FROM_HDR(args->layout);
 
-	ff_args = kmalloc(sizeof(*ff_args), nfs_io_gfp_mask());
+	ff_args = kmalloc(struct_size(ff_args, pages, 1), nfs_io_gfp_mask());
 	if (!ff_args)
 		goto out_nomem;
 	ff_args->pages[0] = alloc_page(nfs_io_gfp_mask());
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
index f84b3fb0dddd..a269753f9a46 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.h
+++ b/fs/nfs/flexfilelayout/flexfilelayout.h
@@ -115,7 +115,7 @@ struct nfs4_flexfile_layoutreturn_args {
 	struct nfs42_layoutstat_devinfo devinfo[FF_LAYOUTSTATS_MAXDEV];
 	unsigned int num_errors;
 	unsigned int num_dev;
-	struct page *pages[1];
+	struct page *pages[];
 };
 
 static inline struct nfs4_flexfile_layout *
-- 
2.46.0


