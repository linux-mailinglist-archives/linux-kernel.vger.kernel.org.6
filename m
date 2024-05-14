Return-Path: <linux-kernel+bounces-178322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 794C48C4BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A39A1F243D6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 05:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7E5179AD;
	Tue, 14 May 2024 05:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tQZ/S9bU"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00070B645;
	Tue, 14 May 2024 05:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715663461; cv=none; b=ArNg0CHMu5sIdNFly9o5WlPk3EWT6/kcZNCqRfnBzd3Kspktj1HQPN5LrAdiuQPCXne8wvJG6zxJ9wehEhYD8WKkuBMLDG5ju9v3SPIcAJ3Umd226SM50NyIL5gv5mm58dBI/C/irYn8WtL0pm0EtCzukdd54rXN6NXKIjXcNbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715663461; c=relaxed/simple;
	bh=VX/nT1OFCwLiO8UeA/uTNBtASw+CFxCX7ESZVp+tJ/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LfhZt4M38FNVfNormbQEtdRi/AHpXbbtmjIwCXgF9H3JALlq+5g7CrlbEKFWWIwCWgBofrZYtn5eoTVCSi+IP1/HbnypBTvSJRNegCaqduLeCP2YMJKd1fjkxIJ9DcEETUkbyg3ETngIKrllk3ZMla2i8Z2pe1O0y0hr4ZM2hUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tQZ/S9bU; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44E5AExJ102487;
	Tue, 14 May 2024 00:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715663414;
	bh=iWcfHQIJy00RbPyb4r7MZWVEdLEUYPY1krQxFcJwd48=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=tQZ/S9bUczitgIkqcrruTbtabGay4Qt3menVgEc0BBwrFa3ybQa3stO9pz4ScsmwG
	 t7a/F/zqaKnXRWWB8jgE7vD0mJeNb83WnxERUnG0RcK5SoFVcfPduAqC54g3qj60VB
	 JGumjiETJrO/NJMumQFz/1XhWWqgCLyB6n0VqcP4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44E5AEc8079975
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 May 2024 00:10:14 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 May 2024 00:10:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 May 2024 00:10:13 -0500
Received: from [10.249.131.75] ([10.249.131.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44E5A41c073551;
	Tue, 14 May 2024 00:10:05 -0500
Message-ID: <c9d27e22-b5cd-4995-86fa-3893430d08a8@ti.com>
Date: Tue, 14 May 2024 10:40:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] dt-bindings: display: ti,am65x-dss: Add OLDI
 properties for AM625 DSS
To: Rob Herring <robh@kernel.org>
CC: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jyri Sarha
	<jyri.sarha@iki.fi>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        DRI Development List
	<dri-devel@lists.freedesktop.org>,
        Devicetree List
	<devicetree@vger.kernel.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar
	<u-kumar1@ti.com>,
        Francesco Dolcini <francesco@dolcini.it>,
        Alexander
 Sverdlin <alexander.sverdlin@siemens.com>,
        Randolph Sapp <rs@ti.com>, Devarsh
 Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>, Jai Luthra
	<j-luthra@ti.com>
References: <20240511193055.1686149-1-a-bhatia1@ti.com>
 <20240511193055.1686149-4-a-bhatia1@ti.com>
 <20240513193504.GA3000298-robh@kernel.org>
Content-Language: en-US
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240513193504.GA3000298-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 14/05/24 01:05, Rob Herring wrote:
> On Sun, May 12, 2024 at 01:00:54AM +0530, Aradhya Bhatia wrote:
>> The DSS in AM625 SoC has 2 OLDI TXes. Refer the OLDI schema to add the
>> properties.
>>
>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>> ---
>>  .../bindings/display/ti/ti,am65x-dss.yaml     | 136 +++++++++++++++++-
>>  1 file changed, 135 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>> index 399d68986326..4aa2de59b32b 100644
>> --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>> +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
>> @@ -85,12 +85,30 @@ properties:
>>  
>>      properties:
>>        port@0:
>> -        $ref: /schemas/graph.yaml#/properties/port
>> +        $ref: /schemas/graph.yaml#/$defs/port-base
> 
> You don't need this change. You aren't adding any extra properties.

Alright. I will make the change.

> 
>>          description:
>>            For AM65x DSS, the OLDI output port node from video port 1.
>>            For AM625 DSS, the internal DPI output port node from video
>>            port 1.
>>            For AM62A7 DSS, the port is tied off inside the SoC.
>> +        properties:
>> +          endpoint@0:
>> +            $ref: /schemas/graph.yaml#/properties/endpoint
>> +            description:
>> +              For AM625 DSS, VP Connection to OLDI0.
>> +              For AM65X DSS, OLDI output from the SoC.
>> +
>> +          endpoint@1:
>> +            $ref: /schemas/graph.yaml#/properties/endpoint
>> +            description:
>> +              For AM625 DSS, VP Connection to OLDI1.
>> +
>> +        anyOf:
>> +          - required:
>> +              - endpoint
>> +          - required:
>> +              - endpoint@0
>> +              - endpoint@1
>>  
>>        port@1:
>>          $ref: /schemas/graph.yaml#/properties/port
>> @@ -112,6 +130,22 @@ properties:
>>        Input memory (from main memory to dispc) bandwidth limit in
>>        bytes per second
>>  
>> +  oldi-txes:
>> +    type: object
>> +    properties:
>> +      "#address-cells":
>> +        const: 1
>> +
>> +      "#size-cells":
>> +        const: 0
>> +
>> +    patternProperties:
>> +      '^oldi_tx@[0-1]$':
>> +        type: object
>> +        $ref: ti,am625-oldi.yaml#
>> +        unevaluatedProperties: false
>> +        description: OLDI transmitters connected to the DSS VPs
> 
> Connected to is not part of the DSS. I don't think these nodes belong 
> here as mentioned in the other patch.
> 

Replied to this in patch 2/4 to keep the discussion in one thread.


Regards
Aradhya


