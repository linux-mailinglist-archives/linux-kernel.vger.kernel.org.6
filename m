Return-Path: <linux-kernel+bounces-563147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DBDA63788
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 22:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0D53A9175
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 21:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782661A76D4;
	Sun, 16 Mar 2025 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="xvj99/SC"
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A73019AD48
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742161055; cv=none; b=Pu/GR2Bt30MiflBQCQgCbgMM4XmD9zgGKTPl+InMw0MgXjnhGxBHgin7GlvOR+vRK1mG6NbeJ3jPX8cR2b8RX5OkMwg2biwpEoY2yueUN3WVe0+8zUC8veFwMuof8NrMBDNbHgdXA3LhyW532A2XjoGamwNWbZmijLaN6pShIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742161055; c=relaxed/simple;
	bh=eQEYD964ZwZcou93JAtqTPtrFjHw2YRPV5Qu0lMgdeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugkv1SfprfivmLJqENJFGoCImcyROJmIo2hxOEt5DGtQrXi/z0Cp8V+o7hnUUKG6hm8YtPodB2hYRvKLQiYPKyoku4tw6PuVVtHS0c0feKPUD02yEB9PA30Jt+Xj9bvEiZvNce6hbnaoxSebdIlwovKZbEzMEfVTCV28HJJ2HWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=xvj99/SC; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 8CC0714C2D3;
	Sun, 16 Mar 2025 22:37:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1742161052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y+gAHhx1QBvSIWSCEwaH/juWgm8kz5kUJuLCBoRiSLI=;
	b=xvj99/SCDZkJJq8mNVU94ixlk9YhS9xAkTBq0g73yDqM1g5rkbjMmaHm1grO/1J3iWL6y3
	gMKt+SJOzSHrnvBPwzpPVvDzy15me08fTJ5y8uWK1eJuGB0pnVC0nPa7CGyYRq6PJuRU/N
	OFhh5nIYxtyd6wKXqmoXsW/BcMNRL8tAzVosQXXjUFfUdJlKyg3eNfvLGBCSGW7xH0I+/T
	zWqtIRNtZPmvvgiPCpQYlJmUoDk3qrSML3wGsGOfDLZzdw0w7HxpKjA8aFGHLsle/wKEPK
	pcEZpO0by/J74XGFtV0XRFLpltquE9r7QHWZO6jTDRGPAf2EgyUtBaPKZd/viw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 8d8a7bee;
	Sun, 16 Mar 2025 21:37:28 +0000 (UTC)
Date: Mon, 17 Mar 2025 06:37:13 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org, Robert Morris <rtm@mit.edu>
Subject: Re: [PATCH] 9p/net: fix improper handling of bogus negative
 read/write replies
Message-ID: <Z9dEiQUyDtf7nx0e@codewreck.org>
References: <20241222-9p_unsigned_rw-v1-1-3ea971d200cb@codewreck.org>
 <4171850.H1WhmIdAfj@silver>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4171850.H1WhmIdAfj@silver>

Christian Schoenebeck wrote on Sun, Dec 22, 2024 at 04:29:58PM +0100:
> > @@ -1592,11 +1593,11 @@ p9_client_read_once(struct p9_fid *fid, u64 offset, struct iov_iter *to,
> >  		return 0;
> >  	}
> >  	if (rsize < received) {
> > -		pr_err("bogus RREAD count (%d > %d)\n", received, rsize);
> > +		pr_err("bogus RREAD count (%u > %u)\n", received, rsize);
> >  		received = rsize;
> 
> Does `received = rsize` make sense here? I would rather do `received = 0` to
> prevent copying garbage below, that would be ignored by caller on error case
> anyway.

Good point.. We're not setting *err here so this isn't an error (and
thus not ignored), so I guess it sort of makes sense if you look at it
from a "best effort" point of view, but I agree a bogus reply probably
better return an error.

OTOH it's a change of behaviour so I'd rather have it in another patch,
will send separately.

> > @@ -1623,9 +1624,9 @@ p9_client_write(struct p9_fid *fid, u64 offset, struct iov_iter *from, int *err)
> >  	*err = 0;
> >  
> >  	while (iov_iter_count(from)) {
> > -		int count = iov_iter_count(from);
> > -		int rsize = fid->iounit;
> > -		int written;
> > +		size_t count = iov_iter_count(from);
> > +		size_t rsize = fid->iounit;
> 
> I think that would break 64-bit big-endian systems, as `rsize` is passed via
> format below as "d" (32-bit) type.

Good catch, thanks!
-- 
Dominique Martinet | Asmadeus

