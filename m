Return-Path: <linux-kernel+bounces-308704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6A79660A7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296381C24EED
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C711C1B250B;
	Fri, 30 Aug 2024 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CWCDqXH1"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33618192D79;
	Fri, 30 Aug 2024 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017101; cv=none; b=CxJ5eqldyUFl+h0jzrFIL7hoiU0Mdixh2X3O6XNnnfw6yQNC/v8Azph8W1sG8GEFrTPGZzRvbjgJBuIcRdt/0w6HyrmEzoknxVOLPR1KGNsRUSiUUEawTzqv2UH6vQzxbnrCOakzVLZgJA/Ns0QHUYuB6qr8dkNS+lbNtHn5/QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017101; c=relaxed/simple;
	bh=ys2Ou2uEsNPOrfeNWjFo3WFHgmDF+P2FLtJDB41f3/E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3HoNmas2HtBe4qycuQ+jXa8ju/Y0yxBnnzsnhLhcZPlANWhtwX65NHJuMt2FWY8roHlHDDJbCo0vav0gfHg80S362iQCAorH/8a4/niobzk31+wEcySY18fZVoMhuwQpL4VQh4TxKZ8zuo9qcKACTQGioUh1Qpiw/LCI/nYXC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CWCDqXH1; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UBOq74110121;
	Fri, 30 Aug 2024 06:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725017092;
	bh=TIEukrcez7k0Vd5WA4TMRIIlNJy5YtgOqtfdkYZcvVk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=CWCDqXH1Uat7p+WMEwITec5HUGc7K34gSk6FiYlGDql0sdPnFZgGqowJ/XQZodHGZ
	 PZkeq3EpiGWMFIv2rTOW5Sn18RTOWRKJlQaxPYlaPchrr02jeMV8wCD6kRkcZECZWB
	 PtDMCQakzzCouoN1D3sxTW04LkekU3ZHmSDKmCGI=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47UBOqFo111288
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Aug 2024 06:24:52 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 06:24:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 06:24:52 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UBOqqJ041257;
	Fri, 30 Aug 2024 06:24:52 -0500
Date: Fri, 30 Aug 2024 06:24:52 -0500
From: Nishanth Menon <nm@ti.com>
To: Prasanth Babu Mantena <p-mantena@ti.com>
CC: <vigneshr@ti.com>, <krzk+dt@kernel.org>, <kristo@kernel.org>,
        <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <sinthu.raja@ti.com>, <m-chawdhry@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am68-sk-som: Update Partition info
 for OSPI Flash
Message-ID: <20240830112452.geyv7tecpb6ydhmz@quotable>
References: <20240828060830.555733-1-p-mantena@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240828060830.555733-1-p-mantena@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 11:38-20240828, Prasanth Babu Mantena wrote:
> Commit 73f1f26e2e4c ("arm64: dts: ti: k3-am68-sk-som: Add support
> for OSPI flash") introduced the flash node with discontinuous
> partitions. Updating the partition offset to be continuous from
> the previous partition to maintain linearity.
> 
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> ---

Please note my response to a similar patch
https://lore.kernel.org/all/20240830092234.veog3e22te7qi3ao@dugout/

I do not want us breaking existing users unless absolutely warranted,
even then, I'd like us to be very cognizant of the minimum amount of
disruption possible.

Normally, I'd say no to this kind of patches. But, since this is in
the backup env, I am not *that* worried, but I want to make sure folks
understand breaking existing users without a just cause is a NO NO.

>  arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> index 5c66e0ec6e82..2e5730216caa 100644
> --- a/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi
> @@ -215,9 +215,9 @@ partition@680000 {
>  				reg = <0x680000 0x40000>;
>  			};
>  
> -			partition@740000 {
> +			partition@6c0000 {
>  				label = "ospi.env.backup";
> -				reg = <0x740000 0x40000>;
> +				reg = <0x6c0000 0x40000>;
>  			};
>  
>  			partition@800000 {
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

