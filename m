Return-Path: <linux-kernel+bounces-562227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42523A61F63
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D837AFFDC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D576920485B;
	Fri, 14 Mar 2025 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="bnRMVnrH"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47AA205518
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988543; cv=none; b=BqED92fl2LfQDbd+BQ1uZ2jMAPMe87sbeZ2EXj9Jhh/8FpQKl0HQ+Vz4AGKnKmRnfW5DMoMC8FuVwWnINZ8ZzYbc2UeMME7eXv1wzsnc3ef5tIQNoF77+WG81bnxddx5B5ISA46Dr3ZCVegkebQp9wHb7GfnA3qjd7C56bH2EWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988543; c=relaxed/simple;
	bh=uGg8JXJSXC6XUKko3vtFo3VClaWGJcePp4VmFBAeI6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pQGzMsiKkHlDWo/Vn2NqpyzxPGGjnrmNcPgQ7smeh3xmJvAPeU/72ToRVGr/dyLqE+SxP6bAZTEIzqCZ+9aa4mFFzeUywi+Chf7FRdBOEtzzUIkM5Qq0Kozm7IoqPZ+3xfz7qmpXXzFpf4cHci6phMqtQK/2ZHUQ4FX6hc2gGes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=bnRMVnrH; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 508673F887
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741988537;
	bh=lY70/mS/r8Et37CQTVQ0HZOmZvOsgWjqVKwtQtIRegA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=bnRMVnrHpkuZy0uBKHS7xSxt54T1zHlKo+wkcSAZMo3Yvkv18sL64uMKWGyWJS5EF
	 1RpKFobHtqPoBaNYOi5lL4qwdlxmoOliEps4eSZ2s0aerCkmxNyVdPDYwxJ4HmXqgu
	 fA19bMdJdWmBgylmL1MCjKhVd8uogfiVOLuq5MrPFT7YV1T/BphsrCtnXYtLBKM49Q
	 fGMJdpjO2DHRxAfU/bS+2dI/4W9s7HC55MnWOeOsp5FLuXyHEaNvfEw61kYJxA1AgA
	 hucKY96S8T0CMCFSlPIrBHch6odkYRfRIE+hZrGUCuXARWNaHQUJNyczjqrmhzQeZE
	 TpkaddyLarMbQ==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac2840b1ee8so256827966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741988533; x=1742593333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lY70/mS/r8Et37CQTVQ0HZOmZvOsgWjqVKwtQtIRegA=;
        b=dAz7V4ntJILsfQarvlhePpghgxLzknABXr5/Ct1WhmGQgW3XURRxUOMhRoffBSZ+8U
         GYHLtGcQ8DdmKi2ZTeVtMq7lpFBiDtoybgJry4BH/HzCQuZ3nJh+sRWa/ZsjWgeb+YyQ
         mvkQNpxj5aiccHRLQg2tDeIdj5ARskDZ5udfpQHRSu/0M5+BM56p1P/5Y0dmGvX4nFKJ
         GFNHhFxZdikXSegoCoagoG61dpUUoK3KgEP69JdJwlU/MUlFmfUHnautImaBkhRjHDET
         M2rUeZV5qp1CCdwKWWhkqfeaPW/gqxc/WCdBkA/cfii7es71iJPHGcGRxS7/oK2AoRT+
         Uc5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUOISC0maXFMr1Fwqyy3vBZWQT1PzCGJ6hQCOLGcxQtEjTzkLSnk9G3QyPVmHd+BqHn3x8BKAxsZjevGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRlouSiOOND7u9GCMSzj3Xm/kgLiF6p8KvPxT55PQcS2NR2EIc
	JAkBgyswaXgBKboByQ9mgMBZfzoSKAdzydhZ0634WjoC1eNOQekl0oXY7M/jOqrkiF60JEvrkEU
	mU+CztMccmDvKVoz347NfGhlPAmFIaLLuv/6ooZLrkltyKr3TojGs64xyzhxHbSM1FkUPanjw1B
	EkKg==
X-Gm-Gg: ASbGncvy0DrAJm2MSKe+7nz+usYiQhoDpPadhubIA7bYahGXyj9OGRQzaoxVBTRZ6Px
	7BQlbkHMQPQqdDmAUP89Yv8guXJG1jlfkY3GMIoCIeo5K2iv8hYyilu/6BxTABEhHa5ZsDcNPuf
	fKbevcqC9NCti6X18OCRzU1ryIVOeX9NbuwR9WnWJUsJWTZaPExraOcvOIbHrrDxRwJYM86clUK
	FOdRaOiKVA5rPj2YNUtBB183LzFWGN2O0UAThbjs2dytjqrMUTTpAE0YWCR7CHZF9dAXocjAYOT
	+bB2yNELqCM1Jnqqt3Zm1q2QqNPq0pwxrw7cFO8YfPZbSlwF2w==
X-Received: by 2002:a17:907:2ce3:b0:ac1:db49:99b7 with SMTP id a640c23a62f3a-ac33041a398mr452869366b.51.1741988532709;
        Fri, 14 Mar 2025 14:42:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYZ/shXBTmdAZ4tudDMccFXpts+ICQBG5lI5HLvE8Waomrj9sbmxYGzKr+xsBq7Krj4ozlDQ==
X-Received: by 2002:a17:907:2ce3:b0:ac1:db49:99b7 with SMTP id a640c23a62f3a-ac33041a398mr452867966b.51.1741988532379;
        Fri, 14 Mar 2025 14:42:12 -0700 (PDT)
Received: from localhost.localdomain ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314aa6083sm272732866b.182.2025.03.14.14.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:42:11 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@amazon.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Anna Emese Nyiri <annaemesenyiri@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] tools headers: Sync uapi/asm-generic/socket.h with the kernel sources
Date: Fri, 14 Mar 2025 22:41:54 +0100
Message-ID: <20250314214155.16046-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This also fixes a wrong definitions for SCM_TS_OPT_ID & SO_RCVPRIORITY.

Accidentally found while working on another patchset.

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>
Cc: Anna Emese Nyiri <annaemesenyiri@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Fixes: a89568e9be75 ("selftests: txtimestamp: add SCM_TS_OPT_ID test")
Fixes: e45469e594b2 ("sock: Introduce SO_RCVPRIORITY socket option")
Link: https://lore.kernel.org/netdev/20250314195257.34854-1-kuniyu@amazon.com/
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 tools/include/uapi/asm-generic/socket.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi/asm-generic/socket.h
index ffff554a5230..aa5016ff3d91 100644
--- a/tools/include/uapi/asm-generic/socket.h
+++ b/tools/include/uapi/asm-generic/socket.h
@@ -119,14 +119,31 @@
 
 #define SO_DETACH_REUSEPORT_BPF 68
 
+#define SO_PREFER_BUSY_POLL	69
+#define SO_BUSY_POLL_BUDGET	70
+
+#define SO_NETNS_COOKIE		71
+
+#define SO_BUF_LOCK		72
+
+#define SO_RESERVE_MEM		73
+
+#define SO_TXREHASH		74
+
 #define SO_RCVMARK		75
 
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
-#define SCM_TS_OPT_ID		78
+#define SO_DEVMEM_LINEAR	78
+#define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
+#define SO_DEVMEM_DMABUF	79
+#define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
+#define SO_DEVMEM_DONTNEED	80
+
+#define SCM_TS_OPT_ID		81
 
-#define SO_RCVPRIORITY		79
+#define SO_RCVPRIORITY		82
 
 #if !defined(__KERNEL__)
 
-- 
2.43.0


