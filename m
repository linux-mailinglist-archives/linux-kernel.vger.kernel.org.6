Return-Path: <linux-kernel+bounces-295935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1913D95A338
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58221F22C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315451AF4CC;
	Wed, 21 Aug 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="EbBpEzXZ"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3646139597
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259264; cv=none; b=dKrjsAMrRTa/G48Rni8imh66PJ3pzMpmLy+8lsw0rw1cTfcsdOhtjKKF5qxxb8COvtGBH0HKoMXlHhU+8dr8mZkn3ozl8UJ0zEM7nKdgFEN0nW31LQHfXRxHdBL3Ealkuf13DFNMtCKzziTdpRBqVGlVtScuFaety4LEOhvpv1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259264; c=relaxed/simple;
	bh=1n26lJVGMiLg05vOSHdjrs2N4Bmqwmjut/g74vzpS0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQgvxvFdzKcX+Bf0WWORh24ZFHoNzkBDp7WUpL9Abf7iyknRtCgZgzEQBLl6ICGx7++O3rmgnj7k1ZkBPgRcxfLMRdBT5TxSdGRv3J3qH+pfjrDG/G3x9kE0bZ6Yz/JK9fh23eOfs3ZG4rjGxnJErkcWe5qu1v7zJBdBdw+9e/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=EbBpEzXZ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7ad1b1cb56so5827766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724259261; x=1724864061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g5ZvFx5/tVz8m9WGczcHivu63oPLiy1OCN15vLkdZLY=;
        b=EbBpEzXZ/tNk4uAAOrm5AKDiLQsoSouIhS2AJRiGc8LFp4p7+aFO9ruVI/a7FkMRR9
         eseQincuz0eoQXjTfxcM9lezTSebfevx4nkx/WYZLXpVlHIU7H5aYqqc/rEn/odOrtkK
         8HF9Zn9nRRf20HF+aVCZlfWHX9xGlbhFYdYyZH1wUwgxnAELfUpDabggP61Ka2416ecA
         1imR+1R3vazSfWAvmxGTr0/Old29uhgxjwLV610qbxqJwS4uEPiEZoQqFGW0cXe6Q1hm
         n4pyw3gL8n5LZmv8Jf1fVJz/whTv0GlqfJ6KQ0OvjoiHwfgVk577KsT6ezeof1yYKdBC
         xXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724259261; x=1724864061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5ZvFx5/tVz8m9WGczcHivu63oPLiy1OCN15vLkdZLY=;
        b=vleivvOWtwOgt8ImaYuqn6bMRU0nRxmJ5cYJeIhKAOdtY+vpJF4rlWfkUgWCMEdKMX
         HcsGJLQ+HSEtY3xzQA9wg1aru/qHBKmV/g6ATBBbeft8JGr6+enXtYaeGpdRKCFke7Mc
         iXqCOPZNI6GgRpJ6BB0Bj9dzRmH6lI+Ms2PpHxkwFPu4qVl1/3v8zjnBQWUQ6axYmyE9
         IDedh2ltt1dOsBeLVASukPkttGMG8QH5qTtZkBEcrfMlMpeCx7uIdCvE3WCIPcjljTxZ
         47UTJlkgiQ2eSTJ2gxLN8NRzbNUI7f6WWlQF2KmRybRWX+6Fvk4TEEY0gwstukwTWUok
         eDtw==
X-Forwarded-Encrypted: i=1; AJvYcCWBALONwx0hfed/evRpFxxoRD5O1ix86tiZuvTx5xtV7sqWOdcknOtCFaAxVe9jAk313/m7+9B0zwKc9rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAf3V6V2IHrU1XDpFSeYYrYBryav8bSNWNUAbIGAwn/K0XTwK4
	CP0FDYnsNFNAIe8wJE20iKpEtmxT5xd4kN2CiycctCbRJi/z0KKcsYHl7TFB1HY=
X-Google-Smtp-Source: AGHT+IFN3yNOqLzOWg4YlQmj6JR2yzYSiPxpzAv7QxWZFvx/RsmDsKWPK7uYJqMLx0Yphkf7cT9aQQ==
X-Received: by 2002:a17:907:7e82:b0:a7a:87b3:722f with SMTP id a640c23a62f3a-a866f2a0046mr127398066b.3.1724259261153;
        Wed, 21 Aug 2024 09:54:21 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86815984d1sm58889566b.118.2024.08.21.09.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:54:20 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: dhowells@redhat.com,
	marc.dionne@auristor.com
Cc: linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] afs: Remove unused struct and function prototype
Date: Wed, 21 Aug 2024 18:53:49 +0200
Message-ID: <20240821165348.87372-2-thorsten.blum@toblux.com>
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


