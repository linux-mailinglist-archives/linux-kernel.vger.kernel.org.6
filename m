Return-Path: <linux-kernel+bounces-528013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A235EA4127E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199C31893F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 00:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1C811187;
	Mon, 24 Feb 2025 00:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buserror.net header.i=@buserror.net header.b="1+v+ww0e"
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5908410F2;
	Mon, 24 Feb 2025 00:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.227.176.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740356859; cv=none; b=uymgHnBJHXgpsiIOlqEA0P+rUfsq+R+sVf3WEi+je3Kmw0SvY5ul85WVegA47Bq2HxTxB5fwtYUUKk7HcK3N6VhNoJ6mKc4aGp0NSUsMg2hnzfIK/sF7mmN8sGOJY6PRu/hgB2tqDU/A3Yt0uOLIaXu4ELK7vDhD72VQa75NzHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740356859; c=relaxed/simple;
	bh=0I41af2cJ7npBQ2S28LqxW7YvzWA+DEHxxUd9YrgFBM=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Subject; b=djVL+SNZzn9QmYIFpAjt0JLWLDKExawg8yyex9nWgt6ssDR1usHF7303q5SWKhWb4jHKO8GHGsUJ3YlRr0qnhJ7RPpTzwVYV21fmPcHFfQ1fq5vGcaORSEiIGqZnln93Y0LudmBzJyCPYvcFGKBEBb0t63f7s1oXpMrgEAfGWGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=buserror.net; spf=pass smtp.mailfrom=buserror.net; dkim=pass (2048-bit key) header.d=buserror.net header.i=@buserror.net header.b=1+v+ww0e; arc=none smtp.client-ip=165.227.176.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=buserror.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buserror.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=buserror.net; s=rsa_sel; h=Subject:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description;
	bh=ESEjuP0qNKG7M31LDxN5dSH9PUQiZX8A161LNfHK2gs=; b=1+v+ww0eli53gNR6dEhBDOqi2B
	mrW7UtVHR4Yzh81YhZxcdbGJtdQbX0Wu/Ew7/1BUBebZUQQ8ArhhfBhL/GJ0C1qpVgStWr8RVCCMk
	5GjYDXmpB2WORXvs59CtqCoEoNWh+fxUYKMgEsuxU7LV9qRHumXtRtcbpHRb61IuAQ/ildErwsOAH
	FJyH0AnNYosXBzEa8H9KKSFQM3sQ0+8qXyzLk8KIPl1Zb7H+jvVMtD6XvhIgW+7dEPA8EtsmFO/jE
	/4gfAdWIyG1k5Utcfe66gKke/O3HjMVSXUFscRPdrWWMViDr399GxelCcOF1PMttz5jRwigl2yYHE
	PoRjdYtQ==;
Received: from oss by baldur.buserror.net with local (Exim 4.96)
	(envelope-from <oss@buserror.net>)
	id 1tmLfR-00ELyd-2y;
	Sun, 23 Feb 2025 17:45:50 -0600
Date: Sun, 23 Feb 2025 17:45:49 -0600
From: Crystal Wood <oss@buserror.net>
To: Rob Herring <robh@kernel.org>
Cc: j.ne@posteo.net, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org
Message-ID: <Z7uzLeXiXIdVYNM5@buserror.net>
References: <20250207-ppcyaml-v2-0-8137b0c42526@posteo.net>
 <20250207-ppcyaml-v2-9-8137b0c42526@posteo.net>
 <Z6kQpuQf5m-bXTyt@buserror.net>
 <20250210215324.GA1040564-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210215324.GA1040564-robh@kernel.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: robh@kernel.org, j.ne@posteo.net, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
X-SA-Exim-Mail-From: oss@buserror.net
X-Spam-Level: 
X-Spam-Report: 
	*  -15 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
	* -0.0 NO_RELAYS Informational: message was not relayed via SMTP
Subject: Re: [PATCH v2 09/12] dt-bindings: memory-controllers: Convert
 fsl,elbc to YAML
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)

On Mon, Feb 10, 2025 at 03:53:24PM -0600, Rob Herring wrote:
> Generally, if a bus has control registers or resources like clocks, then 
> we tend not to call them 'simple-bus'. And '"specific-bus", 
> "simple-bus"' gives some problems around what driver if any do you 
> bind to. 

Isn't the general idea that you bind to the first one in the list that
you have a driver for, since it goes from most to least specific?

> If you have chip selects, then you have config registers for those. 
> Not really "simple" if you ask me. That being said, you could keep 
> 'simple-bus' here. I would tend to err on making the schema match the 
> actual .dts rather than updating the .dts files on older platforms like 
> these.

By that definition I wonder how much truly qualifies.  Even with
IMMR/CCSR, firmware needs to at least set the base register (which is
itself inside CCSR, so there's no way to avoid relying on knowledge of
what the firmware did, except on 8xx).  Though I acknowledge that eLBC is
a stretch, with FCM and UPM being exceptions.  FCM didn't exist in the
original LBC, and UPM was... kind of considered a fringe use case
until someone hooked NAND up to it.  :-P

The point back then wasn't that such registers don't exist, but that the
OS can use the devices without having to care.  But of course, there's
subjectivity there about what the OS might care about (e.g. UPM).

FWIW, on these chips (especially the later ones) there were all sorts of
things (in general, not specifically LBC-related) that firmware had to
set up to present a coherent system to the OS.  Not all the choices made
there were great, but if we tried to describe all the gory details from
the start I'm sure we would have made an even bigger mess of it.

> > For non-NAND devices this bus generally meets the definition of "an
> > internal I/O bus that cannot be probed for devices" where "devices on the
> > bus can be accessed directly without additional configuration
> > required".  NAND flash is an exception, but those devices have
> > compatibles that are specific to the bus controller.
> 
> NAND bindings have evolved quite a bit if you haven't been paying 
> attention.

I haven't, as I acknowledged... but I was describing how eLBC does it,
and just meant that we're not binding to drivers that don't know about
the bus in that case.  The NAND control registers are part of eLBC/IFC,
not a separate block (the reg in the NAND node itself is just the SRAM
used as a buffer).  I'm not sure what that would be expected to look like
these days.

-Crystal

