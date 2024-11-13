Return-Path: <linux-kernel+bounces-408189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5435C9C7B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0469F1F21873
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E82204001;
	Wed, 13 Nov 2024 18:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j9SFGYvv"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8A5174EFA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731523832; cv=none; b=bHPQM2lU4OyS+1/+OUAhcFr2HvIcVsHG6KaPWXJqG8HAOAZZypCBOClRjszTKA0NqZcLwHfOrXdYX+teiNYfeXaGnGn9CcRaTZMYruYfMwVh6nKWNrOVknM1H0NFg1i07S/d5AgDR4MfaoDMsJNtARrxSik1Fm1TIpOp2V8dmD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731523832; c=relaxed/simple;
	bh=mBs5au3OFQRAm6YvuRzSet2qotb/hmlgfsCKASvjb6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ft9sqxX4fcNeUSv0FcXc0y5rlT6ssbrJYAqve9g20iW9zvbUXu/RPm+im87xCBWwzvNcjLtJ/Sdpc85Mz2tWSJ8bl4FD5UVy79jLZ1o45KhTonHAH0uE03EfFbVYOfENX0W9Dpwvm8hVxw0IeTlioc+LucuFQBCZ06prqsmeL10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j9SFGYvv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mBs5au3OFQRAm6YvuRzSet2qotb/hmlgfsCKASvjb6Q=; b=j9SFGYvvVI9W3dkisGXqIcTLCs
	RPQrQpbA9cjq456QTN9Y6acTvaUDcplQcWBEN7GyWvmAUIuOcv9Buw1XS7mqRFT9hOaSfKGvdAewt
	OB7suHTnQwk445v+x6hM/C3GfcQZOYKLbKSLb2RVEbGXAODRKBFAXmezOhp6/tSXa5wpT74A5h+l2
	XX0Nco/3dskmftMUTS95jbZIxJlIXXs1d3FAHbzLzCMBsgYyx7Wbr7Wq49OS84w/VK9avDSCiFRiH
	vjokQCy2dV5cpRSecv7wyAEOGnEKyG3Lo4oi84jbweQsdKUPyR16sdoRzuBjvqVhZQJv/oDXRAzRV
	AC8nWCmA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBIRU-0000000DNmZ-268e;
	Wed, 13 Nov 2024 18:50:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id ACD70300478; Wed, 13 Nov 2024 19:50:13 +0100 (CET)
Date: Wed, 13 Nov 2024 19:50:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Prakash Sangappa <prakash.sangappa@oracle.com>
Cc: linux-kernel@vger.kernel.org, rostedt@goodmis.org, tglx@linutronix.de,
	daniel.m.jordan@oracle.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 0/4] Scheduler time slice extension
Message-ID: <20241113185013.GA22571@noisy.programming.kicks-ass.net>
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113000126.967713-1-prakash.sangappa@oracle.com>

On Wed, Nov 13, 2024 at 12:01:22AM +0000, Prakash Sangappa wrote:

> This patch set implements the above mentioned 50us extension time as posted
> by Peter. But instead of using restartable sequences as API to set the flag
> to request the extension, this patch proposes a new API with use of a per
> thread shared structure implementation described below. This shared structure
> is accessible in both users pace and kernel. The user thread will set the
> flag in this shared structure to request execution time extension.

But why -- we already have rseq, glibc uses it by default. Why add yet
another thing?

