Return-Path: <linux-kernel+bounces-556902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B4DA5D04D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6158B189C01C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EF625D8F1;
	Tue, 11 Mar 2025 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/925Nvj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C841EDA20
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723378; cv=none; b=a8h4QI8Et/LBp4VEjn76g9YoAZ+iQOgCSPThDe4/uF7d1PEf51zqmhxAXSwLVDy7wfqyOyPduscTee5xVix/ffrRdGtFJb8Xi6i4OazCNYZCd1xZpjXG4aag25AVd4MzV9V/xvRifm/OyFeAcFXt3EC3cILh1Qx9gI0etQVZxjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723378; c=relaxed/simple;
	bh=voaHAvIK1G7020iSJ26MIuzUNv3c7H7l6//9jDs+mDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYAh0jWRB4Khuqmsmn8m2zti+/HL/Jf3I9PxbxylGT0zrZJtmEW+mvmnGb8REWm56CIeWBXHAVw9hGYqvAxSGUKH9i6w2yj2Tf9Tn623no2mB85V9zbhXNNkmh24iGHm4v/3L/iFIpJJ+DB18K7XLK9uKgGEV2qoeFKhGTf+9qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/925Nvj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741723374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jcN6AhGFmZwyWIgsYRQkrJVVdkpynFpZX2fNETRTvzo=;
	b=i/925NvjDG2ly1poLMreGt56NhE94oHTNz1oDrJWQiuwNbKbg4c6zxiHQaErBGVe234Xq5
	vymNfO9YnULwofZJUSewGS4WcUiuvKHXICX69k5Wych5HNimrcuNZMxlci9sOD6k0TQYWt
	0D5+4sZkU908BhkSWSv2AL5xKfWnpDg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-qh6vHNrANXq5GLq2qiAVoA-1; Tue, 11 Mar 2025 16:02:53 -0400
X-MC-Unique: qh6vHNrANXq5GLq2qiAVoA-1
X-Mimecast-MFC-AGG-ID: qh6vHNrANXq5GLq2qiAVoA_1741723372
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912539665cso76281f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741723372; x=1742328172;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jcN6AhGFmZwyWIgsYRQkrJVVdkpynFpZX2fNETRTvzo=;
        b=tQ8L2j1COtEtn/AGKj+iUxlkvZniLvBHYFxjodlp+DV/j7XxuuzXYtiw0S1fvQO9wD
         YSAx23oAylPrOZSWaqPY5kNDJ/2tYTh4PqA53FjDjKEP1jKhfsCjo/fdPFIAVE5cd7CZ
         BPuaH7lleSja5Vc2eXh3IPVAEE+/sRCoF/+hhuvJDbgGDcu5W1LzS50mSHC+0y99eoKe
         xKFPAe4KG+G/67OXnywdikDsHWk2kJ97PycboOtUndK0hei1vPjXE+EEEeCmueM3jgyR
         aQgh1mFoiqG/vwAv74bgoxYUW88njuAsRp3Bl3WtIQC/sqHfpG2sboMtFT86E1y+3TFf
         ot4Q==
X-Gm-Message-State: AOJu0YwnzIhv1EParh5XXNjzX/noq8jj/fgWK62tzZkliExtkNf9HBDn
	LsBpx+KdYDaDNsO/sVMqyB2NsoAYsVxth40ERe1ClNvjaMFuqa6oEVsFPais73AFWnmHCYtpxUB
	gb+lVpJlXlDpKJfv/vgqAsIJQLbyaNMk5pVLVHJc5ajunIWRT5gb9XDHwDcjxIg==
