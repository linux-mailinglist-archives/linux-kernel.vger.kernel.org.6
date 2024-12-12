Return-Path: <linux-kernel+bounces-442893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668579EE38D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13B02864CE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A6D2101A1;
	Thu, 12 Dec 2024 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4UlWKG/"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA91420E715;
	Thu, 12 Dec 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997566; cv=none; b=SzDQ5SsKcUqVBovfNES99UYut1zfZ/9jpNjdRa41x/v6Z8kRO5DjUHwrliXilbKKWrj0yvuamT2PV0dOFcO759mC5LBW0MNTJbHk3O2kKPvi83QBc8Ret3ReGxmfi59dqqsNjjPnMnja7UI8sRDTjb1duiS8Q5xvsYgNjHDQpCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997566; c=relaxed/simple;
	bh=f9AA/A46t2LgZraALppz0qz31Q51GoBAgTAWwcSzbKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuKfHY04krZ10GKpBA4Zv+Yt4OL1B5CWcL2aC7fVPm04itsPrbTRZBrq30UHEI+po1MQtCMeHPNAFjrjny2fyLQE6fEzB37HYIINtosu2g7SEHjhoZ4igI2Rl6nk/StFp726W7FxsfPIZ/D1hqOFwZm0UExusEJI/C8+xCPiKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4UlWKG/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso70590066b.1;
        Thu, 12 Dec 2024 01:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733997563; x=1734602363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zk4a8zDUNM2R0E4snQBxkDhcU3anJgMWX77nhsVAD+0=;
        b=D4UlWKG/OCUHtx+xpIByAVUpF0C4JnatsAc8JyRd7C805um7mpLxhffGwNeJgZp27v
         zNpsG/+ECmB/7BBDJ2L21GO49OIfshUnzH4dlTE5UjLNtjGSd/FHHcUjtx97OCVAaZkG
         BbWs2Y7RyQ2NQkgU9V1TJhJbmzNVYSoOi5s1LKk6XOGobqO6TH1f7PdU6z585vX95q+S
         +U2yTP8ExneEnbcFuSagp//6tpRNfbmJ4fEt30FADVwIE4QZrtw3Kipxnom4X+Zp7iy/
         Kwdoqmz0gnM8p/yYQQMWm5Ma/ejdgVw79hZI+LtjetYW4T/iIWphS6JDXCu6xBD5EgYI
         412w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733997563; x=1734602363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zk4a8zDUNM2R0E4snQBxkDhcU3anJgMWX77nhsVAD+0=;
        b=A7u80hAt+IenwnOwPRzZ0N5Df1DhpiQnBWFzKw+kC4FelROk4LErlFaUS3blItCipG
         AnaI+ffCzw3YIrZMJsIRtewwAmAWk43NGKo6XwpWyv9iLsEgNXISVGthscdjxkePhTZy
         VhS2L+qPG1h6RZiJ9Wf+w+nr2rjkakHFWoJk8oDzC0Mxn2X34Fyc6CewzO8NhZAFWhD7
         8zjoYGm+50J6OFiQp+4YfOWxK+AhGGHf0ckpmuZ6MAKE1hlsh1nE1DNfI1OaQ+cvdwpd
         aXwkKALpRUMGisd1VUvwWBbCrsltQ2cYr1dzCogSNqpk39jZbViERMavrJdE+NpYm/Ho
         rWvw==
X-Forwarded-Encrypted: i=1; AJvYcCVG3rttFqAzCAKTTd6lWGGQXWxWjDz6sr/yowQTF5bTrkv5UFHOGAkLrwMduvcYqMDDAmqxlBCwFag1@vger.kernel.org, AJvYcCVd25qv1AKDDqF6EuhizdELkd2fMwMqFQTodJIV7FQqgV+xeQDxr0fnL5k33dp0gtGcIjVoXhcqF3fe1hLf@vger.kernel.org, AJvYcCWVbo5JvuqZeuoGSNuAD4WY9NeoAOpecqJlVpqWWc11eb3XdlpaIu3/PGl06q4KD3ljtfqWMSlrSTga+dE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2c8nl1vXboYOPRezb050qwuBp0cerzfl9xH4nZvIyr63dsi9v
	jFe5NshfBE9SiTc7lz+LZdRT6hFnKBd4ZGZQHeOViq2rt946feCi
X-Gm-Gg: ASbGncuXffUun9IHulEW9lwLCvfzzr8zWtLvtXrobvyEMeN8D/v8IG64v3TQHi9qi6q
	sYZIR6jbNIpomM5+cD/NSqVNTQTWWa5uq4G6dD1pt5i+nJZ+hX5doTgwdutTbsJim0weqTq58YK
	BxTxhcz7c6NfaW2HLLGjTRKkpNwTqaUu0gnvawc+5NVsTr74KWNeuV1UUxZWCPckeC63arytldZ
	ZkSnDUgO+CsxBGsYVXljoqFamUMYrCKkHVZXpLjDYz2zL3Zw/2m2u6Xqq0j1XAqWRRqqr0DdWKS
	DQkVew==
X-Google-Smtp-Source: AGHT+IHsoB7ECXZa+537Kblyf0Pjp2NQCDzrPJy9QJIErcCrbfwLPbPLg6bypSTjvP8hBq30GN5Gpw==
X-Received: by 2002:a17:907:920d:b0:aa6:73ae:b3b3 with SMTP id a640c23a62f3a-aa6b11e5531mr571613466b.32.1733997562783;
        Thu, 12 Dec 2024 01:59:22 -0800 (PST)
Received: from [192.168.7.105] ([92.120.5.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa674a112c7sm683296666b.147.2024.12.12.01.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 01:59:22 -0800 (PST)
Message-ID: <1fc1f1ae-766d-4266-84ec-11dbd67a608a@gmail.com>
Date: Thu, 12 Dec 2024 11:59:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] ASoC: dt-bindings: audio-graph-card2: add widgets
 and hp-det-gpios support
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>,
 Mark Brown <broonie@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.com>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-sound@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241113195240.3699-1-laurentiumihalcea111@gmail.com>
 <20241113195240.3699-4-laurentiumihalcea111@gmail.com>
 <ZzUH3n50Vw6RhmNJ@lizhi-Precision-Tower-5810>
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <ZzUH3n50Vw6RhmNJ@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/2024 10:11 PM, Frank Li wrote:
> On Wed, Nov 13, 2024 at 02:52:38PM -0500, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> Introduce the 'widgets' property, allowing the creation of widgets from
>> 4 template widgets: Microphone, Line, Headphone, and Speaker. Also
>> introduce the 'hp-det-gpios' property, which allows using headphone
>> detection using the specified GPIO.
>>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> ---
>>  .../devicetree/bindings/sound/audio-graph-card2.yaml          | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml b/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
>> index f943f90d8b15..94588353f852 100644
>> --- a/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
>> +++ b/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
>> @@ -37,6 +37,10 @@ properties:
>>    codec2codec:
>>      type: object
>>      description: Codec to Codec node
>> +  hp-det-gpios:
>> +    $ref: audio-graph.yaml#/properties/hp-det-gpios
>> +  widgets:
>> +    $ref: audio-graph.yaml#/properties/widgets
> why not direct ref Documentation/devicetree/bindings/sound/audio-graph.yaml
> and define these again here.
We don't actually want all the properties from 'audio-graph.yaml' (for the moment at least). Also ref-ing 'audio-graph.yaml' will make the 'dais' property required, which is not targeted in this patch. Maybe Kuninori Morimoto can comment more on this.
>
> Frank
>
>>  required:
>>    - compatible
>> --
>> 2.34.1
>>


