Return-Path: <linux-kernel+bounces-388419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4449B5F69
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BFFF1C20F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD841E572B;
	Wed, 30 Oct 2024 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XEr9aXMt"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12C61E2833
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282114; cv=none; b=dyxPKyNTUylCSdZTWnmWxXmx/NUwE60HTiwcwVyYIrLp6bj9Tqbj4Hrvql3jIBYlFJZAScTbq5IkTciEnpfNgz27Bnesoi9U1R/vM/NvL6+JRMLzuORH2wuXgZlb3+X1gGQ4ny6OV//aZtNXo4c8rhzSFWTkTv0UTeWpLbaIt2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282114; c=relaxed/simple;
	bh=QX1c2rnUJdAFC2RHAlIPCaiJEIHCe919jerx2/vD1G4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EcEUANID+CqYtmgprpuq+EymrqFsqnqby0C4t1jmXpDt1bDAW7CI4T9DIFwsO/s/YjJTxPQkjZNQSCWfQsuXs/FQF4z+stg5eDAynDKIoWtOSnl4VrdZzAA+DI46ME3g1qlZ6E7WXSm2exVes2yxIDctu0s+/0XHAgBN0+/Fb5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XEr9aXMt; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso900666166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730282111; x=1730886911; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myhzYHHZOsBi8fssbTItbk4eRlkhy/GUThFWV76ORgo=;
        b=XEr9aXMtYG5q9YBatK1/E+t+YawsLjbeZgwOOsWlyh1pPu3yTNp9EFnOzyTkRVFH3o
         H769bXEZ7ErlVvhYXe7HnFTqOaPm+ulB5fGcjuNuwDHq9tzJuVoKedvj8IUIBJjUPeAM
         FOhb+RjirunhUrwaXR7eXOUJcNs9Zi0J0KK/Fif0r3FgdDwFSHhtGVP/VaM5jp9/nO/W
         +KF1N2rR9JK7Edr/BKfeQQ4s0jJPA7l9YXubI8pksOWv/hwjNgIKNCz1R8+q4hXEqh8G
         QKn/iBm8apB2iT+sSr/DVa2tc7mCI1v6UjNPbzNCLEKVcxW4XwRyKyyx5RpzAha3aKG6
         Yr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730282111; x=1730886911;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myhzYHHZOsBi8fssbTItbk4eRlkhy/GUThFWV76ORgo=;
        b=uHdCG1BIbWNOERsS1DedmPyo1CcfWJ67J5EjeMXDfl1DfIUyt3j/bTzOhRZ7HANdu3
         Oz4Zs56H687aS1fM7rvXasgv1Uu+TTXF9pZncop0hL5GuKfe2KzS7SFmyly4s1Bv7t92
         byU/uNyeLOHgH/+8tBDO+aDfwZllAN2oOU9R3IwhoGmNHzIcV0MYZ83IjYBcLZpcjmLX
         AxRDpDCDuzsfX3YGhTK4ETU/ZtLaNS4zEMKlLSuiQe8aGLqm89753Gq1BT1eL2ifaI5d
         O+HixQBvBTuwLfe0fJ9y9eID3Up04XOdNf+KRjaaqXpGStkfSIN6QXSkchY0nY/GwUQ7
         DTzw==
X-Forwarded-Encrypted: i=1; AJvYcCWfqQX/cOizjpZ6ERDgOLJNDcaZlqPfNou1PuXJ2cy4tw0tZl2eeAfGGxYCqkjqvGal89VYEEUGKD2sxxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoL8j3CkbSxrabq55oCRvKvUz9NDNX3xOsc3mjwoCHxNBYAfko
	txs2HJzbcWz4sU6uN+j2HeSVo30dhTtD1y/xDwc+Z7Z8T9zpzwPcQVLuDUzkF3HmFRwf1okg50/
	O
X-Google-Smtp-Source: AGHT+IHsaH3qIoU/LqTqY0qV1GT3CRkq1Y3kFNvfZmWxV/jzT7lhY9M/Jf8d7CNzzM4kKfxO9/cmHg==
X-Received: by 2002:a17:907:970a:b0:a9d:e1d6:42a1 with SMTP id a640c23a62f3a-a9de5d9105bmr1338783366b.30.1730282111023;
        Wed, 30 Oct 2024 02:55:11 -0700 (PDT)
Received: from localhost ([41.210.143.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b928cesm14995506f8f.102.2024.10.30.02.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 02:55:10 -0700 (PDT)
Date: Wed, 30 Oct 2024 12:55:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] io_uring/rsrc: fix error code in io_clone_buffers()
Message-ID: <70879312-810a-49ce-aba3-fdf7f902a477@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return -ENOMEM if the allocation fails.  Don't return success.

Fixes: c0b9c5097cbc ("io_uring/rsrc: unify file and buffer resource tables")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 io_uring/rsrc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 784fd1ca6031..f317f39e8b95 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -977,8 +977,10 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
 			dst_node = rsrc_empty_node;
 		} else {
 			dst_node = io_rsrc_node_alloc(ctx, &data, index, IORING_RSRC_BUFFER);
-			if (!dst_node)
+			if (!dst_node) {
+				ret = -ENOMEM;
 				goto out_put_free;
+			}
 
 			refcount_inc(&src_node->buf->refs);
 			dst_node->buf = src_node->buf;
-- 
2.45.2


