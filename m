Return-Path: <linux-kernel+bounces-352954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D975A992671
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D691C22428
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10C318C038;
	Mon,  7 Oct 2024 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TicepmjP"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1EC18C010
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287519; cv=none; b=Wt1CG6HfUz/NP3oV7MGmSGRZ0aDWe4NmMxhbJFCyke8pQJB5pKr8HDCMPQCosQDIPo2WhpKf/u+YbeZVDA9lAMcGnNE1b2Vu6Xfo10ZxX3bnTl53smxnc6Ybn9YEaphse/HakTNhk48U2zV9wK+FgQ+7vgQfRnRZJj6Kd0HhJJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287519; c=relaxed/simple;
	bh=BfjjGYRjJ6kYuZlGbvQj7EH54v7/Rr38eIY+1xTMSIw=;
	h=Message-Id:Date:From:To:Cc:Subject; b=Ul6oeDNRHsCqNAiL9ovxLibk9P8sru36WTdpE8JP28Bd0NAUTNFzmmdptirV26yxFjwGssNcO7TOmS6oWjKbt8t5VfGpkgzU0Wy37m9B4J5VCMv/sfZhFuQAXYdiEYoGjjApII0LaQpJWgpesfWCHu2/yp+cvk3me5uRApyVPfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TicepmjP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=BfjjGYRjJ6kYuZlGbvQj7EH54v7/Rr38eIY+1xTMSIw=; b=TicepmjP2hZXcy1FfCSKXkZ0uS
	lVXuxpaI+rw709G4hqWtVGbN4jGNl/cfB1nqB/UZZfSqtcfbuzL1Ou5h8KpCVgvqmcBO/MkC1Aeuq
	K4zep99fKGzSUXWpN1QDQEB45db+wYZ0KE966CXCwsHN0ddsBuXeyjR41oc+wmQepiDL7oS6sfmbp
	kUbdnN9y2VaR0aCnrns59nZl6OGsULxnkZlWH/j86PoIe9dFsNbTkx9KDU3XTPSv9muWpnrbLp26H
	PTnzDx2wVKts43pdUWNqfwNegum0SBFjXC6RfM8C4Q542uyTxMHMhDkFI2O+yiHjIfPEbVXKE4dqW
	k+jrbXew==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sxiWu-00000004NuX-3wM2;
	Mon, 07 Oct 2024 07:51:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 2CECC30088D; Mon,  7 Oct 2024 09:51:44 +0200 (CEST)
Message-Id: <20241007074609.447006177@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 07 Oct 2024 09:46:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: bigeasy@linutronix.de,
 tglx@linutronix.de,
 mingo@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 ankur.a.arora@oracle.com,
 efault@gmx.de
Subject: [PATCH 0/5] sched: Lazy preemption muck
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi!

During LPC Thomas reminded me that the lazy preemption stuff was not there yet.

So here goes, robot says it builds, and I checked both a regular and PREEMPT_RT
build boots and can change the mode.

Please have a poke.


