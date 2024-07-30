Return-Path: <linux-kernel+bounces-268354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA399942396
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2822D1C20DEC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BDB1917F4;
	Tue, 30 Jul 2024 23:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BjTBQz3h"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45C618E04E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722383550; cv=none; b=gvOlzAPEiLptSf+QivSs3GWv18L9J+7wLvu2l0yUAnb+QO69hKAK94lvLDxpze/XoaodP5dNyW1vC8bUMHYRC0CG7SdGgBXBo3TL51N9I9jmwVXAt+MIO6qryzKEPtltM/suzUg5G+5M7fRKmBIEOKQxu3jplQ2lIWrmjx9Ou2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722383550; c=relaxed/simple;
	bh=vWR7eaB2ziX0DQZ+eFOVqHJGrdk55GJujcwPPE799oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g89pClvqu1ALmbLYAXQdIie4sI2Jod/UOldxYpDhS9qRehIMfIGb9agNt4++vdB6TnkI0625h98NW8s7DXJxYLD/Hbl4EzPuNCBYvztAr7yPaSXANRXktKEQ72wnStj/Lw+g9nf5Nq6PSGL71/mLIkHqXtYinXnBeZBKzsf9toQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BjTBQz3h; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-398041b6e3dso1372205ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722383548; x=1722988348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vS2WcqLfwwuILiFNO1YcUTH9wMYaCwcHDsqOO6vbtSQ=;
        b=BjTBQz3hMGsJSg6tvGjbFwJ17+puZI259bB6XIilJCgap8o1KuSqYdxIT4Zfk8SYEM
         RVrbfoW58qatBBgdFir3HHULuD71znGgbCpT/256x64JRwZOPEArXpb6SbuoQxVXAWW3
         gKABFJOvyNMqoCHEUpIfhWsBJG4ckx9agBGco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722383548; x=1722988348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vS2WcqLfwwuILiFNO1YcUTH9wMYaCwcHDsqOO6vbtSQ=;
        b=jBQ+NNe4o/eJ5PEnGL+nZxN7pf1ETB/SyxfsHIzLzkDwcBZWKfi1IQl6xhbN9bf5gP
         LImLKHVUeDKfrJQ5PrRuFNIdxiKajArHmTQG3fNkntmiKiKMu3vHziltWMc4fxhFXnIl
         yCDdDSUeCtkSQWSpZ0Y4OOtpzJtccBbjX2II2nr1cxzZyy5tU/B/OJpT0DKnS6bSrdjU
         aEegO9Cp5CqvEqPBJVCOMcyyG40LJcwzMgqNrdFyrAhEwnQmQ3ohbp/lIe50BBy3gPiY
         5tShyid72BPFewUsE6pNTWP0LyYUZUBdO7D6QFnd//iG2L7p6NjTNSKiJNrOhpElSUAL
         9Zag==
X-Forwarded-Encrypted: i=1; AJvYcCX2jEJjwcB6xRi16sJAxYUUOMf5iLX0K63XsvNnJ0CfX+7ZnCJGC/wVCx94BgfosXGf/0C+dq7W7KE0u00=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHZmeDaCmNsMD7Re4hAkq6bEhxf9o1RZXRsswUtqgJVLCbaR3C
	kKH6ycAp3P2fWA2Nh+Y7y/6Nbm2DGbWeZFSbt3Ayp7F7rS4+9d3MWIJvYeVhaDs=
X-Google-Smtp-Source: AGHT+IGX3WJ0TMHz/80Kr8J8XRAJeVloO4pdMttS6ct5idJVS8UQy6Bnk9x2cGMv+tLMdMuWwyxNgw==
X-Received: by 2002:a05:6e02:2185:b0:39a:e9a1:92a6 with SMTP id e9e14a558f8ab-39ae9a197a0mr98874205ab.4.1722383547949;
        Tue, 30 Jul 2024 16:52:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b0b51ee4fsm5841605ab.28.2024.07.30.16.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 16:52:27 -0700 (PDT)
Message-ID: <29aa906b-a026-46ca-83a9-43d0e8d6e779@linuxfoundation.org>
Date: Tue, 30 Jul 2024 17:52:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/440] 6.1.103-rc1 review
To: Frank Scheiner <frank.scheiner@web.de>
Cc: akpm@linux-foundation.org, allen.lkml@gmail.com, broonie@kernel.org,
 conor@kernel.org, f.fainelli@gmail.com, gregkh@linuxfoundation.org,
 jonathanh@nvidia.com, linux-kernel@vger.kernel.org, linux@roeck-us.net,
 lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev,
 pavel@denx.de, rwarsow@gmx.de, shuah@kernel.org, srw@sladewatkins.net,
 stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
 torvalds@linux-foundation.org, Shuah Khan <skhan@linuxfoundation.org>
References: <061886f7-c5ec-419b-8505-b57638c5cf31@linuxfoundation.org>
 <017486e3-2132-44a0-ade8-94647de78cef@web.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <017486e3-2132-44a0-ade8-94647de78cef@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 17:37, Frank Scheiner wrote:
> Hi,
> 
> could be the same issue as for me, see [1] for details.
> 
> [1]:
> https://lore.kernel.org/stable/de6f52bb-c670-4e03-9ce1-b4ee9b981686@web.de/
> 
> Does applying 6259151c04d4e0085e00d2dcb471ebdd1778e72e from mainline
> (adapt hunk #2 to cleanly apply) help in your case, too, or do you maybe
> detected a different issue?
> 

Thank you for the tip. I will try this first to see if this fixes the problem
for me.

thanks,
-- Shuah


