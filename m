Return-Path: <linux-kernel+bounces-195612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E2E8D4F48
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FB01F22D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E6018308E;
	Thu, 30 May 2024 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AwMw8jpT"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368D0187543
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083734; cv=none; b=BipltE31RqzSaPN2D7I7ycct6rOATxscbgw62T+QEmqemwS18x2C9RLJXOWVbScMfwrr5ykiPhZc50IuaGgahjTXMinomT45/02Ug5FjKtqlBXcduuHWprqtiwjMUTTWuw3ixU4Sc/XzEqO09heNHhoYyP/L8XWJErpsQyz0DQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083734; c=relaxed/simple;
	bh=Hd3TXDh7+1gdd5BKaCfkA1GBlm5HEbnW0ANpefjwrRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0CPO5R6oeScIh5JlNkuBbG88/EBl2zWz2PWzI+PiBDQ+oPvSWb0k/7T75S/wxMzC8FTx47CrygDTjvcrlwsNVz0Emdi8gbxs2pKnLU2wug7YGis25zmll57+h7riCjgIsX7RW2nbfzumUGjYBFtAlLvnBpHlTwvdU8BULbnPug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AwMw8jpT; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e724bc466fso11495211fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717083729; x=1717688529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4j/W0RCkMX6PNwPuDOG5kkKx8vuxg0XIiZy/FRUoHvM=;
        b=AwMw8jpTuLGABt1BG9WyTBXcOK9nlaqk+6V3sR2hifJ8DJAYQDnMGeb0wVYexQwCk1
         cYhZojlMJ3a1bRv6VZN9HwhcB0IRwYM7ZkHuKLTcXVwGIfzclj47OhHxK8fE1CBkvP91
         wGC2wmlqY98dms0GM8CiK3capMRop1SJvN16NpYQEC1/kqHtELMZUZiarYFlqNCkpRrD
         coLAFjZLfEHG+H0+neIYTm/b2NFft2JjwlVy+90YDGVjYha9AvwZmZNEfVTTM16oLJco
         WPZF0BVwu0Hgq6A6ssh85a+9mq19pUlkWoiM+P+A4pRAy04c25jDk4gG0vH76/QlIrTr
         qi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717083729; x=1717688529;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4j/W0RCkMX6PNwPuDOG5kkKx8vuxg0XIiZy/FRUoHvM=;
        b=GluZpYFjxcTR1lFsIOeWom0vyzr6q5zzsSV8Z5i2m8+kqxj7yIpShS8Hptu5sD5PBr
         14mlX37LqKZVptwxTP1RsSzakRy/lixjBz+K9ZDr6fZ8b2iFfc9njXlujdxoQtHYGbGR
         Su5GkVjSDFQbw4tQT+hNlfjkPFLPus3qMRz5mda3MSVOwbLhZLTU31l3tluSABwO7UTt
         /tu4g0XT4PGbUR8mUZ52lrJ7KgaRQ3+Ymtd/lV+mQ188HfwN9qaVpefpw87vwDYJG9HP
         Fm0D3OjP2n3wJSlAMrBH6NvxpK/ftqNyIWXpYDHOjmDiSF5p2ZOtWb1FIcowhDpBJXG2
         c2UQ==
X-Gm-Message-State: AOJu0YxE2wHf704k3tJaKe8CvlOsfN52oVSE/4Lr7C4XD38Fr+Skwqj+
	J9h59hi1ou0KguFyXjKp5DKm11G9Yd3DL1gr7tD2BMjTiedFyx77mLE4ijJHK7I=
X-Google-Smtp-Source: AGHT+IEn8d2q0N4gJb3PvvENzYGflMa35/ncb9g9m38ks5wOB84b6tX+YTJ22UO+C0vHH7+5y2oJjA==
X-Received: by 2002:a2e:b711:0:b0:2e9:8b00:73f0 with SMTP id 38308e7fff4ca-2ea847d4e60mr22286011fa.28.1717083729307;
        Thu, 30 May 2024 08:42:09 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:5de0:a23:f1c3:862a:5eac? ([2a10:bac0:b000:5de0:a23:f1c3:862a:5eac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dcdbfad6fsm544649f8f.24.2024.05.30.08.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 08:42:08 -0700 (PDT)
Message-ID: <0d3f7c58-7fc0-4e8b-b6fb-c4d0d9969ce7@suse.com>
Date: Thu, 30 May 2024 18:42:07 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/boot: add prototype for __fortify_panic()
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Kees Cook <keescook@chromium.org>,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240529-fortify_panic-v1-1-9923d5c77657@quicinc.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240529-fortify_panic-v1-1-9923d5c77657@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 29.05.24 г. 21:09 ч., Jeff Johnson wrote:
> As discussed in [1] add a prototype for __fortify_panic() to fix the
> 'make W=1 C=1' warning:
> 
> arch/x86/boot/compressed/misc.c:535:6: warning: symbol '__fortify_panic' was not declared. Should it be static?

Actually doesn't it make sense to have this defined under ../string.h ? 
Actually given that we don't have any string fortification under the 
boot/  why have the fortify _* functions at all ?

> 
> Link: https://lore.kernel.org/all/79653cc7-6e59-4657-9c0a-76f49f49d019@quicinc.com/ [1]
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>   arch/x86/boot/compressed/misc.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index b353a7be380c..3a56138484a9 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -68,6 +68,7 @@ void __putdec(unsigned long value);
>   #define error_putstr(__x)  __putstr(__x)
>   #define error_puthex(__x)  __puthex(__x)
>   #define error_putdec(__x)  __putdec(__x)
> +void __fortify_panic(const u8 reason, size_t avail, size_t size);
>   
>   #ifdef CONFIG_X86_VERBOSE_BOOTUP
>   
> 
> ---
> base-commit: e0cce98fe279b64f4a7d81b7f5c3a23d80b92fbc
> change-id: 20240529-fortify_panic-325601efe71d
> 
> 

