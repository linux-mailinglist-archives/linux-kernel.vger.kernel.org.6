Return-Path: <linux-kernel+bounces-558353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B642A5E4B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CEEF18950A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B66258CF6;
	Wed, 12 Mar 2025 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jm6RkIOR"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7EA258CF8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808633; cv=none; b=uYlzLB9QPg6eO3KNb5arcYvD/uOhvNENHvMW66KdhG3r1ih81f0jWYgQ3NSdT8JwtadDt2fygjINXv6yPILAG9m44m4w5MJeRZ8RL8sabIdUDBdg2pVakYu8CGGcFAIf7eiZrXDKqIp9hhLVHBM6T/COTrIOnRrqPiz6mkknuBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808633; c=relaxed/simple;
	bh=d6zzect/sdYr/cCXfvJppxjmdys4AynPPOCTWQdhxR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FP6X6u3NX0+sC8p6r/ux1XPC7Dc2uBwNNhP9yTDrO0I9zUSLtJFxRkfliJIbVNYzvB7OiepSShMC/4qKpi75/8XAUNSlufvplaVsbjS1wftyggvWpXu9iihErFjq+C83mqj4OzwQqGKQyNbubhwDiiw3OI9gYVGX2eeMykwvRSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jm6RkIOR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d6zzect/sdYr/cCXfvJppxjmdys4AynPPOCTWQdhxR8=; b=jm6RkIORheRR37Qn1JMjFsbUQT
	iLYkXsPs4azi8XT2oMX7olEpzhF4rooJm3MiOmtZgbEqZXL8Bu1j9z2TuSeuq78FEuJRv6S01sQKb
	VXJ5S0yhHVdxf48Vj6ND9vnhbZlIMKam9CRX/qtFU6cpWHdBjXeT8zCOZfsg3shiETKQCfL3Wmkze
	bGQ+XZARohwzUkvUBzodcfUafLhv8SrNGWHg1S9kayPzSTBLbE31/KmFEaBq+aW84/q43blbWgnRN
	fd+LsWIf5TdY2Q7Hf9w+OJhkuhOjiiQJ/Ma9fYPvO1fE64FvYskfrmkGGGxlNtpQGd25qHDo93Cjy
	Lg2W64+w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsRzU-00000002TN0-3eTN;
	Wed, 12 Mar 2025 19:43:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5D909300599; Wed, 12 Mar 2025 20:43:43 +0100 (CET)
Date: Wed, 12 Mar 2025 20:43:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@redhat.com, tglx@linutronix.de, bp@alien8.de, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com,
	linux-kernel@vger.kernel.org, ak@linux.intel.com,
	eranian@google.com
Subject: Re: [PATCH V8 1/6] perf: Save PMU specific data in task_struct
Message-ID: <20250312194343.GC10453@noisy.programming.kicks-ass.net>
References: <20250312182525.4078433-1-kan.liang@linux.intel.com>
 <20250312190533.GA10453@noisy.programming.kicks-ass.net>
 <702802d2-7318-4575-81ac-4fad6f8ff42f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <702802d2-7318-4575-81ac-4fad6f8ff42f@linux.intel.com>

On Wed, Mar 12, 2025 at 03:41:06PM -0400, Liang, Kan wrote:

> The kmem_cache is introduced to address the alignment requirement for
> Arch LBR.
> https://lore.kernel.org/lkml/159420190705.4006.11190540790919295173.tip-bot2@tip-bot2/

Urgh, okay. Please stick that in a comment somewhere.

