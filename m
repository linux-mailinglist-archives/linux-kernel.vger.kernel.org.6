Return-Path: <linux-kernel+bounces-194858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51C38D432C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 03:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D881C2273D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 01:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9FF1798F;
	Thu, 30 May 2024 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kTuOxVbY"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25968C13
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717033821; cv=none; b=Ald8LhBJDRZBSQTbLHlelzo/C2ZsPCdAxYD+eAYlR5VwqY1ySj5EM9Iv34BdiVUkpgdt+Rr02WuQgsEQ37z79raOBbPo0joqhpD6TH1DYDFfZceUYljnBsADXbLki0aY2acZdkm/ebw1CdF0fyxeN4IEYi0FJEq3V20Gip0Cz90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717033821; c=relaxed/simple;
	bh=dJzhMKWwI+p3fkyvY8ReszvnKdJxHAls86oOxh6MzBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CitJ7oSuakMiiK+Wc4fBHp4Q4VkWD//H5l+oGuuXoc62f65+FzsKNN+aYDu1FVg4NP+GdDLmTshnxW+Zr2Bur5ADhdWqg+lVQlVgP5eCAJ6ih5Oe+Zq3lMtLu3P1eE+pteP3aQ8rFfxdduiMAySYS19e1s+pOPqLxQsxFMCOPec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kTuOxVbY; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: viro@zeniv.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717033815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CfMw9tHy0aaB3TSiLd6z9f6QlIhExqYTyd8E+3PAqVs=;
	b=kTuOxVbYol232cWSsWqR7clknZ080/pkBgkwBM0aNmpo4MirTY1k+9TzbkG2yq+LG3q0Re
	4EcUyYeIgsbWdTw+fh60oB39sx7eYNDRUV29yxSTFzHc/+AEzoBsBFsr808fb3ctbYV7RK
	3zXhkDgNKqZ9c4pHVGGatnuHOV7dLI0=
X-Envelope-To: brauner@kernel.org
X-Envelope-To: jack@suse.cz
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: yuntao.wang@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yuntao Wang <yuntao.wang@linux.dev>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuntao.wang@linux.dev
Subject: Re: [PATCH] fs/file: fix the check in find_next_fd()
Date: Thu, 30 May 2024 09:50:03 +0800
Message-ID: <20240530015003.237210-1-yuntao.wang@linux.dev>
In-Reply-To: <20240529190328.GP2118490@ZenIV>
References: <20240529190328.GP2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Wed, 29 May 2024 20:03:28 +0100, Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Thu, May 30, 2024 at 12:06:56AM +0800, Yuntao Wang wrote:
> > The maximum possible return value of find_next_zero_bit(fdt->full_fds_bits,
> > maxbit, bitbit) is maxbit. This return value, multiplied by BITS_PER_LONG,
> > gives the value of bitbit, which can never be greater than maxfd, it can
> > only be equal to maxfd at most, so the following check 'if (bitbit > maxfd)'
> > will never be true.
> > 
> > Moreover, when bitbit equals maxfd, it indicates that there are no unused
> > fds, and the function can directly return.
> > 
> > Fix this check.
> 
> Hmm...  The patch is correct, AFAICS.  I _think_ what happened is that
> Linus decided to play it safe around the last word.  In the reality
> ->max_fds is always a multiple of BITS_PER_LONG, so there's no boundary
> effects - a word can not cross the ->max_fds boundary, so "no zero
> bits in full_fds_bits under max_fds/BITS_PER_LONG" does mean there's
> no point checking in range starting at round_down(max_fds, BITS_PER_LONG).

Yes.

> Perhaps a comment along the lines of
> 
>         unsigned int maxfd = fdt->max_fds; // always a multiple of BITS_PER_LONG
> 
> would be useful in there...

Actually, we can simplify this issue. When 'bitbit >= maxfd', it indicates that
there are no unused fds in 'fdt->open_fds', and we can directly return maxfd,
regardless of whether maxfd is a multiple of BITS_PER_LONG or not. Therefore, I
think this comment may not be very necessary.

Of course, I don't oppose adding this comment.

