Return-Path: <linux-kernel+bounces-311978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9A7969049
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 01:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E76A2B26AA6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 23:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F75B18800D;
	Mon,  2 Sep 2024 22:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIErJMG7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6361E188007;
	Mon,  2 Sep 2024 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317963; cv=none; b=h/W8Ntka/fBAAfJt8ytGaklDTQ39Zx2EspmT1JMaYA6/U/tCv8yzH+6wEwTlwYyDo32y7Wc+w93visXNZ9g3XexbhVagoIyP+e5AmsMNx8+zpYTBf9d6nanwbAzO4fzuTCHv+KSHvuiSZQeetHlwEHPNv2fR4Z78S0813mB0Fmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317963; c=relaxed/simple;
	bh=Km/6KlnmQOWJjXq++Cne0pmAvoAL3JA6Ik/pIQ5aMsc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KlHIw9IZzez4JYiYkLf5oX2eX25TcNAnmyOWnqhru2nKeN3SVPWYNLCuj5rcjULfcLAms8SqGM1u8AfAszOq1XCaxY2snEvT5edRtMLF8tXumXsCJ9lQRUofA2P6luL0OHRa6rMM+ud7Tn/p1hQPjCyQxY8nKiEL8OJjHaH+Auc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIErJMG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C12C4CEC2;
	Mon,  2 Sep 2024 22:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725317963;
	bh=Km/6KlnmQOWJjXq++Cne0pmAvoAL3JA6Ik/pIQ5aMsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AIErJMG7cKzgaRygrtjzs5mL/pC6veeZwCogVHvV/WBtBT/cKLnuDR62hPgSMcBe8
	 /yuQvKlu7eI5fNCDD4J/dgkzx3ooEmujnp/daGOhR5v+4eVZtVVrMG6e2PG0iFSRZF
	 NIrYhg19ylgXYLM2wQvCc4o/jRlPuA9dEeuQ9jUM3iaLWlUG5Nz2p9/Gke8q0PWRiS
	 gkFDR8G5EB7ytWVL5yqqdSrm6GfhVY2FI1lTb/B4Wd7W2cvFQPmCDCXe7szd35TzKm
	 tlnvY4CVN8T/3+7HoZ8o1Y5GcnDRVLLdtp21+GlcY5VliDWak3j8Yi1r0hUiRotEtK
	 IByHh8ZKne3NQ==
Date: Mon, 2 Sep 2024 17:59:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v8 01/11] PCI: imx6: Fix establish link failure in EP
 mode for iMX8MM and iMX8MP
Message-ID: <20240902225921.GA232316@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtZBeL6LqpIKseXc@lizhi-Precision-Tower-5810>

On Mon, Sep 02, 2024 at 06:51:36PM -0400, Frank Li wrote:
> On Mon, Sep 02, 2024 at 04:12:40PM -0500, Bjorn Helgaas wrote:
> > On Mon, Jul 29, 2024 at 04:18:08PM -0400, Frank Li wrote:
> > > From: Richard Zhu <hongxing.zhu@nxp.com>
> >
> > Maybe "iMX8MP" in this subject should be "i.MX8MP" as in the subject
> > of the next patch?
> >
> > And if so, maybe it should be "i.MX8MM" here, too?
> 
> i.MX8MP and i.MX8MM is more formal. Many other place in kernel tree also
> use iMX8MP and iMX8MM.
> 
> Do you need me repost it?

No, no point it that, we can tidy that easily.

Same for the stable tag, we can add that.

