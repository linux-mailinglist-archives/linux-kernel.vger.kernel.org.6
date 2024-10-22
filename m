Return-Path: <linux-kernel+bounces-375820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9FA9A9B43
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CDC280D8B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4098B1537D4;
	Tue, 22 Oct 2024 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Mc16479E"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9951152160;
	Tue, 22 Oct 2024 07:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582784; cv=none; b=mqH+FIi/gracSy6hV5e8pslMM3AtMuAVNx9LNsBeHWahs4xhTLEY5Ch9YViqgj7h/iLl01R0gu4gIT7+YlLv0x0ggweyv4wMO1RnXpMVeRn1tsXKoqs2FJhUYCS4ZjpsugM6JGekhBFTZXRwveBuKjkGiZQ/CjzuEe+g7Yofpac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582784; c=relaxed/simple;
	bh=JUJtOjX8WrkydJRiayG41HrNu1QMLDBSiTFxj+wZCxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5lNGoSAhINf6r9AOWKYdgb/KbktAjt/IScb/fFiBIQGV46p7YHIaea4Jn9V0zmyG8D7PTv81cCm4TfXXYu6anrd1eo5aZJK62aj+Fb2HMyzLxiaO6JQlbpvAxrzJ2f2WUKrb6pt9DwTlmlEbdXPtenLKtIF5W8zhrBixL24jdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Mc16479E; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 689761F971;
	Tue, 22 Oct 2024 09:39:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1729582778;
	bh=CnUlap5WY75ud22hgLFtn6SDdRG78b20CRAVWfPmZ1M=;
	h=Received:From:To:Subject;
	b=Mc16479EnZrrktDlnQQ2r8HsMHVcjKrSJOM57bjXQmL6uzUaqxg4cLVtLYudrFqRC
	 sKC7/VFrYG3QAaTTiKWqLmuGPdCKkDXOkzNcQHrv7AWq/NQuGmzlG7/UN5x3AqYVrf
	 PgPWjFDBOKr3RvDFIoFjWpmbxvs1tgcSiYJxbCLXMnS1hMUbVSBn8RP4gR/dZbVfUm
	 maA9ZQfLTZZTAvNCiLkDeMwyTzz04WyRop/Wgb1S7b1XB9jxuqbQNFaoZYs++CvBVD
	 ES/nl4/hEGtkTAdFhK3nCJki9G5IV4DlkilU4YPH7x9EKRMIPXxoE5oplMtCOcnTCk
	 4mnnBMIhX23ug==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 0D22B7FA28; Tue, 22 Oct 2024 09:39:38 +0200 (CEST)
Date: Tue, 22 Oct 2024 09:39:37 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Carlos Song <carlos.song@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	Frank Li <frank.li@nxp.com>, Bough Chen <haibo.chen@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: imx7s: change i2c compatible string for
 applying errata ERR007805
Message-ID: <ZxdWuUZ4EQfUJw1H@gaggiata.pivistrello.it>
References: <20241021031148.2682015-1-carlos.song@nxp.com>
 <20241021092743.GA21104@francesco-nb>
 <AM0PR0402MB3937F54EF17F80B80A77DE07E8432@AM0PR0402MB3937.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR0402MB3937F54EF17F80B80A77DE07E8432@AM0PR0402MB3937.eurprd04.prod.outlook.com>

On Mon, Oct 21, 2024 at 10:07:23AM +0000, Carlos Song wrote:
> > From: Francesco Dolcini <francesco@dolcini.it>
> > 
> > On Mon, Oct 21, 2024 at 11:11:48AM +0800, carlos.song@nxp.com wrote:
> > > From: Carlos Song <carlos.song@nxp.com>
> > >
> > > Compatible string "fsl,imx7d-i2c" is not exited at i2c-imx driver
> > > compatible string table, at the result, "fsl,imx21-i2c" will be
> > > matched, but it will cause errata ERR007805 not be applied in fact.
> > >
> > > Replace "fsl,imx7d-i2c" by "fsl,imx7s-i2c" compatible string in dts
> > > file for appling the errata ERR007805.
> > 
> > Did you considered changing the driver instead? If I understand this correctly it
> > would be a better solution.
> 
> This errata fix patch has been applied on i2c-imx.c driver: 39c025721d70 i2c:
> imx: Implement errata ERR007805 or e7805 bus frequency limit
> 
> The patch commit log says: this errata is found on all MX7{S,D},
> MX6{UL{,L,Z},S{,LL,X},S,D,DL,Q,DP,QP} and MX8M{M,N,P,Q}.  So imx7d and imx7s
> both needs this errata fix. "fsl,imx7s-i2c" was added into compatible string
> table in the i2c-imx patch, this is the patch diff snap.  So when
> "fsl,imx7s-i2c" is matched, the arrata fix will be applied.

It is clear what you did. What I wrote is that IMO it's not the correct
solution.

Kernel and the FDT can be updated indipendently, with the FDT being part of
the firmware, and you should not expect people to update the FDT to fix
an errata that is implemented in the driver.

My suggestion is that the errata should be applied in the driver to both
compatibles, and such a fix should be backported to stable kernel.

Francesco


