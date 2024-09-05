Return-Path: <linux-kernel+bounces-316390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A96996CED8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031B61F21C0E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E9E155C9E;
	Thu,  5 Sep 2024 06:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rwHzKx2M"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F28338B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 06:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725516040; cv=none; b=PsawPRD7TOD0zgo+JRDWruBRmgkzZOPaVBK3+RQvhJbq9gCPRh6oYuK/1Vl58LnvsSDqdUeIdXCrZZHQyRKpOOIa/WmuDl2qDA1kH3uAz0vjx8cLXB+D01sDj2ClZbFhbAj7x6dbdRZvpLiT/LFlX6ftUzx9OZdsfpqCkkr4rxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725516040; c=relaxed/simple;
	bh=4g5kMerys2sTSQDIJ5+U/3yJ8VXd2R2vjl68tQymULQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DURn3Q28udJDnwiTWg+jfMJn1lsQv4o513ZStCwck0Y2Hv1p4U6FwUWrYw+wVoLO0xhe/GL+0QiLm7VOcUgr22A94XnBQ9JFf5+R99h8ZkjAw35g+WPXmjRfjYmBcxX61f6Mcufas32TJpoezyND7aZkkeBltmvDGEeJnmbAeSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dhavale.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rwHzKx2M; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dhavale.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e163641feb9so1153122276.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 23:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725516038; x=1726120838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+FW4uWV3KsYQNjcmHOkTPMyGoi7nb0utfin/jBmQE9I=;
        b=rwHzKx2MZS0KznkV5q5BpCvr68upVoyGvIzou/DGVZsMxGETiAhZoze3XGy5Q3v1yx
         DRT3tcxqEnZ04lftXig5AT6iqOaEym09ctvd3XTeH+ju8VEMbBnFJtrsmj1leS6H/jRa
         CfaCGbTTKG9zc6Lftv2tb4J90S4KLVBmTlwEzLEWxFoIcRVYs3TAXAycIzUe95UGzDFH
         RmCppIhUyoMqUoaWszff+q13XvZ7qrOF4oMUxGo/X+psbrE4LMEpn0wzX0NA1h6kO4fs
         qAnlECWe9S5wefOiLbQ/jUJxDVaE4jYZqx/lZCKfnJG3yeF8g8dsYe5kQ2iWtupx1Iw3
         +DAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725516038; x=1726120838;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+FW4uWV3KsYQNjcmHOkTPMyGoi7nb0utfin/jBmQE9I=;
        b=dZITaf2wAp08ByBoxaSwrBzeavuaW82avq6GSgErx/fdU5FXLmkeuDWxMKd8hUBCNp
         wtctPhyvQ1LLN7ZnlbPWW6LxtRejC3ws6zos9egUzYa/gIDWCnwYEcq2+kRdcrarzmy6
         CjS7X1zM4AMDqowsLpwxd720uNUooBkbrTPww1+KpKDlc4y9AjWoKTwlWXCPNX+U+sph
         KaHe8cn6KQvUBqCc/aAy86GUwenSx+9SgD4mfZgBQHQizT2loJsi5RcsgVqvySF5k3uz
         fVZHzc5a+5WNvFfT7SFJxJpsfGASTC/ZYgKvjyY47ThvDsF1d70Za7GK4T+3uNPUrAdO
         Zr2g==
X-Forwarded-Encrypted: i=1; AJvYcCUySt0/jnkKMrZocd7AWN7+n8krcPWfSo1ektCH9YKwrMmqy3XG36Hwk9Q5AYcWy4MXDbLlxl2UMlSvDks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRf3QWTbYPUTbPtnHnHBhJZ1XQCpMIRRMkIuo07SWa+H4Nb2OL
	Tc5gCUuulTyCGhZEpOpyJZY5TkXSJRiqX8JEgUVSjCocww2rn+x4osXsFN6SWy1x81Lf/7/2qzE
	28fI95w==
X-Google-Smtp-Source: AGHT+IE6/jdtxwjYePtJa/mQtCjuubAXd488dazZCbWcyNhof90+G/ZC+ClSd80iROQFjFPidRmr5wz9iYxQ
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:8304:75e2:42b7:538d])
 (user=dhavale job=sendgmr) by 2002:a25:83d0:0:b0:e1a:7eff:f66b with SMTP id
 3f1490d57ef6-e1d108a6462mr49795276.5.1725516038160; Wed, 04 Sep 2024 23:00:38
 -0700 (PDT)
Date: Wed,  4 Sep 2024 23:00:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240905060027.2388893-1-dhavale@google.com>
Subject: [PATCH v3] erofs: fix error handling in z_erofs_init_decompressor
From: Sandeep Dhavale <dhavale@google.com>
To: linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com, 
	liujinbao1 <liujinbao1@xiaomi.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If we get a failure at the first decompressor init (i = 0),
the clean up while loop could enter infinite loop due to wrong while
check. Check the value of i now to see if we need any clean up at all.

Fixes: 5a7cce827ee9 ("erofs: refine z_erofs_{init,exit}_subsystem()")
Reported-by: liujinbao1 <liujinbao1@xiaomi.com>
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
v2: https://lore.kernel.org/linux-erofs/20240829122342.309611-1-jinbaoliu365@gmail.com/
v1: https://lore.kernel.org/linux-erofs/20240822062749.4012080-1-jinbaoliu365@gmail.com/

 fs/erofs/decompressor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index c2253b6a5416..eb318c7ddd80 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -539,7 +539,7 @@ int __init z_erofs_init_decompressor(void)
 	for (i = 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
 		err = z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
 		if (err) {
-			while (--i)
+			while (i--)
 				if (z_erofs_decomp[i])
 					z_erofs_decomp[i]->exit();
 			return err;
-- 
2.46.0.469.g59c65b2a67-goog


