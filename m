Return-Path: <linux-kernel+bounces-244094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0AF929F0E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0311C22EED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000AC78C83;
	Mon,  8 Jul 2024 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="itifBmbl"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19713307B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430969; cv=none; b=th9RgMdjnC8gsrkvN32a4qnwiW9xVFLdJOv0WYh2bcMLHUjos5h0SZQcwOzkdbvpqJSiUdL8FF4QOwB45Tg2Zk5fDtqwuv/749YD6r/6kykBgYBvarbpgX3+ccnFhTUJDU1wVYcR60tz1GEhEktYpEHghZUKnHUYx2oxa0tPcbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430969; c=relaxed/simple;
	bh=73nF+R8eVlM7mp2KegjQ4cMqnN49AihYWm5Yc5ZvDc0=;
	h=Message-Id:Date:From:To:Cc:Subject; b=j5IB3urbXQhsbSlTT9eps8RuczSPE3bWzzHPzKHUeobKdDr8ioYiJ9s+7lj9wRZmnCSeQWpfNE9bYHGwc39TVCI+u2vR113Rj6LUAqraneYVd4Bu34FOirJKAEhpsEuaamHYdF+29FQKSn/xTLVs4eRjnrTxTF+2NzwdgFOmGjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=itifBmbl; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=YuiBq3EzGvP18V89XAoxc1fedsEk5gXONSPhflBT1L8=; b=itifBmblk2w1ctPlg9bUq1Pa4M
	QmDrNu3QrDjvSfzX0TEXXFb8/7BunQw+XVWTrnSteoEy/ZyvIb7W5LcQO3yJJ6xLemhuS3XTVJMJg
	O2vT+Z42JhVuxSxesTvkx276DkbC4LVLNRO00cPIqv18lp9DHf41EvevWBgwUgDHWCjqEowsrvo5x
	dD99aVumlh72YOtJBdjGNaQ081mxX6SLTzAqL33io9zQrvk/X+y3Sh55q/IsvgsFfi2m9DaKjjEyU
	R+MI2m6qObL4cxqhp0W6x0CaY/0bbAfDdPdMB1e00GtmyznKDgHuMpCvKvd1rJ8RFaAjZ4S6LgJGT
	MMeAVbyA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQkgO-00000000ZsM-01vu;
	Mon, 08 Jul 2024 09:29:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 02037300694; Mon,  8 Jul 2024 11:29:12 +0200 (CEST)
Message-Id: <20240708091241.544262971@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 08 Jul 2024 11:12:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 andrii@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 rostedt@goodmis.org,
 mhiramat@kernel.org,
 oleg@redhat.com,
 jolsa@kernel.org,
 clm@meta.com,
 paulmck@kernel.org
Subject: [PATCH 00/10] perf/uprobe: Optimize uprobes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi!

These patches implement the (S)RCU based proposal to optimize uprobes.

On my c^Htrusty old IVB-EP -- where each (of the 40) CPU calls 'func' in a
tight loop:

  perf probe -x ./uprobes test=func
  perf stat -ae probe_uprobe:test  -- sleep 1

  perf probe -x ./uprobes test=func%return
  perf stat -ae probe_uprobe:test__return -- sleep 1

PRE:

  4,038,804      probe_uprobe:test
  2,356,275      probe_uprobe:test__return

POST:

  7,216,579      probe_uprobe:test
  6,744,786      probe_uprobe:test__return


Patches also available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/uprobes



