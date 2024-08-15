Return-Path: <linux-kernel+bounces-287929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2316952E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 635BCB24F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07841714CC;
	Thu, 15 Aug 2024 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u7ff+vnW"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303AC60B96;
	Thu, 15 Aug 2024 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725160; cv=none; b=JAZIezUDeMJyp6PZQB6Fftm6r50XID+AnLUVOPaEh01x00ak8XoSJDDYaXMeDdB5jvbvuY1iKicZrcxOaKsJ3dSAyfqLbp/eTDHiLWxjB+IzWWqgypNZpHU1CZdis8J3FUbW0pY5/ke+neHkvDA0SLkmMDXiY4eC+TGeViLhSBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725160; c=relaxed/simple;
	bh=yO/RN4+ZXbtjfCAWSgPAIXQeRmMl9DU+e9ve79qv474=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTDyWnDXGjC8qTAHk77wuykOsDWXHGt7eNrfka/L1L8D92K/50wGD4a66n7uIMhIQMVqwJGuv8ymoHa3SHYhENUX+QIzVt9d4X2Bqb7kCmOM/6HdFsGOedkaod6GsgxdWSb7ivsjxU/37z+uY/egSKHFdO8gnZbK48xo0mZLvDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=u7ff+vnW; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47FCWJE6044870;
	Thu, 15 Aug 2024 07:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723725139;
	bh=Szt5nSz+Nx/qd59yWQd8AfPh/Haf87qClselV0ALAac=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=u7ff+vnWpxaS6Sz+XbT7uEs5Ck2J8QTnzqUuMk9XkIcrR7c+Jr7/0B9XjNixTyBU6
	 QbtDND1R52Et5jHYrZaux/50IjA4/QeiXX6+sS9n9CNEdaH1XBr/bp9nyOZ5VAiR3a
	 B+87GbQDaxxNc7k/baHz3PSm2+hbLeX3BU+NFvv8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47FCWJKO111799
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Aug 2024 07:32:19 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Aug 2024 07:32:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Aug 2024 07:32:19 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47FCWJiN048024;
	Thu, 15 Aug 2024 07:32:19 -0500
Date: Thu, 15 Aug 2024 07:32:19 -0500
From: Nishanth Menon <nm@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Jan Kiszka <jan.kiszka@siemens.com>, <devicetree@vger.kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring
	<robh@kernel.org>
Subject: Re: [PATCH v2 6/6] arm64: dts: ti: k3-am65: Add ESM nodes
Message-ID: <20240815123219.ovn7hdvnhseh37bb@multiple>
References: <20240813230312.3289428-1-jm@ti.com>
 <20240813230312.3289428-7-jm@ti.com>
 <c5c378e1-e503-43e6-a5ce-1fd53da19375@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c5c378e1-e503-43e6-a5ce-1fd53da19375@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 09:05-20240814, Judith Mendez wrote:
> Hi all,
> 
> On 8/13/24 6:03 PM, Judith Mendez wrote:
> > Add Error Signaling Module (ESM) instances in MCU and MAIN
> > domains, set ESM interrupt sources for rti as per TRM [0] 9.4
> > Interrupt Sources.
> > 
> > Add comments to describe what interrupt sources are routed to
> > ESM modules.
> > 
> > [0] https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf

As mentioned[1], please update the commit message

> > 
> > Signed-off-by: Judith Mendez <jm@ti.com>
> > ---
> > Changes since v1:
> > - Add patch 6/6 for am65x
> > ---
> >   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 8 ++++++++
> >   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi  | 8 ++++++++
> >   2 files changed, 16 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > index 1af3dedde1f67..07c9f043dac0b 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > @@ -54,6 +54,14 @@ gic_its: msi-controller@1820000 {
> >   		};
> >   	};
> > +	main_esm: esm@700000 {
> > +		compatible = "ti,j721e-esm";
> > +		reg = <0x00 0x700000 0x00 0x1000>;
> > +		/* Interrupt sources: rti0, rti1, rti2, rti3 */
> > +		ti,esm-pins = <224>, <225>, <226>, <227>;
> 
> I am not sure if someone knows the answer to this question, but..
> 
> I noticed that for rti, the interrupt source id's are different
> for SR1 vs SR2, so which should be used here in k3-am65-main?
> 
> Here, I assumed SR2.

The only production board with SR1.0 that I am aware of is
arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi I think - Jan can
clarify. The technique used is to do an override in the dtsi if I am not
mistaken.

[1] https://lore.kernel.org/all/20240815122928.4i2yob5aj5ssqhzw@reply/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

