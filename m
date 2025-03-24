Return-Path: <linux-kernel+bounces-574324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8298AA6E3EC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 354E716E613
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715B81B0406;
	Mon, 24 Mar 2025 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EMpTPOyS"
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24640192D77
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742846755; cv=none; b=ug4Hd6rz4q7ZBRpi0k2pjZte7+/C7BvBObbbuomJDIRqNoK6ayESg7hjpd7JEsX/Aqh315rniZCLjJHEFKSD7IdhUFGJjjzTXW0i6LgR1vUcwydL4l6AdjklnIojXIPf7Xg/6NdrCztvPBuSOUx+rL60KIDDtCo383ZReVjwXL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742846755; c=relaxed/simple;
	bh=0LC7Q01bxxbnCKtP7LMgIv4+nf3GB8o6wu8YJoicAZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkXdEiSBmxUTf1OMtr7J9d56cr/DeEy1aJ3Ay8t0jY6suh1WqpUO5sxZqPAlPIwrhrzS2ZNOGNyqwDV54befyLNVwD07+Eu1QzVUk03wxyH8O+pga8im34LtABvpZP8919iLc9FGHMHMbtZyoKGgQUI62t0Y0Oakhhtlz1d/Q98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EMpTPOyS; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-85e4f91e3a7so4419639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742846752; x=1743451552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLYdLYi0Kpc4+Nk8DSJMTWzWqA+/v9byHziOX03/Z28=;
        b=EMpTPOySdRcUTicFETqRG0fmMJ3ekNKJtomJ5kDKUIHd5/jVsnM+iZOt9HepyufrX1
         IJ+F9pcX087NDG+h2rFEauMZ/6/ctmfhhxXdy2sCiJ1Ay54i1LGihs7ZMyjFYqmXULco
         ipR4Gg1r5pK9VIeZytEt6vkVFJsNZN1zecT90/gOT3tjhXjz4m/8VdvzUzd1SNCMi3da
         +jjeGoMx+OAKA1G9poi02OzzASN5y9feR6IHBAzyAb19hZCjwtghbwee1HZh9IXCn3oq
         4ICttyYpFiZWdEmkHwJRGJ/urKqn5adU5uwhK4/v/FO/o1NYwIfjarUCfAGIe53Lc/El
         o8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742846752; x=1743451552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLYdLYi0Kpc4+Nk8DSJMTWzWqA+/v9byHziOX03/Z28=;
        b=NJ0kDxXGt1oTGej+/Qac/uUtEmviOhQdOA95RVT4KWcBwQOZxUEUke9Li+co6wUqk+
         SOpNWIE3587mwpqOrXFn18vFZKguQmgmWMEbbAaD1bkFqnc8VB6KLBrvaWqh57jv85ll
         FiqUvFaUZMwwYQ0bHj5gUfC0LKMX+HuDkL8HVZ+qhc3jSWzoZE5ekYeaiHrZ/N990oKW
         7/QfbaSURRP+SYxtx+xEtNgA60cE8FWYzLBX7DcHxZDcK+E1DkjuB77V5JGBkRaCGSt+
         Fra17GQrQVXfGN0CE5yokXayAkvZyGEdEVi1M5TCCDLOUCQOlOjF5P6RqueEZ3t9U692
         CFdg==
X-Forwarded-Encrypted: i=1; AJvYcCXQdWVe+o4qgSUE2nd5aXTH0BaGwdwa7Fo+4e8EoWDBbxrAsEuDdHPKKWldfszTe3UQtjeV6qxpd4sqduI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOprfXwozWXG6K8saeyj8bfaIYtvly0G+ONKWQZFj+JICraCzi
	dfm/yAk+fLx5tMf9KGHezEXy4YWZ9aVg5zZCKo9QEtRH1sszjNdJODEtwIUbTZrReZuBLA1tLKs
	pYH4NQJ4k7FK/Y4gGngQ9eK/DCDpgfQBv
X-Gm-Gg: ASbGncshm5GUy98WBMDIRP6T1DEP9sKCcNVH1h1OR8YEdM2Gw9DrF7CsBJ54ttiSEvA
	roCIidMXaV2Xfdqh4zJYFEX4AkrtufESGT2wKTXanaogkTO6uciDGegZRxChdcbIC/ol32vbbSx
	bkAICbrjv8nyCcCEsLohB4jevIdDA1xgKHpwX1rF/cXGRsOMHrOgtZ387185oYWcelQkALEkGJW
	fAArqvTthINoKEwJG82vaITxP8J9QRs70/j2T99OxfXtbBYGC0kIZ/kXSLB1nzYc6+b0O6DT5NJ
	Br/n/t0miGROSbzl/IRhENcdbd/6vxLQP1vU1lM8qQx51wVT
X-Google-Smtp-Source: AGHT+IG7NfVe7U+p88IpRxBam/nm1KKUWSAXa7Zk+pdMgEJimwgpeukdWWuZoB24s3/zM5KbGcgbaUc9bdSA
X-Received: by 2002:a05:6602:6926:b0:856:2a52:ea02 with SMTP id ca18e2360f4ac-85e2cd45a5amr332775139f.5.1742846751879;
        Mon, 24 Mar 2025 13:05:51 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f2cbe4032dsm371909173.27.2025.03.24.13.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:05:51 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 411AB340363;
	Mon, 24 Mar 2025 14:05:51 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3C6DBE40ADF; Mon, 24 Mar 2025 14:05:51 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Xinyu Zhang <xizhang@purestorage.com>,
	linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 1/3] nvme/ioctl: don't warn on vectorized uring_cmd with fixed buffer
Date: Mon, 24 Mar 2025 14:05:38 -0600
Message-ID: <20250324200540.910962-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250324200540.910962-1-csander@purestorage.com>
References: <20250324200540.910962-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vectorized io_uring NVMe passthru opcodes don't yet support fixed
buffers. But since userspace can trigger this condition based on the
io_uring SQE parameters, it shouldn't cause a kernel warning.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 23fd22e55b76 ("nvme: wire up fixed buffer support for nvme passthrough")
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a35ff018da74..0634e24eac97 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -140,11 +140,11 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
 
 		/* fixedbufs is only for non-vectored io */
-		if (WARN_ON_ONCE(flags & NVME_IOCTL_VEC)) {
+		if (flags & NVME_IOCTL_VEC) {
 			ret = -EINVAL;
 			goto out;
 		}
 		ret = io_uring_cmd_import_fixed(ubuffer, bufflen,
 				rq_data_dir(req), &iter, ioucmd,
-- 
2.45.2


