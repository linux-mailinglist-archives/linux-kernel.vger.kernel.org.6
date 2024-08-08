Return-Path: <linux-kernel+bounces-279148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FA194B993
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0278EB21AA9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E7C146D5A;
	Thu,  8 Aug 2024 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JAGTyR6C"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F65D2575F;
	Thu,  8 Aug 2024 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723108866; cv=none; b=NXXEjgLBi1OBVBvrDZ+XfvrM58x3e1vACdyP9APC475OyQBUZ6azDoAaUr8tH6B8Mci+qtC+d6eMBHWOdSFit6T2oWpQP7XJgnx3p80MB4qvIMcja+yyJhvPV7yzD36z5jPHzPiPbuXdOfBhWyOl85pLiXHB/uECmKqixwaOoR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723108866; c=relaxed/simple;
	bh=imq1AiFHmG2TQHVtGq0TdcADRTAqGvAXQKIy6Q6VUBA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8NBkEipTGTdoZkjx1PEg5kBnDgrTNDQjMtP0L1U//iFrr9YdU2XN4RboWRiu+QAA3HcbIkk0e0OYDu+uYmxFIE/omdzSlPiWeQNSMOnGuo4DmM+mWznc1TFSYL8xdxgjqdgFFZcOSdKxVCfoT+sTILx8W4yXnOr0z73bBMruBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JAGTyR6C; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4789KtS3107112;
	Thu, 8 Aug 2024 04:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723108855;
	bh=W0/THron0rfDFCIl1FOT38fmOl3uIJ4DHfKFYOF/uTo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=JAGTyR6CssW6R+7F6TvXdrb8MY2X3x2eCUTXlypRNFNXi69xhbk3LEIkJ6BDQFnUJ
	 +ea2OfWejF+otcYEVQs4OptZQx2o/BCeHVhAiVW21tPwktQWeBLv4PfNzOV9pSEO9k
	 7E7UaDT7PtZOE1+E74eECEfJl1FYetLWPKim0+y8=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4789Kt5l021688
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 04:20:55 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 04:20:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 04:20:55 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4789KstJ059303;
	Thu, 8 Aug 2024 04:20:55 -0500
Date: Thu, 8 Aug 2024 14:50:54 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: "Limaye, Aniket" <a-limaye@ti.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Udit
 Kumar <u-kumar1@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>
Subject: Re: [PATCH v3 5/5] arm64: dts: ti: k3-j7200*: Add bootph-* properties
Message-ID: <20240808092054.7x62hy5twrwmadv6@uda0497581>
References: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
 <20240730-b4-upstream-bootph-all-v3-5-9bc2eccb6952@ti.com>
 <1cee1ebf-8281-440a-bf45-baa9b0e3b68f@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1cee1ebf-8281-440a-bf45-baa9b0e3b68f@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Aniket,

On 20:07-20240807, Limaye, Aniket wrote:
> Hi Manorit,
> 
> On 7/30/2024 3:23 PM, Manorit Chawdhry wrote:
> > Adds bootph-* properties to the leaf nodes to enable U-boot to
> > utilise them.
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >   .../arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 20 ++++++++++++++++++++
> >   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi            |  2 ++
> >   arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 10 ++++++++++
> >   arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi          |  7 +++++++
> >   4 files changed, 39 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> > index 5097d192c2b2..f8a5ad4737da 100644
> > --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> > @@ -21,16 +21,19 @@ dmsc: system-controller@44083000 {
> 
> Referring to the thread from v2 [0], I see that you have removed the
> bootph-all from the parent dmsc node. With current patch j7200-evm fails to
> boot (Stuck somewhere in tispl or right after that) as discussed in the same
> thread [0].
> 
> I have boot tested this patch (SD boot) and the device boots with an
> additional bootph-all at dmsc node.
> 
> I assume the removal was done intentionally, meaning we intend to fix the
> bug in u-boot or carry the one extra bootph-all there. If NOT, please add
> the same in the parent dmsc node here as well.

Yes, the removal was intentional and there is a fix that can be done in
U-boot for this so we'll take that up there.

Thanks for reviewing!

Regards,
Manorit

> 
> So taking care of the above,
> 
> Reviewed-by: Aniket Limaye <a-limaye@ti.com>
> 
> [0]: https://lore.kernel.org/all/20240709084857.nf7c57mi6miajeau@uda0497581/

