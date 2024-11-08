Return-Path: <linux-kernel+bounces-402132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 584AA9C244C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA386B26565
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631E121EBB4;
	Fri,  8 Nov 2024 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OnJ2iGzW"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D7D21C183
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087925; cv=none; b=epuUCIKaZK5FFvXCF5tXexUEhzWLoyT2F+cNOqlHNpXLsVukcu8j1cqxgQ+yyee7jv/8r6uvyXtfLzpHRDQcgN0ugGkHrxnX3A436/sk/vgXNGQwBAA7d9NUy9Y6kftBB0Rv5rcXgYWzuPInmq6cPL0kYUhEd0HyMU20Xj2eTpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087925; c=relaxed/simple;
	bh=DyjqDUCBJSj/CnUsQELSU5shQKyR4sQgd2xgO6LEYiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXC8e5T9+71Ke4lt1tL9CLFyRd8Or8UlupcOcTma3x5PXBphh30UjwHfUQnbKfhDpsvqmIGQ9TKJxiHDOgNT62PCgs2OVqP1zpdFLEVMCEf8DNuC83nSQNlQnVZZek7k1/r2cTUk2dApK1pmhZs0MDThOS1MNBKTU/y0U9NnZMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OnJ2iGzW; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e6048bc23cso1497132b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 09:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731087923; x=1731692723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWDNTRuAGEC8P1PkMAQXcWfNP3UvXVPT3pXPdqP7CT4=;
        b=OnJ2iGzWog30ADCSfPtO7riVPGsZU0byapv29srIuAWjnUpLjOlWxa8LC//Zm/7mkq
         MbrmoMuBKhH7AuvxUJr4pVyggg4d024lbbipXJW259Y708NzyTFL0jNTk8DeRp3x2DUy
         yhkP/rhG9eE1IR4uO+REPsLPNvKhtVHlfEs5VyaXRgbjoNs7UVtahBzKfNgzcCM8J1cm
         bbrN2XkomvS/zAUCUh8WAMvnQSu5P6HZhnsApD/MbZCk8EuxnpUkcbMup/PGESlb9dgu
         qO5X7Da9W0lVRl88/J3RiLtlLmIQgZPDXGnoMW6YBPfNJ9jqKMl30gUJ9qy9HqUztVGg
         8Suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731087923; x=1731692723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWDNTRuAGEC8P1PkMAQXcWfNP3UvXVPT3pXPdqP7CT4=;
        b=Gw2l2kVeKjhDymaGjGCC1wvBdDiumVivYZtFPA2Y7v9aSaWVpy04koF8kRDAzqyVG+
         /4hujyURSIDzPZ95F5VYldIMipOO8whmQ9rZAIYRn82CseSY9x7GyFkm7lvDJAda3DmN
         50e8xCv04goKmB7s9ZlAMNawstBldW0R4MZVMKoRrnv79FdEWXJMpTfYKbPZKKGGYORt
         5T/TEgpvxD6vvf8IBjone7a3mRX4pMIVcowSOvGO/ueDhtGP3wElbTFmdpPW4f4DapEM
         DbNIgEn9l4gYaOxCt0c2t58vBlF15Pd7/p7qibMihQ67R5HC5dfQMYbdKG3HKlEDOB83
         LXnA==
X-Forwarded-Encrypted: i=1; AJvYcCVYWL5dDdurCfQT3gyKcr7U00RwTI4lvJdEQwOSApLpHDrzz7h0HrySb0WZmXH2tvQT9IatnqzVVy/6mFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDQGqF6Ur8nSWGzm0YDB4zwVFSt+pmDZPdgLTj/KIk3C7uvL7n
	GwaIIUiwqm8445mLvZO/7LHYlItebDVBggVL4F0H7rkSpIyA/dq8LDGb1XiQT0g=
X-Google-Smtp-Source: AGHT+IEpy29b6bGe+h/CboagPQRbeA16vn/em+bpmlLLfLOrXhNW+1oHUaJS7mfyo/74o97NJpvLFQ==
X-Received: by 2002:a05:6808:1525:b0:3e5:f141:1331 with SMTP id 5614622812f47-3e794733f1fmr4465090b6e.37.1731087923389;
        Fri, 08 Nov 2024 09:45:23 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cd28f80sm780969b6e.39.2024.11.08.09.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:45:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/13] fs: add FOP_UNCACHED flag
Date: Fri,  8 Nov 2024 10:43:30 -0700
Message-ID: <20241108174505.1214230-8-axboe@kernel.dk>
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

If a file system supports uncached buffered IO, it may set FOP_UNCACHED
and enable RWF_UNCACHED. If RWF_UNCACHED is attempted without the file
system supporting it, it'll get errored with -EOPNOTSUPP.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3559446279c1..491eeb73e725 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2116,6 +2116,8 @@ struct file_operations {
 #define FOP_HUGE_PAGES		((__force fop_flags_t)(1 << 4))
 /* Treat loff_t as unsigned (e.g., /dev/mem) */
 #define FOP_UNSIGNED_OFFSET	((__force fop_flags_t)(1 << 5))
+/* File system supports uncached read/write buffered IO */
+#define FOP_UNCACHED		((__force fop_flags_t)(1 << 6))
 
 /* Wrap a directory iterator that needs exclusive inode access */
 int wrap_directory_iterator(struct file *, struct dir_context *,
@@ -3532,6 +3534,10 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags,
 		if (!(ki->ki_filp->f_mode & FMODE_CAN_ATOMIC_WRITE))
 			return -EOPNOTSUPP;
 	}
+	if (flags & RWF_UNCACHED) {
+		if (!(ki->ki_filp->f_op->fop_flags & FOP_UNCACHED))
+			return -EOPNOTSUPP;
+	}
 	kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);
 	if (flags & RWF_SYNC)
 		kiocb_flags |= IOCB_DSYNC;
-- 
2.45.2


