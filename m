Return-Path: <linux-kernel+bounces-522822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB02A3CECD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FEFE189B023
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE61A13DBB1;
	Thu, 20 Feb 2025 01:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBvR0z8z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE857082E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015381; cv=none; b=QRLv4vdTKhjRsEgvvu0V2AlkkFiIY0gKTPZuArdoaC8QQG7uzO+WbSdYK4iF2jZRiGg75oDoSSR0+CcBcPa1TCxCADye8sI3SpOSxTBIY2AenEsrofodHnZd31QBx8ATkoUeyPQuXIZxrplF3JJIC7fOsKh56FTH6gK8hwubZBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015381; c=relaxed/simple;
	bh=R5TxvxsZwHt0rO7emOi+MR0uQ2bgbgllr4eudFiTsso=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=reoPtJ2fCd6uviqU9Uvji0k0/4ED8rpwR/Uj9XZZHZoBfBcZCuq7YZ+pklVdRlsDDIeNzycEEgq2dkgCkMwDKVHRfuTAEybTsFSSYQP0Bf1RlW+Oax4rGbGlItp1wGEhEUfD/d3APdmZcHQH24xuf3H3la0ep0AeULEWRrxsaQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LBvR0z8z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740015378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dyt+UyexCy2S6NSt7d7+7qR1hd7bun67cNPljmVUdxA=;
	b=LBvR0z8zFm/z5TUS6WYOcB344IRg0VIGFekfst1P3LHtmtu3sJPWifa4fyN3ebn+bL7PdD
	0HUHkHLpjU2azWLLXDbfUeSyERC/QkxCB9Ze4BLem1Ptx88k6rGgXTe9rvMlQYzrFl+wts
	WikOt1j02zS6coJrkwe2kxQZUAursDY=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-7QCICzBaPKWZktKsyooRsw-1; Wed, 19 Feb 2025 20:36:17 -0500
X-MC-Unique: 7QCICzBaPKWZktKsyooRsw-1
X-Mimecast-MFC-AGG-ID: 7QCICzBaPKWZktKsyooRsw_1740015376
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5fc2eb2ddf4so624734eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740015376; x=1740620176;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dyt+UyexCy2S6NSt7d7+7qR1hd7bun67cNPljmVUdxA=;
        b=fkWqaVeWVIbEs+8Z00Oa5M9PXDeHULfqN0JVud1lIi28x14nGCXozRXuJTLQm5dW/b
         PnHUA99LfqOJzjZ1mL54rF0cijDnHLZL/v5c0BODTvCeFdG8yZlk4TpIXnGkzNFMlkfs
         XfTLkPBkijWlisvTW7hUkuFHv5OzbZM3KhtBOqRV+2YMMGoPw1m9rzB0roOdL2LJA5P8
         LmvZgFwS5askVALs5Wyfx8MVtJrtwkG+vpncWw51RF7kO+Q1AVpb/GgA79HckoBdyvSr
         XhEGjqHsuCWLDQsQ3Y8dJNNdSL+OuW7gPDFtJ69zh54eE67SIAPHfSuwc12sPqcDJ8/u
         wArg==
X-Forwarded-Encrypted: i=1; AJvYcCVrQOpJeHMW8Hbr73kP+Pa+Ihh2pM9iA7KWaPR6InEYJa7nL7Zcg4KRgXpr/hX5rKn1/Ly0OU5uDmu3sRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjuYe0R69nhIz/Q9mmpzb0rJN25PldPi6LvCDo+0oEtM6Gp+/6
	CzGOkXMpbsUwBJEwZEdkiD1/lt3bhwhSCILh5+GmgKdD6xQkjiD8+oYiDe8BQh/kwMuliRF+NFO
	w3RpI3cbha3r/OH1P//pR9T7Avq21BpfoGSpdyJAoU4Sug9WjWGJEd8eT18UXFg==
X-Gm-Gg: ASbGncsCPntaieUkqrOIboojdu0UM7fiIrFF5fuVq+LoUKfi84GJJuNLeU/MC3PC9aX
	1XPqgxrBoVUmfLDzBAqyw90+A5FJe+8dgM9W6duxFsnTPFHq6fET/y7Bv8ee9QB7VXQsllPFlzd
	JiEUAuKyrNJLjgG3f4uWPvx5AYKD5m4SIll0IwWCc0CzvsCFlPhPM1QTjUGW+dc5r/vZvwUF8yr
	BxWXiSWw2offUh1LYLcTAujy1Zj1sPjmOD1j/hZg2evZH4IK+UNyY/ZAkKiYcqBaQE/5kKyTYIG
	BsHMFRXUZ0EMeWIHBn8pwTufcJAdqjyAoHVqZw4Max+JFdZD
X-Received: by 2002:a05:6871:6ac:b0:29f:8a1b:f76b with SMTP id 586e51a60fabf-2bc99a93119mr14390405fac.9.1740015376286;
        Wed, 19 Feb 2025 17:36:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEc3qdhIgt6MllXMs8VtuUxscrVHayzDGAXSY9S4MfEFS3lGK7gLdXU7IIbu3ceV0bvAY3SAQ==
X-Received: by 2002:a05:6871:6ac:b0:29f:8a1b:f76b with SMTP id 586e51a60fabf-2bc99a93119mr14390384fac.9.1740015375998;
        Wed, 19 Feb 2025 17:36:15 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7272fb6eb19sm1559968a34.27.2025.02.19.17.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 17:36:15 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d8c01f69-34c0-45cf-a532-83544a3a3efd@redhat.com>
Date: Wed, 19 Feb 2025 20:36:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is hung
 on mutex
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Waiman Long <llong@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
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
Content-Language: en-US
In-Reply-To: <20250220075639.298616eb494248d390417977@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 5:56 PM, Masami Hiramatsu (Google) wrote:
> On Wed, 19 Feb 2025 17:44:11 -0500
> Waiman Long <llong@redhat.com> wrote:
>
>> On 2/19/25 3:24 PM, Steven Rostedt wrote:
>>> On Wed, 19 Feb 2025 15:18:57 -0500
>>> Waiman Long <llong@redhat.com> wrote:
>>>
>>>> It is tricky to access the mutex_waiter structure which is allocated
>>>> from stack. So another way to work around this issue is to add a new
>>>> blocked_on_mutex field in task_struct to directly point to relevant
>>>> mutex. Yes, that increase the size of task_struct by 8 bytes, but it is
>>>> a pretty large structure anyway. Using READ_ONCE/WRITE_ONCE() to access
>>> And it's been on my TODO list for some time to try to make that structure
>>> smaller again :-/
> I agree to add the field, actually it was my first prototype :)
>
>>>> this field, we don't need to take lock, though taking the wait_lock may
>>>> still be needed to examine other information inside the mutex.
> Do we need to take it just for accessing owner, which is in an atomic?

Right. I forgot it is an atomic_long_t. In that case, no lock should be 
needed.

Cheers,
Longman


