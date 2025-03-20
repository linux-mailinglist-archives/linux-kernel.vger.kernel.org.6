Return-Path: <linux-kernel+bounces-570384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F001A6AFB0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2207487795
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EB922A7E3;
	Thu, 20 Mar 2025 21:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="226F4C94"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B64229B0D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742505098; cv=none; b=FlluweZFzB7K4qt2FKszY6qPqQ01b7rDNW3/gpblydBUh9bfkgjzeLGM+G4dkpSdS39RArQVR1aZHtDMhcpOLqY7ZXkmV73WnnY2mIyBz+wr1D1ABAPYxcnW3yAPnexDDhIVZBY4Gt5kFj5L4sVIbApoFueXtO1XUuM/J/ZcJQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742505098; c=relaxed/simple;
	bh=7iu2Y0Wtay1ioN02eOsrQuFnCjPMoGEfCCJHMiTewZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDohCsCZStaLwL8YFLdoJitwHbhQZmDp/Ii/+xrCOGjiWd6jpOPP5qRRdqTK0A04QtLTFFropPcGeKyliUL+ONXViQN9KaWGQYaoN/oyQFIvzqjTJFjwGnA44hPqbI2GdEFh8YyQZ3CuY/lmDclQ1v/D4sJ7jrG2SZo27SHKfio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=226F4C94; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff80290e44so2785634a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742505096; x=1743109896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sImzeLmX2UXA2JBg4J72WEGaNrYKRbgkBy97vSMkV7o=;
        b=226F4C94NTRX0nB0fGpVtMNngVVKaodh42fxNEVTk6ZWujooJ5WnzWvDA2c7yFbJ98
         MbzDgG6UU27VcRiznr+31Ssukjo9mrLAwfIWtbU1k62AylWZ74gMvqOthqphOyUCOwNE
         UI+/SIQdoRan+goxTMvd0kr9zDj+llk3CVMTC7INmVmdkCvtQlfMF5oldOhrk2yuRWwF
         SO7oqiljdd97qZO0+SL/sSLvniAvSFBhQeE0X4dqzuDJDmLzVAzTVLY/VyzJR5qs54Xd
         GaZh7hXAH4p01e/pmOKlc6A+JyYRMcdf14ozKmRPugCRyIMdD9PcPrDYFIfLivFJWM1A
         QLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742505096; x=1743109896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sImzeLmX2UXA2JBg4J72WEGaNrYKRbgkBy97vSMkV7o=;
        b=ien1ewyMyhveAR+5OBoJt5eUPswcokQXRs3BzUfFyOs3gS4tgRs6R4wBoyb8jutr0+
         AlWmg6hXuSO7QHcD3kUqqFwAsdZfddJMyZlZWEVcl4mCWSqND7P31Doyf0QrSYqvMRre
         Ik7Sxfw0Drl8ZUA6B3DJCpvwunXhzHafn45GSWDXRVxBEGOfsqxMPOFsreqop+vB4VRK
         mv/KRNK9sQnr7YFl565ozqWoqCWgpwgUGL5pBwpI8JlK3x3ZxZANOKSIDaocehxoiuQu
         BVC5AtJwpLh1d2F5xBPCBnR0gpOzFyAMH5hPgPqUE5HDoCZeD0VubOl4MuIUCcpKdU+6
         xLxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsvIp1Ko1BwvC2fC+dCYFMWI6+E26h/SuOl5Q0uNHoVrxe6ka7qJeFNNBu2FIr4V4HXVGtuEcVtayykSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlwiuDUmtCI9ZF7GoelvHUPGYW/7rk90ioF/LQuoiTS3lJnRgE
	dRVDcJjESZzZ+rt/Er4ww8XqO4x+HAVCwXE9jPMYYRGxQnxRXt1CQ1QlrnVxnA==
