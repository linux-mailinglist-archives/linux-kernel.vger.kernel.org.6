Return-Path: <linux-kernel+bounces-377470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448529ABF58
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47751F23A88
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B6214AD3D;
	Wed, 23 Oct 2024 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bw69+dJd"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A1C22318
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666398; cv=none; b=NtlypZAbpVZ3WUiq1e+IX+BoIO020jXQSHzkLceRjpMmrKVUqVYUUOwO2uB+uKoUIsjgPm6wJ8YYFdiWS33D0DzhHAIKLoTep/0YyfqulFiVCvuwY5zCsrc5Wl0hk6WE4pHYSqdoZEjzji8CSURBr3pIJAyTO3OzVW+cOVV+7sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666398; c=relaxed/simple;
	bh=6EnwPKFEvDjlm+tRK6cKrMGTQl8/1X60i2/mH1KpLnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiyoUdoajNCL6ja6Ahp9PDNpAvcNRfZB5cuaC4VyanpAWqRyCuK4pi/BadHTT2LgSy0EN9PvAoDK3cg0WhCyJWgewnzOd7sTOT9WK88aqNeRcKYT7woHf0jzRvNbmFSm8LIcDiYmKAFCxhDAqeua4Po43CuohlMIcELS3EZfZQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bw69+dJd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xqRJHM7f9WTZXgVFT09u9pKWtDzDJJb1B7yM9QHPZno=; b=Bw69+dJdAUGquWM5lrr6ThvPD2
	vkDsr3VFx4YDbh9P+rF5yCKglYKc9vUZVBpJsHN2eUmm+5AUXjjA6Ai06vY0JvlOs1nNlxiZ2Ww7L
	MxNqYeqd38jBPfjHQuIj4aWxoYPw6IXNHO/QiJnFwhPyFGEQ2b9eUaf0pCeb+jExW2T6PKrv91x1M
	keFSAqnXI7GJigTcTQfr3G4yp0ZlA9629nM2uNOpoPnMppRgAw2dwIYlKBB2tASC3qlCDbkJHBiEw
	AVo0ErRjg6UxCHFT2qylJRbeo52ybINf4VdGlItuiGwbQD9nk2VOm6WwzhW0jKHmQ6TXze5upnKfv
	OfkzTgcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t3VF5-0000000DHAV-08rl;
	Wed, 23 Oct 2024 06:53:15 +0000
Date: Tue, 22 Oct 2024 23:53:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: export copy_to_kernel_nofault
Message-ID: <ZxidW3lvA5Pqu71m@infradead.org>
References: <20241018151112.3533820-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018151112.3533820-1-arnd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 18, 2024 at 03:11:09PM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This symbol is now used on the kasan test module, so it needs to be
> exported.
> 
> ERROR: modpost: "copy_to_kernel_nofault" [mm/kasan/kasan_test.ko] undefined!

Meh, it would be great not to export internal helpers just because
someone wants to test them.  Please just mark that test built-in only
instead.


