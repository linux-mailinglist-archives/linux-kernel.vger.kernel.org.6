Return-Path: <linux-kernel+bounces-439074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4059EAA74
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26526164CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB2D22F3BC;
	Tue, 10 Dec 2024 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mmc7w0YZ"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAEC22CBD0;
	Tue, 10 Dec 2024 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733818818; cv=none; b=FaFg7uyGwyhiLcw889+LhQsMh+52u2M7JNH1KcQkk2CxDsebs7p+WVMr7tdAC3e794+FJKs0XLOH/HfoYYy5Vev23dj7oaG+c0/GpLAO/hANhhCS2ggYzjG9DIBdMyektHEeKPxM9aCkNxArdG+VPmQjoT8Xre/UOioA8LYa+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733818818; c=relaxed/simple;
	bh=p8JGXEWmEdt5MxzhhM9kkyp4xmbpJJ6oNzPanihGgn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSeCryHxM6y9hLrQiKQbGwsrSGohwPoZU+R0aPjju/G6iALE3TTFyOwu49YZGO9BY3IvKgn25Q0NAryn3ZVbpQimYsTUZJfrlMSoS+3eK0akPm6qEb2xhqwJzpwVOTfxVbaRJWD4rR4efeugXa5menNjdAMtOk/IhnsT1TTvd2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mmc7w0YZ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9707DC0002;
	Tue, 10 Dec 2024 08:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733818814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wYOF2Wl1qX6c3I/DkpzehZyI0ZDHmWep+qnl7cvy6B4=;
	b=mmc7w0YZeO0vH7HMZ+9/ewjYFRvq9ryEiXTTOunK+ufrHJ2Ndt8TITmoctEjvX2loy2G9k
	NosFeAMjQRWelu3e9viGIlsl4HPRDncOKIRvOH55KmMYKHL2LW+/RT6DqTlm8L6y4AcfqR
	MQ3xR5or2uSvG23EVc9fVRF2bkbjYv2KzIiTNk4G3jljPRGAzbdKXq1HMLqNiSwf+fLmJq
	qYnjKGT7PDuGTkhZCyi74qjxi13C+W9z7V45LH5jO3loWHHTQCOFNHTFmxOXRi3Xxd+0Hu
	mS7SUpgS0JTXRS3kInAhzG4vGUqhP8dlGybKr+/ZMyudbduSDh6QSGelNeiJsw==
Date: Tue, 10 Dec 2024 09:20:12 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrew Davis <afd@ti.com>, Ayush Singh <ayush@beagleboard.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/7] dt-bindings: Add support for export-symbols node
Message-ID: <20241210092012.0ba678d2@bootlin.com>
In-Reply-To: <20241209182722.2dd15f7a@booty>
References: <20241209151830.95723-1-herve.codina@bootlin.com>
	<20241209151830.95723-2-herve.codina@bootlin.com>
	<20241209182722.2dd15f7a@booty>
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

Hi Luca,
On Mon, 9 Dec 2024 18:27:22 +0100
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

...
> > +patternProperties:
> > +  "^[a-zA-Z_]?[a-zA-Z0-9_]*$":  
> 
> I think the '?' should not be there: "^[a-zA-Z_][a-zA-Z0-9_]*$".
> 

You're right. I will update in the next iteration.

Thanks,
Hervé

