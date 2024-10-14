Return-Path: <linux-kernel+bounces-364472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B233299D510
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDEE4B25AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE811AD3F6;
	Mon, 14 Oct 2024 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ctQVpgpY"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB011AF4F6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728924990; cv=none; b=hwDGGR9nVfPdiBwDtLB5uIU+uCIe8i4mlOpDhbbTkMzgTNEdZGTXTdaBJQP7EfDyiNv9Izkyr5sJX4H/CxNu2eBujNk4FtTB+wmeT8bboB2Q9D8ojTyNLHh04OWv7NlErbNmNM8loeSFP8eDe0s5h0nDr9OOs8uDZc+hxiV9uYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728924990; c=relaxed/simple;
	bh=k8fFu63Mnqa9R96BH6wgTaXjgAGSuyRmS3aedznynuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ul5yVL7L1eZ9ECZJKLnPpAFk4Hj2e41zM8N2e4H2/3UnmoGmV+rxT/hdKondY/dXIAuVL/XTM2cwWlXLewZ3OrSafFvBw5kKw8cku4a6eSpV53A4jOE5DDEpVM2pMEJLVosIU0umwDlbXvcCoIWL7NqsXj/ON2JUlWo4EXyv2CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ctQVpgpY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cdbe608b3so11001965ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728924987; x=1729529787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XshrvEkrWmKQRy64hShoDm58Lk89RKJKAsS7vcs1Ows=;
        b=ctQVpgpYbs9koz11JffTjs34OqY+lbUI92CTXcGHQLnBTVUBCqMZ++ohQrjcqj28F+
         NPFfh8UrU7GuBsIWtQ9x8m6hdfCzkHKALZD0/M/ngD4BvBcl87pyB/GdXf5XFzafbfEf
         PhyM1mRHzA9GRziIf5ykIJFKoyYngoL0fMDyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728924987; x=1729529787;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XshrvEkrWmKQRy64hShoDm58Lk89RKJKAsS7vcs1Ows=;
        b=LDdnfrMowyr/Vg0C3UrdzSTLyGiO2ZhCFeUXNTY0IiL661/t8ajD4xIeY2qZes9ai+
         G8EPd4AALxrZUxSW8/3MX/f3h10PnDVMpS78OwPy2+WVP76PFiJefaz5DEPVgP/pE+eA
         sw1B23CRi9HonKHRFZiC1afs/NpOQjOUNrqTRJ1IsWT03CmQXiUCD0mUASwcqMmcmXFb
         /8yAlvqt7WesSCoItEG99FCw8blNm1I7EqFgroY3CYxXLKL5GRtKSUcD5tGWFwnyiX9A
         jBCu8hGXQHQKHwkQNfKPGzcgTMEiTCBDYcfdjME7PgXSIwEvfav0sQWGpccGojOHBVEO
         CcPw==
X-Forwarded-Encrypted: i=1; AJvYcCUSc8PS0Uh4uCqFiW+m/V9rYKWGr/E6ZiKT4kU/PghWIlq6lvkWbTzrDlW1Sut3LO9Kq74AJ6YqyQt4f64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf0VrXKBMtpkxKYIbW7DyJtGYI9S+cRXOMINBkGn9bkF1b/RWL
	lBx4gsKs6kYg17ejMToV6kEEi+bgBvWF5CG9jXUVdGyD+JIJ0L9pI95GDRCsYg==
X-Google-Smtp-Source: AGHT+IEBwtkMuz59Zc84AsR0slLKr5kYtqrxnj7DgZmB2A+4e91Eecm9SOzZie3yc4k87AzSEQqbPg==
X-Received: by 2002:a17:903:190:b0:20c:f648:e39e with SMTP id d9443c01a7336-20cf648e4f7mr36987285ad.58.1728924987323;
        Mon, 14 Oct 2024 09:56:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e74d6sm68525565ad.166.2024.10.14.09.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 09:56:26 -0700 (PDT)
Message-ID: <c5ffe617-e182-4561-95d4-5f635fda53db@broadcom.com>
Date: Mon, 14 Oct 2024 09:56:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: systemport: avoid build warnings due to
 unused I/O helpers
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20241014150139.927423-1-vladimir.oltean@nxp.com>
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
In-Reply-To: <20241014150139.927423-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 08:01, Vladimir Oltean wrote:
> A clang-16 W=1 build emits the following (abridged):
> 
> warning: unused function 'txchk_readl' [-Wunused-function]
> BCM_SYSPORT_IO_MACRO(txchk, SYS_PORT_TXCHK_OFFSET);
> note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
> 
> warning: unused function 'txchk_writel' [-Wunused-function]
> note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
> 
> warning: unused function 'tbuf_readl' [-Wunused-function]
> BCM_SYSPORT_IO_MACRO(tbuf, SYS_PORT_TBUF_OFFSET);
> note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
> 
> warning: unused function 'tbuf_writel' [-Wunused-function]
> note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
> 
> Annotate the functions with the __maybe_unused attribute to tell the
> compiler it's fine to do dead code elimination, and suppress the
> warnings.
> 
> Also, remove the "inline" keyword from C files, since the compiler is
> free anyway to inline or not.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

clang is adequately warning that the txchk_{read,write}l functions are 
not used at all, so while your patch is correct, I think we could also 
go with this one liner in addition, or as a replacement to your patch:

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c 
b/drivers/net/ethernet/broadcom/bcmsysport.c
index c9faa8540859..7cea30eac83a 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -46,7 +46,6 @@ BCM_SYSPORT_IO_MACRO(umac, SYS_PORT_UMAC_OFFSET);
  BCM_SYSPORT_IO_MACRO(gib, SYS_PORT_GIB_OFFSET);
  BCM_SYSPORT_IO_MACRO(tdma, SYS_PORT_TDMA_OFFSET);
  BCM_SYSPORT_IO_MACRO(rxchk, SYS_PORT_RXCHK_OFFSET);
-BCM_SYSPORT_IO_MACRO(txchk, SYS_PORT_TXCHK_OFFSET);
  BCM_SYSPORT_IO_MACRO(rbuf, SYS_PORT_RBUF_OFFSET);
  BCM_SYSPORT_IO_MACRO(tbuf, SYS_PORT_TBUF_OFFSET);
  BCM_SYSPORT_IO_MACRO(topctrl, SYS_PORT_TOPCTRL_OFFSET);
-- 
Florian

