Return-Path: <linux-kernel+bounces-312385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9129695DB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51290B25825
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3052F1DAC46;
	Tue,  3 Sep 2024 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RcwqNB+4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F161D6DD1
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725349314; cv=none; b=WqY4zzCsy+b1b7sUPHSoSypgFXf/SepGBNFRGibHCQF3WWX7gYKDD/yrTIb52+5tulv5sdZzbrUTePz306BPsbSDl2GxIHBBudhi5rTgyyTkSDxmhA0FlGt4UXJCJeZaj5Mo7kOdQXTKlNoDxasSFgC5/5OupcwSTGz7wIOKGwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725349314; c=relaxed/simple;
	bh=U9IVHcG4wbC0yQ7L6qBp/N6iE98USYi+qYB3QHxg1WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IM65x0teUEW11Mv7dVrrLgkYkmnei2WgO0YDcGt7ILh+7LkNEoED0tLOY4Shhr/WYigSH4GRPeyQ/chxsC6Yi0p1DGd9qi9VgadwlMiUR9BgmwYKSSH8NvnCeUreuLiiGjQIYI2qzp5PNCuKYv3DvmlpAyq1lPsR1Ks0s6qVLmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RcwqNB+4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725349312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=izDPO4iZlSSWjFLviOO6wl7Tt97btyPERPQrQfVWFJ4=;
	b=RcwqNB+41BNMP86veeFo5gHiVTPXsr7j9jG9KkA6iyFq/+Eq/2Mk2rfAByH0BJKzfsiiQV
	mGj7I6nh7+f5bwQHYtdxjFZ29kr1BS9iltKD04rKLUtJhbnNqrGy++IZn8YWl5eWt9iToi
	WTvGG8b2gJpyd/Zu7pHoHms4fil0itM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-2phIVygdMGmgtysjccC8rA-1; Tue, 03 Sep 2024 03:41:50 -0400
X-MC-Unique: 2phIVygdMGmgtysjccC8rA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374bb1e931cso1441263f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 00:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725349309; x=1725954109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izDPO4iZlSSWjFLviOO6wl7Tt97btyPERPQrQfVWFJ4=;
        b=w0RevTQIfYbmYlCo1cA1ioNmkqcb8O1x6ADUpigoWCLQiguluL9Fm8kjvjXZp69RI+
         7ply0naoROlSoJC2FvI+Roeu1qCo9iC3LV+Km9hTTmf6NlWPOfE+KDc8JgRnjlKIiCyN
         mnMuu7b+10tAn1D5nt5TY9nVGxcR2GMSykEWb6epnNMiYMnWZ0vi+rbZnmBloWD/BkPK
         YLQRmV4UvPLYC+TL8MKKMsiCnEygIgdsMr4L6lFt2++TlPmbQP1kIqs/ffxyetcyqumL
         7YFozmUY/dwjxnSOy66cfVw8XnNXI4FLSTcS3vG5Xe6B46sM1FJ3Ze/BfTgNej7O+sKB
         P6ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWYPVcBaKt5ClGMOyYViJoNHQC/Cxw5SGV26N3nYtD4pfi4ZZULtUcsTIg8qQS1GN6iAjwrqxra1kvLGyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzijynFSGv2nexAKvnUsqaaHA3Pq8SHCKw5xkEVMuztuvdc6s0a
	nVjOcDCTEbFilFasE9K3uGRiqiwfKsz68ekULFzXtEJBQXpRucJ3CFczfuwED2CpTbB9fvp8MIk
	aafu1eJkBPbb7YjOD5BzMZPeC9cCmBKhKM0+LFxgukkdS3prJsJmqGqR0eTq/Lg==
X-Received: by 2002:a5d:4f0a:0:b0:374:c2bb:8387 with SMTP id ffacd0b85a97d-374c2bb848bmr5587815f8f.30.1725349309060;
        Tue, 03 Sep 2024 00:41:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHkDJRwbp5dgt1hItw/RDoK4tfshSZ4gIZ2gsD0hqTjOt0yRRq00N2XmU+gpLdCtCRS205lA==
