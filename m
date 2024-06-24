Return-Path: <linux-kernel+bounces-227996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5D391598E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ABE8B247C4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2B81A0708;
	Mon, 24 Jun 2024 22:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sin2uMQh"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4B51A2FA0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266534; cv=none; b=JhSvWl91F2ktLo5tRrB1kVNYgGA0pM/OsmbqfnXhdtetOeloJED0YBE5ARDemPc9k6+8/+d/1WKUbIGKuJhLpOzv29qJT2zwsRUTZ6xFG9Ik0+OsFPiIBMqrSLntGvLMw/aUDA4A3RvNr3Bo1oSjhTVEAdZHBX37YTK90nGzs/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266534; c=relaxed/simple;
	bh=xC5FF9l5eZ8bSM2CS/X7awXDo3lA0kREds7STHvAnvk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AxcIeUgDhpN1AjKhmM3bZM9sMppUNCfUZI0+kaBXfy3ZHLQoZC3ymWFaGi78rzl0wJ/IwVEKBWflu+iRo87TWSutvcnBfxQUtexxFW2yZuu53qBuxmjrUsJ1aAPS/1NDiyg9A3ua7DPeJYkjZe5N/sS0wXGikR9FDEjoX3mBeaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dhavale.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sin2uMQh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dhavale.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63bf1d3fb2dso106631617b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719266532; x=1719871332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s+EfJ0AoKGlj/+Y6NKu6RGkBJo/MER6SHrvQPfBXON4=;
        b=Sin2uMQh3gG1Y1Spwxzi3YLSmk9Om8SFuYYoK99HNJ+Z2fWMydOWNKq1z/Zr3ujvfh
         sdfzAinaI7qUSeKMi5TM+IrmokmLg3tSC6yqCYziyBcx3NDU9EM4yNZIfz5Z9+BTth19
         C+BVDpErV1W8WltbliwHQ0KrCNr+XMFohcnqk9ygB/dLTmgnVSdFf9eWRWMQ1ZYXSkop
         +J4sL74tdMUkSXzfxPvW+lCBv6IyRikxJaXcWtnwSemITwErW/tQXpGvbHBU9I3ZgLM7
         mODBsmTVUYvOPbLXbWezTyBuoM/tDTkVB2xX/4piCYC66K/inueaEn7mY7zCewRmq9y7
         FDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719266532; x=1719871332;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s+EfJ0AoKGlj/+Y6NKu6RGkBJo/MER6SHrvQPfBXON4=;
        b=RJHka54jhB3WsPprAJj5sh19eikVcI2BfTJzBLrkY2ZFpHyrx6QtIZtCfVzKgwQ4GD
         YL8TXBUFnW7W0Ax5peqc1Nt5S4WmgO7HNe9UVG95iFmxpDSMbLxQ0xCU+iqMfsRKH8Df
         SjM7lrQ2fL9qiT+yUEP7HnbSFvMrlLsE2gxVE9oFj+YrwwHEGthL9MMF3djsdnZLIqJD
         Yhiqplw6OpMQt8M38q81vK/vg8HlbeGKsBvttQACdfiX8wvp4qSSVVn5x/s3Hr0TMFw5
         nh8p9eTLy362StN7/0rgQb0VLFA2jhE7SreJIpX0gWl3GR4kh8nah9YErR5ftPT843lQ
         qpcw==
X-Forwarded-Encrypted: i=1; AJvYcCV6I4dbEIH30+va96le+tRdIyVu2gphFr2OEGjBtiu/7i5KPXitWiRqQz0EieixDIJ6pd4JPVgibG+FK0ycPNrQVQjhyoLU2vfH9E5r
X-Gm-Message-State: AOJu0Yz9MdPfgoR+DBdKAHstpm2OiY0ndPahmCxP16FnliS2/m+2693i
	hGKDJ217+DZRsPLywKD333kRfFIhNiEq/8XEHRz/TaQW5r6dG7PL5aZbEAcpytBi0mMBzqkMCit
	WjZTOIQ==
X-Google-Smtp-Source: AGHT+IHLhxwyVv9nMVrC3Jwu4bpC9flEqE3SXuk9eeKuPJOpyr4XzP7jLnmABDJo9hUdNQV/1SKqydFBjFpL
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:307c:c43a:8b68:c64f])
 (user=dhavale job=sendgmr) by 2002:a05:6902:1241:b0:dff:3ec0:71c1 with SMTP
 id 3f1490d57ef6-e0303fbf483mr103883276.8.1719266531828; Mon, 24 Jun 2024
 15:02:11 -0700 (PDT)
Date: Mon, 24 Jun 2024 15:02:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624220206.3373197-1-dhavale@google.com>
Subject: [PATCH v1] erofs: fix possible memory leak in z_erofs_gbuf_exit()
From: Sandeep Dhavale <dhavale@google.com>
To: linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Chunhai Guo <guochunhai@vivo.com>
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Because we incorrectly reused of variable `i` in `z_erofs_gbuf_exit()`
for inner loop, we may exit early from outer loop resulting in memory
leak. Fix this by using separate variable for iterating through inner loop.

Fixes: f36f3010f676 ("erofs: rename per-CPU buffers to global buffer pool and make it configurable")

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 fs/erofs/zutil.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 036024bce9f7..b80f612867c2 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -148,7 +148,7 @@ int __init z_erofs_gbuf_init(void)
 
 void z_erofs_gbuf_exit(void)
 {
-	int i;
+	int i, j;
 
 	for (i = 0; i < z_erofs_gbuf_count + (!!z_erofs_rsvbuf); ++i) {
 		struct z_erofs_gbuf *gbuf = &z_erofs_gbufpool[i];
@@ -161,9 +161,9 @@ void z_erofs_gbuf_exit(void)
 		if (!gbuf->pages)
 			continue;
 
-		for (i = 0; i < gbuf->nrpages; ++i)
-			if (gbuf->pages[i])
-				put_page(gbuf->pages[i]);
+		for (j = 0; j < gbuf->nrpages; ++j)
+			if (gbuf->pages[j])
+				put_page(gbuf->pages[j]);
 		kfree(gbuf->pages);
 		gbuf->pages = NULL;
 	}
-- 
2.45.2.741.gdbec12cfda-goog


