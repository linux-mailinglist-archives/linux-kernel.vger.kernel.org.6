Return-Path: <linux-kernel+bounces-299261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB1C95D21E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430451F21B44
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E631885A1;
	Fri, 23 Aug 2024 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HOUepx49"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7C189508
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428507; cv=none; b=S8n5XJgY7vS7ZGwtZ77nvYPcKuBHALu8L6pJ6xl92AeGsUNucC3guT3pIyxzGNXLXkyAvydk+BQpoY7p1zQk+rqnsZ2y82JEUC5WHANJWZQKzGjgPn6HvmETx6DK01hfjZOioOInpGPnTnCwPED+RDqUbdK4rZ3QAK00NasrWXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428507; c=relaxed/simple;
	bh=eEz/6ePZ1I0F5z1Apuw2JYhplnq/t4tSEJ8r8Pg89tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFTGHbzDsSCFvJtOzc2o/ms2R1GrB1dDxQ0rZDscboF40GLUssRN/cr/vza7vfcg105/5hirrIPWoofmDOjjS+ZMSFtQbz7EQGDgscgTWak7Vg4VFk9LevVrY4Ukpq4zPRPZ+p+HMVaIxTU+Zl2XAPpNenKiZk63famzzHxsHIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HOUepx49; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 36BA31BF206;
	Fri, 23 Aug 2024 15:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724428503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEz/6ePZ1I0F5z1Apuw2JYhplnq/t4tSEJ8r8Pg89tQ=;
	b=HOUepx49jzYoEeJeaYxdSRDvVYk7Zzht9GAHiqD/PYjeUVFT6BcPgyApLNRDcs49+kgWiF
	29EpFGsz2lay3DrnFGDBMhkPeBqysdzLLVhy1cqzNPRERT0kjfht5NGNK6nT4GmMhv7EXj
	sGm8EtGh42qvicnkqPNF2GBgPOKyPvBcdh+uqdr9sHcArb45C+Jz+M1wijKRaePLRQzmWA
	KHWlxIPXnMTFxzjGLU1PtwhZZepfVlV4UNqnIO06Nw7stMxJR5Uard0HdMZEgd2FwaDYGu
	se+vqMOW5AoI2qYBH37Odu2EPNkcZshqkWd/0sj11fJCPqJ58jJJYv45pfy76w==
Date: Fri, 23 Aug 2024 17:55:02 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, Parshuram Thombare <pthombar@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Boris Brezillon
 <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Conor Culhane
 <conor.culhane@silvaco.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 02/11] i3c: master: Replace hard code 2 with macro
 I3C_ADDR_SLOT_BITS
Message-ID: <20240823175502.3d518a69@xps-13>
In-Reply-To: <20240819-i3c_fix-v3-2-7d69f7b0a05e@nxp.com>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
	<20240819-i3c_fix-v3-2-7d69f7b0a05e@nxp.com>
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

Frank.Li@nxp.com wrote on Mon, 19 Aug 2024 12:01:56 -0400:

> Replace the hardcoded value 2, which indicates 2 bits for I3C address
> status, with the predefined macro I3C_ADDR_SLOT_BITS.

I'm fine with the idea but I don't understand the macro name. You're
talking about status bits and yet the macro is named addr_slot?

> Improve maintainability and extensibility of the code.

Thanks,
Miqu=C3=A8l