X-Gm-Gg: ASbGncuAwMYEU2rNlqODW6Zi8eoRU6Z+CpR9xB07lIKLOyu8iKRsAVClbe7rrCDjL/o
	oTa51h8qCSsxt3JiJCmlgNh09/MSHubM7v6kR2LyhkixLnfsiPKdDZmUcapEhp93q7hdAPfGXKe
	d+aN+t+I5/nNDqefdSyWTOi2WbzHNe1RbmByTfjHU6+SzhK7qEhBcGzCoEdBoIvne+OXthZZADD
	40wk/qYoylD4INDUE7wcx0EIjodulLGf8HqueBFOLKaKov6oLE9/5VrmldPnhoyQjgIRJfReK6A
	lt5j34pcDVuH9aKAbb0ceIv0/oX6E6GmRl5jgxcG2RRdz3VXf88b6HX8+yFrEKqtpjXfI3wPIKD
	v15xRou16yj4vW+YtC0hvKhd7fO6IpzTc2h+2VoTS25Q=
X-Received: by 2002:a05:6000:144e:b0:390:e9ee:f27a with SMTP id ffacd0b85a97d-3926d6e5b77mr5138837f8f.28.1741723372063;
        Tue, 11 Mar 2025 13:02:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz1KnszMO1UGmdIqIa6glXoDVrgPQeVqHRiLLlBMuqiLukT4z+73e1IBXVmM416wU4yqyiUA==
X-Received: by 2002:a05:6000:144e:b0:390:e9ee:f27a with SMTP id ffacd0b85a97d-3926d6e5b77mr5138797f8f.28.1741723371718;
        Tue, 11 Mar 2025 13:02:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c720:ed00:a9b3:5954:823e:3427? (p200300cbc720ed00a9b35954823e3427.dip0.t-ipconnect.de. [2003:cb:c720:ed00:a9b3:5954:823e:3427])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c103f41sm18750782f8f.85.2025.03.11.13.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 13:02:50 -0700 (PDT)
Message-ID: <03a7797a-75a0-4b45-b5b0-bf8bfb7f0955@redhat.com>
Date: Tue, 11 Mar 2025 21:02:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v1 3/3] kernel/events/uprobes: uprobe_write_opcode()
 rewrite
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Tong Tiangen <tongtiangen@huawei.com>
References: <20250304154846.1937958-1-david@redhat.com>
 <20250304154846.1937958-4-david@redhat.com>
 <20250310170320.GC26382@redhat.com>
 <79ec5aa9-1937-436e-8cf4-436746142f7b@redhat.com>
 <20250311123241.GB3493@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250311123241.GB3493@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.03.25 13:32, Oleg Nesterov wrote:
> On 03/11, David Hildenbrand wrote:
>>
>> Regarding both questions, the code is fairly racy. Nothing would stop user
>> space from (a) modifying that memory
> 
> Yes, but we don't really care. uprobes.c assumes that user-space won't play
> with the probed memory.

Right, I primarily care about that if user space would do it, that we 
don't trigger unintended behavior (e.g., overwriting pagecache pages 
etc, WARN etc).

Likely the re-validating the page content is indeed something we can drop.

> 
> Note that if is_register is false, then vma can be even writable. Hmm, why?
> Perhaps valid_vma() should ignore is_register and nack VM_MAYWRITE ? But
> this doesn't really matter, say, gdb can change this memory anyway. Again,
> we don't really care.
> 
>>> do something like
>>>
>>> 	/* Walk the page tables again, to perform the actual update. */
>>> 	ret = -EAGAIN;
>>> 	folio = folio_walk_start(&fw, vma, vaddr, 0);
>>> 	if (folio) {
>>> 		if (fw.page == page) {
>>> 			WARN_ON(is_register && !folio_test_anon(folio));
>>
>> Yes, that would work (we could leave the WARN_ON in __uprobe_write_opcode),
>> but I am not sure if the end result is better better. No strong opinion on
>> the details though.
> 
> Will, this way __uprobe_write_opcode() will look a little bit simpler...
> 
> But I won't insist, please do what you think is better.

I'll take another look at this series probably next week (I'm on PTO 
this week) to then resend once adjusted + retested.

Thanks!

-- 
Cheers,

David / dhildenb