X-Received: by 2002:a5d:4f0a:0:b0:374:c2bb:8387 with SMTP id ffacd0b85a97d-374c2bb848bmr5587808f8f.30.1725349308163;
        Tue, 03 Sep 2024 00:41:48 -0700 (PDT)
Received: from [10.43.17.27] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374ca94e002sm5013917f8f.72.2024.09.03.00.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 00:41:47 -0700 (PDT)
Message-ID: <0f3375e9-59dd-415f-8571-48f346b64d57@redhat.com>
Date: Tue, 3 Sep 2024 09:41:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Fixes tag needs some work in the perf-current tree
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240902081837.6def2734@canb.auug.org.au> <ZtYHGDaoJrwLgs--@x1>
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <ZtYHGDaoJrwLgs--@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/2/24 20:42, Arnaldo Carvalho de Melo wrote:
> On Mon, Sep 02, 2024 at 08:18:37AM +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> In commit
>>
>>   387ad33e5410 ("perf test pmu: Set uninitialized PMU alias to null")
>>
>> Fixes tag
>>
>>   Fixes: 3e0bf9 ("perf pmu: Restore full PMU name wildcard support")
> 
> In the perf-tools-next I have it as:
> 
> commit 37e2a19c98bf99747ca997be876dfc13f9165e0a
> Author: Veronika Molnarova <vmolnaro@redhat.com>
> Date:   Thu Aug 8 12:37:49 2024 +0200
> 
>     perf test pmu: Set uninitialized PMU alias to null
>     
>     Commit 3e0bf9fde2984469 ("perf pmu: Restore full PMU name wildcard
>     support") adds a test case "PMU cmdline match" that covers PMU name
>     wildcard support provided by function perf_pmu__match().
> <SNIP>
>     Fixes: 3e0bf9fde2984469 ("perf pmu: Restore full PMU name wildcard support")
>     Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
>     Cc: James Clark <james.clark@linaro.org>
>     Cc: Michael Petlan <mpetlan@redhat.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Radostin Stoyanov <rstoyano@redhat.com>
>     Link: https://lore.kernel.org/r/20240808103749.9356-1-vmolnaro@redhat.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> As I have:
> 
> ⬢[acme@toolbox perf-tools-next]$ git config core.abbrev
> 16
> ⬢[acme@toolbox perf-tools-next]$
> 
> And scripts to make sure we get enough resolution to avoid such problems
> 
> I just checked and yeah, on perf-tools/perf-tools it is:
> 
>     Fixes: 3e0bf9 ("perf pmu: Restore full PMU name wildcard support")
>     Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
>     Cc: james.clark@arm.com
>     Cc: mpetlan@redhat.com
>     Cc: rstoyano@redhat.com
>     Link: https://lore.kernel.org/r/20240808103749.9356-1-vmolnaro@redhat.com
>     Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> So I suggest Namhyung fixes up the Fixes tag to have a longer prefix for
> the sha and Veronica to run:
> 
> ⬢[acme@toolbox perf-tools]$ git config core.abbrev 16
> ⬢[acme@toolbox perf-tools]$ git config core.abbrev
> 16
> ⬢[acme@toolbox perf-tools]$ 
> 
> - Arnaldo
> 
Sure, will do.

Sorry for the inconvenience.
Thanks,
Veronika

>  
>> has these problem(s):
>>
>>   - Target SHA1 does not exist
>>
>> Actually, the quoted SHA1 is too short and is ambiguous in my tree:
>>
>> $ git show 3e0bf9
>> error: short object ID 3e0bf9 is ambiguous
>> hint: The candidates are:
>> hint:   3e0bf9fde298 commit 2024-06-26 - perf pmu: Restore full PMU name wildcard support
>> hint:   3e0bf93e0354 tree
>> fatal: ambiguous argument '3e0bf9': unknown revision or path not in the working tree.
>>
>> so you should use
>>
>> Fixes: 3e0bf9fde298 ("perf pmu: Restore full PMU name wildcard support")
>>
>> -- 
>> Cheers,
>> Stephen Rothwell
> 
> 


