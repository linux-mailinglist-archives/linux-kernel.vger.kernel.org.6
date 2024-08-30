Return-Path: <linux-kernel+bounces-308203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5446196589B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871381C23808
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D400C15CD7D;
	Fri, 30 Aug 2024 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="YWd8JOrG"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA4D13632B;
	Fri, 30 Aug 2024 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003110; cv=none; b=loni7ZSKj1HkyrFrjYgC4DDLRZ4lXNAYaz5qToHmQd2Pqo35alhr3P5fl3g3ft/yn3QR5Fwyw7sv6ZUDkZRtA3fkmrLVxHCjZpu/64lsTWCKFSpQSJYRixVNveSaf4wHhjZ1sYEgY01sEIhodWhLrmXdUNxvxSfS+vfzw1/qdnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003110; c=relaxed/simple;
	bh=oOd49rtLNM5AruBe4nACPT3mjZDW3LzLS9dHxt6Ku78=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tM95B45ZgkBf+yDjyP9aIHodG3ovgUVtSMsTeJITYOdOk5D7pojFKq8DrBGQ5vUp787KcbI5Ki/4siFQZz3lXY04c8jLCJ5B7klfsV2YyFAaHUz95KHbLXp+18R9O5Tq3TNOaCIVzHfGywkoHsmNmswEf/IWHpxgEFsy3K1o1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=YWd8JOrG; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1725003106; x=1725262306;
	bh=6kiAh4bj1vs16SDTRN/mniIbskGshVQ5j+jHnyQ258s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YWd8JOrGT43CBpBDVGf0Fr486nZesQcxj6LDNh+Wo/Nt3lPts5WwvFRWO2jUReyzT
	 WCXMt4Z8Lx06BtPEkCgBp9jK0D2DjBinC7UsT/sVxbrxJqucxloRNPrHo+dQpo0Klq
	 9FA9nJ63ECM9Bi1c8JQdm374rUicMW/I6Ra4cV+z3vApNO5r6t1n+NGZJYReDbLn7v
	 /OM8HDL3baQ7rgvQEYcnOPYaos8biYH9S8dPICeTd1k1dDWq5VK/yp921pErVgOyjp
	 +ixhqCwxK5YAPsRgNt34ISIL6mbVpxd3iw4IoHBoSJ6Ejx7cYgQOfXYOqxGa7SP626
	 piMPIWanXS+8Q==
Date: Fri, 30 Aug 2024 07:31:42 +0000
To: Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Harry Austen <hpausten@protonmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 7/9] uio: add Xilinx user clock monitor support
Message-ID: <D3T2KBEU0DMW.QA7Y6MLTQ3Y3@protonmail.com>
In-Reply-To: <1bd17a02bab46391872e4934895b83e8.sboyd@kernel.org>
References: <20240826123602.1872-1-hpausten@protonmail.com> <20240826123602.1872-8-hpausten@protonmail.com> <2024082655-cubicle-flashily-6ab3@gregkh> <D3QXIGN92QZ7.S2LY531JZ1L9@protonmail.com> <ced9ed863c4b648a65c80447a8482cb2.sboyd@kernel.org> <2024082824-emphasis-thwarting-4ef4@gregkh> <1bd17a02bab46391872e4934895b83e8.sboyd@kernel.org>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 58d99f953b29a2aa5d149b4943e6a5e13f41cd38
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Aug 29, 2024 at 7:17 PM BST, Stephen Boyd wrote:
> Quoting Greg Kroah-Hartman (2024-08-28 00:10:46)
> > On Tue, Aug 27, 2024 at 04:40:52PM -0700, Stephen Boyd wrote:
> > > Quoting Harry Austen (2024-08-27 12:08:52)
> > > > On Mon Aug 26, 2024 at 2:11 PM BST, Greg Kroah-Hartman wrote:
> > > > > Why do you want a UIO api for a clock device?  What userspace cod=
e is
> > > > > going to access the hardware this way?  Why not use the normal
> > > > > kernel/user apis instead?
> > > >
> > > > I was just trying to provide userspace access to these _unexpected_=
 clock
> > > > status event indications (clock stopped, underrun, overrun or glitc=
hed) and UIO
> >
> > That is going to be a brand-new user/kernel api that isn't documented
> > anywhere and will be unique to this one device.  Please don't do that.
> >
> > > Maybe unexpected events can be indicated through the EDAC subsystem,
> > > except that is usually about memory or cache errors, not device drive=
r
> > > issues.
> >
> > If you all need a new way to report issues like this to userspace, then
> > let's create the correct api for it, don't require userspace to mmap a
> > random device and expect to poke around in it safely to get the
> > information.
> >
> > Odds are that mmap will change with the next version of this device,
> > right?
>
> Agreed. I'm wondering if we don't even need to invent anything new
> though and can simply use devcoredump. Harry?

I am not familiar with devcoredump, so will experiment with it for the user
clock monitor support. Thanks for the suggestion! In the mean time, I think=
 it
might make more sense to split out the other _tidyup_ patches into a separa=
te
patchset, so that can be merged separately first. Will do that next.

Thanks for the review!
Harry


