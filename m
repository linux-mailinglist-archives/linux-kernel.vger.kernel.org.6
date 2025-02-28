Return-Path: <linux-kernel+bounces-539639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D031EA4A6C5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54EE97AA7F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AD21DF965;
	Fri, 28 Feb 2025 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Bb3+dpIj"
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B359C1DF747
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 23:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787170; cv=none; b=TXpchPAhwPPasS9/hf9dv4rByogDH190LZcpIl4yybZ3eIilIt8H6oX1bnejOD0fdrhZXcKk7bu3EY969pWgNuiuy+Tkfy9vjSKybhHl62tz+B2aiFe8afoFVz8aDZcgUZcKL3nCGKnLn4b/Tb1LwF5t2gS022zb1SkpjTl8moQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787170; c=relaxed/simple;
	bh=/ShPFdmtDi5zFWZPDuX4uvqo7DJ/+xJn2xPk55ZuQbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+O5zXtYFk4NnPRzzVtZW+lJvYhYk0o8Cu8ti6mbFcd0uRdmnhg6sGL2D9dSWjAhCis4flo4lZHvLJYqL58XWJi05nv4pFVblBpQK7TRzcTDvFo2jqpN3w5yyIHZ8m/Ug7G5q7DfycLk+ZBCEPas6jqkt9giLtpld4K+BVUK9R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Bb3+dpIj; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-223532fae14so6043565ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740787168; x=1741391968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YG/WzviAKa26P9kIv9dajWRH9oVJW/MjIO0ud3obPZI=;
        b=Bb3+dpIjNzolqpvPRpJTdPDkx/FQNie4AbcF1y+slnYdzPXF0sf5PxMSCmr3d7DZm0
         385BqwwE9IUtlAbGNOtcIeBXlc7mK1uc1EfkMKZLRmLQAR7nkfvkc+/gUavjRyW3LUin
         PDBz67WofuHZTS3nCWHwLXdAo+6/1IHSstmluuwcaBfXZKe7fQsWuU1ZYe6vs8Uo054d
         Kzua77Z+HwN7rNSgzy0Oeau1YH601ptEpvshJpoBs/VuzlTUgWTmE0IFtDOwcpCyoWrB
         U+lrIMFch4Zb5jnuAUEqFwJwO7yKN05RV6Wbc7BAtAYC703T1eP83TYjMOAIYlRqX2/i
         yD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740787168; x=1741391968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YG/WzviAKa26P9kIv9dajWRH9oVJW/MjIO0ud3obPZI=;
        b=noA6aXtfbPs9T5UL+FA5qtpQnVasQwfojWl432ZEAC3y9zUUZKxRyXeCBarAeX3Yo7
         QPO5m7/Q3fd/TuWJxXw9B6MohSAJKa0CQEcwFSGg1Pb+yLQDMSzMVicb+arZ5suZ8Dgc
         R6ADVJeHN611JhnNAXqUQ7rLt4U/PND4ostg0E5f+1nmJtUEVyTmR2ZHPUBwvvG9xMIS
         WluCXBnVHtUXOYRvmOEfRx/a32Q5nasoxQWMjZqxhw6/9MNQ3hOmCwYkTk/BHgyNv5QZ
         kGpy5wRcKuG7bEhkcojNmlDg7PGkSnHCbMNyoMA4QIsWeO2Ccuksjn49+R6jlADewK8g
         y/qA==
X-Forwarded-Encrypted: i=1; AJvYcCVhrxiR7ZLuaCqjV2oENpiijC7yp2OpsS5/sVWozqgan+S6Y9JEivD5bHroPHeCKIfm5s09/MmNAYlj3DA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwehksmzFrLlZTRVPtl/zlgkQ/oCWvBtWCuskO79l+TeeK/O+bx
	US8xhDc0rKy/p0Wf35mNrMxSdej3wIi0D+3yaFxSXEspUwG5KPEbcr3AHHT5Jn+p2i09/achsVB
	dk1wsCCGYCDO47Wm8RBJawkV0H54oJLtKbnouTpODgU6vssZm
X-Gm-Gg: ASbGnctm1wAO/zuyrmTLK/ruolemR4QEbKaqi8hszpGcJg7mM7drHa0C9FkKmrI3q54
	olz23QQMZBJ4xqUo3BQW3hOzcPFQURjBBOnbH41WXegH+LpnCpIpXzMPFwDMN75eBJS3SrEaPJt
	4O3uZ76B9h02NoISOMSVgKHtoCGXkJbK0C+xl1afZ6vjFk5gI38agfrpqr/haS/FgL5THV2+aIf
	ANjnjLREG0lxrfv7i/NijHmCYgswPhx9NAfPy5q+WLNwjz2ukAXimOsQ4Qj3QjTahqBNMlHBXHb
	8pJe9+kt38eNfuLxHDP6B8RVUz3Sk4M/ow==
X-Google-Smtp-Source: AGHT+IFHsPC6/EgweKrZsOqRp/ximYusBvGZYTTJpG1c/+bUJfy0qECQNUKeO9TX9U6nuPa28QKEjcpBKwxD
X-Received: by 2002:a17:902:d541:b0:223:5525:622f with SMTP id d9443c01a7336-22368f6c10amr31026015ad.1.1740787167809;
        Fri, 28 Feb 2025 15:59:27 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-223501f9de3sm2367515ad.32.2025.02.28.15.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:59:27 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0807434028F;
	Fri, 28 Feb 2025 16:59:27 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 008E0E41AF2; Fri, 28 Feb 2025 16:59:26 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] io_uring/rsrc: skip NULL file/buffer checks in io_free_rsrc_node()
Date: Fri, 28 Feb 2025 16:59:14 -0700
Message-ID: <20250228235916.670437-5-csander@purestorage.com>
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

io_rsrc_node's of type IORING_RSRC_FILE always have a file attached
immediately after they are allocated. IORING_RSRC_BUFFER nodes won't be
returned from io_sqe_buffer_register()/io_buffer_register_bvec() until
they have a io_mapped_ubuf attached.

So remove the checks for a NULL file/buffer in io_free_rsrc_node().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/rsrc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 95def9e5f3a7..c8b79ebcff68 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -498,16 +498,14 @@ void io_free_rsrc_node(struct io_ring_ctx *ctx, struct io_rsrc_node *node)
 	if (node->tag)
 		io_post_aux_cqe(ctx, node->tag, 0, 0);
 
 	switch (node->type) {
 	case IORING_RSRC_FILE:
-		if (io_slot_file(node))
-			fput(io_slot_file(node));
+		fput(io_slot_file(node));
 		break;
 	case IORING_RSRC_BUFFER:
-		if (node->buf)
-			io_buffer_unmap(ctx, node->buf);
+		io_buffer_unmap(ctx, node->buf);
 		break;
 	default:
 		WARN_ON_ONCE(1);
 		break;
 	}
-- 
2.45.2


