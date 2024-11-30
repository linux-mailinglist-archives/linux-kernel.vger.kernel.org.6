Return-Path: <linux-kernel+bounces-426170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9CD9DEFD0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 11:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFC4163078
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94CD155CB0;
	Sat, 30 Nov 2024 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VS/zch+m"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813611531CB
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732961210; cv=none; b=tLpoabRvdG+l4D9i1lwTs1XmTlV6k3fxMHBLJyHpR56/dBID7XKHsEkOY9z1lL9OZkHvz4uY8gP1bKYOm6+L2mssX9miL7lnT720oqiNItpIgTxUF8s3K3KezFnrhGttMEOJoNiVMydrWUPJcvzk1VT9bNc7MhiLnqaqt1PTI/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732961210; c=relaxed/simple;
	bh=yF4jc/0jnas8u7mphux/NDbZLQaah9CybZy/aj1SKX8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tsyQywSUkPJaD6rg4VPBqI8WGbcZ9HsbuoijBmyT51Gp2+/SZbBVTO2B0StDmgnSj/z0OfGWwEPKWanZILOeP9yDtneDJ4GxAhb1xSOr8Vjd0N0+sTLB0MyVTo38D/vRgb4oR0DAXg9+F5tKBR1bgUnza7jsSlwD0RGMnLaOUqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VS/zch+m; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cfbeed072dso4036451a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 02:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732961206; x=1733566006; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c8lTqcXsmGRMOtMxTUX660jV7KdM2uwrFwbDJ8pCTWo=;
        b=VS/zch+m09chtAANJf75Mhcb0ZQcPj5smcPYN9Qdmn3GwT8IaMs3dNiwBqi+Eref0w
         JGTk4lZG/FvqYZY0ZMbh/KOakPJoeA308dY8OwC9HY9M+iBWsdAwLOUvueJEhUGIQZON
         yeJdXzV9V5YbZCzMYshLFMkam99FbSUwL8+p8DARNw59uQ6x7kv1OV1BJiQNgXDhS9gb
         sUiuy5mEvExGdmImNyRwbz5PvVtGvmnkQPVMHBsZLTi6ZvPx2U9nrm5WuV+x0OfHjIyf
         vG89wIjEvmTyZ4tDSZ5ukP6y8JsgXvtHb7oyoM+VTV7CJSEHWtbrcW4cHyg9klKXuChP
         XfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732961206; x=1733566006;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c8lTqcXsmGRMOtMxTUX660jV7KdM2uwrFwbDJ8pCTWo=;
        b=Pm0Ce08G/IWPrONrD5JmP/WqM2pLzrKuXhT07Dhg0DGlimY3+DQaUv9rRgxW/XTd/K
         8XLvfgh7v4y2OpSVSPYhLOSz5qKLAFy5zYNG8X01/P0NOrISxLFA9CgPuv9tGUdKMMpz
         a0UMH8qW7quYq4et7AiaZ0VyWK69xENdCUAMrsEq+TXIYWpE3q0aRf9WQ42SMCfuh/9E
         bWZGLlI1lAbdiODiZ5MDhcoXrf0IHIWt0+CddGC1LbWjxTxMlMCQK3nwWv4RFyNOas7N
         4o8oyskGV5PV04TtIM7C9XlqzdKFjcDVuT7XC6B+nZtWi0oSIi90omMHoHchX85j8Be+
         gQ1w==
X-Forwarded-Encrypted: i=1; AJvYcCXrrBAo4OpQa/7RzQCyFnFdQP4JBtNFUtOm+F5DLojxhOyVrjLxqxZMJxMr4hTl6rwBe/b5ZLKej6RUE28=@vger.kernel.org
X-Gm-Message-State: AOJu0YynRQgP8X4HmYZ0EX4jcMm7LyeA3J6kihrDrQxkTdoxJgbGuyKH
	ESxpCZbuxzrPfKFZQLnFVcGwE27AKxZ3YtxLzBDC4RFtpv6yOxHt9thiwkPtHGc=
