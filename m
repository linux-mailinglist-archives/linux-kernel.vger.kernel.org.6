Return-Path: <linux-kernel+bounces-207748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0E2901B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E123A1F21AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C926D1BF2A;
	Mon, 10 Jun 2024 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VxUuJ8K2"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30E41CA8A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718002752; cv=none; b=m2hOCZkdwte/TM5F1bPc9/Fnf5iWUjhBIq+XrVZfaD5tIBYucDuZHBz5fsSS4RkHM8Bw9SWkn4VIq1OXc5aI5REmTD/TW+gljaNrtO7TrD2Zk7o9NILVYoJ98uuzh9H6lfSW5ipFuqFmRVTmGH4NYhUeTw9eT3oJQEdv0KDw4Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718002752; c=relaxed/simple;
	bh=5Ike1B+fHLT0EF5123Js06dxlMZISlziRN1WuRhgGVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MWjxPclzliyFwIkXCzGXtdgiCObP2hXtEbLuGaDiYC9wp35y8x64rcOamtOq/VLHeZfZBQB3tld8XYX1kdlmrKc+aytEYTkpCAXc7oZIuNSZw6kiB18lErHCSPvWPYUYo6XwhzEjKNBj1E3piHIEsxznDGpm353cQ9y3+dvB2R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VxUuJ8K2; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35f1c209842so971448f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 23:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718002748; x=1718607548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pIFuZ0MLO/Z7rviC4+IUAxtBbTRnCLpdcVAtAYAsuyM=;
        b=VxUuJ8K2fREi32DDTuiIwezOeqBUVqpYf6rq/wb0xjFOm5HoAaEolL7FuUTdiu6ADi
         2B7JnwWZhA9LibIBCnIxAAmYrkGTAeiPf1/H9LqE8JRLzDa6x0xjqL1imHkxOQ0O62fQ
         V88mvM3oWhewfcfNPWdRZVNpgE7QnDEMoEEzSH7ykcKVmwz5oBXiJHVWKh7Uzonn4HJ8
         uMA06nOc+QFJ99M7CeLKRubN9iQo91V6ou/8zC4TwYxW6SMRUrW9dcim5jUMB/NkfByj
         4Ruflyx40GIpbiOvCpF8WtJUdRFmLWGllfm3+TV9E3ERehIQCXgcELGgEt+Gv2UAox9G
         hYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718002748; x=1718607548;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pIFuZ0MLO/Z7rviC4+IUAxtBbTRnCLpdcVAtAYAsuyM=;
        b=NePII45ct+3ZCNNubR/0QoA/uPVt+1frcSvHzNqYe0C7DypfHcoCCqospq+cemB0du
         16zjKXeMQTLHI204+z37lzX/tBf+qHxN22byrToPpsZSBRiKrrMAa30W9Qe4mTnReU2N
         sMqHoSM0QHzjEoT+ilDJbCfWU7M8/igbQbEH6gWIsx/Uzt1gvJHFoNxjD1xh6fMUSbMk
         UPJY1WKTb/cqT9u2Xh/HfA3T0hfu8dtjsh0zYiTMenrWwT6RMJSCm6KDAWdgQLmIY/Ay
         Jc59Va1g7ICXI7e+491mi56evtbqD/vmjjSVNuGmPGclU+KJ/0tdSq0PED8qU9jnkiQ5
         ifDg==
X-Gm-Message-State: AOJu0YwyP9KyDXa6uVf6wbQNZ16Z6Dis3OIsKXHMLhthmAYKWNg1FoEn
	3HrKqbSuLyTbTCewudfrSuVI/vK3XYXIauTa5QDJ/DJ+5J1IWEi8ip5HwUP/09nBgLWjViYqG6N
	A
X-Google-Smtp-Source: AGHT+IEBVPMksBc7eWn81M8DKQMfaVWUH6roqpv3NqXRHusfAaJUz01IOTxZ2Gvjp+ucVVwBbfg9JQ==
X-Received: by 2002:a5d:64a5:0:b0:35f:2091:4f92 with SMTP id ffacd0b85a97d-35f20914fe1mr1830027f8f.67.1718002748191;
        Sun, 09 Jun 2024 23:59:08 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7579:f459:e30d:c5ec:5a8e? ([2a10:bac0:b000:7579:f459:e30d:c5ec:5a8e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1a7c663asm4896189f8f.115.2024.06.09.23.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 23:59:08 -0700 (PDT)
Message-ID: <eefd904e-cbba-4062-872f-fdfa981b0cb3@suse.com>
Date: Mon, 10 Jun 2024 09:59:07 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/cpu: Move identify_cpu_without_cpuid() into main
 branch
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20240521124823.486372-1-nik.borisov@suse.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240521124823.486372-1-nik.borisov@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21.05.24 г. 15:48 ч., Nikolay Borisov wrote:
> No point in duplicating if (!have_cpuid_p()) check. Simply move
> identify_cpu_without_cpuid() into the else branch. No functional
> changes.
> 
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>

ping

> ---
>   arch/x86/kernel/cpu/common.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 2b170da84f97..69265c0acaea 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1578,9 +1578,6 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>   	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
>   	c->extended_cpuid_level = 0;
>   
> -	if (!have_cpuid_p())
> -		identify_cpu_without_cpuid(c);
> -
>   	/* cyrix could have cpuid enabled via c_identify()*/
>   	if (have_cpuid_p()) {
>   		cpu_detect(c);
> @@ -1601,6 +1598,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>   		if (this_cpu->c_bsp_init)
>   			this_cpu->c_bsp_init(c);
>   	} else {
> +		identify_cpu_without_cpuid(c);
>   		setup_clear_cpu_cap(X86_FEATURE_CPUID);
>   		get_cpu_address_sizes(c);
>   		cpu_init_topology(c);

