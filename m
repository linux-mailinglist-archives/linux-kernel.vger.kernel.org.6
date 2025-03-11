Return-Path: <linux-kernel+bounces-556440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB2BA5C8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329FD16C17C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510D925EF9C;
	Tue, 11 Mar 2025 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E3DcecL9"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803E125F786
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707967; cv=none; b=LWRRNiT4UJDDl6X4tYHXYfTYRfxJIsW52vLwBYANhv0v56JPMgtlk1z1lWaE/FoDZrDDZEz0WnnPfdXqPw6fXWtoHCPvaiZ65k5vtvybR1CfcfQBXw5tetn3RI3+iArdsdgbJYUjn0UmKHo2u1f4+gqIsTspKwLPsLGnX7tPsuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707967; c=relaxed/simple;
	bh=6fVO/vVddYoOEKURR6p+IYPBy9SXzCFfy4PK5pT2lzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTxAWWkXlgZO+XaCPFbz+3vwFZGaQYMvlx3Lq1fVqMOOMjwYoM04EWpXE2KLI4jsrLUbB+iXbT4KUD0jZpeIBEk9sfqzUdrkko84LhlGsLjJh4H/JanGi0UoX9RhCKYHUmcHzqhCibDOHkY9v6TVPrTG1OzKlRz8opvJ53cV6YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E3DcecL9; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7272f3477e9so1204421a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741707963; x=1742312763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TvX1YUIUz+ljyteedbXCuuqtjAef6ss4iRRjFDfHrXQ=;
        b=E3DcecL9fW7/G922kRxSw/OBDRURXZSsqExhBupSz4R5FJxVf3pa9xUimGf9IP1Vxf
         LbpRDGNGXviXTuM2p3m0HORzmBpv1PfJ88EiJ86Z8qJaibqLn+r4QZpGzrJEt/OyUCPS
         /q6BxSYMoivPSTew9x+YBd3R7KZK48BGkbmPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741707963; x=1742312763;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvX1YUIUz+ljyteedbXCuuqtjAef6ss4iRRjFDfHrXQ=;
        b=RGQbo+vGn91SXg7vJpppTJjsj/bNBzfaq2pQeEI7it+wqlHz69uH4S80rVAvDZh4zG
         9YvgAiD2TUqJSruRgOJL3cV0mzzxjV/5YWejFE1N7eAXJdRcD64i6cNDlj/5Dlap09vg
         UZxwAZMVtIfxIiNWPEZujwLk+LWo1OrDQ0TYXnfRQLvWE+mP5YJceJ9h3kZM0mz9QOog
         fQTuNckh+F7I97vHL3QbZVdj5PMJKKUpmV2+kZ7u961S/xqizwBElBolYH89qdR8hKS5
         aXRUvn+vor4+12KhkQZ73F4ec42zqVxD9ynaeNhMBZaRm+i+e5o7yStz8JlXQKqxB223
         TjJw==
X-Forwarded-Encrypted: i=1; AJvYcCWkFGAfEaztaTebzhYoSgNG3ZHLROi2zJEViPQTu4BQg/XZn6m9jySlt4zAdRsr42kXu2SNUbAe+wRR09I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3VPqfT9LKTWpLqf8/zQR+aVIxR0IljzRA8+7x7x+qT2aEmZX1
	Dh557+rrEzFJ49iN7LxndT6LyVk7af6qyDqbC68lQbeEe5cMJd3wG9cNoErBTg==
X-Gm-Gg: ASbGncuxqg313ba/PVNU5ZIFyw8d1ueQeXIVS6hu0I1Z4maoaI1KFxI4gRTRa5GFe6t
	i1T1FkkEIiqfGJKzW1GpoVXvpwwrCKYGAcU6B6vV+XaL5GTWVrnSjlFNn1d2Q//OrnmItkwS9HP
	vYsvK03rMzkUfbN7AoMBmE+uL25JDJE+ZifCumn/RQHpGn8GMUXZNYIkyyQ5NiAn3A/TKkbMgh1
	Nn1TaI0o8keO7dxMB2Iu6mb9Hyc0wYiIxFT0OFsQEw4+hPzedJp2yiPfK6M/fHKbFO3MU31L2+5
	rAo6fJDXorA8KEK4mH6e/y9HH3iQWa+UUka3oqFocUlpDEEld3rH7JQepucU3rVC/458henGk9s
	sDwA/xVk8
X-Google-Smtp-Source: AGHT+IELjvN+XdLjKqh9jaffslYR98GQizJDSBHy2qffYsdvRDcijxUrqGkTRxSvndo2VK5SLo0wlg==
X-Received: by 2002:a05:6830:3897:b0:72b:9387:84b2 with SMTP id 46e09a7af769-72b938794c3mr3908943a34.27.1741707963471;
        Tue, 11 Mar 2025 08:46:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a4634099esm1681482a34.61.2025.03.11.08.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 08:46:02 -0700 (PDT)
Message-ID: <aa4284fa-1f68-4c7e-8d58-1c5129adda27@broadcom.com>
Date: Tue, 11 Mar 2025 08:46:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops
To: Kamal Dasu <kamal.dasu@broadcom.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Al Cooper <alcooperx@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250311150136.46938-1-kamal.dasu@broadcom.com>
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
In-Reply-To: <20250311150136.46938-1-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/25 08:01, Kamal Dasu wrote:
> cqhci timeouts observed on brcmstb platforms during suspend:
>    ...
>    [  164.832853] mmc0: cqhci: timeout for tag 18
>    ...
> 
> Adding cqhci_suspend()/resume() calls to disable cqe
> in sdhci_brcmstb_suspend()/resume() respectively to fix
> CQE timeouts seen on PM suspend.
> 
> Fixes: d46ba2d17f90 ("mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> ---
>   drivers/mmc/host/sdhci-brcmstb.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 0ef4d578ade8..bf55a9185eb6 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -505,6 +505,12 @@ static int sdhci_brcmstb_suspend(struct device *dev)
>   	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);

Missing an int ret declaration here, otherwise that won't build.

>   
>   	clk_disable_unprepare(priv->base_clk);
> +	if (host->mmc->caps2 & MMC_CAP2_CQE) {
> +		ret = cqhci_suspend(host->mmc);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	return sdhci_pltfm_suspend(dev);
>   }
>   
> @@ -529,6 +535,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
>   			ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
>   	}
>   
> +	if (host->mmc->caps2 & MMC_CAP2_CQE)
> +		ret = cqhci_resume(host->mmc);
> +
>   	return ret;
>   }
>   #endif


-- 
Florian

