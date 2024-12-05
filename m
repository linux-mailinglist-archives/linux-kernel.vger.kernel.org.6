Return-Path: <linux-kernel+bounces-433265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0959E55BB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8E518840BF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB2E218AA2;
	Thu,  5 Dec 2024 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR7mcFND"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020C6218856
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733402542; cv=none; b=mSVGzm+8xK0wTOJ6UtPmg4fAkVN7VlM/rKdbKgxnMc9RZ/3bwFaO9tv6jVjWd2E/JnJwM9+tgyJjQDEOGWlFtSTFls9keFNFNva3yxRRuvOGKvAUVTncf8exo2YM2FCwdtt/EMzRifp+zGrTjQgYLvqFpOU0Hh/ZXn6dHI8TJkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733402542; c=relaxed/simple;
	bh=0fiY4M0vGWLMh8YbXauFIoszgtuhrq4EiiJYaLf3Hqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dd3v0Pe/sZ2py4AxMGJWkVYaJpCjwp1YNzJzpknNf3v1KQbdl2XCVx3AYOf/R0RTSBqMe7+P8/cYB/swvbwCKGALwR9KZaynnsHEg67dzSrsIXGJCXz9BDBJmLrIaMkF7Sur3HKQ1DPmAph7wYwXbhUc+9NTFNJR7w8SgsDIEdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PR7mcFND; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7250c199602so882204b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 04:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733402538; x=1734007338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6NQXLm6bUu/CEoFLxo/tlhW2Htpw3ugwUZ4gmDFJzrU=;
        b=PR7mcFNDc53k7sOADf/VyVLHXwCH14fEEUokMMjk5Yq+BBV8DTocE+Nnk/6NOzk7xL
         khk3wFhcX+MKNw+i1BwQfGC6ICYrtrhnN770EYbRW6nxirWGaKkvXwNIA9YsgKtgSKt+
         sfuSAteleCKhFw/eh4rBntFiErNvCDvW8nE9EYPzwQYJ1bhSnauVmgpQkT1t6r3LcUSQ
         iqjFS3w+6dWP5agaXvJ7hCrPRT3muLpDeyHOYoE4VHvGMoLDH18VTGEgUbhWpfMYBivl
         24ExW9v0g4JucHfFgH/tnMZO6244x/VbLhOKM1+5A4ahj5g0GqZNa7+CwLlxZfSDU2gn
         f15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733402538; x=1734007338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6NQXLm6bUu/CEoFLxo/tlhW2Htpw3ugwUZ4gmDFJzrU=;
        b=oB40tSCc7KMARnllg1iRePezN/2H/yF6XXI0L4d8WWLHEdyaU1NHeH9HOGPz4vwoie
         8cfwCnOki7ReFNmZb/a1W5NtQCf2yfqy48hzjbqD2w32n7GkRIvIoMzGFRUNXSSZcW7d
         6Ac4vDhp0H6VzeXshQxGRuHIWu5gq6gpyb4a2Ht+GIfL0otyGrBetmNznGv1EjOlgUds
         aEXEm4wK5DK1fLiuhZ4nKOXjPjNrhuqn43qWgBxZ+W/2Svkq0Kvd+FZoJEXMa/F3YMFp
         /OofKY9EDUjbtdOEy2CVr8uIWSexRz20wI8Kgt14aFxlNum5vd17C4Xx7qMnaW69V7S1
         aosA==
X-Gm-Message-State: AOJu0YxFwC5rn7DDUbzGN2Wb1qDnP57SWquCl33NSRxYQCEEOWuEinNk
	UAXNEB7LVI7oVsj8f9nG/I7DC59lfZrmEouqeQ/i9mjJW/ntn0xw4aAtrciEHxU=
X-Gm-Gg: ASbGncvLLdLljDK4Os6BOQFiFuj2UffXfztyW0eejluow3B30ajgTc4cM62FHnxN9vU
	Rm2boVOFoL/rmtQCFSySaCV6hG8VE7yfYEuZx3SmqnJYm6Smn7pqqAIJhMRD7Hgq/uh38VzWoCE
	gycLvtkM5sPr0kq4nXDP1s+4lS7WzJmFEscr+hfBh36vO31CwGGJixcG6RlUaEZ3ltyQKMb1cXZ
	XuzDQktuHTRzeq4WboZB225fI69W/N15Svk938IEhnTKsv26ZT83CjlD16TGRi24h555WaR685u
	v0lo
X-Google-Smtp-Source: AGHT+IF6YcB3ZqTFaFRb8K55C3X6K6uZ1UigF52BXIYq/pmb7XH5aaUCXEOmlwZ3R/zgirg2yecLxQ==
X-Received: by 2002:a05:6a00:815:b0:725:9dc7:4f8b with SMTP id d2e1a72fcca58-7259dc750e5mr4599823b3a.15.1733402538268;
        Thu, 05 Dec 2024 04:42:18 -0800 (PST)
Received: from ginger-caritas.no-ip.org ([180.158.118.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29c5bf5sm1184708b3a.20.2024.12.05.04.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 04:42:17 -0800 (PST)
From: Huang Ying <huang.ying.caritas@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Huang Ying <huang.ying.caritas@gmail.com>
Subject: [PATCH] mailmap: add entry for Ying Huang
Date: Thu,  5 Dec 2024 20:42:01 +0800
Message-Id: <20241205124201.529308-1-huang.ying.caritas@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Map my old company email to my personal email.

Signed-off-by: "Huang, Ying" <huang.ying.caritas@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 5ff0e5d681e7..7efe43237ca8 100644
--- a/.mailmap
+++ b/.mailmap
@@ -735,6 +735,7 @@ Wolfram Sang <wsa@kernel.org> <w.sang@pengutronix.de>
 Wolfram Sang <wsa@kernel.org> <wsa@the-dreams.de>
 Yakir Yang <kuankuan.y@gmail.com> <ykk@rock-chips.com>
 Yanteng Si <si.yanteng@linux.dev> <siyanteng@loongson.cn>
+Ying Huang <huang.ying.caritas@gmail.com> <ying.huang@intel.com>
 Yusuke Goda <goda.yusuke@renesas.com>
 Zack Rusin <zack.rusin@broadcom.com> <zackr@vmware.com>
 Zhu Yanjun <zyjzyj2000@gmail.com> <yanjunz@nvidia.com>
-- 
2.39.5


