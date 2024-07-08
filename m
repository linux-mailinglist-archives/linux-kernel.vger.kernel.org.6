Return-Path: <linux-kernel+bounces-244009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B85E2929DCF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675BA285A3B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F422238FB0;
	Mon,  8 Jul 2024 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FFDAOOsZ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34D53BBE8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425484; cv=none; b=W1QuBXePyWJVOxRO7dlZvqt2Xkhaxs9jne/PKLDqjFvTwQdhV02h3yD113hmYw0RxuLsgNmMl876Ay8QKwDABFlc4+ocNhI0MI6FOM3jxdgY/SFH3Az67BL7i71d6B6NP/AXh9LLxs81cHpNlXNzsK7bBFd5svqtsn4RPtJxx18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425484; c=relaxed/simple;
	bh=twaeYzFSn/1h1d9xhwS1tJhtyc/6QNjEWD6skPomBNg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cqLqQ14idmggWuZsfHgJ0Q9Yv0lcXHiO64omko/K+3dxDlR55KiQFrofWBrHS6gi93psnctr19QT0uWuf5Uy1Pd04pTVojXPqzWPkQRIvw273eDZhOrXAnuCmjJZRDcO4XzYZ23JJyTMreDkJIj2ij9Y7N3GOQqcH+2CbDobaGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FFDAOOsZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=GHePrlKh36QSGwKVJ3OqNArqPsDNDuyy0iY4WXPrnn4=; b=FFDAOOsZgk415dXO7SwRQzbFWg
	hBfwCl7djiLf12yI0AUhLhM/WmtSmf84kj7HWoYyz2ilhfDVvzG2VhcYoNsDCAwLgCLVG10TfX3xG
	2cRvyPHrlt0UJu8PlP2YljdfGHInryAoy9qQSpo7KVwic4zd9nyeOcBxV2yYn1iKRWg+pOvt9zFWr
	l5Hci+ckMx2sLKa3cfQd7x71H1x6XxAv/sz1oN1k1y7Dnl7DznydXtuVhMq5tQnb+bI3oFH2ZIo0f
	n0m/QGS/bhpvf+h7vVSaQ1IUqX6YFupPJ9auRPc2DKkY49WciZtefbcN0LBMU4lYuCSo7Wxx+52H2
	aF2FBzFA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQjFy-00000006ddV-2ncE;
	Mon, 08 Jul 2024 07:57:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 85FDD3006B7; Mon,  8 Jul 2024 09:57:52 +0200 (CEST)
Date: Mon, 8 Jul 2024 09:57:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	tglx@linutronix.de
Subject: sched: Update MAINTAINERS
Message-ID: <20240708075752.GF11386@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


  Thank you for having been our friend!

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19929,7 +19929,6 @@ R:	Dietmar Eggemann <dietmar.eggemann@ar
 R:	Steven Rostedt <rostedt@goodmis.org> (SCHED_FIFO/SCHED_RR)
 R:	Ben Segall <bsegall@google.com> (CONFIG_CFS_BANDWIDTH)
 R:	Mel Gorman <mgorman@suse.de> (CONFIG_NUMA_BALANCING)
-R:	Daniel Bristot de Oliveira <bristot@redhat.com> (SCHED_DEADLINE)
 R:	Valentin Schneider <vschneid@redhat.com> (TOPOLOGY)
 L:	linux-kernel@vger.kernel.org
 S:	Maintained

