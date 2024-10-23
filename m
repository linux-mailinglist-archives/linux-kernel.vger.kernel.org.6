Return-Path: <linux-kernel+bounces-378681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC389AD3FD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4C328304F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B861D0946;
	Wed, 23 Oct 2024 18:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0C+BRlJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A597F1CACD3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708251; cv=none; b=BoNbGZ0XoWEyhE6Io/MXLH/68JhveJKMspbyz58qrGn4Ti+djMaSnbBCCUv5km5D2gl0GqGaEn/sG7mBQAsLam5mpuG1aVTFcRQY/L0TSmzZxejLdyCu0/3Se3gOJ8hPcYcWZ8Zarla3mbXvgYCog+GNJYe3uzJegC9mA2Hi0tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708251; c=relaxed/simple;
	bh=viiJ3SDn3iS0q3tyffDEb6qnCUCJC1meD2lr0HiQjcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoSWlAH5HWvP4PKtkuLEW2zNlB7+gURYGc3pKGe0PYEVLI7ltGFc93DHcrHdSAHeUhxt7Oyz/YAmRn02iLTDC4LIMNP3r6NtxlqCqZvhAz4KcoNszHhfueW1ZTEUvuudMP3PhcjycscmwDq2T9jlTcBYvVGIiGHVWltAVXMilco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0C+BRlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1772C4CEC7;
	Wed, 23 Oct 2024 18:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729708251;
	bh=viiJ3SDn3iS0q3tyffDEb6qnCUCJC1meD2lr0HiQjcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0C+BRlJL/dXCADlzKoFkGjLqCBJO5y7KSdWqAMNtZpAxoB311TA7EYaqUGpXGWBf
	 moLxYCWIRG4bSUfnBx24rApXt5IifZW5vSEJIk6aYVZxP1yOMDUkIaM7/Uwe1T0jjw
	 Ejyj4+DFXb2PqI4BU/PlF4/mlGd1vgqAAXekdqDmNtT3NU67rc33p177qNxzW4zkEq
	 knof7NtHGuHb4nCrnLivJP34uGsooWQFq4RhGJt2eN/PpQtGkdtnKzMFmhxWw9ygRy
	 iN5IShOkmqtcP8ZpK/UwOKMhXOOCZ+PM7nairgGf1IHG9RPd3t+lc+KJ63SnA5VlRW
	 OYXegtXYZluPw==
Date: Wed, 23 Oct 2024 11:30:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v4 1/5] perf/core: Add PERF_FORMAT_DROPPED
Message-ID: <ZxlA2ZXbzg5dlKhM@google.com>
References: <20241023000928.957077-1-namhyung@kernel.org>
 <20241023000928.957077-2-namhyung@kernel.org>
 <87ed472i6b.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ed472i6b.fsf@mail.lhotse>

Hello,

On Wed, Oct 23, 2024 at 10:05:32PM +1100, Michael Ellerman wrote:
> Namhyung Kim <namhyung@kernel.org> writes:
> > When a perf_event is dropped due to some kind of (SW-based) filter, it
> > won't generate sample data.  For example, software events drops samples
> > when it doesn't match to privilege from exclude_{user,kernel}.
> >
> > In order to account such dropped samples, add a new counter in the
> > perf_event, and let users can read(2) the number with the new
> > PERF_FORMAT_DROPPED like the lost sample count.
> 
> Are we sure there's no scenario where exposing the dropped event count
> gives an unprivileged user a way to probe what's happening in the
> kernel, which is supposed to be prevented by exclude_kernel?
> 
> Clearly it provides an attacker with some information, ie. the event
> fired in the kernel and was dropped.
> 
> For most events that's not very interesting, but for some maybe it could
> be a useful signal?

Hmm.. good point.  It'd give some information to users.  I'm not sure
how much impact it'd have, but there are some folks who want to know
exact number of samples including dropped ones to reconstruct total
period for the monitoring session.

> 
> On the other hand most CPU PMUs implement filtering in hardware, which
> this won't affect, so maybe I'm being too paranoid.

Right, it might be possible to estimate some numbers by comparing with
similar events in the core PMU that implements HW filtering even without
this interface IMHO.

Thanks,
Namhyung


