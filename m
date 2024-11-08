Return-Path: <linux-kernel+bounces-402137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 583499C2458
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12CD1F27D60
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D038220D61;
	Fri,  8 Nov 2024 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HZMR+K+U"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF87A21FDB8
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087933; cv=none; b=NCquAfp1TZUWAeOraLAJ1qjeWCgXc5BRzEKIkTpXTERLQyFSfw9A/73Q/NdM0krh2lTgVUx9Wba8431+3dCAbtteuMsMM4IJi6x43it+DHBlnJoQKc1QuOMiiJ8X2qdnDxAwH0s0hH9maYV/eeIjPqk7GeFC8eO/+UcjplxaUfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087933; c=relaxed/simple;
	bh=1VnlS1RCwZciciCsk6/J6hl4e+sRw9JmzWzfIz5VZZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhvEO+FCUFDksP4O8nGDoPnvnPQqJkKIGUvTxcNXOktc7dYNCT+v6Lrc6c67w/wu7XimyTJH0J8Ue/dHInYTOINIEKP9D+oOkGhgFhvZEckFmU3oQuTgYWcSIvw1noAW31sMKWOwd67/EnOh8IzsAHz6F74F67NpE8BG7FSrILA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HZMR+K+U; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e600add5dcso1373202b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 09:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731087930; x=1731692730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQL0Yvui1/uihQbO1amlpE3hTYTghb1QS2rKG5UGAbk=;
        b=HZMR+K+UmDqm6puflnCGMy7nlolPnAyfUPgt8uND2tZ10eFGflNNgGQkNWw1aIurm9
         LcnzgQCdQzPsuYs93NhwYqgnQjG5zSzHtpykr4KJaRlO6ksiZHvo7KI1LMvfKQuLeBYC
         7KyX+yjhNh6jX4AGArhnXPb7bFMtOeiHLHSDgbGlv8Ir+fj5WwxFrqJEpceihCDELc6k
         ieDX9f9zMoKIDho0vcRTLkVXGE+Jm3ZP8BH7mybdJl3mcGhyW2l4+sUjYv+dc3SSxcaQ
         sRCJzyp6Zb1hCPSeWTJTfxn7/BAx12kiIpbszMcRW/JF2reHktKeJAVUoRD7y/LFJ33y
         ndEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087930; x=1731692730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQL0Yvui1/uihQbO1amlpE3hTYTghb1QS2rKG5UGAbk=;
        b=mwmrti7A13o6JgXz3YRy0au/x78jwxfrNQMPne7hfz+vK8iTEv/ApdtFWpDYOlCnIk
         0ZLvjpHu32xgCtkFOW4nq2GemJxC4vA4MxJSib3ogFtxVwnkeSDTmy+1Ee1ETGZ3b8Sx
         sqzCSIyGTH8WO8HrGX5cZ1aN1LTjFNbsYfDR9h+Xlm3k2nIhBG43afKkr5Ny6/NdrYf5
         P8sP9T4R2qsiT0XSHM3/cxiDqyjXTnRvPRt8lKEPCniMM4UMQEKikU9bF8VGAq1RPpcm
         mt0a7nQTWY23Rzd6W7p8T1vt8Gp3wuGt2+Of5N9pg2A1Mk2xAWVNqUR04AsNYnWDAtOX
         KfDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+5JnDJncgyA+hqqVYUlRIbtlDPMbtBzupTV0bi1FCFLL7lqK0vaj6MskXXPtx06iNJEFJzRyAjmv68VE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPpUqktjVlBnRfpJDjciwp0dQ8sK5hNQ/P+ohfg3/KugEJoxGL
	kMBiGTPqIuEJUvaIC0S3zgaCcB+6yOC+UF8aH9o0dqdwMOeM3L0PLGxwdXb5Z/s=
X-Google-Smtp-Source: AGHT+IF8148kIy+GR70FdSYcCZ0fiyujzQfL1vs9+4lT648aDmaAqJC/hHYFUZhM+2GwXQZ5gTEvug==
X-Received: by 2002:a05:6808:f89:b0:3e6:62fa:6b04 with SMTP id 5614622812f47-3e794720349mr5084554b6e.32.1731087929940;
        Fri, 08 Nov 2024 09:45:29 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cd28f80sm780969b6e.39.2024.11.08.09.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:45:29 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/13] ext4: flag as supporting FOP_UNCACHED
Date: Fri,  8 Nov 2024 10:43:35 -0700
Message-ID: <20241108174505.1214230-13-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108174505.1214230-1-axboe@kernel.dk>
References: <20241108174505.1214230-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ext4 uses the generic read/write paths, and can fully support
FOP_UNCACHED. Set the flag to indicate support, enabling use of
RWF_UNCACHED.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/ext4/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index f14aed14b9cf..0ef39d738598 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -944,7 +944,7 @@ const struct file_operations ext4_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= ext4_fallocate,
 	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC |
-			  FOP_DIO_PARALLEL_WRITE,
+			  FOP_DIO_PARALLEL_WRITE | FOP_UNCACHED,
 };
 
 const struct inode_operations ext4_file_inode_operations = {
-- 
2.45.2


