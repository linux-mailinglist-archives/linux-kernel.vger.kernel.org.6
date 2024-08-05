Return-Path: <linux-kernel+bounces-274317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F7B947676
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42751281A14
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED90A14AD0C;
	Mon,  5 Aug 2024 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="C4aSFHHd"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF45C149C68
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844768; cv=none; b=VuIkT3J1MuFix8v9PPl8IfYtgHi/BibfxD3YNX/xiBZtn7tw4F1Wr/qVNnoRUPjfmoRKaseFbwXTwPw2OZRu0LUZwsryvrs1mOgkn3Nt7++ID9uZn2sV5akcy789q7fmi+epNtOTZ6wGA+rXxLtApnRD0cO6QBuEGyGWTY90G3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844768; c=relaxed/simple;
	bh=qE5+HNDswGYr4BVahrGJ14VppbTNK9Qy5RW1pgu3nd0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NFPVM+xxgutTP3LmECParxAC8fP1pcpiR7BEj6vfzHSJQ/HLWgi+8zxSST0e82jetRDMF4K7v5UseqY0THpabyXDvWlTVtAfPT+ZnPCRHk9snv+2JmrFd8ywqiNyu2jKhGM/aKtD7weHaFN9AKQ13Tx0W88i9YUGwLvQ2DN7+ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=C4aSFHHd; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7106cf5771bso2591984b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 00:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1722844765; x=1723449565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mLqYycAWVh1lMKvL0pCiQa+U5OuKGTfJ8gChUBso4+Q=;
        b=C4aSFHHd43B07f2Prz7K0OA392ME0/XjVCIBEMb9s+9lYJmpmDURpNCE1uPLKUGiZB
         C374HEk0cAOezP+BQQoK4kj1OVAry70qfK11daksaIWGSakfFps9WJiT2wYGvU3pcB9f
         G2/dJ5VYj4nGaQZJJKFPno/U+pIwCWJLkyG54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844765; x=1723449565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLqYycAWVh1lMKvL0pCiQa+U5OuKGTfJ8gChUBso4+Q=;
        b=EVyP4p6LElEjwQ0it+pOXrRHflEN2JVubV1d2vcZxUaOEdxsL+712a/wg+ll5jEfTw
         WdBccPgktwoFFjPyRE85pmtsiPqwIQdP+6PW8WUXIAaHp3Ds455QGsPzlYujSmnAfIcP
         lqUyMq/Sxcbio7AdSe+3EUemxNqIcrSea4qwc7KgK81eZ+C/bjgpjTLjoc3Q0zUfTIyj
         xxxu5LS5Y2wXFTAyy7scX9iGlrJ19ASGIWnnb/N24jTrffMdT6erGEPmfDzEIuNctYMP
         eVBNSgHdmA/adKDKAwzSoP2DqwXmW9yXbDyaT5rcsRqFaJ08TVq2lrL30gJsrphAbF+N
         I9AA==
X-Forwarded-Encrypted: i=1; AJvYcCV5wmWPrYkQXF1pB2QIkVbokhfNNlSQOSlXeesrISvSjTydwwl7J3zVJ6OkEpahs7EH37eSp3ItnkOyJwBYGHARMJDLiJTk8xm4hzuM
X-Gm-Message-State: AOJu0Ywx9D6zqM4EYCIckIBP9JgB7bpWwHu24DAm3uosL8Duz+sIKiiJ
	UcEzLX5NscGn3p8nDkwAy6tN4DomYHNmmOLCHQKKxBK313dYwYt7gg9PSquxjU4=
X-Google-Smtp-Source: AGHT+IFFpbt6KZR4589BfRTia/foesSRLG9SQc9hezMFLhc7gtkH4+7Re0Es47b+xNoieP0nYrREKw==
X-Received: by 2002:a05:6a00:2e10:b0:705:bc69:385d with SMTP id d2e1a72fcca58-7106cfa9a76mr10480501b3a.8.1722844765423;
        Mon, 05 Aug 2024 00:59:25 -0700 (PDT)
Received: from localhost.localdomain ([154.91.3.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec01235sm4897190b3a.7.2024.08.05.00.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 00:59:24 -0700 (PDT)
From: Chunjie Zhu <chunjie.zhu@cloud.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Chunjie Zhu <chunjie.zhu@cloud.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] CA-392151: fix nfs gup uninitialized iov_offset defect
Date: Mon,  5 Aug 2024 07:58:14 +0000
Message-Id: <20240805075814.10103-1-chunjie.zhu@cloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  nfs aio code path, iov_offset is not initialized before used

  nfs aio function call graph,
    io_submit
    aio_read
    aio_setup_rw
    import_single_range
    iov_iter_ubuf           # do not initialize iov_offset
    call_read_iter
    nfs_file_read
    nfs_file_direct_read
    nfs_direct_read_schedule_iovec
    iov_iter_get_pages_alloc2
    __iov_iter_get_pages_alloc
    first_iovec_segment     # iov_offset is used, not initialized

Signed-off-by: Chunjie Zhu <chunjie.zhu@cloud.com>
---
 include/linux/uio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 42bce38a8e87..2121424204c2 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -386,6 +386,7 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
 		.user_backed = true,
 		.data_source = direction,
 		.ubuf = buf,
+		.iov_offset = 0,
 		.count = count,
 		.nr_segs = 1
 	};
-- 
2.34.1


