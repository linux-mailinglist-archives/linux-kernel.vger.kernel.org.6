Return-Path: <linux-kernel+bounces-180927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3C98C74F8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4F828583C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930B3145358;
	Thu, 16 May 2024 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kBO1aKQa"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B5B143747;
	Thu, 16 May 2024 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715857602; cv=none; b=UClyclkrs3o41j1PMhImU/+OEdl+FUMhwntP9IjXN+spzyCCxC4p5kTI4HDOTA56fHZTTDLrF6UTK8PzljZ/kH2rqbLsiH8qkAM1DFA+qhGNSZoAMFnmmpyzFnrFbGhawAz3pA9MadbHLLfB7oHuidAkJBb5LjVgzJlDGeljwuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715857602; c=relaxed/simple;
	bh=mX2e7DP96WI4HwI8WkMRPyTUF2BgOcmfhWebFXswwEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j24dwhXdpNio9LWG+xQS/mipCY4wk0UC0/tAGOV/W2ghAITRgsJTDOgX7CldPOyJaX7PZP18E5z+eHG8Im/QuhzHVlnjnOJ/wdQ1pcvE+5lhRn1+cF4SCGTb+WMjDS+r7DKt+ZhGolmK6Afx6LO2yxuQcH0DqT5u/yXRjcOYGYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kBO1aKQa; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44GB6F2G035545;
	Thu, 16 May 2024 06:06:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715857575;
	bh=3Gx2v5SXrefBPGo2GfUcCnROLjCL96tax4zOhCy0y/E=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=kBO1aKQa779E+rLvQC1B7i7KMBm3pHr7JM0+Ky62ASIXOIZVUvuXfZORueNIMbX0f
	 bY3hkH5Cke9hg70V3/kfpNnbpVkrO8FDFj1K4QmRAgygiw8E3F5miXnnOkww8tsTlJ
	 h7ZuSS5pCDDS0U/tF+D4P/oGeO15KrSnelmD8DfM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44GB6Fxx012222
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 May 2024 06:06:15 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 May 2024 06:06:14 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 May 2024 06:06:14 -0500
Received: from [172.24.227.31] (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44GB67pi065202;
	Thu, 16 May 2024 06:06:08 -0500
Message-ID: <cecb865d-2f59-4cdf-991a-4607b200d503@ti.com>
Date: Thu, 16 May 2024 16:36:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] dt-bindings: display: simple: Add Microtips &
 Lincolntech Dual-LVDS Panels
To: Liu Ying <victor.liu@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Maxime
 Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>
CC: DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List
	<devicetree@vger.kernel.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar
	<u-kumar1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Jai Luthra
	<j-luthra@ti.com>
References: <20240515095133.745492-1-a-bhatia1@ti.com>
 <20240515095133.745492-4-a-bhatia1@ti.com>
 <9f3c1825-0438-464e-bd6d-88da6a9c3b3b@nxp.com>
Content-Language: en-US
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <9f3c1825-0438-464e-bd6d-88da6a9c3b3b@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Liu,

Thanks for reviewing the patch.

On 16/05/24 07:49, Liu Ying wrote:
> On 5/15/24 17:51, Aradhya Bhatia wrote:
>> Add the Microtips Technology USA's MF-101HIEBCAF0 10.1"[0] panel,
>> MF-103HIEB0GA0 10.25"[1] panel, and Lincoln Technology Solutions'
>> LCD185-101CT 10.1"[2] panel.
>>
>> Thes are all dual-lvds panels.
>>
>> Panel Links:
>> [0]: https://simplespec.microtipsusa.com/uploads/spec/datasheetFile/2588/13-101HIEBCAF0-S_V1.1_20221104.pdf
>> [1]: https://simplespec.microtipsusa.com/uploads/spec/datasheetFile/2660/13-103HIEB0GA0-S_V1.0_20211206.pdf
> 
> This one mentions some controls in '3. PIN DESCRIPTION' which
> don't comply with this binding, like RL, TB, STBYB and RESET.
> Note this binding only allows compatible, ports, backlight,
> enable-gpios and power-supply properties, nothing more.
>

Maybe the internal module _can_ support these control options but the
actual panel hardware does not expose any of these controls on its
connector pin-out, and hence has no possibility for additional SW
control. Even for the usage, the device-tree node for the panel only has
"compatible" and "ports" properties defined.

The panel is being used within the confines of a simple panel.

Regards
Aradhya

> 
>> [2]: https://lincolntechsolutions.com/wp-content/uploads/2023/04/LCD185-101CTL1ARNTT_DS_R1.3.pdf
>>
>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>> ---
>>  .../display/panel/panel-simple-lvds-dual-ports.yaml         | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
>> index 716ece5f3978..e78160d1aa24 100644
>> --- a/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
>> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
>> @@ -41,6 +41,12 @@ properties:
>>        - auo,g190ean01
>>          # Kaohsiung Opto-Electronics Inc. 10.1" WUXGA (1920 x 1200) LVDS TFT LCD panel
>>        - koe,tx26d202vm0bwa
>> +        # Lincoln Technology Solutions, LCD185-101CT 10.1" TFT 1920x1200
>> +      - lincolntech,lcd185-101ct
>> +        # Microtips Technology MF-101HIEBCAF0 10.1" WUXGA (1920x1200) TFT LCD panel
>> +      - microtips,mf-101hiebcaf0
>> +        # Microtips Technology MF-103HIEB0GA0 10.25" 1920x720 TFT LCD panel
>> +      - microtips,mf-103hieb0ga0
>>          # NLT Technologies, Ltd. 15.6" FHD (1920x1080) LVDS TFT LCD panel
>>        - nlt,nl192108ac18-02d
>>  
> 

