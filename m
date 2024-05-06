Return-Path: <linux-kernel+bounces-169527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 104AF8BC9F2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC4A1C20CF5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706B61422B4;
	Mon,  6 May 2024 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PJAc57vG"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FC01419BC;
	Mon,  6 May 2024 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985286; cv=none; b=W8qpJlPYQH8R1sbIy9nrieeSb8B8PtdLZLDEBdhGAzucn6bUJdRpDQLUZTVmBroA+Eqr8ENcIVAzxCY8uoayHpBHW+CBqRvO28/GAKuEz5vgoFf/cPMMrhh1bl1FI68hYyq8VK21gP1Q4rXlwf0QQQoXajmWmgIOxaCyP6WaWZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985286; c=relaxed/simple;
	bh=qec4JOlCq2MSVwUU+8VRmsKAw88MzHZzy9yA4DQOIHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXNe5uNnphl6Ze3Ue/14yb8LjTEwJBsWepnar3L+FV4BX4PWZOccb4hO2b5d52YqIOZaI3DngxZwmcUSpfTDswFAnVCritPCxAvX2pgWBI9vzIkGvy/16AiuE9Pq6NwZCtgL93V7iIAb3Uun8Q0+2lntsV34bP1seFsY/KMt0ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PJAc57vG; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47A84FF80D;
	Mon,  6 May 2024 08:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714985276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qec4JOlCq2MSVwUU+8VRmsKAw88MzHZzy9yA4DQOIHs=;
	b=PJAc57vGVhbV9olxuDC0j3hEPIgju5U6MTQ6IIAoX0CMlsroo8tcN+BdsZCA+A4G526nxI
	7DfJNRfmkRJP+Hod/+t0vf+P8DNxHLtvPdqs29gr3XCkhL4XNIvLTiwmmJh8OWVWcMaule
	4avCb8cj0JtGuNztJMWFh6PO/4RDZ9WnmRSF5NxnCqBR2guX8TceIoL3osnPgcNraPs2ei
	JuxUqoFdobsXA/ngbkJZp+bqnBvcnl3X+mTCmK69l5bhJi/SDvZP2GJW2i/9ClD/ZLktSh
	h4nzCt0+AnNa+ewY5wWoZjuSlbPPIjkiE8/FzBObfRkilGJvGzjdDcuPfYyhNQ==
Date: Mon, 6 May 2024 10:47:53 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
 <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <oxffffaa@gmail.com>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v5 2/2] mtd: rawnand: meson: support R/W mode for boot
 ROM
Message-ID: <20240506104753.25e5f8cd@xps-13>
In-Reply-To: <2e5b39a1-ffe6-1186-2ce7-51b61c5006d3@salutedevices.com>
References: <20240416085101.740458-1-avkrasnov@salutedevices.com>
	<20240416085101.740458-3-avkrasnov@salutedevices.com>
	<2e5b39a1-ffe6-1186-2ce7-51b61c5006d3@salutedevices.com>
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

Hi Arseniy,

avkrasnov@salutedevices.com wrote on Thu, 2 May 2024 08:09:34 +0300:

> Hello, sorry, pls ping, 2 weeks :)

I was on vacation, I am currently late by 30+ patches, yours is on the
list ;)

Thanks,
Miqu=C3=A8l

