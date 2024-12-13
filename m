Return-Path: <linux-kernel+bounces-445256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF089F1366
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36793188D49F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6CD1E47AD;
	Fri, 13 Dec 2024 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wglq7siq"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D5017C21E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110078; cv=none; b=eUIFoqHkfChU8uuo4wKZcRvqzx7DvW6j18nwQQ0Xy9X9tTcQk6ZPyPwBAbYFqbZy7u3B9vyXwKGEPlZwa8gisQsVR2VQsp8T5c39cICRYhoHmGRWRISvNgBfvjC7BZ/BMtsExzd4H/w5lcrIscBNWDoskQhTxXmYy/mGTX7LvIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110078; c=relaxed/simple;
	bh=nEQAJ7tMAVKoPCrSrHaaafwI82XnnJ+HSEY0wGbZcJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTA7qE0Wc6Ew9RGFsWt3S3fsgu/PtQZL7Rblek1hiL0aVHWfEJSH9UmGts/fA9qZKaJGZ6lZ32EN0QQ9xabLcaVSJu1sXmO2vHrFbfV005gOeGCUsLzFZWkkD8NlkXDd+0+nK8KEE/k2G5sR3M+2ODWq35C29ik6E360ejRpnVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wglq7siq; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a8c7b02d68so15821235ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734110075; x=1734714875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HhPL9NYTRXT2OymQSUELSnul5634w4kN0UX4t+krxe8=;
        b=Wglq7siqvFHpT52GbQe123lMtX7kiFzUhci7nAIi3BvFt18YZVpA3i+KsXoRdnxBKK
         TLW57Cg4thcGYD+ew1bkEnltRP7/Ga6jxFLcIwj4DUq2aTLqde1opKTe4Fj9oc4fyMQH
         9AiBDKHpZx0VZmqujmQqpckB8JIInFmVTfl10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734110075; x=1734714875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhPL9NYTRXT2OymQSUELSnul5634w4kN0UX4t+krxe8=;
        b=hiigeHiyjewKBhp7gKmXUQs8bni1bTdSM74gbdICxrL6h6CobWUZmYEHGaQdIA/v5h
         9bEwWIb5Jw8g5AOpCQZZVWrM9JJZeiKtCDSOHym5mKSOsnLgzBQrY9kogk3ynOSc/4dA
         F7f6vU6VXAkPz1XFqGOKjU4ZlxBxJxVMxZUpYGLkm+dEh3hGB7lLG/Wf6H2aZ/fT6cZ6
         PaRsw4J4gOYQHwdqNZ5DCPbHayivo7mhSwKTHVV2XW81C5C/3z/sYbiXBzYe9tbx4XuM
         6vwjOIBLrfOZRFxMNFRloXibtZAhSvnwtvAyGO7jSc08SmH3cMHyAO47TNIN8z1Bpiyh
         xMSA==
X-Forwarded-Encrypted: i=1; AJvYcCWnXXhTDNXnRj8gqhKmD3YMLlSwMFSYqyyle2A0XCYg0f5ZaQbRuGNGfKD68SW9cUA5KfqtrXnOs13eDg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFvzkm61ajD2zC6DrVsBfRm1mLuoiOx8y+9wSPb6K4GqVfB2LK
	+XcpMnp89Y9J3lDU+4WyFHKe5fZgbx6ZvBsFF2wcKpgjX33/BXbBigKsxHdtHlc=
X-Gm-Gg: ASbGncv1yPw4BBhL4NX5IRzC0ka2tOm8KQ0jXUL3OKvWCY8qSS9RlNn9hqE0bnBaKBa
	I3CscacBG5LCjuvBbskmFKTdoSNy+i1MT5E0g10fiMRBduE0rYCdJthltuf3EBBonbQsDvittrd
	6XzSSUlN0mgQ1Y8rFehHD9Y+y116Sr9ESYB2FAYE143D+EH+pPdsVxoETIZc4yOUcymrKxDE0Nj
	Wm6BZm2mkA5cxjbNtoFvE5hB/OD5R5mb//yptdJQsKf39lBlviGe5kfI+2b5aAWNCdh
X-Google-Smtp-Source: AGHT+IE787W9PHbVdoivn28P7E8AqG8a0BDD76LSQQ9TR7ermXtOOZEn/BIwAAOAjlwDZ7A+ZBGldA==
X-Received: by 2002:a05:6e02:1aa8:b0:3a7:d84c:f2b0 with SMTP id e9e14a558f8ab-3aff50b340emr41233965ab.8.1734110074882;
        Fri, 13 Dec 2024 09:14:34 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2c835a054sm2288061173.77.2024.12.13.09.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 09:14:34 -0800 (PST)
Message-ID: <b71d9339-4b5e-43a7-a728-8016daf4a90f@linuxfoundation.org>
Date: Fri, 13 Dec 2024 10:14:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/565] 5.15.174-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 07:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.174 release.
> There are 565 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.174-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

