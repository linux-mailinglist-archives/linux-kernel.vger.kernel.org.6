Return-Path: <linux-kernel+bounces-364724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 585EE99D86B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1992A282F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AABF15ECDF;
	Mon, 14 Oct 2024 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="rvRbnYTj"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02579142E77
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938339; cv=none; b=qsIDkvD+Lq9zZs9GEVwGx+x1wQbr7UBc6gOb7kR31UuEsIqlBzE23lDLt13kbmLYNZxJPgLdSij1X5+lLInJaaF6VRxK86RQZAJyOnICSa+H5hIxifJbUepBPoSsIdMGQcOcvy+eZkehDN/+W23p3VeiXmvRlYRDd2J/93r3xEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938339; c=relaxed/simple;
	bh=nEaffIp+CJuW+N1iMoCee0jOln2gnRywVic31Yjps30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJgsMk1Q9fzq5M0QBbK8FudjVPRQGBxeI/dOqBXpWzPaDk18N5mWb2TgqdS751/3fvaCiJaRuaRSqf/SzwPfQvVH6MxEbW0nVHuqNdJ3rAtTOpCXbkEPQTod/IDLgWn3Vy8Bp8T8bZvZARuUHT12rOMfAuIQodYfKpBPtivbhyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=rvRbnYTj; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6EEAC2C0276;
	Tue, 15 Oct 2024 09:38:49 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1728938329;
	bh=baEpGfW7rxqNpgz/S8mcS2prZpYssy/RFfM0CNMgx9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rvRbnYTjCePWHxkqDNxQy2BugsYUg5xCKn+f4nXMuHhx641ObimRtiZx3AcNMy6jl
	 7ZiUHBLPki+CUI/C1WDW6IYD0SILY3LKAx4MTksbpU3tRZViqYuJlbqwvCoai/MqDc
	 6A7/3Uwo3raVk2OVIxFhj0EcjdmzsMyZQwxfJ5mHYkG5e0RlYK+vhiVN1a06lIQdd2
	 x5Aolorh4RXV+JdE8awHjKL172p8o0g2H4m3NSGWn8UTpsqnorJ+gtVmQR/aTG0Dqy
	 F9HRwfYdyScEfQZIdraJjI3Df+QRuEwnCmLadfUxRKkn/7VTR6xkXPrR8jWG6XI2ok
	 P5tkdZ5npORwg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B670d81590000>; Tue, 15 Oct 2024 09:38:49 +1300
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 53E3913EE32;
	Tue, 15 Oct 2024 09:38:49 +1300 (NZDT)
Message-ID: <bd802a5c-e09e-4f4d-9d37-b87d85efb4e4@alliedtelesis.co.nz>
Date: Tue, 15 Oct 2024 09:38:49 +1300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 1/3] dt-bindings: spi: Add realtek,rtl9301-snand
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, tsbogend@alpha.franken.de, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org
References: <20241014015245.2513738-1-chris.packham@alliedtelesis.co.nz>
 <20241014015245.2513738-2-chris.packham@alliedtelesis.co.nz>
 <nuadh2elbry2qc4l7rdngfvs4inbsmo2vg2w72w5d4cgpnail2@zidp7kzxp7qp>
Content-Language: en-US
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <nuadh2elbry2qc4l7rdngfvs4inbsmo2vg2w72w5d4cgpnail2@zidp7kzxp7qp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=670d8159 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=62ntRvTiAAAA:8 a=gEfo2CItAAAA:8 a=G81r_u4-8cHXR2Yzib8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat


On 14/10/24 20:12, Krzysztof Kozlowski wrote:
> On Mon, Oct 14, 2024 at 02:52:43PM +1300, Chris Packham wrote:
>  =20
>> diff --git a/Documentation/devicetree/bindings/spi/realtek,rtl9301-sna=
nd.yaml b/Documentation/devicetree/bindings/spi/realtek,rtl9301-snand.yam=
l
>> new file mode 100644
>> index 000000000000..397b32b41e86
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/realtek,rtl9301-snand.yaml
>> @@ -0,0 +1,59 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://scanmail.trustwave.com/?c=3D20988&d=3D3cSM59Be7zhiOY6j70B=
GhTh0kCvZ-1Nf0f5XJZnTzQ&u=3Dhttp%3a%2f%2fdevicetree%2eorg%2fschemas%2fspi=
%2frealtek%2crtl9301-snand%2eyaml%23
>> +$schema: http://scanmail.trustwave.com/?c=3D20988&d=3D3cSM59Be7zhiOY6=
j70BGhTh0kCvZ-1Nf0a1RIsqGnw&u=3Dhttp%3a%2f%2fdevicetree%2eorg%2fmeta-sche=
mas%2fcore%2eyaml%23
>> +
>> +title: SPI-NAND Flash Controller for Realtek RTL9300 SoCs
>> +
>> +maintainers:
>> +  - Chris Packham <chris.packham@alliedtelesis.co.nz>
>> +
>> +description:
>> +  The Realtek RTL9300 SoCs have a built in SPI-NAND controller. It su=
pports
>> +  typical SPI-NAND page cache operations in single, dual or quad IO m=
ode.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - realtek,rtl9301-snand
>> +      - realtek,rtl9302b-snand
>> +      - realtek,rtl9302c-snand
>> +      - realtek,rtl9303-snand
> All of them look compatible with each other, why not using fallback to
> 9301? That's common and expected pattern.

So something like

properties:
 =C2=A0 compatible:
 =C2=A0=C2=A0=C2=A0 oneOf:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - items:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0 enum:
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - realtek,rtl9302b-=
snand
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - rea=
ltek,rtl9302c-snand
 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 - realtek,rtl9303-sn=
and
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: realtek,rtl9301-snand
 =C2=A0=C2=A0=C2=A0=C2=A0 - items:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const: realtek,rtl9301-snand

Or am I over thinking it and I should just use only a single "const:=20
realtek,rtl9301-snand"?

>
> Best regards,
> Krzysztof
>

