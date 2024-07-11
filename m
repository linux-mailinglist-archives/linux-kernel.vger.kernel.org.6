Return-Path: <linux-kernel+bounces-249155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE8392E7C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B80A28953C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD0915D5BE;
	Thu, 11 Jul 2024 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wu5gLYPp"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F47115FD15;
	Thu, 11 Jul 2024 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720698987; cv=none; b=OK4VSi1p19crZSwCtaPkUi+pDhvshJHdV9Kpy0ozvf88Uchu7iTJnmTQ/mlZFvvjzEY07eVbE6pS3qJaQftf0ZYkeUwqwPLveLgbCiL0XRUHTcNrkIjvyJ0DazObv54OK940LlRfDl3Wt4WiSnM7mb37odLx7/Z0bpFjRlBcVrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720698987; c=relaxed/simple;
	bh=yL9nOzO4JRO8ARg6ThjkeEd3noDQcACDauD3MhB+qEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3HiBDSXkv8lflGAo/Cx3qANjwEMLkbgoB8Q4hOq6gaEhkGQ/2PhJgi6ZVnxyuwUn+0XoLrVGJuxhz8oPSEViAhXc2MIMher8p1o+Hmm7EZMPXqP/Sh5gTvCwvGQkfxvVlqFzDso6ALQhh3xGa8pCqp/R08z75If6ilvwjcuAbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wu5gLYPp; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58b447c513aso1004573a12.2;
        Thu, 11 Jul 2024 04:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720698984; x=1721303784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bq2MHRWMRpRuHietDcISXO0+46WBW+IZOyTMBnJpPCI=;
        b=Wu5gLYPpgFuDi4hbCp3s/vtJsRdjWnVK4nT01m6LW0HfV71c0I52g64jvVy38+3bPk
         u4GB6/v/U7ZPvtmUsMXH09ZLVj4YYKU8YMpkzK+OOQ3GPmdX1TBc4NrYq17J/HZmmGTP
         /kgp4olgGNbe48rjaHWynhGnTaQXOUSRjpT2chzCn+4bQqIIl8LAox4pc5TDsNHsRgGK
         zb2T7UM30UYgHhQZyn34VCNC/663836M4h5ZAzdET1mqxkP0UPK+ldby0BguvK5cyX9U
         Bktdg05ISL5l31NmM3J+fE0rGdOldIgBIks98wX7AHHvDlgHbXOY2fOCwxFusPfFFBPN
         jsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720698984; x=1721303784;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bq2MHRWMRpRuHietDcISXO0+46WBW+IZOyTMBnJpPCI=;
        b=uYZYFAMHGLhF03UbtD05J75RwX1GiL1KswvMW5RJzW82EiTfoMjDP0iKstesRgZ9/7
         mj5r3I80mfhKepbzyoR7ksHn8o17TjtFkaxnX3T18Ty2QzOJcwjbi6af+I6hCjGfXWpj
         GjamECdPBjSIHvd550ctwJEetG/HIfXkFsfSzDlIKflODGWwiSeXhah1ahXSvA0UXOX0
         iQtbu+KhVGIhCE73bX6pPHc5dD/5axxYTNMIxjgB7bHfBjidPKtoy1qdgX1YSfJaibbr
         bRL5yzZe7GYtI2koAMbtUhWUDD/7MnEABBZvD2/rjsQFHDNJqmVQ6igzyR/Pw5n7+oF1
         Rp6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqLNNTJ/tHa9NcrB8wTAO3LOFkaZPrF9MUhBmQCXVeMNulljjrIlUdOVTh5U1sseaLFaQ9hCPDaz68CzSDBTLmAnArPG343eY/HpIzpo26ly1yzCPBdr7BXXJIR1VToZdLXJ7rsn33pA==
X-Gm-Message-State: AOJu0YyEZt7qqfchiRavWoUaOkEX6Wl3Z64EJjsPX5SY8egof4/m70kw
	y+oZ3CRwM06LNCVM0bPIkiF213/r7D0kxeFkOqgnQrY9bY1UCdkYv0UC
X-Google-Smtp-Source: AGHT+IFPclGUkdX7WZ6l5h3IecZRqbFpN4dthUnDLTpOivMTp7878y/TTqx+pJJ4Japsfg+fOBaMSA==
X-Received: by 2002:a17:907:3d88:b0:a72:4c33:6ba6 with SMTP id a640c23a62f3a-a780b51309amr713941966b.0.1720698983425;
        Thu, 11 Jul 2024 04:56:23 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:2315:3572:6db8:dada? ([2a02:810b:f40:4600:2315:3572:6db8:dada])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a86f636sm248691666b.208.2024.07.11.04.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 04:56:23 -0700 (PDT)
Message-ID: <1cc5ca06-bb40-4787-9e97-a12d79e54d7b@gmail.com>
Date: Thu, 11 Jul 2024 13:56:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add missing pinctrl for PCIe30x4
 node
