Return-Path: <linux-kernel+bounces-395462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D56C9BBE31
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF4C1F22A6A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B1D1CCEF4;
	Mon,  4 Nov 2024 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ye389VDr"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE5A1CCEC9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730749348; cv=none; b=Pgudl3H1fvum6x20lyRVUf+h2psgWdJ//i8uWO36BnxxL+sH7alKzDRJ9mZlh/3h5dSfNsrNcFtDxXJbVBHrAJCFNjtpyz7aq/IlcWFX8ieL4cjw7K6LjFVqJzncLcVCqOZkFxukpwhxAwBBp/N5MXrZ/OYIbwsRc/gh63RUGYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730749348; c=relaxed/simple;
	bh=vwEntz4/lvl+PfPmJPSfCxSEh9DupmxFHAAWG09equs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P21AGaAv9B77ImlNIYA4ocW5kuvUkalP4bNy03gVfdLbV6fW9LUHO8RP3jb0QdawjgI2u8LUAe2JTg6Tpdb0DRdvLR7tWUrS7zJYjHtvwhc12Nm/6RHO30UvGi4ZkHpM2v/Nndby0GOt3YMnwINDC3Q7X5Ms/7LdhCXMLW8Dac8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ye389VDr; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 4 Nov 2024 19:42:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730749339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9EYq7wvFbS6q3j3l1UKcFa9P60tlccxS7EyUqJu3c4o=;
	b=Ye389VDrzTm1qPIBqIv9xY4mHDS+T0+Im4Ip9sQNZG05W0bJk2h6j+7hNc8ghLbpP5tpSM
	/rJqbN2aoPu8Su8G5GGjaUdoMEc+O8iC1rjt/p/eVxTkZ7wPDxL9ESAcGkP4w+5k9WE7lO
	s6m3Uu3SJs1KGdzOzyUIWJzkzdWkRwI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Alexey Gladkov <legion@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrei Vagin <avagin@google.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] signal: restore the override_rlimit logic
Message-ID: <ZykjlaoNTndyR9dz@google.com>
References: <20241031200438.2951287-1-roman.gushchin@linux.dev>
 <87zfmi3f8b.fsf@email.froward.int.ebiederm.org>
 <ZyU8UNKLNfAi-U8F@google.com>
 <87o72y3c4g.fsf@email.froward.int.ebiederm.org>
 <CAEWA0a4Kz9exk04Wgx9UZ9YFfURnS-=50TWyhPHm3i-N-D_8DA@mail.gmail.com>
 <ZyZSotlacLgzWxUl@example.org>
 <20241103165048.GA11668@redhat.com>
 <ZykQnp9mINnsPTg2@google.com>
 <20241104184442.GA26235@redhat.com>
 <ZykaS1arGZ3DMFkm@example.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZykaS1arGZ3DMFkm@example.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 04, 2024 at 08:02:35PM +0100, Alexey Gladkov wrote:
> On Mon, Nov 04, 2024 at 07:44:43PM +0100, Oleg Nesterov wrote:
> > On 11/04, Roman Gushchin wrote:
> > >
> > > On Sun, Nov 03, 2024 at 05:50:49PM +0100, Oleg Nesterov wrote:
> > > >
> > > > But it seems that the change in inc_rlimit_get_ucounts() can be
> > > > a bit simpler and more readable, see below.
> > >
> > > Eric suggested the same approach earlier in this thread.
> > 
> > Ah, good, I didn't know ;)
> > 
> > > I personally
> > > don't have a strong preference here or actually I slightly prefer my
> > > own version because this comparison to LONG_MAX looks confusing to me.
> > > But if you have a strong preference, I'm happy to send out v2. Please,
> > > let me know.
> > 
> > Well, I won't insist.
> > 
> > To me the change proposed by Eric and me looks much more readable, but
> > of course this is subjective.
> > 
> > But you know, you can safely ignore me. Alexey and Eric understand this
> > code much better, so I leave this to you/Alexey/Eric.
> 
> Personally, I like Oleg's patch more.

Ok, I'll send out a v2 shortly.

Thanks!

