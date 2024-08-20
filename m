Return-Path: <linux-kernel+bounces-293653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0239582BF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3F61C249BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D19018CC08;
	Tue, 20 Aug 2024 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="vZ55Iy/B"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5BF18C01C;
	Tue, 20 Aug 2024 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146604; cv=none; b=L8szWA7830BkbUXu3LfoKoF9GtlKZPl8ZxcM+K8k/DwLK0QBwdSJ9NkVu+rYh3GcmgKpJ4eLaae6O4ZQGXR07NT2WFh75XW+zjSccOrjzNO6MkgtfqEYDWV8K7kt5CNZJyRNFd9FVGPIXAFt+HXt4hpP+FQBbEqZhz4UlMrLeWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146604; c=relaxed/simple;
	bh=Uh5YB41o5J+Ua3Sf71x0mzKTl8FKLx3gmk4O+iRloU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=icXXYvD/8CIKBzG0KjMM+LXJ5sx2NRTqxWh03jSVkG2yRjTkqhfnnX2hshl31GXwC0CipfBF3rfLEnbibakt93aA8NQu7N43sPthxIlJPOuQwfUJleBn3T7sVfHqW20STmowukLV9sEFtH+5NxYu1XBHnnVu01mrro1aiZYKv8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=vZ55Iy/B; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K8G9Oo013636;
	Tue, 20 Aug 2024 11:36:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	pLoeQp1q1B5be6zyiREunwSL/Zzh3AyJoDZp6AjmFRA=; b=vZ55Iy/BvqZi/TTW
	tbwLiV3Wr9rhLe80DysMxnVchif/ug2FKCRzzCHzapRULHB3f/fHH+P7jQ4ZMIKM
	s/JTOYYZ60/v7PvLvC1P7Zzl7UBnfsxkJMFfnXtohQaCnrFBUuGf20WVMA5Q0kth
	IhvztraEFCHEoZLKW2fbq1ipgDCAU4B/rdLBmq4VVSdx58NXIZMJJkl0DNHFMG1J
	fgNKi/mXwlB1Z0S99BomzgBlClCU9KkbbZVJ7OMG/mRzXEDmLla4mRNMbBPTCCxO
	ubm4NSh2rwvV7W6UGWa8mk1zFz0dn6myZIQ9/10AqNmENQABza6qyu2s3OIP3Shx
	BChEmg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 414qg1gcwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 11:36:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A060240045;
	Tue, 20 Aug 2024 11:36:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8021C2515AC;
	Tue, 20 Aug 2024 11:36:03 +0200 (CEST)
Received: from [10.48.86.225] (10.48.86.225) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 20 Aug
 2024 11:36:02 +0200
Message-ID: <b86b33d3-2ab2-49a7-a7cb-d005dc4491d6@foss.st.com>
Date: Tue, 20 Aug 2024 11:35:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: access-controllers: add controller
 configuration property
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240716161427.237825-1-gatien.chevallier@foss.st.com>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <20240716161427.237825-1-gatien.chevallier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_09,2024-08-19_03,2024-05-17_01



On 7/16/24 18:14, Gatien Chevallier wrote:
> Add a pattern property that allows to define several controller
> configuration in the device tree. It allows run-time controller
> reconfiguration for an authorized entity as in OP-TEE OS [1].
> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> Link: https://github.com/OP-TEE/optee_os/pull/6946 [1]
> ---
>   .../access-controllers/access-controllers.yaml | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/access-controllers/access-controllers.yaml b/Documentation/devicetree/bindings/access-controllers/access-controllers.yaml
> index 99e2865f0e46..88824719bb73 100644
> --- a/Documentation/devicetree/bindings/access-controllers/access-controllers.yaml
> +++ b/Documentation/devicetree/bindings/access-controllers/access-controllers.yaml
> @@ -58,6 +58,13 @@ properties:
>         A list of access controller specifiers, as defined by the
>         bindings of the access-controllers provider.
>   
> +patternProperties:
> +  ".*(?<=)-access-conf$":
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Contains a list of inseparable access controller specifiers that forms
> +      an access controller configuration.
> +
>   additionalProperties: true
>   
>   examples:
> @@ -81,4 +88,15 @@ examples:
>                                    <&bus_controller 1 3 5>;
>               access-controller-names = "clock", "bus";
>           };
> +
> +        uart5: serial@60200 {
> +          reg = <0x60200 0x400>;
> +          clocks = <&clk_serial2>;
> +          access-controllers = <&bus_controller 0 0 0>, <&bus_controller 1 0 0>,
> +                               <&clock_controller 2 3>;
> +          default-access-conf = <&bus_controller 0 10 0>,
> +                                <&bus_controller 1 10 0>;
> +          shared-access-conf = <&bus_controller 0 256 4>,
> +                               <&bus_controller 1 256 4>;
> +        };
>       };

Hi,

Looking back at this, I think it would be coherent to declare a
dedicated cell definition for this property. It makes little sense
to base it on the #access-controllers-cells as there could be
different arguments. Maybe #access-conf-cells.

Then, I should change the description as this property should describe
a list of access controller configuration entries. This list can contain
references to one or more controller.

What are your thoughts?

Best regards,
Gatien

