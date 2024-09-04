Return-Path: <linux-kernel+bounces-315586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5339696C47C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A13B1F24BA8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1EF1E0B8C;
	Wed,  4 Sep 2024 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hnoMTIeP"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E41A4778C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468954; cv=none; b=M+oPNBigwNmp0vuDtE4Lw9aoFXyxrSAlOKZW6G1eh2kCqPcAJxfZHmJaWXK4YYiGRyCKSkhGJsmDwXwjB14g74nHCL2gyFycRHF0D3jZ9YGoquk1kaBYmN+ukOiBcXs7dydfpUJyGHp/NOUGMWuwp+UxX4KxiyekfwzuWhZ+R88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468954; c=relaxed/simple;
	bh=tpbc6MzDLkqXDnv8L0UfBuzo0UTvSaG2dQtmH6H3UB8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=abiGUIetQ/5wxYsSF6Rw6e4n+veMBIaWsq6RNDYaIPGQ0rvDZzcqGLwALlFyNOsfEIbWvAzEyneHbehsI+QdIg5dPqHO9rTvlygZeOqyB5ndLnnyxq5leIFO9R0sN+bCXsDfJNIVyaNZatt198JV1Vca0j9ICoId8PbvHCPUm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hnoMTIeP; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a9782651bdso79304685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 09:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725468952; x=1726073752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FHAijoASNp+gJRk6KrYMDvs2NpHhscFYYgL4xfA1Ej0=;
        b=hnoMTIePPgGvEWRMmvBVDo/jGaFtaG7x3+au87GxUbm6tin1+rgkAySH4eOeURCvQL
         77NdZAZBdfOF2MEc0k5CipMJ58aJ9VPs/9pCLxINbxcs2TlciymK9cmrFfs07fUV9ptU
         DLLrJg4sU2Rj5lAuqcpY2hqj12pAHLWiTnG+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725468952; x=1726073752;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHAijoASNp+gJRk6KrYMDvs2NpHhscFYYgL4xfA1Ej0=;
        b=TazRE+KAlk263aP11WDgZbDeKiQ37j4wyrBGKpl2v+gUyjmIjgBtnzyFpPAez3Sj4g
         SM2Gh+LxraTqzOUh0FyF/MwHY5yKXHhkoW03mFv/CekHbgcV9wyZ0lCICrb6yXkkNfDu
         rqUtiXXPHoeq+GUXM2p8s7D/bdVX+9MXnGC82trDA8TWQkEi+Jm4h7eyCc667rCdgoup
         HNyXfFRH7kRtOAPRq1R1WfP/5FefbvRFnxRFfzfkbxxMjrAUKELov+Nf89ZeAwSO6/ka
         7m4jpJ3LTDiP9KpvZe8Ul4tGIYiNE56Qmr77SRxF4XCtABHGRONyGt8OdEZ83Hr/ZiYq
         gkUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmHVXNUxss7Hgl3/tsVLozMFkNNyJwqPk7Cdvftgpzx8R4/+Z8sAK5UW2FuUkgzElg96Q3Kyy1GLYekzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyh7dXUMrVohEp4PJXYHgf0LvTFnwpoGMH3Jjv6SuqkRhg1XEY
	we8h0R1fDlpkmB2aognpP8YXOnZFPREBLkJ7SnacTKFDWyTxQarOBR9farN+Bg==
X-Google-Smtp-Source: AGHT+IFTCSaYeyRsECdDZKJj9c6nIvWUrYvHfZJxoUXUZVWGhMsEbo3lPglw+z9Mhq6dD7+ks4oGrA==
X-Received: by 2002:a05:6214:21ca:b0:6c3:575a:a975 with SMTP id 6a1803df08f44-6c518de50e9mr39113966d6.2.1725468952203;
        Wed, 04 Sep 2024 09:55:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340c97b14sm64989626d6.77.2024.09.04.09.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 09:55:51 -0700 (PDT)
Message-ID: <159c5fcf-709d-42ba-8d45-a70b109fe261@broadcom.com>
Date: Wed, 4 Sep 2024 09:55:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: florian.fainelli@broadcom.com
Subject: Re: [PATCH next] PCI: brmstb: Fix type mismatch for num_inbound_wins
 in brcm_pcie_setup()
To: Riyan Dhiman <riyandhiman14@gmail.com>, jim2101024@gmail.com,
 nsaenz@kernel.org, lorian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240904161953.46790-2-riyandhiman14@gmail.com>
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
In-Reply-To: <20240904161953.46790-2-riyandhiman14@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 09:19, Riyan Dhiman wrote:
> Change num_inbound_wins from u8 to int in brcm_pcie_setup() function to correctly
> handle potential negative error codes returned by brcm_pcie_get_inbound_wins().
> The u8 type was inappropriate for capturing the function's return value,
> which can include error codes.
> 
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>

This looks fine, however it seems like we could either:

- update brcm_pcie_get_inbound_wins() to take a reference to an u8 and 
assign num_inbound_wins directly plus return a negative error code

or

- update brcm_pcie_get_inbound_wins() to return 0 when encountering an error

We should have at least 1 inbound window to operate this PCIe 
controller, so if we get 0, nothing useful is going to happen.

Deferring to Jim as to whether he prefers to take your patch or fix it 
in a different way. Thanks!
-- 
Florian

