Return-Path: <linux-kernel+bounces-353917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0563993471
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDAC2832C2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ED01DC746;
	Mon,  7 Oct 2024 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iG+/w1Pd"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B511DC721
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320871; cv=none; b=Cv4KwHevLPmRVh3y62g5b5cqPHPPM7CgOfb57vgmrxagUdGLAZY49L9DN7wCsvRg9YzGR2X/RsRYWKgwUxw7WWhgx31D8rCwNzsIQ1Yi7/e9q8S6cRb3OksTuEbKj5WAsHaPiXfVnU+63dApuzom7dcrL2m37Bw0jrcIQQ5NqPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320871; c=relaxed/simple;
	bh=OOMuuH5IlYxEWqct0FimV+HnzWKOtW4Vj1nW5sw4X98=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PxlO1O5XnwUVgnwwIaezktsKMUq9SQl79eRSxq2eMZk/Xcr1xMXQGUMKR6zY/uVyBliVNjwmECu6t7QYEhvvnGtsHljcPExSzc5cHg8EMOuaHqv7p2J0SrxSDL3ttf7StxVa4lGuXJHpyQYzgCRK1Wj8EO3ODsTe5ft5G2nWyGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iG+/w1Pd; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e091682cfbso3472214a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 10:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728320869; x=1728925669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1Xsz1cKkpJKzKS5NgU8P9HM5AvWEcAQxgUYBZ/hb0Eo=;
        b=iG+/w1PdgxjyZNcJcG8GH98ZJj/iTyRWQf3/sX2v/D+WL9/RqNZnR1ktbNCqwUBsi0
         Rh9T2xZcWfrnwr4Rah4bOTACwuus37rU2D5JBZkd0jHBoIlUiSxZKIeHUuwekxWxnBtY
         BkCund25RwKOlBbcIdrJ8LawlpvJVdTUM8QM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728320869; x=1728925669;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Xsz1cKkpJKzKS5NgU8P9HM5AvWEcAQxgUYBZ/hb0Eo=;
        b=E0QG29fub1BmpX/vxK4fm9oaHjcqI6uW/mhaI0MdLJX6rP+5bwlPHIjerG6UovSpRg
         mR4ppoWDLzUXyYrWoBQ9+YKGYftYPVeVsOQQ1dF5p9Pu0Cpnjitb9o6XvhVL+YrtHgLG
         Km9rd1EhKktpBW9HLdmCd7iNSFmtE1ny90WCMTdEx6dy72auD8bPba74oJb+MVs1cuPy
         XJophQozmrTHYJ9lBjnAINnsKMVmffJxi8TkLjcMo1B1IsTZbeESKlgrYVUg2N97ZwKU
         lmU0eN4mx9Z9xLd0CfUwqZsaL0WDq4fwpmgDVWMUEvV18McuvedEFiYX33f9EIVwXPBb
         b4zg==
X-Forwarded-Encrypted: i=1; AJvYcCUwogy5lynBZaehMSKDa5O3HDKh0Z5URcPF5IfCkw9ENSZlvJ1F3D5J+PoVq9t3RLovCK3W9VkHaeijZKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE3DQFeiO2XlGCUPgjnJhjvBTE4dsncc53BbnGHaxdKG7EViTR
	npPXvCxD8yDlO5o6Inswmvph8bnwIypOC/XwNvbom9YMZAo2f2XQu50T5KAd4w==
X-Google-Smtp-Source: AGHT+IGafgSzyj7H334JaowYq/bSl0luswUi03Ck5xtcg5AC+8GL0Qp4QvzU6hyPq89Q2aXo/BBkdg==
X-Received: by 2002:a17:90a:ce87:b0:2c9:649c:5e08 with SMTP id 98e67ed59e1d1-2e1e6226d7bmr13956400a91.15.1728320869018;
        Mon, 07 Oct 2024 10:07:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85d96bfsm7420819a91.27.2024.10.07.10.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 10:07:48 -0700 (PDT)
