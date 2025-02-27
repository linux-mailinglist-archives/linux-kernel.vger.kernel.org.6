Return-Path: <linux-kernel+bounces-537083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8282BA487E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495E218861D4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD681DF270;
	Thu, 27 Feb 2025 18:35:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C367C17A303
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681340; cv=none; b=AiJmnTwnGozm36jkMBfC0UNWnSRnWPXRIlYY7EKCpjegK83DSop6saG82zQD0Why8JwG9eaAi+QLyH9wZkTLy47XUqFi02yfMVt+NJMQSxnIM/UAV7MeZsRxtxca/NYeIzJyzxentOT2c58aENT1SpfseeL/O8BZqaulPKa8Y0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681340; c=relaxed/simple;
	bh=9ByLine/BML7cSO8X0cHw0zBxpNQCbOBi+Xn8+HaENE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsRdZJKFdEYrW8zLXLtJ0JlhJ3WBjNVNKEo6Nid3n/yADxENLMJq285MDkhoKnoP27jtHJyFqPcg2gbdpfnrgmGgDOiZKfejvxZZj9sSjX5jUWsoMeP2+4m2nnKJmNTvA+jyOQ7sJcYL/Rlpxg2ufWsNuxkIMEHcMnfmbMR8ux4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77A751516;
	Thu, 27 Feb 2025 10:35:53 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EDB93F5A1;
	Thu, 27 Feb 2025 10:35:31 -0800 (PST)
Date: Thu, 27 Feb 2025 18:35:26 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
	will@kernel.org, oleg@redhat.com, sstabellini@kernel.org,
	tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, kees@kernel.org, aliceryhl@google.com,
	ojeda@kernel.org, samitolvanen@google.com, masahiroy@kernel.org,
	rppt@kernel.org, xur@google.com, paulmck@kernel.org, arnd@arndb.de,
	puranjay@kernel.org, broonie@kernel.org, mbenes@suse.cz,
	sudeep.holla@arm.com, guohanjun@huawei.com, prarit@redhat.com,
	liuwei09@cestc.cn, Jonathan.Cameron@huawei.com, dwmw@amazon.co.uk,
	kristina.martsenko@arm.com, liaochang1@huawei.com, ptosi@google.com,
	thiago.bauermann@linaro.org, kevin.brodsky@arm.com,
	Dave.Martin@arm.com, joey.gouly@arm.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH -next v6 8/8] arm64: entry: Switch to generic IRQ entry
Message-ID: <Z8CwbmCXguCEfJvx@J2N7QTR9R3>
References: <20250213130007.1418890-1-ruanjinjie@huawei.com>
 <20250213130007.1418890-9-ruanjinjie@huawei.com>
 <xhsmh4j0fl0p3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh4j0fl0p3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Thu, Feb 27, 2025 at 07:08:56PM +0100, Valentin Schneider wrote:
> On 13/02/25 21:00, Jinjie Ruan wrote:
> > Currently, x86, Riscv, Loongarch use the generic entry. Convert arm64
> > to use the generic entry infrastructure from kernel/entry/*.
> > The generic entry makes maintainers' work easier and codes
> > more elegant.
> >
> > Switch arm64 to generic IRQ entry first, which removed duplicate 100+
> > LOC and make Lazy preemption on arm64 available by adding a
> > _TIF_NEED_RESCHED_LAZY bit and enabling ARCH_HAS_PREEMPT_LAZY.
> 
> Just a drive-by comment as I'm interested in lazy preemption for arm64;
> this series doesn't actually enable lazy preemption, is that for a
> follow-up with the rest of the generic entry stuff?
> 
> From a quick glance, it looks like everything is in place for enabling it.

Sorry, there's been some fractured discussion on this on the
linux-rt-users list:

  https://lore.kernel.org/linux-rt-users/20241216190451.1c61977c@mordecai.tesarici.cz/

The TL;DR is that lazy preemption doesn't actually depend on generic
entry, and we should be able to enable it on arm64 independently of this
series. I'd posted a quick hack which Mike Galbraith cleaned up:

  https://lore.kernel.org/linux-rt-users/a198a7dd9076f97b89d8882bb249b3bf303564ef.camel@gmx.de/

... but that was never posted as a new thread to LAKML.

Would you be happy to take charge and take that patch, test it, and post
it here (or spin your own working version)? I was happy with the way it
looks but hadn't had the time for testing and so on.

I expect that we'll merge the generic entry code too, but having them
separate is a bit easier for bisection and backporting where people want
lazy preemption in downstream trees.

Mark.

