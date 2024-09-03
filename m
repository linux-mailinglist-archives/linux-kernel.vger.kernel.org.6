Return-Path: <linux-kernel+bounces-312445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A579696B5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35AB2831D9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1299B201256;
	Tue,  3 Sep 2024 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kYE/ijij"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E922519C562;
	Tue,  3 Sep 2024 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351371; cv=none; b=IgXmecR4srzohG7zgkGfPC6/wAZYaQkjjn+mUtLiWxYMAl1iRM+wV1SXdREPaEZp4JGZh4eTbysbGEJnvXnXleMTLK0Yj/zH6+vLHGtvRRQZs/pkNUOy/6DmNyiQ+lQntbcriByai3OrggqxiPJuTXf6Xmwo68KpV1SC/hngbiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351371; c=relaxed/simple;
	bh=Lcee6+sOVA87hrJeKC4oisQYXFgVo1X5IP6lYlxWxNE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6jgYmZh3H3yiPHsfoZCYGnOZNHqt99hkiEGZfX0lmuxO7K4cyskNM7haLkTmtEoZHNQFuCtYs9Yf5JRHBwBDDGaMAZjn+gEJtALmqGrLacyUxXbC5bbMBrgXdVkq+LTOm/FR2wbG6tkbZ3JEewhed/b3CngmQRinPCC4M2/kEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kYE/ijij; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4838G3PA050684;
	Tue, 3 Sep 2024 03:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725351363;
	bh=JXEDvySkzYxZUupzmkZp26uSUZx+30Vm4A8Rk8NYurs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=kYE/ijijR3CjOACnLU2dqSIH+sBRMmbt4kdsc9Uwry5KQovl+0zwEijWAf9VMcfeD
	 nET8G60zHbImZzTVmeNaCQoEbtADtWqgzj7l247sVPwZOshNr+lSGUgNoMaf1v4tvI
	 oyXFQY4LKY4IQBn1uzpX+bJ9W4uwPLI8NRtB1emo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4838G3bj025888;
	Tue, 3 Sep 2024 03:16:03 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 03:16:02 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 03:16:02 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4838G1Wd066175;
	Tue, 3 Sep 2024 03:16:02 -0500
Date: Tue, 3 Sep 2024 13:46:01 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi
	<b-padhi@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v6 2/5] arm64: dts: ti: Refactor J784s4-evm to a common
 file
Message-ID: <20240903081601.msfrnt77otpahjxi@uda0497581>
References: <20240902-b4-upstream-j742s2-v6-0-6a7aa2736797@ti.com>
 <20240902-b4-upstream-j742s2-v6-2-6a7aa2736797@ti.com>
 <4avtzi22ue6nfusdrvyl2x3apwjgmuwa246qu5kh2dk2fdb4si@hka6nygye75z>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4avtzi22ue6nfusdrvyl2x3apwjgmuwa246qu5kh2dk2fdb4si@hka6nygye75z>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Krzysztof,

On 08:39-20240903, Krzysztof Kozlowski wrote:
> On Mon, Sep 02, 2024 at 05:56:50PM +0530, Manorit Chawdhry wrote:
> > Refactor J784s4-evm to a common file which uses the
> > superset device to allow reuse in j742s2-evm which uses the subset part.
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > Reviewed-by: Beleswar Padhi <b-padhi@ti.com>
> > ---
> > 
> > Notes:
> >     v6:
> >     - Rebased with conflicts
> > 
> >  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           | 1488 +------------------
> >  .../boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi   | 1490 ++++++++++++++++++++
> >  2 files changed, 1497 insertions(+), 1481 deletions(-)
> >
> 
> It's impossible to review this. You need to use -B/-M/-C arguments when
> creating patch.

Apologies, have resend the series with the following change [0]. Hopefully
it will be more readable now.

Regards,
Manorit

> 
> Best regards,
> Krzysztof
> 

[0]: https://lore.kernel.org/linux-devicetree/20240903-b4-upstream-j742s2-v6-0-49d980fed889@ti.com/T/#t

