Return-Path: <linux-kernel+bounces-417120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2599D4F41
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E591F2153A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F661DE891;
	Thu, 21 Nov 2024 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ifi4ZNoh"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67471DE4FE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200717; cv=none; b=rlyt6eNzqk2+8NtGh5CW2eph51xuCU6NFjQ1aOV9UeiXzVXdObjRHPsOzlEKrbEbZQ9t3vSwsXKecB2s9lgIgraeF8Q78XaYit2dkQU1HxJH0/23JrwPqBkVfOYi/cVP5S6rFMFrvFODD/xQ4fG8uyiTh0HZYh7KzD2RLgu1QFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200717; c=relaxed/simple;
	bh=L70ih0b5CGIYxQxsmUvq4AV/q7xqEhUmZA/jzOP0hCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dKMZ6nsCTlt+T5qP/sZZDvGs+1+1FFnKM9nzGqov5jdzwEcH2RaFZeyv0n6GM64+M0/pjBcrR2p6sY9wqzWdzHE8IvVdjfu++llLoxQ4gRNoY9M3bBJjAafkGayt/wJ5Ih+Q6VtW1GNmsNRFGi16wHCqBTph9vXRkk4RfKSW2CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ifi4ZNoh; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21D37FF809;
	Thu, 21 Nov 2024 14:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L70ih0b5CGIYxQxsmUvq4AV/q7xqEhUmZA/jzOP0hCM=;
	b=Ifi4ZNohp5429Hhl6OSzm3pxgOJVPc4rEMMeytYsEMwjgUIR5PUzdEcPXTCnGcAmASqpxv
	Z3hdqsRr6daakAMQGVDu4bCuK1c2+U68Nolg07pU4x1x7qP4SKUwUoXqx6G+JGT6OeOMug
	T4bWxbFJIw93ti+/UQjcxjcTZyg+WEBkUQbE+hTMZb2V08bTsCuMQ5kIq57IaZR+/rm3vD
	L7G9ek1h84LmjvWdc0dez6LxDNivrXf0ucNtyBPIBNPZGd3nKZ+vUNPWGmns8G5KuJkgCr
	MckBL+M0S4OWh/A2s7DPRSXRj3wCdtD4cPhkCZ/bx/XjgLStgEXoPqnHLO6qBA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>,  Santosh Shilimkar
 <ssantosh@kernel.org>,  Richard Weinberger <richard@nod.at>,  Vignesh
 Raghavendra <vigneshr@ti.com>,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Herve Codina <herve.codina@bootlin.com>,
  Christopher Cordahi <christophercordahi@nanometrics.ca>
Subject: Re: [PATCH v4 00/10] Implement setup_interface() in the DaVinci
 NAND controller
In-Reply-To: <72a0e0a5-c44c-4e92-9f91-e200900e3eed@kernel.org> (Krzysztof
	Kozlowski's message of "Thu, 21 Nov 2024 11:23:51 +0100")
References: <20241115132631.264609-1-bastien.curutchet@bootlin.com>
	<72a0e0a5-c44c-4e92-9f91-e200900e3eed@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 21 Nov 2024 15:51:51 +0100
Message-ID: <87ed34vdvc.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Krzysztof,

On 21/11/2024 at 11:23:51 +01, Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 15/11/2024 14:26, Bastien Curutchet wrote:
>> Hi all,
>>=20
>> This patch series aims to implement the setup_interface() operation in
>> the DaVinci NAND controller to enable the use of all ONFI modes and
>> improve the NAND access speed.
>>=20
>> PATCH 6 depends on PATCH 1-2-3-4-5
>> PATCH 10 depends on PATCH 6-8-9
>
> That's a bit too many to go via separate tree, so I'll provide them via
> stable tag to Miquel/MTD.

Yep, works perfectly for me.

Cheers,
Miqu=C3=A8l

