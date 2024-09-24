Return-Path: <linux-kernel+bounces-336632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E1A983D40
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D15528335F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19C13B1A4;
	Tue, 24 Sep 2024 06:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ka0uon2z"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4824717993
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727160199; cv=none; b=s4aYGK8dfUZu1FEHhdjNrKtdKe8jV3XeJbsz7IA/Li7SKNeqqFj2WZ7Du/8VxdpwAKzVk69N8+UObGB0gDXrF0yjhSv7o4cX/DCjAh5yoJPK7Y9OQyLRcsZjga8U8lXiRT0HYVaocwQO9OzWNGapHhR6KrFfBWGEbhNaGDqEWJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727160199; c=relaxed/simple;
	bh=GXR9er8nmP3Zb+bUoPtpmUnvLEXCY9mlWbpx1uuK9+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExR2nnYVpN+MITO+34t+pux8egmeK5arQy7L3wLpaL0pXP6WCu/CNSySZqYy3Gp3cqir/TQ6YelhJHRQhSBQ41DlCoMnw9/kD53s6+Zcko/JdXCqVtXOK3fVlBrQ1kEuNXiNy1zrun4jMZ/FeysGW/Hl1Uw1Io73I8iarnMFqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ka0uon2z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3PbJzwROUpOmaLdozFnNNaDRLerBVFk8Lgsc+PwcLyc=; b=Ka0uon2zqIMJo0sNG4nL3Ikk2H
	3aBSSz0O7w87unRL6Fy+MN7IAJTz1kLBOjbkckXSIWB9dXvDnHq2GmL0pAljx7ntG5TBydG2DJzea
	Ppo2h/8WQmJEb/Bcum8x+2bH3tTV6pEUPmZDJpzXTC9v7HhA3SecoovwLMDwIIULdMGlI+qR1NASd
	/oLBeDvkW8b/mxymEjgfcEI4g0v92/i/Wshpr5x4L+C4njE9nZqsGw+3tjXy1t9+OdsC4e+bIpI/P
	K5DVUpFfkMPeUVJ8Uc5NuR4x3V9zTQXYAZ+fxXR9BVJBoAUHE5TgLpY3sqXySg1FtDpOGcN+v6yHf
	OTu9nXpQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sszGW-00000001IVs-3QAI;
	Tue, 24 Sep 2024 06:43:16 +0000
Date: Mon, 23 Sep 2024 23:43:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] mm: do not export const kfree and kstrdup variants
Message-ID: <ZvJfhDrv-eArtU8Y@infradead.org>
References: <20240924050937.697118-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924050937.697118-1-senozhatsky@chromium.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Sep 24, 2024 at 02:08:37PM +0900, Sergey Senozhatsky wrote:
> Both kfree_const() and kstrdup_const() use __start_rodata
> and __end_rodata, which do not work for modules.  This is
> especially important for kfree_const().  Stop exporting
> these functions, as they cannot be used in the modules.

Well, they do work when called from modules, they just don't work
on constant data that is in modules.   There's also plenty of
existing callers in modules.

So just unexporting them is going to break.   The API is kinda
horrible, but an implementation to check for constants in modules
would also be quite horrible.  So I don't have a good answer here,
but simply unexporting them is not going to cut it.

