Return-Path: <linux-kernel+bounces-383604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AF59B1DE3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8201C20BBF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 13:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669DB1547F0;
	Sun, 27 Oct 2024 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zenbv5+S"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612A1D6AA;
	Sun, 27 Oct 2024 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730036782; cv=none; b=jZeT6JN1iA+rRo90pda0h5IO8XkOBZw03R7RCEJ57Na7ChQIqrQZLagWUl/6E1pE+ePjDtJ1zF4pibzTmPRv8M5nEzDebdwLWbh4TADciudVLxwwbfI822M49FK3YZn/85sjEFCPnEc2rXdVYlA7sIMuV7MtNKtWzCr/SXn7V38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730036782; c=relaxed/simple;
	bh=1wAsLqM/9YxIYVWDGTUmZxhjUhZh3V6gZDRoFAyHJe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/fUkX5iXRkM9RLqzbnMFW+hFYWHmS629VFn3OCzvUOZYk/1DeGqW6fV8XPtU4tsuf7FM282v9J2BfuHJUZlwL/3lcHSGBjHBvB13NyyK9PxCqiT5XILxBlw91Dt9Q27Lq0Zify+k+gf9muoosN5X2V4u1B0oG3as3vwnUd7vig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zenbv5+S; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so33751775e9.3;
        Sun, 27 Oct 2024 06:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730036778; x=1730641578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FBF2xCVjDBXY36r9f8qZDqWQaqa6k7kywBRKHfiq8Cg=;
        b=Zenbv5+SWN6PD6cudq8+g5ANNi9nbdcbVsJIjbdSqXA5JCb8IxwOpmDJgsU7iT0T7X
         /9HlrH3L8ibnUNskddlZIF3Uhg02BHIt7k9m6bB7uIlcdO2y7GT5eFEqFFP+Pj3BFxWr
         RtYUwZ6g8Dn2PGoyd8q+/ChTaRL4n27EPDn7kebJ+ss8wqvHpvSdlJhS+m7vAM8/BKzM
         6akk8efa8tIBlmkr8zIw82UWWpLLe2AuImjzLXcTPwUczwSxLZR7o8AGbROydbQ2BHJg
         KwciMhVyikvU6Mou4WpGup+lyXWjwRAJ9mSSyfiAOZETVMWAxIgexz6BN9xSj8Lje+9Y
         51eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730036778; x=1730641578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FBF2xCVjDBXY36r9f8qZDqWQaqa6k7kywBRKHfiq8Cg=;
        b=GSrJNZO9f3QlkdM3cdBROrEbyDvqU8hMTb7qmNmnOIg/1KNFcscrsC/JsSH5f3BgAa
         V6fo499UuY3tFQXSV2OEoHkpdjgdXy6q9XSBRlN7bB9+UU0qQaAmAF+ri7Ck4r5Y3RV0
         P5yODjVvorhZ0SglOAczXJmwrpoJzjVeru9zawdrXxcgGWrTNeHy6iywyzMjLRxPaLUz
         UhDwQkyeCxLkHolMgEFOwoyyahMKG+4XlXCqEa9RPyUGFcxpwhuxYUceEug+LSetxwSK
         27xiXN7yXlkT0yV/mTalIzsQIBogdoHh8EpI//b2ea41p131TXLd0+D8rkuqJS2coXCu
         1t0Q==
X-Forwarded-Encrypted: i=1; AJvYcCURRlWQgkkzKzVEGhie8VshksDnnAUHZkgvh0GAxYthlbCLbXKy882tE82IzpfnVFIN+SGqCD/aq5Sx2gsPsBo=@vger.kernel.org, AJvYcCWc1yn3LpFivLrsb5RNVw6UT4SoRUI50TmxasSFzAY7mCIccEvgaNeCXmRfnZxFbnqfqNolv/ygkWUxgMwr@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb4HZVraxD6KjFEtQSLVmQTedvR8651A3/x2nMoX8Cfhu1DUHf
	n1A8BdG2BUKgk3NEixHxhy89wuR8T4LA9JCq620CViop/wICHsRZ
X-Google-Smtp-Source: AGHT+IEMlm41NAVGO68RrktYRtrNXvoOnHit95Vmz7cUlneN2UZAJxzmsEtHxE25ytVoHyo3sCHmvg==
X-Received: by 2002:a05:600c:3b14:b0:431:60ec:7a91 with SMTP id 5b1f17b1804b1-4319ac6f895mr48516405e9.2.1730036778049;
        Sun, 27 Oct 2024 06:46:18 -0700 (PDT)
Received: from void.void ([141.226.10.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f7789sm76393165e9.36.2024.10.27.06.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 06:46:17 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] fs/ntfs3: Fix a typo
Date: Sun, 27 Oct 2024 15:45:30 +0200
Message-ID: <20241027134613.23188-1-algonell@gmail.com>
X-Mailer: git-send-email 2.47.0.149.g3e3ac46130
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo: recommened -> recommended.

Via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 fs/ntfs3/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 6a0f6b0a3ab2..3d7693a55321 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1252,7 +1252,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->volume.ni = ni;
 	if (info->flags & VOLUME_FLAG_DIRTY) {
 		sbi->volume.real_dirty = true;
-		ntfs_info(sb, "It is recommened to use chkdsk.");
+		ntfs_info(sb, "It is recommended to use chkdsk.");
 	}
 
 	/* Load $MFTMirr to estimate recs_mirr. */
-- 
2.47.0.149.g3e3ac46130


