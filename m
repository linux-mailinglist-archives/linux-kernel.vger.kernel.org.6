Return-Path: <linux-kernel+bounces-256168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F26B4934A32
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8B941F255B9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242037E576;
	Thu, 18 Jul 2024 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rLiF7O9f"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03322745F4;
	Thu, 18 Jul 2024 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292314; cv=none; b=SjU8qSSbWZ3QqU0V0qmvB1zGDmJbvrGIa9jV/wJBky2rAfjoY7P0+wBzN7BJmiBZuRbtNw/NS86U/AWrLgPQszy99rGYVwPoEylTAoL7H6H14mWD/oRBFxeeoxfRGHRqdGT5uYW5RTBVcKINA0I/uOROjrP2BIlqYryfNVstzOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292314; c=relaxed/simple;
	bh=fkCywxD3okS1KYREw38tF1DYuPRi9L2ZeQTfpycQs3U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pBngoFZUxjaVtuBw+OJDgbJB86HOM9iM3NYxDhcbD3Znha8SWfv5GF23VI8+PQ/jsnbMQl0mXRx0CCvrPGmW5dmtE0KCP+BImrQ+7cc7XTbw9L6ALLs8YFU5M8knpf9WvIegX4QhkS2/BJtz6dY92v7PYGZZZAvkdl3CqrN+C1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rLiF7O9f; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721292311;
	bh=fkCywxD3okS1KYREw38tF1DYuPRi9L2ZeQTfpycQs3U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rLiF7O9fmaFWzbFQdiQyoRcpH9TaxgcAct7wegDUE+I3wTVmk35/m15OAschwhYpH
	 DbXTMAwcMyeI+w4TwsSNYRldxwxCgB3jz3wRrpX7d1ycz6Y1YO+Q3dpuF+mYBE7Rnq
	 Qlaz49lNlj+KkgbKdWLX3cuUSU5SyctiqacNBIZFl16vgsvFlmwoZxm9En4db9pgi0
	 p572Ix5/w8tpjTDTlXQS73XqXheAy11TWgOb7VG9BSvlpZzlDkvsSXzJEM551TNbGD
	 JQBaBUSrAzDP2ePnicoVymKTS47aL5qFb/qf20ROAz+5Q2SqDGepAJifocY+EuLt7F
	 qaKrn3bsj/jqA==
Received: from [100.77.12.232] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: obbardc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7F4913782167;
	Thu, 18 Jul 2024 08:45:10 +0000 (UTC)
Message-ID: <7dd789fb26817a8f752b6b0e8224b2ddf7293156.camel@collabora.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: rockchip: Add Firefly
 Core-PX30-JD4 with baseboard
From: Christopher Obbard <chris.obbard@collabora.com>
To: Dragan Simic <dsimic@manjaro.org>, Conor Dooley
 <conor.dooley@microchip.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,  linux-kernel@vger.kernel.org, Kever
 Yang <kever.yang@rock-chips.com>,  Collabora Kernel Mailing List
 <kernel@collabora.com>
Date: Thu, 18 Jul 2024 09:45:09 +0100
In-Reply-To: <6ed3e6c6b74ddba1bca1a719dfdf3ac4@manjaro.org>
References: <20240717-rockchip-px30-firefly-v2-0-06541a5a5946@collabora.com>
	 <20240717-rockchip-px30-firefly-v2-1-06541a5a5946@collabora.com>
	 <0c804e9a0227904b16bfb779f2009af1@manjaro.org>
	 <e34f1a0a81de24437be7f582c719d3f128d44b51.camel@collabora.com>
	 <20240718-lapped-suffocate-0216bad82c68@wendy>
	 <6ed3e6c6b74ddba1bca1a719dfdf3ac4@manjaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dragan,

On Thu, 2024-07-18 at 10:43 +0200, Dragan Simic wrote:
> On 2024-07-18 10:34, Conor Dooley wrote:
> > On Thu, Jul 18, 2024 at 09:31:45AM +0100, Christopher Obbard wrote:
> > > Thanks for the review.
> > >=20
> > > On Thu, 2024-07-18 at 06:36 +0200, Dragan Simic wrote:
> > > > Hello Christopher,
> > > >=20
> > > > On 2024-07-17 18:46, Christopher Obbard wrote:
> > > > > Add binding for the Firefly Core-PX30-JD4 SoM when used in
> > > > > conjunction
> > > > > with the MB-JD4-RK3328 & PX30 baseboard.
> > > > >=20
> > > > > Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> > > > > ---
> > > > > =C2=A0Documentation/devicetree/bindings/arm/rockchip.yaml | 6 +++=
+++
> > > > > =C2=A01 file changed, 6 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > > > > b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > > > > index 1ef09fbfdfaf5..33ca8028bc151 100644
> > > > > --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > > > > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > > > > @@ -148,6 +148,12 @@ properties:
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - co=
nst: engicam,px30-core
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - co=
nst: rockchip,px30
> > > > >=20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Firefly Core-PX30-=
JD4 with MB-JD4-PX30
> > > > > baseboard
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
firefly,px30-mb-jd4
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: =
firefly,px30-core-jd4
> > > >=20
> > > > Similarly to how I suggested the new dts(i) files to be named, [1]
> > > > the model names should be named like this:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - cons=
t: firefly,px30-jd4-core
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - cons=
t: firefly,px30-jd4-core-mb
> > >=20
> > > I suppose the order should be the other way around to match other=20
> > > entries, e.g
> > > firefly,px30-jd4-core-mb first?
> >=20
> > Yes. Mainboard first, then som, then soc.
>=20
> Ah yes, sorry, I somehow managed to get the order wrong.=C2=A0 Basically,
> it goes from more specific to less specific.

Right, I thought so and was just double-checking ;-).

