Return-Path: <linux-kernel+bounces-199363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4708D860A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C29B1F23544
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0A1130A47;
	Mon,  3 Jun 2024 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jrcHkDad"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C56712FB0B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428449; cv=none; b=gM8FAM3nhkNuNeuY2X+82ljDmRZGVyklVFXuqCQkG4+Hk/pRgr+L6QGasTUQXmI98O4dhskTKVr3GXmA29MMg50RtINyS8fmoSIwpowgcah73zfdMjLH6z1hgDHQrsqV6+viBIHURTBJL9lPHC2++gvbWY7W3Byak9GHz2Coku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428449; c=relaxed/simple;
	bh=SXVAUYuBVvyG9bJHg70o7CBVGk1DxD39f2tNbedrQxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vj+VH8OGcW4Ag77Thh7MPoWgNavLYr1zJ5Bf/azMs83aNBg0DmqWsHps5DhE1HNSj0TyYd530RyeKuHAN/mG1ZPugvqUImcCtIrbYX999J+6iMCPp8WKZRxkoM29qQANW5nSMDkolfeegbUtNy4ueggLfjSZkNzjAxkk8J6Eb7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jrcHkDad; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4801E3F6FD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717428445;
	bh=Fr+lwAk3qfyLZR/E+av3Bn4ZLoKvig7SyD53fLchvOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=jrcHkDadeOO4NAAucQUZqKM5VCZ5fi1KAVBtQfgowc0WaNodP+yvtnYWNNR2EmlPv
	 fwEqibOWTZpRDuYRpTIggaawODJuRe1mPglGpC1QOAmjNqs8s1stBELIUQIFi/SgV5
	 esY5z3Rja1/fGCn84PEirfVz6//7OGD/d1h70LlJ+y4gOAMtXY3MJsRPVCE2GmbanI
	 arjsClpeWLfbCtPO2HXI3baM3hddKC1uYQPQj3ePyKyr7GItNzFRO8TJFzmIAldTmh
	 eueHVbWTuTiUswSocMMqlLGpRJzCtJTXJ0wNHLqDB2tRyH/bnhvonWMDT5bSPQ08O0
	 rtWAmUeLJ0ORA==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52b98d73cf9so927725e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 08:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717428443; x=1718033243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fr+lwAk3qfyLZR/E+av3Bn4ZLoKvig7SyD53fLchvOA=;
        b=PSPxEeLbvhuwrWGsdr2iy0qGgqNiBFgW9EEnPeOhu76YqMpG4FOs5x+4CNyvMlFL77
         QZrscH6Zgn8RQTOf2i502cIcLRf8Wb9EVX4tMm58pDI7AV/knGtZHX5b/AQ0RyO3eCEY
         nMpzDrxkyGb3C78ZOAKsFXjqgePOCUaeuUkyxACnw/TcVjTm1kQTtjhA62a0eWNsAgs8
         p5q7LNv1A75CRHJnb1R5+OaJanOyQSWkRvu8Q8qHFc5/LQTpQ6QyvhqXCkGjndCgQ8Kz
         XYcDfRzZBwSDIIsCHNLS5iXB85Bofhs4QgcL0cCsrE2QZQ4q6WolLHP9gwOrHhvkX2ja
         +6tw==
X-Forwarded-Encrypted: i=1; AJvYcCWJd1ykoCyFg0hv9NTR5z5RDvX6WDFcOLygM4/63cBhy5rYrE8iNC7+L/NC8rsK1kptLiWvnz/+Uo03aacKVdHtvWOL5NCSYyEbggJb
X-Gm-Message-State: AOJu0Yz4Np9rWfN+kwwUzjxpl0kCvn83dYYdDKIzN1S2AL0kVHXpYvGO
	/zTIvqqsuHX+mgGyAv95nRiiH8cDozBn7je3G+Zvu41aWD2+NnGG9UsOgGwc1FjQAiJpQdV/M/1
	4zJm5NJnt+7efEiMuS6F740nTq3BG9/L40eP0n9utLk/pNgk6RB6P5mUOquT5rDSEYpM0awPwfG
	tk8A==
X-Received: by 2002:ac2:58d8:0:b0:525:32aa:443e with SMTP id 2adb3069b0e04-52b8954e931mr7769743e87.17.1717428442713;
        Mon, 03 Jun 2024 08:27:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4tA4IuchCsdrErWQrGd4V6yhmYuIPHnknJtEIeTtg0eU4jolMUpFBqZbhOrx6k/P93dx1fw==
X-Received: by 2002:ac2:58d8:0:b0:525:32aa:443e with SMTP id 2adb3069b0e04-52b8954e931mr7769726e87.17.1717428442197;
        Mon, 03 Jun 2024 08:27:22 -0700 (PDT)
Received: from ?IPV6:2a00:20:d00b:f75d:a576:8b02:7e96:f388? ([2a00:20:d00b:f75d:a576:8b02:7e96:f388])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68a53d38bdsm402013066b.172.2024.06.03.08.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 08:27:21 -0700 (PDT)
Message-ID: <8e50216c-2a3a-4946-ad90-9d66c6aae20c@canonical.com>
Date: Mon, 3 Jun 2024 17:27:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: starfive: Update flash partition layout
To: matthias.bgg@kernel.org
Cc: devicetree@vger.kernel.org, aou@eecs.berkeley.edu, duwe@suse.de,
 linux-kernel@vger.kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 linux-riscv@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 kernel@esmil.dk, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
References: <20240603150759.9643-1-matthias.bgg@kernel.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240603150759.9643-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.06.24 17:07, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Up to now, the describe flash partition layout has some gaps.
> Use the whole flash chip by getting rid of the gaps.
> 
> Suggested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

For flashing larger firmware like EDK II it is helpful to maximize the 
partition sizes. Thanks for sending the patch.

Commit 8384087a ("riscv: dts: starfive: Add QSPI controller node for 
StarFive JH7110 SoC") 
https://lore.kernel.org/linux-riscv/20230804020254.291239-4-william.qiu@starfivetech.com/ 
introduced the current layout.

CCing Starfive's U-Boot reviewers.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> 
> ---
> 
>   arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> index 8ff6ea64f0489..37b4c294ffcc5 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -321,16 +321,13 @@ partitions {
>   			#size-cells = <1>;
>   
>   			spl@0 {
> -				reg = <0x0 0x80000>;
> +				reg = <0x0 0xf0000>;
>   			};
>   			uboot-env@f0000 {
>   				reg = <0xf0000 0x10000>;
>   			};
>   			uboot@100000 {
> -				reg = <0x100000 0x400000>;
> -			};
> -			reserved-data@600000 {
> -				reg = <0x600000 0xa00000>;
> +				reg = <0x100000 0xf00000>;
>   			};
>   		};
>   	};


