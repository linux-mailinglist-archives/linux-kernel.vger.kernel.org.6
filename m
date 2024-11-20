Return-Path: <linux-kernel+bounces-415902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C2C9D3DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E2C284832
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3981AD9EE;
	Wed, 20 Nov 2024 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fIfp9bWk"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6890916D9B8;
	Wed, 20 Nov 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732113884; cv=none; b=BMQAAmwauwLIrOrtZvFlCKv/tYaRD4VySEu0iyM8n2epcKCfj4+DKU6QKCCv3bpadj+Mu/6Q74EmP81yuVJ6kscEz0PfmXXzveK/339bCH7QG2PmiT6ElgvNYcGq6eD81CnsuUUajEntr/Md7tH3Hm6xRzJLyNVRnRTwNCiOy1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732113884; c=relaxed/simple;
	bh=5CCbvKv+VIzsR7QI6BcLoEt1IdbnLtAcVPyElZFExMU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTuZ3lm1j1HmasQ8t5O8mN1Jeo4IIKzQNui2bnSDwLkrsVso4R/RJwQdzSfER8pvcGktu2UMPVu7Bc17mUIU1X4CcUA+zlzL9b786zMlPSwLFPhKMkCgHDzTJOEsTBuMpWeI4W8dlkDer5ED0UisMO2amgePwR3ZPwCRdkRMg9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fIfp9bWk; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AKEiSh54137450
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 08:44:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732113868;
	bh=SmGRAQNzr9IbhEOimZwTw8lIUi3ybRW4Cu3nzQgFFX8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=fIfp9bWkeIRSAsrfQv74AZsEIHLWPZfK+OJ2om1FYn5//e7jYRu/zl5D/Q/G96TWF
	 uRnpksVkY2gLoy4hijKqUw6oRCsPvpenq8mr5Wedb6UXlWQH4FJpVEei/tcM3yJzgL
	 AANTEPNi/JNok7RkBsb8QtvRHlHDDlNutSvx/DkA=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AKEiSfU092708
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 Nov 2024 08:44:28 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Nov 2024 08:44:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Nov 2024 08:44:28 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AKEiSBc009121;
	Wed, 20 Nov 2024 08:44:28 -0600
Date: Wed, 20 Nov 2024 08:44:28 -0600
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am62l: add initial infrastructure
Message-ID: <20241120144428.xp5lscjl652qexd2@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20241117-am62lx-v1-0-4e71e42d781d@ti.com>
 <20241117-am62lx-v1-1-4e71e42d781d@ti.com>
 <19223ad9-1f92-4688-9efd-b6aadb250d9d@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <19223ad9-1f92-4688-9efd-b6aadb250d9d@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On November 18, 2024 thus sayeth Andrew Davis:
> On 11/17/24 11:34 PM, Bryan Brattlof wrote:
> > From: Vignesh Raghavendra <vigneshr@ti.com>
> > 
> > Add the initial infrastructure needed for the AM62L. All of which can be
> > found in the Technical Reference Manual (TRM) located here:
> > 
> >      https://www.ti.com/lit/ug/sprujb4/sprujb4.pdf
> 
> We usually use the non-direct links, that way they can be updated
> to the latest, so here and everywhere below:
> 
> https://www.ti.com/lit/pdf/sprujb4
> 
> Also might be good to get the TRM folks to now drop the
> "Confidential NDA" watermarks..
> 

That's a good point. I'll use the non-direct link

..

> > +		 cbass_wakeup:  bus@43000000 {
> 
> Some odd whitespace indent here and below in this node.
> 

Nice! I'll fix this up in the next revision

~Bryan

