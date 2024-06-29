Return-Path: <linux-kernel+bounces-235075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B2991CFAD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 01:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1622D1C20F2F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 23:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C52C135A63;
	Sat, 29 Jun 2024 23:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="j/VbK+1N"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3281D540
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 23:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719703846; cv=none; b=quR0J+Rig8g07JiMjiJaTEdSxup90fjebOzx5Sxz9IhU8qxZcApAbjQyBpZNwPeJKk17mnnkOw+dNozvQ7rjs+NYU0XkAppWIE66Y49Wdx9ddzYPGWsauX6BhqhaVtFbEi5ubygXycENbh+/hfLQzg0UHuFq/mEVQoRBXvUl2Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719703846; c=relaxed/simple;
	bh=IEJjlAS5//s9IpfZOVPZKU6ryrB48hGMt4oSDmz/BIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DEZ63gJTFyOFATguD2G9Srifi4A7ie3RUcOFFG7atZh/fbAyMejD3mQQIJ9KminOjbtKZ36oZtKG7bhfCEjF30ru2N7h9Gqrlz45M3cSvZBauwM37OAQZj30NL9EG+yLB/5vRkMiB/Vo3w0lvQX6XRvssTkqUlGYa5TKzhiIiI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=j/VbK+1N; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b54683f65fso9309516d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 16:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719703844; x=1720308644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kzngZ4dBsZTw3mzD7TJaRH343afEjYAiOI6vhb3xMXs=;
        b=j/VbK+1NaxRuT4jUqnZcD14LO3iMjW+G759wD3rfc9rsjLsFGbKGO1MCjm12+4FqxS
         8I5hhtN+Qr5mD/Mne86it7EIvYpM4fZUAQC5plOkcHzu7O+sThYQA3YOfmK1qRlutQxS
         3RioUDSD0QuIiB+BoEGZEn6/yk7vijU+JR7+5AuPFdnhkv7A0Eu/QkrZbXBgT/0HTA20
         IAJtbdgaOIbdpvf4CQyQvdfv7f6Obm6e01vAuH1Yu0XHG8qzcERChfE2Y3dp8Lx9E0CJ
         jJq5nK5/ddU0T5TyyFmXG3HHZP16fncE4xJQJNhDx4hN6Bmn+x3LrJfLWE5KHGr9/97x
         jIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719703844; x=1720308644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzngZ4dBsZTw3mzD7TJaRH343afEjYAiOI6vhb3xMXs=;
        b=RmZrDmUU8ydkM6CMu04VgT9Di5j32GCxWZYUcijOoH0zLucQVQQeENOIH1jHQud4/H
         bh7vrrXw7pd79vsy6hdMm+UyVXDOIfgNq6S5uSa6gqH+ycd3VVS+8XUlctk2U9aYcWyG
         vJPQhT58VTf6hH6Uerq9jnpnibcR3dACazmqqZOByVKrg05xVUd1bPuGKaGCmwoWESLe
         6ncAxZFXfhwUz6B4XWhi9whVQIsY6J77YgvvGZkgxgH6BaY3X7SQCGq9iGNRQd4m+Zoz
         DJ3zjbFWlhB2fL58369oU+NEuzLbwbe8rHbU/5+sQ3usxpLIWn8YiWx2JXl7dGA6jgbm
         yiDA==
X-Forwarded-Encrypted: i=1; AJvYcCVtsAKy7TivumApZPKqTn9OlW4UCPzehkp8i270Yz14dDtHY9qn1rwP0mECOWMaorc9/sU9aURFj6mBcpRQPQcUHCRtXiGYgQ0XwntG
X-Gm-Message-State: AOJu0YxBGVyVHiWVsPqzf7Urok87GG3dJoqpfVvceMyicmNAHMF/ZiLc
	6C1APuHOdENNJyTajNfKmOxo1I4DebkJGOT1exfjlHVJ8ZXNL+Q3LyKFeyGi+0VtEZloqwjbab2
	/
X-Google-Smtp-Source: AGHT+IHMoATyt6j5Mm2oZ60wF78Ol80+nzN8Vjq1tYadVGAVyarOr8GCKkzWv8xp4vKA1CkWio12pg==
X-Received: by 2002:ad4:5e8e:0:b0:6b5:8de5:d0b7 with SMTP id 6a1803df08f44-6b5b71a5d60mr27016206d6.44.1719703843928;
        Sat, 29 Jun 2024 16:30:43 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fad31d5d57sm26608945ad.160.2024.06.29.16.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 16:30:43 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: linux@armlinux.org.uk
Cc: mingo@kernel.org,
	sshegde@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v2] ARM, sched/topology: Check return value of kcalloc()
Date: Sun, 30 Jun 2024 01:30:29 +0200
Message-ID: <20240629233028.275424-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return value of kcalloc() and panic() if memory allocation
fails.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Panic instead of failing gracefully by returning early after feedback
  from Russell King
- Link to v1: https://lore.kernel.org/linux-kernel/20240628194350.542376-2-thorsten.blum@toblux.com/
---
 arch/arm/kernel/topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 2336ee2aa44a..27d6527f5fb6 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -93,6 +93,8 @@ static void __init parse_dt_topology(void)
 
 	__cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
 				 GFP_NOWAIT);
+	if (unlikely(!__cpu_capacity))
+		panic("Failed to allocate memory for __cpu_capacity\n");
 
 	for_each_possible_cpu(cpu) {
 		const __be32 *rate;
-- 
2.45.2


