Return-Path: <linux-kernel+bounces-349610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA1098F907
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D203B1C20F67
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8DB1BD01F;
	Thu,  3 Oct 2024 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OiYpYoI6"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4863748D
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 21:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991554; cv=none; b=BDs/5c/fwiTQNKtrqRRMTI6Tz17nXWK2AeWFRY97NeD9pl6GM9z1OsL8KlwQnibzH5FKqbkLpSqvFA1VLpH0lGypTBkK34Sf1Lx1l7TXRdroCiWlD3NYBUrPblrfj6kT337x4GRyXEbZsXtGcWncS48gq/NF+sCsLxbrS7Lh32E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991554; c=relaxed/simple;
	bh=nfuNzII8nKcy5KInW0Hf5GAkpxAI6OmWmsIZ6ZyN7c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFqsiSIrGFmVPYKoEkkl2/4T8+rRiVM8eXqlMAbbIOK0EBLcVv+Ddcsio+3nSfWLnssibtIVqQ88VZCtbtnQmJmhXx7E8emtHDI8s2qN8BRjO++UXqbfoSBWBq9fWuHwGlN4xAPnAq5CfuMvajPslzmJbPdt8xmCxxUwi6Mmlck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OiYpYoI6; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82ce603d8b5so69943639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 14:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727991552; x=1728596352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZXdW6G5LWJ1GWGh1KXvZndbFeqVS8z0ZBtVcxH6wWkk=;
        b=OiYpYoI6KUa68uLJthl7NZo3UdUrY6D2KuG/BEyZvI/16MzXKbiVop4BEK1IhCLX80
         CeJcI8sP2MHzevRwOkcjTADfZhFrknfn/aTIQn3CqHi8N15U+y3jbrlHfM+FxnQPMsBn
         toD31ylu63IGrjMePyRNrzaqVQ1Mwy7KW5aok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727991552; x=1728596352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXdW6G5LWJ1GWGh1KXvZndbFeqVS8z0ZBtVcxH6wWkk=;
        b=CZ2G//hxzZcynAghV+bDFzC7lz9oQ3+e+UFLeeySGtlfk1D7nNcO9DTnb2USD+1Vef
         bJgU1G/Td9515B8MIkNpwf+QGRKgzFtOsQguPM39m7rjnct3qbEKkWdOs4drpfF4xxfv
         x0S0FchrCyHFZcHVrtbxDEsH2iYDnlayzSTpzDUcv9M/E69ZfIXWudIaGyh409AcA2QL
         WKPgwY4dyqQJ6vi+W8V6yRzinOEOdwNKTl5rHlM7wxtdFsYRDSislhLAD7TKQ6d34qMl
         dYSIUs0Dl8t4/JXgclTWmrjVBeX+DgaiiKt/TWpUkEJUhBTWQ71luzRzHY3lV6nw781T
         Cn+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpu+xg98jaVXzLNpFS/zbZNzcmcIV0CKl+hkDDu9GUZAFSOWwIeYRmN84KfosMUJEFTsk9KeQlyh8tQaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDOCXy7aC4UrY5LlePwK3lBzG1rYc2vZX25FuEw2qj5Xv42pxc
	JiGYUNvbKFYVQInJgp22KXWHeVkXG4BBq2YiuZTHJovjUxJJqEtTtIv7SyKslMM=
X-Google-Smtp-Source: AGHT+IHUWy3TlQJyb99RJOkAvNUXmRC2WWXVl7330ECrHnSB2ztnXujwddFTXhVmct/HAXJqf38nyA==
X-Received: by 2002:a05:6602:3429:b0:82d:16fa:52dd with SMTP id ca18e2360f4ac-834f7cb0934mr73870639f.7.1727991551952;
        Thu, 03 Oct 2024 14:39:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db55aa5833sm444925173.152.2024.10.03.14.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 14:39:11 -0700 (PDT)
Message-ID: <bb534e04-618d-48b9-ae19-00301e7c73b4@linuxfoundation.org>
Date: Thu, 3 Oct 2024 15:39:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] lib/math: Add int_log test suite
To: David Gow <davidgow@google.com>,
 =?UTF-8?Q?Bruno_Sobreira_Fran=C3=A7a?= <brunofrancadevsec@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 rmoar@google.com, kunit-dev@googlegroups.com,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240925025606.1714-1-brunofrancadevsec@gmail.com>
 <CABVgOSmEHtSHHsreVq38AzD+PnacgY6h-+Cv1u4n4U-1yjqwUw@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSmEHtSHHsreVq38AzD+PnacgY6h-+Cv1u4n4U-1yjqwUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/3/24 01:00, David Gow wrote:
> On Wed, 25 Sept 2024 at 10:56, Bruno Sobreira França
> <brunofrancadevsec@gmail.com> wrote:
>>
>> This commit introduces KUnit tests for the intlog2 and intlog10
>> functions, which compute logarithms in base 2 and base 10, respectively.
>> The tests cover a range of inputs to ensure the correctness of these
>> functions across common and edge cases.
>>
>> Signed-off-by: Bruno Sobreira França <brunofrancadevsec@gmail.com>
>> ---
> 
> Thanks, this looks good to me.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> 
> Cheers,
> -- David
> 
>> Changes in v3:
>>    - Fix checkpatch issues reintroduced in v2
>> Changes in v2:
>>    - Fix the overflow warning reported by the kernel test robot
>> ---

Bruno,

This doesn't apply - please rebase on top of linux-kselftest kunit branch
and send me v4.

I tried to apply, but a few too many merge conflicts. Rebase is a safer
option.

thanks,
-- Shuah


