Return-Path: <linux-kernel+bounces-561417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C47B2A61176
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120DE461403
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FE41FDA93;
	Fri, 14 Mar 2025 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EJWoeO29"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21871CD3F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955826; cv=none; b=D38XtXayYkeHR9vbfU7QF3rS6LfdMwEWKW33T679Vz1TvlclY8/HT5DaraU+Kyd1aQTeZ5mVIfpFbGoGNqd5BLumfliIjndubfcVHJdagh5bSPIpjAI91H4dmEFXeDDz6FrZQu5yuf2HY2oWjqTt8S//zDhY9Pf9NTEFgo1tszY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955826; c=relaxed/simple;
	bh=iWc7k+5rdMuDJNMosz5+lnafca5gIuxxwLrpH2pKsAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+QDY/YTad7uP/BC4yM4m51NAZbnr0wdUCnm3Qpg0BMQWeKC0fMVM3nHoPWRtN6w8NCD51x/9TYNhpG5+v1JSAPLaU+s69MEjBFV/uSM++hy/f+HKZin2ChFXilbxJY4X7CdQUE5FXAO0uGsLxgJTZA1/SmuNSUlW1mYRFvUQIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EJWoeO29; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IC9QMaEw6FvqZDu83lXmjMoZvzlZbLMqnRbwitYSCG8=; b=EJWoeO29/ZdR30XAbUKD239Zu8
	zFi3w4m+IOEP3yqIbQ+ZKeUEwJAcLyp4Gb729/NXDzahL8xLinyh5ID2G6ArP6HCR0Uwot7jGqRwT
	gvu1cyy+bH5wVQcJTwvGMTMGvA5jvkv2jnmsLEl5uOgk6HhELEZsOsnv6P4yTR3t8DYf+zf4KBFFj
	Xny6bmgSe13/tTW8jS94542f7R0MQqPcccGkBgdFF74Yw0MTzL75ZiT/xeo7z6e+O2WVRJrEM/SWS
	QDooaR9nHjq4IFoiWdZlq/ic5I4VxqcKFgjt3hAXgY4O1iax0Bsak2uasbXwsv2AQ+TqXFWVuSc7L
	ENxLM+5Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt4HU-00000000HfE-0ON5;
	Fri, 14 Mar 2025 12:36:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 079FD300599; Fri, 14 Mar 2025 13:36:51 +0100 (CET)
Date: Fri, 14 Mar 2025 13:36:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v10 15/21] futex: s/hb_p/fph/
Message-ID: <20250314123650.GA5880@noisy.programming.kicks-ass.net>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151634.2183278-16-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312151634.2183278-16-bigeasy@linutronix.de>

On Wed, Mar 12, 2025 at 04:16:28PM +0100, Sebastian Andrzej Siewior wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> To me hb_p reads like hash-bucket-private, but these things are
> pointers to private hash table, not bucket.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Hum, do we want to fold this back instead? It seems a bit daft to
introduce all this code and then go and rename it all again.

But whatever.

