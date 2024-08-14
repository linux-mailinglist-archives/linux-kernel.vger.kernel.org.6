Return-Path: <linux-kernel+bounces-286415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D0C951AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04988280FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0034F1B0102;
	Wed, 14 Aug 2024 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a5Vsb4nK"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140171B0104
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637804; cv=none; b=pYjgRAwHC6j8fTTzjxdpZLzbGTQePGJFr+QnTdWS7Jq9odE+Rrf3PgDsvaW0tix01O7ByhOv/WezAySJwWOOhEkujTI9VzHUQcTqmGOxMSnUbx8fyAp4tOpGIJtISW0VLrE0XgeBUDD8hsYrbIKSYeTsrfKTzsn7H/UCVzJ5jT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637804; c=relaxed/simple;
	bh=fwrrqi59D8+gyaVDxw+e4glai5gQB/boHoF93Oean/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqZ/+VnT3nBCDr/oaViqOXmJ08pjoC9eFyi2LH+2euizs4d0egFNiWzKc+q1gxYUk8GPnorWirvW600GdpZPCJw5KDmDFDMg9a0TzZv5LsHIBU8wdSx33RdyEv61GvYTWnae4inDxyd/iyQMZFEKgPPvm5iRJRRdOpAV1+JpeI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a5Vsb4nK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fwrrqi59D8+gyaVDxw+e4glai5gQB/boHoF93Oean/s=; b=a5Vsb4nKZCkCLSWJc4DKosJAcD
	fq1STNAyLp/GsplezQyiXkheoWHZivKw1ZWUbfKoDNk/SGDUV2pexYYBTKc815KiNmXFhs5k1Neno
	KD0DTgCfTUi4zh3dxcubMsfycGqVSv/gWbQBerZ8NcuEWQ1Xiz0Oxfd2kDBdiAv18auP0ml5v41PL
	2dYAUcMfMTOigg5gPpPLfNDHk7Curhj/6YOxgESiLX3teiad4nALIpskfeFIau8j4SYhcW3WiNjSK
	UIY1HtnpVMvxzn6tW3YI1nmVlix4IgmHcVnQJ6JRK1SKIHVNks2DE6LszjcFzGGGm0MiUoyI0EIol
	W6HLIPLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seCve-00000006tkh-0ev7;
	Wed, 14 Aug 2024 12:16:38 +0000
Date: Wed, 14 Aug 2024 05:16:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@infradead.org>,
	Max Ramanouski <max8rr8@gmail.com>, x86@kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	linux-kernel@vger.kernel.org, jniethe@nvidia.com,
	jhubbard@nvidia.com, linux-mm@kvack.org
Subject: Re: [PATCH v2] x86/ioremap: Use is_ioremap_addr() in iounmap()
Message-ID: <ZrygJqIAz_AqqjcT@infradead.org>
References: <20240812203538.82548-1-max8rr8@gmail.com>
 <Zrwyh9bKGVzkLzeA@infradead.org>
 <878qwzpfbi.ffs@tglx>
 <87le0zmhdp.fsf@nvdebian.thelocal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le0zmhdp.fsf@nvdebian.thelocal>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Aug 14, 2024 at 10:08:23PM +1000, Alistair Popple wrote:
> I would tend to agree and had the same thought when we found this. At
> least some kind of message (WARN_ON, WARN_ON_ONCE, printk, etc) would
> have made the issue we were debugging much more obvious. FWIW I have
> tested running with a WARN_ON() there and it never fired except in the
> bug scenario.

Various architectures had either an early ioremap variant that got
silently ignored here, or magic carveout that don't get remapped at all.
None of this should currently apply to x86, though.


