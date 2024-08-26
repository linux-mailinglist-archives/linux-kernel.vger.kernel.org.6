Return-Path: <linux-kernel+bounces-301867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA6A95F6A8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC031C208CA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB742194AF4;
	Mon, 26 Aug 2024 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E1XI13bh"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677441946A8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690156; cv=none; b=XRM5u2hgLuOTLJB3ikxjdVLAApRo6pkbhkxOB6c24RWyXIJqTBP2oiKGCbbUYR3kRJgi3YVorflmwp0ImI/6nY7weqGYb3q96G3g4x7xrKWTA9nn3FPmM/1fF/nfd5aGZLK0Zeqtre3fMH0mMy090a6pHWnHA2VNKrYfuPV0j3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690156; c=relaxed/simple;
	bh=1Fp7vCAVfUq6/YbsJlztZq0VRK/XwicwkPHvc4kaONY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAbe+AWS6J2RjqcDta5c4TYo+ioOOskR38LkgDBUxccu6PSebOLc/L1JVUk8gTTfe4R5ih0eXRQ9deGZC9x4ZWjUKDIga9lJfFpdBO3ssie2EsCexcGemLshz9S+/1CpwxZGqCodEoLNhPoSXQE/JwrqwWI1XqrjLXPkfF1h/IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E1XI13bh; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BE7B1C0006;
	Mon, 26 Aug 2024 16:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724690151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Fp7vCAVfUq6/YbsJlztZq0VRK/XwicwkPHvc4kaONY=;
	b=E1XI13bh+XFuTg45imTzbBhWhln/cSeAgaMkOQQ0awFH2PxIP4F53XWkT84zKWnZVUlVxL
	/FINkvp+c48A1Qe1wfmnY92XZ5bOdbeypcE/fF7J+Iu79RZsCgbP7j0JuPVgxOsoGhKPqP
	3SLgCxu97x3ct0bF0OQeSUCR4nUqUND5GNuChxwdMyr+c8PWFbetwbudreNZwc+HX4Wher
	NrOZPPZKznuY0GD/fg1I4la3AV38Bt/4+2fAs+8pg+i0u7IDycMLV0/lXYqqE71269F75Z
	5WjoqBwNBDPOqjauuVHbYGPGPULMuUxafk8qCVQQPoV0UsF7r4K24ZTd7uCdVA==
Date: Mon, 26 Aug 2024 18:35:50 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: carlos.song@nxp.com, alexandre.belloni@bootlin.com,
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-imx@nxp.com
Subject: Re: [PATCH v3] i3c: master: support to adjust first broadcast
 address speed
Message-ID: <20240826183550.39d36e0e@xps-13>
In-Reply-To: <ZsynnIWGIlmWPdzW@lizhi-Precision-Tower-5810>
References: <20240826050957.1881563-1-carlos.song@nxp.com>
	<20240826101323.746b617c@xps-13>
	<ZsynnIWGIlmWPdzW@lizhi-Precision-Tower-5810>
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

Frank.li@nxp.com wrote on Mon, 26 Aug 2024 12:04:44 -0400:

> On Mon, Aug 26, 2024 at 10:13:23AM +0200, Miquel Raynal wrote:
> > Hi Carlos,
> >
> > carlos.song@nxp.com wrote on Mon, 26 Aug 2024 13:09:57 +0800:
> > =20
> > > From: Carlos Song <carlos.song@nxp.com>
> > >
> > > According to I3C spec 6.2 Timing Specification, the Open Drain High P=
eriod
> > > of SCL Clock timing for first broadcast address should be adjusted to=
 200ns
> > > at least. I3C device working as i2c device will see the broadcast to =
close
> > > its Spike Filter then change to work at I3C mode. After that I3C open=
 drain
> > > SCL high level should be adjusted back.
> > >
> > > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com> =20
> >
> > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >
> > Frank, did you test it with eg. the Silvaco master? =20
>=20
> This problem only existed on one board with specific i2c devices. I have
> not such boards in hand. Carlos work closely with me and tested by our te=
st
> team.

I understand you may not experience the problem, but the solution must
not disturb setups without the problem either. That's why I was asking.

Thanks,
Miqu=C3=A8l

