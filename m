Return-Path: <linux-kernel+bounces-206932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23681901003
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6021284458
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 07:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BFB179958;
	Sat,  8 Jun 2024 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXmgVPsD"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E327178CCF
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717831948; cv=none; b=aIssiA/w+5Dh5nqAaKAMh0KhM8qC/iCtHQmZB9W3YcSIk7KGzm0FtBTnULudS61+Xy6eLiw70DsEiYeOyOhfrhcsA112iBPvEZdzUQootN5AdexyGALy4XToMzg7QjoPsDJydNfeSo3U/GKC+IjJ2i4si1LWbyk8qjyWzWCmRBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717831948; c=relaxed/simple;
	bh=3jOy0+txvht60ez96hmeG/ql+B41viAQYPhyv6P80DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtiw6cltQO3mtcrx/yqlP2GUzkpLKAU4uESpZzWcL+DakTtPExQKMjEziMY3V6DxYMEQTxL/mcHk1pA3eIj70dllDs9CkhxpmLF3WjMxZye7tG89aUniGgG7hs3GYJwGNEv2b6GzGmLlvP0evLkiI5y1Ct09nXjj57+vErk8s2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXmgVPsD; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57c6afa1839so216886a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 00:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717831945; x=1718436745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zf7ANtS8cwkA5oNK6XZKZnn2ERXCqFjIJiVktSlvH9Y=;
        b=MXmgVPsDDCzkpnhFSTVpx5VNcdzcC5ydJbfGnLMuMMNT206afb2czIiisqExqBX3Ac
         FL+F91+1offKheW48tlqa/C9CmcvVkLj/zrch83WpJFJ3APjSzKGOPssmc/ifavx6u63
         Fe4gy7o7g+3dFvBJl/achxlOYumG4IjsHGlRdZoRPu58RgCPTudzUD1KJSCex+QI6iHE
         RtvJi+MNJzziLzr56GhAw9mnncKfWDu4n0P1yPt+PrMRPbJVSJmGDSXxZzA4HQvgahZg
         nll2OikdpITaXZ4ZzFXvyS10sYzDQsNxzSKSGrblt01imkjF71OsKGKFtbFkabFNvq48
         J6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717831945; x=1718436745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zf7ANtS8cwkA5oNK6XZKZnn2ERXCqFjIJiVktSlvH9Y=;
        b=BPKmSs9mUje/7lMr7vEYMldhdbIkQELQMHXVl/ieL0nQiEnoCd9IPaa66Sk4CC+lCj
         6U4cb7sdGEz3sA7unmo6ubcbtIaVdZ6b+OBTfn5ES8w4YaoskwOnzM2CiOJxQerCxNSt
         sTnnxdi4/opGP06k5oW539rCArIzkHy9CiniqgWWU//RToOD1u1NrFlA5qpA9rWlrMUS
         q/NYmLxvBsGo1Y4szxHOzTfLxN/Ll7/rJbOZ7AhEHThr1PNFFJ7O1AymYsXO8x4Hspq/
         9MSkqpViyC3kxu6Fk+lZ8wG88Id3qRNpAxR7s9SnT+4u+QpwCrWzq7UYEj3pZfr5hMru
         VQKQ==
X-Gm-Message-State: AOJu0YxW6v7Q/hb77cWgYtV8yNmQjtzKjA9N+wTcq2pVZZdwByoejdIy
	tFhOewNPQiyvNkT/m/ZIpB214Z02DsZuqT7UOS7U0ghTMP1X6Iq2s+mMwW+q
X-Google-Smtp-Source: AGHT+IHVVtvDxCkTdPs3uVJYh1UJd45asf9YlJ0wjDxk9YRQbnNqlSPploujPmhc18KzHzF8N3PVng==
X-Received: by 2002:a50:f695:0:b0:57c:71ca:f651 with SMTP id 4fb4d7f45d1cf-57c71caf6d2mr151179a12.20.1717831945138;
        Sat, 08 Jun 2024 00:32:25 -0700 (PDT)
Received: from kepler.. (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efe5262cdsm61350466b.117.2024.06.08.00.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 00:32:24 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: [PATCH 9/9] x86/fpu: Fix stale comment in ex_handler_fprestore()
Date: Sat,  8 Jun 2024 09:31:34 +0200
Message-ID: <20240608073134.264210-10-mingo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240608073134.264210-1-mingo@kernel.org>
References: <20240608073134.264210-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The state -> fpstate rename of the fpu::fpstate field didn't
get propagated to the comment describing ex_handler_fprestore(),
fix it.

Reported-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/extable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 1359ad75da3a..bf8dab18be97 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -111,7 +111,7 @@ static bool ex_handler_sgx(const struct exception_table_entry *fixup,
 
 /*
  * Handler for when we fail to restore a task's FPU state.  We should never get
- * here because the FPU state of a task using the FPU (x86_task_fpu(task)->state)
+ * here because the FPU state of a task using the FPU (struct fpu::fpstate)
  * should always be valid.  However, past bugs have allowed userspace to set
  * reserved bits in the XSAVE area using PTRACE_SETREGSET or sys_rt_sigreturn().
  * These caused XRSTOR to fail when switching to the task, leaking the FPU
-- 
2.43.0


