Return-Path: <linux-kernel+bounces-236181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3AE91DE7C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006DB1F22963
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512B5126F0A;
	Mon,  1 Jul 2024 11:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FYJ331cX"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8A984D02
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719835026; cv=none; b=QMTkka/amGp9uMqfmE8vqlbNSrNK0P8P2e5X+zWDiAFdhZGXQrqU9/heXhnbIRKwROU+vHbBEpFgs9Nj18/xOvgArrmoTMuXOoJ/txgkoNagIWKKsChud3KVJXUY0/OKcbXpjNYaSs14zs+Igc74mF6yD+H8iPec39C4e7qFwVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719835026; c=relaxed/simple;
	bh=nQkUCEyoNucsphDLXWSe/1YShtMDQlZ8d9pl7pAPNk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRliaz/wlxQZ9GsLB1DuOHNKZE/c+UM5FG3NLQ92gzLLF1aVMfSOsIlGbaiq5hiTkWfBkZYvL8vf0oxFQpnIN2efnFGBuWe7OuC4Q4jGbSXXrWywTM7asdRSYzYCWsBAMnX5rNzlHnmvuUVboYjBrGAHr1lSuQXKMcX604Fb1Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FYJ331cX; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367601ca463so1677020f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 04:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719835023; x=1720439823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qM6ozT6ipWpUx8fDizJzb5G2gQBWPUGL9xe3Ichxpek=;
        b=FYJ331cX8EE44WCXWueM5+E44vSdkIbfP728djFFGh/c5jQMlAuPPSMu6dnjlluqbj
         HOVEx7vUSDsMk6tRbrIFEO+uTahI8uc4Hz0Ez3nJRUu8vp8LFGXMa1XL/7VdeKyqsXJf
         Tq2+1XH/qZjpum7JOIlk43YwdfuYltUsRi+PN8fsQX2fwvddOTywkwSKO7yhLH6SoxYz
         YSWSED9t+mbzhrjB79Fhij1moae5TdP0aKjKohTG5LsqlGPElKmhogkMa01nGf4GOdez
         EaRZlQlfaPPg2ZhDWtDddd/im7a7I2P7b6I5Y1A4tigDgkR+MBILg9h94AOEbcPlb7u8
         1NBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719835023; x=1720439823;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qM6ozT6ipWpUx8fDizJzb5G2gQBWPUGL9xe3Ichxpek=;
        b=idRt11fsidat7fuFA8PmuYQLhmPGZfc3Ur8CyCPCOu+Dkd48FGjUoiBD6dt/Wp1ihc
         nl0BwVWOHmVhB9U/E+pyB4c5SjIS9IdWZC272okGGzdZ9wudLyvOkyfsWIIfQiDeL4tI
         4nj9Q/8mt9eJ1LjTnVC5N0pFdxY96LLfJQ4PAHe2k5rCQ+aNd1yDJ9545CIr4Unu/8kM
         mxA1gbPlsZSmkFnxliP7Hu1uZLQRQN0TJoM4tNorc56vhY+EFmD8VaYr4TW84RAJ2Mf1
         Hrst+vNc4p/Qx7Lvvbg3faDhMZe9927MGNAifF8NRkzgeTt5gQJhGB2B/Hf8DqVpArbC
         dx/g==
X-Forwarded-Encrypted: i=1; AJvYcCUVzI3OuwbMwxAZO0/4wBDtKpBUxBFgznkcz1P/ScnpUKEHfXpjD5muog98wTCEEQtuGr5DBV/3InBh9JtTALK+5+AxbAqT4+SDWBQ0
X-Gm-Message-State: AOJu0YzE7R/T2IdcbkwFJ1wRe1E81dNcl5IXGJTaae6IzIrmjhKevpqX
	Ly0rscmSjgJxoE82u997rNrtE71FT8PVX3E/XGoH8KEPbeTot0e1eqkjZRaUKuQ=
X-Google-Smtp-Source: AGHT+IFYVSdRcV9MLSYbS5/vmHR/G4uYFaK3YDbIt8yGK5agQ58wvuLvzBnOMK0fuQtCapDBq2tqBA==
X-Received: by 2002:adf:f6c2:0:b0:364:3ba5:c5af with SMTP id ffacd0b85a97d-3677572827amr3273332f8f.61.1719835023153;
        Mon, 01 Jul 2024 04:57:03 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7471:9e35:9ca5:4e8a:d8cb? ([2a10:bac0:b000:7471:9e35:9ca5:4e8a:d8cb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d90casm9755883f8f.32.2024.07.01.04.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 04:57:02 -0700 (PDT)
Message-ID: <e1c4fae6-dbc9-4b79-8dd6-9ca00bf2bf6e@suse.com>
Date: Mon, 1 Jul 2024 14:57:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] x86/cpufeatures: Remove
 {disabled,required}-features.h
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org,
 peterz@infradead.org, akpm@linux-foundation.org, acme@kernel.org,
 namhyung@kernel.org, brgerst@gmail.com, andrew.cooper3@citrix.com
References: <20240628174544.3118826-1-xin@zytor.com>
 <20240628174544.3118826-4-xin@zytor.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240628174544.3118826-4-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 28.06.24 г. 20:45 ч., Xin Li (Intel) wrote:
> The functionalities of {disabled,required}-features.h are replaced
> with the auto-generated header cpufeature_masks.h. Thus they are no
> longer needed. So delete them.
> 
> None of the macros defined in {disabled,required}-features.h is used
> in tools, delete them too.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

