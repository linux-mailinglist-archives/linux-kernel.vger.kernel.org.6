Return-Path: <linux-kernel+bounces-412464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7082F9D0952
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224471F2278D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDEA22083;
	Mon, 18 Nov 2024 06:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dj432bVi"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66313D516
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 06:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731910106; cv=none; b=ouvkggf+4pJEDGW/+aj8pHT90iM18eGQjYA7/RFhigpdR3Ljzy93rmGgIsiUsSSdK7uon+tX3iab27NfNdrH2f0r3EuWbYPgH8FK5Ud8QzbIIqns1B2gPL7lt7UaDs9QUutw9rUH/RFRfxp3o9HhUvHXS2XnoA53rKPWdZKr1K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731910106; c=relaxed/simple;
	bh=cJ2P6uR4opZsVGWIta5h5IZmD3jekZ9UDttr48No1E0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H6Db6fDsON3FDXwG5t5rFYAe8E8j41P00mjVbplPkdmk0EPk+pyg+lufCQ8IlHwElQ6vtjMfqj5FZPIsX9CI/yNFq94ACTQ5nQKTBef9vkjykMquPCJKmU8Hb3mmUZtHkoc+ddS0WrkvDZUwOfNCTPaYD4QTsZ5TBvCJvaIbEWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dj432bVi; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43193678216so34843605e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 22:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731910103; x=1732514903; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fF7b8budhWUD2De6hv7m+BHsAeeg1J7TYowVwHq0Uok=;
        b=Dj432bVieEbcQxizrB7AhmvEEiIYvJJsuqzBbCQJEsDYCv4WHJaiNywoHacU8CEwht
         2hxP89nt6T5IjXvtqiihUxB7cDYRmidNWlayEYHqgnC9vmoWpGt5Fir/KiAdFsv1O7oB
         VF+LY5UiBFR0qtkU7rA3ODPWU4mN8hYptXymGWWJH3mKLS92Wj/IK1e+drcCiqyCX2qY
         +DuKsUBhz0JpSy8pTZM4zHevnzf/GnkJA8NxR3Q1rJ6UY2pnia+Rxq0/cVYX41bmBSYc
         IM1Mkpc0x6oGZ8t+sDGFoDG/9FqnWHd1/tFfNvXXf/WIUlidmGsOTCWiWdo/4khMXhmu
         e3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731910103; x=1732514903;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fF7b8budhWUD2De6hv7m+BHsAeeg1J7TYowVwHq0Uok=;
        b=XqaDMkm37h+ERtbNhSoSgYxKATl4amnuNSn8LxdQrLRODV1KrfomqpHySSonpSTRzU
         XxLDJl1CPY+nXKok/RspetCSoxcKH4FssAXN6MrlUJ9JwJ26TI8MJ6/bQZVwivw8kAYW
         xpQ305FdXT58bborzsw8LTHDol3E+oX2kgC7yTG1SKCYNu40zeZXRWvboMx0ixecWcuF
         bp9uP39V4xFl+lZPfcNn3QJSWSW8x/RivL+53tqppCzumlpUOgXCjfHLy9Gzq4jyw7Hi
         LVIp/n/VB2Hs9xsecQfSWgKrRizafQ+0NdEYOhO7S0WxBPsYGCNbcmTQngW9IwyYZL3x
         aWgw==
X-Forwarded-Encrypted: i=1; AJvYcCXouJrB51IVrAB3TEGQ7bn5uDF/EHRm+s7PJ8cifbr0+uQ7xC3+pSMPgURLsdXhIWMK5kOjIlqH91Ufogk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5rfo3KeM0n4MV3H4r57tim967wJVOzGejuwAx+zVkz2dcd+fA
	N6Y6VLvsoGsP2+Vls23ojfD1WUw1Ktz9t4phdvHevV08MLGci7fbmrL55vYgJ26s1htAot5+Q0z
	Byf9QkA==
X-Google-Smtp-Source: AGHT+IEro4yYmZP5OKHef+XOzgZ/LRIKlD6qWiYZLHMGCu2nTq/i6YxPj2oMalXqgeMbxjS/2dLAvw==
X-Received: by 2002:a05:600c:4505:b0:431:1868:417f with SMTP id 5b1f17b1804b1-432df74be9amr107263115e9.17.1731910102919;
        Sun, 17 Nov 2024 22:08:22 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab788a2sm141599425e9.11.2024.11.17.22.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 22:08:22 -0800 (PST)
Date: Mon, 18 Nov 2024 09:08:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] netfs: silence an uninitialized variable warning
Message-ID: <867904ba-85fe-4766-91cb-3c8ce0703c1e@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Smatch complains that "ret" is uninitialized on the success path if we
don't enter the nested loop at the end of the function.  In real life we
will enter that loop so "ret" will be zero.

Generally, I don't endorse silencing static checker warnings but in this
case, I think it make sense.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/netfs/write_issue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index cd2b349243b3..8f02d8effe78 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -862,7 +862,7 @@ int netfs_writeback_single(struct address_space *mapping,
 	struct netfs_inode *ictx = netfs_inode(mapping->host);
 	struct folio_queue *fq;
 	size_t size = iov_iter_count(iter);
-	int ret;
+	int ret = 0;
 
 	if (WARN_ON_ONCE(!iov_iter_is_folioq(iter)))
 		return -EIO;
-- 
2.45.2


