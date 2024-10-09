Return-Path: <linux-kernel+bounces-357737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F369974F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB701F2419D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F751E04B5;
	Wed,  9 Oct 2024 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdT4ik0x"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A8E381C4
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728498936; cv=none; b=iaOqegSD64nys9zlJuXFLdOc36shjOIVN6CDZbn7/aY8kdiq6NQVHb3h4m7DhRufxDi4vdUBHxM95Oks5WU+LZm7WLXXhIA8KssmK63847entJqDOMKkHpg8E1SGCAosDXeYwMtJkhbMXI6/D3/YUiJ0gfawMn3SC/BUIpESy3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728498936; c=relaxed/simple;
	bh=hX6Rk0pD8i1kyG4mLW4K9/JgFzULy4r9N49R0z3uRLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jk4cIrK84jzin+CM0yoIob/YgaVPY41RMPCVZkYMfpVgRAYP3M1kbU8Kfp0GXFjlw7741dT3ZgiMRfyhT+Ix+JhBELHrwQilr/xMvW8b4sEhE/6HTexV80UdMZ6aHAkbPqjyXv5+5IOvrY6UrGlvTmr3S1SrNFc/WnMl41H0s60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdT4ik0x; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71dfccba177so1065136b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 11:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728498934; x=1729103734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2unDtTcWJL9ezSqoacHJfSttGJoxKnTLruOZrgmrfKY=;
        b=kdT4ik0xiLOpcorU1efG0yav+34KuuxSi6RobRCMOsW6R0CnoIGlqFOGK7dwgLJ+RM
         DlII2ymoyLjBn0rb0U/8tmDcvXpMTKUKNPhUfBnHaV/OwvA1ncLBQkg/e6jXJAggncNY
         gOI0e3hCKtZlrARbyYlKS2BWAjC9kNZ/4NM3Ls2fovIzIJoL69PI4CTCG+iUrvkTTjwr
         CMJnghu5h2n8w5hPBepT8+hT9eBvCMT6vC4TUm+gvc9SS6zEKzCU1Us6ZMNjAtmPx6ON
         Ndq8g/C/4SowGOcfbKrJdVV499vi6GGmqaMRI1do1rOWtjEMOWVWoPGyXmqhdCvY87qp
         MLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728498934; x=1729103734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2unDtTcWJL9ezSqoacHJfSttGJoxKnTLruOZrgmrfKY=;
        b=PW6Q/M1UmjEpA9ydNennincEOrvaCIR78JfkA8I3ndPXwkFOGc8i2WMQ+TP4KLR/tK
         eg1HXtxjHI9b57sey2AQZTYUPj6OVnh7NFiNkV3bKvr1D1FwvPRKjx0Djm2yP5Jr6qmb
         Ai0Q/1PeZu82NjK+ZjITwn70uQ61Isc10vaioZRYAGcadM9PI2gV2ymwgTaAWXZswRb6
         IlpajtWuA2zoD0198H+QLXNsy3qxavJlR1d8M3d+pm2JofrTiKLghlm/agW/T23jU5rg
         D6YzgOZXDp3ZEUjsOY2L7o2cGmkuKcpwGPztqAdbbvmxiO2t8a8ugS2vs7urm45v98Sb
         bgGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqkoACxav7qwh1rvDxGa6TCD3sjjgz0mdscczTLNp7uSQOifITiC14k6Z8mh8lhm7gKANTVOXymfRg9Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzapYhc4Eoj1c3kHe2M2vNjuXsV+smQEXfGMRKEqV9Dk9vk2tP3
	ApWjgmFP22Lr0myupngUuAZavH+K8Fmd06xbozHSHC6KbO1+bXiG
X-Google-Smtp-Source: AGHT+IHYTpHNp4eHuL/vO8mtzqUUk2g4i1XCswSOcJp6e4UCC4MPGni77acTd01MeBHFZ18BIcuIKQ==
X-Received: by 2002:a05:6a20:f29:b0:1d3:418a:e42 with SMTP id adf61e73a8af0-1d8ae0b83bdmr741716637.10.1728498934162;
        Wed, 09 Oct 2024 11:35:34 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.lan ([2409:40c0:11a4:8d8a:9f9f:e11c:1176:3e0d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd1f26sm8060358b3a.84.2024.10.09.11.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 11:35:33 -0700 (PDT)
From: SurajSonawane2415 <surajsonawane0215@gmail.com>
To: dhowells@redhat.com,
	marc.dionne@auristor.com
Cc: linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Suraj Sonawane <surajsonawane0215@gmail.com>
Subject: [PATCH] fs: afs: Fix uninit 'count' in afs_deliver_fs_get_capabilities
Date: Thu, 10 Oct 2024 00:05:19 +0530
Message-Id: <20241009183519.36651-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Suraj Sonawane <surajsonawane0215@gmail.com>

Fix the uninitialized symbol 'count' in the function
afs_deliver_fs_get_capabilities to resolve the error generated
with the smatch tool:

fs/afs/fsclient.c:1704 afs_deliver_fs_get_capabilities() error:
uninitialized symbol 'count'.

The error regarding the uninitialized count symbol in the
afs_deliver_fs_get_capabilities function arises due to the
control flow of the switch statement. Ensure that you
initialize count before its usage to avoid undefined behavior.

If unmarshall skips to cases 2 or 3, count remains
uninitialized and may contain a garbage value. This could lead
to errors flagged by static analysis tools like smatch.

By initializing count to zero, guarantee that it has a defined
value regardless of the control path taken, thereby enhancing
code reliability and preventing potential issues associated
with uninitialized variables.

Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
 fs/afs/fsclient.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 098fa034a..4ab41dcdb 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -1665,7 +1665,7 @@ int afs_fs_give_up_all_callbacks(struct afs_net *net, struct afs_server *server,
  */
 static int afs_deliver_fs_get_capabilities(struct afs_call *call)
 {
-	u32 count;
+	u32 count = 0;
 	int ret;
 
 	_enter("{%u,%zu}", call->unmarshall, iov_iter_count(call->iter));
-- 
2.34.1


