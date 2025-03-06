Return-Path: <linux-kernel+bounces-548537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EB0A54633
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D37A189585E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EEB20967A;
	Thu,  6 Mar 2025 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkmpD9y4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912C219CCFC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253081; cv=none; b=iKQYPxSP8CSQNalnqziH2VMeGSU0pHTJdkbIpICl4K5hiZusYG3M312189xnCcq0PNm9+Fn9MJNSgM77Qo2Tg3GqD2N5OOgDgmk00UEq9WYR0aGX0ah4hp436HONpsQA/E1UKURz9rh6VH1d2dUvm+78QE838jkhGy1icF9KLTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253081; c=relaxed/simple;
	bh=DMNEwMMCToXbqvKWO5VHsSmY5eBHtySWCjfyioNYdqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wbfx7RpUn89pSgCGDWI1xaVAYuBMZYCCtNtM7NONjI1m9uP2hhmLfjPGv20c/q+VsM33UqQolo80qL2Aru9t7gBTovUg709LaI08k8sWxUp7VOHz52ITkPQD/I3VpSnWe2VCoERBaNTWJLlZOTLZECNwueGwLm8mfbP1ihjU5YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkmpD9y4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F042FC4CEE2;
	Thu,  6 Mar 2025 09:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741253081;
	bh=DMNEwMMCToXbqvKWO5VHsSmY5eBHtySWCjfyioNYdqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fkmpD9y4YPa4laMqDgvsm1VBrrBAf1xEry8NLJTBSzVFvdTDITcbV78fd+Hd6pNsg
	 FZoxsBtQZ+6NCznMsna7IaNBrBkWym4iNUZRy5fhMvD7GWbyf8fhYdRtr35RT6nA+/
	 W5dMm0k3doyUnbDW4hMFUvf2q0V3INUaTvyAxL9CzT1Bzn0Dz/TP4EZE+/wivnGmxG
	 0S0ZrRkBI5A2jUCURLsgax+lWCfo4L86D0tSJhuEYYJv4aOKQ1g1wh9HtGBJi/KXAN
	 xfDM0eGk0bGeNY/pccECRyGbn2KlRvov7afDaQDMciURM5euEVRv0Mhz9h/xErdaBL
	 AHMwCWkf5Zb4w==
Date: Thu, 6 Mar 2025 10:24:35 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, lucas.demarchi@intel.com,
	linux-kernel@vger.kernel.org, willy@infradead.org, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Subject: Re: [PATCH 04/19] perf: Simplify perf_event_alloc() error path
Message-ID: <Z8lp0z-7nlUr7LyD@gmail.com>
References: <20241104133909.669111662@infradead.org>
 <20241104135517.967889521@infradead.org>
 <Z8lVchtSX/w/atEU@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8lVchtSX/w/atEU@ly-workstation>


* Lai, Yi <yi1.lai@linux.intel.com> wrote:

> Hi Peter Zijlstra ,
> 
> Greetings!
> 
> I used Syzkaller and found that in linux-next (tag: next-20250303), there are two issues and the first bad commit for both issues is
> 
> "
> 02be310c2d24 perf/core: Simplify the perf_event_alloc() error path
> "

We've had a number of fixes in this area, could you please check 
whether you can reproduce this crash with the latest perf tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core

Thanks!

	Ingo

