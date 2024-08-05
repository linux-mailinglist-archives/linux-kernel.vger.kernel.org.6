Return-Path: <linux-kernel+bounces-274759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90901947C5B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47AA41F234D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B8213A418;
	Mon,  5 Aug 2024 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOCjf571"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1D717C64;
	Mon,  5 Aug 2024 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866476; cv=none; b=nz28F01bsklXU1pdaaSJzQSGexUXYOR+QhXuaKQDT0JU1/Szj1TozEs++parlW0lfvE4No7hfRTrxdO0j6LRHYqp+u2nDQ9V8YDuf2RRxdjd3ZzH9AFZYdUchT9U3JbD7YbETienelXTe++mvBxbO3Hp+7e7mWYVkUlaJi/YPgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866476; c=relaxed/simple;
	bh=xeW3BFg1rRXSSiFrEPt3V/qUAtk3sB6WPkxk77Ds2VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnEaQ8v7kyTup5pRW2o3+HzZvtE/l8HrVYVNUB/GEhYJxmLeiclM0ED6PowhMr5DE/K3FHWo+cQMnzt5hdfGP6BRoQZa3tDMwJE+GgDDxKwOSfKNmCvUU7FNZ5Dj88NBd24I5XJBa2spY9AEsW1+HQeek0jLtMu81bZEPip5u10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOCjf571; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1C1C32782;
	Mon,  5 Aug 2024 14:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722866476;
	bh=xeW3BFg1rRXSSiFrEPt3V/qUAtk3sB6WPkxk77Ds2VU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nOCjf571dA5qd+ea4EQBuw9Z3KxslRDSOi+6l1QKD4BPPTsrqhbPtbOa/Tw/brAr/
	 Ray+f3MFmZrFNo0T26yT/FNnB027HjfuiuxRl3tpfMcveGI6F6iK+iUmJaHT0rcPy8
	 3ZR0wIkDTi0J4pfy9GtjHsM5Ymi0rd6heAIDjcU2kUf8VKGkjexjqvnX7XsaSgKfV5
	 I+FZKHyD9Vu86GnmTtOzgQ9PcRwoQv0Jh4m5TuLZSUyun6yCPI8a4Ie+z2L8l4EY9E
	 mZwNXxicKzHtsBSoUz2t/k6TXwJsq3TL1CZvwLp1lyj/iK1wJ8UxAGGoVEZJJ7tQa5
	 7kVnYMTb7I6CQ==
Message-ID: <2bf38b29-6aac-4c08-837f-a43683a54b56@kernel.org>
Date: Mon, 5 Aug 2024 17:01:09 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/12] Fix USB suspend on TI J7200 (cdns3-ti, cdns3,
 xhci)
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Chen <peter.chen@kernel.org>,
 Pawel Laszczak <pawell@cadence.com>, Mathias Nyman
 <mathias.nyman@intel.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 "Vardhan, Vibhore" <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Kevin Hilman <khilman@kernel.org>,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
 <37760e53-4e0d-4275-8497-1b51dcf72d5a@kernel.org>
 <D37UREKS0WIL.194M8MD5LEN2T@bootlin.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <D37UREKS0WIL.194M8MD5LEN2T@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

+Vibhore & Vishal

On 05/08/2024 11:58, Théo Lebrun wrote:
> Hello Roger,
> 
> On Sat Aug 3, 2024 at 5:14 PM CEST, Roger Quadros wrote:
>> On 26/07/2024 21:17, Théo Lebrun wrote:
>>> Currently, system-wide suspend is broken on J7200 because of a
>>> controller reset. The TI wrapper does not get re-initialised at resume
>>> and the first register access from cdns core fails.
>>>
>>> We address that in a few ways:
>>>  - In cdns3-ti, if a reset has occured at resume, we reconfigure the HW.
>>>  - We pass the XHCI_RESET_ON_RESUME quirk, meaning the XHCI core expects
>>>    a resume.
>>
>> OK.
>>>  - We add a xhci->lost_power flag.
>>
>> Why?
>>
>>>
>>> The previous revision had one big issue: we had to know if
>>> reset-on-resume was true, at probe-time. This is where the main
>>
>> Don't we already know this at probe-time? why not just rely on the existing
>> XHCI_RESET_ON_RESUME qurik, than add a new mechanism?
> 
> Some TI platforms cannot tell, before going to suspend, if their USB
> controller will reset. Suspend behavior is defined by (at least) two
> features:
> 
>  - Power domains. See arch/arm64/boot/dts/ti/k3-j7200-main.dtsi:
> 
>    usbss0: cdns-usb@4104000 {
>       compatible = "ti,j7200-usb", "ti,j721e-usb";
>       // ...
>       power-domains = <&k3_pds 288 TI_SCI_PD_EXCLUSIVE>;
>       // ...
>    };
> 
>    This `power-domains` property implies that even s2idle will reset
>    the controller.

I'm not so sure. All K3 platforms have the power-domains property for
the USB wrapper nodes.

> 
>  - Deep suspend. The type of suspend defines what will happen to various
>    controllers. Currently deep suspend is suspend-to-RAM, with the SoC
>    being turned off.
> 
>    This might evolve over time with more complex rules: the chosen
>    suspend behavior could depend on wakeup source and/or wakeup target
>    latencies. That information might not be available to Linux, being
>    decided upon by firmwares. We need to be able to resume successfully
>    without being surprised by a reset.
> 

Got it. Might be worth to mention this in the patch description.

> I am sorry the precise usecase wasn't clear from the get-go.
> 
> Thanks,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

-- 
cheers,
-roger

