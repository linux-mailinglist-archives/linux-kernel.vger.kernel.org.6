Return-Path: <linux-kernel+bounces-201897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4A98FC4E7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E1D283726
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1272D18F2E9;
	Wed,  5 Jun 2024 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QGKdGKKg"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846FE18F2D3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573593; cv=none; b=G8B5eLuAIb4VICP2yKZRgqzVWyxF+S6Tr896ZvDDNgUv9BI3g3Qc0vIJpaLYPOKwzaqq9SnoyRiqdGHuPJMTUyPpILnNAjchPfnOBS1mV7OaPgORCVM704TlsCvNYBadSUVAZjbCcIrpTk6RzAVPqqv7X1Fc7ARgZ0nsnZWeHUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573593; c=relaxed/simple;
	bh=r3Kzc+XJxiov2vmnrA4MZmY3LMokV9cIB0YO9V095a4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xdvz7O23MH/tcWErKLi8dA7NKFvhI1ornrl9xk2i+Hgh6zPVYgoN6X9d12Ko+uUtd8Nisdh91wIlksOxFZ1OwVRP14um2IPiF1TtbuO+4lgBBl9fLyfdReeI7NKxm7JdWuDzKW7jcj+AFeLcJaAKelJr26pE5nbADVGSmvKpQuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QGKdGKKg; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay8-d.mail.gandi.net (unknown [217.70.183.201])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 96935C696C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:44:09 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B21C01BF20A;
	Wed,  5 Jun 2024 07:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717573442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMazlr+f0ay0OQRRaQaLtVjPs1acjHVrV/9BzKL3MHk=;
	b=QGKdGKKgTQwaxwc7fzB9V3qEm+4vNF63AtrXImg09JWC6pPjni7y6vu9B4TIVsawzG1ri+
	utuOAP2q5gaPux+W+FabcM5e8JGR74mA6aitOyTySvwAynZ4qPIyAjf5ElVLFusrKaAeIO
	QNJl7eBavwHYr0tiIfNM+bt+3aENtas+Yd0pmM5FRcYAv5E3Pv+ZIMJUbbz7TPs3hjlM6n
	giURPVPgGjS2A/1+/WPXZDGStYZpaBe6t8o850O10cBLFosy6TF67428plfi6cVPrKr3b0
	4lmf6Ojyyw74JLYMGSFqAZ8UsuVrk2ARRxAzjHSucGncWW1hT1WYpyUxLZjlpQ==
Date: Wed, 5 Jun 2024 09:43:59 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, Richard
 Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 0/2] mtd: use 'time_left' instead of 'timeout' with
 wait_*() functions
Message-ID: <20240605094359.53a6d8ca@xps-13>
In-Reply-To: <20240604212919.5038-4-wsa+renesas@sang-engineering.com>
References: <20240604212919.5038-4-wsa+renesas@sang-engineering.com>
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

Hi Wolfram,

wsa+renesas@sang-engineering.com wrote on Tue,  4 Jun 2024 23:29:19
+0200:

> There is a confusing pattern in the kernel to use a variable named 'timeo=
ut' to
> store the result of wait_*() functions causing patterns like:
>=20
>         timeout =3D wait_for_completion_timeout(...)
>         if (!timeout) return -ETIMEDOUT;
>=20
> with all kinds of permutations. Use 'time_left' as a variable to make the=
 code
> obvious and self explaining.

Good idea. The waiting functions are generally confusing because the
semantics of the return values are different, so this is a good first
step, I'll take them through mtd-next soon.

Thanks,
Miqu=C3=A8l

