Return-Path: <linux-kernel+bounces-438655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00149EA3F4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90CC167EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B012EB10;
	Tue, 10 Dec 2024 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jfn8WX97"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A57617580
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733792336; cv=none; b=dlwrvQxw0GaPX6i54bSf6QfjnnoDXN0PzK6hfSwtSw7tXhvvxHhwc5mY5aNS6mBsM2/Lud6Is0YFHqS5MjVyLcg+zhJ3yKZBf1bt5git/UyNm6qv2lPDlOkhRDz70di2hE7O91to8xqLhJpxiam3I22Ov9bFOKsMvdAhqyau/Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733792336; c=relaxed/simple;
	bh=DxAm7kB2JcECl7gkapIzceGKJiE+AFE7Hpp0h/5e9u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PUNMg6EIWOYuYpoPOInnk8/IH3PhyyEw0sZY3+BJO1OwT8MVssdkGl2lbnOcAP8Y7F+xdPU+qj/5YvEjNgD6Ac4t3eiwVhfeOAaVREEV51NAaX9Rslvomt4F2xbOsNaUN3bBl5+nDAueRhIeNYraxSNz/qL0qRDEcy4QKx+f2Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jfn8WX97; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-841a9366b5eso352777639f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 16:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733792332; x=1734397132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SEjpZPJq8u289IHUov+/X17hbI/fbgadb77smhqlSX8=;
        b=Jfn8WX97H8LZp5TPqijjgUZ8sJQk9GamWeVOdaxZafHte8TNTTuk/4IjTGnyTCBnI/
         AlmoWE/r7JAj+OSLU2TlTxXu6dvq30Sklij+ZY25ydjBDjjU5VeuLmR5D3nZQtYXzdwd
         7b83Qnt+n3cZIp0FZz63AJuj1lWSh6kOEhc00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733792332; x=1734397132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SEjpZPJq8u289IHUov+/X17hbI/fbgadb77smhqlSX8=;
        b=LV+0N9HkKTcqg4mhJ52ZFKXZOe6nIBGzoR6eNJsAwJm5T9qLevkoZM/q1YilU90WxR
         k32clT9nUao0hvYIYqZczVezRURAFLweLqsRKTfKjM5xeUMFCgmsVNJ3bjG0Q/b5F4lz
         8q9EO/keufzihdlQa4PS0zqJe0obfHoqZpryG+za0wDs+GmV+GeySC2YbwVXcq/YioIs
         oFRXX4GwTsum5cwRoVMRk9KFBPYs9Gg/aBRlsCDLmbHeU8f9kok7zDtcsBcqu8DPEoHN
         90b+bdwQ2LrQuDofAu6MmLZjuXSBXpfwYmvg0AtXbPVq//ljuvvwsQf2Z9JVJzjtwRDw
         9tKw==
X-Forwarded-Encrypted: i=1; AJvYcCUhUR67boco6m7Kc3eY91KieDekC96lxJ0+87WdzYDBB56yEClb89a8+loU0uS/12XDPvOlVn/uBjM5LLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc/erdncvpNLlmFxeXtSxNvgI4lYgYTr5ndBia2dJAnBUFqv2F
	5DxzGP4dLDVVCRlluj62jk5Tia/nnf3FzHC/viKqqWkfcdiH+2sWlVqEI3sIyhE=
X-Gm-Gg: ASbGncv914A+kDzlBXeZbMmAV8G8vsJfUjr1Wvz6EDRdKqROrcfOYtPAf6BIaSbzRg9
	MZ5jk8dVn7eqcqwwYChyKDHzuAIzq9sfA7HJovgBuQOE8u+5vwr+/Y9hLsaAT1OBw0ZvUnzl5Tp
	65lI95Kx69ZdReAht7SFdR1Hy2U/05A9Ky5UuVrN9TRD55ROyFvx4tFA2End/zIyP5psFvz0L9u
	2RBhrz9uSdDiKwcfX44ztWnoh+TqSgcvDcjEBYgdiFpqSPOQLUHjIznItbJv68OHA==
X-Google-Smtp-Source: AGHT+IFtcBzpMhyjSQe9UzBOfjoOKfl8uNNpbJPlBJbRvrs/Ojhx1komTQp0qnO6A25grb08jLMKjQ==
X-Received: by 2002:a05:6e02:1cab:b0:3a4:eca2:95f1 with SMTP id e9e14a558f8ab-3a9dbac0352mr35106495ab.6.1733792332487;
        Mon, 09 Dec 2024 16:58:52 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2c64c24a7sm540644173.78.2024.12.09.16.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 16:58:51 -0800 (PST)
Message-ID: <16615e97-268e-4daf-a991-6cad7803ac16@linuxfoundation.org>
Date: Mon, 9 Dec 2024 17:58:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pm: cpupower: Makefile: Fix cross compilation
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, Peng Fan <peng.fan@nxp.com>,
 "open list:CPU POWER MONITORING SUBSYSTEM" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241129012006.3068626-1-peng.fan@oss.nxp.com>
 <ae5eba41-e2ae-48c4-b25d-daece4d329ca@broadcom.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ae5eba41-e2ae-48c4-b25d-daece4d329ca@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/24 10:12, Florian Fainelli wrote:
> On 11/28/24 17:20, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> After commit f79473ed9220 ("pm: cpupower: Makefile: Allow overriding
>> cross-compiling env params") we would fail to cross compile cpupower in
>> buildroot which uses the recipe at [1] where only the CROSS variable is
>> being set.
>>
>> The issue here is the use of the lazy evaluation for all variables: CC,
>> LD, AR, STRIP, RANLIB, rather than just CROSS.
>>
>> [1]:
>> https://git.buildroot.net/buildroot/tree/package/linux-tools/linux-tool-cpupower.mk.in
>>
>> Fixes: f79473ed9220 ("pm: cpupower: Makefile: Allow overriding cross-compiling env params")
>> Reported-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> Closes: https://lore.kernel.org/all/2bbabd2c-24ef-493c-a199-594e5dada3da@broadcom.com/
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> 
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> Thanks!

Thank you. Applied to linux-cpupower for my next full request to
Rafael.

thanks,
-- Shuah

