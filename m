Return-Path: <linux-kernel+bounces-539650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C68BEA4A6E2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98F6189C5E4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782FBBE6C;
	Sat,  1 Mar 2025 00:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TZRVwYdo"
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193CA936
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 00:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740788176; cv=none; b=jkoWBoMO9KNdZTiwpA4PjpoImPc1G5mpf0XD9oUJbvr6eux9CnfmIiFZ3MHefoLnZIX5VePVTf5RWUvBPmehbvhrTB2UyGcEWewq+AHH7VMMgtQrWskAiEx4TXyDWBdhhq3rQCda7OwR+cp+VPVk6RRrurCIy25trN5zyjIfOAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740788176; c=relaxed/simple;
	bh=gEsO3KSN33JHbOjHTf+tQsfxSg1mhFmpgrI1pGdf+Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arnAI1ktru73vjrMROLHTT7aEfur5Ov6/zHEo0c1BBk/iH632edmjoh3gqRyUn8g/ZBlwkthywsFh9slDQzE+hiEw8Ilkd7PgotbUkRnvzJLb/AJFJsIqyqpf0Vu3gi6Ttf7Lxs44HipR8KzOfEpG70ihMQbQFHTcPVV0cb0yjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TZRVwYdo; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-22378b3a465so2628385ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 16:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740788174; x=1741392974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQZ71ECrKkWECl6xiI/pDVZ0FP+103ZQTyoLJB/O+Z4=;
        b=TZRVwYdothALMFYxxZa/Evs3/rFbbkU/wa1uWjzrTOUjVgwq17FPVQPzrkTWCAA8Bl
         fpkOPqd3W2aSbJxd9IpD8nWrqHOqEA7Ck1K9wQJOmbUAq5Wt0uCH6PZNcQ95tx4vEjAm
         k+GYwnbO9ql/SVCT8pJ4ZnggFcV5Hvvi4+vi0IbUdnpLbMFLdvXjURDkooiDMFTiHHZ1
         nYEVTzWiwPiet2keQvBlHGyVYd+o7owLipLRw14tUMckM7zpWBrv4XISFgGuUGuSEVww
         0Dnv6AWa2Dagd/IcH1pJUKuoDoycMGFVRJSW3EGIFrkUtWErlriueDZvyB82QwAQ6nDD
         Cflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740788174; x=1741392974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQZ71ECrKkWECl6xiI/pDVZ0FP+103ZQTyoLJB/O+Z4=;
        b=vWVCsJE+sDjSg8MDLaMlAC5b4G9ZpkBUalyC5BmKZBzvCNcCFdNKdX0Bcp/PKdEm0x
         oKtNO3sFikDKwuGAZUmwLkitQz0mB1+QZtTb2tBqJA+rHusv9t4N2ELL0CJc/o6Yq9UZ
         bfEqQXsUeZLClVY6zjQHe5OHmdCiFKhnpS6cMQvpojIAqmVDoMWMTYZJNsxCL/tOOtLB
         hyTFTJzpH7eexWqQNtHFS7EgF6b5n2KYPGEfIjk7UWOYeEpoaSZdcj2Srxf0HwbbSCFv
         wB1a/AYNmJGl0hIv7MKx7Sdmfkc4x136A04sq+92XllxSg3RgpnJ7LVly6dPHSlKed5Z
         EidQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZpcN9GkhrrP21kZrUnf/skTMeo3N2BbF0e4U85n96oM+94Xd2ukl8eqlaocmrD2cKTZ+VcWFPTGD5/88=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkm0LYY1e64NGkHe+ehpxX5oUz7on6n6K/Ac0UrHQuXKdqo/jc
	yi3CIitf8yvnI7dleKKtEWYwOJUvLm1YLMZpM11rf9P6fJLLY/FcJ/G7iT76t8OP6TADZwZPjN3
	JerJKm8blpk31Hufx/gyCu4m9wmT158m2
X-Gm-Gg: ASbGncvh5rDEQdk32Xp4pMbyos2EylPfpVFMvxuHW54A/PKRGgJkTEo5hbn9FT5VMHr
	M4xZf8MxHN4h03F7NG+GCSlxHVOhZRPG/EKsOjAFkugwMYnATj+JoUa3E28Qo+Ua//Tk1TCPPyc
	0A4Bohc5LEa6sqETld9zrWewyytyZ93GslfTWAvAUmDQIUCxyzm6WxFiPNS75LH2K3PktEHMWcZ
	eNCZQuCSB9oXy+TZM5WlgjbDGC7EfPT7F55tidgl6QnMApQsa8wQYolmU/MeG+WFLuEvVi/49vT
	21Ob/4xeOE+neWA2r8lGjPZQ363YW3nQ8Fu4GmUQ/PmxE+Kq
X-Google-Smtp-Source: AGHT+IHm7l5gSAjpuXl6sjpSEETVwb08PP2ae8KBZIblUgIaqAeUNtu1Pov6eYfnSnHcoVeKU6k3kOvp+iND
X-Received: by 2002:aa7:8895:0:b0:730:87b2:e848 with SMTP id d2e1a72fcca58-734ac4a764bmr3123476b3a.5.1740788174093;
        Fri, 28 Feb 2025 16:16:14 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7349fde9edasm289102b3a.8.2025.02.28.16.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:16:14 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8BA97340D6A;
	Fri, 28 Feb 2025 17:16:13 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 86D82E419EA; Fri, 28 Feb 2025 17:16:13 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] io_uring/nop: use io_find_buf_node()
Date: Fri, 28 Feb 2025 17:16:08 -0700
Message-ID: <20250301001610.678223-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250301001610.678223-1-csander@purestorage.com>
References: <20250301001610.678223-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call io_find_buf_node() to avoid duplicating it in io_nop().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/nop.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/io_uring/nop.c b/io_uring/nop.c
index ea539531cb5f..28f06285fdc2 100644
--- a/io_uring/nop.c
+++ b/io_uring/nop.c
@@ -59,21 +59,12 @@ int io_nop(struct io_kiocb *req, unsigned int issue_flags)
 			ret = -EBADF;
 			goto done;
 		}
 	}
 	if (nop->flags & IORING_NOP_FIXED_BUFFER) {
-		struct io_ring_ctx *ctx = req->ctx;
-		struct io_rsrc_node *node;
-
-		ret = -EFAULT;
-		io_ring_submit_lock(ctx, issue_flags);
-		node = io_rsrc_node_lookup(&ctx->buf_table, req->buf_index);
-		if (node) {
-			io_req_assign_buf_node(req, node);
-			ret = 0;
-		}
-		io_ring_submit_unlock(ctx, issue_flags);
+		if (!io_find_buf_node(req, issue_flags))
+			ret = -EFAULT;
 	}
 done:
 	if (ret < 0)
 		req_set_fail(req);
 	io_req_set_res(req, nop->result, 0);
-- 
2.45.2


