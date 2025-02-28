Return-Path: <linux-kernel+bounces-538063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F62A4942B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9313AA056
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B442A254B1A;
	Fri, 28 Feb 2025 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXk9K5pG"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACF1254863;
	Fri, 28 Feb 2025 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740733065; cv=none; b=mTGVQLqBe5bNzNk786N5717aL3epfs/K/VxaSrRxdVEEQpMJ0Tv5D8Pp1jN5ZGevxRUgLHr79LPjfP+nt0EimWJmOGL7l4pFxvRFfEvRg3sD6bsLaFmMh1khDipyUkfpUTnSq/DewYfJzFamBUvLh4vEI8iqBj1Le/lwC6CpyOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740733065; c=relaxed/simple;
	bh=8ApnVxOAIku1y1NGlqRF2zzBzpu0NT4/22VcCwtbvmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TOw/A2ERpOL7oUMIHmx7bQvWBjHJSIlD2iVcESE9GBSo9LF3QvIRx0H2/cPOF0/+TgZqvn71MV5GQ8cXQHnGYT32KhQ9okjpI+hFfiDSSFiCx4x7hFelUAeUn5O01UpXq3JCFoPNHxyNeSrqt/BniYkXqw0Clb/twGilqqvWokI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXk9K5pG; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390e3b3d432so1252064f8f.2;
        Fri, 28 Feb 2025 00:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740733061; x=1741337861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YOOGOHp/kT32Ubbsvrda4rp5OvOxGdyciA4qun4jkHI=;
        b=UXk9K5pGGB66PuEhqMqJR/XYNNAuJTdG106fsDbr673ZPvj3hxiw42pjL8QcqGoPxu
         2udnywUZjprLJfNQ4r/WXJSAjGpQsgICwTXWlxfuA/jMQvHHQSDdiLgUTrReq6sB2938
         70b9sfNstUp554pxgkrPICDJv09+JWzrTUmAYEj8VuhKum/H0e8ZYAm41OoRmFgZa7pM
         TqJzuwRDfh74SzgZkcrkVCh965YcSUpXAilna8PjcUS2YuW760IjqN1BjNL6089wMKHI
         V8rzWx8sbIeI2E2D2LYcmq2F02bb65Rcf0Xf1+0m9IWvr/0K1QBQOb/e3Ta/OYNcZu/C
         z6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740733061; x=1741337861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YOOGOHp/kT32Ubbsvrda4rp5OvOxGdyciA4qun4jkHI=;
        b=nLz+nYnHrxGYzurTQ/X9aNKNF01//u6F4VsNbWarl0Ubk7vBnHF77K9PIUtUndHZf+
         Ii3oOhfBdWg0NtIL91MzNMtW1ue1Ykl5dcLPa0gCX8TOf3LbELIGf0ZLrw7Sa/3uHaQi
         567ekdJfexXrgW9niNUk/5hasGf+Q73cIJkIZmcT6iQCgIa509sj7/VNnDlJ8u2LbQt8
         ROjMIiOvzseIDfu2aafEOQa47nEqJcYqJH/xs4oE/YOnsOyHyj9Rj926i/VfvAQxfGdg
         5CEoi0jEGhd66sUFVCg0f6XkaibokJgfuGq+wuF5r2RZ6m5qoqevKiDBItfzeqrVJdYH
         lh9g==
X-Forwarded-Encrypted: i=1; AJvYcCUjEVuKMH16mzCK7sT4iXPSSoE/kvMZG7Eby4KY8YuBwdQnvue7lzahtZ7cMWhQnc2bhfavlX2BQEqRVfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKCgNfggeLDijU4RalbOhFFzRmZAwXgZP9gBbYERxs7nvIw8SI
	qEQlCw7kRxwGP1JctsLsXl0KM5/ZBSnImiXLZ2AJWAqGUSb01Z2/
X-Gm-Gg: ASbGncsqSbs51MKrJNBi3yx06pfHjyOCEsZ2J2epLaMomBlpfCCmFiY727qi7ciWc6h
	Al54w3TfbLTVWedMU9WTmVdIIniHJhAiIVV85nfDQcqoh4Q6li2K8BrLNvFGqYcu9VFlgKGXrmE
	53xXYlySpjr663mkAnPzyhBIark7QomYCZ/iooEINxbOEnC1RrB6N/phtJG34TRsFGWBkK9j6y8
	vVhe7JUJENq3Z/ywYu8bYGAknpj4aS+aPC2MTOIlG6L6sR744+VsU7KTNcJe9rlJYKEcSHG+g2+
	PVsq2WFZZkuVeuQUpRitm8elYrw=
X-Google-Smtp-Source: AGHT+IHh1cn5sBB+ae6U8u5TgIgCJ1b8UOf6j64PpB4BLf31Gp1M6o46xk83F0wVo1aSC8clSYk29A==
X-Received: by 2002:a5d:5f84:0:b0:390:eb06:d6bd with SMTP id ffacd0b85a97d-390eca41380mr2114817f8f.34.1740733060559;
        Fri, 28 Feb 2025 00:57:40 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e479608fsm4611706f8f.14.2025.02.28.00.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 00:57:39 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] fs/ntfs3: Fix spelling mistake "recommened" -> "recommended"
Date: Fri, 28 Feb 2025 08:57:03 +0000
Message-ID: <20250228085703.678824-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in an ntfs_info message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ntfs3/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 920a1ab47b63..d0d3214d3688 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1293,7 +1293,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->volume.ni = ni;
 	if (info->flags & VOLUME_FLAG_DIRTY) {
 		sbi->volume.real_dirty = true;
-		ntfs_info(sb, "It is recommened to use chkdsk.");
+		ntfs_info(sb, "It is recommended to use chkdsk.");
 	}
 
 	/* Load $MFTMirr to estimate recs_mirr. */
-- 
2.47.2


