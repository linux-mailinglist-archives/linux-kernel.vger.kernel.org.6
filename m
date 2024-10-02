Return-Path: <linux-kernel+bounces-347289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FBD98D082
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9341F214DD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFDC1E5018;
	Wed,  2 Oct 2024 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="bDEoclJn"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938271E2023
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727862787; cv=none; b=JTZek7Az7SCZ375acG1w334+NuO1BtxfRiM4kR8xJszsELpnKImbVsG+PU2yr6CTA81Fbs0/bnKESFAB1k/2GrWBZHChTyVnyAUfZsZ7pEiVpo3P7AVE1e/PYxka4b9/3rjtwRAfIxLHMJ+snjZU5y8sOZkkywB2nxQIsuqWCiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727862787; c=relaxed/simple;
	bh=aN7qz/p2yFFjWdhvlvJcw0UJXrJvejxwLpb3F/G3N2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nE9c5BKLUCp85ZAhQHJr7eTjLX97WNyGxaEc0otUPYlpURvnFfTKbB+0BLRDN5EJ065Rd/nmemDbipAkk/Ra+hSGgK89kLQ2/An2JMy895PfP/DLf7xE7AaZlOx5lqn6ZNtRe8mU1ZXYvojWwuokc2DSxVgUXXgf+YF0nFQlpfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=bDEoclJn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso58133995e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 02:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1727862784; x=1728467584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0y2fOVyD+icRBtf7f6CfcDIS1ruayl7XHPLwSR33SU=;
        b=bDEoclJnyKg8PsUfc7RCfJT8IpIS09a5Kdc4TDxI0H+FH4IRhwqXAqaWTnhLHB3V+j
         OGlhtDRGqhFvGoYKuU48HZAB6kWInG1FGClaCyoEssDWzAwPwpjzAwTZ/1LdQ11TVHMF
         NS0qSHMvy/hnlqWc4MMHRpy1QvLx3r8yt8DSkrUyCoIuaqlqTMMFdFQfM0c2KJRBaCuE
         x/3AdZRMnjNBO+Ctx83BFGnrrG6vxb0HBLOSM60Hi56MYgFDcdCiPsPR8bjqYSTncDse
         cTQ0qPohSunEYN3ojJydjhArunMQzCHgZ9O9hyaTra3JavDHURYySd9bVb8sahjBAbJC
         GRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727862784; x=1728467584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0y2fOVyD+icRBtf7f6CfcDIS1ruayl7XHPLwSR33SU=;
        b=fbA1h8TnbyI8+N3vy7VvMLB5bBzyC3iP2LReN09wLrcglE+9tyVFuSmUYnhdTfi9RU
         LJ/u6M7IekIP0zsoh9IZEuFWtiZOWoLWnNrvpYdHa7+IjWZhhHnFTpN9QnIu5keWJGAt
         EnhoY72ETG/rLVYHl4JNjCk04VLx2HSjtIikaIGy1fn+OV34He0vbxZ4rqrgm/u+aOeO
         k7d+Hem0/mq69SLJGPHOFCJibYBZi+AqeQBTlx12aMLvfKlvnnWj7rc+fOReL0MK7SQN
         zIgEIHLXcPP8i1SOkbwuPIaPjB6bEpACWbxXILnjV/l3hX1BvsyFPrxl1oQVlf2TwsZd
         F4/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUOEPp6C0QXfU/pYdG4xcAEBEY6XYhb53noY7cuD/upMlvm9nV/fG7vZ+o8tobMamyQ/TYNA4Q/i/3WW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9vr9RAy+abu0Z9vV26Xph4G4rrTYkWyP2nqvBkLDvzu+RBblB
	9uPAPGUpCndjjTk1UiYwfyli8rLB4pbZOPLLNXFjGS9/866PN94KF1MI8w9yWPw=
X-Google-Smtp-Source: AGHT+IF5ENllhob4HVuzWBT5I4b1Fpp6RnDUCZA83Vl5cMB0AyC0sOUxg+PT5HXx00IekSQKVstslA==
X-Received: by 2002:a05:600c:3595:b0:42c:afea:2a10 with SMTP id 5b1f17b1804b1-42f777c8559mr18958795e9.21.1727862783976;
        Wed, 02 Oct 2024 02:53:03 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:53:03 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 35/37] bloblist: Fix use of uninitialized variable
Date: Wed,  2 Oct 2024 11:47:26 +0200
Message-ID: <20241002094832.24933-36-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize addr to zero which allows to build on the CI
which is more strict.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/bloblist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 2008ab4d25..cf1a3b8b62 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -499,7 +499,7 @@ int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
 	int ret = -ENOENT;
-	ulong addr, size;
+	ulong addr = 0, size;
 	/*
 	 * If U-Boot is not in the first phase, an existing bloblist must be
 	 * at a fixed address.
-- 
2.46.2


