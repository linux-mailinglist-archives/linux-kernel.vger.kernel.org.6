Return-Path: <linux-kernel+bounces-551732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F735A56FF6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D18B188EC02
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D1023ED6E;
	Fri,  7 Mar 2025 18:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LCrA7F1A"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F60721C180
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370546; cv=none; b=NQxcuV9RILlNVarpQGBPCCnVcL98ceDmGLvQKQfNWPVCnftjQyRgZr/FKYfgH+5Iya9+fNgAyVocuSFEbtkhZPyk44xlZdDs2+Cn4ipMPRFVVZxOf3HBiLrbvB2qlTsAB01z6LawP/EFWIKgeej5U2QqvheNuzqQkwwu6k+xPko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370546; c=relaxed/simple;
	bh=y2toQQYUoaG3Hk/vLxGI7RZEKDnGyzA6U+NxbH1cp7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=od5Mrco18YA4KNe/S3Fa+LUk+FPFkE/PoIAyNvlSvOfNckbrIpsSdO0eeR+/mNH5AfC+h6XjE81o9IC98tnWsHwPyr5EGp7MvvwoRty7Pw2CWS2zVhx8wRNIsCrH99AQiCE+FZMWPxq4Kt2ImLOD4F5Qhg64IDfPek0DujZ+41U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LCrA7F1A; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 7 Mar 2025 13:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741370531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KE6q/rKYH7PUqFF/DQcNeOX4lcfTqpEyOJp+maO+/S0=;
	b=LCrA7F1AUCeHsxUkKCqBA5SalbHCToyUyDL+GjqMDl9IyYhHaA9Qy0REMXNKORjDatw0tI
	hQEF3Df76adnqLFsmm0OJFcXbO+eCyom0/u/89x00iBv7Ddakm9eBuXVoLYYKd3lq8oTa8
	YRDa7NQU0AOmnOv2kmlpMuIQ3rXTHcM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: vulab@iscas.ac.cn, linux-bcachefs@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bcachefs: Add error handling for bch2_folio()
Message-ID: <ubkcjbt76z5jaiw75irjhybullftj5gnbtwn4p5y7xfu6mw254@ky3rsexlfrpg>
References: <20250304040311.2081-1-vulab@iscas.ac.cn>
 <1ed644b8-f3c4-4656-aad0-a3c4f7fb0533@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ed644b8-f3c4-4656-aad0-a3c4f7fb0533@web.de>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 07, 2025 at 07:01:03PM +0100, Markus Elfring wrote:
> > Add error handling for the case where bch2_folio() returns NULL
> > in __bch2_folio_set(). Return immediately to prevent null pointer
> > dereference.
> 
> How do you think about to add any tags (like “Fixes” and “Cc”) accordingly?
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.14-rc5#n145

I'm only doing backports for _really_ critical fixes until the
experimental tag is lifted, so don't worry about it yet

