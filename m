Return-Path: <linux-kernel+bounces-262507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC1E93C7DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4873F2826E9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B2819E7C7;
	Thu, 25 Jul 2024 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="doKSRAD8"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A90826286;
	Thu, 25 Jul 2024 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721930011; cv=none; b=YjKu/hDTYkw+64cI0WhgiYOMMtSpBz04wma9CDne6V4F0AXFP4AIfSiBel5RFaNBEDzGVLqERD1A482QDh4TYi/bAbAyOT23kiPQzvFVVJRrqE8YDNI1MowkSVr4ISZ50PXecSzF7xdBh6+PEAyFujdWtjiqsqTpyZBNPj9Mmyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721930011; c=relaxed/simple;
	bh=FbVwM7m8QTCtbwcCdA/SxPGOePO5lt9nq/s1gyms9nA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lv+xSF2gQvkvGhY4CV3JZbVBvALuTfMeo/gx13vqjfg8wdXu2CsV5VGNeHj0+DL3D+sUgnwm/2m/LAM377ofxwEEX+/lphTTCt+/0gfaTcmKgKDQFw/i7bTMD20J5fLuPcQYe6ZRY90knSmcTe5Roq4qz2ExCW6YeA2za0gGf3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=doKSRAD8; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1721930000; x=1722189200;
	bh=gcI8ajkKhVCKObgb627fVTODC55s8WKdezHOuXwpvoM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=doKSRAD816Hw+j7yDOh9cdr6XNNsZxkzsoM+hMIOu1O9CYPVCJSHzBFcLdkeJ5OLA
	 JLFE0w/TtIHlHetFiZfHrxxLxKS2GVNQg2wt5g7RNrO5T1zB5VW0H76TPbQmsrNo8Z
	 g1Ua67wqNxSgJEeIylvmJ7irSnPvUNNcghdKK7KCncvYhHILQe7I2HBBcUsM4kRfKF
	 eFSgjlOXmxiGjr43X0anXncl8FAOzrYsJVzRunHukdJvtpOfWoAeLx6jfivAUXp3VH
	 3h0EzYCBdFC0SAzUaRNJQRiQRfkUV2CtsvOCb0hPzOM8PQq2hBVRa15mfa+bOLUBoY
	 pTryHj90iDWKw==
Date: Thu, 25 Jul 2024 17:53:14 +0000
To: Conor Dooley <conor@kernel.org>
From: Harry Austen <hpausten@protonmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/7] dt-bindings: clock: xilinx: describe whether dynamic reconfig is enabled
Message-ID: <D2YT8KJZ7HA8.3D38BIII4J2T1@protonmail.com>
In-Reply-To: <20240722-removal-grandma-92cfe99b8a88@spud>
References: <20240720120048.36758-1-hpausten@protonmail.com> <20240720120048.36758-7-hpausten@protonmail.com> <20240722-removal-grandma-92cfe99b8a88@spud>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 0530831d7b7240f3ad8972b03eedac85b992c716
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Jul 22, 2024 at 6:13 PM BST, Conor Dooley wrote:
> On Sat, Jul 20, 2024 at 12:01:58PM +0000, Harry Austen wrote:
> > Xilinx clocking wizard IP core's dynamic reconfiguration support is
> > optionally enabled at build time. Add a devicetree boolean property to
> > describe whether the hardware supports this feature or not.
> >=20
> > Signed-off-by: Harry Austen <hpausten@protonmail.com>
> > ---
> >  .../devicetree/bindings/clock/xlnx,clocking-wizard.yaml    | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/clock/xlnx,clocking-wiza=
rd.yaml b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> > index 4609bb56b06b5..890aeebf6f375 100644
> > --- a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> > +++ b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> > @@ -40,6 +40,12 @@ properties:
> >        - const: s_axi_aclk
> > =20
> > =20
> > +  xlnx,dynamic-reconfig:
> > +    type: boolean
>
> The type here should be "flag" not boolean, boolean can be set to
> "false" and what you're likely doing is just checking for the property
> being present. "flag" doesn't allow false.

That sounds like exactly what I want. Will update to "flag" in v2.

Thanks!

>
> > +    description:
> > +      Indicate whether the core has been configured with support for d=
ynamic
> > +      runtime reconfguration of the clocking primitive MMCM/PLL.
> > +
> >    xlnx,speed-grade:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >      enum: [1, 2, 3]
> > @@ -88,6 +94,7 @@ examples:
> >          compatible =3D "xlnx,clocking-wizard-v6.0";
> >          reg =3D <0xb0000000 0x10000>;
> >          #clock-cells =3D <1>;
> > +        xlnx,dynamic-reconfig;
> >          xlnx,speed-grade =3D <1>;
> >          xlnx,nr-outputs =3D <6>;
> >          clock-names =3D "clk_in1", "s_axi_aclk";
> > --=20
> > 2.45.2
> >=20
> >=20



