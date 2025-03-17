Return-Path: <linux-kernel+bounces-563923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9F6A64A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585CF17219B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6301223314C;
	Mon, 17 Mar 2025 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPpXWE+f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16F8233708
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207961; cv=none; b=ce0krM9u01AU2bexlpXYtMogSFhZjO/+MP7fSjdiYq7kN2eOGNWnrkrQQI39n56c+MZkl7OaJacCETbLErScCRlhZhyBtgBeFZLcLXnLxtqBsITMHRZClj3TzUm9iGCNQnsOgYjl8wLqmJfuquUf8kxnQzkuUIFIliZLvdKZJBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207961; c=relaxed/simple;
	bh=lGFUk/XY6OKlwutG4IOmDRDUF0uDW6snxJrQMRReHsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grUFNndZCGWkuMLkspeapymmZCRuNmLj1EeDjcJd+X+gywKk/xzDi7xVQ+BtLBfk8qVex561UJmvXQfbp66iOneb7zL/drrfU21s2HnEipWAI0Jw/hm90brcgElIbv4ZgxUgq4uFYGRaNMszTzdM8pUuErw9VEaw5aodyok38mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPpXWE+f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742207958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7qJFOZ/+Jl07lT0f8d8WZ0s2eXtHTAaslsvyBrO2T8=;
	b=DPpXWE+fqW4X/WH4PywgeofmS++1wuhp4yxHTayOAGR6W/dqWCv7M4xJmwJyS3grs62QCh
	/HN+FWwxKJaDdx9Uz5sEB6uH5ez0/9yesmGT+RriOvhzsW8Kop9AWRjGytTPqqQ6xRnbOK
	2CQfzOUGK5Y/V2M6kY3zhRoLwg7OnTk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-X2sgq3SaPMe1a3M3-QDIBw-1; Mon, 17 Mar 2025 06:39:17 -0400
X-MC-Unique: X2sgq3SaPMe1a3M3-QDIBw-1
X-Mimecast-MFC-AGG-ID: X2sgq3SaPMe1a3M3-QDIBw_1742207956
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e6c14c0a95so3413908a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742207956; x=1742812756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7qJFOZ/+Jl07lT0f8d8WZ0s2eXtHTAaslsvyBrO2T8=;
        b=DeMp4+g1qibCJ6FZvj+5YP2kyu74pG6svibE+lTMyg8jgq2+D6L9JqmbWcRLrhxNFF
         /aL6Ag6iarwhJYn1DxsyLfnLNqJtgPc5d71B5j1XPZnYZGfoehdtQHcNIDzeBcjkBfxS
         RHFIdAwvzwNxv+LWLMB3I6UPy4MtNs/rnWZn1HtsGOb563E9sRkYZ8R+mKPPb74e8wTZ
         guepDCfFuGIp+sSyJMqB9DirQ06KV5YANzX7lIqd+HxF5YavUgQpkZdPuR/PfvSYIBRi
         lKpe0wVnD2wg7LLYzkfnZwqnHgD/br2taNj0wm1rcASioMHGgAyedvPnU1TKnDuClrQW
         Ep8w==
X-Forwarded-Encrypted: i=1; AJvYcCVQIKUzeDVUzSg2sEIVlPixK5PVS8fFl9IGL3cPVWztklpFxuvpiPaEC7lsrtoSs77z+IayxajR2Gw1DW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzROjLzzJxMjh+RpqRGqt13XCrecnpTZ/v3WRvosUvtsm2GwYvB
	ZD8Q195yz+EejWyiaos1tBpETDqlc9cpN0YD7yD8/9fB09KCMy+vSDtaIiTM7NBwZUtCVit9LC1
	0Fuu2SiKYJC9ugPqzASebU+Ft3JRiV5XYYgDKfk8977cAbayf1Z/l7m30sveyBw==
X-Gm-Gg: ASbGnctgoAS4skvu7XqvHegm0XFcoS6jOfrCrdUdEUA7Dc8xxDheKxywsQLM1v7RM04
	5C+PRmL07A5exfVfCRRb5MJ/DPGPaTFYaivQfnNMYrmr0aGpOzSfPjOs3xboWi8ssaHcr96yezn
	cCvLZErSR3FzKJ5gXXCGtTgOqFkwcdU9iQ3LvZCIqllKaiUeVBZ+dnmoufrA5VjRq19nBgc68es
	XXa4eHZwdtnfeBFb4ay7r6QPgaTgD3ijKCF8YA4DLAoDrRse/9z6HN0mOfxxL2MGiQdQLO+FFBb
	ZupuRiiZkytcJFA97y4=
X-Received: by 2002:a05:6402:4301:b0:5e5:c847:1a56 with SMTP id 4fb4d7f45d1cf-5e89f154754mr11487577a12.10.1742207956027;
        Mon, 17 Mar 2025 03:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3rVSyWnaQ7mFS+/wMjUyIh6Vh7FNtuCJ/TRTA2qxB+a0eh5O2HklSrp6Y9RiFKkNtraIoNg==
