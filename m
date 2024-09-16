Return-Path: <linux-kernel+bounces-330493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16935979F45
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D148D28415C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F0B14F9F9;
	Mon, 16 Sep 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wz0IgHdi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FB3A935
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726482490; cv=none; b=eCZkAqJ6KlonGvdt4zTU5fDYNMFbC1Hi7IQY4AdJDci/aG0gfVX5P5FYtsPgzW2BiLIzWIPAj42q/pWsHXykWqaCVJxm1Uzd8Ogyz2vTTBWjYMYAW31eDBIesAsSsiKIKdrMV4K3RQ0Q6Uk98p+KEHKwpy0+osRhbU5n9LKx+Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726482490; c=relaxed/simple;
	bh=D8v2259im+OOZivRqdPTFyX0+fRqHuSNG+3D6vzKgv0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UYbAmSpRvNLIMTxO3TSEvzLc/QAfB5HudsmFygwDoBs0JN89sckGbs4MEvX/KICz+Bb97zAY2l1Dun0sChiPzmqTC+0UsFk/Iwo9H9t3k4cYnn3RlWCguu00L5PtodxYLMiJKJNMPZefxkHJI+ZreovXD8PXz4V463tI0QQTAhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wz0IgHdi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726482487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=yMOO+5zuP47cm2PSmBG0SvJ4q2L6HUZ6VPVcAFdwe5s=;
	b=Wz0IgHdi1uCZxdBMYQn9Nlerl6P1RJm7irAC360vdOC2ZO/QcOLYBTlyPOsNC3nz7Y1CAN
	tQ3BUqRrDVgCqi1/3qOS4Zcwf+QBlb8s20c5b9BTQbfJys1EF8lFao+zlgJhGloaPN8Df3
	ZaWATIns5Qm+66nxvbkWMunIc9pKeuY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-XEWiKj66NRy6m1-Aa4Za4Q-1; Mon,
 16 Sep 2024 06:28:02 -0400
X-MC-Unique: XEWiKj66NRy6m1-Aa4Za4Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84C871953944;
	Mon, 16 Sep 2024 10:27:59 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.82])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AB17530001AB;
	Mon, 16 Sep 2024 10:27:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 16 Sep 2024 12:27:47 +0200 (CEST)
Date: Mon, 16 Sep 2024 12:27:41 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	chenqiwu <qiwuchen55@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: arm64: stacktrace: WARN_ON(state->common.pc == orig_pc) in
 kunwind_recover_return_address()
Message-ID: <20240916102741.GA13899@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

I don't know the details but people report that
kunwind_recover_return_address() hits this warning.

I know absolutely nothing about arm64 or kernel/trace/fgraph.c, but at
first glance this code looks broken:

	kunwind_recover_return_address:

		...

		orig_pc = ftrace_graph_ret_addr(state->task, NULL,
						state->common.pc,
						(void *)state->common.fp);
		if (WARN_ON_ONCE(state->common.pc == orig_pc))

	ftrace_graph_ret_addr:

		...

		if (!idx)
			return ret;


given that kunwind_recover_return_address() passes idx == NULL to
ftrace_graph_ret_addr(), it should always return ret == state->common.pc ?


Perhaps this connects to 29c1c24a27 ("function_graph: Fix up ftrace_graph_ret_addr()")
and I have no idea if something like the patch below makes any sense.

Oleg.

--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -106,7 +106,8 @@ kunwind_recover_return_address(struct kunwind_state *state)
 	if (state->task->ret_stack &&
 	    (state->common.pc == (unsigned long)return_to_handler)) {
 		unsigned long orig_pc;
-		orig_pc = ftrace_graph_ret_addr(state->task, NULL,
+		orig_pc = ftrace_graph_ret_addr(state->task,
+						&state->task->curr_ret_stack,
 						state->common.pc,
 						(void *)state->common.fp);
 		if (WARN_ON_ONCE(state->common.pc == orig_pc))


