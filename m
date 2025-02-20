Return-Path: <linux-kernel+bounces-522917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 778E8A3D014
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9303189186D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B561DEFF1;
	Thu, 20 Feb 2025 03:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0BTlue6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A5F2AEF5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740022163; cv=none; b=nztfHcBxPuK71Ersz84Fb5PVko8+z4YFIwVuovaApj6QZvMOoyapnDL2L2SVjm3D18PpFOWDmw7pqVTfxbN/ZTDd3kLMja3mdibkSBBmZs2Uq5EIz0RKYMWPgY16OQuT5otKedIBgFTa4SE94AD1vIyLzjnaty3NG9Qx/U1CymU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740022163; c=relaxed/simple;
	bh=x8UfbZ8X+5fr9SvuzfxqTGqh1u0oMnuWXrayd7+/8NI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=vGcszlYGGEhqVPvM0LMLxINa2ma2vTOq9q23v3oyxBZGdnyd7gUJrBarbUWu21LVn7rE0T+Nu30IN0JlGwoOHjtCaHxT0LVIhp8ksQGXEAG/+g+5kEF9sO1Lyw0o0ukx4H8at9yzyVIPykc01KvMKmQN5B0Ykb6fqarsTug/ewo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i0BTlue6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740022159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5RmLudMZbjhJs//q/v0HEJwcUpuvtvTaPYdXzzF2wAg=;
	b=i0BTlue6Jb7YqlfHZP19ydhIUlwYZtl1ldoRjVr4zIv0zKKDUU2j7Ma4/5uyw0EOF6UzhO
	M7kGkGXO/aq9karB/SZZzYT2Uwlm/l8LH+BPowzEf3UldPjdHn3s6Y8u36NTJtxnCags/a
	qZu6bcLT0MU5QDVjr6DN3XlWFs0K3C8=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-6gnKMk5WN6-cXt8ti2DAiQ-1; Wed, 19 Feb 2025 22:29:17 -0500
X-MC-Unique: 6gnKMk5WN6-cXt8ti2DAiQ-1
X-Mimecast-MFC-AGG-ID: 6gnKMk5WN6-cXt8ti2DAiQ_1740022157
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-2b2aebf00c2so155772fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:29:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740022157; x=1740626957;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5RmLudMZbjhJs//q/v0HEJwcUpuvtvTaPYdXzzF2wAg=;
        b=gA0RBzoIktEwSMO1JD4+u/Zmc3lSQOh/aCgSAOteYvMCoCWUZANmfHP7Rnf620VeRK
         HUZShLVcFvZ2t7Gm/h9uet9eNPnhehRVmov87LuNtttvoSoHn8Ak/S9qdLn0y9/nRFwC
         d/vvbObSHwZvlYNb1Xqb9brluHU0SVjcBybScu5wTaZYcHxIH5utz8VTqLjiJrwey2BO
         j6NshJyNRgys3YyQaxgfYf8S4tAvcLUxc4MT4R6drH9OCYJK3O7AL1WVQfC1G05fk0HO
         xs75yy6nhWEobuWOulCqbkAiJf4eDSemRCwtK7XOAkLHFUgA45nbry8/nwIyYdxCYigo
         LGcg==
X-Forwarded-Encrypted: i=1; AJvYcCWyDE5H113uH5TXkBUTIX2oBbSVRC6MsLue/qg+flUUtyewFZvh2hA5e8rwhFQXk3R/8DKCHksqtIyX5qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCvgOOdFIEbSX/ZTVl0fBRGwDqA8+r+k62G+a9Ig4V4S2Lv681
	zAEXPc5iskbKYq1p/JqpaNllEzj3rJEwgXLTliBlgCHBrhxeamYUb4oX6of9KhsZZvhhMFNR/A6
	oqh0q/5c2vY8/1O0a940HafWbr3ZarPqEse7JkaYm7W9mi/y0/LOEXmbLWC99Ig==
