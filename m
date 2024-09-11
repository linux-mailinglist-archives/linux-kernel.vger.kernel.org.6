Return-Path: <linux-kernel+bounces-324635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0C0974F0C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A4E1F23401
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3B41714DD;
	Wed, 11 Sep 2024 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="lieWKF6o"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF3B153BC7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726048275; cv=none; b=GEQNRKVnnsUqXjkU65zGSA9JaT2lBV6hAIuNwzhxAyEDfwMNlpTJYToS1cLZPmsNDVKACsNYvlbdx1qCOzE8pGnjo9PxPBphpAGOlraHoWFm/iyouqiJVfYpIPGPDIBD6+dRdLbyjQfd74QrD8QpJqdHdei/Fm0BFsaoYJPIa1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726048275; c=relaxed/simple;
	bh=1n26lJVGMiLg05vOSHdjrs2N4Bmqwmjut/g74vzpS0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q9+KLAUPCbH+Bz/YJMG+NjPW6dIAi2ll4vZrIg9p5fDmvVFyDi65+dSuroRxXT2oS+D4GmvoEB5tqquvRkUP0JzMzbOd2rLRnVZWpb15qFZL/VJXCuoy49HdsAXLIR9vLaaw0PWnX6bJph2xcocyxkFvUY9/jGca80Wo2wQ/j/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=lieWKF6o; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c4ea1d75so250299f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1726048271; x=1726653071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g5ZvFx5/tVz8m9WGczcHivu63oPLiy1OCN15vLkdZLY=;
        b=lieWKF6oFujXCGDzm+97+xedNO2rqNwvnvIedKnQmhEFTDU2rDHqapGLOqiZ6j2BhA
         tPOLga5UEe1/0bvPZ19jKhmd2XbiWugWue1A1c01SjHMkM28i+2S9+qmyfCDyFn/TxQG
         boqeEA6kwgBcrrTzHAKWNQCSZx0pmtrd95ihc8u0AgKAUg5xuCd4aL5oc8apB1WlKLhO
         U/dg07z8ldzRSvz5j5vQjYeOpWX2dKemjp7lK1V3voHck3IHvBoKMd0m5ztFOnas9puI
         aErkyGtOF/VzZyDjlGl4Fi3j8a67cmAEomrDF8pmsgMilcfPuRPKbDxb9zYiHMTfm3Dv
         L/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726048271; x=1726653071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5ZvFx5/tVz8m9WGczcHivu63oPLiy1OCN15vLkdZLY=;
        b=d0SAH4EMaECLilNHvjQ3ltRt70uPoaz00cfMkVARBCgm93atRlZSrRAfwA46C4d/eq
         PQGsmMxr7wded6SRklaLA57owXhAdQKfTr1PXc8dZ8x5s/dqvuZqgeXyKrxSaq78firf
         XLW0FVJ+T+FYuDFXHJwRSd0V1lCuTp6D3pN5EIfaCcPYmcE8IvkUO40Vl2+CFK3c/TO3
         5u/fBJ2lriJOkqo6PvNTCGKoXHGwhadEyRecpWuju/HZxpzSrILld+pzPw2ZEIS738SX
         2VYNV8fMK6Zuumb4ZURgW+O/3TloeBAj03Xqo5T6zsHa/BpjHO/rcJd6tTk9KxA7ev6R
         GG2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8sOKaDw5MUCKTHgbs3mrUn+me1UFf8wvaJIUTPJyQEvlRNcFwJ9GgSGBjkWdA5ybtOYXtLmOZ17w471E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywix20wLSv1JrrWr1OtMi0yTzuBc2Q6kg3SpSXw+M1UemDtGkPk
	2aqiQfYz/j0cKRGF3veCoAPq5YSzrnE76Ej0tUx2rw6LrGhA2c4WD9XEYh/adeg=
X-Google-Smtp-Source: AGHT+IHPQay7WgwnSJWTGv8uQQnmjGBlCcXp736iTL36hiK3djZ3UYR7aVxnW8cayK2eV02YzZj7hA==
X-Received: by 2002:a05:6000:18ad:b0:374:bfd1:a786 with SMTP id ffacd0b85a97d-378895de490mr5629324f8f.4.1726048270927;
        Wed, 11 Sep 2024 02:51:10 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-245.dynamic.mnet-online.de. [62.216.208.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de152sm11017775f8f.103.2024.09.11.02.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 02:51:10 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: dhowells@redhat.com,
	marc.dionne@auristor.com
Cc: linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] afs: Remove unused struct and function prototype
Date: Wed, 11 Sep 2024 11:50:47 +0200
Message-ID: <20240911095046.3749-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct afs_address_list and the function prototype
afs_put_address_list() are not used anymore and can be removed. Remove
them.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/afs/afs_vl.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/afs/afs_vl.h b/fs/afs/afs_vl.h
index 9c65ffb8a523..a06296c8827d 100644
--- a/fs/afs/afs_vl.h
+++ b/fs/afs/afs_vl.h
@@ -134,13 +134,4 @@ struct afs_uvldbentry__xdr {
 	__be32			spares9;
 };
 
-struct afs_address_list {
-	refcount_t		usage;
-	unsigned int		version;
-	unsigned int		nr_addrs;
-	struct sockaddr_rxrpc	addrs[];
-};
-
-extern void afs_put_address_list(struct afs_address_list *alist);
-
 #endif /* AFS_VL_H */
-- 
2.46.0


