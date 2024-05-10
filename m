Return-Path: <linux-kernel+bounces-175109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2360A8C1A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70421F214E0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5329051C4A;
	Fri, 10 May 2024 00:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rF4v9Jq+"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFD2502B4
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299785; cv=none; b=nC+IMZSjUlyCKtOYC+WsIiUdjeyHKzHs4vPlm1T4ALmx1O4+BO2zL5gwNB3TUKzm/ECopp1Hkxp7bjEtUR17FPmh1BDNbRCkSnlexkbk6xDvrfFEQN4iyQmLUuGnqQaRYnTM11s/S/+gu0gg1Vq1FPGkQkza7dF453/9jngLU/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299785; c=relaxed/simple;
	bh=Udp2OmpXlPrvNQk3Kk+fsTuA62Oxv6sttbB301xWHNg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LaxzRZXOqktHc40CkBcPUIRy+me3BPwmQWNc4lARRUbKORzhORo/7s5vNha/e/5ZC6JoYs0+fLPASFs3mw3LYF1Ji4njEcpD26/kNhhND5p5kQf2z4Yldgpge+VX4q2XhSoJ7IoTz7G5BaDlZf+f2eut+1QYs8x14GqpR4b3Hx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rF4v9Jq+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b37771326cso1397250a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299784; x=1715904584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nD4EzUbRtbWK7TkNHEGymGoceFYTK3zje1jRLglZ42M=;
        b=rF4v9Jq+ytMGciz6mwG2yUozziLG6OiICQ9rdOWAWiLQAtPXvcqCRN3H0ODjERvxQn
         b6/NbLXCYJuECI1w/mwd15kiLhO1dwwA9lJJYBcjO4v8RMeJXAYsEWIChpG20hxFSwGj
         SL8QTZ0IZWrgnBO7th1g3wYeJNWL49QcdTRExcwclXvT0Y2jyiknuMZQXubWunUMO7vF
         GVjpEmqTDOgDqtKSuCfkFjjgKNbl4tU8ZhJWOZ6nmwnZTzQe4YxhHDKdcgfaL9IkM8lx
         FYLkzDMxc8mIzOn+EAEQBpF6WsB1bisXZNWMIZIdS76hot1Z6mFogEdsI6Ea53wBblFH
         a08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299784; x=1715904584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nD4EzUbRtbWK7TkNHEGymGoceFYTK3zje1jRLglZ42M=;
        b=BaBNTlhPZT88a/mrQrpoHdnYEMB3Ktc0+VQ4rkeD/Yw72FrV2sY8zfL3Zrh8dPJ2mn
         s7WcAAWKQMQ8/EF0HxNhYO3jOCWNGd+1YtNUhRT9sVyiu8BawAgrGHu/dKKwDGLVvMbW
         QKgV1NDzmaA0lzzrJw2qppbhuwxUO8xWo6pP85RzjOChwN4XEPvn66nkyYUnXL/HyAh9
         yQvToxen2IjfK9Ur4B7Qgb65MiocAIUE7XMkNKdw0fMnQy/baNLRflN9MCMDv6UTxOa1
         ADE1i1Ocd1Q/CzS3Y0NYLHdNhHW6BX0tyoZTROeS+NAaPuGC1knAW3KEVfHoHbQELLxN
         j8dw==
X-Gm-Message-State: AOJu0YyIDW35BiqG2IRGia9Wg51bzd0KUnYmYvtRO/qW9phXLx2VwOiv
	cUWlg/BE4EBicjjUU1V/+8HaMJNRj3x6bFOg3BmfnxPt0wNDWr+0tVpgPC6liHJcjaxWnEzvGkj
	Pew==
X-Google-Smtp-Source: AGHT+IHxMR6Pp5SkTVMeBaev3opCRzONt5mntrRWzWl6NBUoxiLz/a/B8LNHqFeHKuHis4padRNmU+oftSc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:488d:b0:2a0:40df:2f57 with SMTP id
 98e67ed59e1d1-2b6ccfeee89mr2677a91.6.1715299783557; Thu, 09 May 2024 17:09:43
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:30 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-14-edliaw@google.com>
Subject: [PATCH v4 13/66] selftests/exec: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/exec/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index fb4472ddffd8..c5bdb653422b 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
-CFLAGS += -D_GNU_SOURCE
 
 TEST_PROGS := binfmt_script.py
 TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
-- 
2.45.0.118.g7fe29c98d7-goog


