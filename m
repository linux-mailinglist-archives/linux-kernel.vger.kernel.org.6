Return-Path: <linux-kernel+bounces-531346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 794E8A43F61
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FF9175162
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C7C267B73;
	Tue, 25 Feb 2025 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BzRwIjJP"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0968219309E;
	Tue, 25 Feb 2025 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486437; cv=none; b=do0lmxPNezR/rrwFmxLsMoqMHRwn1KxK5wlMeY0WNeed+JF0/LilCSW9es2MTibu03QiLEY8qw8oHuGLe4DO8WboJ+N8QBCOnsti+psjKBY3aMZg5UAkCcelGjl6JQR4ADQab2Ja+jU+MuPhyg65WAhXpnk/qG0JCUPSFDQd0XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486437; c=relaxed/simple;
	bh=pxCy5QokWzOZjy10KJV2L0KzovnRJn7WqWlTe1KvyGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFmAlvkkciDls1ay6itVBIx5i1+RekRTCQJgC+Cpgn4h9tvYp9OdL6C+7mlXbSXSP7q33RmSlDS+7tGwVIwqj6ZuZ85kFiI7YZXILLo1pzHbslA9K82U8TJMrSPp/o77PZvWHf7dN9DPikv4+2vGG/Baa9aL9fbCAdE+2UBL99I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BzRwIjJP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eqAF4IrhnEXUU95nYquBlfNI3NOb7emcGTojdjYK/50=; b=BzRwIjJPKF33moI+3IBUwQqZd0
	YRCWQnVqi2ddNokTj4Hs6c7I/9iB2QEyubU50+EBg19vWK/KX5LlyLR4dlJKsPxCwLVwUv9aNgwMX
	rz1ZiYvKUTD+4V6fVbp5epknb4PasTg9z5tqqHRA2Yy+elQpJWI9/hGNnab248zsyrAyQ2zIpiP4m
	apOSp4VQjg1mgXGyWB9fPrT0NCOZ+BK7Mpby6timNY+IeYn9fy+uEvW+uZPweAWNbFZ5GeVoGOrPh
	NoPpMsfUihdLwk2LRHxAHeHWwCeJ4PtkAIMQwyEQsBcmnoSgbfQB4XX4MjLK3KK4qZzc2rz+QLqNY
	5e9+FWJQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmu1i-00000003L98-1PAL;
	Tue, 25 Feb 2025 12:27:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A1AAF300472; Tue, 25 Feb 2025 13:27:05 +0100 (CET)
Date: Tue, 25 Feb 2025 13:27:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Chen Yu <yu.chen.surf@foxmail.com>
Cc: zihan zhou <15645113830zzh@gmail.com>, oe-lkp@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>, lkp@intel.com,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [tip:sched/core] [sched]  2ae891b826:  hackbench.throughput 6.2%
 regression
Message-ID: <20250225122705.GD34233@noisy.programming.kicks-ass.net>
References: <202502251026.bb927780-lkp@intel.com>
 <tencent_6D9B516AFF16965A3BB652A049D6CA847706@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6D9B516AFF16965A3BB652A049D6CA847706@qq.com>

On Tue, Feb 25, 2025 at 05:31:34PM +0800, Chen Yu wrote:

> 
> But consider that the 6% regression is not that high, and the user might customize
> base_slice via debugfs on-demand, we can keep an eye on this and revist it in the
> future(we have encountered some SPECjbb regression due to over-preemption).

You can specify a per-task slice using sched_attr::sched_runtime. Also
see commit 857b158dc5e8 ("sched/eevdf: Use sched_attr::sched_runtime to
set request/slice suggestion")



