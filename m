Return-Path: <linux-kernel+bounces-206929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DD9901000
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF0828441F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 07:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D877817837F;
	Sat,  8 Jun 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wg6EN9TH"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993EA1779A5
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717831945; cv=none; b=AX4o9XXdi6UI8K7YDtssEhvlBovi0oqe+WcOqyTYBURgspDejgC8sSTBUs1iVGSxEa7BDOSmdLO4YGaoHu9xQKXqQWCf3SWfVDuFlcqs7s5N7/Y1Cl4IBxCjiKbECPnM4R2eitsrEkZMuZOacElzkUcq3Zxh4RRwD4YNtsccEKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717831945; c=relaxed/simple;
	bh=Oy+NHG6mD/cGCqU1rGUvREyzGkIQ+RAhqrNHdtGEKsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9gbw7svaVnaISmlXHO41lyIocHuOmpo5uNhphM8U0Oo/MbEcS17w19vHzxoSHLUjQcQWg+2TD40bv9XPhM0AOMzfTt11N+x0rRdi0JiiQKOaFTUyZW3/hkYF6xvCpJhxh1CD4v4GIQXvb1AwZTxUeaMt0tlDc0W2cVBvGEEUlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wg6EN9TH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6f0dc80ab9so10862266b.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 00:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717831942; x=1718436742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0Ptq0zYXtCgwiXoL8ayk/kDTAsQ3v0jXZk6Fq+9owA=;
        b=Wg6EN9THMw8OWpJs9GcYhZ5bmidZqzhy9BtiHpTwnYjoNMwbYB7ohHzHyUnQFlfFWt
         7yM5qDuHgCVUYKPoHV1Eg18v870bzoDadeBEwwySTljWGf4JuzfeZCJ4ASpPoQafi86O
         H0U2A2elKcl+77Ybl8YniPo0QXvJgkx2SrhZ2e97V3AcoiWn86lRURREUV2j/unrq9zg
         +cWQ361bXhYygd86LBUCpoJXOIdC7o3Ic8Cc+K4pcO/iahLfZm9bclVGmM08nJ/A+kcJ
         inP8RiXFex5nuR2e8pQIZHrYTj+5LUts77OpLNGXz98TpQLMuXWpQv5/hAP7Tm99sUEF
         jPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717831942; x=1718436742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p0Ptq0zYXtCgwiXoL8ayk/kDTAsQ3v0jXZk6Fq+9owA=;
        b=dh9+1/jIpqDH/M1/jjKo7CZBlRR5ydUqXh6o3JxYDIXTuKoJUzqaWOEAVQnwUdV4Y8
         WONxqtLJmtUVajYW74f/n08nUCaPImlYOrA+X6NxF/NJ2E+nCH4W6RTbWVXwdBH9HBRn
         QsPokbg5xsd/d+BXbsNzGV7vAE7Y4seDHZnuht5sdqGo4OIz2tMBdpcM2QwKJmWk3yPV
         NIkgGx80iHQkh4lNBogkXRbudnPAtPvUC00W0murr11P2GDVFbSbp6zs/OvmwpoTQQfG
         7jTCkYequhUi78Iw8yC5l7WRjxlsD5/8AoTbL2pjJhZNjnJzuvwiOJ9SlCT0mqDAKopK
         hVkA==
X-Gm-Message-State: AOJu0YwztEmmNoLvdIdMKPyiXBL9SQy3NG+gKBW5m4UbOKZ2bmqclZOy
	znTw0KliUOHNhydUbBbQWey8ljpzfW/RamtQlF+2Z2q8qq12o5oqweMSTQGQ
X-Google-Smtp-Source: AGHT+IHkwQ5Xj32OR7I7jHgSmColdqBVuYjeyJ/ZbwsSm87yrBpATUgibOpNwDc36bCpXaQI54vrgg==
X-Received: by 2002:a17:906:2694:b0:a6e:ffa2:3cce with SMTP id a640c23a62f3a-a6effa23df7mr52363166b.41.1717831941983;
        Sat, 08 Jun 2024 00:32:21 -0700 (PDT)
Received: from kepler.. (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efe5262cdsm61350466b.117.2024.06.08.00.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 00:32:21 -0700 (PDT)
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
Subject: [PATCH 6/9] x86/fpu: Make sure x86_task_fpu() doesn't get called for PF_KTHREAD tasks during exit
Date: Sat,  8 Jun 2024 09:31:31 +0200
Message-ID: <20240608073134.264210-7-mingo@kernel.org>
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

fpu__drop() calls x86_task_fpu() unconditionally, while the FPU context
area will not be present if it's the init task, and should not be in
use when it's some other type of kthread.

Return early for PF_KTHREAD tasks. The debug warning in x86_task_fpu()
will catch any kthreads attempting to use the FPU save area.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/fpu/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index c85667c0695d..52d5843c886c 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -674,7 +674,13 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal,
  */
 void fpu__drop(struct task_struct *tsk)
 {
-	struct fpu *fpu = x86_task_fpu(tsk);
+	struct fpu *fpu;
+
+	/* PF_KTHREAD tasks do not use the FPU context area: */
+	if (tsk->flags & PF_KTHREAD)
+		return;
+
+	fpu = x86_task_fpu(tsk);
 
 	preempt_disable();
 
-- 
2.43.0


