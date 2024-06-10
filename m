Return-Path: <linux-kernel+bounces-208554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 993979026B9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0101F227B3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8044143C43;
	Mon, 10 Jun 2024 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="X7KHTk1Z"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A6514389E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718036980; cv=none; b=BU3kXXBK52kdVCVPVCv83UaTjv0D47ztiFd3BPJFH3oWYpCLjjwF731gDprN2AVyMvxrs8FnNHFJB3jqX81y5HfdP7++f+jAoW5lIWRryxvKpB7HCgSE39CuSs3Bl7rpGFSnjDamFYO4ZwW0G/sRgsNF9SAdQHa8W1x4LmNvELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718036980; c=relaxed/simple;
	bh=KD17DpYA+Own+2mjA4cap4Dn43A4ySTl2BcRMlYQn6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iq0r7cXQ11igrJ2444uZmqtgZ033HUs8cOJ63POsK6T5GkkzjLMMPfgLAORi9rb8XSGcVQmpR1MQR4dnuwIkCKjLHc6lt3u76WSjCQU6IYvdlDb7TKVUL+J9236XLGtKko1VzH5HfAWoemQYSAnXWIJfIVHdh2ZXfbpLxVtIweU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=X7KHTk1Z; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 33D9140E0081;
	Mon, 10 Jun 2024 16:29:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BF5qESk6-YgZ; Mon, 10 Jun 2024 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718036972; bh=PX4lzbqfUw6c6qfToKtLJI03DW8O5Lp76nqw+hcKEJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X7KHTk1ZOmV6ZnzxCNPgATfL3e6BlNcFu+ZWNUGSvcfOnr2WkMUfSeqiqkL1rF6fN
	 aUobxa6Z01NcKqqgDi9EP4/NZWPrb5pD7stNHJBQBxTVqwrOh401E/eKZB2iF+7pQv
	 BYALAllMfn62rTtuVIS71RBkdFZ83WVBg7DvLftV0uYvowaCivjR/ABDVXwi3uhPHY
	 WVWukEZQrkax+GJHkCO5I/8PlqDp3lRCykFnW6wEWV2S4r9TWmhvLVcG0gEiulYj0y
	 dvNCW7PwpZLW616pf56/qnEiUNFaA0k9+MlgkIb9sV6jST+QLUM5n5daMCWxXa/Ho0
	 W9nNtzwUxRBY1N1mQU5tEPPjaOj9a56F4DUcdPZyrftKBIwQIytYAtl/38SLmLfIur
	 wY4qDxiCggAuIY41Sgn/8zBiF3cj009xw6zXIGIcwxPLHAQS2gaws3GMpCcnFEoejV
	 6SR6hgFMiXXMfBfjh59P8YfIUYXu7augzEsyyAL7k9nYXOJD26xhq8hy90zumQpS6+
	 l7TgARrzQXFKAQnw5P4f9afcFmKHj4ujNqup1XwY5Z9iRJH/6WGTSVHGIAKPJWxrc3
	 qaEgKowcS1BlsboKASJJaezOVyQzLXVEJQfmjCMSmWoWNUuut/hAMumJUIh+o+Wc+Z
	 Zs5HAypeWLH8mE+JWElvgvlg=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D158B40E0027;
	Mon, 10 Jun 2024 16:29:28 +0000 (UTC)
Date: Mon, 10 Jun 2024 18:29:23 +0200
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kees@kernel.org
Subject: Re: [PATCH] x86/boot: Remove unused function __fortify_panic()
Message-ID: <20240610162923.GGZmcp4zRfJcTghSeg@fat_crate.local>
References: <20240610115722.107780-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240610115722.107780-1-nik.borisov@suse.com>

On Mon, Jun 10, 2024 at 02:57:22PM +0300, Nikolay Borisov wrote:
> That functino is only used when the kernel is compiled with
       ^^^^^^^^^

Please introduce a spellchecker into your patch creation workflow.

Like, run the thing through the spellchecker on the system or you can
even use my python script which checks patches and can do that for you:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=vp

> FORTIFY_SOURCE and when the kernel proper string.h header is used. The
> decompressor code doesn't use the kernel proper header but has local
> copy which doesn't contain any fortified implementations of the various
> string functions. As such __fortify_panic can never be called from the
> decompressor so let's remove it.

Yap, might as well whack it.

We can always resurrect it if it is really needed as it is trivial.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

