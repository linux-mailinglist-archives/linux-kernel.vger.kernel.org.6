Return-Path: <linux-kernel+bounces-355714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E66CC9955FC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC851C2387E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0B120CCE2;
	Tue,  8 Oct 2024 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B20MH+Sy"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1D120C498
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 17:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409749; cv=none; b=Bl96k9U/cJ0QkQOxUkxQGKjO/d2pdJn9B698fokIxqiO0W+B+7KUuSf6NAvz8DLbidU/wgvxHmpzM20JokTgzsaeId8rbFmppbXSkVoOys+ierNRVF0kYXyK7lON/yANdOEKLurrg4GuLwP5OLZVu2NjvhtMbTVsnExj1IrF6B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409749; c=relaxed/simple;
	bh=/KF1w1wBRuHAADvZ6Jgja8NIekx9QCklwBG3hCI+kr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aj4sIBcnqS1/yMh6nzl2mhd+1zemfwNh/zRNLFDV8orPPly+BQzVDPOMmhfTMZGQIjWiH9sFf5DwRhofag+CVvOM9KAjY/Rd/ek2uqAJJsV+OUCv5Bci6PfwO8BwKU+JybjnIUlrX2ERTuJ3+7UPDJVz4Ny2WkDI+RvMuDRvDuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B20MH+Sy; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7ae3e3db294so339869285a.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 10:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728409746; x=1729014546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G4bto6OqX2TfQ2WCYygWiJZXBSBUXWs8ZGig2kin1vA=;
        b=B20MH+SyVnUI9u5q8FaDwIyIOA3QqwBwUjp/sxYRC/DVRgRqBPG85dkpe2vD4S5m8c
         zRfaF0htA6QK3g6zVvIy5ZVbjnNehquPHsjTIqk/IY2e727cNughc4XhUWS5iKECJSfo
         lh1xYH5h5k3j7Gvny2MUsoRRGuRVs/rTMoTAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728409746; x=1729014546;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4bto6OqX2TfQ2WCYygWiJZXBSBUXWs8ZGig2kin1vA=;
        b=xAlVPczORwx0h6kOQdVfRhrUBWN72q5DEK+DVFRUYkLOZ7TYG8h2lA2BNXDb97vCb7
         UQFismm7KquMzQ8Av5pOK1bveKsaWpEU7OBjKSjr1xK/FBcOAIcwqemJORII/dDHMSIN
         huZtRewPChc4M0UfGap2kAKT8JXp1WCCUjhTOsZLVQjiLUXNNmlHE/iAyxTCvd/oOfio
         TQNN93LxP3ZXv92wRfGqysIL9P6CHJnV7d11yX79FhXxhZH1SeZMPXUFf2GpaW+MeVOV
         eN+gCEpuOvx50Fc8rs0PBeQ69+f1j2rvIT53Xmjn7LIm2/QzE6DmnGerViY+B3quvB2t
         cRTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFxqHLOvUAOnhdZnEKVYbohPKhKEW0DPCYAVXdijhSy6Ed/KQLOOsOCgzOWo9G+jCqRytHSx9b6wu7X/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGjh42e9iFKg4BqzUqOs3iehwOn1LJ4PtqgJTgHC3K5DENH7PI
	q4nv9aQsR4Eu2QP0gYmPe8QgnTokSsQ9in7VG/QurJ+EE6j/Jy5UafZfFLoXJA==
X-Google-Smtp-Source: AGHT+IH6ylrbEpabA4BaGSJx+434/PYNDlVW3Txex91TG0rYeC2DKYOcG+0ZmIaI5/SdXtdvIcOJdQ==
X-Received: by 2002:a05:620a:1983:b0:7ac:9c07:e90 with SMTP id af79cd13be357-7ae6f4217f8mr2536447585a.12.1728409746050;
        Tue, 08 Oct 2024 10:49:06 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae7561642esm373607885a.12.2024.10.08.10.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 10:49:05 -0700 (PDT)
Message-ID: <ecc29852-37f4-404e-b22c-817cb7cb0cfb@broadcom.com>
Date: Tue, 8 Oct 2024 10:49:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: arm_scmi: Give SMC transport precedence over
 mailbox
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
 linux-arm-kernel@lists.infread.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE"
 <arm-scmi@vger.kernel.org>,
 "moderated list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE"
 <linux-arm-kernel@lists.infradead.org>, justin.chen@broadcom.com,
 opendmb@gmail.com, kapil.hali@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, Arnd Bergmann <arnd@arndb.de>
References: <20241006043317.3867421-1-florian.fainelli@broadcom.com>
 <ZwPLgcGeUcFPvjcz@pluto> <a4f403e8-44eb-4fb4-8696-ca8ad7962a00@broadcom.com>
 <ZwUuSTYkWrZYIcBM@bogus>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <ZwUuSTYkWrZYIcBM@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 06:06, Sudeep Holla wrote:
> Hi Florian,
> 
> Thanks for the detailed explanation.
> 
> On Mon, Oct 07, 2024 at 10:07:46AM -0700, Florian Fainelli wrote:
>> Hi Cristian,
>>
>> On October 7, 2024 4:52:33 AM PDT, Cristian Marussi
>> <cristian.marussi@arm.com> wrote:
>>> On Sat, Oct 05, 2024 at 09:33:17PM -0700, Florian Fainelli wrote:
>>>> Broadcom STB platforms have for historical reasons included both
>>>> "arm,scmi-smc" and "arm,scmi" in their SCMI Device Tree node compatible
>>>> string.
>>>
>>> Hi Florian,
>>>
>>> did not know this..
>>
>> It stems from us starting with a mailbox driver that did the SMC call, and
>> later transitioning to the "smc" transport proper. Our boot loader provides
>> the Device Tree blob to the kernel and we maintain backward/forward
>> compatibility as much as possible.
>>
> 
> IIUC, you need to support old kernel with SMC mailbox driver and new SMC
> transport within the SCMI. Is that right understanding ?

