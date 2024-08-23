Return-Path: <linux-kernel+bounces-299303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 368AA95D283
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68EF31C22477
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E7B189B8A;
	Fri, 23 Aug 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aoPAuVp/"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA29918593A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429459; cv=none; b=jbAQ9S7MveoABRlqoRwDYZTH+xGYDZPhWoCmvc1Tu8N815K0uBbliJXFB9oB8k26BY8Txg0SxtXEJstN+9IgqqKmGGIu0j5MldjkapsvodyMP4JUwxcFz6kYfDPvTR1kvzLc1b6S3+xJepLCndgaHgIkOR3e3ckKS8xz1TdmKxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429459; c=relaxed/simple;
	bh=OTgGYKu2x0zUKSDgcu/aPbz+tb0PHBa0K0KAuoUGdlY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izMwXvCAyNpwY3gfcX4aR8lCJVuTUofYjPKB8nJZtiJb/SBOQKaddPomY2fqil/Oo3MyJJkxFLZZNqVTwQf/rPlsvBK8DB9+nHyLkwN2y6R70Cs8jr9AETvOj3vxtQtalP2UHsvdTZqN/bsG61JN6RdIivZToBrLwrxXChL9RqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aoPAuVp/; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 13D3D40009;
	Fri, 23 Aug 2024 16:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724429454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTgGYKu2x0zUKSDgcu/aPbz+tb0PHBa0K0KAuoUGdlY=;
	b=aoPAuVp/1cIoLFPBf8qBDCysN7ZELBNzgpxnKiSg0xyPrispsWeedQ9LXmP6X00itXfHg9
	rpdRM0XG88qlckXUaPoxRbzD3k03L7eJFxJSqyGdbsFYzB+VcxcqQj7Z0aC9rjQNeatMdW
	UiunmznfP9Twd2SnuEDbknS8KVKRSkI1vJbMuAV96IdEbWtEMGHqREsF1SdC4sh64nnpXU
	FPAr7ESIfcCSuOUOVJU0tPVigjpGeHiwAFx+ZE8wyGxButwFtbs4MExqoNPuedOdnLXIg7
	fqzddBVpESdRhmBOjT0FCEjr2Gx7mlyaDy+l7e8NWDWiTZ7wXck7X88+P4Tdtg==
Date: Fri, 23 Aug 2024 18:10:53 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, Parshuram Thombare <pthombar@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Boris Brezillon
 <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Conor Culhane
 <conor.culhane@silvaco.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 07/11] i3c: master: svc: manually emit NACK/ACK for
 hotjoin
Message-ID: <20240823181053.4a793095@xps-13>
In-Reply-To: <20240819-i3c_fix-v3-7-7d69f7b0a05e@nxp.com>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
	<20240819-i3c_fix-v3-7-7d69f7b0a05e@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Frank,

Frank.Li@nxp.com wrote on Mon, 19 Aug 2024 12:02:01 -0400:

> When the address is arbitrated at send address, the hardware can auto-send
> NACK if it is an IBI. However, manual emission of NACK/ACK is needed for
> hot join or controller request events.
>=20
> Add help function svc_i3c_master_handle_ibi_won() to check event type and
> send out NACK if the event is not an IBI.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

