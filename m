Return-Path: <linux-kernel+bounces-348707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5267D98EAC6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF9A1F21B62
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9C7126C12;
	Thu,  3 Oct 2024 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hUzvLfFN"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF49F81AB6
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941835; cv=none; b=mKGHobxV0ZL9cGtkqTtTuSnIXFUiYBlmwm4aM2SoTizpeOqWhGZWmVm8wjZzrIRHF7hg22QKgD4TfAJ1MdJgzShoniTIizjB3J4lXFOqiN/gvSxLjVWROdpooVzqrIL1FbJx3lnlpm8zkszDOEUe4ep93dqPbmJJRxU+dmXg0FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941835; c=relaxed/simple;
	bh=wLVjs11u2R5+r3r/CoPmno0bEsYMsUdeBM0kDiOj0CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W38ivNL1aQrLzA4pw2GkSXbHp+MAdPDGjYFUAcN9wnNeo+uyVU6xEFZOLcMjW6g6fg/27SGyn/+AEmqEXxhJiIqrf3LjWe6Iwnu32iQJMYmJijkMQGxwi/cICRP2IToIKRTiZfCff4tk4Au1iduQ0UI6mH/XTJhogGyPPiRx4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hUzvLfFN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N/Blbpz2n2+Wu8DWIWjIuS3nrcPB7msCqjY/tuVyrtU=; b=hUzvLfFNX9tc0dJASyajFw5onY
	BxUkPbq4H+mtVzQFccq+pNsHWl+//C7EHcSNQ7fVzupZqyvSRrfKP8JgXNiwQ7oqq63oSOaRaHBIi
	636ymSnmzYKlhmttuvsSfesBjNvsxVN0JdUsWNDWcyP6S/Ye5T/7clAbKQWKas/u9sqr17aXWhu/o
	AZuQ8GsAinn5rOSPmGsWEDpoe+NvUTzjnOfUF1aIHIvt5nIf2zwPRzBNGIuTyKgEcRBlHRb57mt3c
	uHdj9Fm03ZHKq7mfc0KHmoxT5YLQeH9r3Ps0rtge7X/+W4kAn7Pc/O+SgYZPdCFqYgQbH0YK/0QvQ
	5FV6JBgg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swGbZ-00000008Rgg-0QeC;
	Thu, 03 Oct 2024 07:50:33 +0000
Date: Thu, 3 Oct 2024 00:50:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Paul Moore <paul@paul-moore.com>
Subject: Re: [GIT PULL] tomoyo update for v6.12
Message-ID: <Zv5MyX12CyvDnZDJ@infradead.org>
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net>
 <7dce903c-2f76-43b2-bb6f-808cb50d0696@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dce903c-2f76-43b2-bb6f-808cb50d0696@I-love.SAKURA.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, Sep 29, 2024 at 12:32:18AM +0900, Tetsuo Handa wrote:
> Since Paul Moore continues ignoring my concerns, waiting for support of loadable

Paul is not ignoring your concerns.  He is rejecting your argument for
all the right reasons.

> This backdoor symbol-export mechanism is a transitional hack needed for
> demonstrating that loadable LSM can work. This hack will be replaced with
> proper symbol-export via appropriate trees after this merge window closes.

Seriously, this should get you stripped of your maintainership.
Backdoring yourself in over explicitly NAKed aproaches is a no-go,
but unfortunately Linus has become lazy enough to let that slip through
occasionally (e.g. bcachefs changes that we're painfully sorting out
now).


