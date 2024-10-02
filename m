Return-Path: <linux-kernel+bounces-348424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F67298E773
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F1B1F25BA5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29DC1A01B0;
	Wed,  2 Oct 2024 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="apyUOVuO"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F48196DA2
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 23:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727913426; cv=none; b=hcqKy9HvVpTAdPA/0K/wFk76nUovxXxuZi2N5ksnjretdICufFT8NeYR6XbU8dAjCeKIGDqeLUqGARs7YN3WSkr+LiueHgFsuYbbgck+bmt5lnosHx3fpAS3zhOcA907R5FnWl9SxHyPFg6YNjsrU1ucn18gEGbpS/+tPAMkEa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727913426; c=relaxed/simple;
	bh=YSX9f0KPIXq8iPsOQ9VblraJvhf1rUMHCzbKCRGyTjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPMvr0G++XxBuY/IItIJdmynjIUV77bz7GWdaiA2FnOW1pqiEGUPq8Rs9cTYQFp5ND9lffEVleaev4lPrhEZwDWLb0d4F11Q9aWxwZyPSkiUlg1TeScXvhZFyCUEkNwvcqP779UdHvniklIVVcwtBCVSEKz6gIanXs77zsQXKl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=apyUOVuO; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-834d3363a10so17772039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 16:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727913423; x=1728518223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OSyZMGPQXKBkz4kZ0qmjNo27H4oSupPDSi35nl9XIMI=;
        b=apyUOVuO2jm+A+MBhFeaxZICsWiSYmeCKa7H2LgKm8voyDtZiKgtTzCVyq4F0WYfZx
         V5ZwSqZYvFx8i6Fi4fNwduiyLdJrmROT2tNTiYediAKMim/PTXho/9jTEYCV/VmFpjjl
         /5xvO1S8H8GwWLP8uhNSmuyOmor2rf0cSj1Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727913423; x=1728518223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSyZMGPQXKBkz4kZ0qmjNo27H4oSupPDSi35nl9XIMI=;
        b=g2zCCgNCQiCHbCGHbJ5Ugil5j/EY3xs9ObbHfzPOGGcNPDmXI12goLa8/wWnletpSU
         znMuaNqejy3jWOyVE2++4RGm6lm3sV/hro2KsovwwAWseRHntQ5EflBL7XMqfYBDY+R0
         zn6CQmYdyX2uhlDCr+TX1OB1w/8ThMH42j/30Awr3vcna224w+NSic0mQzEqsvbw9RO6
         rrdqQqVEZbphcn7osxAeNrnFyXrX0xnFIQP8/IPVoMZOq+uouAEtUgHRFRELKkaDhWYa
         F6yjpFTRBFnNcnXjzpdKhjfBjDI8Ob7JdFgd2rE8s82jZa/qwzCbYFX44iHWvNqt2moF
         YX3w==
X-Forwarded-Encrypted: i=1; AJvYcCX/faMTjhs59E7Drs2LmTF1Z/8Fj36XbYLzbhYqViLKl++BS0HDgW3A6m7aoK2CPLGb/2sMKaCLNiDGvUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkLgK9sfIbp16Rzg4zjfJ9n0eUfXfPpSM5pSjZfXZIF1ynlGcm
	//WZ6J0jUFJi74eSS03Ea96vwJswO38633JE2ZEqY6TPdfdj3dATfG20syHYPbk=
X-Google-Smtp-Source: AGHT+IHh9kR0yfoxmhoMxEgAl2XLNnn0nCCHbNVux1JmoYXp/yKiayDABF92tCcXiqy+TMLK3eBsiQ==
X-Received: by 2002:a05:6602:6c01:b0:82a:3588:994b with SMTP id ca18e2360f4ac-834d84d0b75mr559838439f.15.1727913422764;
        Wed, 02 Oct 2024 16:57:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834efe38883sm1197839f.52.2024.10.02.16.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 16:57:02 -0700 (PDT)
Message-ID: <e500ad8b-07d6-413e-8fc6-2a9afd5593de@linuxfoundation.org>
Date: Wed, 2 Oct 2024 17:57:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/538] 6.6.54-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/2/24 06:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.54 release.
> There are 538 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 04 Oct 2024 12:56:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.54-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compile failed on my system.

libbpf.c: In function ‘bpf_object__create_map’:
libbpf.c:5215:50: error: ‘BPF_F_VTYPE_BTF_OBJ_FD’ undeclared (first use in this function)
  5215 |                         create_attr.map_flags |= BPF_F_VTYPE_BTF_OBJ_FD;
       |                                                  ^~~~~~~~~~~~~~~~~~~~~~
libbpf.c:5215:50: note: each undeclared identifier is reported only once for each function it appears in

I think this is the commit. I am going to drop this and see
if it compiles.

> Martin KaFai Lau <martin.lau@kernel.org>
>      libbpf: Ensure undefined bpf_attr field stays 0
> 

thanks,
-- Shuah


