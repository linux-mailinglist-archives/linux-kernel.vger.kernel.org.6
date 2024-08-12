Return-Path: <linux-kernel+bounces-283533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB6C94F603
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58151F22113
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D9E188018;
	Mon, 12 Aug 2024 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b="omz5qer/"
Received: from read.uberspace.de (read.uberspace.de [185.26.156.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E73E191
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.26.156.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484724; cv=none; b=Y2Wh+ovUJh+7dT/+oTjh5RBQDynNE6l9Qvjp2s+2DMu3+rMYyZ3dKDK6DHJby8rdPQSMPH2JW9IxqU1JfX52N0ByWsXwRZOZNQLtWf0ec9TcU8TQOP5LAG/Bhjpqy/zYBUOOquZynZKL6ul41UugOchLFlKP/+mv+iQGAyCcJkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484724; c=relaxed/simple;
	bh=T88emezkzHvFJIY1FU+CWOWblCLzrtTe/ItS1ZINM0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMGyWXoEU07fIruG9WXU6dLzVB1CWJXskiCyQEOi8nAePX3aZn0FOJcnKcUfW7/3k9dCVIaqP9XpipjT4VOLA+BQaT+X6PzHXIREQi9dMUA2qFfvhIM5yCLYg+S0liKcWy7yXKFfUxxjxmtPtlKN+QRpadio3kmF5p2+x5r0hBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de; spf=pass smtp.mailfrom=florommel.de; dkim=pass (4096-bit key) header.d=florommel.de header.i=@florommel.de header.b=omz5qer/; arc=none smtp.client-ip=185.26.156.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=florommel.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=florommel.de
Received: (qmail 19526 invoked by uid 990); 12 Aug 2024 17:45:18 -0000
Authentication-Results: read.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by read.uberspace.de (Haraka/3.0.1) with ESMTPSA; Mon, 12 Aug 2024 19:45:18 +0200
From: Florian Rommel <mail@florommel.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Lorena Kretzschmar <qy15sije@cip.cs.fau.de>,
	Stefan Saecherl <stefan.saecherl@fau.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Randy Dunlap <rdunlap@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	kgdb-bugreport@lists.sourceforge.net,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Florian Rommel <mail@florommel.de>
Subject: [PATCH v2 0/2] kgdb: x86: fix breakpoint removal problems
Date: Mon, 12 Aug 2024 19:43:35 +0200
Message-ID: <20240812174338.363838-1-mail@florommel.de>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-2.755498) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: 0.144501
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=florommel.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=T88emezkzHvFJIY1FU+CWOWblCLzrtTe/ItS1ZINM0A=;
	b=omz5qer/TuV+JLZ3OsoXTyeZEB7Yuw0azBeN+c6DIIyjsBYPw4Ja4L2xvMakiQ5+wR0CUysiC1
	iAW3UZbSTBiQmLYSQgkBU7NHRQQt8BqXZIsgZg8IpJVplu0mxBgwPZxAT+lJWcbuT9WCX4XlMrMo
	TYs5fkBbvJ8v7xWGcLIIbRQzF8Qa6lL5CFyl0BVlP5Xh3Zu7tw3rBi/JjDUgPfmWCj5A496asyx8
	lxyBOv2I/n2IvjT3WEE47QO7j1+yoYK1fviIUuxrORDqrK+HFd5b+fEqI8X5vNxQwRuH2o7K1jI/
	VyqxhVkCdVwbJLdDOC8rf9SOHd5Qh2+VXhX20N38TXqo6p7EMK6BPOy+Yf6UHfV9eQM9AV9tN/0x
	AvgCEfC55qEFdFwqrm+PRjnW5rQ2sOuZC3p5/Hj2mfSzxwZ1d/YDxUmCLof1KbZOhMogfTvQLbcd
	3OsQ2Mx0qBttSc9UfQF0Z1iRMIP0rFJV1A2WUHtdUTRjJuhAR/f8/WOi81s3UNB6nrhAWnl3pYYb
	IAPIQG4/lxDKWG4oCqDXVsp05iPNzo2wHVXiEk7msdGiagq5PAaZp7zggbjPl51gKy0MUrCfpzND
	o0MxqqaIZL6GLFLoshdwsgvHwxeLa5p/MPkxN5ZcIW6kpbpAt6iINoh4BKkvyclzWUApZ7I3pT49
	k=

This series fixes two problems with KGDB on x86 concerning the removal
of breakpoints, causing the kernel to hang.  Note that breakpoint
removal is not only performed when explicitly deleting a breakpoint,
but also happens before continuing execution or single stepping.

v2:
 - Add missing stub implementation for kgdb_after_mark_readonly in [1/2]
   when KGDB disabled
 - Link to v1: https://lore.kernel.org/all/20240811232208.234261-1-mail@florommel.de/

Florian Rommel (2):
  x86/kgdb: convert early breakpoints to poke breakpoints
  x86/kgdb: fix hang on failed breakpoint removal

 arch/x86/kernel/kgdb.c    | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/kgdb.h      |  4 ++++
 init/main.c               |  1 +
 kernel/debug/debug_core.c |  7 ++++++-
 4 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.46.0


