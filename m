Return-Path: <linux-kernel+bounces-174882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 376198C1690
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688F11C21515
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADA113D259;
	Thu,  9 May 2024 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DvilGzYl"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2DE13CAA5
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284949; cv=none; b=q9VbnQxGJEg+6tV5ls3WTJKuQDN0H/2hXEbIO7ZdvjL5myPl+nHygG2MPc8WKuHSuhKhVtjHvuTYjJ/dfuJKlqFca9hb+mUn1OcTgiJuJHYZWSOn/vgbMWZAzw6doFT+R++kZOZt1tzRLhNYCs8nBE49RAQj13G/kOdpXyZ60ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284949; c=relaxed/simple;
	bh=WxA21+L2Zuykor9dBqpJGTKesy/LFIZkyBfJiqKwSMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PUk+c2/+/ryZ3caPyZ4Ll3jViA5SpLa0Oy3/UvMuvoMGmnJTRTJwsSk2CTIZFa13Bw10FbbcvOjQFc72eXQMAeHjEgjHewCgub1HGCDyiF4K+xwRDMdbaCoJfZkZHZ7uAMbr+6jVZKpF653AcTKVVMWRAXaukk8CW4YTPvdFvRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DvilGzYl; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ef9edf9910so1233475b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284947; x=1715889747; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mGN3dzX1Fg/8DMWBisk+V0BflWzMHd7DBmLWWSrLzcU=;
        b=DvilGzYlCUiqWoI2SHcvhol5+mm5PgXUf1s2z+AfW15AIMFMPMxMi7FlS+JKUMVDla
         Cq6s03jYu15ot/MM0c8I6W9gaGC5FBzivKX49TJeZ4oxzmlevPtNAp/lzKhathGxcoTo
         jcpWxe0BKLn1hMaASvISxD8+Co5cBLq29a3jtrQEDdxber9nQvu4o3vg9qTDkAFKdLqX
         gRGVY2Z46bga8aMS7c+/LDfBWok2LpYga2h97f8Tkf40usWSvrE067IQwCrHJYeSZqGU
         I6fzoYai1JUyVXQZLRmqbFI/8aG15LSvy+RbTrQ1SwLiYhZy0Wbrsdht1lbRYerr6f0S
         3SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284947; x=1715889747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGN3dzX1Fg/8DMWBisk+V0BflWzMHd7DBmLWWSrLzcU=;
        b=gniI/5W8zFNsleZesQZxkNVIBQ2CpspwRljGD7fk7zJ6F/dEkrZMO17ICBzWjHTyvu
         27+Ip6287IKY0mjUm0j0sbeidM6jnHFlFFaUqSBGERzgeeosJjPVvLczmhZOMo08bfHE
         ojG60+Nx864blbkiVAtsu5cJfsCyi3uj8BLfZOQ9DYCAAuz2f3/KzAihGQDgCQv060pT
         1hqLTu2aupn6qTEBGYKkXZCs30+rttKpyVTc0Ksrnf85Z7H48Nd8FWe99JY6q1CuOeDx
         JtNGQfuZ2ezv/6iy6B49Puiw5tZG5EoYou4gYYdQBcqLnUJbCqXhuEQRiqq1W7LEeJjY
         MmFw==
X-Gm-Message-State: AOJu0Yzte8nSpc9dj7Kgp9Az9yr6NOdIWAb1q7Izlgjw5wJZzwF7dCDx
	mkjpTb0ZYJ0nm9HXk0uaXBMbe+3D9eIbb6MoP++lkB+JKXGRNM/gAZaguvD03OQgmWBuquDb1ig
	VUA==
X-Google-Smtp-Source: AGHT+IE13kb/DRTCsG66In5JbdvATNZ7UNmIfPfoP+M9Al27cmAukFzPSkQdhJiJAXpJTvsnAezDpKm1rN0=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:2da6:b0:6f4:47dd:5f41 with SMTP id
 d2e1a72fcca58-6f4e040fefamr9101b3a.6.1715284946869; Thu, 09 May 2024 13:02:26
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:27 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-36-edliaw@google.com>
Subject: [PATCH v3 35/68] selftests/move_mount_set_group: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 .../selftests/move_mount_set_group/move_mount_set_group_test.c   | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
index bcf51d785a37..bd975670f61d 100644
--- a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
+++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdio.h>
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog


