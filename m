Return-Path: <linux-kernel+bounces-537429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F4BA48BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7AA3B5611
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B2E219A68;
	Thu, 27 Feb 2025 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8D+yU+2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE2F27781F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 22:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695824; cv=none; b=s0Bqjnloql2PRPywK9KgsAfYIeDhMwn+lEw4Y5V9H9c8tTMRL93BKQXMFYd5+pfqbQPSdhwPZztoY7h3QxCbWqNdkZluTe0AdDIfpDquA4n8eqEt0f7KpQtvBINJhJww9I3e+DDQg4cKKdTosdP693p630eAcxcucpZXKGYS45Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695824; c=relaxed/simple;
	bh=Vf3JqGGYVGnRh83afWoRfiv4LqPUwmISXhnpuxrz4GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsnFjHVg3+Yy3A0u6g0klaQOBC9rIynPeOeozzenw2yBfWMlSZ6XZMMZlukPWC8lK8iEAEIzOixZeUMCKnlOV9eIC9cT/Mds+CISDfBQaBxwAIvpSxwYl6uYDVMKNiplHASf5IFu0YAOrcQMrnUugjwe8BFsdx0oVJqV3K+J4Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8D+yU+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879B9C4CEDD;
	Thu, 27 Feb 2025 22:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740695823;
	bh=Vf3JqGGYVGnRh83afWoRfiv4LqPUwmISXhnpuxrz4GM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o8D+yU+2eaegpK/CSj8LKpfUqNAoxObBqrwGfdg6v/2JJ+7R6CVe+fbfHCybgcPP6
	 5Qi75kUhc8RHRz/WjxaKUyMylEBaFRsPo+DwIjulOKQq5On7ulOY+A5BayPL9972La
	 1HeQe8XC1vYoM4cp9pLeLyzmwXmqxdru6ZocXacckqGtA94l+9tGnNY2xnLrM+xGE2
	 hPF9b1Kj1MAlneyb32Fc1Rr7uamTArPF+rDThGohqdajxFaWMAIxRnbF0Kma518RVV
	 NfHM/glHs6hkZNsPCcQ9RNH+X1Goy0SLoBxD9TdsPzxoZLLDC4RV8gTxzlpjmu2OoT
	 DDf4zVwHfXtDg==
Date: Thu, 27 Feb 2025 14:37:01 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v1] x86/insn: Fix linux/unaligned.h include path
Message-ID: <20250227223701.ckpdy2z6qy34dzud@jpoimboe>
References: <20250225193600.90037-1-irogers@google.com>
 <Z7-ylCsV43noci77@google.com>
 <Z8CW4ozmV4OwyXWm@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8CW4ozmV4OwyXWm@google.com>

On Thu, Feb 27, 2025 at 08:46:26AM -0800, Namhyung Kim wrote:
> Adding Josh and Peter as it's used in objtool as well.
> 
> On Wed, Feb 26, 2025 at 04:32:20PM -0800, Namhyung Kim wrote:
> > On Tue, Feb 25, 2025 at 11:36:00AM -0800, Ian Rogers wrote:
> > > tools/arch/x86/include/linux doesn't exist but building is working by
> > > virtue of a -I. Building using bazel this fails. Use angle brackets to
> > > include unaligned.h so there isn't an invalid relative include.
> > 
> > Right, it's using tools/include/linux/unaligned.h.
> 
> Josh, are you ok with this?  I can carry this in the perf tools tree if
> you don't mind.

LGTM

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

