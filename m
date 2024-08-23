Return-Path: <linux-kernel+bounces-298606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C418595C951
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8084D285FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B440514C581;
	Fri, 23 Aug 2024 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ijDn3QUy"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BAE13A86C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724405714; cv=none; b=HcO/yiVjfkXsYuviMfHtL9ifw/Gmz9/jzc4PDhhbohAxwiIO+fSQ/ZV/s45jPipcIP3UN1QB6HEpd0Ikr99SU7RNlRH19gFPzguJ4ILX/RQYFKIbUCQpwJNco4vm977n61fPE3a+cE6STQ2gKd0lUX+asC95DsgKRDTEX56eaLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724405714; c=relaxed/simple;
	bh=hxszrgTfu5DNhhdPZSdbfApdD3WFlV5mkaDhlcVV7ww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DMLKWtbCSb+vgAdg3Mv6mE6xr3sNLGlC7rMub95HmgJhXIcCDUF0ZGYRF634RQ7lAPPpkrbmn8dnATBaoAdT+0TwMsXrVvG02s16b7POfZ91Jxpi357o65GLa0mCJclgiPZTVaWBNSkG5PN/G1gk/uB+mfqpMl4b9H6rT6yFi0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ijDn3QUy; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 629E040007;
	Fri, 23 Aug 2024 09:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724405703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hxszrgTfu5DNhhdPZSdbfApdD3WFlV5mkaDhlcVV7ww=;
	b=ijDn3QUy55N0MEtS815dDTilIs7DaSEADkeOC3jOjoYnF0SoBqpeVURSJ605Aub4C1lf/f
	zwYWLkDilxj/kQwRD1+xf29EdMQVcB0CJZLBSSN5kGXkKGpVdT80/y6mS2N5AiMlivGLSv
	q37IMDSFiWyuZWx+HN2rhd2xj8tKystOTz0HmhXt+o3z5HYokggi24awKo2IZGKI7h9X2y
	g9+sE84+u1KlkJQUjcqPHa+WkcmbwI4bpIAUNObN5Ku30iSc54KHWPuMrY/fcartQqP2V7
	hRnzfyiT1CrRHGpSYouJyESM1rHUh9jZhoYPSwtVbkEccQV5GaQzPGJb8y4gxw==
Date: Fri, 23 Aug 2024 11:34:58 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Gregory Clement
 <gregory.clement@bootlin.com>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: Regression on Macchiatobin from the irqchip driver
Message-ID: <20240823113458.7540bf0a@fedora-3.home>
In-Reply-To: <87frqvh9wz.ffs@tglx>
References: <20240821165034.1af97bad@fedora-3.home>
	<87frqvh9wz.ffs@tglx>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Thomas,

On Fri, 23 Aug 2024 11:21:16 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> It obviously is the proper solution check after use is pretty pointless
> as you demonstrated. Care to send a proper patch?

Sure :)

Thanks,

Maxime

