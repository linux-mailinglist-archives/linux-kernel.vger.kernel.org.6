Return-Path: <linux-kernel+bounces-334821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A5B97DCEE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 13:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85655281F7B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 11:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2432D161310;
	Sat, 21 Sep 2024 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwBEFxkd"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FBB155759
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726918093; cv=none; b=ddAlNHZ05PG31bdBDudMsuxzT8tABizGqHQqmUjIPnA8J00TGYgHx7DGHqfGFpj9End2Z7so7b11qJ0csB8zBjVIJNXqsonuRGdXs04IlF+TB1qlEB9riD0ekVAKagsEKaLCjhbubuwQ/Gx/fWA/nq+PDWmpHptw4BXmjMlW/WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726918093; c=relaxed/simple;
	bh=cJuRp/VT9u23ZwqggQtkt7xtePVkwfUUowEUIFvzudw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TriZtZOW4Nr5m5+GATZioCXLkHQf2UtWYdGWRP45uyEEkAv/esnKj+vzDSAqjDVEeTTR3YbJTndliNKuhSTelkpXc8xo4SWPRAQKFn0V6fg+JbeYykbmtkH826/wnhT/3t7B7ymFFX7C+bv2SPRkq/yexkcfJ0BEieShQyVl3yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwBEFxkd; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71957eb256bso2505676b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 04:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726918091; x=1727522891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1TosarMix0EeLolPPk4hOFOZ1EcbZ3V9GwDjexY3/fo=;
        b=bwBEFxkdVE9bUvTYt2B7Ctkd2p3wmpQGuABEHqII+ySHz0sc9MOGI07YOxstYF3hm0
         y7Y81BHr9GWFZQcYlDZg/7fBhFJqfX1zDAptEmWgeFGkAuRM40gVChClk517Y/qS1/BD
         iWKzujYdq0PdtRMDNjK0SBVJ7dq8GZr5pH1O9q2z3NfEeCyN56sQbu9X8F1q6gReUIhd
         0a760WQ7jjeYjO/DQ7zCL8AYdqyC4iaPVT+/5lM/4zxAvxRuqKMiaykR3eAXuyx8nkmx
         pNr8WL4k9Sf7MwnohYgyHYNpDGE5IMmR/yI/SimPWtWVEANWsHXIPFaPp2tKyXhB4SRg
         ol6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726918091; x=1727522891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1TosarMix0EeLolPPk4hOFOZ1EcbZ3V9GwDjexY3/fo=;
        b=b9ltN36cXCdnbZn8xB/P5bQxCqHZ13NKJT12uv6Iogl+A5l1Oc8UG4ivwqVA7p8S1h
         bPpPu60hEhWwTW0/uTYsNwayzeP4Hh42F5Q+6bMTNJhNIyGIvy9ARGxnM4IXYJyMWKeU
         ekXlwl070QY4lTSQHpcH5NkqaUwQGPE/k1tGBXbqRApWjheRh+ZirP5mV0BsRKCeFJep
         WVuAGLU5H/dlclgVR05hy8jtVaURoKJOjffPNvZrfF9wwtaogAkYw95ql3xPESVp32nu
         VO5cZaCkUmC0Pwya/wlQWeIYDd2x4vbgtBXKU9tqRCxYlIQky9uU4N0V8BV9KISH3qMX
         3j9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBM16AUjfez/2gtu9+640xDLn1D+RJurm+emWWP1kQmrMcGcT4KqxtaFSUzzU9AVeJR6Hz3mDPRqe/Q9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLIHPpHcEVrKDiPs66nvrIr4XoEea+3tb/VBTbbb1xl8BEgP1H
	xzB1BOmktpE340mBKPoISVsHMyDLabJppm17NxgGTMQ+UQMhTvCW
X-Google-Smtp-Source: AGHT+IHCIfk8HcWv/D8DDJPhd0JyXbNBo7shCo7ksMrbEmle4wuD51KpLK6mMmOWR4h+h2fmXvowTw==
X-Received: by 2002:a05:6a20:d795:b0:1d2:ef5c:13f6 with SMTP id adf61e73a8af0-1d30a987f85mr7330776637.34.1726918091388;
        Sat, 21 Sep 2024 04:28:11 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a974dcsm11173426b3a.32.2024.09.21.04.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2024 04:28:11 -0700 (PDT)
Message-ID: <a333f5f9-ffc0-4dea-80de-92e275492235@gmail.com>
Date: Sat, 21 Sep 2024 20:28:04 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] tools/memory-model: Switch to softcoded herd7 tags
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>, paulmck@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
 quic_neeraju@quicinc.com, frederic@kernel.org, linux-kernel@vger.kernel.org,
 lkmm@lists.linux.dev, hernan.poncedeleon@huaweicloud.com,
 Akira Yokosawa <akiyks@gmail.com>
References: <20240919130634.298181-1-jonas.oberhauser@huaweicloud.com>
 <20240919130634.298181-5-jonas.oberhauser@huaweicloud.com>
 <8cb4e810-da6c-4d8f-b608-5bdba56da2bd@gmail.com>
 <c0b25884-b22a-46d6-949a-81fa9ce8f836@huaweicloud.com>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <c0b25884-b22a-46d6-949a-81fa9ce8f836@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On Sat, 21 Sep 2024 09:39:05 +0200, Jonas Oberhauser wrote:
> Thanks Akira for your continued eagle eyes!
> Will include in next revision.
> 
> One question below.
>  jonas
> 
> 
> 
> Am 9/21/2024 um 4:44 AM schrieb Akira Yokosawa:
>> This litmus test is not compatible with klitmus7, which is much
>> stricter than herd7's C parser.
>>
>> You can have only int or int* variables in the exists clause.

I should have said:

   By default, you can have only int or int* variables in the exists clause.

You can find an example where an atomic_t variable is listed in its exists
clause at:

    Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus

, where the atomic_t variable is declared explicitly in the initialization
block as follows:

    {
	atomic_t v = ATOMIC_INIT(1);
    }

>> Register variables need their declarations at the top of each Pn()
>> (classic C).
>>
>> See below for klitmus7 ready code.
>>
>> And tools/memory-model/litmus-tests/README need to mention this
>> litmus test.
>>
>>          Thanks, Akira
>>
>> ---------------------------------------------
>> P0(int *x, int *y, atomic_t *z)
>> {
>>     int r0;
>>
>>     WRITE_ONCE(*x, 1);
>>     r0 = atomic_add_unless(z,1,5);
>>     WRITE_ONCE(*y, 1);
>> }
>>
>> P1(int *x, int *y)
>> {
>>     int r0;
>>
>>     r0 = READ_ONCE(*y);
>>     if (r0 == 1)
>>         WRITE_ONCE(*x, 2);
>> }
>>
>> exists (1:r0=1 /\ x=1)
>> ---------------------------------------------
>>
> 
> Should z also be changed from atomic_t to int?
>

No, it should not.
Such a change would make z incompatible with atomic_add_unless().

        Thanks, Akira


