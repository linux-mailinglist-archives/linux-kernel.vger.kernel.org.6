Return-Path: <linux-kernel+bounces-360177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5772899958E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 00:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794E31C216DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043671E7674;
	Thu, 10 Oct 2024 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DBjqw0A4"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8B71BCA0A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728601048; cv=none; b=b07y9Y4OeH8xgaiLPeQ4dEdSuVJGtSuoy4w6ofzRwiHYraRkMX2V/8cQb5v0BJFfj0jS7bpsFtS/bLb6ruTnIvrUKh2R5S2pJwYee2KPinhNU8uA7HUyjG5EgoFsHO8WaRiNjJ/CJssFAEoNlL/TqP36LH2CqfHYU5bUDL0YSGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728601048; c=relaxed/simple;
	bh=GpF1b8UxS/ZMGi5OYkYUBq4SAwSPD5KFqCxfhGb/aOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N64Yt/DNcX3OsDAvkzXo6nvHCpZSdWrlKWyw2esRTcslDBl95MLdqwlD0qH0+i6+JTMhWx3OlcSwxiXmv9ZOznN2Xv3bNVW9OrMHP6Qq2/UzYGOvQ0E5Ncr9bD74JnjWvbBlzm/KaP1YbA2JCP+PT6DtUkNIkwwI2DN2ceRas0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DBjqw0A4; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cbe3ea8e3fso8593166d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728601045; x=1729205845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/aV8yQc8B8F3nruu/zns9W6QYbKLmgb2AQfeOKadaMg=;
        b=DBjqw0A4kyauex/iCps6dPoBIW+owTpgw3AjGatXRycXFL9z0ETVHygacGKPOcX1Hi
         oWQKL9xvH55TTE6sAusZchVHpJMmiWKv1K8ieGqgVZ3p+XQsnxuJAw0nHXjBckjNZCzV
         Y6T0EqJtkoGo6Cgisk7h7dxUiBrJ9kyTtUaQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728601045; x=1729205845;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aV8yQc8B8F3nruu/zns9W6QYbKLmgb2AQfeOKadaMg=;
        b=s9tv/57bzC5On8Ovrf80BzEIZhfK6cjAGDK9v0Dzh0lP3nu+LzLFA5XUr+O0RVKWmF
         T0i6XohNyFDMRq662hbTuWIAYBvGvt0fRrmELhb27HQ/LRZJjPPsASXRR08K7kHRhNI6
         4WAuRsip8L8V6iG5mSzF3dZ9mwbcS+GzIIUxRcGOH0HzpzmOLtOjetvPJeoBGl3WwJDT
         h2X3If4zkiHntD/VVd7btzjGt1s3xIFIBljArCXhXC7HE88F2A2BJUO0sSRCglDQf5xN
         KSXvKrOhQDfK3ifTtQKaXnApqVYCh8W6gQXxnurufcbK2f+VOhXwWU8gRubseKhX4u6+
         4ddw==
X-Forwarded-Encrypted: i=1; AJvYcCVrZl3dTqjuoBkrp6LpdvwDMb8hEKQNEHDyN6qdyNShizvDNSHBCFSBCxVLdtHTaKJ/WF4CrDjtV9qx08g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM64ViAeS7MdqJMJU7Uvf1yHZUqiZggkYXb/ExH4VpxmXnm/E1
	pWeBfAoGCo+JJWNWGA0JAwGem7cGzkSOtlj+RdQV7uT8Kdxm/MOd0j0Cznw7RA==
X-Google-Smtp-Source: AGHT+IF4EbkD5/KfZ8L2sn5/CP/Jd1O9YfNYcrJe9UDlLQPf4nBIHsnYSdYUuPoyIO/kT9eoATSPZA==
X-Received: by 2002:a05:6214:2b83:b0:6cb:c744:c415 with SMTP id 6a1803df08f44-6cbf00a1340mr7626196d6.49.1728601045606;
        Thu, 10 Oct 2024 15:57:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85d8564sm9902696d6.65.2024.10.10.15.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 15:57:24 -0700 (PDT)
Message-ID: <ccc78255-a2c4-4144-b580-9a16aada09c2@broadcom.com>
Date: Thu, 10 Oct 2024 15:57:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: broadcom: bcmbca: bcm4908: Reserve CFE
 stub area
To: Sam Edwards <cfsworks@gmail.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, William Zhang <william.zhang@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>, Kursad Oney <kursad.oney@broadcom.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241005050155.61103-1-CFSworks@gmail.com>
 <20241005050155.61103-2-CFSworks@gmail.com>
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
In-Reply-To: <20241005050155.61103-2-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/24 22:01, Sam Edwards wrote:
> The CFE bootloader places a stub program in the first page of physical
> memory to hold the secondary CPUs until the boot CPU writes the release
> address, but does not splice a /reserved-memory node into the FDT to
> protect it. If Linux overwrites this program before execution reaches
> smp_prepare_cpus(), the secondary CPUs may become inaccessible.
> 
> This is only a problem with CFE, and then only until the secondary CPUs
> are brought online. Ideally, there would be some hypothetical mechanism
> we could use to indicate that this area of memory is sensitive only
> during boot. But as there is none, and since it is such a small amount
> of memory, it is easiest to reserve it unconditionally.

If we supported CPU hotplug on those platforms (do we?) then it actually 
does matter that this memory remains protected, and it cannot be 
reclaimed. This does not invalidate the commit message and I will take 
it as-is, but it it is not memory that we can necessarily reclaim that 
easily, if we did things properly.

> 
> Therefore, add a /reserved-memory node to bcm4908.dtsi to protect the
> first 4KiB of physical memory.
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>   arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
> index 8b924812322c..c51b92387fad 100644
> --- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
> @@ -68,6 +68,16 @@ l2: l2-cache0 {
>   		};
>   	};
>   
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		cfe-stub@0 {
> +			reg = <0x0 0x0 0x0 0x1000>;
> +		};
> +	};
> +
>   	axi@81000000 {
>   		compatible = "simple-bus";
>   		#address-cells = <1>;


-- 
Florian

