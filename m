Return-Path: <linux-kernel+bounces-574714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 289D8A6E8D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 05:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C13F188DD4B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 04:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EC61A5BA6;
	Tue, 25 Mar 2025 04:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bTSvGoW2"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3412B19E98C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 04:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742876042; cv=none; b=nunPuWIMECCvE59yKWF7+JewniO9P7FQpN0E6ww8EoJ/sxlIpjWyQLSxYuF6mYObrYRcIfo0wCFpk6Qo45eK+YGQHsV5JqohlA5gDhGGNafGZwwiKFiSZCUKOhtjS6CqCtG3kULbVZM989w3R7bNrNEe6txfdYDPauRhpuq6iQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742876042; c=relaxed/simple;
	bh=3TAwYkMl/7Jrwu+foCwYFjf4/ZKYpnei3D4Wl9VvD1A=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=bUwQKozCkQIiQAg2s31y5axSfcoJUkf1HXp0QnRKD0IfdBSf3tn0QL9gP/6wdIKPsK1AUBe00icTNwxD4+g1gCvBGthNPwxLd/7Ti17bHbKZRbUvCKfsgu5gKvOe5wWmhUaK54z2hEC+CHv8VmJ8fCLf6wg64024XYE3fV+NiSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bTSvGoW2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e5789a8458eso6614101276.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742876039; x=1743480839; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EJASGRGmrPcwpU7CqSRwJwZcThKb/XyXZK/AkLrGpAk=;
        b=bTSvGoW2tcKUFol305j8zVwTqtJBPxwgMsiZ1O9M3/gj/0eG+pJ0eO+42EJNTIYkDj
         VJUdpk8zyIWkT9RXKickVnaRPogW0bHMT6kuyjKOa6Nd3LXWWD3Rz3v9eJDMTMITsNCB
         nuIQlff3Lf3EXwwkvBJL44aqlfeyEFy8qZDlWq87szTkkJdDhgBDZo6rjHPsyGnS562m
         YK6/2xsux1BRWqmzWEtPFp01TVd9vi3kuQz5y01XZRl7i6OsuQFLsRkuetx3TUzzc+h5
         1diN6d4W5ltYMNSbquVfC1ASBrDSEwda2vGn+ZdP5kGO9tYOtWwjc+C110ZlIWwyz53j
         D3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742876039; x=1743480839;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJASGRGmrPcwpU7CqSRwJwZcThKb/XyXZK/AkLrGpAk=;
        b=RwjF+RFqbE01uq50U6AbG2zEjhkHs/9qT3RnSkh+wt1RejtBKJg36ZaHoLL+bvFK/i
         AnOvLGm+wR7rlIpdDKuIUXXwpCZ93y0vAt2MtaLk6zEe0lilI/+Z9yk/L1Gh3LcP/8Eu
         3adzUpr+d6on1Vd/hKFpVdnv8nvCYtNVC6aChi6F2/WDaRJ74GNmuzl0WnkyQOhl3Utq
         wXZimaXWYg7YfIh6PzibFYAedun0j588Gu3uIPZjKe7xdDiyF2DHiBxDP04E3X0xx4xK
         Ps3YY0PcIqvRKYpjRjht2E51R1dORnDwT5JGw3YLcPAv9X88hivBxG36yeR46e1FIbst
         XrdA==
X-Forwarded-Encrypted: i=1; AJvYcCUtCpaV+5C6A6Tx4vzG+77TBHS1MXn/DcmBviqVX7664QJzSTAmPABqf6zSftVi0oQpXqt7PAY/qvLpBu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGnPpQPl/bQ9a9JQs5vD6nqcIDzKUfBr+qa4ngeeF2DdXgLk6A
	qB4mfQaeXzX49g3FX3ReplOmtyhBnb2vQPxeuRyNbN8R9eTOCwTQbbDW0XP5IeUfZQyV6KlS0Ix
	erOqoNLxzyg==
X-Google-Smtp-Source: AGHT+IFRXyADSH1VG1iqof3ddCopTGj+wUY0S7x/42w9GR77Lq+bRsylsnD/Z9GFSuEUsXLsmUb1Qkhap5kX8Q==
X-Received: from suleiman1.tok.corp.google.com ([2401:fa00:8f:203:858a:76d0:aa73:eec8])
 (user=suleiman job=sendgmr) by 2002:a25:b582:0:b0:e63:65c4:798a with SMTP id
 3f1490d57ef6-e66a4fd11a3mr11205276.7.1742876038884; Mon, 24 Mar 2025 21:13:58
 -0700 (PDT)
Date: Tue, 25 Mar 2025 13:13:48 +0900
Message-Id: <20250325041350.1728373-1-suleiman@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v5 0/2] KVM: x86: Include host suspended time in steal time
From: Suleiman Souhlal <suleiman@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chao Gao <chao.gao@intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ssouhlal@freebsd.org, Suleiman Souhlal <suleiman@google.com>
Content-Type: text/plain; charset="UTF-8"

This series makes it so that the time that the host is suspended is
included in guests' steal time.

When the host resumes from a suspend, the guest thinks any task
that was running during the suspend ran for a long time, even though
the effective run time was much shorter, which can end up having
negative effects with scheduling.

To mitigate this issue, we include the time that the host was
suspended in steal time, which lets the guest can subtract the
duration from the tasks' runtime.

In addition, we make the guest TSC behavior consistent whether the
host TSC went backwards or not.

v5:
- Fix grammar mistakes in commit message.

v4: https://lore.kernel.org/kvm/20250221053927.486476-1-suleiman@google.com/T/
- Advance guest TSC on suspends where host TSC goes backwards.
- Block vCPUs from running until resume notifier.
- Move suspend duration accounting out of machine-independent kvm to
  x86.
- Merge code and documentation patches.
- Reworded documentation.

v3: https://lore.kernel.org/kvm/Z5AB-6bLRNLle27G@google.com/T/
- Use PM notifier instead of syscore ops (kvm_suspend()/kvm_resume()),
  because the latter doesn't get called on shallow suspend.
- Don't call function under UACCESS.
- Whitespace.

v2: https://lore.kernel.org/lkml/20241118043745.1857272-1-suleiman@google.com/
- Accumulate suspend time at machine-independent kvm layer and track per-VCPU
  instead of per-VM.
- Document changes.

v1: https://lore.kernel.org/kvm/20240710074410.770409-1-suleiman@google.com/

Suleiman Souhlal (2):
  KVM: x86: Advance guest TSC after deep suspend.
  KVM: x86: Include host suspended time in steal time

 Documentation/virt/kvm/x86/msr.rst | 10 +++-
 arch/x86/include/asm/kvm_host.h    |  7 +++
 arch/x86/kvm/x86.c                 | 84 +++++++++++++++++++++++++++++-
 3 files changed, 98 insertions(+), 3 deletions(-)

-- 
2.49.0.395.g12beb8f557-goog


