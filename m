Return-Path: <linux-kernel+bounces-539642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40F9A4A6CB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4C8189CE2C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704031DFE3D;
	Fri, 28 Feb 2025 23:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bbYcnhvh"
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD301DFE29
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 23:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787198; cv=none; b=Gaf0t88nGS3a9taviAsmVth6ZgETVSBPjCsrBxl9DRX4tE2BzEdcg7c1HLTCKv85Zbt2mIJf5zFUXl7+0Cds79Pd4SnALNb6iez+Q5IWLkoNmGgRhEedo719kytIVku7MT0yH7Wevrx0bBCU2XVEOHtLxJNoiby/BsBeGP5oEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787198; c=relaxed/simple;
	bh=GqEhJOiyYXdr8rGQugNrCU6kawK92vTYNv4q8/6+xKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqN3b3UxbwIjTu9fYFn1sN+N/pSYSIZd6sJXPMo4HXsvrGDWjpVGwGqdGUO8CWgRy5CduMTgFqlzaiJeX0R/9pCJqM4U/XxEm22+M2gMB55YqRNe0A1/dY0HrxOATUMW56D0UG+1LPS1hOAndLCKWovDRf+uxHDSjYDb5PSRdOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bbYcnhvh; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-520c0b81315so39217e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740787196; x=1741391996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqbUgsOP74rQAaYypSD/gLbYz0cVUXhGZfBogbxaru4=;
        b=bbYcnhvhpzE+esEVp0I7U0EDjNqvwDySuY0XTWgXlYJxrCawT3hYpHiWdN95RxL2U9
         e6bKZnoOIZ4QzUeJeOmo0nu2YxcFQjAkmNNnmlcrxsVhiRV1NzmvjW8NgD2AIefJR85g
         JJn+ZG6Om1SHOKuFlHgkd0syQBxv29Av2V8hfBVUTHgMOY0zP3CU1L9DpxHAtPOp3JfL
         I+CdouGPDKU/kuQkm6c0zxgF3MGtt0gwQQL9IZ0NRV/rGno/hyECfFl/fewzhDCgCMx+
         jzxpgMItWzgOLV4LHY/DjJuhTp31b14C7G1A1yNDD4CYA9FaD5rQVuUnNFqI1815YRS2
         jULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740787196; x=1741391996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqbUgsOP74rQAaYypSD/gLbYz0cVUXhGZfBogbxaru4=;
        b=V6u4O51O5W77Z0RVAS8jvrIYITbiqgj7PNcP31x8rygDJ75hqsWocKH3xrmsp1mI5g
         45nwtGZ9D5gKNfd05lOqjprgelDKAe2lmSHd2/M4Tw331sEO4LMKdwMQ766x+wz7Oqpv
         lgCKsEew22v3u5mol/7FKdEXgjoybT5ycC91ItxuYUrdOu4poHneEbrUlg7opEDAaG8H
         53PmCZNvPeEFlxqbCOHIxYHCuPnXfUe895vle9XnRUGebYDthhS2S9r8W3z6j4fxDCA5
         O9cEpXUYNJenY6Ek14eqOLbzVa0Xc08TyPVcn8y2+HTq0S8qXjTLHpsh8Z9DFFiDmgCh
         9oIg==
X-Forwarded-Encrypted: i=1; AJvYcCWal3bbPQhkuNUmqmentE9Oqbgrj6PBsnekbNBPIdM6Zh8R5xmfJ82Nsha8nXkG2mL7xHnB2p65//Uw3g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuCWw2stfLMuP/sj/R+9IuROqGcimdxqaGoIjIMRoCtNC9wWN5
	J5H0NdZFZ+W/RvKXno++uZrMV+QyKLQKHKn0pTPfy7x3ljV6MXXrJmFVulwx90N4Zw/vPH5pucb
	3e4HFxgQidRIVFmaMmVlIxnYpq+j3fxGvn/yH31xUTxYxV4DA
X-Gm-Gg: ASbGncvVVZjuHPRgUxzZynLxCLn6ucqQxYbwP/xt/5G+hYpV1Btas/8tUWhp6v8+qz/
	FoTlTLIzLOhSgShV1WruBYsXUGgUAQ4mZL5R+ieCXo35dM/R9oCfctHj2ydtSgqI4Kccem99TgD
	5dnCxALOWZ/1YrYxzrOuehLxWo2jK7myd6s9mXJV65nr1W1qhkdOSi48+/bvk698kmZfNVB7C70
	u9v7k7Ww5EQiEmEJyvC1RrnCyKN5ahi4fWGHIcXOqh/QbLWJ8dmKxxMlS5I9DmamUUgb0dI8tfd
	voWq7+O0fvS0QwgG9DXlCGZflmEEEbcuUQ==
X-Google-Smtp-Source: AGHT+IGRBEGoIDXj6ALCnhETDFnXCj12VARjJtS72JzhHgZ8tigxOcRZZIHSTkQ218vW8h9TJLZxg4EO/5ga
X-Received: by 2002:a05:6122:1b8d:b0:520:579d:893c with SMTP id 71dfb90a1353d-5235b64757dmr1239548e0c.1.1740787195935;
        Fri, 28 Feb 2025 15:59:55 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5234bec414fsm230393e0c.2.2025.02.28.15.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:59:55 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6B12334028F;
	Fri, 28 Feb 2025 16:59:54 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5C474E41A01; Fri, 28 Feb 2025 16:59:24 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] io_uring/rsrc: call io_free_node() on io_sqe_buffer_register() failure
Date: Fri, 28 Feb 2025 16:59:12 -0700
Message-ID: <20250228235916.670437-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250228235916.670437-1-csander@purestorage.com>
References: <20250228235916.670437-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_sqe_buffer_register() currently calls io_put_rsrc_node() if it fails
to fully set up the io_rsrc_node. io_put_rsrc_node() is more involved
than necessary, since we already know the reference count will reach 0
and no io_mapped_ubuf has been attached to the node yet.

So just call io_free_node() to release the node's memory. This also
avoids the need to temporarily set the node's buf pointer to NULL.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/rsrc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 748a09cfaeaa..398c6f427bcc 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -780,11 +780,10 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 		return NULL;
 
 	node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
 	if (!node)
 		return ERR_PTR(-ENOMEM);
-	node->buf = NULL;
 
 	ret = -ENOMEM;
 	pages = io_pin_pages((unsigned long) iov->iov_base, iov->iov_len,
 				&nr_pages);
 	if (IS_ERR(pages)) {
@@ -837,11 +836,11 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 done:
 	if (ret) {
 		if (imu)
 			io_free_imu(ctx, imu);
 		if (node)
-			io_put_rsrc_node(ctx, node);
+			io_free_node(ctx, node);
 		node = ERR_PTR(ret);
 	}
 	kvfree(pages);
 	return node;
 }
-- 
2.45.2


