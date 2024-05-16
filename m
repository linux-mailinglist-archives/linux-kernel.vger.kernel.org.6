Return-Path: <linux-kernel+bounces-180961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AB68C757E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10CB1C2108A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4695F145A13;
	Thu, 16 May 2024 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="gMmQ2SmC"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E22926AD0
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715860577; cv=none; b=rfFVf5GgokZ26up/bM/BlhCZsy51v58u5yFast3jk8eKbS5yBNk5Jec7EdlPYQieyug+Zy14qBbwaFo9A48TPGwRBTPM/A3WKZP+c46u9MvvZKFUvizGMJ03718FvxxULWWSviUdXa8VTFd4rv7/CwQc7H4ViWmm86IgLD6mfYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715860577; c=relaxed/simple;
	bh=2B/fjBB4aYHf8t1LxfBe614e9dXmRNTwtbSxV5tvdmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpde7C6j5UMjF2E0MSljcitCSP8dK6x4dbQE6Qg+3vFD2Y6hy+B77uHExvc+dLe6EtNZVhEDpxb40PQM7vh+wVeLPo0253e8tizCniH7OY+kJhWPC9Zs9bKDaPw6GO64k3hZkBcrAUiEVBl55iCZWdjXLvYuiESbbJD9JiRBurw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=gMmQ2SmC; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=OJk0VDLmJe2K6Dsn2f1ZTNRqPDlvCme3nV40CtZqDfw=; b=gMmQ2SmCWlTGB51t
	mCMUNETpNHIctdAz6t6GvhJJNGhUnt+ug6N7TNvt++y189g6y9ZDFFj6WtUx4tczdrvHKs3w8mr0J
	pDvXjfYsfbXNOmqJcWtwOZDYALMEjjm43pL20grvRolQwkzTALKxeCibu5udrxmHRNWUb1WeCaVSt
	7UZfS1K1etC06XvlE/7Ksza3qzO3srNJMWKzYlGD2SuAQVjOx6C17xEV2jmMHevRJzB1DXY3QH/87
	0FeZaIIa2cypeEOxGl0CBh6QShg+yhJ5lIf1pJZHj9cA81PwF50OqX8K7wAivY2/7zAiJ0XJaOj7d
	X7/pFIi5AW0ZsZxkMQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s7ZiW-001DAy-1G;
	Thu, 16 May 2024 11:56:12 +0000
Date: Thu, 16 May 2024 11:56:12 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, nathan@kernel.org,
	luc.vanoostenryck@gmail.com
Subject: Re: thoughts wanted on dead code hunting?
Message-ID: <ZkX0XMrRGceOL8W-@gallifrey>
References: <Zjy82Ja6G2iIHl75@gallifrey>
 <202405141706.1D5D26C@keescook>
 <ZkVWCOZDb7iewLxL@gallifrey>
 <202405152023.67ED1BD7@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <202405152023.67ED1BD7@keescook>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 11:52:45 up 7 days, 23:06,  2 users,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Kees Cook (keescook@chromium.org) wrote:
> On Thu, May 16, 2024 at 12:40:40AM +0000, Dr. David Alan Gilbert wrote:
> > * Kees Cook (keescook@chromium.org) wrote:
> > > // Options: --recursive-includes
> > > @find@
> > > struct to_be_removed INSTANCE;
> > > struct to_be_removed *POINTER;
> 
> Oops, I missed this line:
> 
> @@
> 
> > > 
> > > (
> > > *       INSTANCE
> > > |
> > > *       POINTER
> > > )
> > > 
> > > 
> > > (I bet this could be improved, but it should be a usable example.)
> > 
> > Hmm, now if I could use coccinelle it would be more tolerant of coding
> > style and slight variations than my script.
> > However, trying that tiny example, I get:
> >   File "play.cocci", line 10, column 1, charpos = 141
> >     around = '',
> >     whole content = )
> > 
> > so it seems to be objecting to something at the end of the file?
> 
> Sorry, yes, missed the "@@" between the identifiers and the code pattern
> to match.

Ah right, that's done it - I'd noticed there wasn't a @@ but couldn't
figure out where to put them.

After a bit of guessing, I also added a 

virtual context

at the top and now:

make coccicheck COCCI=play.cocci M=arch/x86 MODE=context

works - thanks!  I'll have a play.

Dave

> -- 
> Kees Cook
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

