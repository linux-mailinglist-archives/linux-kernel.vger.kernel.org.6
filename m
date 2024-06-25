Return-Path: <linux-kernel+bounces-228546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A6191617F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 767E828558B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA19E1487F7;
	Tue, 25 Jun 2024 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h5Nc5AVP"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB09E1CABF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305002; cv=none; b=Ye411o1DEU9kFa9E7u1yYFv5vrU9M02t9ckncgM4Rebf+M/gfNzgnpG+qRRhihSik3ZvGp22AEcv8vzjw8FYPGiBf4djZv4bXZMPKv4y631hNtB/5/ZiWJvqfPsyT5oHyDCbNjGlT1uPu3VB1OE/MKr51FrxIB4JrZNnPu5uxOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305002; c=relaxed/simple;
	bh=zkOjfyKhZ0zxDTbHHw6mP/bcgD2m4oY2XNCEYdpg4L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfHWiRbji30c003dPBU7C5jwBMwwCwlgAUBjA8O9tdjoQSE8WUQThL5lxNMpmQmFkL9LGkTImgPKTQ2I1lXSCKCs94v8tbnMwMqhJ+76ExBy/j8u92HY2onygzrS8QgSEujcto7rqaHWlK1a69FzxI+5V4uoE9NxPHR8DgqGF/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h5Nc5AVP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Gn4+W1/TLGbgbomMvxeNcnCegXEs4p9DDVw0WGXpnIU=; b=h5Nc5AVP/zcrKYNZeicOE3LC3i
	5LWSwscGByffJYtp8rmlez/PSgJN1m9SkeB0xDPepvoC4jXihYIGWoxH/yq6gKCwQ5M5GKzOJa8mn
	9+IzmALYgBbZO0KL9fRMqxOAjH2OmSeFhqqYyoPyfC5Dev2lhx8a9ipZLMxOjDAlPt8mWkFJo4+UK
	g3HvInpx0cwQx0PNSBkqYKXF5JJHmRefU5lyF+9/9wE7yfnel4jORdYfb/0wRXrTjJyWXwXpYhGMY
	jpZDC++PqX9g4GUkCbKk5cbKT0Pecc+12uy2vmr/l7UXnc551WPPvm+WWk5+OeZJhu0PVkik7vKn9
	xmcCLZag==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM1la-00000008NFP-2bRV;
	Tue, 25 Jun 2024 08:43:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BD587300754; Tue, 25 Jun 2024 10:43:05 +0200 (CEST)
Date: Tue, 25 Jun 2024 10:43:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/4 v4] perf: Fix leaked sigtrap events
Message-ID: <20240625084305.GV31592@noisy.programming.kicks-ass.net>
References: <20240621091601.18227-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621091601.18227-1-frederic@kernel.org>

On Fri, Jun 21, 2024 at 11:15:57AM +0200, Frederic Weisbecker wrote:
> Hi,
> 
> This is essentially a resend to remind the patchset on people's pile,
> using a small typo fix on patch 3 (thanks Sebastian) as an excuse.

Poke worked -- I remember going through this a while ago and only having
small niggles. So this one must be good :-)

I've queued the thing for perf/urgent.

