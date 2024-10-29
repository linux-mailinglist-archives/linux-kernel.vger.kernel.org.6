Return-Path: <linux-kernel+bounces-387539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 175229B529F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B51F9B2288B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C91D2071E6;
	Tue, 29 Oct 2024 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xa1rH/kY"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF3E1FF618
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730229611; cv=none; b=TvXN7mtsv3jg7M0U8ZC3QoZXsI5JeiuurriHoir9o4BrOZovMbKy655rs1weQAaX+V0DfoENmVflERFhAl76yuID69DYYShXIs9qAU8uG+IQRJp0m6xpl8WPzYJEitCLNCsKfEK8aYZDOGR4rMyeXjhGukFXqmA2Aau/sDgE7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730229611; c=relaxed/simple;
	bh=rHdDm+FF+i4852Y+EUhrnwvCfBTND2mrMMwdnVIdKEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rObwfiKdObFx0Ento+1wE4290icSUwxzfSsmqTEgalY09Bjt0Crb6Y6+w72YllcI+kSpLkReHg7bpOWB9+zG15pxM8LEHxODxk4SnoWtF8eHLB7lPKzJSKu8lRAS/ZrMziVVvq2wgFJJgAnPTY8KqCwt/6CzVu9NVGrH2qEmRhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xa1rH/kY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso52471695ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730229608; x=1730834408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O0vFHoWbrSRR2ES8L3I6DovgTdFZvj8y3um9C03AOTM=;
        b=xa1rH/kYOXxl+PJz5nXyyOvzbmFoKTaaxoWBXLwbjJHFxqeNTt5Aug4IGH4nti0FZU
         49kBBaZRG5jcRE7p+diMmtv8DWettathilL0OYdM6j9UG4yj4cODGetKRCa8CzS8w6rZ
         72l1BGRHtfImEVvoFyzMWfItq+xxtQNKCrOMp6y3GWIcX/SOQyc0gptYom8lErWZ7Tc4
         AlZY5eR9xuI342K+avw2ZBzslGyRoLQnue+5AY3nIrtaq28KYgWtmf9ptrDVmi2wmU/+
         VJeNViM2tap+MPawICz+aFSfCOa+HQCcTvRx4xB0zsrqBLQpoYRp7Dl7mMHNdXb2gxaY
         Os3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730229608; x=1730834408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0vFHoWbrSRR2ES8L3I6DovgTdFZvj8y3um9C03AOTM=;
        b=DueifAm+sHRgI0GUfk0T/1fdlcRT6KI7R70DGVNflR832POFWM/7vn2ogXjPkqZpeP
         umMG6hSd2KuyMxMpAEUXyuMpW4qvt56/YlsuzpPJzA+QlZaI1wjM8GeYFXJUNIZCJLiV
         B4jHjlsAtXdQ6Az6lMoW1ciO6rpEMZxrdnM0hejThfZnGO3g9EP/wmbGOVXa6p8+SQiF
         e1K4WLmtX0ayH1nchirKTRfa0sfQZyssPO+ZWz7UADRBqwuhVhYO/ffQn9XOuMDAzT0O
         w3mRQj4HXQAKx3m978OwIvdVCwOwqaRSwK5zwokXHU9SsO8dAv8wB3evylGYH8Yh6TmL
         INhw==
X-Forwarded-Encrypted: i=1; AJvYcCVjIlp9mFx5Nk/bcQQyGxKQ/mS5R95P/lvGT2jNtmxHQl0Q7BRmAvVWYOBdEGrLV9ByfXXRQAKWdCua2eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHrWvh+zlT5kIt3PdydVwiaL2DWVsh+QdQBJUJodb9cX9ijrqg
	GwNJq9GcyuN0cb9g3BxkIF3jimzBvT0pGBogmKCmU9bLX1DiXJTtm+ShsVWGaofeTfeAJt1C0dl
	e
X-Google-Smtp-Source: AGHT+IEz1Nei096nISYhbzUC6FRMXyKTS7dZH8MtzqB+gzpPW7BJsfK7Sdp2yjSlqcl2PqbelWFqkg==
X-Received: by 2002:a17:902:ce0d:b0:20c:da66:3875 with SMTP id d9443c01a7336-210c68eac77mr182841805ad.24.1730229608560;
        Tue, 29 Oct 2024 12:20:08 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc082f20sm69567585ad.299.2024.10.29.12.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 12:20:08 -0700 (PDT)
Date: Tue, 29 Oct 2024 12:20:05 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Yunhui Cui <cuiyunhui@bytedance.com>, punit.agrawal@bytedance.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	cleger@rivosinc.com, charlie@rivosinc.com, evan@rivosinc.com,
	samuel.holland@sifive.com, andybnac@gmail.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Enable Zicbom in usermode
Message-ID: <ZyE1ZVCI71sLUeqm@debug.ba.rivosinc.com>
References: <20241025091527.57825-1-cuiyunhui@bytedance.com>
 <20241025-puritan-sank-b8a828ef5872@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241025-puritan-sank-b8a828ef5872@spud>

On Fri, Oct 25, 2024 at 11:16:44AM +0100, Conor Dooley wrote:
>On Fri, Oct 25, 2024 at 05:15:27PM +0800, Yunhui Cui wrote:
>> Like Zicboz, by enabling the corresponding bits of senvcfg,
>> the instructions cbo.clean, cbo.flush, and cbo.inval can be
>> executed normally in user mode.
>>
>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>> ---
>>  arch/riscv/kernel/cpufeature.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index 1992ea64786e..bc850518ab41 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -924,7 +924,7 @@ unsigned long riscv_get_elf_hwcap(void)
>>  void __init riscv_user_isa_enable(void)
>>  {
>>  	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
>> -		current->thread.envcfg |= ENVCFG_CBZE;
>> +		current->thread.envcfg |= ENVCFG_CBIE | ENVCFG_CBCFE | ENVCFG_CBZE;
>
>I believe we previously decided that userspace should not be allowed to
>use zicbom, but that not withstanding - this is wrong. It should be
>checking for Zicbom, not Zicboz.

Additional comment:

It would be good to have this (flush/clean/inval) disabled for seccomped
process or at least some sort of user abi to disable it (whenever use decides
to seccomp current task). So either

- by default disable when task is strict seccomped

OR

- introduce user abi (prctl) to disable it. so that any task trying to
   lockdown itself should be able to do that.

This is particularly useful for sandbox hosting in same address space.



