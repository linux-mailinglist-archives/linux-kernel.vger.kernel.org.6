Return-Path: <linux-kernel+bounces-208799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E289902948
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5886B227B9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B0A2230F;
	Mon, 10 Jun 2024 19:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HVFUtOwG"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E1215A8;
	Mon, 10 Jun 2024 19:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047844; cv=none; b=m+Bz0vPdSHHsixBzalpJtITfpzIwSj6yRKmMqh2ac56N5YGdz/alZmCwiafckQ6CgpJShXMjUYFlGggr49wbMXO69dnNszYtoG+norYc161+B8pXXtad1DEuK+JBgti+l3P/0oA0WXDqfXVqMapwvrqrqXgfDxV0fvELfILwLP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047844; c=relaxed/simple;
	bh=QNo/Hi+24ofyIL/ZiJqEl6sZHnzgkMG8cAmo6Kt4Ai4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tG3fkRxQdHYT818dmF7V9BVRHER16e24P6KNSrzyATXoo17fgqLfpcYb1u+BPWRhpGNIBpalfjDax1Qo3PIm84l18+HEe+tZjRYLB1bdj4Qi+80ULgmTrOC3iS9B93Z1v3H8QrjJNFyRCwCoO0hQGQLa1YbV+hKlvtoYd19Mm04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HVFUtOwG; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45AJUGhS097546;
	Mon, 10 Jun 2024 14:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718047816;
	bh=hW6VCMkxCCGg6hLZeTeC/jrZH1rZBd54xaTw67pHzdU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=HVFUtOwGAHHa1OaI7U5McdTKy6kaGY3xz1HHpSA4ED0rpJXxtAHeA7u1algi/tyCu
	 F+zxPgD2K774huKmrGcTRXS5hjiPwdei2xf2JvHIezdD/acYmiTMMuvHqBKn/Kdfpy
	 kUAsLXoAwwaztcBKOf7ruBICfEKT/185lyur34wk=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45AJUFRf073656
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 14:30:16 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 14:30:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 14:30:15 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45AJUFNB021618;
	Mon, 10 Jun 2024 14:30:15 -0500
Date: Mon, 10 Jun 2024 14:30:15 -0500
From: Bryan Brattlof <bb@ti.com>
To: Hari Nagalla <hnagalla@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] arm64: dts: ti: k3-am62a7-sk: Enable ipc with
 remote proc nodes
Message-ID: <20240610193015.flfynlomz6gzwbx6@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240605124859.3034-1-hnagalla@ti.com>
 <20240605124859.3034-5-hnagalla@ti.com>
 <20240606171620.h3twptxb5mrxbqxh@bryanbrattlof.com>
 <e820d497-9327-8d8b-d1b2-7f6707e593aa@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <e820d497-9327-8d8b-d1b2-7f6707e593aa@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On June 10, 2024 thus sayeth Hari Nagalla:
> On 6/6/24 12:16, Bryan Brattlof wrote:
> > > +
> > > +		c7x_0_memory_region: c7x-memory@99900000 {
> > > +			compatible = "shared-dma-pool";
> > > +			reg = <0x00 0x99900000 0x00 0x01efffff>;
> > > +			no-map;
> > > +		};
> > >   	};
> > This seems highly specific to the demos we're currently running for our
> > reference boards. If someone wants to develop their own app say with
> > Zypher they would instantly need to change this.
> > 
> > If these absolutely need to be in here could they go in a TI-demo overly?
> > 
> > ~Bryan
> Hey Bryan,
> You are correct, these carveouts match the TI provided firmware binaries.
> Ideally, these could go into an overlay. Just following the carveout model
> used with the rest of the TI SoCs (AM6x/J72x), to avoid confusion to the
> users.

Ah yeah, I was planning to rip those out too ;) 

My idea was to throw them into our SDK layers so that other distros 
don't have to work around them anymore. This also gives the maintainers 
of those meta- layers the control of the reserved-memory{} node so they 
can carve it up or move it around as they need along with the firmware 
they build.

~Bryan

