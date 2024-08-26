Return-Path: <linux-kernel+bounces-301010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3156495EB85
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E861C20FED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3009513A3F0;
	Mon, 26 Aug 2024 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LrSIsxdl"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8194A28
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660016; cv=none; b=pENfD8igPpfMaIm1OHyh2TAzAVtxcj6hYz2hznetFEeUKe9SyhSe37c+lWU/SMHehW21ZrNTzsd3x8/JLcAKZUL48JinLiOa+u3Kzw2PfzhreBX/adKBjLwmDKxLpxvd4s9VFCb0iN72ro1ODiQWBYp1sXqawa9POsr7Cd8pjEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660016; c=relaxed/simple;
	bh=Qp/00LpdFt9fyZ9y8QshjY+ptg9wzwMtAYA98L2na+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VaXb/Ykl8Mr+8d3cWlHc2nht9syuYOeaSBFPweHZI4tx1DOQqz0biyaqIB7mwCw3z5xyGxV1WCWfAdE8EsRuTXt9wLkASAHmCf6wb94ZolAFGYxh9Ynl2snIkppvARpYnyvimZzYcDFkAxDH2p3cdpiyCM10soruA8VwB0s/hqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LrSIsxdl; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D35D20007;
	Mon, 26 Aug 2024 08:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724660007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qp/00LpdFt9fyZ9y8QshjY+ptg9wzwMtAYA98L2na+o=;
	b=LrSIsxdlmUt5Cou9Feh8QCcpu4xZ0fj6zVtQ2So7NSmWHulQyMiQPZs67HToG1ptjSlVRf
	HGZPAGVF2OZOOdGJ6BXW6X8oOScS/y38En16izvGbzQMHpVdeO9CDkdYMq3x7waYSg0F0t
	nFwf48cMzmjz1EdvjMOJnE3at65uHFXltVc329sYuKBtUng1mhGkgJ3l/Le/i4YnJMmjIf
	vn4rIxT8rGOjWv6o4MtnRaaxG4QtA08OMHSTrlq4MPpTBiOH9tzKZc1qZxK8WP1RSYHOrz
	D8x0HP9JxckoBRAu53ANliqxTAUFC8Tumti1BDG4AdLT+qN9LCn02dnuXUCF2g==
Date: Mon, 26 Aug 2024 10:13:23 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: carlos.song@nxp.com
Cc: alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-imx@nxp.com
Subject: Re: [PATCH v3] i3c: master: support to adjust first broadcast
 address speed
Message-ID: <20240826101323.746b617c@xps-13>
In-Reply-To: <20240826050957.1881563-1-carlos.song@nxp.com>
References: <20240826050957.1881563-1-carlos.song@nxp.com>
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

Hi Carlos,

carlos.song@nxp.com wrote on Mon, 26 Aug 2024 13:09:57 +0800:

> From: Carlos Song <carlos.song@nxp.com>
>=20
> According to I3C spec 6.2 Timing Specification, the Open Drain High Period
> of SCL Clock timing for first broadcast address should be adjusted to 200=
ns
> at least. I3C device working as i2c device will see the broadcast to close
> its Spike Filter then change to work at I3C mode. After that I3C open dra=
in
> SCL high level should be adjusted back.
>=20
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Frank, did you test it with eg. the Silvaco master?

Thanks,
Miqu=C3=A8l

