Return-Path: <linux-kernel+bounces-360691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C566A999E18
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DFB28A5CD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0703820A5D9;
	Fri, 11 Oct 2024 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="o05ze88m"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2102207217
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632326; cv=none; b=HiBuazRu/1OQnXtae59Mt8JJmcelr3FIiLd6ht+ExCNTGlJBrL+qNmSNuQFvtz2NRKoh78sK1I5unffa8mxMePEBJeihED+OALIfQPDlEnxADuXFLUrJMWzZ8+oXTv+9B5u8fPb6PztFH/oYV0VsrO7kdp9sD3B2i7zV0VjTgfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632326; c=relaxed/simple;
	bh=fLH30U3Fh/JQ4tUWoB/9cQN9oTgm8M8m7/S8D7/Gu9o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JCxjFFL1KnfnwUVDuGFnb9HyTwvIq0y46XC0uoSh3aPwtPYsynl8GWGvgQ8nsLMUoSK3Vu8cxMbgQOtJYOjpd7UYLb78Akd7s2atV7ox9yWJYxgV/Bi879vWuOxufdpuwqG6rXW34e6L/QWkEMBttw/wG2u4H8EQpGYahTtT9KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=o05ze88m; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HCw/3no5oYj2UHi2qRYtGo97uJOdKggjS5l76VTP6Oc=;
	t=1728632324; x=1729841924; b=o05ze88mCQy08EJgOOlVjplZSxJDQvYQ6D4LsZw9LIMdl0z
	RP3UusxinhH3/8VC8pxiM2nkbhfzSB/gEmGGCc646E0rMNCtcGpg80KGHshvHWgNLLUkZGHC1hTLi
	vdQCrOxbSJi8o7xV9af/hefoNVvIoSSHzTg1qMPj9NE8Yaw7WopmPujgH54p78EeJl2TaLcejQ5ut
	PUDyTUnoTo2nV1JBZ14VteZwtZYAtNXuI5G32z2cjYwtHbS5Y5sNWa84HBe1RmLjhbuxJsJ7lF8Ti
	n+kHVzYjF4xn5XcAf6pRwkkXUmnPK7XJluNhNOYytXHLZBh934TInxDph19MUUbA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1szAEI-00000006zgG-3Yaf;
	Fri, 11 Oct 2024 09:38:31 +0200
Message-ID: <99d9e95fcb27160da5ff931fcfe16a07b3256574.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Abandon the _PAGE_NEWPROT bit
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Oct 2024 09:38:29 +0200
In-Reply-To: <20241011053843.1623089-1-tiwei.btw@antgroup.com>
References: <20241011053843.1623089-1-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Tiwei,

So kind of a nit, but if the resulting code looks like this:

> @@ -184,17 +172,14 @@ static inline pte_t pte_wrprotect(pte_t pte)
>  {
>  	if (likely(pte_get_bits(pte, _PAGE_RW)))
>  		pte_clear_bits(pte, _PAGE_RW);
> 	return pte;
>  }

then the if really isn't needed?

Same for all the others, I guess.

johannes

