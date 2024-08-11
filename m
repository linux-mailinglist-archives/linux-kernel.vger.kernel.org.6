Return-Path: <linux-kernel+bounces-282391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C5794E33F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 23:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029631F21F5B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 21:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7874D15C13B;
	Sun, 11 Aug 2024 21:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P1TPYG3h"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BFB157A7C
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723410521; cv=none; b=maqD+ivMcJSXJmDU6CxMCAoxwEYnSAYAmpU8bx9nj/m0+lUzOs/lX6lapFfUJ7MpeCbjw9cHH2EOeKwBgpojNz7Q7zSGMKKdvGjoQBZKBNx7Ca1SLzNITsjmMQCfZU9y4xpBXKURrin/8EGH0zUpWOdbiDbj8H5K2U6W79F8z9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723410521; c=relaxed/simple;
	bh=7Hn/bSp2BUJ6gXnNHyy9Z6qc19T+6O3qXRwkvzIv4dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3W+foTFucpxYt7XFahexNdQmsfvTBGXc4ohO29G2Cekt8359gZyK6Y2gsRDlzShkyY4GP5i8bWEaNrmt6iW8Sh2JbulIQ/QJ9S7hDTJxdyZKc2ib3LzLkWZtBhu4UKfWxhAkrqtO1+vRv8PzBUS8XJnGBttY9NZucOhYOZay5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P1TPYG3h; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc66fc35f2so32621475ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 14:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723410519; x=1724015319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ieHPyKsOEMGrUP0hwI39W1ByoYVFpablUCilTuIezJU=;
        b=P1TPYG3hvIZTUuWzPI8tTOvpmCAD0QID9iuyzR0bpdsCEHJY2DN3XhYMBnlm9xbp3y
         0+0q/bkiVET4ljnZdZ0HN6swAT46sMIBbe0YVUbAs0//Nw/DGjBv6ZgQ2ONy9K+r66bB
         h5dgGCqTC4FZIG8lfL/gGyOZDg5I/WbfkV4sU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723410519; x=1724015319;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieHPyKsOEMGrUP0hwI39W1ByoYVFpablUCilTuIezJU=;
        b=Oo/WJdHFeFJ0uFA1xIfPl4pWGRNjEW2blQC6Z41eFbx6KHOHjnzeZR9bIURQlS/Nfb
         HuUkIT2rRdT6EtxM2adHCt6qHhnaK2m6AQEwipAaWS+qNtg2SW2Thu4CwAgViZc2zFjN
         I6OmB17suNx68o/3nek7KeUN3ksYFqBmurmJTVi+/YDPncVsauOMJY5j3IOPLstJveN4
         /9cjCvBd9Xu4hs4yy0idFEPiQI3KETQTYM57O7x5E7PVJczFhbKvzU7tF81r5ihcJOZ+
         5BFIkLvkZ3r7PGY7i+L931OF9GWeN4j6XhfSRzIMX4wD93UUzpEBwofCQNl+QYlfMl58
         1jPg==
X-Forwarded-Encrypted: i=1; AJvYcCW90c1sEggA5RJJdT0lPCc/C0Ou536CydJZry4lEtC8mYTLg3xSxyEl2WLEu/AtTr3nMUW+MfClmGL4hCN0pgIdsquq0zgT3WcQfu6z
X-Gm-Message-State: AOJu0YxAmhKWlbSllW/ovfU78HPhtp7CwzxVVA7rwXdX0b0zXIKt77zT
	x04+9tmzf7liLZI08uzwm9haVYpamvV2xrEiJ6ODm6AI9r3HuhYh0wkmK86wWQ==
X-Google-Smtp-Source: AGHT+IFBBX2OgvowFrqdkgthVYHDyM4B72w+JBWFjYtLh1ieQuDGImIR0qaja9fp61TGHJOEIutTUQ==
X-Received: by 2002:a17:902:ce87:b0:1f2:fcc0:66f with SMTP id d9443c01a7336-200ae61a40emr99450965ad.31.1723410519439;
        Sun, 11 Aug 2024 14:08:39 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb7eed50sm26088775ad.10.2024.08.11.14.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 14:08:38 -0700 (PDT)
Message-ID: <40d5782e-6b04-40c9-9b44-6960cd61eff1@broadcom.com>
Date: Sun, 11 Aug 2024 14:08:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Support 'reg-io-width' property
 for shared memory
To: linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Cristian Marussi <cristian.marussi@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 arm-scmi@vger.kernel.org, james.quinlan@broadcom.com,
 justin.chen@broadcom.com, kapil.hali@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com
References: <20240810214621.14417-1-florian.fainelli@broadcom.com>
 <20240810214621.14417-3-florian.fainelli@broadcom.com>
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
In-Reply-To: <20240810214621.14417-3-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/10/2024 2:46 PM, Florian Fainelli wrote:
> Some shared memory areas might only support a certain access width,
> (e.g.: 32 bits accesses only). Update the shmem layer to support
> reading from and writing to such shared memory area using the specified
> I/O width in the Device Tree. The various transport layers making use of
> the shmem.c code are updated accordingly to pass the I/O width to the
> routines that need it.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
[snip]

> static void shmem_fetch_response(struct scmi_shared_mem __iomem *shmem,
> -				 struct scmi_xfer *xfer)
> +				 struct scmi_xfer *xfer,
> +				 u32 shmem_io_width)
>   {
>   	size_t len = ioread32(&shmem->length);
>   
> @@ -90,20 +144,19 @@ static void shmem_fetch_response(struct scmi_shared_mem __iomem *shmem,
>   	/* Skip the length of header and status in shmem area i.e 8 bytes */
>   	xfer->rx.len = min_t(size_t, xfer->rx.len, len > 8 ? len - 8 : 0);
>   
> -	/* Take a copy to the rx buffer.. */
> -	memcpy_fromio(xfer->rx.buf, shmem->msg_payload + 4, xfer->rx.len);
> +	__shmem_fetch_resp_notif_data(xfer, shmem, shmem_io_width);

As Justin pointed out to me separately, the source pointer is different 
for response and notifications, will fix that, too.
-- 
Florian


