Return-Path: <linux-kernel+bounces-356577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 369EB996393
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599A91C21749
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFE318C329;
	Wed,  9 Oct 2024 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="N3MsA3xX"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A917E189B98
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463366; cv=none; b=hNUM9huzOCbdCJab+QkKcmnDgcOyMw2+SWoQ1CDqw7nWgX1O6rynDGheV91u4fKCDXMZc/FRPoClqfoE4vNIsq9no4V5twj976zE29QxQx7HNDad9Zw+Z+MXWuJssKPcpbpQeaTJhCxNEi7z5Uilbgw9a+bAstcXFRNNB8wiiKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463366; c=relaxed/simple;
	bh=XhJiHPGo1+eCnZwKrwKtZoj+qGtS2ActqBF7GqOTjZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXk385DgHv+9qn43EnJ/TP4STrIUbtJSf8OOU2Qs/jQe+4nDzZGRFLnwc3TpyvJy7cQeK/SHeqANdaQABkHF68eVWw0IXKjiSrbLQrDOKCiTTx1qCoUzaKs4wBxIdPj19e09eNLREkA9D8BdmACcLTh75npxSdVYJcaqgLSVg3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=N3MsA3xX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9943897c07so555145466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 01:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1728463363; x=1729068163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCo1GlPGMO9qRjYk6NqblAPH+ivDBMcmdikYhCEoAX0=;
        b=N3MsA3xXYhA8BGicfckJzTKfIILQJylZFKBHAuYRpUMZCEwA/MGo1xlfMjbYrppwMZ
         1ABbNIaLsfWy+n8Jmcp8wGFMp3p0uj+e1t3wYhI4qL9QNlpICl5LZX23lNnVkMmbaHBv
         DEp/Ve+HON0bMnYDM8TZ1DjHpQ9m3QPEuyubq4S6VFwJ1cWDVuFZc2s02I1dWMgjGU0D
         i6gu7v4tWYpiAjOym8BXENecX5/8vPT46O4acX3v8gMjc51e0O2rc5avmUq9JgCtisGp
         lrggl7V+vqye8HtVY5xMd67EFvelC/sNNaMhrfo/TW+jzqv8cJhyNmH606Mqlv595Z+q
         xSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728463363; x=1729068163;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCo1GlPGMO9qRjYk6NqblAPH+ivDBMcmdikYhCEoAX0=;
        b=LyLo/Izb1Y6IWR8OTfTOxRcxfAy1k1d/+sAqe34j5BdcUDgKazL6fjrj1IvtN3OJTb
         aa2kpAylYrbYPsBBvYFbH7/VUt7OpfEz8ay+3pg02JanmFyZQugSbavA/t5ngt3+uqlM
         gFNTisjN2bPecEOWUyD7z+VCv/5r9SJp4uZ3513SFD0muWuSNEfl5onbNItoG0ylZWa/
         OOWrwkxBvJk52KWL6+v8VE12DZIVFwXs0s3hlEo2JOPl1KZFjCi9Y+DTSmw8v4G1nct9
         KA+r+uBCdKGmZQ/KidcmCMe2d0NeiubPhp4UsO+JK2IoXl8UDYikCwofSyt4a7/sCNzG
         yHgg==
X-Forwarded-Encrypted: i=1; AJvYcCXSwHkQ3eryilq75ZaJv04kb1deTRbKha8f/oWdMuqp6/DnRpAfGvGVWy5Jo2dQvaodqQqqfqED6n4sb6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY4egfQcYhrt6FokmCh98tUjVPkFddObp5WXAcMqf7k+7jVblI
	NwiVoS4DAaBA7MBosJniwkm7RLX3Oc5/LGYg09Orf1p/ovwVpC82EE4er9IqDag=
X-Google-Smtp-Source: AGHT+IH65Py6ZoVFXJXAzrfoxCpg11Zu8PXx18r+jrhrvKhS9cBYCLJYMJJAgnToJzsiU/Uro8/0AA==
X-Received: by 2002:a17:906:6a05:b0:a77:c95e:9b1c with SMTP id a640c23a62f3a-a998d1f6694mr148213966b.27.1728463363024;
        Wed, 09 Oct 2024 01:42:43 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9957c683d1sm365002866b.203.2024.10.09.01.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 01:42:42 -0700 (PDT)
Message-ID: <cbb9d3ab-ed61-43f6-aca1-8d35316c4ff6@tuxon.dev>
Date: Wed, 9 Oct 2024 11:42:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] arm64: dts: renesas: rzg3s-smarc: Enable USB
 support
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, magnus.damm@gmail.com,
 gregkh@linuxfoundation.org, mturquette@baylibre.com, sboyd@kernel.org,
 yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com,
 ulf.hansson@linaro.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-16-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXbNRO--0ZGO4owi3At5n1dTMMWo4PTaubyNWEkVnPFFA@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdXbNRO--0ZGO4owi3At5n1dTMMWo4PTaubyNWEkVnPFFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 08.10.2024 18:16, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Thu, Aug 22, 2024 at 5:28 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Enable USB support (host, device, USB PHYs and sysc).
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
>> @@ -144,3 +188,20 @@ &sdhi1 {
>>         max-frequency = <125000000>;
>>         status = "okay";
>>  };
>> +
>> +&sysc {
>> +       status = "okay";
>> +};
>> +
> 
> To avoid regressions (/sys/devices/soc0/ disappearing), enabling sysc
> is a dependency for "[PATCH 05/16] soc: renesas: sysc: Move RZ/G3S
> SoC detection on SYSC driver", so I think it makes sense to change
> its status to "okay" in r9a08g045.dtsi instead, and spin that off into
> its own patch. 

Good point! I'll add the dtsi changes into "[PATCH 05/16] soc: renesas:
sysc: Move RZ/G3S SoC detection on SYSC driver".

Thank you,
Claudiu Beznea

 I am not super-worried, so doing the driver and DTS
> changes in separate patches should be fine, as long as they meet each
> other in next or upstream.
> 
> The rest LGTM.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

