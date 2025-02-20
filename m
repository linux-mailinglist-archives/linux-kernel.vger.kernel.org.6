Return-Path: <linux-kernel+bounces-523898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4818A3DC94
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A334519C12A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D141EEA3C;
	Thu, 20 Feb 2025 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClT12c+Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE56F1F03C9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061349; cv=none; b=c/FJk+3fc+iU8mXOZNJsJEG7CPyzcpPAqTD/OYUfa2KN8NEOhl8Pes8qw61hu2napHRAFNIwOJj08IAfLqyvRcteIfx1If/3AUzsV5m/Wy133HRsZv+jycBB1b/Ut4vDW75BJ2b7wT3+7eHYc6XwMyjsSP8npFsDSq6Yxfus5FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061349; c=relaxed/simple;
	bh=RvMBdWtOp3DESzFvYDUh9x1/kB+bNsyJc9bwkbnB5Sc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=occIhiXhmyVtQqrgzCa2r3ZZ8E+1PzjWJFpzwHnzhEKxkrPcZZTzFWAsbcBcBgCj9Ce4vf66pX8A6RFmcmLbnc2FCA4+5T3b5chcB0SRRBqo9iQpGyRvNPxOyDu+2nKhG2wut3I9/kxuC7AflM6sInfUX3HVg+HKlw+oNzAA2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ClT12c+Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740061346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7r14EXjFIx3XwpfOuxJfMQcfssTHWQYqFB5E5YFqFI=;
	b=ClT12c+YFB9RbXloR8eZe7Vq7v+ivtuojqHeuvGMSBU1Knw/H6lgtUHwjYSESbf+RnmDnN
	cpP8K0UsFgriGVJ+gb5l9MW5spN1tY+5gwEvENF2TgvRLaZi6ZWkgF0EPusk80frKiipPH
	SfT4lvjz/Gjw558pQ2UHZEp+Opxhs/E=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-pMri7GDjM6qd6tNHTPZ7VQ-1; Thu, 20 Feb 2025 09:22:25 -0500
X-MC-Unique: pMri7GDjM6qd6tNHTPZ7VQ-1
X-Mimecast-MFC-AGG-ID: pMri7GDjM6qd6tNHTPZ7VQ_1740061345
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-471ea7666c7so18957251cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 06:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740061345; x=1740666145;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7r14EXjFIx3XwpfOuxJfMQcfssTHWQYqFB5E5YFqFI=;
        b=J7Y0i4K8SEpzONZ76uTDQYY9ofnqukTeA+JI3irCIHA9Q1+DZQn9fgMMq6noZVktHe
         fH5RzUbmrv1HfuqmeTcU4YtkQkXCPYQRCKx9zzWtwy4pBHAqN2agyS5ZSAU9V85D2m0C
         AO/bTiasUo8oqtNzw3CcXQkf04f4x2BgMcC4vKnqzwpq+FqwFzn5C8Vw5Fkv2t0Ygpku
         sIC02bA4blTnaJlQBkpyCgXSVsgNUhn1gjXGNE9bX8Z9Ipo2D86vafFYPlq+hWMJHZ5Y
         04+xCKjZzquShJ+Cau/qqxYre/aDW0dNkm1wq+I/gLAgvpGU7TRmnCtdgFYzm4ba2yn0
         C8tA==
X-Forwarded-Encrypted: i=1; AJvYcCXlhgZKyHpDM6aakTfN2Q2erUcdZKoIn0+hy5b7JWCQYerHySHbZBoXbvp8HmF8Cck6W2p4q5wLNWRSCmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAucvoFiIMGPTDPYYS/6Cc3g6yqcPNkxLh6D8lNm6FCaO93oqm
	1T/D+A72Jpkj9orJalztI9APlcz5n+Ve1GO3lUIbA3M0kK7nu+9FrxwvfWY5ebRpyIJZKUdi+Zv
	NvpCPw29KjZeDcmUBRE3kLKyJikr9NChm0uh65c1ueGFOBm+yaiBDMiSj1PoEiQ==
