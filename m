Return-Path: <linux-kernel+bounces-173805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CFA8C05C5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341751F2386B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A9D13173E;
	Wed,  8 May 2024 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="a2/4sLX3";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="CEGyBVPP"
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [46.30.211.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8D225D9
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200647; cv=none; b=M6PbagwjQyHbteaBvWQ3y4g0qL9ibdkPDWE9wXcqbq0MiSsNACFHA6wD+X603RKidf8OIYFM/MWHsT9qBZ4Sn5IRFiRO2AdDySM/UiZjyuUJBCrIrQaFpWjd+hQ5e66WbpnTIS1ePBnX+QAoSQBmAOqF3+RIN+6fbr8NKoWT+Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200647; c=relaxed/simple;
	bh=07jHoMe4bOPwypjru0RYH8uUcJ12KG1zUOTQvntaJ6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wokbj9QbvzbQyNikMG2pJZFwDptN6nsa/gMIQpvM9j3v34OM0G4Ot9fV6HwgHjtkJBeCwmgBP0BHNwsazUmiGjN+i7uhhLpqRXq67Lr/uoRdsDkQ4n//kJvT9P2EmmNdhZqkMR5inPBjSOdCgBn7jvoaeaDYbHnXFp/VC4lbYr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=a2/4sLX3; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=CEGyBVPP; arc=none smtp.client-ip=46.30.211.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=2Kr4WAPymGfrFyDSJoZ4sUX/qeZZIZop4uu2xT6wC8g=;
	b=a2/4sLX3UBAM5CDJi69E6xgTJmcUlUGlgiWpr3MBzvygSwoYJbD4px9wDDaWolIfocZnuHGq8Ipki
	 g2c1Cm9trcnFPLPJWyfrieGUJP49pcwKxr6DwOohwAUqPl8aNIpGCsd369mft5I/sOhOF5pDe2XvoZ
	 TznTG2taddCRb4oovv2/qD/kGN5HXfArIwiXGAG60eJhNhQCyLMcG4vKw94oh6SZGwI5cWKfCGf9sI
	 5ZG6DPefQlnNmzHOhVyaAX6YR+XIh19zAIYTPBigUyCmp6z3Vts8TQANRqh3PGKkaijxA59SZBMP4p
	 ksjcSxxQkccvLutPmbJzHTtgoX7IvvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=2Kr4WAPymGfrFyDSJoZ4sUX/qeZZIZop4uu2xT6wC8g=;
	b=CEGyBVPPCl2X12NdPcyzd1fao8OO62cec9WJU3Erhxjd1RIzw7J466KO211uqWipb7NQIdd3xvAKq
	 Z/F8Ep7AA==
X-HalOne-ID: 9ba8772e-0d7a-11ef-88ab-edf132814434
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay5.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 9ba8772e-0d7a-11ef-88ab-edf132814434;
	Wed, 08 May 2024 20:36:15 +0000 (UTC)
Date: Wed, 8 May 2024 22:36:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	"open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
	"open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] fbdev: Have CONFIG_FB_NOTIFY be tristate
Message-ID: <20240508203613.GA2715801@ravnborg.org>
References: <20240503192858.103640-1-florian.fainelli@broadcom.com>
 <8e1867fc-34da-457c-b95a-2d51ea97336a@app.fastmail.com>
 <05a5e893-12f7-49fd-9a9a-abd387571f9b@broadcom.com>
 <ZjjXtEwWWZX43c6l@phenom.ffwll.local>
 <47c63c4c-c657-4210-b476-c91c4f192483@app.fastmail.com>
 <ZjoMI5bJSlqhtOy1@phenom.ffwll.local>
 <41191296-0aa0-4010-b70f-efa80b9200d4@app.fastmail.com>
 <fe156e32-8ce7-4ce5-99cb-6291ad4b83b0@broadcom.com>
 <41639d6b-a429-43f4-8568-12fcd1671cff@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41639d6b-a429-43f4-8568-12fcd1671cff@app.fastmail.com>

Hi Arnd,

> 
> I think if you want to do a new version, that is likely to run
> into new problems, given that this part of fbdev is particularly
> fragile and partly wrong. On the other hand, it would be nice to
> have a patch to limit the use of the notifiers to the smallest
> set of kernel configs that actually need it, and leave it turned
> off for everything else.
> 
> These are the ones I could find:
> 
> - CONFIG_GUMSTIX_AM200EPD (FB_EVENT_FB_REGISTERED)

I was surprised to see this driver is still around as many other old
drivers was nuked as part of the pxa cleanup.
It is the only user of FB_EVENT_FB_REGISTERED - so a potential cleanup
if the driver is no longer relevant.

Just a drive-by comment, this should not stop a v2 of the patchset.

	Sam

