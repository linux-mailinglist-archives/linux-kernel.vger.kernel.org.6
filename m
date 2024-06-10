Return-Path: <linux-kernel+bounces-208589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE7D9026FF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF4C81C215FA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F96155CAE;
	Mon, 10 Jun 2024 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V/2ZAlKN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7txRKhGm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E050B155A5C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037760; cv=none; b=V3KbXOL3r3TbDaB9kBDxa4errGVpjXll8MJPZe+/oMBQik6uBT5yyrZ7PaXC8hBTlHfnti5fQFSdN181dKPdmZZlQE9oBefZ4pzMVyWHFG20rBkPvw4CpRVF3pq07wiNTa+jhL+cT9O/6c5P+HPpP+y5ELoupLIaJcPG3kq3YII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037760; c=relaxed/simple;
	bh=aSmCpittOoF3ezZp87bwESr997wsqcqECssDBgE4Mvw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=FNnwTQfsocI9sSpDCQKaM3wG6hI0w1TH/jD3Dc0wbT2WmxfzGNnB3t6qlgtiEbWBryPqhPzhSIwy/981FlEpXr9E22/I+BZqWunmKUxJuPBohZRUCFOCKvpGkO8AEvoz28+40TR1oicZ5wQv936P7tySKAWBaV7E91Owu48mTD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V/2ZAlKN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7txRKhGm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164027.115004173@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=pJjrzduNqM5JDPsn8IBKNH0/K/D3T9whic02EnoKRWM=;
	b=V/2ZAlKNJrQFecc+B0zpOVviOaLacLqXGznZ35dLVOFhZ29m7Y/q71sQ6bY+/XirDmMIaH
	w6AlPrllBkm5C3GP+N9ZCfI/xRnxjur5re4mZ/IKtFpt+XyQFu3wfMyO0ALEFVWYwYevc6
	DMdfOl5BuhwY+AIls+YCrbLcmkoeGNrpqd8R0RKZN2D6ht5L1dJrfvztaKnyZjwiIqTNsu
	VSlF5Tn2GEvAk4U04ekKo5e9bM7mAM4Jzt9C2tnnrm0tEXZxv4BxkFrMnAvKm1AWVIysyn
	qh87i09+GONz6Gps0xkPW/YLo2nCrVi33gr+Q8o1mb4+54BhuAyg/zq46MtxQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=pJjrzduNqM5JDPsn8IBKNH0/K/D3T9whic02EnoKRWM=;
	b=7txRKhGmzu4nE92Kiz6lZaMFxjA7A+FnXb15kEbE3sfmo36Z/fPMDGbd69v48FkaDE/lOx
	LpUIN3VgEdsfITAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch V3 26/51] signal: Prevent user space from setting
 si_sys_private
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:37 +0200 (CEST)

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/signal.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3350,6 +3350,14 @@ int copy_siginfo_to_user(siginfo_t __use
 static int post_copy_siginfo_from_user(kernel_siginfo_t *info,
 				       const siginfo_t __user *from)
 {
+	/*
+	 * Clear the si_sys_private field for timer signals as that's the
+	 * indicator for rearming a posix timer. User space submitted
+	 * signals are not allowed to inject that.
+	 */
+	if (info->si_code == SI_TIMER)
+		info->si_sys_private = 0;
+
 	if (unlikely(!known_siginfo_layout(info->si_signo, info->si_code))) {
 		char __user *expansion = si_expansion(from);
 		char buf[SI_EXPANSION_SIZE];


