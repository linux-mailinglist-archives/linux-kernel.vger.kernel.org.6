Return-Path: <linux-kernel+bounces-309453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C88966AD5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC241F2436F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61381BF81A;
	Fri, 30 Aug 2024 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wd4oCwzn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5DF14F9F3;
	Fri, 30 Aug 2024 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050847; cv=none; b=Iw5jCtLmqrk9hkK0yUqzCRnDbB4MMTzWTiFt/qE5lMBTp3B6zD5MtpR5sPSLlFbOE1ZOxrVOIGSSjedDzI8VXBaVLTojhHz9poXjCw4bDWtugHQ2av+J4FFUIsKTC+9iRb7pWDd5NkDnWs9IGtNTz21/V/0opBzXM9dJA91hPhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050847; c=relaxed/simple;
	bh=75EtIvAaFBVgzO4eYiFTiZ0lVf7TXVl88lNzpIMKXfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsvgPc/NiynMweaMB59etl1Rt07nmOorb+TBbhRz6e7pRSgSWsvy0fyhKj2PIpW5W9l3hyKTA8O991UNu68c34u4/JspUVTRnTwKTbwvmQXR9IbyteIjK/sYfz/28bphPli+E2+x3DD/FuK5rteJqe78zLFA8EivnqwRblJOxZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wd4oCwzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E50C4CEC2;
	Fri, 30 Aug 2024 20:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725050846;
	bh=75EtIvAaFBVgzO4eYiFTiZ0lVf7TXVl88lNzpIMKXfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wd4oCwznX4WFN9nXdN67kGv2vH4BHRnvsUw3wTH1OGMiIDzfqYzAByvLyiboHd/GX
	 lhsmxQkV/3rgB/zpifRgzqOLnTjDybVcD+dXRASZQGv+4oW1HCS5yTDDIJnT5EEumB
	 gZ/sAFu0oQ6oTPBta97jonhdMRwBH1ePYk0Lw7b3Rk68Zx1qPN2MiUCZtyn/PRXDYe
	 qmHNPmFQKqUdceMpKHlhtQVt7KSLlRsvdYpTLxWaodpAea8BA217NTGaet9iy1/59K
	 Z4sT4BJDNmghgc0E528ilmf9GtKkQ6pNg8BBzDPly2QNLEG2ClbK6YNpsFcyQSlz6K
	 15CV3JzaCH1aQ==
Date: Fri, 30 Aug 2024 17:47:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org, Xi Wang <xii@google.com>
Subject: Re: [PATCH] perf lock contention: Fix spinlock and rwlock accounting
Message-ID: <ZtIv21BLm9BrU4CD@x1>
References: <20240828052953.1445862-1-namhyung@kernel.org>
 <ZtHH6JcfNUBAQAen@x1>
 <CAM9d7ch27q8JycAvOqKzeG+0eXFbJ_o6qZoVSS6aUrWTpU=vdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ch27q8JycAvOqKzeG+0eXFbJ_o6qZoVSS6aUrWTpU=vdQ@mail.gmail.com>

On Fri, Aug 30, 2024 at 08:51:43AM -0700, Namhyung Kim wrote:
> Hi Arnaldo,
> 
> On Fri, Aug 30, 2024 at 6:23 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Tue, Aug 27, 2024 at 10:29:53PM -0700, Namhyung Kim wrote:
> > > The spinlock and rwlock use a single-element per-cpu array to track
> > > current locks due to performance reason.  But this means the key is
> > > always available and it cannot simply account lock stats in the array
> > > because some of them are invalid.
> > >
> > > In fact, the contention_end() program in the BPF invalidates the entry
> > > by setting the 'lock' value to 0 instead of deleting the entry for the
> > > hashmap.  So it should skip entries with the lock value of 0 in the
> > > account_end_timestamp().
> >
> > Thanks, applied to perf-tools-next,
> 
> I think this can go to perf-tools instead.

I think I published it already, don't think this is a major problem tho,
we can make a note when submitting for v6.12 that there are a few
patches that are already mainline.

For the future, its interesting that when posting patches we inform the
intended branch where it should be applied, something like:

[PATCH perf-tools] ...

Or I can add something to my scripts to check if the patch is a
regression introduced in the current merge window...

- Arnaldo

