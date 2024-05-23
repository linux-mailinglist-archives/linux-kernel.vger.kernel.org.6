Return-Path: <linux-kernel+bounces-187860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCB78CD9AE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D734EB21B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391C4B662;
	Thu, 23 May 2024 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F64dGT+F"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF33537FF
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716487691; cv=none; b=owrfwdqhOkeIBBcF27mfnHuZAAfXavAhBGDiSRmi+cvpo1jxqUmJU2JKkyK4eZ1Mxybeo5O0XfwmGLUoRWO6wwxulgaUw1QdWwlVvwOnYHdfP1Yj9twDLiWHp0FNdkDnbDViHqrjW8DCNvvCHMyYEVfQpy2jdT1VskH7WMh2UMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716487691; c=relaxed/simple;
	bh=01GT46pvee6PGpIlVi/vTVwShA2deAevmjcurFaC/DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpbVzSlNtpo/TCTg279n2tVw31R4VFsjLbG61cAC0dY2904DIeGN94c15lXFxB9mwSw0PMyuWl/j69Vj92KL0YAjQAcIHfj1+e2wn3RLlS9Z8XXHRBl3jsAlXY4nuog0WSNZsGtv78JCWGhS1qnxmyxhfqAdmAohvt/8YN4bwUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F64dGT+F; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36db5dff6cdso964415ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716487688; x=1717092488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QppMVaRvwpv224Y9IO8Cxn0UTTJUNxxLps+IPODX5QA=;
        b=F64dGT+Fc8YxDqlo3viSB4w5GVXepGomVOCpznQ6Q4ODxaHL1Ls1rPexrAf/XmuY4d
         7foPDR7qAV4HpXrlOsKz46uJa2uHVQ0gBN6q4FtdFAuA0Nat4FtmCdrkgxl03I/wamOc
         3zDsIV6BDgFllV1ETZaJLARB9HxebzcCg5xBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716487688; x=1717092488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QppMVaRvwpv224Y9IO8Cxn0UTTJUNxxLps+IPODX5QA=;
        b=LAyQNNFa8lvgmiMCBeWIkqpYQYUm7sxVLSQ+UyGDj1oFc8YJK8YLIYilXUFswRooVQ
         xiyCOcyT9XVQqrmCwP8XwLU3moR8RZmHcqa7FQkR1/YTA2ijOvcmV9WbDtvSF/XjmUzP
         b1JfXf9GP+CjDG7nBqNuh4cBj9GRe43zinB0oogmCy2s5EGs21oDICP2OUNeroIg/S+b
         HYlFC7Y3SPZ/oofB2cYWYlAy6cNAMYtnAw1INGeQldCRQNQputWIKr7M0qQnWpI+tOQe
         KJ9EZnK1917IStRJFEHMMR9ehtsJyUace+YvYplwRH3XixdTENSiQFJ3ZNJGZMIjXdJf
         g89g==
X-Forwarded-Encrypted: i=1; AJvYcCU892QeYsV+099FKRgIknjl1snQaCr7KN9fEsa6ZitUAJvPrfiTQMUFQ7bNPHoSAU4KoBUjqg4yzj+M64wyeuHzCd0cEGsZTnPElVDB
X-Gm-Message-State: AOJu0YzaL4Mi0kQqAWXXTKIibUpYl11dyf/yepJikzyOyGeSjrv5ryqT
	4BUZuH3IWWk13ueQjbsq5/z6b3i94zzVNNUosjEOwERdkPKMqMGdlxPL9oaSIFM=
X-Google-Smtp-Source: AGHT+IEBBvDmUK0IP1Etmxs8NE88XVgW6UxT7U9fncixZVdPc3a6kqkZwE1ED1Py3qsDc9U9/8UYnQ==
X-Received: by 2002:a05:6e02:218b:b0:36b:2a68:d7ee with SMTP id e9e14a558f8ab-3737b248c34mr967395ab.1.1716487687922;
        Thu, 23 May 2024 11:08:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cb9d3f601sm78622145ab.13.2024.05.23.11.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 11:08:07 -0700 (PDT)
Message-ID: <fb045118-5cce-43f9-9757-542ad3b84aa0@linuxfoundation.org>
Date: Thu, 23 May 2024 12:08:06 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/68] Define _GNU_SOURCE for sources using
To: patchwork-bot+linux-riscv@kernel.org, Edward Liaw <edliaw@google.com>,
 Tejun Heo <tj@kernel.org>
Cc: linux-riscv@lists.infradead.org, shuah@kernel.org, mic@digikod.net,
 gnoack@google.com, brauner@kernel.org, richardcochran@gmail.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@android.com,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240522005913.3540131-1-edliaw@google.com>
 <171642074340.9409.18366005588959820799.git-patchwork-notify@kernel.org>
 <29c1f444-6c58-48b2-90b7-a17ca22ad309@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <29c1f444-6c58-48b2-90b7-a17ca22ad309@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/22/24 17:36, Shuah Khan wrote:
> On 5/22/24 17:32, patchwork-bot+linux-riscv@kernel.org wrote:
>> Hello:
>>
>> This series was applied to riscv/linux.git (fixes)
>> by Tejun Heo <tj@kernel.org>:
>>

Hi Tejun,

I noticed you weren't on the email I sent in response.

Please drop this series. There is simpler fix to the problem
this patch series attempts to solve with this series is already
in Linus's tree:

https://lore.kernel.org/all/20240519213733.2AE81C32781@smtp.kernel.org/

>> On Wed, 22 May 2024 00:56:46 +0000 you wrote:
>>> Centralizes the definition of _GNU_SOURCE into KHDR_INCLUDES and removes
>>> redefinitions of _GNU_SOURCE from source code.
>>>
>>> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
>>> asprintf into kselftest_harness.h, which is a GNU extension and needs
>>> _GNU_SOURCE to either be defined prior to including headers or with the
>>> -D_GNU_SOURCE flag passed to the compiler.
> 
> Hi Tejun,
> 
> Please don't. We determined this series is no longer necessary.
> 
> With the patch that Andrew applied:
> https://lore.kernel.org/all/20240519213733.2AE81C32781@smtp.kernel.org/
> make its way to Linus? As you say that's a much simpler fix.
> 

This patch series isn't necessary and makes it problematic because all
these patches are labeled as fixes - I don't plan upon taking this series.

thanks,
-- Shuah


