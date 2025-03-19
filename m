Return-Path: <linux-kernel+bounces-567948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2851BA68C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382D6189BF27
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5BC255259;
	Wed, 19 Mar 2025 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y20+15DA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0A954758
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385783; cv=none; b=dF1iglFAMtSgVxGv8O4oDKATVi+/RFM4/+AGt1jMsO58eueo/VyyakDoImKbILQbZyykrcDZs7M8dohA9P9SHIh6Qyqpnke3kjb8XESxjCRfAk4PxJyYB/lKk7KnLVpuFdm3nHnMklKrpl8peDldGo6s0nJ6wgGWs/SQ2HPncpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385783; c=relaxed/simple;
	bh=0FwV0HNcL+vt4qpXO6jzr792i6b6LgV0sJ5JC4nVi0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1kJGdGm6z7bSMjNyUM/u3XDl4kd/FDE0kTG8pwYIwok94x67s+FM5aOO77O6cvd/4FSrI76pwPhLNUxG/jc30hYzBkY2cFIFRZBur+ysRaEoGwz/uuCnt77aYJpL3VJUpCIPRlCdN4D41vUdS3LeeQVs45mxRkZAV2Bg4q3ohA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y20+15DA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742385779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7gn15plHVRiqXpFBn0Z9q9dTxOPDKBEPCsHLFphLWXc=;
	b=Y20+15DAQhAkFq3bvd7HKEgB0wHKYqiQcPn9ZtAlUqqQAYzSPTKiRUQvaRqE8r7Gof9Hgm
	87+jiRYSjXGrPHczw+xZqy4KwY+8i2YPtcEpD08bf5eG2q9z+lqvBjT5u947CUNTL72+1M
	QkaUrC4/Zy6/CLAy6+nQfCah4lCf6IE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-eoxkHv_VMLyA-bCKPYjwdQ-1; Wed, 19 Mar 2025 08:02:57 -0400
X-MC-Unique: eoxkHv_VMLyA-bCKPYjwdQ-1
X-Mimecast-MFC-AGG-ID: eoxkHv_VMLyA-bCKPYjwdQ_1742385777
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ced8c2eb7so32744465e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742385777; x=1742990577;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7gn15plHVRiqXpFBn0Z9q9dTxOPDKBEPCsHLFphLWXc=;
        b=nhs2Hg1CCJQ11wafEjBnmEiyXsvchfBiPtQ4qNXu1K2oJr7XQ5O0HLdC8j9Q3w4hy/
         xKRn4Z8Bm+OZHVkIE+YtxJMlWGWtL/8YEr8SqjORBY0DELpk4m9g9XFPMybX1mdyAHup
         VljZabYx1IwKNkJ/XoU75RWINw/UE1CnanFKr/9PG6XHpqAeLgvoSFvVIQEurSb/HWRF
         BM5H3guzJlPFMbk9GwO9V7VgRJx4xdnpBFdo46aDhFDsMM39BxE7XnYk9vbdMFXARzNU
         GGqfUNb4rjgRfCzzVUQRBLXXGfvQPyW2reF6TholeJStBOR4wU+DHlwHnuRdCfnW4ie/
         3R3A==
X-Gm-Message-State: AOJu0YxBhrUImyzTzf3x+jMggPRTXRV9l7waW6+v+3AUq4ZQBZsow1Lb
	5KhIZZGWZcyEvaz/x9lXgRZWm9HpHXIb8mjgo+OvgShLZC1AwHF5Wvys9puZkhQsYQ9BcP3XOtN
	GPaBVFfU7KTDln2Qd2TPOg1LQIhxVt6lqczkQxTEAwcTX/Jw5N+DtK0kNJn6NtA==
X-Gm-Gg: ASbGnctdq9QzRbBXIKV0SyiVY/SHB7POC06pGJe+FvkF5yIugL7jMMOl0QTzmOVvjzG
	qTcYOJIPEfnbA3nmw2Zyc/ovj+5Gdm5+FB90Frw6A7cZqdbpKWLz63FBZ7QAZxAzfQWq4LqZbCm
	dGS9RP/eFLnrS/ikOZfoRthDAq+P9V0Fu8n/1Fy6kdcpS1TRyNC7PnjIqBJhSUwk9rbEEfA2ht5
	SrF5OQ3UVtuizdYyLApk4K8u7V8yfRo8Cgg6xkxF0B50t2zrhUac9b0VSyYztn1Y0xQ9VKovEQM
	087IPJpvolRMdCNKDqCm6hPKaUe0l8KWTkA11Sdr4S2/z2WWiUH99WdM1ZuLoI4gJKorDI+gwbH
	ZBdtwTbF1w9lz1nEpkdTF7v7/A1neViAmGf/W2Pv2xtk=
X-Received: by 2002:a05:600c:46c6:b0:43c:f5fe:5c26 with SMTP id 5b1f17b1804b1-43d43786292mr21442845e9.4.1742385775907;
        Wed, 19 Mar 2025 05:02:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO9wFO2nTkTUlJSs58/meqK0dfmIPHPe7ubDLeTE+LBbIu5UE13qcBy19o/yn3H77bmuGCZw==
X-Received: by 2002:a05:600c:46c6:b0:43c:f5fe:5c26 with SMTP id 5b1f17b1804b1-43d43786292mr21439295e9.4.1742385773180;
        Wed, 19 Mar 2025 05:02:53 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:df00:67e8:5c3d:de72:4929? (p200300cbc705df0067e85c3dde724929.dip0.t-ipconnect.de. [2003:cb:c705:df00:67e8:5c3d:de72:4929])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed4cbsm16960215e9.34.2025.03.19.05.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 05:02:52 -0700 (PDT)
Message-ID: <d0f0cbb3-6284-4060-afdb-ea828b9e909d@redhat.com>
Date: Wed, 19 Mar 2025 13:02:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] kernel/events/uprobes: uprobe_write_opcode()
 rewrite
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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
References: <20250318221457.3055598-1-david@redhat.com>
 <20250318221457.3055598-4-david@redhat.com>
 <20250319120028.GA26879@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250319120028.GA26879@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.03.25 13:00, Oleg Nesterov wrote:
> On 03/18, David Hildenbrand wrote:
>>
>> +	if (unlikely(!folio_test_anon(folio))) {
>> +		VM_WARN_ON_ONCE(is_register);
>> +		goto out;
>> +	}
> 
> Don't we need folio_put() before "goto out" ?
> 

Yes, thanks! ... as always, the result of some last-minute reshuffling :)

> Other than that, for this series:
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> 


-- 
Cheers,

David / dhildenb


