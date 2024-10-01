Return-Path: <linux-kernel+bounces-345634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A79398B868
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA851C2271C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE9E19D8BC;
	Tue,  1 Oct 2024 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lrLvu/SH"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414E32B9B0
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775144; cv=none; b=ta9kj/vdsGtPggfLy3XlbvasIE47tADiSfulX1StS2sk4wsyJur+GlYaXyogplqoeaRlJbQZQMuQXyiT6kdE13CqJYaLgy30LMVAgFEvXzFSLcZdvM/9PRAJUNax2EC+FYpTZvq8fnBwFTgpuBr1AJB+fq2sGEsOXqdHYsvz24I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775144; c=relaxed/simple;
	bh=c2VQWjCZzBixHiG6aR4P+UDOCoeCcMrq4XaxHaqteh4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SL5XdZ0sLY3Yz/AL1W/vUdfcdk60WLiHahIpOCEQFVw4NiU2UfmZ6H+TANvvIgUv/wQDDkfiE4Ga0F41AAYyaeV0vuAWAiuNsjDDhjRsDIjcc3ogzy4n19dOTDJ78ZtaETxfe6pJlDMmHOl9m66kWFVdNd6fHmVUl2ViyjQ/fJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lrLvu/SH; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25A25E0004;
	Tue,  1 Oct 2024 09:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727775132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c2VQWjCZzBixHiG6aR4P+UDOCoeCcMrq4XaxHaqteh4=;
	b=lrLvu/SHVU3hhgKiXxZdDx59akLuAM0v2CGkjIdj79RUC9RBkM3jB1GhRDQ3uIFpQQTshx
	4TozDTZWDs4lXWxzKHLOw/AUSrUYfRbKopbw0AfR3T/QWmwFcR2/+qjXmzFnYL/0M6Eaga
	fCn7rlkXPAJm6UqRQJRe6vuPNSfistk6MG7bFlg03ybcHiVU8C7tvpOedobkBgXSxksHxw
	/7rgnH/vgO9UHotE4jRC6bDF0Cj5yaNI8PWeUm6yMPaL89eAE/UVQaWFHjPZD3rkcEVD+Q
	P8FfcnU1gh3+Gp9GjjhL741HyOn6W+I7CBbqinwG4ocf2JWJXQiGDE+sQ3Rkyw==
Date: Tue, 1 Oct 2024 11:32:10 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Martin Kurbanov <mmkurbanov@salutedevices.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 Michael Walle <michael@walle.cc>, "Mark Brown" <broonie@kernel.org>,
 Chia-Lin Kao <acelan.kao@canonical.com>, "Md Sadre Alam"
 <quic_mdalam@quicinc.com>, Ezra Buehler <ezra.buehler@husqvarnagroup.com>,
 Sridharan S N <quic_sridsn@quicinc.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Alexey Romanov
 <avromanov@salutedevices.com>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>, <kernel@salutedevices.com>
Subject: Re: [PATCH v2 5/5] mtd: spinand: esmt: OTP access for
 F50{L,D}1G41LB
Message-ID: <20241001113210.3fcab87d@xps-13>
In-Reply-To: <20240827174920.316756-6-mmkurbanov@salutedevices.com>
References: <20240827174920.316756-1-mmkurbanov@salutedevices.com>
	<20240827174920.316756-6-mmkurbanov@salutedevices.com>
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

Hi Martin,

mmkurbanov@salutedevices.com wrote on Tue, 27 Aug 2024 20:49:03 +0300:

> Support for OTP area access on ESMT F50L1G41LB and F50D1G41LB chips.
>=20
> Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>

All my comments in 4/5 apply here as well.

Thanks,
Miqu=C3=A8l

