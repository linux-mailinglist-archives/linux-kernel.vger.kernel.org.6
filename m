Return-Path: <linux-kernel+bounces-526998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7525DA4060B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 08:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6174F16DFE9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 07:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28071FBC8B;
	Sat, 22 Feb 2025 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="euuKWPXj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B647494
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740208638; cv=none; b=YD/Hr42/v/Hw8TzR6NAVUHiod1ZWwdhUcbrNdnfVqbXwaeJqYsOWekinmTx8q/NiC8plu609RDLBvdwbXegg5cCL/vW5TuYHN1a5tQjp3Slsry9kffjrnpiFA9AYTODDScXPmnhJY/4sCYtQfGd6ufb5UcJbLzlWE3xFMm/bGnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740208638; c=relaxed/simple;
	bh=GWKyza79Ui4KgpUzStnf6vRjczBd+KXdrJEehFJ/8KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/05HRwyP3ibfUSuYGSDfy5FyLXjzdQAR3Q3eL2OyvNR7hE060W9JQ0Yb9eJFphdelgtghJE4Gdl1Y0XfiPPm/fzqT54MJmRYsyEavG70wrMbA2uLCYjo7wAO2UD87sEQo2oqdcf/D5d5CW/CzB30jUx2nRehbRC+A6/1lcwHPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=euuKWPXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C46C4CEE0;
	Sat, 22 Feb 2025 07:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740208636;
	bh=GWKyza79Ui4KgpUzStnf6vRjczBd+KXdrJEehFJ/8KE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=euuKWPXjUwbt5i6ShksGDlFK5oW+Zsq4ypB24NysXX5utPcW4hqM6Nhv63U+Kr8H8
	 ci7PpKZLiWDT/fTjc5IUlYDk2fOlihetUvgC4jaPofM5HtYxZjAI1ivj84byb3Mygt
	 Y8T4p33rT+M01XIYOWQmd7i8J4TucT2aP4s5yWCY=
Date: Sat, 22 Feb 2025 08:16:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hillf Danton <hdanton@sina.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Matthew Wilcox <willy@infradead.org>,
	Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, conduct@kernel.org
Subject: Re: [RFC PATCH v12 00/26] LUF(Lazy Unmap Flush) reducing tlb numbers
 over 90%
Message-ID: <2025022230-jurist-unfasten-c024@gregkh>
References: <20250220052027.58847-1-byungchul@sk.com>
 <20250220103223.2360-1-hdanton@sina.com>
 <20250220114920.2383-1-hdanton@sina.com>
 <Z7c0BTteQoZKcSmJ@casper.infradead.org>
 <20250220232503.2416-1-hdanton@sina.com>
 <20250221230556.2479-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221230556.2479-1-hdanton@sina.com>

On Sat, Feb 22, 2025 at 07:05:26AM +0800, Hillf Danton wrote:
> On Thu, 20 Feb 2025 18:44:12 -0500 Steven Rostedt <rostedt@goodmis.org>
> > On Fri, 21 Feb 2025 07:25:02 +0800 Hillf Danton <hdanton@sina.com> wrote:
> > > > I'll tell you what would happen in my home town. If someone said
> > > > that to a co-worker, they would likely be terminated.
> > > >   
> > > Interesting, I want to know if the three words, rape, pregnancy and WTK,
> > > could be used before judge in your hometown court by anyone like your lawyer.
> > 
> > This isn't a court. And there's no reason to use the word "rape" in a
> > technical conversation on the Linux kernel mailing list. Perhaps a person
> > reading this was a victim of rape. How do you think that would make them
> > feel? Welcomed to our community? Absolutely not. Which is why it's totally
> > unacceptable.
> > 
> There are NAK victims. Did you nak more than twice a week, Steve?

Hillf,

This is not the way to work with your fellow developers in the community
to express disagreements. I would recommend following up with an
apology.

thanks,

greg k-h (On behalf of the Code of Conduct Committee)