X-Received: by 2002:a05:6402:4301:b0:5e5:c847:1a56 with SMTP id 4fb4d7f45d1cf-5e89f154754mr11487561a12.10.1742207955531;
        Mon, 17 Mar 2025 03:39:15 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afe1f6sm5613581a12.77.2025.03.17.03.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 03:39:14 -0700 (PDT)
Message-ID: <bc3144b7-23c8-4b47-bdd8-c482b1a6d81d@redhat.com>
Date: Mon, 17 Mar 2025 11:39:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] platform: toradex: Add toradex embedded
 controller
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
 Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20250313144331.70591-1-francesco@dolcini.it>
 <4596db59-51fc-4497-9e94-670e9533e7aa@redhat.com>
 <20250317100856.GC17428@francesco-nb>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250317100856.GC17428@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 17-Mar-25 11:08, Francesco Dolcini wrote:
> Hello Hans,
> first thanks for the feedback.
> 
> On Thu, Mar 13, 2025 at 04:08:14PM +0100, Hans de Goede wrote:
>> On 13-Mar-25 3:43 PM, Francesco Dolcini wrote:
>>> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>>>
>>> This series adds support for the Toradex Embedded Controller, currently used
>>> on Toradex SMARC iMX95 and iMX8MP boards, with more to come in the future.
>>>
>>> The EC provides board power-off, reset and GPIO expander functionalities.
>>>
>>> Sending it as an RFC to gather initial feedback on it before investing more
>>> time in testing and adding the remaining functionalities, with that said both
>>> the code and the binding are in condition to be wholly reviewed.
>>>
>>> Emanuele Ghidoli (2):
>>>   dt-bindings: firmware: add toradex,embedded-controller
>>>   platform: toradex: add preliminary support for Embedded Controller
>>
>> Thank you for your patches.
>>
>> 2 remarks, as Andy already hinted at drivers/platform/arm64/ likely
>> is a better location for this.
> 
> Ack.
> 
> This driver is not going to be specific of ARM64, but today we have only
> ARM64 systems that would benefit from it. We might as well use it on a
> RISCV based SoM in a few years.
> 
> With that said we'll move it there, we can always move it out if
> anything changes on this regard.
> 
>> The reason for having ARM EC drivers there is that these are for
>> x86-pc-like laptops with all the typical laptops bells and whistles
>> like EC handled battery charging limits / spk/mic mute-leds built
>> into keys on the keyboards. Special key handling (like mute, kbd
>> backlight) done by the EC etc.
>>
>> Since all the experience for dealing with those laptop-esque features
>> and exporting them to userspace with a consistent userspace API is
>> in hands of the maintainers of drivers/platform/x86 it was decided to
>> add a new drivers/platform/arm64 directory maintained by the same folks.
>>
>> If this EC driver's only functionality is: "The EC provides board
>> power-off, reset and GPIO expander functionalities." I'm not sure
>> that drivers/platform/arm64 is the best place for this.
> 
> The directory decision / architecture was mainly inspired by
> `drivers/platform/cznic`.
> 
> This EC is used on a SMARC SoM [1][2], so we are not talking about a
> laptop nor a device with a keyboard.
> 
> But we do have a power button, a LID switch, some handling and
> coordination of low power mode and more.
> This device is between the SOC, the PMIC, and various IOs used for
> low-power, power-up/down, boot configuration (selecting the boot
> device), ...
> 
> The short term goal is just the 2 basic functionalities mentioned in
> the cover letter available to the driver:
>  - power/reset (already implemented)
>  - GPIO (working on it as we speak)
> 
> Starting small, and adding features when/if required.
> 
>> Also you mention GPIO expander, but that does not seem to be
>> supported yet?
> Correct, coming soon.
> 
>> 1. A drivers/mfd/ MFD driver with the regmap stuff,
>>    registering "board-reset" and "gpio" cells
> 
> So, we considered the idea of going with an MFD driver, but looking at
> drivers/platform/cznic, that is doing something relatively close to what
> we are doing (just more feature rich, as of now), drivers/platform/
> seemed a better fit.

So looking at drivers/platform/cznic this does not look like a good
example how to do things. I see multiple sub-drivers each in their
own file, but it is all directly linked using symbols from the modules
to each other.

The cznic code looks like a classic example where a MFD approach
creating child devices for each functions and having separate
drivers bind to each function would be a much cleaner way to
do things, especially since they now also have #ifdef's to allow
disabling some functions where as with the MFD approach one can
simply e.g. not build the GPIO driver at all.

Especially if you plan to re-use the baseboard / EC with possible
SOMs of a different architecture, in which case drivers/platform/aarch64
also seems like a bad fit.

The example of the MFD approach is that e.g. your GPIO driver can live
under drivers/gpio and thus will be reviewed by the GPIO subsystem
maintainers benefiting from all their experience with GPIO drivers.

But if Andy and Ilpo are happy to take this as a more monolithic
driver under drivers/platform/aarch64 I'm not going to nack that
approach.

Regards,

Hans


 


