Return-Path: <linux-kernel+bounces-230838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0A791828E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4CE1C23B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF869181D1E;
	Wed, 26 Jun 2024 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="XDWOTzst"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346208825
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408891; cv=none; b=fBWh+UVw9OgF+hHl5xTjC/uuxdgJV8hoy6qCen+cdmPLef/BoNaINgOv9wGP88bWGlQmHQ/Ney0JgFCoMwHl8/VJUfbY+1ZWqyDG0G7G0smRJ2Bi3WSObMj5F61aXIAeBvePY5mSEWmVqiEYqY9lapZCPBgn12+MYNJdjVeFT5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408891; c=relaxed/simple;
	bh=0dhkLQByZQyQREJ/jDXsMAaxg0FH/9/7ubG2ajZen5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8j03DwwyDn4uSWkgjaGAGA8Qf1vC8fRAiFbezs4yFunJwUiHbdOztUP/YinEqA3fNQsSsckSL9u+5G0Pw9j5knOVks6Bq04jy4LYm+zgkuL6TzWK8Edz36gFI7I5GaGRWeyk9ElUdHKzNVixgfPxo/V2PudP9XTy1DeuLM598E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=XDWOTzst; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso6840013276.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1719408887; x=1720013687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2ukVWFT1tyYPa/ZAcJ6dOW3ry3HjmGJ9j874uwa7jY=;
        b=XDWOTzstf8Fkde0TjDXjwn64xXPAqkHA3uqmTyNK9bes5BRzxplsJ3sHEVThK1WqMd
         BtTJcPbrl7tuGU2AKx4kr05UcSDxjISrKudhsw+OWdEi8cpRX7wdI74rM/kYX4uLChUh
         HTo0pXh94v1V/Dj76Bh5AZS327uoSYpAh+Mr6mtQv42OdLEXBW5xqchfClKgtxLc+uhI
         PUCmFj5cA6SbkUfQREV2/sl2tvk6TET9lb/5/SIlveFni7Ju8TFiH69tLtxfl1VyV44F
         70fM9FmVHFGkxektsY+llVk4OPbZi2XNwty2e4fSEU71RJto6s2D5QhAiPIlZgoA3pGJ
         lCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719408887; x=1720013687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2ukVWFT1tyYPa/ZAcJ6dOW3ry3HjmGJ9j874uwa7jY=;
        b=DviyywAMFYFgdD3Nc/SaknYJA6VbMcVefUuBwc5IAGwWbIR/wiTfPWrHQq8EAiNwHN
         SAkLyN57VvD9QUDAHd1wA8M2aEBQ6y/x8m07ZBNVXGx7jRxAgwSxg0ya97SnQ1RoDHIp
         kY5tOIVQRMT2xFhe0h2U9TMznlzE9Y+JRih2+ZTASwXqouo5KZvDOZ5odTKu5tWzyF6Z
         mVzqRG7B/juYyJRnaNPTzQb4A5CvXfbj/g5U7xpoU98vt4yk1dCmC2yrzkN6uo1be53m
         pQ6oE5z+oYUdqt4k92xHU744ye774igABRGzY3pAL/VaRTuqMCeQXMzLG5ZMyYzrSOcP
         a5MA==
X-Forwarded-Encrypted: i=1; AJvYcCUAbirw05ANW8OH5demGrvcY/Mc5CkguItrSxSBewoMkxeqjMuteqRd0nWCSMQhdKtlGf8B0CXUL69Tb9UNOpdO/+4sPVWSco6lIUpX
X-Gm-Message-State: AOJu0YywPm+BUrxoBI7YhkKzd1vgcYT86cPBNRH8DKYDPfqyWgu8ldu2
	fwFid6Xs0dFqCXIvy1dKuhnUSWE1qqWzHN7XoWEGkPN8Z4bKRzkeEG5A4rhYeNBhRFYP6RUPzM7
	7yAA=
X-Google-Smtp-Source: AGHT+IEQI8k8PaDkmUreltxCCIhuD3MDFLr14G/kuLv1N8q8FK1w7DZXRPufoe5tRX7CDtMnP4E8Cw==
X-Received: by 2002:a5b:f90:0:b0:dfe:fac8:b890 with SMTP id 3f1490d57ef6-e0300fcee40mr10585487276.28.1719408887101;
        Wed, 26 Jun 2024 06:34:47 -0700 (PDT)
Received: from [192.168.0.50] (dhcp-24-53-241-2.cable.user.start.ca. [24.53.241.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2c3dc89sm66757551cf.65.2024.06.26.06.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 06:34:46 -0700 (PDT)
Message-ID: <cc70c1e7-aa1b-45a7-8edf-20dc4f3b75ad@draconx.ca>
Date: Wed, 26 Jun 2024 09:34:44 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-mm@kvack.org, sparclinux@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Hailong Liu <hailong.liu@oppo.com>
References: <ZnqspTVl/76jM9WD@MiWiFi-R3L-srv> <Znq6tEtCgB6QnnJH@pc638.lan>
 <Znq/8/HAc/0p6Ja0@MiWiFi-R3L-srv> <ZnrjZRq5-_hemrbD@pc636>
 <ZnrnADHvOiNcZv9t@MiWiFi-R3L-srv> <Znr1IQ1mssdNNXbv@pc638.lan>
 <ZnsjIB2byIxSgbjc@pc636> <20240626051206.mx2r4iy3wpexykay@oppo.com>
 <ZnvcToH1h-sVtikh@pc636> <20240626100342.2dudj6fjjx6srban@oppo.com>
 <Znvyvof4CnFETJ-v@pc636>
Content-Language: en-US
From: Nick Bowler <nbowler@draconx.ca>
In-Reply-To: <Znvyvof4CnFETJ-v@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-26 06:51, Uladzislau Rezki wrote:
[...]
> Thank you for pointing this. Below is updated version with extra comment:

I checked that I can still reproduce the problem on 6.10-rc5 and with
this patch applied on top, xfsdump doesn't crash anymore.

> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 45e1506d58c3..03b82fb8ecd3 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2542,7 +2542,15 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
>  static struct xarray *
>  addr_to_vb_xa(unsigned long addr)
>  {
> -	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> +	int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> +
> +	/*
> +	 * Please note, nr_cpu_ids points on a highest set
> +	 * possible bit, i.e. we never invoke cpumask_next()
> +	 * if an index points on it which is nr_cpu_ids - 1.
> +	 */
> +	if (!cpu_possible(index))
> +		index = cpumask_next(index, cpu_possible_mask);
>  
>  	return &per_cpu(vmap_block_queue, index).vmap_blocks;
>  }

Thanks,
  Nick

