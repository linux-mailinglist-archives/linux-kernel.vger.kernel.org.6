Return-Path: <linux-kernel+bounces-369918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C42059A247A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61FC7B23142
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AED1DE4CB;
	Thu, 17 Oct 2024 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OR+mHA0N"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928BA1DDA39
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173914; cv=none; b=US9oxluGemQwfRxYKIFaK0BpCj+3tqRe2DWQB1lVy6XcmVbI21GNrIvp34ntdUKLw27Z8pmb+mpfNe35EjgmA92MA7l3LLDhHuUPCOGMCrABgUcSebMhxi+JYxjG2ImKgcoPN0NQSEQUT95OSHZY4RtFdMOKaGCw32sbo/+vPcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173914; c=relaxed/simple;
	bh=sDTmyRBhZeZQtrFrujlScwd8GcBMDV/Qu61nx/GWiyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxwX505V0K42rHBVm/j1cHQeV9gdITNRrOCQ9AZ417jowHMmdD7hQ+f1QteBmDCSSp/mCbYvR4R7I1IPPNHYkMh5hskt4VUZ5deDti9bZdCLlSopM64u/Z5og8WRBmYtPUYLw35IWCUI9LDxEASMeTmFaQ4ejHNNO6/XgiXV27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OR+mHA0N; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e6cec7227so827666b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729173911; x=1729778711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3b9WTpgaEfQ62qsPZIMgsRHEUWTtDopign4ULhcO2Y=;
        b=OR+mHA0NEANGK46pzHtRyjTv6edb/kHFuK1H1eUVsxNPFdkEhH24Yu/24+CrEr4AD7
         MMbGe/W5R9wL86tMWMYuFceJ08bpoBbeczDeVgqcYAwIA17awczEvF6UspPiruzJF7YM
         4ysDI4QtFx9TIaoRS+AfiCSvsAKx8W0wXWeFdubyG9Y/J/Y72H3CgnxLEZifDwjnPOP0
         rCKV/QDsmETPEXvdT5mkfEiU8GiPJ/qHlS4I4/vLCWd2jnze1kU0z0WZCosAFJT4yCfE
         06h97+5KGZioHsLtkikRp9+EsIQmr4rZvInNrq//GXK8cwJsENs8If/IqG6mahQ1qj99
         ZRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729173911; x=1729778711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3b9WTpgaEfQ62qsPZIMgsRHEUWTtDopign4ULhcO2Y=;
        b=AxwD7xs+F/4XPvvFFlqAF46thUHpMMa/Caloi87Ei8VvKTYG+jb6DNSBiyx2sRPd+T
         EHmV0XrWhu5IPHRnEhVNhprZmuWiyk95ivlENU1I2J8l4HycoxpReZG6OPJa/bAIpl1j
         MIlsF7+VqsdZQdN13m2Uv9NGfxKKnKtxaqsXZBCggWgQeiqcIfQCdC7hJbPm0OqHp2Og
         EECXvJ5iSBMXrv4SZlMO0lK95UjzW54Cp8BBvidqkEGPdcD+cMf6KKiKt/p6xLtAvzQ6
         G92uw74gmu7CfDeA4bPooBwpvH5MYdVh2KteWIc116eVVPK/cS6Gk/K4E9bMuARDjsr/
         +wpw==
X-Forwarded-Encrypted: i=1; AJvYcCUwKLoeJ++fg5qp9Y+0KFduN8f4v7+/oChURWjbHKss7ycRtyrD0b9RKuk/5/+V6rDr/IFVN17KWle+4jI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM4DS4NM7Wb4kAsY9qR6y/+WZFruOveFbxH87fwMv5dhQ8pDnn
	AlxzR6/o7a/jyVoKvkzrZ47hVlTCQ6f01uO25yYa1AZGt77dNxiDBRrfDJAq5cU=
X-Google-Smtp-Source: AGHT+IE826OH5Qi8TBuZE8FFeZ78wE+lMdNZpV3vFd7r+PlC14bgo6QWYfG3qrQ7sSNf8eB2EMFBjQ==
X-Received: by 2002:a05:6a00:929e:b0:71e:768b:700a with SMTP id d2e1a72fcca58-71e7db05c3amr13164700b3a.23.1729173910861;
        Thu, 17 Oct 2024 07:05:10 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e773ea180sm4923376b3a.90.2024.10.17.07.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 07:05:10 -0700 (PDT)
Message-ID: <3400cf0b-85ca-4ec2-a8a0-c9d75889d573@kernel.dk>
Date: Thu, 17 Oct 2024 08:05:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AMD zen microcode updates breaks boot
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 the arch/x86 maintainers <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <5fe1e264-c285-4988-b1e3-46771d07172b@kernel.dk>
 <20240930044313.GAZvosYZF5mHi2OZbC@fat_crate.local>
 <d7aff674-ad92-4a36-9ebf-8d3c42774723@kernel.dk>
 <CC418B80-5ED9-4F64-917F-BA6F94130F83@alien8.de>
 <ad9638b4-0a4a-4cd0-9fcb-2690693da157@kernel.dk>
 <20241009091247.GCZwZJDwFETmN5pEGe@fat_crate.local>
 <77f16324-47e1-41e6-a9e9-2cb7cbc8d14d@kernel.dk>
 <20241010134613.GDZwfapaZ8AKp0n72C@fat_crate.local>
 <842a76fe-3d6a-4846-83da-bb113634b8bc@kernel.dk>
 <13fe104b-d83b-4d6d-a348-1103d402540d@kernel.dk>
 <20241017100257.GAZxDg0VqDAesee00m@fat_crate.local>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241017100257.GAZxDg0VqDAesee00m@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/24 4:02 AM, Borislav Petkov wrote:
> On Wed, Oct 16, 2024 at 08:34:09PM -0600, Jens Axboe wrote:
>> And then I totally forgot... Got it done now, but it still just hangs
>> after loading the kernel. No output.
> 
> Hmm...
> 
> Let's verify it still actually selects the correct patch. Diff below, it
> should boot with it as it won't apply the microcode and you should be able to
> gather dmesg.

Same thing, doesn't boot, just hangs after loading the kernel.

-- 
Jens Axboe


