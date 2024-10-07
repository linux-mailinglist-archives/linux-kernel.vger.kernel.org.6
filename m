Return-Path: <linux-kernel+bounces-353865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BC49933CB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ABE51F2464E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854DC1DC1A6;
	Mon,  7 Oct 2024 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XQQU2T1O"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E121DC18F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319633; cv=none; b=WoI6L7rfF1JIWdz770YHEsGjh6y8mEU99agEYZolQ2aDcJvjZukPuGIJi27ql8/sR7FaiImkNvcgg9HcmNCzNF02F5NkYEUSxxFzQeCMUXS/yCVFk+xNR0HGPRWhPzdv+ShDsOHY5OiYxveaPvVzLL8aVTM1b70VhJP/PpZrPEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319633; c=relaxed/simple;
	bh=2JvOXnCE8q45yOzYM4/Se7vLDg7oF4TeQX5icNd5G/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QeSP873GfaQXdSap6XwLneBN6T+SmHRKX5FG1c0DSD7SIRq7/xFfcPzxc+k54StUT309Etv5yqLH85pWqwC9UQoXXBmGxkQ4zOlcU/Bh0a836NERYHj5CYmo5eQcZIfDDlYJG7e6DgE+bXlOAmvXj6N5W5Wsy0S+sXBLJlqYVVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XQQU2T1O; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cb7f5f9fb7so50277886d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728319630; x=1728924430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S9CjsSMRTcKaZhkjpOoFNmBuBgqEpMntZNfMT8VgpNk=;
        b=XQQU2T1OZjwquxK9ZOtH5oCvZMfEgWIWHByMH41G4SK0LSrH34snMtWjyZHQuxQgu8
         LUp+capu++xnxrhs6XvNOHxjwE0hlpVHS4MtaOx86UGYhpKmbGtY9ysKL1zfbAJPQJ/6
         nrsblxPeUwlal26/pyIZlgRhmnv7FDRARMT5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728319630; x=1728924430;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9CjsSMRTcKaZhkjpOoFNmBuBgqEpMntZNfMT8VgpNk=;
        b=c+dCHQpKwGwBEBAK+VYLHmC82qp+fninZ3cRcRMQkiWIW78EauLbkMkVZXoA3ktGOM
         UJCWV+0exQIIOlxAAqR4xU1QLGhMW1f0SP1pE/vRol7Lkj8CXQoyvPcMTJIjRJfynwfg
         2vy4eNRFasdm6RRDXhiPKxceo5N/8ISUJwYIWD+vxJx76+hEkgl8sIFk8p+JhGKAJrEk
         FvkHb1EiFctpv3HVCMIrL32uGOE/C6hYfgUm81wGP/41AwS44yiC32f0eN37MA38MKzk
         qVlIcpz/BGDfnMaWR/6LubsG9KI3BuKAqTsWI0YFmLYXza2uz45LQ9LiCkYPlcmlfLMw
         vNfg==
X-Forwarded-Encrypted: i=1; AJvYcCVakOs/l9+OCXg9RA/OqLZPMkzJaMbcvxLAiNcgPwpJlEdpeKtD5rIQwa1siGZFbpjNyjgIIX+mfHDkmLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX5s9dbXQPDDpFavwnoCKDU+URNqfxhsNCgXoB8SPQ0fZ7wmMk
	3pZ734wwGzcWS6cw2b4gZeXI3doSDSMyS/00jOKNbr3TzpfGYg7mFaXDTxrtWA==
X-Google-Smtp-Source: AGHT+IGkzDBDte/43eYOd/aigjOKOeHrGPpTVqz8vfZIpAXJNx38FHSgFi1MXbXtmwfxAGzq41Ah1A==
X-Received: by 2002:a05:6214:4a87:b0:6cb:b7ea:2072 with SMTP id 6a1803df08f44-6cbb7ea20a2mr28174736d6.1.1728319630398;
        Mon, 07 Oct 2024 09:47:10 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba475142dsm26725486d6.102.2024.10.07.09.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 09:47:09 -0700 (PDT)
Message-ID: <17593cd5-e188-4146-8e4b-c87ce48e1140@broadcom.com>
Date: Mon, 7 Oct 2024 09:47:06 -0700
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
Cc: linux-arm-kernel@lists.infread.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE"
 <arm-scmi@vger.kernel.org>,
 "moderated list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE"
 <linux-arm-kernel@lists.infradead.org>, justin.chen@broadcom.com,
 opendmb@gmail.com, kapil.hali@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, Arnd Bergmann <arnd@arndb.de>
References: <20241006043317.3867421-1-florian.fainelli@broadcom.com>
 <ZwPeiUwT7OAgxXFl@bogus>
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
In-Reply-To: <ZwPeiUwT7OAgxXFl@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 06:13, Sudeep Holla wrote:
> On Sat, Oct 05, 2024 at 09:33:17PM -0700, Florian Fainelli wrote:
>> Broadcom STB platforms have for historical reasons included both
>> "arm,scmi-smc" and "arm,scmi" in their SCMI Device Tree node compatible
>> string.
>>
> 
> I assume in the same order.

That is correct, in that exact order indeed.

> 
>> After the commit cited in the Fixes tag and with a kernel
>> configuration that enables both the SCMI and the Mailbox transports, we
> 
> ^^^^^ s/SCMI/SMC ?

Yes, this should read "SMC" here.

> 
>> would probe the mailbox transport, but fail to complete since we would
>> not have a mailbox driver available.
>>
> 
> I always assumed the node compatible match happens from the more specific
> compatible(on the left) to the more generic ones(on the right) from the
> compatible property list. Looks like that was a wrong assumption then ?

This is the correct assumption, and this worked very well, and we were 
utilizing that as long as all of the transports where "sub" entities 
within the common and single arm_scmi platform device.

When breaking up the transports into individual platform drivers, now 
each one is responsible for matching, and if they are all built-into the 
kernel, they are matching in the order in which they have been linked 
into the kernel.

> 
>> By keeping the SMC transport objects linked first, we can let the
>> platform driver, match the compatible string and probe successfully with
>> no adverse effects on platforms using the mailbox transport.
>>
> 
> I don't have strong objection to the patch itself, happy to get it merged.
> Just curious if my understanding of the issue is correct. I think Cristian
> has more detailed query, so just responding to that will suffice.

Sounds good, thanks.

> 
>> Fixes: b53515fa177c ("firmware: arm_scmi: Make MBOX transport a standalone driver")
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> Change-Id: I8e348e3e0deabdc5c1d596929d7f9134793f346e
> 
> Spurious from internal gerrit repo ?

Indeed, will post v2 with the typo you highlighted and that remove, and 
any additional explanation Cristian deems necessary to add, thanks!
-- 
Florian

