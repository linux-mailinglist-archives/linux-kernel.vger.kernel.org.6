Return-Path: <linux-kernel+bounces-344440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC4498A9A4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F17B2285B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502A0192D68;
	Mon, 30 Sep 2024 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TNh0q6+s"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A7191F74
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713363; cv=none; b=e5GK3LcPr+WJI06sCRmaX1NJNJWPjjPzr+tfx7sDlBjmjH/p5z1FAgaeyowXk5b2yl/GWH5Dki7H1ob69UBYapYun47dDwwfgddnOHmIWfXJOvVJ7ZaGbnWoWMOP3VcXufnybALnBzRxY4P20vcNvaoX1W3GecPy+HvR5lDMCHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713363; c=relaxed/simple;
	bh=wuLXXsvmGa6Wkqbw9wJKACQvYoepo61CtgILGgO62tA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ge2hTl/wT3XM0VPeTmHSG+UQ0HTF9078Z+QuPGaRI0JVr2xaqZ1eervsmQbcXx6Y6hJdbTfjaKBEtSw/8dA8ANpDrutMQWjDbZsRmYM0spW4uJV4sJFUiiyOiwKYvsb7bWFwfCXPx5LCpodDJ4UAsQhi9UTmG6LOgjF7Onmtg+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TNh0q6+s; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52682C0003;
	Mon, 30 Sep 2024 16:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727713359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkPKgnAgbGFe7mgt13GeZjNd77h1Yl8R02uaedeP1eM=;
	b=TNh0q6+swvpWa7Kb1FK9mnp3NW5W/cAfiyiul6aouZrXgxzid52LiI0OcY1d7yKbQqEkpj
	CKgyGH8w4GbAH3xJJMwse4hwQpd46Ukc0Dp2DLEs0OAoBA2gWOaM1O7OKEBu93GkXqxreP
	ctvGTUFLt7hNmedORp2+u5AkCtjk1jDMhVYpgayxNx3WlN0sqBmvKykkv/sXb++1ekRLhU
	LeUdwMI7oMXhMVJstQZ3JqKFUueP0UVCVqW8QGcDcr+Prga7ujgdPvCHtLzqXiSNKplZ3K
	l9hq9QrULDN8qYb4tcwcQq0H+dl6SEUK6k07QAxsiVyudfXJbIjCJWR9Xe1Icg==
Date: Mon, 30 Sep 2024 18:22:35 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: alexandre.belloni@bootlin.com, arnd@arndb.de, bbrezillon@kernel.org,
 boris.brezillon@collabora.com, conor.culhane@silvaco.com,
 gregkh@linuxfoundation.org, imx@lists.linux.dev,
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
 pthombar@cadence.com
Subject: Re: [PATCH v2 1/1] MAINTAINERS: I3C: Add Frank Li as nxp I3C
 controller driver maintainer
Message-ID: <20240930182235.52c4530e@xps-13>
In-Reply-To: <Zt9VDJ546znNR7AT@lizhi-Precision-Tower-5810>
References: <20240815141609.4089406-1-Frank.Li@nxp.com>
	<Zt9VDJ546znNR7AT@lizhi-Precision-Tower-5810>
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

Frank.li@nxp.com wrote on Mon, 9 Sep 2024 16:05:32 -0400:

> On Thu, Aug 15, 2024 at 10:16:09AM -0400, Frank Li wrote:
> > Add Frank Li as NXP i3c controller driver as maintainer and add mail li=
st
> > imx@lists.linux.dev for it.
> >
> > Add Frank Li as I3C subsystem reviewer.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > --- =20
>=20
> Miquel:
> 	Any comments?

I guess we'll happily take your feedback on patches targeting the SVC
driver, you've been working a lot on it. However, in general there has
been a lot of discussions happening on your substantial patchsets and
little to no convergence in the end. I understand you want to push your
patches upstream and I also want to make things move forward, but maybe
one of the reasons for the stalls is the lack of fluent exchanges
between us and the difficulty to explain bigger pictures in a clear
way. I believe maintaining a subsystem still requires a bit more
experience on this regard.

Thanks,
Miqu=C3=A8l

