Return-Path: <linux-kernel+bounces-307241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D27D964AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7211F243A9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF86F1B4C44;
	Thu, 29 Aug 2024 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="yTb/OPZQ"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2BC1B3B1D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946683; cv=none; b=UqAvRiHeVIIBJYg4W6dFAos4CruU2JwUyrQ6F3bfP0RGxykFB4Fty3TqzmKKaTmcm5ojbiuhLuGfhHCDStjirwMz7E+u1O5bXdaTuKsY6Obu4IVoXLEhDeGtwoPRIToLNfl86cd9RbTbQYj2IZanynkUyNqZUvhLsDs4CRaa5z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946683; c=relaxed/simple;
	bh=nDu/Qung/abakY0tFCNkQeANmw4UpVnF+Ix+JtUHdCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z/92hfzc2fjg3K0y+16qPaJ7Zi/SC1Qjxms4JBricnrTjGf3YSJKAIngTGsesNDnnzCfYRR6qOYbHTv8lMPD4UtHOJJpsdWOviMuFWeWl+cPDcaRE05ovLOHjzEfn5LyAiEm73OFfwgsXesjsCtd4vM4jy1pWtN5L7ECCVa8tS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=yTb/OPZQ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bec4c3ace4so139336a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724946680; x=1725551480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wo6F4DAHD7vgQXQVkup216t7O3I64JdYrUKFA8taWwo=;
        b=yTb/OPZQx3azJrRxWbt+GZ5PVpR5qAMb2CcLctm+T79XWMm7v1DzzfddyLZq4CbupS
         qKuk5fHI3MQuTJwJ0+FM0HX4F3+MJAOQi7NEkqUoOhwBF0jacn7knLnUfzF/ntxWirS6
         fTTsj9ecgheV4Wrfm6Buqr7KZH8jK7NpVXybixz68jlyELHpWdWao6+kvGNguHpmsb/m
         M85KtiVHzugaY6ZmQmqICp3nv/Enl3M75lBw9pk2GebH05A10S3x1sOyJTjtE7OwtKBk
         nZwg9pCk+XODwjVYC/z9AB5jIORwbStI6HyCHAN1AMggyYvOD4tgr9j4cXP090J9At6/
         BWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724946680; x=1725551480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wo6F4DAHD7vgQXQVkup216t7O3I64JdYrUKFA8taWwo=;
        b=ktEcpWjDW5gsjpR9XU1TZ50BA4c2xCp+AdvhWxte+lemWCSuJ+kC+VAqSha2tBWVq5
         E77DEwUXQIfHBC7DmNUem0Q/J75TMMzDESzSXLdFhpNoFYLzACncFtuRU9qdNxukkxnY
         g3Hma6toHHga2TuLLteieoz36Pb9lT4xRMseIzQoy7qwtOoVW3QXzVGQwoJXxE+BdDI4
         oi+USIarSGe93ywl2e2UpMp8dEsJzn2RpMPbiHSxxkJnKEoyH88WyWe57BXLTWF/hd8G
         KgTo/D9iddBP1NFFTdTcFR4YjAm7reRtlZuJdwraJc6Y5uQyQU5B9fT9zlhH5zW7m99X
         yVgA==
X-Forwarded-Encrypted: i=1; AJvYcCW7sAYg+oDQq0EfqJDhcoaplyxYGl+5lUDjpviLw/nJqr/0QShpehpg7A+D6AtNkTTVHqT3c8HrFUKXD5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaT8CYnr5xvYMyl6idWIakrFjrwBlpazpbdL8+oe/qnLJwklnv
	HIMowteA6c5Ju1Gu0YrJ7Bk7fomaglqaS78WMIX52ATJKb6rDeSv40MJNa7t+RA=
X-Google-Smtp-Source: AGHT+IG7mYT+8MRbo4XobdrNXyXcPtZnp88K8wVmpVeqCVOOISsvXievrKS52UYHHKj057dSJAGNLQ==
X-Received: by 2002:a05:6402:26d4:b0:5a2:7cfe:2371 with SMTP id 4fb4d7f45d1cf-5c21ed8e6b1mr1903574a12.3.1724946680192;
        Thu, 29 Aug 2024 08:51:20 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89892223dbsm92288866b.202.2024.08.29.08.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 08:51:19 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: kent.overstreet@linux.dev
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] bcachefs: Remove duplicate included headers
Date: Thu, 29 Aug 2024 17:49:50 +0200
Message-ID: <20240829154949.109402-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files dirent_format.h and disk_groups_format.h are included
twice. Remove the redundant includes and the following warnings reported
by make includecheck:

  disk_groups_format.h is included more than once
  dirent_format.h is included more than once

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/bcachefs/bcachefs_format.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
index 14ce726bf5a3..b97fd0f75831 100644
--- a/fs/bcachefs/bcachefs_format.h
+++ b/fs/bcachefs/bcachefs_format.h
@@ -499,8 +499,6 @@ struct bch_sb_field {
 #include "disk_groups_format.h"
 #include "extents_format.h"
 #include "ec_format.h"
-#include "dirent_format.h"
-#include "disk_groups_format.h"
 #include "inode_format.h"
 #include "journal_seq_blacklist_format.h"
 #include "logged_ops_format.h"
-- 
2.46.0


