Return-Path: <linux-kernel+bounces-572635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AE5A6CC6C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E43B189C0C8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 20:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF772237179;
	Sat, 22 Mar 2025 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vYtlnrts"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E42236437
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675788; cv=none; b=U4kuWR5KvSSXIVcvanUe/LEgQ2p393OkyFZuT6UfQr/ce1Vt99UmlFoVsEVdsu4UGX2/HW51MejrgNednok/EKQHN7TZPx9kRpSOvh4kH1YDuC0fkkh6Hkiu+SD4qs8t31fGJ7Vnb/+seqIZJJTY4I1Cjk28wBVAC4bCwz4G0+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675788; c=relaxed/simple;
	bh=c3/J2vBhFHgcYU8/R+B3kO6gEpk4hnzkVfVtuyfH1MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7fzSEX7eHpvl24YISKARa6B7kfKHIxNfSsXDaXjJ9ntoBm6PJL5RhFIVWSZ/c3ZNG9JaBdi5+D+uf4SFvT5h60o4J8CQhHNme3X+jtxJ6+jgeR/zPpjwwbmyYRypO6+CK0O1MoN2XX9cs8yek7W+mBuPgAIiMrVJYYMbGml9Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vYtlnrts; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223f4c06e9fso49800155ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742675786; x=1743280586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dz/LHTTUvobHGyp+oeRaoigsjw3nQSx8Yss6Q7WiTEA=;
        b=vYtlnrtsa70XvUxSH/BwDpwL7WlkEe4pR4Dqcd+CuXXifqtEe04UCyrmSCgFn2MBiE
         0xvx0EEJLPsYvBsDDvJ7p2DFfbSC2vsUr0PMxehVIEQbrS0mCf9+ohJ+0kHvjJU/VoKP
         CSZemS9GPjNvXN1utqyDLFd32AA3/U3MqFj2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742675786; x=1743280586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dz/LHTTUvobHGyp+oeRaoigsjw3nQSx8Yss6Q7WiTEA=;
        b=vlo8nb7jCrDZ4Dye44CYoRptqOtNZNuUBAS/93kQc8isRO9LFBDk6oIN7NxnNI3bOy
         erYCu72FFkbO//i5upv267IH97pp0r1J7yiYUKw9a5/Y0oaKiv0bHkmpnCBUwn3HlNun
         QhjCJ8/esnXgJXfZV0AySGn/EjPmcmlLzaMsN6U/yhYcMzZnHytl6ThqMni7dJKt5q3O
         NP7ZeCXaLUlk/NdsN/Tmxe3yMY9d5B/06cHUqZLaV+47Kr+zRh+VR2Cdt/W7QExHj0t5
         l1fTlyPSyyHCqi3eAunaLZFv3MqQwsuPA+fgVadeLiaYPfbNZoLuMyI6fJBA+m9y3u/e
         Wdmg==
X-Forwarded-Encrypted: i=1; AJvYcCVz6UoFyeDStHt6GHLeQl14VSbjqdJ7tnfxi9ei0wYiQfYGWftw4lMNq+DzdYew+dq5Xz5xXT+dIxC3v+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD3ltimrUyHgBXkFhosRJMucogLoJi9e4k4EqcfgKtzJxPGl23
	oJJnPlhfPtXlEdB58XCLjRrlCjOcVjWI8hakw8GcwAff2NbVipP5ftQlaulMlts=
X-Gm-Gg: ASbGncuq2M1CqukUoZVE5f+/bkM8EuKvruWvjQTrCBqOjioiEEN8OZYAsaUJ2lXuTve
	mCMi040ujIIAx18PeASnSXGzMGlxpaDFn47N9HNY+J23kdDybFokK+9G5uj35YTd9ncj3IjFTcy
	4Ie8PTEI/ytX9H49sqRrZBdGs1C6qGU6UJxnziVA6kG1L6BS6tavlQN8RPvB84FOarse+h+fvg9
	yZYSr7rZuEgU5PDUP5esxPUiijt/JmWe1P222Re07olDtDKCfXUABtTA4YJKMjeQ7O4KDKGNw0u
	11mT58jnH3RWIEb0lYgj74bikdjhk0rf8BQYNG/y/Yss20UIhKwieHZ516jCsKI=
X-Google-Smtp-Source: AGHT+IFlOF9+hHiNwkeX6ca8/2vV/UbK7oUM8j14EpRf1krcAZwqEjvIIPVQftAfXDqYfTgS2nWJkA==
X-Received: by 2002:a17:902:d9d0:b0:21f:6d63:6f4f with SMTP id d9443c01a7336-2265e67fa37mr149203865ad.2.1742675785993;
        Sat, 22 Mar 2025 13:36:25 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61a579sm8711798a91.32.2025.03.22.13.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 13:36:25 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-fsdevel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	brauner@kernel.org,
	asml.silence@gmail.com,
	hch@infradead.org,
	axboe@kernel.dk,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH vfs/for-next 3/3] net: splice_to_socket: RCT declaration cleanup
Date: Sat, 22 Mar 2025 20:35:46 +0000
Message-ID: <20250322203558.206411-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250322203558.206411-1-jdamato@fastly.com>
References: <20250322203558.206411-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make declarations reverse x-mas tree style now that splice_to_socket
lives in net/.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 net/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 2640b42cf320..b54df75af1a1 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3739,11 +3739,11 @@ static ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 				loff_t *ppos, size_t len, unsigned int flags)
 {
 	struct socket *sock = sock_from_file(out);
+	bool need_wakeup = false;
 	struct bio_vec bvec[16];
 	struct msghdr msg = {};
-	ssize_t ret = 0;
 	size_t spliced = 0;
-	bool need_wakeup = false;
+	ssize_t ret = 0;
 
 	pipe_lock(pipe);
 
-- 
2.43.0


