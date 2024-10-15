Return-Path: <linux-kernel+bounces-366598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC88B99F791
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECA32824C2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B1F1F5827;
	Tue, 15 Oct 2024 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iVPQOfRT"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAD11B6CF6;
	Tue, 15 Oct 2024 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729022155; cv=none; b=PuGbEjDCxi7iXTEhx/DBDIUNGExvV/oi7khYqb6FedoaSCSv7nTDi/l/6tY5kgdd5jES9WZXggKLfkLv/GezJf987wROzqJ5sNIicZO0z2QONQKQ4Y+rs7U25QCXV5dhUIu2+co68BOflsLo4Oq6byQh4Gg1JZU8tUVzwzDqiB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729022155; c=relaxed/simple;
	bh=M3wZr81kfgygW0+8Dr7VM/EyrOjZLzoHA7tE8P/1jxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Et/xV2v36B9Vze2G3qbpC4+G3kYUSB6aSD76U25hxH3Um/h21XJObzg70o3rbJZvzk1pHbOwSoDL4xnzyZPKDVgfDrRApHhwg+g7TNZu7VkARJjXdCdb/hdmIDBxwiWU1fv2SX/oEeuhP6trjLifhLh8TTcSi99NqilWVRRs0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iVPQOfRT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M3wZr81kfgygW0+8Dr7VM/EyrOjZLzoHA7tE8P/1jxk=; b=iVPQOfRTF4WSqC/YFCzMaWBkCg
	mi5WkQIAzbl73SzniLdSYrJzVJP86bIBPxkvENfkYntaXsKSkWtD/aTmPKlOBYKXRF872fXxTDyEj
	bQmzE2J94et2yRWSiPq+MNDYxeW0TWNsl1QDtz4mMKbFL38Cl+b5wvyitJvcgCgHl0FcXma7sxjbj
	B2vdZbQAinM8pHviOlrc7K7pl4kPwAla/m94VaeU822ni4CfxAv85NPGhpK6iNwV3vH8Cl7IRnMQv
	eJ9BKPVgIhcgXtA51e6WHi76axrd5Hf070TXwmWX6NBuDaqwLc8BQa7dfLF19LhdPqIB2oxJw4wKw
	ZEEHo2ow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t0ne1-00000006eVY-3hEo;
	Tue, 15 Oct 2024 19:55:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 08F40300777; Tue, 15 Oct 2024 21:55:49 +0200 (CEST)
Date: Tue, 15 Oct 2024 21:55:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	vschneid@redhat.com
Subject: Re: 6.12;bisected;regression - psi: inconsistent task state warning
 appeared in kernel log between 2e0199df252 and 54a58a787791 commits
Message-ID: <20241015195548.GV17263@noisy.programming.kicks-ass.net>
References: <CABXGCsPprMWjj=u_kJkLcQOQcR3M3iF797zsmSqQin8UUkkppg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsPprMWjj=u_kJkLcQOQcR3M3iF797zsmSqQin8UUkkppg@mail.gmail.com>

On Tue, Oct 15, 2024 at 04:50:00PM +0500, Mikhail Gavrilov wrote:
> Hi,
> I spotted a new warning message when kernel
> 6.12.0-0.rc0.20240920gitbaeb9a7d8b60.7.fc42.x86_64+debug manded on my
> machine.

Should be fixed in tip/sched/urgent -- also in next.

