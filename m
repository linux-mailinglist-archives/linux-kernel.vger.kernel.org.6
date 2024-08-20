Return-Path: <linux-kernel+bounces-293193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A37E957BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034D01C23B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE94482FF;
	Tue, 20 Aug 2024 03:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p/pkFhuX"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1041F3A1BA
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724124301; cv=none; b=gZtCJ6+8a/oE088RlRml3CKokb+jZZGLF5kL7jUo/SAJaBytZOBhZR30xB7x+2/83CIOzOxjcGZNWDoruuMnZl3KPIgh+SK5r4HQEhUX3z+i2VEqKKUSZbV+T44ViLNvC4ZnS671irSYXJBV8b7I3/carj6wqUCvUW4sHN2u6V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724124301; c=relaxed/simple;
	bh=Lix6rgWyLa+b/58zM+qNIJmSO5RW2gtI3m7VGIt9UlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlEmzp9dEkXmpcLFXTHH1nq+hfa2Eu1PMgbLTp81fgBbtvjx5VeBJtJov3hVrzU3nM08pXqZJ/e50OUtU+zHeil9sIBipWld+qQUEjA+TDtey3DC0rqf6+Zx2X+6hlWPuHihfDTYhG/UDPsAwoYuEWgj2evS0Rof9Fc1Pgv+Pjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p/pkFhuX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Nvbw6T3DHbjL6k7DOKePSmd0g8wcKwt1FQH0RB9ZfvY=; b=p/pkFhuXddW6T5hNsXhXpuibLT
	wpdM9/dtWA0by58UJBoAxxlHGDmwUtvA7SPFOVN7Rfp4qzSQJN9p2xTxxWTzuo+5MXj7qGyRmzbUW
	sVhj7IL+F8Kp2aVlYmQzM3RA0j3muuF1U2KUecH/R2127fD40FeHpoyImL+pbNihoWoiAlXDpk488
	Lqy7efenSaS0QgCynOAVPSwqr/9KmyxmamZf9EVCQ7pV05bFL50K/kXb3mY464G87c8BdDUgxA7Y5
	E+0tuyulqyInQvYwG4rq/9U0X6I14DV7gzwyLXtT7P/XK68OAwzhUdwDgOzECFdCmZXI5+GIQ/20N
	oq/W+LJw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgFUI-00000007TaO-2fUY;
	Tue, 20 Aug 2024 03:24:50 +0000
Date: Tue, 20 Aug 2024 04:24:50 +0100
From: Matthew Wilcox <willy@infradead.org>
To: zhangchun <zhang.chuna@h3c.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, jiaoxupo@h3c.com, shaohaojize@126.com
Subject: Re: [PATCH] use might_sleep check if kmap_high is called from atomic
 context
Message-ID: <ZsQMgpZpx4oo_a9b@casper.infradead.org>
References: <1724118791-51554-1-git-send-email-zhang.chuna@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1724118791-51554-1-git-send-email-zhang.chuna@h3c.com>

On Tue, Aug 20, 2024 at 09:53:11AM +0800, zhangchun wrote:
> kmap_high is defined as EXPORT_SYMBOL, and cannot be called from atomic
> context. Add might_sleep check is necessary.

No.  Nobody should be calling kmap_high() directly.  There's already a
might_sleep() in kmap().  No need to add one in kmap_high().

