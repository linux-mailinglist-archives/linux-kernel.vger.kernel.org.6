Return-Path: <linux-kernel+bounces-174863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F6A8C1631
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F141C2310A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74302135A49;
	Thu,  9 May 2024 20:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mjzgm3TO"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FC513541D
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284897; cv=none; b=CGdUokuHFwbBo0ojLxXjYxSPeaCQtijmL1Rotoo2Zt2KbXMGmvCn92PbJF5V2yFdwHd9Q6IvOzmSEt1mZbIs0TnbCxYS2mMVXhNjZE9ux8nWLvmxHACCVZYEA8YUj2141nhajWtf/T+TYyLVXyt/wLfg+XwzEFhUZlLxsZEMYKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284897; c=relaxed/simple;
	bh=C3bR+kpQ/pwvE2T/NJgOdT8P13gcI63yQCJySRf7IgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X2QPnSsKVcZzK3BAahCjS8WanpPHJgvThdFOVOyQH9C0jLKVL9+HWIIIApocli8PkwInYorGiMYkNrl3MQkHrPBAa95wVq0sblkqrf6aUZnFfrL2WKfVB7oRtv5k5TOjf/MWkh/rmSvtkZf35Be4rcmD3wp/1lL475RW5ocQ5HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mjzgm3TO; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de5a8638579so2119683276.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284895; x=1715889695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G57nowh4j3zc6dZ0oWotSbgcBjSXunvHMbYgrgfrS5s=;
        b=Mjzgm3TOINzFdHhbrwACivH+nHRKigNcSDM/W5emIwk5hFZng5JqVxMukE9UJNyIHS
         UIfysBaSrRE+oR3Yrhdb+Pn0gVptaVI9ut75QJcSgH4o28o5wIYQHuB3t0sSQ9BhY4Ws
         bxV3TTZcp2egKigvfuT4jr943PYV4KExGZDOdKuJ0Ni1iKYWszINgwbwTeA+gHyxnIcw
         UROpmOQvoMWPzeiuwQV7aPlOVgDhzM9vvaUGsS4yirS7ITy0gd1JmUvdDFNL6oYQDH2l
         4nFPZ1fX6Bx3WB/w9Joc4HA5toouLN3CGi0yb5dHXRcmd7Sn5ZOn/4wfDtvwG9kiiR05
         MDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284895; x=1715889695;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G57nowh4j3zc6dZ0oWotSbgcBjSXunvHMbYgrgfrS5s=;
        b=OLB0rkLReINTwEh+MSeQhfVlVT5JsYjWLGLrezMTTwyk5CbbvcC/ZvvRRtEyTSOouw
         2CB84ynoMkYjyF9B/ZmeDVCubFxz94Crx3j6xX2ybor040iXbGmv9rn4o8Uv7kJT0Bws
         MedjmqmHpD/xTN7c1w4mokdf2p70SL7sMSRjMD8bUK9iH3+U1LTIKRqC85hrOkJlaiKe
         VufkhetkCxGSZ4eavGNweDrH3ButuFKOMpi6h2DVi8Do85oOzvOb3GJx3mFhViv7+iFL
         p3aTtQzMRXc3sdRezvDZFKRA5Nis8uW5/LqPZGsPoVTPtTgv8M5n3w/3ny2F3hrOWTwO
         pAsw==
X-Gm-Message-State: AOJu0YyHxjY2PF83ejrp0g902hXgunfhr2cvwnWzOydMgtfykAFqbKb3
	BcrfSZ82C3Oq5KDXJmoXvA5bZZ33C7Y90dpUguSuaF8jbrRwfwwkMD9rnDsNSosZiZjIWx/azt+
	qIw==
X-Google-Smtp-Source: AGHT+IHoch+jGmejTUt/KWjoMuZe6CHm+ujySJjPOe4GFGCIUbS8DO634gokWfmQQFi6/Nyn5DWYlXv4Q1Q=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:c11:b0:dd9:2a64:e98a with SMTP id
 3f1490d57ef6-dee4f30134amr46466276.9.1715284895465; Thu, 09 May 2024 13:01:35
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:09 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-18-edliaw@google.com>
Subject: [PATCH v3 17/68] selftests/filelock: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/filelock/ofdlocks.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/filelock/ofdlocks.c b/tools/testing/selftests/filelock/ofdlocks.c
index a55b79810ab2..301c63ddcceb 100644
--- a/tools/testing/selftests/filelock/ofdlocks.c
+++ b/tools/testing/selftests/filelock/ofdlocks.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <fcntl.h>
 #include <assert.h>
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog


