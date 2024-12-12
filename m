Return-Path: <linux-kernel+bounces-442586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1749EDEAD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 06:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45A3167205
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 05:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B4615C14F;
	Thu, 12 Dec 2024 05:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LENiNzcK"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF561DA4E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 05:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733979859; cv=none; b=ch6t8bBl+fNK4NpkfJ4MrIsuX061QBKOjanAY0uWFsrvapCYFW3ZMWG0scoZ5pu66/h0xcagy1kFKDS2RCgsY4MJU+aM5CdK4sRRXN61Nqsx/3Yoo1OV1IYz2dKB2eZeLIkegOqNYU6U30QBMJ3Bxzs3CYfmTSpa4d3rnUvziao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733979859; c=relaxed/simple;
	bh=qKJ3GjKoUK/asmXVKRKYo89Rmww33iIzwkSJvTJ79qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOLOZrZhyRx6g90z6pvUHLNaR0I7YN/wuzaUhYmmdGoEOirp82sLq/fzcOmKHsAco2/NZMounLsaRixq1AxWQ6qhKcROwgV3b+fwkH3OZvuJZjxWpp+6XSyrVG7AZsune7iG80S4Y5DQpNgnc2IeMII3NyNy79zT9qNlFLFQNvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LENiNzcK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SgcPDGPuW4iluvrRpiyJGhFNveNEeMyNKqGJc0iYnRg=; b=LENiNzcKOHOsEvqj0M1jCdxF4d
	zfk9YjDVIHVuuTOlkQsLMTEmoz3EUurG3ki2h3/Pqi79PnIQUH+bkzK8AkWnCMvu4ltCfVrzKgh01
	y7HggK1EGR1bjc0xrDnzOTUmlSaCbPH5hO5gyX+LIil89qGjc+kuiuuN29PNzZvlyczUYiekdPX82
	F5MOo91gZUw2LOlOjWUiv6AxGp3tn3SwQgopn7Q6LoyooUmoPTSeWPgalDGEFpRfobR3O3QGee98M
	6eeEiuCDktKvjdKzfjf3s4uBdkO12YP5jVBiVNDUGcPVnrfHqOmaBubvGCuPCaTsyJQKAzdAIzzYm
	psSjS42g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLbMx-00000003Nbk-3SlW;
	Thu, 12 Dec 2024 05:04:11 +0000
Date: Thu, 12 Dec 2024 05:04:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	syzkaller-bugs@googlegroups.com, yi1.lai@intel.com
Subject: Re: There is WARNING in __alloc_frozen_pages_noprof in v6.13-rc2
Message-ID: <Z1puy5Mh5O6g6piO@casper.infradead.org>
References: <Z1ps6e3/2vT7QrYo@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1ps6e3/2vT7QrYo@ly-workstation>

On Thu, Dec 12, 2024 at 12:56:09PM +0800, Lai, Yi wrote:
> Hi Matthew Wilcox,
> 
> Greetings!
> 
> I used Syzkaller and found that there is WARNING in __alloc_frozen_pages_noprof in linux v6.13-rc2.

The bug is in the caller.  You should do some initial investigation of
the report, not just fire off an email.

