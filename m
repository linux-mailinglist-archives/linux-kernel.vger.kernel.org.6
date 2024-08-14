Return-Path: <linux-kernel+bounces-286226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B690595183E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A6B284A92
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384CB1AD9D0;
	Wed, 14 Aug 2024 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="iguUNddu"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F117E13635F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629749; cv=none; b=gIaql8WW/F4lfzwtddWaU27ysIm32E0MS87G4mpG6JK63M7wYKFQJWSuNMhWLoiT+4EiXPlHpZBx40f7CRZZnB7DEQzyUH0PM8Q7922CL6hwirLn2smbOsiCvLfsZU67SoWfJSr4FKFIq07jkUFfuyzWOaHBpa0UTLxvZWCcSzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629749; c=relaxed/simple;
	bh=B9chU9/0IqlL3225+x+s8qqL6sC8onowYFoFyMPszRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KBCHkJ2AnYv9+fqQtq+lm9WoNVNnu9JYBNi+3iPDXtqC2lRMsMQuAXXTRAArt4mYTX+Gk9ceSc2RAz+Tgap2vJfnfF+Pc7YMp7aP4dSXBHStHPjxMQYxp/qngaq6lSnnm+a//QK3peKTWtSe/KkFShTpiupO2qnFwkIZ6xz2xuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=iguUNddu; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f04150796so8449273e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723629746; x=1724234546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AUYn6IRli+oEs6D+KJzXe5DntEafYq0okHoLDQr377w=;
        b=iguUNddubuTOcADFjRDMjmhqiIw4byzMdL8EOCNRL+UNfDJdON15yEDyY/QOtQW9LK
         AXCq53MJyUt5AjMGgUZK9xZYjyqr+OQc/5p5X8HWWR41FnyM4AknLAJNHsFfKUAYb1Xh
         KflmdPFguxbfYcAi8j3B9Pwo12KqfMqKWotwhikq/ev8B3AbKk9WSLShgYM7U7WoziOl
         PmlLDB9cGvsVK+BpP5NEQnJ2I9xDzkRu2L1k9Bb1Y8PWDqqemOeU/KulnzTWAq3jgQ9o
         UscD9n27g5NEewmy29r0I1ME8ZaEhn5oQ5GMdTjxM7ZYmq+xmR4qZ0J8v05Qc4VRyqcE
         63Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723629746; x=1724234546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUYn6IRli+oEs6D+KJzXe5DntEafYq0okHoLDQr377w=;
        b=gshkEDf3NxhAKaXbEd1/GGho3ZuLsAcicNMmMzPpPQ/Tb77HfbV1NllvXl//D1n7jl
         VqnQZ4/jJsuUJBAYymTUyqJR4JFWdeFjqiD8WcB8iOW2Xah4N2njK3htUUvlD08f9iuN
         mjutRv2rJWR2NFD1QsIGggAA1qJYdjwQJBEXhpO+Br7576V3yFkHt0LLstd3ODtbv3EM
         QotgFvpQ7i84ugomoiiq5o/mo4Ar3T3TLfgzzLXOUtsibTLDTr8kR723ohRuwlAsIO2H
         /pxfpp9ro4crDCTJaVH7eJp1W+TnnVRYjWhTB7N2QtTw45sfdLvNxzwK1RubVaz/x79u
         omgw==
X-Forwarded-Encrypted: i=1; AJvYcCWJlhiRxHwdo6Iaa9AbMtp7bD69lfROwaCEIEhI1kvipjh1gy6edlZS4oz+E+pEaJR2k96j0xOPm4qql3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHklqQuY42TtXZI+Ow8mAYuOONnsXK47w/y9Fm3ovOJMHQATCX
	E39B4gb/Zh7/sRh5qbNYgJ+Bb/e5yC17pxLlLnP+0iMztvydUs2ALSgP8e43gFs=
X-Google-Smtp-Source: AGHT+IHFhOyBeGlUxBjzud5WmiYxl1tBaGcj9uLfsenvP9y/8nDQ71mcGv06eIx0V5n8Cud7drQVcQ==
X-Received: by 2002:a05:6512:3195:b0:52e:a699:2c8c with SMTP id 2adb3069b0e04-532edbad9c8mr1393454e87.45.1723629745529;
        Wed, 14 Aug 2024 03:02:25 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd3631sm12364660f8f.110.2024.08.14.03.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 03:02:25 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] nfs: Annotate struct nfs_cache_array with __counted_by()
Date: Wed, 14 Aug 2024 12:01:28 +0200
Message-ID: <20240814100128.157057-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
array to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Increment size before adding a new struct to the array.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/nfs/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 4cb97ef41350..492cffd9d3d8 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -151,7 +151,7 @@ struct nfs_cache_array {
 	unsigned char folio_full : 1,
 		      folio_is_eof : 1,
 		      cookies_are_ordered : 1;
-	struct nfs_cache_array_entry array[];
+	struct nfs_cache_array_entry array[] __counted_by(size);
 };
 
 struct nfs_readdir_descriptor {
@@ -328,7 +328,8 @@ static int nfs_readdir_folio_array_append(struct folio *folio,
 		goto out;
 	}
 
-	cache_entry = &array->array[array->size];
+	array->size++;
+	cache_entry = &array->array[array->size - 1];
 	cache_entry->cookie = array->last_cookie;
 	cache_entry->ino = entry->ino;
 	cache_entry->d_type = entry->d_type;
@@ -337,7 +338,6 @@ static int nfs_readdir_folio_array_append(struct folio *folio,
 	array->last_cookie = entry->cookie;
 	if (array->last_cookie <= cache_entry->cookie)
 		array->cookies_are_ordered = 0;
-	array->size++;
 	if (entry->eof != 0)
 		nfs_readdir_array_set_eof(array);
 out:
-- 
2.46.0


