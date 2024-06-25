Return-Path: <linux-kernel+bounces-229332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D651916E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2767F281745
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3385176FA5;
	Tue, 25 Jun 2024 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QpGoMeOi"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB45175570;
	Tue, 25 Jun 2024 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334186; cv=none; b=S/Cr8oOMzdpgEV+svmsHbHqKdY5wsogcguXzRygzuzLPv4gma9tnu9GkETY8psIQswhZ6ZSLgqWYecS/MBSJtzPrH+LrqRqpidRqlYIgHyYX7bphK+iDCaZkmEPWJHxS7BOOju9HubG8sSvpKX4Nkfj4VPSfOPYGC07FSmKwzhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334186; c=relaxed/simple;
	bh=dqKVb4iDPrREF0TJ5hpRxUHj9GSVMmTywTOYP9KMAAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tr6V0dOv4zIKIAoYVPtoHZL0PNfPxNWdi3wnT859Ockm/wwj2ZKARi/ozTXX9fgUo+7bFK9VguTaTorl3LaPQLFEUy1qdxrpYYc44m63BtjXkEkqa0w/2Jy5rHqXNDBLQvlDr7BoYpoTjgfwyfcXzqqfpybM74B0FqtPMGpRva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QpGoMeOi; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45PGnLJ3106823;
	Tue, 25 Jun 2024 11:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719334161;
	bh=e+PxibB+O5GhU5C92Wr/IByOYRbQppvPEhHwTlzzld8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QpGoMeOiTlr9w7Sz08YfUVBO+BmJarEy9u5AkuWWvsok4VbXVdUEBL2K7ViuOvfmI
	 /zYkFheyQmpQoy4vMWimNdS5V2tEZBA4mBetO/Lt0J3MuDV42eOS1HLazCdhFlnZ9J
	 JAxxKqLUb5Wv6Cs+BzUZbBnmXkC7CNQloo4bSev8=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45PGnLqL074280
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 11:49:21 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jun 2024 11:49:20 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jun 2024 11:49:20 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45PGnKas053654;
	Tue, 25 Jun 2024 11:49:20 -0500
Message-ID: <6ebc89dc-fbb3-4073-8b1b-cd413907ebf8@ti.com>
Date: Tue, 25 Jun 2024 11:49:20 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: am654-serdes-ctrl: Add
 simple-mfd to compatible items
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jan
 Kiszka <jan.kiszka@siemens.com>, Tony Lindgren <tony@atomide.com>,
        Nishanth
 Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240625164528.183107-1-afd@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240625164528.183107-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/25/24 11:45 AM, Andrew Davis wrote:
> This node contains a child which is only probed if simple-mfd is in the
> compatible list. Add this here.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---

This patch depends on https://www.spinics.net/lists/kernel/msg5253666.html

Andrew

>   .../devicetree/bindings/soc/ti/ti,am654-serdes-ctrl.yaml       | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-serdes-ctrl.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-serdes-ctrl.yaml
> index a10a3b89ae05e..94b36943a50ff 100644
> --- a/Documentation/devicetree/bindings/soc/ti/ti,am654-serdes-ctrl.yaml
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-serdes-ctrl.yaml
> @@ -14,6 +14,7 @@ properties:
>       items:
>         - const: ti,am654-serdes-ctrl
>         - const: syscon
> +      - const: simple-mfd
>   
>     reg:
>       maxItems: 1
> @@ -31,7 +32,7 @@ additionalProperties: false
>   examples:
>     - |
>       clock@4080 {
> -        compatible = "ti,am654-serdes-ctrl", "syscon";
> +        compatible = "ti,am654-serdes-ctrl", "syscon", "simple-mfd";
>           reg = <0x4080 0x4>;
>   
>           mux-controller {

