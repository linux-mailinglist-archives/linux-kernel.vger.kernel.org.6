Return-Path: <linux-kernel+bounces-332553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E5997BB22
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4391328467B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD74E1836D9;
	Wed, 18 Sep 2024 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="od7TtIhx"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443DA178376
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726656941; cv=none; b=HO9AJrCIaFBss8JZI48W3kkUXg+eF0zPtvCs8c65N5Go0uwGyTU/unC6UVszQXJb4HvqK3VWc57GphsXH6re9ktVjrJAub/Mjhcu/JOhWGxHo0UWa/299Jr+cmTgd084fzoRV0du03HSg0lW7eyePDjdOyyCrdlItY7JuoWBSV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726656941; c=relaxed/simple;
	bh=Ur2EMeticBjNZ9iJpv7p4pR6Weq5i+AQfz6bvuwlohU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3Hh2YROIyn23D7G57NG3Ux6j8XHji0i6UtMeEEacF+/9eKW3cCneXwmETdl0ub2JX1zQjjRDQ25LOp2NKkSLChJrEFHQkE+yqyoTI4l4xX8QGxp4MN7D8HLqKriyNtCkk3a4WKlULwn8ApVIA8OqElM3Xjscy1OfyiYAw4i6j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=od7TtIhx; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=yyEXUZ3RQ1qxYBxqZeUIoPgjNl+F/3RttZyZCmpr67o=; b=od7TtIhximjnEzTn
	kDfajJbC2Be8pV0OF2CqLeoDP4UGYd5EiGc0hFUDi3k7SJ7Rn2SlIDl9AJFV3sJPUhX7M6GZoxFlJ
	MIE0KNA8PnymqehCTArRi0oYe39LH+HxJ6K3WqyP9MDXlxwZRdAnOEosJe/W5jvu034bNBPKspYLF
	W1ytyGbpGkWBIzkERwpf8ID4jGsLvoXPaP3OWHI1ahk4AN3NIhI3V80iDIXR1eOqNPHcaW1RSe9Rc
	qTlxh5UqH6kcZ6NUMMv4Y9KFxTcexd+wbGeQEn2b/a7eSNu4TDUpDiV1hdHX+OKooGMb1GwoSYZr/
	pCQqI9a8CLRRBVMb+A==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sqsLM-006H06-0p;
	Wed, 18 Sep 2024 10:55:32 +0000
Date: Wed, 18 Sep 2024 10:55:32 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	kees@kernel.org
Subject: Re: Dead code by symbols
Message-ID: <ZuqxpBRVSYIk1Hkm@gallifrey>
References: <ZugliLgw5VFb9yau@gallifrey>
 <d289061d-7dc8-41d7-a166-4b3b8dce886d@redhat.com>
 <ZupwWT5ZEHFmWIXz@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZupwWT5ZEHFmWIXz@infradead.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 10:53:27 up 132 days, 22:07,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Christoph Hellwig (hch@infradead.org) wrote:
> On Tue, Sep 17, 2024 at 01:39:35PM +0200, David Hildenbrand wrote:
> > > Now, it does take some more guesswork, for example an unused function
> > > which was added a couple of years back, might be something that's
> > > there for consistency,
> > 
> > I know people will find reasons to do something like that, but we really
> > *shouldn't* be maintaining / dragging along dead code that nobody might ever
> > use.
> 
> There never is any reason to keep dead code around.

Yeh I mostly agree; and indeed I'll be sending many many patches to remove
the bucket loads of dead code I find; but as I say, there's a really
big variation from the dead-for-20 years, to relatively new, to 
functions that seem to make sense next to the file they're part of.
So I'll get to those later, I'll get rid of the very dead ones first.

Dave

> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

