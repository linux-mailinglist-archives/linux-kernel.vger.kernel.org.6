Return-Path: <linux-kernel+bounces-438116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559AF9E9D0F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8939280FAE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3B01547FE;
	Mon,  9 Dec 2024 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LZBWrAqk"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE84C153BFC;
	Mon,  9 Dec 2024 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733765261; cv=none; b=ajjA0panccDeFQm1BILVV2xv+bnMIwA7BiLUPM8o2oTMDg74/vFQ0kXBezxfQBYPpXOr4R0SjMo9NwaKm16jamYWUMvofKFEOB9rN1+RUMwms5cM0PaaC9QIoWWkkWGkzLvI+LOsGVtJMaN2QecOWgToRbxoUjLIo4z09Ur9Jbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733765261; c=relaxed/simple;
	bh=hLHbv37/Xjdjt+zvQM/NG/XnnuAdOIx2c+MdjpFa5WU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MW2/gQSOw3tgni9YVLkUA9L7EDc/AayLlzYS1n8gDMpMrcE1JFkzTu20zJSAKxV3AfA87R2AvxYn3ZPsBJEgW4Bh6v5k0cl0F+YcAb67UyKR34Hwv6rAvAsprCoWsFGIYfIOHhoyvU7JL80vw30GP0p0qVULdYb8k4soqe9zpUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LZBWrAqk; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A1AD140004;
	Mon,  9 Dec 2024 17:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733765250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eUSkSmcJnrpmczKhbramKYpveVX33QbC2aQansZdETc=;
	b=LZBWrAqkbC5ShMQqtmGQTmNrErgmmZKVVYNaUgVqWm7UEzkEwvAB11gJ1sVj5sAoETRvcv
	EwEABcw40CWJOYMEVKrWHteZQ/rjjNMsBHGxZ3iQRnMJP6xW22wLhEt+uMLoEunwmYVUaK
	2HH1bP2k8bI6J8fRypwcSTHZ8eWLvvXyPOcfFbtEgH15ynunFzuI9ZiQpZtocRX9hokB8b
	0NRDItQdtA9Q//7ML6zAwIG3knnEd7X3qVRug3zdOaS6OY3U1stegV+MeGFSoDLe+25Ubh
	W52RRGbAePOlgNbYLVDzXeaACP8p9qXDn9rDWAweNwkxpuHDC4FrWz1qD7QpdA==
Date: Mon, 9 Dec 2024 18:27:28 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Davis <afd@ti.com>, Ayush Singh <ayush@beagleboard.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 5/7] of: overlay: Add export_symbols_name in
 of_overlay_fdt_apply() parameters
Message-ID: <20241209182728.1ab9247a@booty>
In-Reply-To: <20241209151830.95723-6-herve.codina@bootlin.com>
References: <20241209151830.95723-1-herve.codina@bootlin.com>
	<20241209151830.95723-6-herve.codina@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

On Mon,  9 Dec 2024 16:18:23 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

> In order to prepare the introduction of the export symbols node
> handling, add a export_symbols_name parameter in of_overlay_fdt_apply().
> 
> The export_symbols_name is the name of the export symbols subnode
> available in the base node that will be used by the resolver to handle
> export symbols resolution.
> 
> Having the name of the subnode in parameters instead of the subnode
> itself avoid the use of an export symbol node that is not directly

s/avoid/avoids/

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

