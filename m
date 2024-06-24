Return-Path: <linux-kernel+bounces-227465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE73915195
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B3A284160
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A77719CCF2;
	Mon, 24 Jun 2024 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2iyrtr6V"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D3A19ADB3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241839; cv=none; b=f59Y547xQWHABU7zgoyLhlMObR+ONc/i8r1DHhPRiPvqg8RAVXU/Zj8i4LVIbMNc4XeQPTp1gvXRf3Cg8CltlJMfnVQb+UvfrdRkJBzd7wErMfHkV2er3OgTTWm4RPlZrGHex1jqNxOj2iU3xhYxJQnYyFSzKG/Wp1YCz/NlHPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241839; c=relaxed/simple;
	bh=jKGyvta2G1uYVIlK5HNoVK9sdIrnIVmJnDbVOWaOOv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQJs+Yj8lkChLz8QCf08xKZwL3DBBFmo69pe8JQXvgYJLDVQLL8gM4eQsHW5JRPE7hsiyJiyJmA2GUgvc2Ul2tGrW9tI4ToPDqZv9WT4VjAbum1ALjbdDP1zY+5rhWp9Ivcj3/2wU4Q3+pHwkY6m7w9Qg1WHhC2T69crIz0DWgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2iyrtr6V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sIjcwJiRP5XNu8VuXIVIMMptG3Wg9vWUyczIJClgvZ8=; b=2iyrtr6VIc4eDAKSzQ55Z4hAiQ
	8Q/VPLOVlk8Qop3b/t71XkHRPHEPJ8kkEf3cMXfupfokml4vPnIhyq4RTtbMmWLHirdRuaH1g6yTe
	vWC9M/cLJy2w7pVAPxGWXjmt8wsoFygw2F0yRwwgNm7ChNuANOrqOuk+HB4x3vwo7iCs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sLlKm-000rVr-Ci; Mon, 24 Jun 2024 17:10:20 +0200
Date: Mon, 24 Jun 2024 17:10:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Liu Wei <liuwei09@cestc.cn>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, prarit@redhat.com, will@kernel.org
Subject: Re: [PATCH V3] ACPI: Add acpi=nospcr to disable ACPI SPCR as default
 console on arm64
Message-ID: <5741452f-2a54-4239-a5c3-f13286726780@lunn.ch>
References: <f706cb73-4219-47fb-a075-e591502be7c2@lunn.ch>
 <20240624050404.84512-1-liuwei09@cestc.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624050404.84512-1-liuwei09@cestc.cn>

On Mon, Jun 24, 2024 at 01:04:04PM +0800, Liu Wei wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> > On Sat, Jun 22, 2024 at 05:35:21PM +0800, Liu Wei wrote:
> > > For varying privacy and security reasons, sometimes we would like to
> > > completely silence the serial console, and only enable it when needed.
> > > 
> > > But there are many existing systems that depend on this console,
> > > so add acpi=nospcr for this situation.
> > 
> > Maybe it is just me, but i see nospcr and my brain expands it to "no
> > speaker". Adding to that, your commit message says "completely
> > silence"...
> > 
> > > +			nospcr -- disable ACPI SPCR as default console on ARM64
> > > +			For ARM64, ONLY "acpi=off", "acpi=on", "acpi=force" or
> > > +			"acpi=nospcr" are available
> > > +			For RISCV64, ONLY "acpi=off", "acpi=on" or "acpi=force"
> > > +			are available
> > 
> > How about putting the word 'serial' in here somewhere, just to give
> > users an additional clue you are not talking about a speaker, CTRL-G
> > etc.
> 
> Thank you for your suggestion. 
> 
> You mean acpi=nospcr_serial or acpi=no_spcrserial? However, it appears 
> somewhat unconventional compared to the original acpi=* parameter.

How about:

nospcr -- disable ACPI SPCR as default _serial_ console on ARM64

Please as Will suggested, add a definition somewhere.

       Andrew

