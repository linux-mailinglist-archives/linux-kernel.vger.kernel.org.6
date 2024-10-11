Return-Path: <linux-kernel+bounces-361882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E4099AE69
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429DB1C215E4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786811D14F4;
	Fri, 11 Oct 2024 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="erVI28Oy"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E7D7F9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684087; cv=none; b=ryY/22yXHsKokOCM3n0mBugtxgFOMDQehSd/lOHO6ePxhoQj0dIQcCMnxriDolSI2pKoMXZsYwpDo6YEHmF8mkzI/v9g4v5g0NFHNrHZBd0EuaKCyhpIV35+2MlV6iUb44lTe9lkypEiZMXOQm83yYwU7z3KNxHK87QmQ4ljcp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684087; c=relaxed/simple;
	bh=KLqO+bitO4CIAdDeNYlTQTvy3jmUlBwwxYy099IQBxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nssMHfUsJjjni7+VoVWWiLqJiEIa+U1q9Oic0/synUP8amVb3q+ANeTRWw9CkADZaAKtu4bFRvarwqsUVmmaxwxWAoplG6BziGIOb4cqH3LG5hSLNiAM4BtwRS+4u2FNoNK3Q2yVl/P7EVac7MXQBM/LUCNUGULPw6blTQh6aDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=erVI28Oy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ut6NOFNTb3499u0935DCIAcc8qC/2mahk+mc/rJPgbE=; b=erVI28OyXk045P4+/JM4no/wIi
	xoZcXyLiqqp5cBb3TCa5aOg8N2rXFpAi5FDBsdRtZbKwDx75ZLGy2FD3AoVIgJIooKS/K1lCVxJID
	JzHRTB23JnHgtEi2LKZJtsQnmh6/u8nzFtM1J0rYr9rBNteJRsl32HfFcTTazd0k443J5F5KfDU9x
	Zz39WRwQHOCboMk7f6qCcwniJPtJWWPM4tkXC+ebs6nRRs4MkQgAhWKJbgF/XmaIrYvuJjid0C1yy
	qzQv6sqV93dTGzUbspsb6WJZ3whsYs+QGm4PfSPEmLvuUruXp4JrSELDOtUxEpwOr75ZEN+tSD2I4
	6uREJ0Jw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1szNhB-0000000Bxph-0fBJ;
	Fri, 11 Oct 2024 22:01:13 +0000
Date: Fri, 11 Oct 2024 23:01:12 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zheng Yejian <zhengyejian@huaweicloud.com>
Cc: arnd@arndb.de, kees@kernel.org, mcgrof@kernel.org, masahiroy@kernel.org,
	ndesaulniers@google.com, ardb@kernel.org, jannh@google.com,
	song@kernel.org, boqun.feng@gmail.com, gregkh@linuxfoundation.org,
	gary@garyguo.net, wedsonaf@google.com, linux-kernel@vger.kernel.org,
	yeweihua4@huawei.com
Subject: Re: [PATCH v2] kallsyms: Fix wrong "big" kernel symbol type read
 from procfs
Message-ID: <ZwmgKHxgl2BQuKp6@casper.infradead.org>
References: <20241011143853.3022643-1-zhengyejian@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011143853.3022643-1-zhengyejian@huaweicloud.com>

On Fri, Oct 11, 2024 at 10:38:53PM +0800, Zheng Yejian wrote:
> The root cause is that, after commit 73bbb94466fd ("kallsyms: support
> "big" kernel symbols"), ULEB128 was used to encode symbol name length.
> That is, for "big" kernel symbols of which name length is longer than
> 0x7f characters, the length info is encoded into 2 bytes.

Technically, at least two.  If we ever have a symbol larger than
16kB, we'll use three bytes.

> +++ b/kernel/kallsyms.c
> @@ -103,8 +103,11 @@ static char kallsyms_get_symbol_type(unsigned int off)
>  {
>  	/*
>  	 * Get just the first code, look it up in the token table,
> -	 * and return the first char from this token.
> +	 * and return the first char from this token. If MSB of length
> +	 * is 1, it is a "big" symbol, so needs an additional byte.
>  	 */
> +	if (kallsyms_names[off] & 0x80)
> +		off++;

So this "if" should be a "while" for maximum future proofing against the
day that we have a 16kB function ...


