Return-Path: <linux-kernel+bounces-175237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B5A8C1CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B091C21266
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B716148859;
	Fri, 10 May 2024 03:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="0gC8GNCY"
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB48333CD1
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 03:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310797; cv=none; b=u+ZHDR8N8peUTu3q+3Nf2fK3AlNHMw/j/aYy/AaOx5DVnZzgho5h6zTsPhmW30tF+narbkT0AfxGrPBAD58LVejBzaN3kUpSYpsmA7ICCubRJgaz9Ka4iTyW16+HqvPkayWWD/ax+IsHBY3DAuPaJv6ehPp+P4Yn07a0SImPzxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310797; c=relaxed/simple;
	bh=jHuBYJh1fWMU79daz3sn1J9/58kgK/BwHiHDGGVnTds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojLjD1d1aJ294lvqdrFXpXJan69yPKbs9oGVr2dN3CW8tYDDv+yPx1FyztDVgCqUsuhYefctKD/JIg+ML/5pR0ZxpGn2SJXm38UxJVprxsqpYCTNBsogkyavn8AG9ixPbzaRgzqKjJvMkHB97U3CBjwc4OcHpVNgBOE388Y1c5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=0gC8GNCY; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 3363514C2DB;
	Fri, 10 May 2024 05:13:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1715310787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+QPtvYM7X3Y1l9pvLzIZVB30PRJqZmzc/z7JfxU/viA=;
	b=0gC8GNCYZ1wj2RPqnwoAPoJ6D8SwRKAhpdqLYzrhbuZM/qWOlkJVBClAlbkeixv1ryqgaF
	7VfZ6TLbRJ53YBZ9qi9vhmuFb9ftxoeq6v5icB+GpTPmnr0wG88iz4rqkmXFOXoi+hNMhk
	goZ7pqib5At+Y7LrrJ6J/KQshBWDHTa2YWw/tDRB6h0odQiw2dOM1J9p+Vrj6fOYhxiLHH
	A7OwOUONGAqLCmAsT8eQkHv6SL6b9Khz+IPIk85JDJCP1LslAbrhKiL8Am80Z8nC3sKPVz
	AyWzmFnR7lPT98Vr7v8ajBvDulHO3ThJhtjNp1olvdPeqIt9/wKGpeqEbebqZA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id a006931a;
	Fri, 10 May 2024 03:13:01 +0000 (UTC)
Date: Fri, 10 May 2024 12:12:46 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2022-48655: firmware: arm_scmi: Harden accesses to the reset
 domains
Message-ID: <Zj2Qrt6_kJzqA0-S@codewreck.org>
References: <2024042859-CVE-2022-48655-5feb@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024042859-CVE-2022-48655-5feb@gregkh>

meta-question: I've had a look at Documentation/process/cve.rst and
while it describes how to report newly fixed issues, it doesn't describe
how to add informations to already submitted CVEs.

For some reason one of our customers saw this CVE through some news
outlet and asked us if they were vulnerable (NVD flags this as
high[1]...); so I had a quick look at the minimum version that could be
updated for everyone.
[1] https://nvd.nist.gov/vuln/detail/CVE-2022-48655

I can submit an edit as a patch to vulns.git json, but this doesn't seem
overly important so for now a mail will probably do.

Greg Kroah-Hartman wrote on Sun, Apr 28, 2024 at 03:05:16PM +0200:
> Affected and fixed versions
> ===========================
> 
> 	Fixed in 5.15.71 with commit 1f08a1b26cfc
> 	Fixed in 5.19.12 with commit 8e65edf0d376
> 	Fixed in 6.0 with commit e9076ffbcaed

These commits lacked a Fixes tag, so this CVE does not have a minimum
version.

From a quick look it would seem it fixes arm_scmi from the addition of
scmi_domain_reset() in 95a15d80aa0d ("firmware: arm_scmi: Add RESET
protocol in SCMI v2.0"), which first appeared in v5.4-rc1, and does not
appear to have been backported to older kernels, so v5.4+ can be added
as a requirement.

This means the current 5.4/5.10 trees are affected; the commit doesn't
backport cleanly because of a trivial context conflict so if that helps
I can send a couple of stable patch if that helps even if our systems
are not using arm_scmi (CVEs also don't have any way of expressing
whether the affected driver is used (or even built) at all, so I guess
people with affected versions will have to check that themselves...)

Thanks,
-- 
Dominique Martinet | Asmadeus

