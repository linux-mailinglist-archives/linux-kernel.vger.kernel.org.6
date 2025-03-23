Return-Path: <linux-kernel+bounces-572955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0585A6D0BE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 20:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6533B2468
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 19:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA62419E965;
	Sun, 23 Mar 2025 19:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VInR10bh"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F90D17E8E2
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742757732; cv=none; b=gRGeMXQzxsJP5EBaBdlCsOYn9Htdg6R7hwsZNcDiuzx5FwM1INIBvTE1p90SSpcDuDKwb2FtQvf2xD9bQJUJr9eawsqU9X/XzdmE0PODFhHSm20NmiUOmUHhut0QfFznagwkNT42DXSR7vJDYUFNt4z2ps18b4+r+I6pQoX2tis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742757732; c=relaxed/simple;
	bh=yCW1WSqIBkpN1Kdf0z0NgS81xun6ufeqlQ4XJkRV73s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azFdhQULT+ShkDyD8yLNy9/SblyOtGR3KAwwVJsUAnSVayMm2s9okDAXfs2cJ/jJ3ra9i/LkwP8D1QiVT3PgcPdZTgtnmzvS+DjYzHntn+GmSVKJ++OVl82p77Ov+vZkOFrSUkvCJgowJMr2VhTY3z8Bp+ev2//WZkOWHDRVDC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VInR10bh; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FKK/Gk26NEn/H9dR8QxHNJQIbP5HsuYy1Suou0C5P9w=; b=VInR10bhD6WDtWDN7bG1+GRcsy
	+ZRRIs9LPrDjXPDEJuJpsVxGzwB+gLJPXvjXC7CdF4/Dc0SXFhB+CgJVO8l9i+m0cq839mrxR/90D
	NfACE2Amo/lQuL8UJrlM+m5Ho1rAgo51E919IjYySWPkddFmwBDkQFuGU7MuQ4PZ+B+1neU4aCEw7
	xSn5mUpYnbhqQsj42jy1o2bMsID54rdCTju2nDPVsejZEgXl2xMTO2pfekZKflvc5siSNRJ3itQM8
	8iVWfaJ46pYs1602+XUO/fX081CtjkQN1Ti5v2KmhzM028XPBAV23y2xjyEN/0uwZaGRZuH+S2S54
	UP93/MCg==;
Received: from [187.90.172.172] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1twQtK-005NjV-9q; Sun, 23 Mar 2025 20:21:50 +0100
Message-ID: <8247f64e-316d-0eca-9e5d-0c63c7dfc862@igalia.com>
Date: Sun, 23 Mar 2025 16:21:44 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/tsc: Add debugfs entry to mark TSC as unstable after
 boot
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 dave.hansen@linux.intel.com, kernel@gpiccoli.net, kernel-dev@igalia.com
References: <20250226132733.58327-1-gpiccoli@igalia.com>
 <1238b1d0-275c-9117-a2e3-5e7684404980@igalia.com>
 <EA2BAF2F-3F8E-4F81-B71C-7B97677216C9@zytor.com>
 <b43e2353-41ff-f2de-881c-c9a3348552b7@igalia.com> <87iko213qo.ffs@tglx>
 <c9ce2eb1-bf90-3ce4-0adf-3f4e43f4a5bd@igalia.com>
 <20250323181444.GCZ-BPlCAhtO7AIsS7@fat_crate.local>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20250323181444.GCZ-BPlCAhtO7AIsS7@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/03/2025 15:14, Borislav Petkov wrote:
> On Sun, Mar 23, 2025 at 02:53:05PM -0300, Guilherme G. Piccoli wrote:
>> But what about AMD systems? Even the modern ones apparently lack
>> TSC_ADJUST - or is it changing recently?
> 
> Yes, it is.

This is great to hear - is there any starting point model that you know
AMD introduced/is introducing TSC_ADJUST?


> 
> The only one I know of is a Zen2 laptop where BIOS botches a perfectly fine
> TSC because those BIOS programmers are soo smart.
> 
> If you know of other cases, where are those bug reports?
>

We don't know yet what's going on, some TSC skews reported eventually in
some machines, in a fleet - but "old" processors, Zen 1st gen.
Once things are more clear, definitely could provide a more mature
report of the issue.

Cheers,


Guilherme

