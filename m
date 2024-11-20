Return-Path: <linux-kernel+bounces-415913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 598939D3E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D429B2D5D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC1D1EB3D;
	Wed, 20 Nov 2024 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oOTHZFzO"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF181BBBD8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114038; cv=none; b=bGK0UweTf0+SuCdtyb8ZzFCOD131SMY2Fwd/2+nrjafuG9eUxknHx4UeWso9PHVnpeOurtRtPvU2oGBRFrHmhxdyJ12aBux5hrxOkboZl0o1ZCss2IvMMD6x3BD81VCvKNe6AUEDWh1fujpbcPhk1Qqu3d1i4bG/2J5ygmG7lkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114038; c=relaxed/simple;
	bh=/1qWPGxG78UXzcj1yQsfCQE5p5gEEpS2sHZhHof7aIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5QaCOEtBw5cObAzI0X/R0q8Ijwm7Fa4sorMPvgBjnDSOQ9B2lNpA7yJjI0AR2CQlS9vrWzwjaKtjAT4EdfjUzE4OuhuGv6kAnjHC6s5NgdyOVmkiV9ggqDz1nuKr5JTsmYAoTkyB7u6uzh+2OD95ctQUEOV7wX2uJeP0ozfHR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oOTHZFzO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DjGePskTCzMNUVdNkK/duyIEJatqxwhDrMa0dTspZv0=; b=oOTHZFzO+Qox9rLoqTshPWWvRZ
	WJ95bKQLQo37aFNu0tERthJP/+piNBRk8+pyC8vX1CkXei/5CApwihDd3zgNGnuAIJzIWqM49rB2X
	APXHYMTs+/X+mb8sELMW/89Z/EnRqtpE2Jrq9bNoDE8isJ9zKUAZ7nDGPg6c9v0RswKv4YkqavfNn
	4PGCIfpBfoGC9AcuNe0APmxvYA/S7dl8P0xXkQ/m9BDcSH7RkQwdzOnGmynpevbKQ9TST9bdUlk7h
	EtATnzsg5478YRdtyVwLgvQEscD3NUIxGpMobZSY9jzCg62gsjb+LX1qX0lgXm1etNEvMWpWagWpZ
	/6nitO0A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDlz4-00000005MMa-3bRw;
	Wed, 20 Nov 2024 14:47:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3522D3006AB; Wed, 20 Nov 2024 15:47:11 +0100 (CET)
Date: Wed, 20 Nov 2024 15:47:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seqlock: annotate spinning as unlikely() in
 __read_seqcount_begin
Message-ID: <20241120144711.GH19989@noisy.programming.kicks-ass.net>
References: <20230727180355.813995-1-mjguzik@gmail.com>
 <20241120-gastgewerbe-oblag-e8e208731117@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120-gastgewerbe-oblag-e8e208731117@brauner>

On Wed, Nov 20, 2024 at 12:11:45PM +0100, Christian Brauner wrote:
> On Thu, 27 Jul 2023 20:03:55 +0200, Mateusz Guzik wrote:
> > Annotation already used to be there, but got lost in 52ac39e5db5148f7
> > ("seqlock: seqcount_t: Implement all read APIs as statement expressions").
> > Does not look like it was intentional.
> > 
> > Without it gcc 12 decides to compile the following in path_init:
> >         nd->m_seq = __read_seqcount_begin(&mount_lock.seqcount);
> >         nd->r_seq = __read_seqcount_begin(&rename_lock.seqcount);
> > 
> > [...]
> 
> Applied to the vfs-6.14.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-6.14.misc branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

