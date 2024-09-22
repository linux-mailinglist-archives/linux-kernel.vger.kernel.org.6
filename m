Return-Path: <linux-kernel+bounces-335328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A60F997E428
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE1B1C20FC6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 23:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E964C7DA95;
	Sun, 22 Sep 2024 23:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNbSNihx"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38997581A;
	Sun, 22 Sep 2024 23:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727046967; cv=none; b=j4nBBuMBSbQjzduCWvc14DqeSn9tChQiw6ZpF8F7cGvyBLCRUGKd0INVbC9lN8wnvKBe7blCrCx0+MrfYd2Bp7gYVH6U3CcmI83s4mcSPqrioJEeh9pFq5dQ751msFdfNHJc5Y7DSH6wbVM4AY1X8snuooyHaMfu0LLf8wwfPZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727046967; c=relaxed/simple;
	bh=fx3QNRbAVm1b74xZ/F/27pxOipNT34BcVyOmdEBu3bU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JyDkmvNhjOstNrRG6G9CQ7Nsw2o4YEB83gkYvI4vyBpq2aSy7RPYC3eiAcWQ0ptqSZ/vovoMzKtIezQKjZ2u/MAyR0Q6RexC6HNDaQZBPGat6k4HobWqlEhxvinNQmvvqE+TZ7k/s7yi6xGXgScSxZ421ADXDnnx1IUTExHhfrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNbSNihx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cafda818aso35954815e9.2;
        Sun, 22 Sep 2024 16:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727046964; x=1727651764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQKrIsMaR5H73uXstbYvKgdNX2p28gN7WwxvuQwKaBw=;
        b=jNbSNihxf6nYP1HPexLQqi7j3j6CLrDGDmfaNsi1hboB7+qur8ZU4h6Q0mCSVRbbxC
         rwh09f74xRXZxr3jUyB7eYt1qFV2ZGReuFFkRkxDbsHlQLKOIgvS5lhnSWR0WxDlZvj/
         MGNNO8BxFi7U/CF8+m9WfFoOqzFX7DIBmTZxE0h0/jvrrTxuxZ/EN93I4QMqyU/Xi/kl
         Kqu3OoYcwqoS8QO8LyA2cwif7FCZD+nImQj6mQfZfx3iYUHSDL7tog4y8gPoGt1edSvb
         R6bhIcN9crwsRzDDS9XvZJBzUXmrC/GAbgSoTYU5PWpXlBS5NIPbqqc/c5/VgFQCpv6j
         /N9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727046964; x=1727651764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQKrIsMaR5H73uXstbYvKgdNX2p28gN7WwxvuQwKaBw=;
        b=Jwu1K0Nq475Au3eIQVtIlB1ge+cAlDUD4TDEUdJS74XeqfZBg7VbeOK84RvmldBnh8
         NV46G0UC3gspT41NGS320Yz4dHM9r49Gk9KXq2dP6V3udVrvuU9n2MAKCw6d5yiZj5Hx
         hhhnHNrjt6Yw7jX2Zu33462NW/AGf0wMcVDtQTYzRH6bkpekeMvSeNZ2nkYylVJYrlHA
         Q6Ax9qLK3Tw1ku85xv46itmccEzz36rbWacC3uiKuZ+rwnTIH1KR+/B1ICCCX6676KiC
         g2vXjUEjcS9MeiVdtVD+5OHQfhiqtfflyUa+6KJDn8MG+7DFIMIOLe7brWdYBes+yo3A
         K7Nw==
X-Forwarded-Encrypted: i=1; AJvYcCU2qv7fngsfUcRViA6LjUxmLC3kz+LNxMPCVHxggB6jHgVi3LZnZuoM7pH8uQ0Bgj945Wk3QQTXt22I@vger.kernel.org, AJvYcCVnVrqAoqL0WCPUXk7qVWWpDK3hFT6kQb68JOmPs46uU3Mo557MdRPVA1GuVJ+rD6DA2ixuXGMsU7k8ZogN@vger.kernel.org
X-Gm-Message-State: AOJu0YxkorKsL4qZeYCfO/Lf3ayoWqWg4jDLj+Ek+tB1y/2DkIi66xwz
	I6PtgtGQ9dmxhHOxO+oWoOO5JfMdd6CRF7UjGZZtMuycVj2TQfbr
X-Google-Smtp-Source: AGHT+IEDinjp0rRpmKvDlaxodTCIjSMZRPmtYU8gpGpSTP+j0fpbwp/LZwEehvOmUrmngjmPQEGmIw==
X-Received: by 2002:a05:600c:1c29:b0:42c:b4a2:a1aa with SMTP id 5b1f17b1804b1-42e7c16e861mr77676245e9.17.1727046963880;
        Sun, 22 Sep 2024 16:16:03 -0700 (PDT)
Received: from [192.168.1.130] ([86.127.146.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7afeb1c2sm84618145e9.36.2024.09.22.16.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 16:16:02 -0700 (PDT)
Message-ID: <1652f001-742c-4ef0-abee-c9645a3ae63f@gmail.com>
Date: Mon, 23 Sep 2024 02:15:59 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: imx8qm: enable dsp node for rproc usage
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Daniel Baluta
 <daniel.baluta@nxp.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Iuliana Prodan <iuliana.prodan@nxp.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
 <20240918182117.86221-6-laurentiumihalcea111@gmail.com>
 <ZusjSPQ0vpqIUtlL@lizhi-Precision-Tower-5810>
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <ZusjSPQ0vpqIUtlL@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/2024 10:00 PM, Frank Li wrote:
> On Wed, Sep 18, 2024 at 02:21:17PM -0400, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> Set the status of the dsp node to "okay" and assign
>> its reserved memory regions.
> wrap at 75 chars.
>
> Add dsp node and related reserved memory regions.
>
> Frank
>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> ---
>>  arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 27 ++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
>> index 62203eed6a6c..7ee69ce7b193 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
>> @@ -92,6 +92,27 @@ vdevbuffer: memory@90400000 {
>>  			reg = <0 0x90400000 0 0x100000>;
>>  			no-map;
>>  		};
>> +
>> +		dsp_reserved: dsp@92400000 {
>> +			reg = <0 0x92400000 0 0x1000000>;
>> +			no-map;
>> +		};
>> +
>> +		dsp_vdev0vring0: vdev0vring0@942f0000 {
> 'vdev0vring0' should be genernal name, such as 'memory'

Driver expects reserved memory node names to have a certain format.
If possible and if too problematic I'd rather have this fixed in a separate patch series.

>
>> +			reg = <0 0x942f0000 0 0x8000>;
>> +			no-map;
>> +		};
>> +
>> +		dsp_vdev0vring1: vdev0vring1@942f8000 {
>> +			reg = <0 0x942f8000 0 0x8000>;
>> +			no-map;
>> +		};
>> +
>> +		dsp_vdev0buffer: vdev0buffer@94300000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0 0x94300000 0 0x100000>;
>> +			no-map;
>> +		};
>>  	};
>>
>>  	lvds_backlight0: backlight-lvds0 {
>> @@ -640,6 +661,12 @@ &sai7 {
>>  	status = "okay";
>>  };
>>
>> +&vpu_dsp {
>> +	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
>> +			<&dsp_vdev0vring1>, <&dsp_reserved>;
>> +	status = "okay";
>> +};
>> +
>>  &iomuxc {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&pinctrl_hog>;
>> --
>> 2.34.1
>>


