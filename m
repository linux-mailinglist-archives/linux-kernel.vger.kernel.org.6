Return-Path: <linux-kernel+bounces-319106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A01796F7C9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B562C287532
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE731D3191;
	Fri,  6 Sep 2024 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MU9qiiEe"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E481D2F57
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635084; cv=none; b=oc9uG5u+hoo7B38VCefFX3LJGb3GSHO0zEnH6miK3wptClb2PwRh9TaXqKM6atgZsSPi15zh1ojJhARce1dXkoxF9kPJzxpElZfoESjWmkC4YysAik4LJiEWPDbmeiv4ZDYV/OkTEQkQF8RxSwYofMoBtTCfSw+FXzFpnK2CCiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635084; c=relaxed/simple;
	bh=mdlqaFi/Uvx2ktNZCM67K7I1Tw9tJEMim7xP6b5Z78I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZnTdgICcWFm50weP+0JzumY/dfrHehp3k8lINw/9/iHVv+fsP+UcolcGMLj9CN7V11zlt87Fpq31i/AcFade0bKiCTHjFsIT9DXo/J2ig6OnAQC7RIP/vl9zpWCLkeMMmOT9cp8Ot2+n8eFittYc2Rl1DTJC4vL+o6OAvfyYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MU9qiiEe; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BE81220009;
	Fri,  6 Sep 2024 15:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725635080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MzODiud35KXJeKU0eeHbpjUWLMquM8lxcBBxxzdvxLI=;
	b=MU9qiiEeZCB2Jv3502tf7ZMhTZ0EDlcSQC2qdXV03Y7sgYM0utXdRptBCBVAWt1JUpYBWl
	MTClIgNReTGOAjjUCQqPg9bdVRIjx8dAqDWqwi20ketlP0LonpUVKb5B/BayT1dMqgpNWJ
	0h1BZoPSe8HCIRNQXGNZybGD9/Hk1KULfl2WlEYzfMt64wdcsgO1+2hGIwVYecQ0A2TVnA
	oG7+MAMzZGSIiEhRgoq30fQ/3Zu9jbcm/AicIPXIab+iIeH2DpDghua9A1nvxqU0zIkOba
	CPk15j0Vnvl6s5LyDlyaYO6CpIDYxHa3m9fqqkkk7zhvrRETump1HwJnNZZ7FA==
Date: Fri, 6 Sep 2024 17:04:39 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw,
 leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v6 2/2] mtd: spinand: macronix: Flag parts needing
 explicit plane select
Message-ID: <20240906170439.286e6c55@xps-13>
In-Reply-To: <20240903013625.1658825-3-linchengming884@gmail.com>
References: <20240903013625.1658825-1-linchengming884@gmail.com>
	<20240903013625.1658825-3-linchengming884@gmail.com>
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

Hi Cheng Ming,

linchengming884@gmail.com wrote on Tue,  3 Sep 2024 09:36:25 +0800:

> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>=20
> Macronix serial NAND flash with a two-plane structure requires
> insertion of the Plane Select bit into the column address during
> the write_to_cache operation.
>=20
> Additionally, for MX35{U,F}2G14AC and MX35LF2GE4AB, insertion of
> the Plane Select bit into the column address is required during
> the read_from_cache operation.

I tried to apply this patch but it conflicts with the spi-nand
continuous read series changes in the macronix driver. Would you mind
rebasing and fixing the conflicts (it's just handling correctly the
new flags)?

If you do that early next week I'll merge them right away (please
resend the two patches).

Thanks and sorry for the inconvenience!
Miqu=C3=A8l

