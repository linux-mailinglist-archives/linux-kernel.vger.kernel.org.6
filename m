Return-Path: <linux-kernel+bounces-175152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A9D8C1B68
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453AE1F200F6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A2F13DDA1;
	Fri, 10 May 2024 00:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/IBZDgJ"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066EC13D8BC
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299905; cv=none; b=j3JEFH7isDE6hCce5nVXsOxCCf8BefBE+dmmeUwZNiMgbZDiAzOLrkJhZZbtfdovbSCzVkFg5tBblZhmtM0/9uwVa/ablGy4D8aBonU5NG8WUj0Rd0ukbD78hElBkPt+WToE1LEbvvdqPHGM8RAIf4H97+8U8dkFHbwTLdDCwmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299905; c=relaxed/simple;
	bh=+sItl3NA1283go5M9bQJeU6wBJ4u9ILtYGKec/4SU+M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FCel91AWhGhBy06JRlg73bHcM6T8UcMarnXJY5Tqlv8Abz5Nl0OspXMYkApBUGCc2/aSCHoMdF1mo1hTtxWgd+x16u3AVFEzKcYEy6UcbcisZHc2472Egd6p7jHu0qZXoRDkIiJrShuCMJ3l/fXaY+CAqKW2tktSlxKvAY+H00w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j/IBZDgJ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f474d5a8dfso1009895b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299903; x=1715904703; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8aFdfEWt/7k/b5Ocj8/yszbVTyEkIpeJxepTUQyb5mg=;
        b=j/IBZDgJBixITROWdSoUh3EMJl5FLq9rkLiG9WDGzdfWhLyOCsEhBBeJ0klsUnG+PJ
         mMu7w1GHXvsguldwWHKL00EEbCE0sgi0AaGaO+U4NBtq7ds/66eZG7zS7SwIQn0tfjui
         zGfe4rD0B0DfaJ0CR4O0YPfcC4iykBUlIBmkImwlpct3NkHBph7icpPOxHWsH7KMgEQR
         tRFQDb+AHAoX4II1XL8AUIsH3VaYb8UV64d0wY8N5/0X/MBJLtN/0/ay1Bvto7qyWmNw
         NC7k9ATRWDyIUTWNjZRn/1FdEDtNwLBthL9m5yA5aIkDTQE5ytft7lUEQQ4dYnr/dTT0
         PDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299903; x=1715904703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8aFdfEWt/7k/b5Ocj8/yszbVTyEkIpeJxepTUQyb5mg=;
        b=kGxmVWqlnlQPMZj3zJLunZ/tEWKmkPBBClynH8VzGaWNhnu1NjNpeJSEpAgV1GEPqb
         Qlg3c08ermdkuK7RkwU58Mrj7UW8jIE7tCDrMOiAFImu4r+hU0Mol2UjXPMswkkOtvux
         0b9IVNQuwZCoFQNZsLStuIXbI+ln1ql06XQvlZjRBv/lBx32vm06sozAXLhuXvDekEDI
         7IJYGLVe5gqc013DQyO7K8TarSsbG8MgcSayWr704O9GsqTeZDcgeEvzEyM4kdl/Xx5f
         hNjAq8ycOUpEjuSKtj07DDI5by/S48SlrBLNECHXutQ9Kf8zr2cKV4+muT9sIvk1X2Su
         Zx4g==
X-Gm-Message-State: AOJu0YwydyQ7kRz/1kmRlLvtsFbBflA+MFWHizTJoNnlSwartizCs86S
	zcvzB1HoHXgljp/KtPV6JRSGq60IwxWkWyN6Fqyv20iFMp5jJn+c7HOVmQ6IuQ+zEJJP+/zmo19
	slQ==
X-Google-Smtp-Source: AGHT+IGbpUeforMn4xLMD5N1hyX2TrG0gSGZyFXuPe0hRHFj81tMrWmYRZqjYHTnolVlOz0QL5y0YD27qvs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3a0f:b0:6ed:416d:f7e with SMTP id
 d2e1a72fcca58-6f4e037d8cfmr68300b3a.3.1715299903347; Thu, 09 May 2024
 17:11:43 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:12 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-56-edliaw@google.com>
Subject: [PATCH v4 55/66] selftests/seccomp: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>
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
 tools/testing/selftests/seccomp/seccomp_benchmark.c | 1 -
 tools/testing/selftests/seccomp/seccomp_bpf.c       | 2 --
 2 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
index b83099160fbc..3632a4890da9 100644
--- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
+++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
@@ -2,7 +2,6 @@
  * Strictly speaking, this is not a test. But it can report during test
  * runs so relative performace can be measured.
  */
-#define _GNU_SOURCE
 #include <assert.h>
 #include <err.h>
 #include <limits.h>
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 783ebce8c4de..972ccc12553e 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4,8 +4,6 @@
  *
  * Test code for seccomp bpf.
  */
-
-#define _GNU_SOURCE
 #include <sys/types.h>
 
 /*
-- 
2.45.0.118.g7fe29c98d7-goog


