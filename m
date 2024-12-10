Return-Path: <linux-kernel+bounces-439407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425B49EAEC9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F4028CBC8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BBD2153C0;
	Tue, 10 Dec 2024 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QVFkKudn"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1479E210F40;
	Tue, 10 Dec 2024 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828121; cv=none; b=oWanfaB7Zi1pFHkEPtLFljwdG0TUXoIeZEMsoh8wjFVwsymelmimUmIZ7twJcmXYrJOxD1uYZd6MUYgc4mP6XoRj1Jhgt2N6ZdSkcbhF2irxi1tR3g7Iaxqps73ow7XCOfkwgutNYEAXDuw0kV0VJv0QjSHWh6rh0avrTV3iyrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828121; c=relaxed/simple;
	bh=9111b5UZLqs8DQnEvLmhlYthhnN7GvbeSR8UC43HhAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9hWjaLo28m3XVhtzBVZwW9s/GFLzJnf0N/I3a3+C77/kO7BHZEuXD7q1aWNMK+uHYdfbg8sjrux6dg4hUjicuGnG7dSb4IeFpZeQ9IDLpuinBCO7Q+hsOZUcIc8IyOHhnlRrlkiNCNjsTMV10sindlCUT20tvIDlsLyhdzsAfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QVFkKudn; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 283B0C000A;
	Tue, 10 Dec 2024 10:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733828117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F5zEew0UHZxKlI51DMdavZ0AMc7bxxmVeaOJ9lkCc6U=;
	b=QVFkKudnUF/Khnf4BKkMOyOkqTQUf6RzPN7rqMbn389uombB8MvMbv8lXGFNZoR5mouaJj
	9HF3bgeS9txZ3GaMT9Z92ygVkXWibMWhrAl5yhJ5wOxwuRDZXUsG+9cGOKRR2nw5wS8MNK
	P1ryjbO613rA17IQ8kg7cf3c0GK3TvQb4JBFHoNKsMlrbFsybJ/IrDlJnAw7hYJZzAVgpC
	ufBopWL7bj30yxUWwnycTnGilXXWzh2yvfs/cJz97pUpl8WAxTDv2NAkmN5MQLxgJhoBtX
	qyNPnZi2gZv7+np4AjG6gnU13UjodrdZ1zm++cLdkRw0eNx0bEFb0N6O186c2Q==
Date: Tue, 10 Dec 2024 11:55:15 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Andrew Davis <afd@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan
 <saravanak@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 0/7] of: overlay: Add support for export-symbols node
 feature
Message-ID: <20241210115515.1886f73f@bootlin.com>
In-Reply-To: <bab9f277-a366-48ec-acdd-0896c8307ad9@beagleboard.org>
References: <20241209151830.95723-1-herve.codina@bootlin.com>
	<33c61b28-c0b8-478d-8107-c6ed1ff9e466@beagleboard.org>
	<20241210104141.39acffb1@bootlin.com>
	<bab9f277-a366-48ec-acdd-0896c8307ad9@beagleboard.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Ayush,

On Tue, 10 Dec 2024 15:26:44 +0530
Ayush Singh <ayush@beagleboard.org> wrote:

> On 10/12/24 15:11, Herve Codina wrote:
> > Hi Ayush,
> > 
> > On Tue, 10 Dec 2024 14:52:22 +0530
> > Ayush Singh <ayush@beagleboard.org> wrote:
> > 
> > ...  
> >>
> >> What is the reason for not using symbols directly as described here [3]?
> >>
> >> I do like this approach since it does not pollute the global symbols.
> >> Just want to know if there are any other reasons for it.
> >>  
> > 
> > Modifying the __symbols__ node at runtime (adding / removing properties in
> > it) exposes memory leaks if __symbols__ already exist in the live DT.
> > This __symbols__ node exist if the dtb was compiled with '-@' or if you
> > chain the overlay (i.e. __symbols__ node created by the first overlay).  
> 
> Yeah, that is a problem, specially in a setup which might involve 
> hot-plugging.
> 
> > 
> > I think also that some conflicts can appears. What happens if you want to
> > add a new label but this label is already present for some other purpose?  
> 
> I do not think that actually is a problem. As described in the original 
> patch [0], the symbol and connector overlay is supposed to be applied as 
> a group (overwriting any conflicting symbols in the process).
> 
> The reason why this is not a problem is that `__symbols__` are only used 
> to resolve the phandles (overlays do not support path references yet), 
> but do not really have a purpose in the livetree (at least far as I 
> know, but I can be wrong).
> 
> > 
> > Best regards,
> > Hervé  
> 
> [0]: https://lore.kernel.org/lkml/20240702164403.29067-1-afd@ti.com/


Also, in your first overlay (adding symbols in __sympbols__ node), you have
something like:
   GROVE_PIN1_MUX_I2C_SCL = "/bus@f0000/pinctrl@f4000/grove-i2c-pins";

If I understood correctly, other overlays will have GROVE_PIN1_MUX_I2C_SCL
as unresolved symbols and will use GROVE_PIN1_MUX_I2C_SCL to reference the
grove-i2c-pins node.
This unresolved symbol from the overlay is resolved thanks to the __symbols__
table where you added GROVE_PIN1_MUX_I2C_SCL (first overlay operation).

In order to work, you need to have a phandle property set in the
grove-i2c-pins node.

This is done by dtc when you compile the dtb containing the grove-i2c-pins
node (i.e. k3-am625-beagleplay.dts)

The phandle property will be set only if:
- a label for grove-i2c-pins already exist and -@ option is used
or
- a label for grove-i2c-pins already exist and it is referenced as a phandle
  in the dts (k3-am625-beagleplay.dts).

Otherwise, dtc will not create the phandle property and without this
property, the symbol resolution will not be correct.

Best regards,
Hervé


