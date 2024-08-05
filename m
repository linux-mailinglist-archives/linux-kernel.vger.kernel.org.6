Return-Path: <linux-kernel+bounces-274496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 157F39478D3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465681C20E25
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E1215351B;
	Mon,  5 Aug 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UH7X6rAo"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00CE137C37
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722851986; cv=none; b=AXitYAKcw9tSGI9H54BvarGEkYUHJ7uwHQ+Pxw/THvwUs03JhGLHZujkq5H8hz4cXOH4EXMRERvRMYDjVKlcLIeAmfg+kw11LIzs8GHmJsHLqSK/7/kl6/MwN47Q9K+/UTgi/9PlnwhbwEfoB60b7q9FzelO4vRp6/UMyvzR0/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722851986; c=relaxed/simple;
	bh=OSzCM2GQ5Hw2DrAX7W1sM8eSrBx1ah8GOrHNX7yHRoM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5DbDnhv4205IIbP5IntRR7Sxza96bmt2M+2T0jqA4DClamrZu1vggcFFLT5B5bfrEyaG0YVyVctYivI0q0yeeVDFsok770JNxlBlUWZPAEAkXGJ+/+Vtha6McaQLOzdhvfR1Aq2t+vR8mL9RuvsnCrWNAFbho/knQD8r+4dnl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UH7X6rAo; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4759xUSg078589;
	Mon, 5 Aug 2024 04:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722851970;
	bh=3rtJY+6qU4cO9BoI/EfcOK26NGFpLzHMQaxOKgKpC3Q=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=UH7X6rAoa8wPzGo1zK48wzenSZhFTz+z256LhYaPmQTIkSwAHfWePWp6d50TOTaX8
	 H4HhD8ImNNZ+gH9qe6oTmYzdv/XopC7ghFOFPPXVs6h/W02w6oh3MB97rfuhbD+jlu
	 rgJdYFjVsx26vwzVO/Md1VEdkGOkuml8Y22dufuk=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4759xUQj084019
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Aug 2024 04:59:30 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Aug 2024 04:59:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Aug 2024 04:59:30 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4759xTnN049991;
	Mon, 5 Aug 2024 04:59:29 -0500
Date: Mon, 5 Aug 2024 15:29:28 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Vinod Koul <vkoul@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <kishon@kernel.org>,
        <p.zabel@pengutronix.de>, <sjakhade@cadence.com>, <rogerq@kernel.org>,
        <thomas.richard@bootlin.com>, <theo.lebrun@bootlin.com>,
        <robh@kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH v3] phy: cadence-torrent: add support for three or more
 links using 2 protocols
Message-ID: <d2329736-9697-4d73-b2d2-2b83c129221d@ti.com>
References: <20240716102442.1605280-1-s-vadapalli@ti.com>
 <Zq-15_enK919eUg_@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zq-15_enK919eUg_@matsya>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Sun, Aug 04, 2024 at 10:39:59PM +0530, Vinod Koul wrote:
> On 16-07-24, 15:54, Siddharth Vadapalli wrote:
> > The Torrent SERDES can support at most two different protocols (PHY types).
> > This only mandates that the device-tree sub-nodes used to represent the
> > configuration should describe links with at-most two different protocols.
> > 
> > The existing implementation however imposes an artificial constraint that
> > allows only two links (device-tree sub-nodes). As long as at-most two
> > protocols are chosen, using more than two links to describe them in an
> > alternating configuration is still a valid configuration of the Torrent
> > SERDES.
> > 
> > A 3-Link 2-Protocol configuration of the 4-Lane SERDES can be:
> > Lane 0 => Protocol 1 => Link 1
> > Lane 1 => Protocol 1 => Link 1
> > Lane 2 => Protocol 2 => Link 2
> > Lane 3 => Protocol 1 => Link 3
> > 
> > A 4-Link 2-Protocol configuration of the 4-Lane SERDES can be:
> > Lane 0 => Protocol 1 => Link 1
> > Lane 1 => Protocol 2 => Link 2
> > Lane 2 => Protocol 1 => Link 3
> > Lane 3 => Protocol 2 => Link 4
> > 
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> > 
> > Hello,
> > 
> > This patch is based on linux-next tagged next-20240715.
> 
> Sorry this does not apply for me on phy/next, can you rebase..?

Thank you for pointing it out. I have rebased this patch on linux-next
tagged next-20240805 and have posted the v4 patch at:
https://lore.kernel.org/r/20240805092607.143869-1-s-vadapalli@ti.com/

Regards,
Siddharth.