Message-ID: <a4f403e8-44eb-4fb4-8696-ca8ad7962a00@broadcom.com>
Date: Mon, 7 Oct 2024 10:07:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH] firmware: arm_scmi: Give SMC transport precedence over
 mailbox
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-arm-kernel@lists.infread.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE"
 <arm-scmi@vger.kernel.org>,
 "moderated list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE"
 <linux-arm-kernel@lists.infradead.org>, justin.chen@broadcom.com,
 opendmb@gmail.com, kapil.hali@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, Arnd Bergmann <arnd@arndb.de>
References: <20241006043317.3867421-1-florian.fainelli@broadcom.com>
 <ZwPLgcGeUcFPvjcz@pluto>
Content-Language: en-US
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
In-Reply-To: <ZwPLgcGeUcFPvjcz@pluto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Cristian,

On October 7, 2024 4:52:33 AM PDT, Cristian Marussi 
<cristian.marussi@arm.com> wrote:
>On Sat, Oct 05, 2024 at 09:33:17PM -0700, Florian Fainelli wrote:
>> Broadcom STB platforms have for historical reasons included both
>> "arm,scmi-smc" and "arm,scmi" in their SCMI Device Tree node compatible
>> string.
>
>Hi Florian,
>
>did not know this..

It stems from us starting with a mailbox driver that did the SMC call, 
and later transitioning to the "smc" transport proper. Our boot loader 
provides the Device Tree blob to the kernel and we maintain 
backward/forward compatibility as much as possible.

>
>> 
>> After the commit cited in the Fixes tag and with a kernel
>> configuration that enables both the SCMI and the Mailbox transports, we
>> would probe the mailbox transport, but fail to complete since we would
>> not have a mailbox driver available.
>>
>Not sure to have understood this...
>
>...you mean you DO have the SMC/Mailbox SCMI transport drivers compiled
>into the Kconfig AND you have BOTH the SMC AND Mailbox compatibles in
>DT, BUT your platform does NOT physically have a mbox/shmem transport
>and as a consequence, when MBOX probes (at first), you see an error from
>the core like:
>
>    "arm-scmi: unable to communicate with SCMI"
>
>since it gets no reply from the SCMI server (being not connnected via
>mbox) and it bails out .... am I right ?

In an unmodified kernel where both the "mailbox" and "smc" transports 
are enabled, we get the "mailbox" driver to probe first since it matched 
the "arm,scmi" part of the compatible string and it is linked first into 
the kernel. Down the road though we will fail the initialization with:

[    1.135363] arm-scmi arm-scmi.1.auto: Using scmi_mailbox_transport
[    1.141901] arm-scmi arm-scmi.1.auto: SCMI max-rx-timeout: 30ms
[    1.148113] arm-scmi arm-scmi.1.auto: failed to setup channel for 
protocol:0x10
[    1.155828] arm-scmi arm-scmi.1.auto: error -EINVAL: failed to setup 
channels
[    1.163379] arm-scmi arm-scmi.1.auto: probe with driver arm-scmi 
failed with error -22

Because the platform device is now bound, and there is no mechanism to 
return -ENODEV, we won't try another transport driver that would attempt 
to match the other compatibility strings. That makes sense because in 
general you specify the Device Tree precisely, and you also have a 
tailored kernel configuration. Right now this is only an issue using 
arm's multi_v7_defconfig and arm64's defconfig both of which that we 
intend to keep on using for CI purposes.


>
>If this is the case, without this patch, after this error and the mbox probe
>failing, the SMC transport, instead, DO probe successfully at the end, right ?

With my patch we probe the "smc" transport first and foremost and we 
successfully initialize it, therefore we do not even try the "mailbox" 
transport at all, which is intended.

>
>IOW, what is the impact without this patch, an error and a delay in the
>probe sequence till it gets to the SMC transport probe 9as second
>attempt) or worse ? (trying to understand here...)

There is no recovery without the patch, we are not giving up the 
arm_scmi platform device because there is no mechanism to return -ENODEV 
and allow any of the subsequent transport drivers enabled to attempt to 
take over the platform device and probe it again.

Thanks!
--
Florian

