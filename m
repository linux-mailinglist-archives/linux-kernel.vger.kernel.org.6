Return-Path: <linux-kernel+bounces-444804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 786CC9F0CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31B21884DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287AE1DEFEC;
	Fri, 13 Dec 2024 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nZwSAN1M"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C132DB640
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094316; cv=none; b=roKk0VVDIM3xqk1VTTP/6oS5FP1whKWZUEO49bT6OeCYKBexugstMEQYPmDY/co7Aig0XNE0j79FClhfRfQD8b07kMxP3MNPhdG3yRzjN4OhW0WH8+a8+o+4O26o24VcriaGOVEJVsldj7Rk3iu7lB8HMDu5LhM62w9l3O9wbMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094316; c=relaxed/simple;
	bh=NEj+03j0Q5jtOHwVsBd0UEFq58v0bsMouvOLQjPfG8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luhRjoXMY53VvzwFfEl6RKeH90TY5f4SQ/J8ZZvB6LhQtjAFPhSvgiiVekaqQhrcafFpLnDYB65HjtN8rO63PCniWH7cw5ACHRXGncEbGgG+iH7epe/nXJeSpZjW5WkpJQ8hWQQaa0yTj1zlH/TIhCtD7q/tU0WjPO/pYZgRDIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nZwSAN1M; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NEj+03j0Q5jtOHwVsBd0UEFq58v0bsMouvOLQjPfG8Q=; b=nZwSAN1MIyyS7pVuNjLeX4U93e
	U38SCjes+yiyy3YEQWQY98EG0pUtkKPOGlK1f0T8STbu5evi7/9bGkW0vy+SD8tOrqTLKrLWschfB
	R8J3ZFjxOFo41xXYQorDXNgEffgPfjWj+zsRjzltoDFsDwRAoN1YoF2WnGxc+ApXpO8591VZxokqf
	57HU9wWdfEw+TUdmnGeItkQPLIokQQsQxjJ2jwZM2o29gp14TMIIFo/wrjWSLJkjI8AlzDfrnamoR
	joZY9wZ1x+lZi2N55VsHR+VZLqarmdShNztkzruLJtYlmrbPYydpzPFkIOT0mv7iwk8i1payvfLFE
	SZ37SbRg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tM591-0000000Cyih-3WsA;
	Fri, 13 Dec 2024 12:51:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 27DC130049D; Fri, 13 Dec 2024 13:51:47 +0100 (CET)
Date: Fri, 13 Dec 2024 13:51:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Joel Fernandes <joel@joelfernandes.org>, shraash@google.com,
	marcel.ziswiler@codethink.co.uk, i.maximets@ovn.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/dlserver: flag to represent active status of
 dlserver
Message-ID: <20241213125147.GC35539@noisy.programming.kicks-ass.net>
References: <20241213032244.877029-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213032244.877029-1-vineeth@bitbyteword.org>



Thanks, I've invented a Fixes tag for them and stuck them in
queue/sched/urgent for the robot (although I don't expect many
complaints from it).

I'll graduate them to tip/sched/urgent if nothing comes up.

