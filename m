Return-Path: <linux-kernel+bounces-175116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1375F8C1AAF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 990B7B2380C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BE412AAD2;
	Fri, 10 May 2024 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NfPYhVCZ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A507C12A163
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299804; cv=none; b=tC/T442J8hRUysCbP5ZCNukJo5X32kX6WGow64G2COiU+d0gOvyl/pCx/8cEuPVWNrVTvezvDrt6osqjBSjqEKkGsQp/Wk4jBou/jucjFu4PTbp0c+i035p4dR+cGtcA3/RAcqtZyZH0Mp2V//Wvp5Ys8fOlzBfojJavFz1e3os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299804; c=relaxed/simple;
	bh=qbmkyF0+P08/z/Fp9ZayOXH0wErOspB3sKr8OqJ3zqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sf/zgcjccJR1smb959OCRiDwHLzF6ZQO03eoN89049XV88Cl5ysQXX8sTzsGI5i+VfZp4qL8Jlv0sXpR4OK1mZL7HjAZM66q/tVV1ZausRN8Yz+OgmjfdNxfY4VftpXvRuLMsNlXzaQBP3ntNmdmXO4oHtauM5gM5+cHEAvkKFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NfPYhVCZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be23bb01aso28184217b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299801; x=1715904601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7gmE/+1tJ7Ep2oqmr2taMm5VZCwXrcQv9eKCkUAc/7U=;
        b=NfPYhVCZw8/6vRnxi5mwooE+sTm/zS4DcErqO33jFYRyYjxzUKVdolwxgomkX2Ur0R
         l65rmdSEdY6cSGQS/D6c4smxibXHNbmVgSLEge1gTtRdZ4W68jzDEsAWU6Gs72xLTRL8
         4ouG9L5f2HTZNxuyhOd/8DyoZlA7eXJ/uJ+PlXoY9PXE6k9MRljXDE47D+2hm2wrheGb
         SmTsrODv/3QPkAQm9/qbZcqKJ6r6FtbKdH9eyRlM55uvZSBjgsF0uIPMyUejVOpn7X3T
         MZZ9Okt7kpx2w7E/mv6ekgov6pH+DfgUx7XD+sVAV1arj7MSiefc1FLNxKnGYhdow8tY
         PrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299801; x=1715904601;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gmE/+1tJ7Ep2oqmr2taMm5VZCwXrcQv9eKCkUAc/7U=;
        b=MQIG0LSNzSTx4dlXzyU/IQ2xkaMQ91tKM0/ZKhiRYBfCvzX2eaqrp148GHf6wcBrwU
         2hw5PzM4foHidhXoUI+a52TteToxMAyriyiP4RrqK0FG8o20jwhyIBE3BnMaL0s7V7pj
         TPiwiy6gX7bf2nsNmyFgBi0z/XynHXPFSi8o0CatZ+YzQgnke5EaVa1jjiD8WLH2Vthk
         EV6hv2y+7Kk5PeVkB4ybo6aTh6fSMgWI7gfJDlfqIUkeSPh6mQzScg+sHXI+HDRU1dO2
         KGxVWklW3X83d7tyLK5vx5T4oaxrDulzBgSnE9QlCyaZqhqmg2bHRB/PWfa5DqKwZsKy
         xaAw==
X-Gm-Message-State: AOJu0YyMbVZHF97T1s6wx8mMg0sBK51JVxy+HGzxtct6NcNXeM9r4LId
	l7GjupetO7+lPoamjD/PopLWTGFDkpBqtTlpMe25rlZM7yxcPLbSLeoqT4auwqZajkkZ0SnFVjD
	q+A==
X-Google-Smtp-Source: AGHT+IEoDu0ZcQdyPuiQJKnDncyGUY3Booo+z0EW8VBY1J3sHBK3DT/V9Dd5nwidmRrvGe1vHB9FlAyGRV4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1002:b0:de5:9f2c:c17c with SMTP id
 3f1490d57ef6-dee4f37bbfbmr289205276.9.1715299800737; Thu, 09 May 2024
 17:10:00 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:37 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-21-edliaw@google.com>
Subject: [PATCH v4 20/66] selftests/futex: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/futex/functional/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index a392d0917b4e..f79f9bac7918 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
 LDLIBS := -lpthread -lrt
 
 LOCAL_HDRS := \
-- 
2.45.0.118.g7fe29c98d7-goog


