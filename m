Return-Path: <linux-kernel+bounces-326089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43075976271
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0696928407A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E6718CBE1;
	Thu, 12 Sep 2024 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="TCXeVHHh"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42EA383
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726125393; cv=none; b=EFyYhYjLYKjwcza8Ty+96zNGbOapvPmoxBq9ojR94JvhudrOneDLuhm399T8e2+MdYZaayB2/R9RqKFBp0v9O9VzjxjMMyRWuJ32bNj5waHjao5w63efjyfExb5zRvnmt9ZnSnZZa1CEz3QNWRA3I5DWYay6gR65C+ljNTrzqC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726125393; c=relaxed/simple;
	bh=AHrcQx8LR1mijO3wHALGSJs+5RqDe43pynZ1DgmTUCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfjUr+S0qaOTBK9KYBufp1HA0VOgXJOCtqaAokt3Wa+GZUQxnoe17NURzGX8Fi89Z5DFwmYaizYpW7xoiDYoGWY3JH0PYGvyPt1+Kuqd0BCpKDoag4e6qOaG2P8vJ50eq2f5bd1fWOMMpe0L15DlTJPA1b3VIMs9TXCQjNiiybI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=TCXeVHHh; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2053525bd90so6580485ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1726125390; x=1726730190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lh7l9YoHy4qkgvE49qc+r/MAsmVlGzV7/aids6D1De4=;
        b=TCXeVHHhXqMrqL4/1GuwNnEgxG30DjlYBJgBWnSuM8lE92x8U0Fw6U0i4M/MwluSwM
         RuoYsCOaVrBhXzUAjJKwEcFtvfQpq5HC/n1pASaqwl/c+s/BUQE7zXJiPAhvBSPyQ+Rg
         NQbeMBx217h4kuvrEJfA28ekfHRtFi6Z+XIjkLaG9IbYkobryXyq5SCj3wr81xDMoya/
         9M9XDMjSNH87OZJd5KE6uEJ5vbLJRlJpNWiQXrsOyYsDZtTZzTMld0tNfFg7L/tNit4P
         mCkJ7TFP7nGOA4Q0HrUITGJlsvgIPwM2XAp4SiTeyzuC5Sg1LBBLzI5Z/cN0cQ+kMYSq
         Nycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726125390; x=1726730190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lh7l9YoHy4qkgvE49qc+r/MAsmVlGzV7/aids6D1De4=;
        b=Z1KlYU1sa+hvdLwQsGNMkmqQvTflvZrdFzzKQr9OAG0Gg9ffPK7+UvFNrFOxG/lWek
         UjG2mS0Un90NoAWEqOk4aeK0bW5w3ePpwORSP3KYUVBfigTDXRLRFpDNd//h60zdhoBu
         oEARmPncw1L1Jc0sAssiXbwOrvxqxbXwqRxBzPDrMHxzT3g7vIZ++dVDsHuCWA2J2O1J
         uIdkjrIw/3TjPlcR4dLqgcjo7G3ahLLA3pB+y9OavRmtVIKE/RhE+J/KkqqaBFqDHb2K
         snk0o0V9Ngf8+ycLq/3r5KMP5DoHcWEXKaOvPVK0t3/kBDngfzEFAx3/3g+KkC24eHmd
         ppVA==
X-Forwarded-Encrypted: i=1; AJvYcCVZXWauWAa/OHqJZY4WF0clKRbKHDCSg12HgkqQcHK1LgwUFgVbs+9dMc+a2pGP9VxQCsqmYlULCDYA3/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUlT6U/g10IY5QXAAq9sCH5AIzPXmzBAzYbVrx01FRTwYIPZb/
	gi6ebM/W1ADs5lNosdco2yh8PfbCyhbYHozPk9B0dqs6a2NPOSvU/BwGtdlxyg==
X-Google-Smtp-Source: AGHT+IEgQUUi+YQfcBvAAIBX3uJLnFXqg+luxeETvddbtjlQ/UH/tax/cuWaglJLbLCWUuuqRX2lvQ==
X-Received: by 2002:a17:902:da88:b0:206:b250:1e1 with SMTP id d9443c01a7336-2076e4239fdmr32667795ad.45.1726125389908;
        Thu, 12 Sep 2024 00:16:29 -0700 (PDT)
Received: from [172.16.118.100] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadb42e6fasm11951226a91.0.2024.09.12.00.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 00:16:29 -0700 (PDT)
Message-ID: <097159c7-1602-4e32-8e6f-9cd023d62238@beagleboard.org>
Date: Thu, 12 Sep 2024 12:46:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] addon_boards: mikrobus: Add GPS3 Click
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ayush Singh <ayushdevel1325@gmail.com>
Cc: fabien.parent@linaro.org, d-gole@ti.com, lorforlinux@beagleboard.org,
 jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 Andrew Davis <afd@ti.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>,
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911-mikrobus-dt-v1-8-3ded4dc879e7@beagleboard.org>
 <2024091149-vocalize-composite-6e48@gregkh>
 <44039255-159a-4284-abd8-a0f558ad006d@gmail.com>
 <2024091151-unworldly-dance-9a80@gregkh>
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <2024091151-unworldly-dance-9a80@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/12/24 01:34, Greg Kroah-Hartman wrote:

> On Wed, Sep 11, 2024 at 09:26:06PM +0530, Ayush Singh wrote:
>> On 9/11/24 20:28, Greg Kroah-Hartman wrote:
>>
>>> On Wed, Sep 11, 2024 at 07:57:25PM +0530, Ayush Singh wrote:
>>>> - GPS3 Click is a UART MikroBUS addon Board
>>>>
>>>> Link: https://www.mikroe.com/gps-3-click
>>>>
>>>> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
>>>> ---
>>>>    addon_boards/mikrobus/Makefile         |  1 +
>>>>    addon_boards/mikrobus/mikroe-1714.dtso | 28 ++++++++++++++++++++++++++++
>>> Odd top-level directory for the kernel, are you sure this is correct?
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>> Well, it is kinda a temporary location, since well, I could not find a good
>> place for board overlays but a top-level location seems better than putting
>> them in any arch specific location. I am open to moving them to a more
>> suitable location if we have one.
> top-level location is not ok for something so tiny and "special".  Just
> put it where all other dtso files go.
>
> thanks,
>
> greg k-h


So here are the directories where dtso files currently go:

❯ find . -type f -name "*.dtso" -printf "%h\n" | sort -u
./arch/arm64/boot/dts/amlogic
./arch/arm64/boot/dts/freescale
./arch/arm64/boot/dts/mediatek
./arch/arm64/boot/dts/qcom
./arch/arm64/boot/dts/renesas
./arch/arm64/boot/dts/rockchip
./arch/arm64/boot/dts/ti
./arch/arm64/boot/dts/xilinx
./arch/arm/boot/dts/nxp/imx
./arch/arm/boot/dts/ti/omap
./drivers/clk
./drivers/of
./drivers/of/unittest-data


Out of these, `drivers/of` and `drivers/of/unittest-data` contain 
unittest dtso, so probably not the place.

And the `arch/arm` and `arch/arm64` are for arch specific stuff. 
MikroBUS is supported in RISC-V boards as well (BeagleV-Ahead). So 
probably not the correct location either.

Maybe something like `arch/common/addon_boards` would be better?


Ayush Singh


