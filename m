Return-Path: <linux-kernel+bounces-385633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836149B39AC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489A22841BC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347D11DF738;
	Mon, 28 Oct 2024 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUjMvNnR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A953A268
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141619; cv=none; b=cNueFloBXNFQIvHMsyJCQpEMbYpx4c0CZD5YZ3d7vXEAvVYZfHCTfdgoZNlEG1moNYl0/PUfERadxp3w/wBXxIMq+ErjAj0CEa9IDl85UcqjyDToptl1vWmARfvWhom0mPkf3hO6rcmIRS/9/oCg6jqsv+glp6MSRbMrew1jV0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141619; c=relaxed/simple;
	bh=xkBPMQLPiUWTee2CmXHp8dR7rCR1oJiapPKYL5A0QtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfJig5P4uM1KdhXfBU4PucsTOGDupmB6HNoCrSyiDF0/BIOCp7JzKZQf7wkVy6/WUhO0QjpQcuwsq2MgUhMa48SABj86UTkNqO+ALE6MbOsnXKeOxhjhtSCkSCdPuogO5OVd/LXitlF4WON54KP1qixsacx4hBcDPFCdfoFHKXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUjMvNnR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB45AC4CEC3;
	Mon, 28 Oct 2024 18:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730141619;
	bh=xkBPMQLPiUWTee2CmXHp8dR7rCR1oJiapPKYL5A0QtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GUjMvNnRd6tWft7qTUZpsw3Yh/RS0whC44Moln7EuEwg4ChYFPFiJqjdO0vjMwCRi
	 2FV5laJkDhGl8OTyOvjz0ofrA/Lt2brbBMiHyWdgfWZGZ3qsEvD6wwYTB2XWtKxw/H
	 V+GSQk4XQDHBFEShSbzHp6+9YNmX6zsyfsRBiPiCp1sfGvBNWboBTpuV8bz84gBAji
	 U0OKc0hzJ0gITb8AmNbMVpqLS5/JiA35b4CUYuuz+e2nQVvIk3JgfGKGJUm4N7Qh+z
	 CvJIARQHY55J/SFRKAen0YMqRYEBjeyoXt+5rcMt5vfYjDcorZMTq4V76g2J7SJHGc
	 LZdvAzylcOTWg==
Date: Mon, 28 Oct 2024 11:53:37 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v4 1/5] perf/core: Add PERF_FORMAT_DROPPED
Message-ID: <Zx_dsfLx5DTLkK8P@google.com>
References: <20241023000928.957077-1-namhyung@kernel.org>
 <20241023000928.957077-2-namhyung@kernel.org>
 <87ed472i6b.fsf@mail.lhotse>
 <ZxlA2ZXbzg5dlKhM@google.com>
 <9da44581-9a87-4ee8-9d45-ccd74283bdf7@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9da44581-9a87-4ee8-9d45-ccd74283bdf7@amd.com>

Hello Ravi,

On Thu, Oct 24, 2024 at 10:13:24AM +0530, Ravi Bangoria wrote:
> >>> When a perf_event is dropped due to some kind of (SW-based) filter, it
> >>> won't generate sample data.  For example, software events drops samples
> >>> when it doesn't match to privilege from exclude_{user,kernel}.
> >>>
> >>> In order to account such dropped samples, add a new counter in the
> >>> perf_event, and let users can read(2) the number with the new
> >>> PERF_FORMAT_DROPPED like the lost sample count.
> >>
> >> Are we sure there's no scenario where exposing the dropped event count
> >> gives an unprivileged user a way to probe what's happening in the
> >> kernel, which is supposed to be prevented by exclude_kernel?
> >>
> >> Clearly it provides an attacker with some information, ie. the event
> >> fired in the kernel and was dropped.
> >>
> >> For most events that's not very interesting, but for some maybe it could
> >> be a useful signal?
> > 
> > Hmm.. good point.  It'd give some information to users.  I'm not sure
> > how much impact it'd have, but there are some folks who want to know
> > exact number of samples including dropped ones to reconstruct total
> > period for the monitoring session.
> 
> Can we restrict PERF_FORMAT_DROPPED to perfmon_capable() if it's a
> genuine problem? Or would it defeat the whole purpose of _DROPPED
> count?

Right, that's the purpose of the PERF_FORMAT_DROPPED.  But I think
we can discuss this interface later and just focus on the IBS swfilt
first.  I'll remove this part now and add it back separately.

Thanks,
Namhyung


