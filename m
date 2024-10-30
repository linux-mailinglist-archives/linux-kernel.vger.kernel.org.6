Return-Path: <linux-kernel+bounces-389035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8DA9B67C6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6B328327A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0A0216DFB;
	Wed, 30 Oct 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c/IxGIxf"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE050213135
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301954; cv=none; b=LlcHI2bN8Yd6K3DVf4F/L/7b/VDSbztAfgsqBNhsWJykAA8kx3uv3SpSPqSj9vb0p+HDWAbcRgsMZA0VUKb/b9k5zJy+NQVFIvwP7ivzLYPAftKBx0FHoWY9dS2YPu9P63XTubKq59GhmLrO/tF/Okkoj9MiQeywE5oQeK5iK1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301954; c=relaxed/simple;
	bh=HrPOdx9KF4cUFjIto9wQp2qq/9hGUo3H6jKfQr0SfEY=;
	h=Message-Id:Date:From:To:Cc:Subject; b=rQDdmIeEBFT60FBvL4OQVqQUQo6zrQdfN0FVq8iuaUHZZg3/mSAnlq5PuqhE14f9CWBlCeAbnFp4mGiUzhM2j0QqJZ+AtZlT/1p6tW96hHmic0rMpBoE8ET5E8YeDUCrcqcsnpmEZlXQDzJS45MpidkSMbmFB4DYn/ttdaBcxGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c/IxGIxf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=HrPOdx9KF4cUFjIto9wQp2qq/9hGUo3H6jKfQr0SfEY=; b=c/IxGIxf7IEmGyFAU4Zm2JW2L7
	vfyoaR6wFvCMObAMr/8Zwfrj4rYwyWpo46N9h5Ai/n9FQRlhpE4Zzge/CqSSzNSyDJU/f1JgNQE76
	J99l+XJ/sezICKTk83UJT3TObKfrFc+EDZzh24o3KNULH5GEsDp/FcFTTCm7IB2UQNkeitywpFOIL
	lt1PQV+cWzkrBbMNb+AFWiK9QDXl7alCVwoPhlOED0nO7TKjplxDKohFl6MHPvVc+1AB0Xd5RMC//
	ymlwZTN1J1oubcoq8g8QjVOs1P+Sq1+nPp0jV5c+8oacJ214/30nUwgtjbj/whR3JAKB88wTvViit
	4mra87xw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6AZs-0000000DYqT-2YBv;
	Wed, 30 Oct 2024 15:25:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D6B4B300ABE; Wed, 30 Oct 2024 16:25:43 +0100 (CET)
Message-Id: <20241030151255.300069509@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 30 Oct 2024 16:12:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 void@manifault.com,
 linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 0/6] clean up class switching
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi!

Recent changes (scx and especially sched_delayed) made bit of a mess of
sched_class changes.

The first patch fixes an scx bug (some day I'll remember scx), while the rest
cleans up the whole sched_class::switch*()-eroo stuff.

Patches are very lightly tested (as in, the test box boots).


