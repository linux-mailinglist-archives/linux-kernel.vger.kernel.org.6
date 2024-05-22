Return-Path: <linux-kernel+bounces-185614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FF78CB7BE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1562EB240EB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B5415216C;
	Wed, 22 May 2024 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oN5K997C"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBC61514C8
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339685; cv=none; b=NBtuYx3JU4j3aKVism2zKBHBvXldw7Mwbn66w6cKI9/bCM2M0nb+FzR8nVY7IoDm0/CBD0BxyhMABRcwAWuzQwjb0Gqr/5mkBfc0zD5w9ZAaHKWH2PPJg2MzSZpqTl+mWBPtWQsx767QrZuZQaUkuJKf5o1MN7FYhJV/6DKqMJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339685; c=relaxed/simple;
	bh=XPidHqKZJs7ktRnj/rKRN9OSO+QDlu7k9DcihfIduBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xe0qO5XFhDRDF/HWIDZKTmY5OGZ3FEgGp9kQFIC+A8YM1rDfGgk1b0iNu1UJJVYept7PPhRRTY/FPA5Ig24XicjgIjf9HxuC4hOg4z6OsJ9CVxa/gRUuRhghN2J+SmgwCdQVDmokqXvn9wSfi3LmuDQDYW7K26ikpHQGx6jGdwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oN5K997C; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ee3b4f8165so130162405ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339683; x=1716944483; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K7LYN7Buhr7rix3hzdieKTkVhSQ5bSYYW7kF2VJ5jtY=;
        b=oN5K997CmfYJ3ELVNWeymfY6LovFM9PWmGcQl4KhEzDu067hqfQeMQwKC4WgjIqaPk
         SmyXS6ggpQ8B6aQoSz9zPncsGtX4FubMucUhN21ucruVzbn0wHlAEW0+Z53le5SXj/iA
         IjRMs4v5AIbNyuGmmsdzy0GvXH0YSThyScceFXNkUSscJMjYMGmSzzxk8c5621kv0YjJ
         DK3J+YEoFn/52elnC0Yg7gIUofr8Eap7zFYqLCCJFeIqnVNwsmKufwgQiOWywQ2mPHjR
         Aj+irnUfBMs7q/kd+nGC06zHZStjngQ5Ylw88V1bgeWtaL1m9CsXtUt5F+fPPJ4RlOKH
         mEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339683; x=1716944483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7LYN7Buhr7rix3hzdieKTkVhSQ5bSYYW7kF2VJ5jtY=;
        b=RQAvmDRQ1p2TKWFwxBMA4ltlDBUkuew5QdEerdgSEI5WL3l0vbiCn+DQfCmuejftJY
         /kym7lkG9fO7Jhf5sqRWIzwlSQEBbJJz9/8kPwOZlyFzY4Cw76k/CQ0WlzWtSLyW4Qih
         E4FRX4l+f6e9u+feSESmIAYJtc4BUW2UcJsifL/rguKr7fFTra+ceeucAfu0cpCFc6ka
         AIpSo1GJkJXV1kLOlrflIpoqegc3deSYKvFgRO5Gk836F7nSQTQak+cUpTY2TBMTC7T1
         aIA/o9UrbsOkwGxOKvQ4C4f0hril/NHuEJj2S9UnKiAf9nBtOEza13fkHVniILHmjg44
         sPBQ==
X-Gm-Message-State: AOJu0Yxftw6M8DCQyKfOOwYAC93UhaSe9DK+osnV0Xk+vd1DKkuIdwz0
	v7FlPYEvUEBYHWg3pEqbrjfdjHobggQh/hL5hTJesVxDZ2gHMdE3/oW8Oz44TPn6tqKvOyCCsFz
	l6w==
X-Google-Smtp-Source: AGHT+IEKTKEU8i8LsxKnc0jl8+K9ZmtrZEux+7ecvL6WO9wgfYI2cFGhBFXoIp+rSur6ZMbWmmU9SraeSmM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:da86:b0:1e5:10e5:344 with SMTP id
 d9443c01a7336-1f31c964eb8mr40885ad.3.1716339683060; Tue, 21 May 2024 18:01:23
 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:24 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-39-edliaw@google.com>
Subject: [PATCH v5 38/68] selftests/nsfs: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/nsfs/owner.c | 1 -
 tools/testing/selftests/nsfs/pidns.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/nsfs/owner.c b/tools/testing/selftests/nsfs/owner.c
index 96a976c74550..975834ef42aa 100644
--- a/tools/testing/selftests/nsfs/owner.c
+++ b/tools/testing/selftests/nsfs/owner.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <unistd.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/nsfs/pidns.c b/tools/testing/selftests/nsfs/pidns.c
index e3c772c6a7c7..9136fcaf3f40 100644
--- a/tools/testing/selftests/nsfs/pidns.c
+++ b/tools/testing/selftests/nsfs/pidns.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <unistd.h>
 #include <stdio.h>
-- 
2.45.1.288.g0e0cd299f1-goog


