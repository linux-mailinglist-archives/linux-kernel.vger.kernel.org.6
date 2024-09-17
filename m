Return-Path: <linux-kernel+bounces-331433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE8697ACDE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 464C6B2639A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82271531F9;
	Tue, 17 Sep 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="Q4N/nF7Q"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881ED482E9
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726562005; cv=none; b=bIPH7DMV73VeRwPobfyLjnlJlyTVRVVt/aJ8HBSoSAgZyhUA9/woDhqfhfYfYZuUwvR2+oWDJp2kKNPnei3+1aqTFMUDYsMsKLZeqCK42VlDfqzqb35cZAi/jcOKpDYsdX2xs9lXnkHSgrBaxdCIUkg1e3Yz3qEv3zKYTmagEf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726562005; c=relaxed/simple;
	bh=d733EcIxmZaBjdgAm7Srzkjrb2zAjIoDRUsZMU1zZs8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BprST2xX0pO5chAIkzbPSy/ciPK30y/Q0UMVGdRakkDaaRM+KI8i9dAytjafqR/7yrH7Q9CqhlPMQ8WEiek/x/M2vEVHjrrgee7iJlVXd7wpV43kXX5GebspVAF6US6d/tT8XjkE591ALKe8YIHYC7fyrUAuy0oq/+5YHNNLIqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=Q4N/nF7Q; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1726561473;
	bh=C4wJ7ptJot7KDWTuIlywID28JkwMEQ70zMg/a4akJKA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Q4N/nF7QQPtG+5kaztVw7XrbgLm6QBYGoqEHYFcnttGpeD1+d8+8Qla8lBPlkRlQh
	 /IvRYt9OXtioubBW48pBa3/1tzwEBG1LFYINvdqv4+ikXWb5DaubbP2r+sAFLKep9T
	 QXyVIlFxIYwnnotZrsuWYj97L0cKzlXxl0XMMvP4=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 3B94F669CD;
	Tue, 17 Sep 2024 04:24:31 -0400 (EDT)
Message-ID: <9352e7749783e3b36aaf23f0e29f2385a629d57e.camel@xry111.site>
Subject: Re: [PATCH v10 1/2] x86/mm: Don't disable PCID if "incomplete
 Global INVLPG flushes" is fixed by microcode
From: Xi Ruoyao <xry111@xry111.site>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Dave Hansen
	 <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Michael Kelley
 <mhklinux@outlook.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin"
 <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Sean
 Christopherson <seanjc@google.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>
Date: Tue, 17 Sep 2024 16:24:29 +0800
In-Reply-To: <20240626171541.eeisf66vhuyspv4j@desk>
References: <20240522020625.69418-1-xry111@xry111.site>
	 <b901776293d19271a34bb14f79639c4b574b6174.camel@xry111.site>
	 <e2cb23a6-60d4-49b1-ba48-1ded846e5292@intel.com>
	 <20240626171541.eeisf66vhuyspv4j@desk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-26 at 10:15 -0700, Pawan Gupta wrote:
> On Wed, Jun 26, 2024 at 09:50:39AM -0700, Dave Hansen wrote:
> > On 6/26/24 06:10, Xi Ruoyao wrote:
> > > Ping.
> > >=20
> > > Ok to queue these two into some branch for integration?
> >=20
> > Please don't top post, and please trim your replies.
> >=20
> > The code looks fine, but this has zero acks and I can't find any public
> > documentation of which microcode versions fix the errata.
>=20
> Based on an internal document, I provided the microcode versions used in
> this patch.
>=20
> Acked-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

Still applies and works on Linus' tree.  Ok for 6.12?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

