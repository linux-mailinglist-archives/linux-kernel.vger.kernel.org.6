Return-Path: <linux-kernel+bounces-536502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC5AA480B8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276B617E2F4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8DA23A56B;
	Thu, 27 Feb 2025 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CIDF0hya"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EAC239094
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665004; cv=none; b=W8qIac/HyyexnrLwOTTLPxr0pVUv1zDxD0Mxokxh22MFvEspeH5klEVguuDZ1w8+Fi6qhWwPjN8pxyYkfIlZFKoAfiwlyQvBH6Sc0A3CxCUBtKzKlZJ6tpaWs414XggZsGnTu4YAYiTdIA5bYpmFjQVkXsJsV1IMil8q71hTvtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665004; c=relaxed/simple;
	bh=3NnxLM9evLC5dZoexGpaMUPJqUxrZ9lwjMscmx27tjo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=P58BvDITGSAIFLOHhJNtvNkR7l3G2MDoYWO0fUy1CseTUl1G4RgABzBAhufADD9O6J79H7djPS2Viana3vOds8lIQP/4Knlzz7JJa2JJZQclOFJeC3DdYUckZNHlUct9yz+XVpj99G9V18zU3xt6jD7Z0P0vERF5iUiwGTcQgKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CIDF0hya; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-390eb06d920so81480f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740665001; x=1741269801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=saWev/BLtPHQI+zr3xOwDwS1bzfDXQxRvDaSiKo3ZN4=;
        b=CIDF0hyaafsyrb9W24ayhuVhiXQ54R6nsLM7Z5u+nne7zr3RgA2uUaZwvRwlBI/4Co
         9RK0rNXVh7Ffxu5MQ9e6CIe6GuQCGLEpSJfYhJPv8PaOOaWqJjxiN2oC+ZmtDWmQVouL
         6UTXzO7gbytvM66uxakubQ9xJSuWoZdhdtFZvoeHdAUxp1zvmMl5cbPuBOKlGrJ4cXtD
         uOvIZbrElPzuKwhRVsbwmkQow11DvqvN84Z6TscSOgVbai++03bNNli6Dghjve2ca1C7
         1y09crIyVg+7Lv77LCTmfVbjytKqqJ2X2DIRjeYYEx8wRnhnreOSVW+8CiVr+dYm93bJ
         Qv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740665001; x=1741269801;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=saWev/BLtPHQI+zr3xOwDwS1bzfDXQxRvDaSiKo3ZN4=;
        b=OVhLjagDQBZATA95tyIOKookC7EFHDi13ySplzS3LH6sC1aj6PWJZ7MdaksxtVI721
         VWVD35TXocj6b2lJ40Zas/3k4c7R24h9Na/7bDVod0u4k38mhjhmCNw/Uaa3w2qlTiDo
         XyPKQQ0YztSmAIXyVZDtRKrQat28ouTB3m0TfVjb7MzApZht9hMfOID03lJWIUJLYUN7
         CrMgj3tNsNxMmZGVz5P33z+8zZ9KkyI7F9eTrrT4BC6Zln9/78Br1El6TXMOv1LZuKep
         mKPM8isOdPdh7SWZLcDQOPftsm5glJ9bKIVa4yH5eFonOV6nwfZts5NzmJS2B8qDlHIR
         12Mw==
X-Forwarded-Encrypted: i=1; AJvYcCURiM4UMEjsWDZUedBl4Jbx5ffaIEw/+DtGk5QM/7f6vNS/Ln421sAj0YUHx9V+Qz1z1IOAYoKrPtFP2GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo4SOpf/2kJ06wmIFcGvOeANbOV5LccyN/8T7AjLtTmFJFX0A0
	U5NLaRN3Q1J4FEyChU/lTOqosZD5ISIsmIjOuMHDh4vQEJGyHzhlwwdESKArj53fXZE3M5x7W1I
	gz8YAkA==
X-Google-Smtp-Source: AGHT+IFmqZomhoMqAYZ8T+5JMApUMHdVzCXF2alNphLj59R1cMvvM9y4wMaLrZO53sJ8XqE4aAhk5Ho1jVlP
X-Received: from wrd5.prod.google.com ([2002:a05:6000:4a05:b0:390:df7c:ab82])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1a87:b0:390:e005:65b9
 with SMTP id ffacd0b85a97d-390e005680amr5677012f8f.23.1740665000917; Thu, 27
 Feb 2025 06:03:20 -0800 (PST)
Date: Thu, 27 Feb 2025 15:03:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <cover.1740664852.git.dvyukov@google.com>
Subject: [PATCH v6 0/4] rseq: Make rseq work with protection keys
From: Dmitry Vyukov <dvyukov@google.com>
To: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com
Cc: Dmitry Vyukov <dvyukov@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If an application registers rseq, and ever switches to another pkey
protection (such that the rseq becomes inaccessible), then any
context switch will cause failure in __rseq_handle_notify_resume()
attempting to read/write struct rseq and/or rseq_cs. Since context
switches are asynchronous and are outside of the application control
(not part of the restricted code scope), temporarily enable access
to 0 (default) PKEY to read/write rseq/rseq_cs.
0 is the only PKEY supported for rseq for now.
Theoretically other PKEYs can be supported, but it's unclear
how/if that can work. So for now we don't support that to simplify
code.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org

Dmitry Vyukov (4):
  pkeys: add API to switch to permissive/zero pkey register
  x86/signal: Use write_permissive_pkey_val() helper
  rseq: Make rseq work with protection keys
  selftests/rseq: Add test for rseq+pkeys

 arch/x86/Kconfig                         |  1 +
 arch/x86/include/asm/pkeys.h             | 30 ++++++++
 arch/x86/include/asm/pkru.h              | 10 ++-
 arch/x86/kernel/signal.c                 |  6 +-
 include/linux/pkeys.h                    | 31 ++++++++
 include/uapi/linux/rseq.h                |  4 +
 kernel/rseq.c                            | 11 +++
 mm/Kconfig                               |  2 +
 tools/testing/selftests/rseq/Makefile    |  2 +-
 tools/testing/selftests/rseq/pkey_test.c | 98 ++++++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h      |  1 +
 11 files changed, 188 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/pkey_test.c


base-commit: dd83757f6e686a2188997cb58b5975f744bb7786
-- 
2.48.1.658.g4767266eb4-goog