That is correct.

> 
>>>
>>>>
>>>> After the commit cited in the Fixes tag and with a kernel
>>>> configuration that enables both the SCMI and the Mailbox transports, we
>>>> would probe the mailbox transport, but fail to complete since we would
>>>> not have a mailbox driver available.
>>>>
>>> Not sure to have understood this...
>>>
>>> ...you mean you DO have the SMC/Mailbox SCMI transport drivers compiled
>>> into the Kconfig AND you have BOTH the SMC AND Mailbox compatibles in
>>> DT, BUT your platform does NOT physically have a mbox/shmem transport
>>> and as a consequence, when MBOX probes (at first), you see an error from
>>> the core like:
>>>
>>>     "arm-scmi: unable to communicate with SCMI"
>>>
>>> since it gets no reply from the SCMI server (being not connnected via
>>> mbox) and it bails out .... am I right ?
>>
>> In an unmodified kernel where both the "mailbox" and "smc" transports are
>> enabled, we get the "mailbox" driver to probe first since it matched the
>> "arm,scmi" part of the compatible string and it is linked first into the
>> kernel. Down the road though we will fail the initialization with:
>>
>> [    1.135363] arm-scmi arm-scmi.1.auto: Using scmi_mailbox_transport
>> [    1.141901] arm-scmi arm-scmi.1.auto: SCMI max-rx-timeout: 30ms
>> [    1.148113] arm-scmi arm-scmi.1.auto: failed to setup channel for
>> protocol:0x10
> 
> IIUC, the DTB has mailbox nodes that are available but fail only in the setup
> stage ? Or is it marked unavailable and we are missing some checks either
> in SCMI or mailbox ?

We fail at scmi_chan_setup -> idr_find() returning -EINVAL. I did check 
that returning -ENODEV, which arguably might be a somewhat more accurate 
return code (-ENOENT being one, too) does not help us here. Cristian 
suggested device_release_driver() which sounded like a good idea, but 
will deadlock.

The reason why we fail there is because mailbox_chan_available() returns 
false. With fw_devlink=on Linux will parse the Device Tree, find the 
'mboxes' property pointing to the brcm_scmi_mailbox Device Tree node and 
puts it on a list of providers that it is waiting for.

Because we are using the ARM SMC transport however, the 
brcm_scmi_mailbox node is never backed by any driver in Linux and this 
causes the system to fail booting since we do not have any SCMI 
provider. At the time, because we were under pressure to get a GKI 
kernel we decided to "break" our older downstream kernels by doing this 
property rename and put in a patch in those kernel to treat 
"brcm,mboxes" the same as "mboxes" where relevant, which was mostly in SCMI.

Now, assuming that we revert that DT property rename, that still does 
not really solve anything anyway, the channel is not available 
regardless of how we shake it.

> 
> IOW, have you already explored that this -EINVAL is correct return value
> here and can't be changed to -ENODEV ? I might be not following the failure
> path correctly here, but I assume it is
> 	scmi_chan_setup()
> 	info->desc->ops->chan_setup()
> 	mailbox_chan_setup()
> 	mbox_request_channel()
> 
>> [    1.155828] arm-scmi arm-scmi.1.auto: error -EINVAL: failed to setup
>> channels
>> [    1.163379] arm-scmi arm-scmi.1.auto: probe with driver arm-scmi failed
>> with error -22
>>
>> Because the platform device is now bound, and there is no mechanism to
>> return -ENODEV, we won't try another transport driver that would attempt to
>> match the other compatibility strings. That makes sense because in general
>> you specify the Device Tree precisely, and you also have a tailored kernel
>> configuration. Right now this is only an issue using arm's
>> multi_v7_defconfig and arm64's defconfig both of which that we intend to
>> keep on using for CI purposes.
>>
>>
>>>
>>> If this is the case, without this patch, after this error and the mbox probe
>>> failing, the SMC transport, instead, DO probe successfully at the end, right ?
>>
>> With my patch we probe the "smc" transport first and foremost and we
>> successfully initialize it, therefore we do not even try the "mailbox"
>> transport at all, which is intended.
>>
>>>
>>> IOW, what is the impact without this patch, an error and a delay in the
>>> probe sequence till it gets to the SMC transport probe 9as second
>>> attempt) or worse ? (trying to understand here...)
>>
>> There is no recovery without the patch, we are not giving up the arm_scmi
>> platform device because there is no mechanism to return -ENODEV and allow
>> any of the subsequent transport drivers enabled to attempt to take over the
>> platform device and probe it again.
>>
> 
> OK this sounds like you have already explored returning -ENODEV is not
> an option ? It is fair enough, but just want to understand correctly.
> I still think I am missing something.

Yes, that was my first start.

> 
> I understand the bootloader maintaining backward compatibility, but
> just want to understand better. I also wonder if the old SMC mailbox driver
> returns -EINVAL instead of -ENODEV ? Again it is based on my assumption
> about your backward compatibility usecase.

The old SMC mailbox driver is not present in any upstream kernel, and on 
the downstream kernels where we need it, it would be used and not return 
an error.
-- 
Florian

