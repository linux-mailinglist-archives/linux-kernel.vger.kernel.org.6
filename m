Return-Path: <linux-kernel+bounces-286083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0FF951645
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D8E28347D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81AF13D539;
	Wed, 14 Aug 2024 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="xp5F+2lZ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC74394
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723623257; cv=none; b=mrUYPxAellqqUYFV3DAIL8JRcSGrUYH1nVz4YeLWwB8bQhlfkpkuel3JEGA7eyy/k75oWM8R/DCcD1L6djVwMqsHxtncYgjU9B/kPgItAxg6x2CbJkuKmdOhkGTVXer7k0nJU/Yfn/9AKpsMp4bj7Bvr3ef8WSrV6wtEHI9V8u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723623257; c=relaxed/simple;
	bh=lUpCW99eNg5vkK25e0gKoFBbywiIER/+T1SiprkyiTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZwXXH1xD6eb/q+Zji8V7C4NVk6tvKbapq5HxZ8rvgqPDlRaeU5gMR8MEYZyxsi9wdFg1j6l/bKHOgN0xrOpebc1UlJ07/pfP0coZ0cOd57YBkB+baHvatlizD9tOK6dbeggUGqYH230KGVAO7iBjMalcLlcx9LmvOFeyuH60EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=xp5F+2lZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42803bbf842so62536095e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723623253; x=1724228053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a2MhE9T02qlicCXJIOlaKbeQ4BlaVRpkGM8J9n1s408=;
        b=xp5F+2lZbO7fKF4bhzt5XD6ZfwDUA3B5kNq8mF2K25L8jhEatGqw9oz/+BTY4eNrTg
         1er4goG/n8CUG0kT5GAV1qhFqKKcm2XJ674bHvzjjkuH8r3tvN4N6ESQSpdF2Pa1lYsd
         8Sgf9AqTIQ2TScL2fu0xreF8mla7SFj/8QFHLiLCSXRjmbNq+5OQXwOPZzSWS9U0//3d
         V2WA13QJEWr+dnekZCx7GWD+Pg+cEXStlG+OK0VYND3O6gneOzDpJro/Lo6A3e//LhkN
         pVuGDhY3BWEkzTToC19aEwA48OuzdSds5jCc6Je1POxkG47H2SpEHKlin5R/wknpq+BK
         J5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723623253; x=1724228053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2MhE9T02qlicCXJIOlaKbeQ4BlaVRpkGM8J9n1s408=;
        b=hmM9n5K/udvoxX1y7khjZ5J0fPrUuGVQ07imRktZGwX0MtwVNllP/0b4yHSqm+cG1v
         1ja/T7hdGZyGt/OfapP4fFrk+bnu/2wieYkELSDhigBXtvnAt9zTHc3HtcmniMukk2Qg
         sklzblfbOP4InlniW8Th6eVrNEBKT/Ma3yORlAmiC9tkoZ9fPGgkeKh7jKXtrHvK7xrP
         perKCMRB+PiBMrMPmgMo2Sjr5MPtew02Z3lfg71sTiOqXQKiGQyhUQwkknz33dBuqXXr
         FZb7QVi2ys1pMKO5A6IP3GcHlrdVdLjHLif3IDsEBobRpEO83PUXQhk3in7WYlSBEgtw
         UMHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbei57ucMTTMiFeFYwDmzT6pnk29ORgFilp4z0cBPTR6g+izgi17C5C2UwuOcjkThO/vUJISlDv6VeRO1h7ggOymPuFMMIQpZdx6db
X-Gm-Message-State: AOJu0YxjCNYbbytcfrhn9Mco8mJ1GTTwhwfR8jO0+RG9ejJiJmYOxg9x
	1GcJAr4I1NtprtJH9Fd9p+DT84Y+Ofq3EBJUVERzIUd+f8iDnN+Rzh+8817rDi8=
X-Google-Smtp-Source: AGHT+IHpolfM6NNB/HEnomjj8UK5buQ67rajgbPrjTUUH7umLau21LMSc1FmvzG4ylSy6BwkNA6bow==
X-Received: by 2002:a5d:64ec:0:b0:369:b842:5065 with SMTP id ffacd0b85a97d-371777de9b8mr1845068f8f.41.1723623252726;
        Wed, 14 Aug 2024 01:14:12 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd374bsm12132027f8f.109.2024.08.14.01.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:14:12 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] btrfs: send: Fix grammar in comments
Date: Wed, 14 Aug 2024 10:13:29 +0200
Message-ID: <20240814081328.156202-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/a/an and s/then/than

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/btrfs/send.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 4ca711a773ef..02686e82eb9b 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -62,7 +62,7 @@ struct fs_path {
 		/*
 		 * Average path length does not exceed 200 bytes, we'll have
 		 * better packing in the slab and higher chance to satisfy
-		 * a allocation later during send.
+		 * an allocation later during send.
 		 */
 		char pad[256];
 	};
@@ -1136,7 +1136,7 @@ static int iterate_dir_item(struct btrfs_root *root, struct btrfs_path *path,
 	/*
 	 * Start with a small buffer (1 page). If later we end up needing more
 	 * space, which can happen for xattrs on a fs with a leaf size greater
-	 * then the page size, attempt to increase the buffer. Typically xattr
+	 * than the page size, attempt to increase the buffer. Typically xattr
 	 * values are small.
 	 */
 	buf_len = PATH_MAX;
-- 
2.46.0


