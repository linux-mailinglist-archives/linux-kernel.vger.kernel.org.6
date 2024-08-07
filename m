Return-Path: <linux-kernel+bounces-277679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B5C94A4B3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12356B25611
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8180A1D1753;
	Wed,  7 Aug 2024 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="anSb2QOn"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCA31C6899;
	Wed,  7 Aug 2024 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024084; cv=none; b=DXTpeIlawW9IedIH8OLyIc0dNYbTsw1pihNozG5PTcRWRv5Ri6qgUrQotP8YCe3VOYlrhNryfZoJV0zW1sVdLNSS+dg+LO8spVuuoFzFBsv6xD/Gcs5WZEUWzn2M0Pc7AkorvY9LgfGVbqJZCMPztK62qWVxRkVdBkh/kMSg6qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024084; c=relaxed/simple;
	bh=UoFTPkKTSOCKq8g9bA4LwsqiNPZVmB33G4kIY9zxgX8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnIh3MgaOpGGmZYUvzYSvgcQgZX70hyY64A4QCxg6RbE6NN+bGLjacdlMl0cafIrPkRCfzIhc99wXbelQetDvWEp2TY1ZIxq52f0rlEVRgKjlGxlQabwJU/xI/vQHs6fE0g09RFpI89KDjZYkm4u36OK/Tk3yEg/APVbpYm1nVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=anSb2QOn; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4779lpZg092058;
	Wed, 7 Aug 2024 04:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723024071;
	bh=vvwK4OT4Sp643RTDXo69Y1qShjPxCrk6ghZjjrAeEP0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=anSb2QOniTJnYkhAngYdYoZsRSKHN1vs6YO/LQ0VQUpWxEM4nn+JIvP8kkCCzyjJZ
	 ZRgQrvfIJ9OQJQV69cmuc18UHEPN0uSIwrFSFz+dIATh1ATP3KGEkqjvomQnMPJudJ
	 LcbiGrau7pE+cKpaHSbdF0vwmcLnz+LcuTEzducA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4779lp9F014664
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 04:47:51 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 04:47:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 04:47:50 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4779loDO048866;
	Wed, 7 Aug 2024 04:47:50 -0500
Date: Wed, 7 Aug 2024 15:17:49 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Aniket Limaye <a-limaye@ti.com>,
        Udit Kumar
	<u-kumar1@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>
Subject: Re: [PATCH v3 4/5] arm64: dts: ti: k3-j721e*: Add bootph-* properties
Message-ID: <20240807094749.3fmaxjdptw43adem@uda0497581>
References: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
 <20240730-b4-upstream-bootph-all-v3-4-9bc2eccb6952@ti.com>
 <81c14a3e-cdea-4367-8955-df7f2dbd2dce@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <81c14a3e-cdea-4367-8955-df7f2dbd2dce@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Neha,

On 14:54-20240807, Neha Malcom Francis wrote:
> Hi Manorit,
> 
> On 30/07/24 15:23, Manorit Chawdhry wrote:
> > Adds bootph-* properties to the leaf nodes to enable U-boot to
> > utilise them.
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >   .../arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 20 ++++++++++++++++++++
> >   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi            |  2 ++
> >   arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  9 +++++++++
> >   arch/arm64/boot/dts/ti/k3-j721e-sk.dts               | 18 ++++++++++++++++++
> >   arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi          |  5 +++++
> >   5 files changed, 54 insertions(+)
> > 
[..]
> > @@ -440,6 +444,7 @@ &hbmc {
> >   	flash@0,0 {
> >   		compatible = "cypress,hyperflash", "cfi-flash";
> >   		reg = <0x00 0x00 0x4000000>;
> > +		bootph-all;
> >   		partitions {
> >   			compatible = "fixed-partitions";
> > 
> 
> Sanity boot tested on J721E-SK after porting to U-Boot. Thanks for the
> patch, along with the reviews made by Udit (although one additional mention:
> IIRC, OSPI partitions are cosmetic for the U-Boot driver, but better to add
> bootph even if it's cosmetic in case the driver changes the next day), with
> those addressed:
> 
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

Would be following up on those comments. Thanks for reviewing and
testing!

Regards,
Manorit

> 
> -- 
> Thanking You
> Neha Malcom Francis

