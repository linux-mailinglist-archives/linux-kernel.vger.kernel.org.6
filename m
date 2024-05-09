Return-Path: <linux-kernel+bounces-174886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 013248C16A5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF28A28B1C7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F330C13D888;
	Thu,  9 May 2024 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gRxG1DeM"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD3B1272D6
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284964; cv=none; b=uFsPg+Y/g2Sk/L3HydSzHlOQcmTfOY+q3TadCl84Xr8WQVflCZ7zkX6qfIaoxXKNcHHBNTCK7nYjvVgDXGT0peCYucJsOqe4tz3WGO/oYcHiXYoDtR6FsNkXCkzNBOtBr7Dr5oYhn99OrI/rmj9V3T5GDTFw2CyGu2gN1sb+iUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284964; c=relaxed/simple;
	bh=DaG/27qWh2/JZ9Z87R2vLxvxszcgvyNhPpNxQzRNES0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bxugbmpv4LsO5+NaCC6Up2alRHN6zjm6ZOqy5WEXTeKofxYR+vx0CyEH1jt8N34mTpHp91Ikrn5fvLVEeGYllfO5VwGLz6jyijmHdMMoP0p2xceVVNuRTbjNJ+0y1D49vjoKpLJYiopKgMDO3BiKkb6Btr8KCwD/GnIu2Smg+88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gRxG1DeM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ef9edf9910so1233789b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284962; x=1715889762; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m279s+e6M30hZxl/PZzqmSNhzRgg4yVrloVP9fngHJo=;
        b=gRxG1DeMUp8MWa0CV/ABlrv1NaJpJWM8QNLH0u1SYQcBEzZAeB9HurZVJwxcvmVBgA
         aLYX9G/JKMVGwGT8mxD4d/XOMON9M98ZL9LiH+oppQ/AX48EuCUYcvlmx24ulNKeFLP5
         6TTHz5D0P6ItdykHyqqfpGWQssUBTWypUqtsbF8QtWDI3eN/i99l3bMKRCHI672xl+G+
         sEVM+ekmhFbnX+T88nT57hMlj7NiRYkiKRxr3ceyVh7CgmCl0PMTIENtbjrP2zRwda5c
         3X97rgOWbE9aVqR22aLfu+wH8Jt22/HHbHi4mmOZeUuJTjxykUu6u4PM1Ajh7pI8B+nR
         oUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284962; x=1715889762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m279s+e6M30hZxl/PZzqmSNhzRgg4yVrloVP9fngHJo=;
        b=JZeM+7/OyvsRMBJjQtNrA4enMj/2mRgkMeMyQJl5wUhFIYKpbb3LRUFrxO8PVXJIe+
         nv8HcXD74viK6bYr/lw+4iPIJ3CCqYIaYMIjan1+bxGEyS8dmcXdejv4AJwarAVgxKr1
         bgu80f4FeFz+9UHEkN6bnpLTXs2rhGB7X40XmJTb7wfb3+s4OHySizFFT8qJ+UXVlBbz
         kg2vhYiGhq/BpDYzfwRZht4lYaEiHEVso7p9lSD4NUuywqi7RWDdbN5ZxBNm82zXJ7H/
         AlbclMmZ+PusOktX+vmpP/HBTLUR5Rn6OxMKcbNm+0Av+oM/Y99A48y5t1DikMJ/ZYNc
         1QMg==
X-Gm-Message-State: AOJu0YwjnB1wlmT8SYKEJ11b7rFW+a63DYHA94qJYKjfq2oLm7VTPmBl
	PFiK+bv8xhBXLzbE3xIOfnSZarOyIz5+W73iZAKIEhek8bJyquOkgy8QeLM6fonWx6qYWPNJRzp
	OjA==
X-Google-Smtp-Source: AGHT+IGCr5mZelKS9iX9bRXqnB7kjyhmCMgwx5eyUHoa4Y3/aN3G/xPHARYQx5VNmnnQO5Sez15H5lzxkdg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3a0f:b0:6f3:8468:432f with SMTP id
 d2e1a72fcca58-6f4e0373b47mr9098b3a.3.1715284962387; Thu, 09 May 2024 13:02:42
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:31 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-40-edliaw@google.com>
Subject: [PATCH v3 39/68] selftests/nolibc: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Willy Tarreau <w@1wt.eu>, 
	"=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <linux@weissschuh.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Edward Liaw <edliaw@google.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 94bb6e11c16f..a28813f4367f 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1,6 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
-#define _GNU_SOURCE
 #define _LARGEFILE64_SOURCE
 
 /* libc-specific include files
-- 
2.45.0.118.g7fe29c98d7-goog


