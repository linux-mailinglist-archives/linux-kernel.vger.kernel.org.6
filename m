Return-Path: <linux-kernel+bounces-192330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ECC8D1B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E344286141
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6057016D335;
	Tue, 28 May 2024 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ICY6tl54"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63177316E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900514; cv=none; b=Wo8RMTpdNp3WxnwlxTHDYVAl6mZpFb1s9CWWECTVpX7ttWOWH14TeCayiv9LP8bKrfpOZ0PHUYaeqAplsmLlRL/ir9i/pv6XAWNfWfDZBNrWbIZajJTtEDMfX/Mwu5ru9bx0iYVm4ZBwp+P++apB3qJz7GVVnZwRM/efEhpD1kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900514; c=relaxed/simple;
	bh=DLJWkJDSvhOXa3XSbG71htDtV3QhuWVrpRwUqqioGx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lg7xp8HxnvGkMicY87PxF4n+huqwOgRwJxQmpbW3l3l5Ufz2+e2ErUm4McC6fJRIcMP5XJcFQOE3DYLDm919eKUxiLWdxDgiV1YG2xuzZBzZbuiHOd7+qdgTyBfeXZjGpwrgKq46ggYkLuR2hz5ilDyQPixO628Wf17C9OC486E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ICY6tl54; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A4721FF809;
	Tue, 28 May 2024 12:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716900506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLJWkJDSvhOXa3XSbG71htDtV3QhuWVrpRwUqqioGx0=;
	b=ICY6tl549JvPFPlVwt7iObOMHzhwO2lt67WGlfgFejMB/CKbBgh0rHR0kbXuCmasmx4bAF
	X/za9QNoeNAJlaHCDrzMsH+35b9WPdDGQpZ7AHVDDay3ObaxU2lQj8Dc3JH6fJmX8qW8AJ
	h3HlXE4vvI9RI8NreTXfiU6d/1ZwADbZKLSNSjlRvrrin8YNfItjGk5eWQDCAHal0Iv9pC
	hjiVU6v+VeEwDNHxhfAKOnjCN4Xs62Z9A/i2yii7l2bdqsNKzLNC/rWvHIzZEE6Qna5ZTq
	UxnZB3XMLJO/2rXiu8CDVjQM98YnjqCKGP+MsBKcRMAxwH4LXtfx/AuUo9IPpQ==
Date: Tue, 28 May 2024 14:48:23 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, Michael
 Walle <mwalle@kernel.org>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] memory: fsl_ifc: Make FSL_IFC config visible and
 selectable
Message-ID: <20240528144823.2ec929f6@xps-13>
In-Reply-To: <20240528-fsl-ifc-config-v2-1-5fd7be76650d@geanix.com>
References: <20240528-fsl-ifc-config-v2-0-5fd7be76650d@geanix.com>
	<20240528-fsl-ifc-config-v2-1-5fd7be76650d@geanix.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Esben,

esben@geanix.com wrote on Tue, 28 May 2024 14:28:52 +0200:

> While use of fsl_ifc driver with NAND flash is fine, as the fsl_ifc_nand
> driver selects FSL_IFC automatically, we need the CONFIG_FSL_IFC option to
> be selectable for platforms using fsl_ifc with NOR flash.
>=20
> Fixes: ea0c0ad6b6eb ("memory: Enable compile testing for most of the driv=
ers")
> Signed-off-by: Esben Haabendal <esben@geanix.com>

Looks good to me.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

