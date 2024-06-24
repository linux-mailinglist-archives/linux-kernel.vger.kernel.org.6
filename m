Return-Path: <linux-kernel+bounces-227718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC4E9155D3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104991F2224B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3161A00DF;
	Mon, 24 Jun 2024 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jxty3GNU"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC9D1A01AD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251388; cv=none; b=vE+h15vbUo2diBYJpotEHEnWiXVxGhGAXT9nccl6EzNlNPo2uInbcqxDPfaUMPnXDeMbleFAxB0iRep2LlKl20VY8il5HvCgG+b87FFOdE+w1ihK/jz2utTRxjGL/+mN8KxlkNMVdopbeQFHbwLP+LP4dRCgE/zc9Cx7gRuIfNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251388; c=relaxed/simple;
	bh=Ssjb3Uo4Iut5+I8dmIRqobRAiZrYRNHEz6Ht7+Uda/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tm8XbFvWGV1ciJ9J8DZbcnwV44EofzjbrEQRo/zQviTLWzabw/n36l9+3RJr2lvMQzgiQKC2jStyuj7AxWxJONe9ZnM+KyryxYOYBcm6xZQy4VjTPg78f9+1GdncR5k1wCmfbL/L2u3mhHyyrdRUpkO1DR3IRPPdv6fPDp4N8Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jxty3GNU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70673c32118so1251892b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719251387; x=1719856187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mkH0vN6ua6Gjn09ocrkAPIaM9p5reMjO+llNAon/y1w=;
        b=Jxty3GNUstZno9Rk3yheQPkMBR+REAhEfAw+VNBSFIES4+WADq0rT2AZz3F/k7pT6s
         qebyO9pSmqklShva0U1kKBS31nFsfLqUuwFUww9+yztmDs+GckIaNCx4RQj9WzZnkC3C
         c1jrKFbX+NaKGjavM2WcFdNGvcyiarIoYPxZVRuiQZ1bjds+2BNxpUn7bD0ohfvTBmia
         xqT5GOrf3aqRCW6tltPQQR1YgN4dwBa3jfHISTh6s5gW7JhVYyZNeKFHqm4M4lV6IpSi
         NWNqJj6nXiHD+m1mFmlmDN5LmX10PmMTCahfa8gjm3cRSknQ76feh2x7CQzusBCaAKOr
         6weQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719251387; x=1719856187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mkH0vN6ua6Gjn09ocrkAPIaM9p5reMjO+llNAon/y1w=;
        b=S01U4RpWU0W3YUkMLVB9F4PDSJxv3+EL6Acc3te+w+/kb5/pPu2IBN1QuHJ0faraSh
         NA5OuzOxAT5W1NOwjP2TWXDb7UI9C5KT60iZvySTRBTPz6Q8kgiPUjMm01NCnp78nGXl
         NQ3OCk00H3YZ/6q4H322K3JY5eXz7F6ACPkKuPd57EU0ipXwPMN2O9MLXyjqSvcGZ49t
         ZvcdDLdrTDJenoEM/ACJzmyKRRkzycP0wdPLyAmH01Dtjk3zPy/OGNLNlpKvsLN5TrpZ
         bcaDSILrctxHT7cWXsMi+Jq998BYl7OmsureeFbfrHvG/tKSjKIx4LzC6w/g4JZd5rYc
         rqOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSatxa+H39QDm3KUzjlIzaeEngX2HaedwdWecsirxEs9ui8jCT5RPjJBfzTzkAnPVALPR8L1hWq5KLI/k/0UgJ/7AXOMXVZcpVbQiS
X-Gm-Message-State: AOJu0Yw0QXlvk0SUwrLQNOR54om4LkVORQPT1aLXr9g9dQJ9iWUEEYwP
	W5e6CsbqgqPnoHP+0zotN14sxFpvUh1xmV1wXkzQwcFk//UFExdp
X-Google-Smtp-Source: AGHT+IH+svNIq4Zyd95MOOzrn+9RVplI0PwbRSAbMW2J6ZziscrSXG44QMEcN53Xd1+ghzGSLAAj8Q==
X-Received: by 2002:aa7:82c2:0:b0:706:6f39:1d63 with SMTP id d2e1a72fcca58-70674690fb3mr3975274b3a.22.1719251386616;
        Mon, 24 Jun 2024 10:49:46 -0700 (PDT)
Received: from localhost.localdomain ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065130078dsm6487825b3a.204.2024.06.24.10.49.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Jun 2024 10:49:46 -0700 (PDT)
From: yskelg@gmail.com
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Austin Kim <austindh.kim@gmail.com>,
	MichelleJin <shjy180909@gmail.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH RESEND v2] tools/virtio: creating pipe assertion in vringh_test
Date: Tue, 25 Jun 2024 02:49:06 +0900
Message-ID: <20240624174905.27980-2-yskelg@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

parallel_test() function in vringh_test needs to verify
the creation of the guest/host pipe.

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 tools/virtio/vringh_test.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 98ff808d6f0c..43d3a6aa1dcf 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -139,7 +139,7 @@ static int parallel_test(u64 features,
 			 bool fast_vringh)
 {
 	void *host_map, *guest_map;
-	int fd, mapsize, to_guest[2], to_host[2];
+	int pipe_ret, fd, mapsize, to_guest[2], to_host[2];
 	unsigned long xfers = 0, notifies = 0, receives = 0;
 	unsigned int first_cpu, last_cpu;
 	cpu_set_t cpu_set;
@@ -161,8 +161,11 @@ static int parallel_test(u64 features,
 	host_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
 	guest_map = mmap(NULL, mapsize, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
 
-	pipe(to_guest);
-	pipe(to_host);
+	pipe_ret = pipe(to_guest);
+	assert(!pipe_ret);
+
+	pipe_ret = pipe(to_host);
+	assert(!pipe_ret);
 
 	CPU_ZERO(&cpu_set);
 	find_cpus(&first_cpu, &last_cpu);
-- 
2.45.2