To: wens@kernel.org
Cc: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 Anand Moon <linux.amoon@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240711060939.1128-1-linux.amoon@gmail.com>
 <a8c1f49e-bf25-4fd3-a16f-13088f75767f@kwiboo.se>
 <CAGb2v65iR9BdAX43gfpBOeKF_B5PFm+RhPwu5FHUfRxCMeqh-w@mail.gmail.com>
 <e3410560-6dec-41de-ab14-441dbe8e5bb1@gmail.com>
 <CAGb2v66gmZGh-_7r6+ifeH-OfU4npxZNWucS-GhtL91LCSvqvQ@mail.gmail.com>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <CAGb2v66gmZGh-_7r6+ifeH-OfU4npxZNWucS-GhtL91LCSvqvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 11.07.24 um 13:38 schrieb Chen-Yu Tsai:
> On Thu, Jul 11, 2024 at 7:13 PM Alex Bee <knaerzche@gmail.com> wrote:
>> Am 11.07.24 um 11:17 schrieb Chen-Yu Tsai:
>>> On Thu, Jul 11, 2024 at 4:44 PM Jonas Karlman <jonas@kwiboo.se> wrote:
>>>> Hi Anand,
>>>>
>>>> On 2024-07-11 08:09, Anand Moon wrote:
>>>>> Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
>>>>> signals.Each component of PCIe communication have the following control
>>>>> signals: PERST, WAKE, CLKREQ, and REFCLK. These signals work to generate
>>>>> high-speed signals and communicate with other PCIe devices.
>>>>> Used by root complex to endpoint depending on the power state.
>>>>>
>>>>> PERST is referred to as a fundamental reset. PERST should be held low
>>>>> until all the power rails in the system and the reference clock are stable.
>>>>> A transition from low to high in this signal usually indicates the
>>>>> beginning of link initialization.
>>>>>
>>>>> WAKE signal is an active-low signal that is used to return the PCIe
>>>>> interface to an active state when in a low-power state.
>>>>>
>>>>> CLKREQ signal is also an active-low signal and is used to request the
>>>>> reference clock.
>>>>>
>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>> ---
>>>>> V2: Update the commit messge to describe the changs.
>>>>>       use pinctl group as its pre define in pinctl dtsi
>>>>> ---
>>>>>    arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 6 +-----
>>>>>    1 file changed, 1 insertion(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>>>> index 2e7512676b7e..ab3a20986c6a 100644
>>>>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>>>> @@ -301,7 +301,7 @@ &pcie30phy {
>>>>>
>>>>>    &pcie3x4 {
>>>>>         pinctrl-names = "default";
>>>>> -     pinctrl-0 = <&pcie3_rst>;
>>>>> +     pinctrl-0 = <&pcie30x4m1_pins>;
>>>> Use of the existing pcie30x4m1_pins group may not be fully accurate for
>>>> the PERST pin. The use of reset-gpios indicate that the PERST pin is
>>>> used with GPIO function and the driver will implicitly change the
>>>> function from perstn_m1 to GPIO. So this may not be best representation
>>>> of the hw, hence my initial suggestion, something like:
>>>>
>>>>           pcie30x4_pins: pcie30x4-pins {
>>>>                   rockchip,pins =
>>>>                           <4 RK_PB4 4 &pcfg_pull_none>,
>>>>                           <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>,
>>>>                           <4 RK_PB5 4 &pcfg_pull_none>;
>>>>           };
>>>>
>>>> Similar change should probably also be done for pcie2x1l0 and pcie2x1l2,
>>>> not just pcie3x4.
>>> Can we consider implementing strict mode in the pinctrl driver so we don't
>>> have to keep doing this GPIO + pinmux dance?
>>>
>> This is not about drivers, this is DT which is independent from drivers.
>> Jonas and I had discussion recently on u-boot mailing list with somebody
>> using Open/FreeBSD about exact that topic. Pinctrl mux settings should be
>> very explicit, even if it is not required by the linux-driver.
> The hardware also prevents you from using GPIOs with any other mux setting.
> That is already implied by the compatible string and doesn't need to be
> spelled out. The strict driver mode merely enforces this hardware limitation
> without the very explicit setting. One could also say that the driver is
> wrong to support conflicting settings.
>
>
> ChenYu
"The" driver is in fact not correct here, since it's two actually two
drivers: pinctrl and gpio, two subsystems and separate HW blocks (not very
clear, but it's at least configured in different mmio regions). So with
what you are suggesting you want one driver to implicitly configure the
other and expect every OS to have such methods? Broad ...

Alex

>
>> Alex
>>
>>> ChenYu
>>>
>>>
>>>> Regards,
>>>> Jonas
>>>>
>>>>>         reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
>>>>>         vpcie3v3-supply = <&vcc3v3_pcie30>;
>>>>>         status = "okay";
>>>>> @@ -341,10 +341,6 @@ pcie2_2_rst: pcie2-2-rst {
>>>>>         };
>>>>>
>>>>>         pcie3 {
>>>>> -             pcie3_rst: pcie3-rst {
>>>>> -                     rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
>>>>> -             };
>>>>> -
>>>>>                 pcie3_vcc3v3_en: pcie3-vcc3v3-en {
>>>>>                         rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
>>>>>                 };
>>>>>
>>>>> base-commit: 34afb82a3c67f869267a26f593b6f8fc6bf35905
>>>>
>>> _______________________________________________
>>> Linux-rockchip mailing list
>>> Linux-rockchip@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip

