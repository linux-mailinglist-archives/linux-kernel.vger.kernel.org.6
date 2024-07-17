Return-Path: <linux-kernel+bounces-255227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FA6933DAE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2344E1F219A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766181802B5;
	Wed, 17 Jul 2024 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DanwzryU"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78276566A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721223258; cv=none; b=D4WwJins9LAH1+6fBie/85bCH+7T2+qN99t6CV+nIVJ32jcvHeDH7MOWE5oe71JSF4ZvPQuQhQpLS6NXIJCKcr0yhBe4gPjvYSzx7eJujDeaIkEGNA2g3g/klAvhUZvwYGbxMtZ9hXsYgMdEXQ0mv7wpQE4NOxfrNDfFPAEs3wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721223258; c=relaxed/simple;
	bh=5RJUsBlvHDg5vCxqAtoNjC6aPhMPpZdxsKO/XEzeyLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTRAvKBju2/c7jm/CopWhcjuKi5nBSkufSMja0oAB8w7Td/1IA3al9Z3/ER9Q30B5TZRlhpriSJyb13MF8LIfkDP4MTJ34B+6YN4rC96xqP1dXxXyGdhEC94PfThPzmQDPs+GfBZL5yqebGMGYKHpEzO8InHYS10NN4xeSWYzfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DanwzryU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc4c33e746so649865ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721223256; x=1721828056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Xw/N/Nknt+hnHErgAhb4sAGn5EWOvMdRK8INgc/iwE=;
        b=DanwzryUtiuUnkIshTQ9BGRFT4cwb190lL5oqAqwZESxPvlqVuJAyYV89vsiEh0v/I
         C0CBdiUPKnaoikmu0/nwDPC+wW/2+rsq+LSvCS1/ilbDRYZIcVWKvq7bFPFBkzhxbfuP
         puSwZyxNGqJs+U/e4TAxYppEV+uTZm7kOPD/Fkuna15Y+pYOXTAeEEILIfGcEVcaXWHh
         GeEALk8+kZhiUY03oTvr+IpYAX7bw41WUaD3+osjTwdkjQ3IDvUJ3CX3Z8jtQ3+kEVmf
         JNCeEh1UxYkD+LYfkd9/8VdbXKLA2wl3IPpOHqpBMNopqA6EsEFbJtGbFop1nZHGmBVb
         kR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721223256; x=1721828056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Xw/N/Nknt+hnHErgAhb4sAGn5EWOvMdRK8INgc/iwE=;
        b=Cyhc4bhD715ZPuJ6V+U+f0+5hDpPn1yPY4B5tchV6C9OCgeH9vMuVZkn0oBevINTFV
         LYg8QkffmTY8labt/PiNFM5VculpK7cyO0GE2DLeJrAMQM9Y1VvDhKOqiUXJIZAKdBhC
         ZSM3WSz80BDJ4ANjlNgT+UEbdQHR15rVe2l1TY8cgGXw8LOZFiQKNcMGmdfW/ipbt/pD
         hA1XpLFA9iLFyjNFC0tD4yYMLHJXfWbWmZ6zFBNtFaIKIHKfzsJKZPWjIiJGSR+FShyU
         qfNxe5VgHfOoOv7Jp7OfRx+eLawGXE0ZkQzBjLqCCyQJA3f4D1MKbMYyCiDv1MeUqChP
         EpbA==
X-Forwarded-Encrypted: i=1; AJvYcCUNaE1wPYxDbD21/H9ZCxwgWg7eT1TelAhIGxD8vtZZcXMgPWv9eV9PE6DnxugAUsoQrsCg0MXNL5RmrJog26Pz36WmGTLAJiP2kE3e
X-Gm-Message-State: AOJu0YxWj4HLkYPf4TBq/90ASb1mZoTytrpnu2mvtQSQT8tldU78HwrY
	gzCjZLaS81m2M/mqdGNIqxVVcbeDdhKdVcvs2fql5mI3AeIhldcCMGCAE78ciTE=
X-Google-Smtp-Source: AGHT+IHms1cWLCgQC4yvQAgbreOqMc80HS4eJgDWkU02jypBXGuCpbaumITC1nUfJM8C/W7W++ZkVA==
X-Received: by 2002:a17:903:248:b0:1f2:f9b9:8796 with SMTP id d9443c01a7336-1fc4e12608cmr10902955ad.2.1721223255347;
        Wed, 17 Jul 2024 06:34:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc381a1sm75109425ad.202.2024.07.17.06.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 06:34:14 -0700 (PDT)
Message-ID: <cba0c880-a1b2-4bb8-bef0-d280d87ec308@rivosinc.com>
Date: Wed, 17 Jul 2024 15:34:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] RISC-V: hwprobe: sort EXT_KEY()s in hwprobe_isa_ext0()
 alphabetically
To: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-kernel@vger.kernel.org
References: <20240717-dedicate-squeamish-7e4ab54df58f@spud>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240717-dedicate-squeamish-7e4ab54df58f@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/07/2024 10:54, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Currently the entries appear to be in a random order (although according
> to Palmer he has tried to sort them by key value) which makes it harder
> to find entries in a growing list, and more likely to have conflicts as
> all patches are adding to the end of the list. Sort them alphabetically
> instead.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/kernel/sys_hwprobe.c | 43 ++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
> index 685594769535..8a1c9ce170e8 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -93,44 +93,45 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
>  		 * regardless of the kernel's configuration, as no other checks, besides
>  		 * presence in the hart_isa bitmap, are made.
>  		 */
> +		EXT_KEY(ZACAS);
> +		EXT_KEY(ZAWRS);
>  		EXT_KEY(ZBA);
>  		EXT_KEY(ZBB);
> -		EXT_KEY(ZBS);
> -		EXT_KEY(ZICBOZ);
>  		EXT_KEY(ZBC);
> -
>  		EXT_KEY(ZBKB);
>  		EXT_KEY(ZBKC);
>  		EXT_KEY(ZBKX);
> +		EXT_KEY(ZBS);
> +		EXT_KEY(ZCA);
> +		EXT_KEY(ZCB);
> +		EXT_KEY(ZCMOP);
> +		EXT_KEY(ZICBOZ);
> +		EXT_KEY(ZICOND);
> +		EXT_KEY(ZIHINTNTL);
> +		EXT_KEY(ZIHINTPAUSE);
> +		EXT_KEY(ZIMOP);
>  		EXT_KEY(ZKND);
>  		EXT_KEY(ZKNE);
>  		EXT_KEY(ZKNH);
>  		EXT_KEY(ZKSED);
>  		EXT_KEY(ZKSH);
>  		EXT_KEY(ZKT);
> -		EXT_KEY(ZIHINTNTL);
>  		EXT_KEY(ZTSO);
> -		EXT_KEY(ZACAS);
> -		EXT_KEY(ZICOND);
> -		EXT_KEY(ZIHINTPAUSE);
> -		EXT_KEY(ZIMOP);
> -		EXT_KEY(ZCA);
> -		EXT_KEY(ZCB);
> -		EXT_KEY(ZCMOP);
> -		EXT_KEY(ZAWRS);
>  
>  		/*
>  		 * All the following extensions must depend on the kernel
>  		 * support of V.
>  		 */
>  		if (has_vector()) {
> -			EXT_KEY(ZVE32X);
> -			EXT_KEY(ZVE32F);
> -			EXT_KEY(ZVE64X);
> -			EXT_KEY(ZVE64F);
> -			EXT_KEY(ZVE64D);
>  			EXT_KEY(ZVBB);
>  			EXT_KEY(ZVBC);
> +			EXT_KEY(ZVE32F);
> +			EXT_KEY(ZVE32X);
> +			EXT_KEY(ZVE64D);
> +			EXT_KEY(ZVE64F);
> +			EXT_KEY(ZVE64X);
> +			EXT_KEY(ZVFH);
> +			EXT_KEY(ZVFHMIN);
>  			EXT_KEY(ZVKB);
>  			EXT_KEY(ZVKG);
>  			EXT_KEY(ZVKNED);
> @@ -139,16 +140,14 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
>  			EXT_KEY(ZVKSED);
>  			EXT_KEY(ZVKSH);
>  			EXT_KEY(ZVKT);
> -			EXT_KEY(ZVFH);
> -			EXT_KEY(ZVFHMIN);
>  		}
>  
>  		if (has_fpu()) {
> -			EXT_KEY(ZFH);
> -			EXT_KEY(ZFHMIN);
> -			EXT_KEY(ZFA);
>  			EXT_KEY(ZCD);
>  			EXT_KEY(ZCF);
> +			EXT_KEY(ZFA);
> +			EXT_KEY(ZFH);
> +			EXT_KEY(ZFHMIN);
>  		}
>  #undef EXT_KEY
>  	}

I'd prefer that to be done after removing the "if
(has_vector()/has_fpu()) by using the .validate callback for ISA
extension. This way, you'll have only a single commit reordering everything.

Thanks,

Clément

