Return-Path: <linux-kernel+bounces-324144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4432A974861
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 04:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2DF2B246BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619922A8D0;
	Wed, 11 Sep 2024 02:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NaCs+Yz/"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F08161
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726023370; cv=none; b=PYhP38Oetgbmiz09U1m/XRuE8jbeXT37YvCKVd8Z/90wG4cM7HLsvO3RPRtiW5S+ccwzp/KJUQObo+nAJwGTLaa2yJeEJaLll7gPqDeYCWbs2Ac9RpGvOfIT5pT4fPawzZMMv0LuGH1CM5jAkzB4LLItohGob0NkhxJkl2pgGsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726023370; c=relaxed/simple;
	bh=t56H1BupMRoI2IQEY+UqEN+q8cTmpxwrJ0A8fPca7Es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IO4YLXIvTJYlCzXf6RE9i/0bR8vjQ1yy3jTm81iUfIy1eNYKSj0qJroNup3YIS2Go/AZKf5gxEDcG85UQ0As95d/r/chKHE0GP1XZBptZCQjbk29LFkipeHqRmIM3Os+ADFnJNvyYd5lKnt7H3ny1zFD58OTiTBeyO1vRPac/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NaCs+Yz/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20536dcc6e9so39854635ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 19:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726023368; x=1726628168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WOIzLUnnpZTrZLa69kfeGABac8EpornaY5X97Bc8fdM=;
        b=NaCs+Yz/D5c14PRFGm28Qpiy8r0jWb/Z2qQA1i3qigvqn52KVGncbvLQxY1Dc/AbXY
         v+Z6eQklo8/CGPyTB6/iAQ2VPAGBTtpbwjj9TsBXX46ZQ2wKLivBiNrlqpay+fpsbkdX
         t5wJbwW6lb+acNKZgBlNicAos/7z5n/lsG2no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726023368; x=1726628168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WOIzLUnnpZTrZLa69kfeGABac8EpornaY5X97Bc8fdM=;
        b=G4N4Zo1SNcRHX5cipSMmxrCeISrLGHVAXVwTgPzZW2fNbOKVd3bXN29kIlTxmbUjKg
         BVIb5/BTh2HISkWU59hWNUmMrB22DLpP81lMyl6q5XtcjLt2YPEQbhUHWg+0GeX1jtuy
         FOs0N11AeUXNy7N8/ISWZA2jvXf2u8vMKCLntCndhY6Og4Q7zJJv2QMZgHrKkipM9XNq
         bBf/RNN+L5xuK93j4iMcjToXe4nr2w772fHmelfdpvby0f/lcuNyHQa3MleT73l5UH1f
         PjpdGqGuURwJ9fjv/cf5JjTpd3mHBgQpVcySwhrLXLkbkdqKaGSVygQumXknMPlnP8iR
         1lHg==
X-Forwarded-Encrypted: i=1; AJvYcCWAW9LT/ihL8I8n2s7A5aNMwZ+BPk2uu/UWerrEdSIPFEpdXAIwSNs77nLLrFli4EkU9dQLdOtcMVqyO5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVPPq33bKvT9blOq4QE2NDz2R6v8TQsLL0sNcQXobjz3WVZasA
	EbRRu64nETkrjup6HOB3kgc4FFPiz3dhHE5Lrnr8FOZiVsFMyFl+gCTXsOZHmA==
X-Google-Smtp-Source: AGHT+IEh+zUENKlHwTqqvMCLXHJPeHfx8bc+42zpBFb1EgLg0Uh6wz0DEozMg7IfOwpfpIC3HXlFdw==
X-Received: by 2002:a17:902:d50a:b0:205:8b9e:965f with SMTP id d9443c01a7336-2074c5f974dmr32242815ad.31.1726023368412;
        Tue, 10 Sep 2024 19:56:08 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ab54:b18d:dd53:2da1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f32dbasm54738295ad.279.2024.09.10.19.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 19:56:07 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zram: free secondary algorithms names
Date: Wed, 11 Sep 2024 11:54:56 +0900
Message-ID: <20240911025600.3681789-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to kfree() secondary algorithms names when reset
zram device that had multi-streams, otherwise we leak memory.

Fixes: 001d92735701 ("zram: add recompression algorithm sysfs knob")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f8206ba6cbbb..ee2a279c5f25 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2115,6 +2115,13 @@ static void zram_destroy_comps(struct zram *zram)
 		zram->num_active_comps--;
 	}
 
+	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
+		if (!zram->comp_algs[prio])
+			continue;
+		kfree(zram->comp_algs[prio]);
+		zram->comp_algs[prio] = NULL;
+	}
+
 	zram_comp_params_reset(zram);
 }
 
-- 
2.46.0.598.g6f2099f65c-goog


