Return-Path: <linux-kernel+bounces-175138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F131C8C1B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC060287736
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10A01E481;
	Fri, 10 May 2024 00:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OdR5AmzK"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE26139CFB
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299866; cv=none; b=qswoS1bwASgvHAPWRKGGeipwFNZnV6x8d/Kl+U6/QQkBostXwP1wF1NfAju8EA7yVwbewSXzZEpgXOMF3KVvQQJXXpq7N8G5gEiLLrpVpXertZYzgz/A68xffeb0gte69HAtabhJ0x/ANmR0tT6qg+lYWQikjf0xFdNTqwNEzPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299866; c=relaxed/simple;
	bh=F2h5TqE2gznk34Xcds+2kdj8K23iiPRCWyz0VnUXgXA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lFWCHDL2n9zrW+LVY7dOp9XdaJeHKzXyh9tk8gbwxTn/BVWenh9GQohewKTsntFcbY6HEI7J36WmFpzVV7e0vQ7Ys2Hjn9umjIwiCqqj9egVUb5NKDapLlkf0cwaMY6fNz0wMm9kVHo2rWdGOHcljHEctWfUoNw24SfaCfWJhI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OdR5AmzK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ec6de5fff5so13644685ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299863; x=1715904663; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bwoIN6qkNAvdiVIWhe30F/ZM8apUP9a8ewoMWfm8QMg=;
        b=OdR5AmzKxDF2VeWbz84SkamMt5Xs46lx2Y+AmngwiqfwOjgv+WLgjQo0LVMdSM3ztE
         sZ6rBe6/JLjrfh875Ucpx8QPWEOSO7BtUofcmxN49SBSXjBy6bKXCghqQU66IXGh9F5q
         DTfUg69t1wwHXSgZuIP+TDjiyrLPQOhQjcYfFLCx36y7dY7AVwBhgKRsQw9jNf7Wlcuc
         9McSjxKbVX/ljwEcbXrx2gH2l69tLpvqSROHhl95GSvqhspSvZjlx6okqUopw3n6gTB/
         8XMqW9eFaU5x1sSoCJpCKu9xRfKr+QiedTj8bJ27fNpj3wMqW6h1VbYN3NBcXw0SA6u9
         FsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299863; x=1715904663;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bwoIN6qkNAvdiVIWhe30F/ZM8apUP9a8ewoMWfm8QMg=;
        b=HynZZa1wGQISpvJhPgS+5HIL1Qeu7WgLOr/0cNTLYDRK8ccVKMs8PVPSv3Qj6RQoda
         A/YciMkwP/XuRRdDxa/5t9oZCqbhWbI/vfvbi2o7EyRrxkTFFLvsFwg7FyQ1cdKr68bA
         bEDxQMWE+Z8mk6uQ6uOUr2icTR3H9obwfTI5O10kLdV/2TT98j1e4155gMdrYnpebx03
         p88/rYGCWSWVSOdEBduPqZHbSSKhvy1vVma3b4xPjaFZR2Y5B+ndeqwXmqvT2oyt7oR/
         RvkvtuGJFU8NabMFgg8GH2lexIrNHo8vHU32XG25MUb4B8MXN46Qas6ZKTe3cbU8XMgT
         0HgQ==
X-Gm-Message-State: AOJu0Yy692iprdhjTDwyeaM3mm51dC+57EMsdxLE2djYrkSJbWGGjVzj
	CZw6iIBjGkpiH0g6qOgvOrYfuNEJwsk3igvA3vqJfyBPwBKToFz/d4kcPDQJnBwozCllXeOMypE
	RKg==
X-Google-Smtp-Source: AGHT+IEbRaO3Ij2eSHkGXoI8SykX5P3OggNnx2FkEhJM98+CkdTeaw/WmnIfTcZIrruC+KD5ZR5dK9HYN54=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:e549:b0:1e5:e676:4b0d with SMTP id
 d9443c01a7336-1ef43f4b57cmr31935ad.9.1715299862877; Thu, 09 May 2024 17:11:02
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:58 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-42-edliaw@google.com>
Subject: [PATCH v4 41/66] selftests/pid_namespace: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/pid_namespace/regression_enomem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/pid_namespace/regression_enomem.c b/tools/testing/selftests/pid_namespace/regression_enomem.c
index 7d84097ad45c..54dc8f16d92a 100644
--- a/tools/testing/selftests/pid_namespace/regression_enomem.c
+++ b/tools/testing/selftests/pid_namespace/regression_enomem.c
@@ -1,4 +1,3 @@
-#define _GNU_SOURCE
 #include <assert.h>
 #include <errno.h>
 #include <fcntl.h>
-- 
2.45.0.118.g7fe29c98d7-goog


