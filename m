Return-Path: <linux-kernel+bounces-553112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F5DA583FC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C0B1891AE3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 12:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB161D5AAD;
	Sun,  9 Mar 2025 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="q614rjf/"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3C717A2E3
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741522558; cv=none; b=sIIj7cepMatl4If3PpV37a8Qna6QETfuWtdOtO6hfz+KBIiNqchcbKEnZQICjje9CsFirp28jjsgcrfDor13srwO8PzGqirxBGVhIDADWe0ohiwmHFPQYIHSdL9Ch740gY1HuqIUGL3jopBfZgjvc2J6Fv4qIA5xn5VaomgqJjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741522558; c=relaxed/simple;
	bh=tg28/9hanaFbrmazqnyGo9rUsvy3BxgiFLHrwpc0Hds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WhP+oiD4z80d5cgCIJRMjjCQh8WmVy1SMpB1ID3zP558SsE4tTAtGI+oq6K0NXOqBRxl6T/7GQb3PwOZvYuy+LBocp49JRXrA9fefkmFS7mig7EgGpd2Hj7X/yH5HnL+RR1u0x5fKFskBkxJbHFvemK6Oux/NlS+tM77EcKrkLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=q614rjf/; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AE4CE3F849
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 12:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741522547;
	bh=7oajGXmwoZ14RjsiUyyOZit7FlCk8P+EMjDV4rSKNPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=q614rjf/GR05v7Dah5LZVVGfDb7Bb6OE3Ot5+F+HVVXrf6ZM3G/0R+cyNGS47c238
	 0FKZxq6kpaiH5a/Bu3zY8itD1TM2d88DSsa71kRHLzJ1GsDizT+TDX1tyii74Zw9uU
	 i6yN4lx7OM/06P02Mk3AyHpu6Ri8GWS3eUTrtX3cBpjL7fPfNCTQhmHSG25/sJNY+P
	 xMRnM0A5mpkqL47htD66QVk3ZWY1oDw+sSIFK9PO5NUR8Ty2/FK4+ivjMnlyav5KWT
	 Y/u9KXaCFHoWX6B64Uo15x634syrPc+h6UzpT3aH2AvUyn08hXR+Pfubqc6k1Luh20
	 nVPf0Muyah2oA==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac287f284f8so36253066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 05:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741522546; x=1742127346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7oajGXmwoZ14RjsiUyyOZit7FlCk8P+EMjDV4rSKNPI=;
        b=XPCRfdSkojIlHN2E49sv7cXaTRZCIE1FUpj/zHxhA+9y9YpydGcWP/0GMGbxE4trFd
         tPuvXtsxQNr04xjHXkB+VmmcwH7aYhx7jGhImCKJeAQ8hnOzN7/y9n3BViT3o/9fI/Kz
         7LDM5PMV/Vx1ipuHwxxpUCznvQTheKz3ENc2uYz0KzOT0RgBYh8T8KWTLVTepJGByN4c
         2h24am0XGjieKqo6x7zG9FTgfgGg0CQYuffPMR7JEyqO2L0gQtDR/yprFYa6EXLUFFYN
         dYXv9tBHR55wc2hOoOBfsJZvIXTC/N5NfEH4qwwFxH85fLdQPjwBNC3QyMmzXw+ve/t/
         VCAg==
X-Forwarded-Encrypted: i=1; AJvYcCXbs7FJ8/pzl+VFSM/vGXP8nXqmTTHH5RjMdg2nTZWybP4JEPHRayTqFSB6KshQCedCohoULGJNiNu6z3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8DEQKf1985t/Wx5hze+SDN8/14u7UL+4WWaxtM7QT/s0GYIzd
	UjdtMLb8zHfD7R3XMy0m1fL+Lri1fI9Wfv3pTbvzBVcTPln5hnRLbcAoovRmSLlwkZBm8MZBanD
	ddHR7Rm5HY7K80QMmgmzceQ/quxSL9ETQ+a3bSQljBCUg0Q5LJ2CgbNsiVegypULRZ4UBYoAIiA
	TiZ0XwPgS8kg==
X-Gm-Gg: ASbGncuzHlcqgX4PGd769UjwspwYuoLXz3NakCt880C4VGVs5pE8N/mnMcU/Js3wkA+
	casuqIcXmIv4ibwBtpIply5RUl15SueOb7codV7Wz8ClbTm2grAhjwSTsZDNtldlkDV+BtFOOtJ
	CsDhjmRclcyOl4FN2yOvL9Y56X3Fdy35iTBkbdGH9nIMg89M5BngxP7JyMuaqVIZccXWthdKGDW
	X2fHrRHbioueQtFGyMdmF24ErGbzkVtcjHsuH5LdngiR7ap8oTb46Eb/NykOP7yrxJrQAjEKQS7
	4Rh7zc+FG9z9wuNBmDnUy87kwWNUaiDWFMPyaFCk2PRxHyI4FQ==
X-Received: by 2002:a17:907:3f9b:b0:ac1:e332:b1f6 with SMTP id a640c23a62f3a-ac252102b70mr1161848066b.0.1741522546041;
        Sun, 09 Mar 2025 05:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+yHI6fDgActxSSCyVGaL5W4KOO55ngcP2uSoo0/npYO4T8MWeQ2E1aCzAa+KpyTjjPU5KmQ==
X-Received: by 2002:a17:907:3f9b:b0:ac1:e332:b1f6 with SMTP id a640c23a62f3a-ac252102b70mr1161846366b.0.1741522545691;
        Sun, 09 Mar 2025 05:15:45 -0700 (PDT)
Received: from localhost.localdomain ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac296998256sm69160066b.46.2025.03.09.05.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 05:15:45 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: edumazet@google.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Anna Emese Nyiri <annaemesenyiri@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: [PATCH net-next] tools headers: Sync uapi/asm-generic/socket.h with the kernel sources
Date: Sun,  9 Mar 2025 13:15:24 +0100
Message-ID: <20250309121526.86670-1-aleksandr.mikhalitsyn@canonical.com>
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
Fixes: a89568e9be75 ("selftests: txtimestamp: add SCM_TS_OPT_ID test")
Fixes: e45469e594b2 ("sock: Introduce SO_RCVPRIORITY socket option")
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


