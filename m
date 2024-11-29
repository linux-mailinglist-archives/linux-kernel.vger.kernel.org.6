Return-Path: <linux-kernel+bounces-419112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275DB9D69A0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 16:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027C01616B1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 15:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47A62E3EE;
	Sat, 23 Nov 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ofSUqaHI"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC5223098E;
	Sat, 23 Nov 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732375874; cv=none; b=lGQW7hm9tafykruxSDyFW58yudC7vVzthsOkVPGslIdt7Bm1i0gE35GNOEKeHepie7AlaNNMCtL6NklcZeQxe3R5znJj7RxXqYHsIld+pmM9sre4VLThMVaAv0F/gcnoAv61sdwhly9tXR+uLPekQeJmFIHAiPLv5ry4tFPQA80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732375874; c=relaxed/simple;
	bh=XFETHtpKlJRfFVo/z8h3SdYU9sWhxuuvlcPfCGVmcSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z9WUYBg03GX3AxSYB3L0KLIv6+ZepECPNYlQ47a+4Cp5u9fwes3ZgQ4myY7OAQYCRwlJxLw07cM+tbL/f7rSS490jQfRlu1P6J29lSylEzUoMn5DKnVZjj0q9teeYssT4VgOVgabOfucwuolrxqo5gWRbE54lM0RW3drA4oCmWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ofSUqaHI; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1732375865;
	bh=XFETHtpKlJRfFVo/z8h3SdYU9sWhxuuvlcPfCGVmcSo=;
	h=From:To:Cc:Subject:Date:From;
	b=ofSUqaHIrN9SUXw90PmfhzK2VHmZJCjgEfyT3PGEHSNIsMPFj9OS+Iql2AGASgdYS
	 eU3KN/2fSyVQm7Bi6BWqLOfEjKHTHCz3UVSWBHPSxCo+yInjYaZoU+UtqMOZG+2Y1D
	 Jt9X5kOEVQdc4j/MN+/xKCcHeXEf5QT1tdhXgk453daZb57qblLSdeZsfAYNRAusU/
	 yIhoSIRQr1UEOHTJRz7dEECx90iqVMN101ajw5Oawte/uuvehiMpx4KbVRrKWJlTVk
	 gSSBa8jsKvoOsQPOVDlri/OsXl/yk/ttSJH92PU0SYuRHL3ylhfv37+WWzPNHAHkTT
	 fBlAO4gO62taA==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2605:8d80:581:d239:b14d:eb44:5229:ce95])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XwbXS1YT0zXDc;
	Sat, 23 Nov 2024 10:31:04 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michael Jeanson <mjeanson@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	bpf@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>,
	Jordan Rife <jrife@google.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH 0/5] tracing: Remove conditional locking from tracepoints
Date: Sat, 23 Nov 2024 10:30:26 -0500
Message-Id: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus pointed out that he was not pleased by the implementation of
faultable syscall tracepoints because it contains conditional locking.
This patch series addresses those concerns.

This is based on commit 06afb0f36106 ("Merge tag 'trace-v6.13' of
git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace")

Many thanks to Linus for the analysis and feedback.

Link: https://lore.kernel.org/lkml/CAHk-=witPrLcu22dZ93VCyRQonS7+-dFYhQbna=KBa-TAhayMw@mail.gmail.com/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Jeanson <mjeanson@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Jordan Rife <jrife@google.com>
Cc: linux-trace-kernel@vger.kernel.org

Mathieu Desnoyers (5):
  tracing: Move it_func[0] comment to the relevant context
  tracing: Remove __idx variable from __DO_TRACE
  rcupdate_trace: Define rcu_tasks_trace lock guard
  tracing: Remove conditional locking from __DO_TRACE()
  tracing: Remove cond argument from __DECLARE_TRACE_SYSCALL

 include/linux/rcupdate_trace.h |  5 +++
 include/linux/tracepoint.h     | 70 ++++++++++++----------------------
 2 files changed, 29 insertions(+), 46 deletions(-)

-- 
2.39.5