X-Gm-Gg: ASbGncvCbJThGzLLriqXnvYz4OJTh66uB0+B2sP9eTuGhL+TO+zgTL1yzqlI8aczNlp
	NHRxTeNTcMrgQSUZwUXER6zY3OJoaIGxkH2icJNFGlH/kKoD2yYBiAgC9ffzS85g+LXQoteCppZ
	yi04ND3eJBYYpbbSMq6Ibsfp339vcBs3ruVjfD8uTmif8a0yB0fZC8wGQmJAUatEC9ANeaKwXvd
	0R3vTucAl4vsqgC6WHCNZ34ZP8myvH0vduixOC3UcdYxpvkoEr/el3PQ0qniI2aJR9l3YhD
X-Google-Smtp-Source: AGHT+IG1JrcrPGtyAZJteVJCHxH7vH8ZY5O7MkjzsGsefj4ES1XpFTzV8A+g+FkUnjuwPIicEV56fQ==
X-Received: by 2002:a05:6402:1d50:b0:5d0:b931:8db9 with SMTP id 4fb4d7f45d1cf-5d0b9319043mr5867129a12.20.1732961205855;
        Sat, 30 Nov 2024 02:06:45 -0800 (PST)
Received: from localhost (h1109.n1.ips.mtn.co.ug. [41.210.145.9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996df78csm267844366b.67.2024.11.30.02.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 02:06:45 -0800 (PST)
Date: Sat, 30 Nov 2024 13:06:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Roland Dreier <roland@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Akiva Goldberger <agoldberger@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/uverbs: Prevent integer overflow issue
Message-ID: <b8765ab3-c2da-4611-aae0-ddd6ba173d23@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

In the expression "cmd.wqe_size * cmd.wr_count", both variables are u32
values that come from the user so the multiplication can lead to integer
wrapping.  Then we pass the result to uverbs_request_next_ptr() which also
could potentially wrap.  The "cmd.sge_count * sizeof(struct ib_uverbs_sge)"
multiplication can also overflow on 32bit systems although it's fine on
64bit systems.

This patch does two things.  First, I've re-arranged the condition in
uverbs_request_next_ptr() so that the use controlled variable "len" is on
one side of the comparison by itself without any math.  Then I've modified
all the callers to use size_mul() for the multiplications.

Fixes: 67cdb40ca444 ("[IB] uverbs: Implement more commands")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/infiniband/core/uverbs_cmd.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 66b02fbf077a..5ad14c39d48c 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -161,7 +161,7 @@ static const void __user *uverbs_request_next_ptr(struct uverbs_req_iter *iter,
 {
 	const void __user *res = iter->cur;
 
-	if (iter->cur + len > iter->end)
+	if (len > iter->end - iter->cur)
 		return (void __force __user *)ERR_PTR(-ENOSPC);
 	iter->cur += len;
 	return res;
@@ -2008,11 +2008,13 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 	ret = uverbs_request_start(attrs, &iter, &cmd, sizeof(cmd));
 	if (ret)
 		return ret;
-	wqes = uverbs_request_next_ptr(&iter, cmd.wqe_size * cmd.wr_count);
+	wqes = uverbs_request_next_ptr(&iter, size_mul(cmd.wqe_size,
+						       cmd.wr_count));
 	if (IS_ERR(wqes))
 		return PTR_ERR(wqes);
-	sgls = uverbs_request_next_ptr(
-		&iter, cmd.sge_count * sizeof(struct ib_uverbs_sge));
+	sgls = uverbs_request_next_ptr(&iter,
+				       size_mul(cmd.sge_count,
+						sizeof(struct ib_uverbs_sge)));
 	if (IS_ERR(sgls))
 		return PTR_ERR(sgls);
 	ret = uverbs_request_finish(&iter);
@@ -2198,11 +2200,11 @@ ib_uverbs_unmarshall_recv(struct uverbs_req_iter *iter, u32 wr_count,
 	if (wqe_size < sizeof(struct ib_uverbs_recv_wr))
 		return ERR_PTR(-EINVAL);
 
-	wqes = uverbs_request_next_ptr(iter, wqe_size * wr_count);
+	wqes = uverbs_request_next_ptr(iter, size_mul(wqe_size, wr_count));
 	if (IS_ERR(wqes))
 		return ERR_CAST(wqes);
-	sgls = uverbs_request_next_ptr(
-		iter, sge_count * sizeof(struct ib_uverbs_sge));
+	sgls = uverbs_request_next_ptr(iter, size_mul(sge_count,
+						      sizeof(struct ib_uverbs_sge)));
 	if (IS_ERR(sgls))
 		return ERR_CAST(sgls);
 	ret = uverbs_request_finish(iter);
-- 
2.45.2


