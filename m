Return-Path: <linux-kernel+bounces-226858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF089144DA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB97728663D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B92B5C613;
	Mon, 24 Jun 2024 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JNcUWoyb"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA2D4DA0F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217773; cv=none; b=qO7Ywrc3xMmvKVVOd96AXDiJBzmP4uRUJ7B5uLk0V6DwUpJHn3gBlar+1jgR7jRTVyP6W3FPD736TuueiupmvlCGW1wgsMStrv7oXP1jwhB0upLKbA/3SNt8cMCNDbuSeMqoKorCHeaMPavGcRZb4H+uvRO/KBJwpC5nHy5qSqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217773; c=relaxed/simple;
	bh=WeMXF/M5oyRrlBoqEZMJzcLfPBvunbEbMwBrIM64Ufs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isgVQHdsVCy5jOL1LThMT/MVcDEmVhtxkCfaCl29zMCRdT0jRDwhOATv+AfX8alHwyDuMiu6/GatpH4TaBmLOCFynmDzr1FrfxbnfhD28yZo3lQjtsnnFtfGL/7FBzt/vgS89yS6BnI6HdQAuIip6o/MTLjk2qHpbUBB5KO1L4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JNcUWoyb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WeMXF/M5oyRrlBoqEZMJzcLfPBvunbEbMwBrIM64Ufs=; b=JNcUWoyb/3Ys0/tUpUCOQLAlMS
	yB/FAKwtL61ZErqHm6bJvz2caHOP4OiC2/+vDM40lp1uubhNZDt822bsEdy+8nfKyZOOrp1J9DQL9
	sk4tfE2ewAq5NW13t90KNY5ohftY5hVvahMsXh3Bsj0Uw1CCSlC8aytnyBHNyng+Bz3Z6rKGrJOyL
	IltJ1p6f0dD7B3Rm9z96RVR/RNkWp+nLCiZn3F/sXOr7z2DzUDhTkkoP4tUaFP/cXwE4SjeJ7bhCK
	Q65gIIHw8o7PIndY4Yo7qB3xOY4+XvzA4wdfmif3EAIrKjmVHJ3d27ZuyNKGQOUxqGgrZ0mMe9CH9
	pFYdXhkA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLf4p-00000009qnM-1XEl;
	Mon, 24 Jun 2024 08:29:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 09DB0300754; Mon, 24 Jun 2024 10:29:27 +0200 (CEST)
Date: Mon, 24 Jun 2024 10:29:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com
Subject: Re: [RESEND PATCH 01/12] perf/x86/intel: Support the PEBS event mask
Message-ID: <20240624082926.GD31592@noisy.programming.kicks-ass.net>
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-2-kan.liang@linux.intel.com>
 <20240620070215.GP31592@noisy.programming.kicks-ass.net>
 <840ced10-cc0f-4883-8559-772c5521a092@linux.intel.com>
 <ab9ca3e3-6484-482b-aaf8-6be21dd6fc9a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab9ca3e3-6484-482b-aaf8-6be21dd6fc9a@linux.intel.com>

On Fri, Jun 21, 2024 at 10:19:34AM -0400, Liang, Kan wrote:
> Think about it twice. Although either code works, we should try to make
> the code as generic as possible.

That! Thanks!