X-Gm-Gg: ASbGncsuqLFd7L2lm5LXhr0k947Yc3AfL5Bx+a61UT94Dq8Ut+Rr3OT4/1BBntkJ/0m
	9BY0FtM5y4Yr+x22fshjCsiHSP8ak+ul2It58PInRUbidEQ/6aUfjzu9LHRtjdSr+7j++AeMJK5
	cvXuPwyxn9WzDm+NkxS+Hzd/pSX3e/aeM3frq7Ic1Q1fpiY/i94jHV22dqPTmDMGq5smoEFXnbo
	a1qKp6xwZV6priFMelPal4eygupjK2U1TZTccn+4lMW5NZFG+xmFOtAZvd8e2cutssIQYMfILNF
	hOLr/DRiOUVThd5sMKtVACcAe2K4SXBPQJBYVIedjokO/zIm
X-Received: by 2002:a05:622a:13cb:b0:471:fa92:9239 with SMTP id d75a77b69052e-471fa929817mr150698631cf.35.1740061344901;
        Thu, 20 Feb 2025 06:22:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHcKCnyjKgYMKC7pmhTIxMT9x10jSRgTftOyocqc0ie8YVpDcc0KW4B/4fFt77IpT4ToCA2g==
X-Received: by 2002:a05:622a:13cb:b0:471:fa92:9239 with SMTP id d75a77b69052e-471fa929817mr150698401cf.35.1740061344576;
        Thu, 20 Feb 2025 06:22:24 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a3c20sm86544956d6.53.2025.02.20.06.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 06:22:23 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <edd2d160-e1ca-4d2e-be92-cb033d3b791f@redhat.com>
Date: Thu, 20 Feb 2025 09:22:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hung_task: Dump the blocking task stacktrace
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Waiman Long <llong@redhat.com>
Cc: Lance Yang <ioworker0@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Boqun Feng
 <boqun.feng@gmail.com>, Joel Granados <joel.granados@kernel.org>,
 Anna Schumaker <anna.schumaker@oracle.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Yongliang Gao <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>,
 Tomasz Figa <tfiga@chromium.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
 <CAK1f24knkxX34hNLRjT20mjyyOwasmXgXJBbTDX=7WYwiw9S1g@mail.gmail.com>
 <CAK1f24m-Ci3BvgfVYGW2tFSUEkPwiO9=0M_w4kpOt1qViiDXdg@mail.gmail.com>
 <8ca57548-4b18-401d-bfda-95bc12216adf@redhat.com>
 <20250220231857.6e377e5f208b60a7ba303cea@kernel.org>
Content-Language: en-US
In-Reply-To: <20250220231857.6e377e5f208b60a7ba303cea@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/20/25 9:18 AM, Masami Hiramatsu (Google) wrote:
> On Wed, 19 Feb 2025 15:20:39 -0500
> Waiman Long <llong@redhat.com> wrote:
>
>> On 2/19/25 10:02 AM, Lance Yang wrote:
>>> On Wed, Feb 19, 2025 at 9:33 PM Lance Yang <ioworker0@gmail.com> wrote:
>>>> CC linux-mm
>>>>
>>>> On Wed, Feb 19, 2025 at 9:00 PM Masami Hiramatsu (Google)
>>>> <mhiramat@kernel.org> wrote:
>>>>> Hi,
>>>>>
>>>>> The hung_task detector is very useful for detecting the lockup.
>>>>> However, since it only dumps the blocked (uninterruptible sleep)
>>>>> processes, it is not enough to identify the root cause of that
>>>>> lockup.
>>>>>
>>>>> For example, if a process holds a mutex and sleep an event in
>>>>> interruptible state long time, the other processes will wait on
>>>>> the mutex in uninterruptible state. In this case, the waiter
>>>>> processes are dumped, but the blocker process is not shown
>>>>> because it is sleep in interruptible state.
>>> Cool! I just ran into something similar today, but with rwsem. In that
>>> case, the blocked process was locked up, and we could not identify
>>> the root cause either ;(
>> Once this patch series is settled down, we can extend rwsem to provide
>> similar feature.
> While discussing about rwsem with Sergey, he pointed that we can not
> identify a single blocker on rwsem, because several readers can block
> several writers. In this case, we need to dump all of them but we
> don't have such info.
>
> So anyway, I would like to start from mutex, which is the simplest one.
> For the other locks, we will discuss later. (or start with limited
> support, like showing only rwsem::owner)

Yes, reader tracking is a problem as the rw_semaphore structure doesn't 
store information about the reader-owners as the count can vary. That is 
a limitation that we have to live with.

Cheers,
Longman


