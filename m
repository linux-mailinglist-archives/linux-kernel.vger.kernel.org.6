Return-Path: <linux-kernel+bounces-374826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF78A9A70B6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2552C1C21BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13BA1EB9EE;
	Mon, 21 Oct 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bevb8mYo"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83C81E8852
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530711; cv=none; b=Bl9WKI+h3onKX0JZGCgCTlJKiW25Kr1zlx6xDYHB4SHzQ04iK4s3b1qQxc+kq7eAVrPD0pWlG5lTdzZlayphTI0V6luiuJjUdSSZDrNJMGa+/0q0+IAWGXHgw5eRoQcMlIdYw+tMZiYo0TKTWul5MGglDhRvLELM6mNUdGK3C0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530711; c=relaxed/simple;
	bh=Mk4+kSBX5o2Fgx3BcrDmQ1DaLSs9iJ9r7vjPx6iskiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojIHr0zI0fIZeUYCDZEsoRAHwutqDQ/ncyhwGVt+aU74NnMO3ES61rWD008sa/a4luq0ieu4gpXG+Glv6SGlPmMbGM/Von6tbSeaXGIJWFSO9ax8KB7L2gTeV+DNe0JRqfy6SDaitEz/M1TLghI7YXtCxKnHBbznpp+XdzvslpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bevb8mYo; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b1601e853eso177548985a.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729530709; x=1730135509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3DvZOKHCzDgJ0PXhBkO9wq63UJ8r5xTKcFkxa96sMsA=;
        b=bevb8mYo/XLB45LM3cvaL4IDrll83AH5jun3TEvipEjJ0f3HH2v+VsxD1wTAJbP4Eb
         oOipxT9ioxHya+YNVOrFhRLGYdNcgLJRTBOerT+Ydhy6qtOuf023XsrpdF6rtloIHa2x
         IDWAiSbl//QeayYAOVom7NFPr5U6MZ+MV11+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729530709; x=1730135509;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DvZOKHCzDgJ0PXhBkO9wq63UJ8r5xTKcFkxa96sMsA=;
        b=J+Hu4jntFarJgMyglkZ/eDf2fSS0I7ipFjUPKz5COPWQ0F/rZChFkc4m0zffWZxQT6
         Ouu0c+7OIahO+pa7k4uvTQ2yV6Hz7QWjapcOHbG7ejaRDMAmJ+aKWVA+nspOKM9P6+SE
         Q4Hag0gRsHdlBKJsFUaNNn2H7siRlPMCmwr9T3H/9gaDT1ARd8Av4RKLieI8msnBDodZ
         GKTQB5VaX+KETS4KgkGKbVGiR9J+8pzc6BXWVpL9KzQkUiEECJZNM3Etju0ktHAZ6Bmh
         0TzS86eAy06ORSp0idDbNYN+URisDrQVW/xCBF3nb3Nbf8eTCJcX6ba2SgEIHNMii6Ed
         jZXg==
X-Forwarded-Encrypted: i=1; AJvYcCWRHUsTbwpeKatZhuUkEHrKDVxlk/2nF5jCc4RMblcy5ad0lyqeUUgX7w+bSjl2KE+n9xopHKI2nyqKgAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZvNOX9bJhkmChKakGUoMMJFeA6mQrm11oBoBX9mZVjf3I3/Ru
	BkyadcUzPvRyGaa7Wt3apDQiPbBkf+SvDRGf4/LCBzGa5FGnXBMHoLHEX/YRB5UySLz9qCfh/qg
	rZQ==
X-Google-Smtp-Source: AGHT+IFtfEeEaq47YRn59V3KJT9oC3Me2huEYSiIVEr4Uj9v0Dz054nf2XU8CSgucYrcddn9KZNhEw==
X-Received: by 2002:a05:620a:3727:b0:7b1:1013:c256 with SMTP id af79cd13be357-7b157b76983mr1705023885a.38.1729530708754;
        Mon, 21 Oct 2024 10:11:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a78a56sm189813885a.112.2024.10.21.10.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 10:11:47 -0700 (PDT)
Message-ID: <5d6d545d-b6bc-4b37-b324-a664e4685100@broadcom.com>
Date: Mon, 21 Oct 2024 10:11:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] firmware: arm_scmi: Account for SHMEM memory
 overhead
To: Cristian Marussi <cristian.marussi@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com,
 vincent.guittot@linaro.org, etienne.carriere@st.com, peng.fan@oss.nxp.com,
 michal.simek@amd.com, quic_sibis@quicinc.com, quic_nkela@quicinc.com,
 dan.carpenter@linaro.org
References: <20241021170726.2564329-1-cristian.marussi@arm.com>
 <20241021170726.2564329-2-cristian.marussi@arm.com>
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
In-Reply-To: <20241021170726.2564329-2-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/24 10:07, Cristian Marussi wrote:
> Transports using shared memory have to consider the overhead due to the
> layout area when determining the area effectively available for messages.
> 
> Till now, such definitions were ambiguos across the SCMI stack and the
> overhead layout area was not considered at all.
> 
> Add proper checks in the shmem layer to validate the provided max_msg_size
> against the effectively available memory area, less the layout.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> Note that as a consequence of this fix the default max_msg_size is reduced
> to 104 bytes for shmem-based transports, in order to fit into the most
> common implementations where the whole shmem area is sized at 128,
> including the 24 bytes of standard layout area.
> 
> This should have NO bad side effects, since the current maximum payload
> size of any messages across any protocol (including all the known vendor
> ones) is 76 bytes.

This looks good to me, just a small nit/suggestion:

[snip]

>   	size = resource_size(res);
> +	if (cinfo->max_msg_size + SCMI_SHMEM_LAYOUT_OVERHEAD > size) {
> +		dev_err(dev, "misconfigured SCMI shared memory\n");
> +		return IOMEM_ERR_PTR(-ENOSPC);
> +	}
> +
>   	addr = devm_ioremap(dev, res->start, size);
>   	if (!addr) {
>   		dev_err(dev, "failed to ioremap SCMI %s shared memory\n", desc);
> diff --git a/drivers/firmware/arm_scmi/transports/mailbox.c b/drivers/firmware/arm_scmi/transports/mailbox.c
> index e7efa3376aae..4e0396250ad0 100644
> --- a/drivers/firmware/arm_scmi/transports/mailbox.c
> +++ b/drivers/firmware/arm_scmi/transports/mailbox.c
> @@ -16,6 +16,8 @@
>   
>   #include "../common.h"
>   
> +#define SCMI_MAILBOX_MAX_MSG_SIZE	104

This IMHO, could be named SCMI_SHMEM_MAX_PAYLOAD_SIZE and used across 
all 3 transports that are loosely SHMEM-based?
-- 
Florian