X-Gm-Gg: ASbGncvVsM8ATopZtVhq7tLKg553qFSusmcfeLvaZTx7GTX7EivjPw7ukNxi5nBzd8E
	a6GFnCx7HZKiNs84YqE/KBT7C5U/DJMLyIao++V8+rHkzI5WPE5l+VhlhoksX80LaOQBmpUtuNA
	/vEb+HnLC7Sns6jGSmtvzllB3EMH3ZjWdnobNUqgPLGs6vPt8SB2a854vRDv4hg8g58mykfvRPs
	kSHR24cIEJ8gU8KJINfy0WP7iZAqZQFR4HDsx2li7fz32mbE+hE2U2hgMMhXAoE/Z3gCFhbkWR6
	eiToCB7jkMTRVRkaqAQKH8tJ5+gCpWYlHSeIir6ro4Bydgsd
X-Received: by 2002:a05:6870:c47:b0:29e:684d:2739 with SMTP id 586e51a60fabf-2bc99d90c69mr14428290fac.32.1740022157025;
        Wed, 19 Feb 2025 19:29:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQ8CW05WOfmwhWbiIO3fslX6q4AOMbeOAGzVN+41OUPwv0UVPke0cvunK9HY7sRsYtXPchhA==
X-Received: by 2002:a05:6870:c47:b0:29e:684d:2739 with SMTP id 586e51a60fabf-2bc99d90c69mr14428274fac.32.1740022156659;
        Wed, 19 Feb 2025 19:29:16 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72732eba000sm1347259a34.61.2025.02.19.19.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 19:29:16 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <46eca355-930c-4f6a-97cc-6787b6041a0c@redhat.com>
Date: Wed, 19 Feb 2025 22:29:14 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is hung
 on mutex
To: Steven Rostedt <rostedt@goodmis.org>, Waiman Long <llong@redhat.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, Joel Granados <joel.granados@kernel.org>,
 Anna Schumaker <anna.schumaker@oracle.com>, Lance Yang
 <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Yongliang Gao <leonylgao@tencent.com>, Tomasz Figa <tfiga@chromium.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
 <173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
 <20250219112308.5d905680@gandalf.local.home>
 <0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
 <20250219152435.35077ac3@gandalf.local.home>
 <db4ee5e9-56bb-408c-85e7-f93e2c3226dc@redhat.com>
 <20250220075639.298616eb494248d390417977@kernel.org>
 <d8c01f69-34c0-45cf-a532-83544a3a3efd@redhat.com>
 <20250219204153.65ed1f5e@gandalf.local.home>
 <9f9150b4-1cf5-4380-b431-419f70775a7d@redhat.com>
 <20250219212708.78b93a84@gandalf.local.home>
Content-Language: en-US
In-Reply-To: <20250219212708.78b93a84@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/19/25 9:27 PM, Steven Rostedt wrote:
> On Wed, 19 Feb 2025 21:15:08 -0500
> Waiman Long <llong@redhat.com> wrote:
>
>> Writer - setting them:
>>
>>       WRITE_ONCE(lock)
>>       smp_wmb()
>>       WRITE_ONCE(type)
>>
>> Clearing them:
>>
>>       WRITE_ONCE(type, 0)
>>       smp_wmb()
>>       WRITE_ONCE(lock, NULL)
>>
>> Reader:
>>
>>       READ_ONCE(type)
>> again:
>>       smp_rmb()
>>       READ_ONCE(lock)
>>       smp_rmb()
>>       if (READ_ONCE(type) != type)
>>           goto again
> Do you really need the READ/WRITE_ONCE() with the memory barriers? From
> what I understand, the compiler can't even assume what it read is the same
> after passing a memory barrier like that. So there should be no reason it
> can reread the memory location after a barrier.

You may be right. However, without using a READ_ONCE/WRITE_ONLY, a 
compiler can potentially break up the read/write into multiple smaller 
trunks resulting in partial data. So I will use them to be on the safe 
side. In this particular scenario above, we may not need to use them on 
type as we are going to reread it. I will keep them for lock though.

Cheers,
Longman


> -- Steve
>