X-Gm-Gg: ASbGncvSTCIYOKrlHt48a4IAGFN0JNdI0lE3ex5qrZzFnh6fy/8fLrhpcGiAcXZbcTP
	yNSsuoCvVVCnrqnCQrunE9bouyjXfXeQFOs3IpAcX80KHpl+Jsse5uXGzcJEu5kJTAHhdxUK1z0
	s8M5xxXKWHkLreaybb5mxPaKMcFVjaky8WoCX/D1d0Ybh51BRF9jm8EZg0poF3vQtvk9j1Mwrf6
	8laKiam9l0HF8p4M7CV8uqHpCOEdmGqMCTVHfv7bK+mNkzO68V2p3H/cwRi6/qeDKqCjt/G8hK9
	8p7bR1sV2xrben2GgHvmNGvHlOVJFm0em4ZXNvigIuBQEy2SBPkxGYQ8yAax0ecKq28MmRxsKCF
	NYVjbopsr1WRfafsbQzVPDoxlvoek4ZllXh6LqW6wRNE=
X-Google-Smtp-Source: AGHT+IEqVCBTwmZhDMDS7kV3oI+HSN7FBdoblik0mljnFJBIOLjzU5LIjYcNW/TCl7MTjYXEnFspdg==
X-Received: by 2002:a17:90b:1dd2:b0:2ff:6f8a:3a13 with SMTP id 98e67ed59e1d1-3030ff08e34mr1105261a91.25.1742505095920;
        Thu, 20 Mar 2025 14:11:35 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e14:7:c50a:4138:6122:653a? ([2a00:79e0:2e14:7:c50a:4138:6122:653a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf59e2desm4429935a91.23.2025.03.20.14.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 14:11:34 -0700 (PDT)
Message-ID: <9852e5a8-843d-48ae-90d0-7991628e93b3@google.com>
Date: Thu, 20 Mar 2025 14:11:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add support for Battery Status & Battery Caps AMS in
 TCPM
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Sebastian Reichel <sre@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-pm@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20250312-batt_ops-v1-0-88e0bb3129fd@google.com>
 <20250313-determined-wild-seahorse-f7871a@krzk-bin>
 <914a0df4-96d0-4cd4-ac87-3826fa9c1440@google.com>
 <3f65fe16-56f8-4887-bb91-994b181ce5a9@kernel.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <3f65fe16-56f8-4887-bb91-994b181ce5a9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/16/25 9:52 AM, Krzysztof Kozlowski wrote:
> On 15/03/2025 01:49, Amit Sunil Dhamne wrote:
>> Hi Krzysztof,
>>
>> Thanks for the review!
>>
>> On 3/13/25 1:50 AM, Krzysztof Kozlowski wrote:
>>> On Wed, Mar 12, 2025 at 04:42:00PM -0700, Amit Sunil Dhamne wrote:
>>>> Support for Battery Status & Battery Caps messages in response to
>>>> Get_Battery_Status & Get_Battery_Cap request is required by USB PD devices
>>>> powered by battery, as per "USB PD R3.1 V1.8 Spec", "6.13 Message
>>>> Applicability" section. This patchset adds support for these AMSes
>>>> to achieve greater compliance with the spec.
>>> Which board uses it? I would be happy to see that connection between
>>> batteries and USB connector on the schematics of some real device. How
>>> does it look like?
>> Any board that uses a USB Type-C connector that supplies power into or
> If you keep responding like this, you will got nowhere, so let me
> re-iterate:
>
> Which upstream DTS (or upstream supported hardware) is going to use this
> binding, so I can see how you are going to implement it there in the
> entire system?

This is for maxim,max33359 Type-C controller.

This would property would have been present for the connector present in 
the typec device for gs101-oriole board (that uses the max33359 
controller).

However, I will be exploring existing bindings to describe the 
relationship for now.

>> out of a battery while operating in sink or source mode respectively.
>> The VBUS is connected to the (battery + buck boost IC's CHGin/Vin) or a
>> companion IFPMIC connected to a battery.  In our board we have USB
>> Connector <-> IFPMIC <-> Battery.
> Which board is that?

gs101-oriole board.

Thanks,

Amit

>
> Best regards,
> Krzysztof

