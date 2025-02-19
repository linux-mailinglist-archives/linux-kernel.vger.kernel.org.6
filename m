Return-Path: <linux-kernel+bounces-522391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E477FA3C989
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B3B1660B7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0633722DFF3;
	Wed, 19 Feb 2025 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9a6D7Uq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87E0211291
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996448; cv=none; b=apwEd5Q2R7jtDr/PXKttONpSrbY59Ako9iwwKRp0xQLSVvhUv1z4ZEAEy2VeqY+xOsdWvdcWSeP/2RTygM85Xyt5nCSQDys22KMrnDEYsklTLFkRPCR1MAwQpiww4mBwHzAMlVEBXOQz2YvCaD6FzXzEU4vqSHwLyFR2nwOA8z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996448; c=relaxed/simple;
	bh=ygbIrb1kmuPASL99Lj6Ag7c41897c0GbMeyTzSauQQY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZcP0BEKJ4gHwnouOzwLNdyizjgcW7WFYxQ9ZzgI6Em7VgslcgzKwHNIZ3W87ytoon4nA5BOu+eZ6cz3+z4lQtLLVzQ3Wg8adfMAzJU/GjvQGRk1xzCLdwQG/ebP2QsR0/KmmkmAtzbftqXbBGpTNjAWNye1wX4hNq2nolhhthj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b9a6D7Uq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739996445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m56pAf3/12TQHH7eDD4tbpCjv5t0oQOoxHOFLr4f6XE=;
	b=b9a6D7UqRouDF4mcVirOBW9q0QUfattgmOReKGsIiWm1cXNTneWFwF6ebNNkk0b9sT13O5
	R0ymjiG3y+VpqS6+vKF7XO3MFFIs6YORZ8Q4VJkFiDKfpu7xJMCTjL6ivt1cSDdf7S8Fs1
	shFvL7potE+gvml96uzFHhx4YNrYxk8=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-oXMtMI1hMOiK1j6B5l87eQ-1; Wed, 19 Feb 2025 15:20:42 -0500
X-MC-Unique: oXMtMI1hMOiK1j6B5l87eQ-1
X-Mimecast-MFC-AGG-ID: oXMtMI1hMOiK1j6B5l87eQ_1739996442
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-2b1aa0c87daso42966fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:20:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739996442; x=1740601242;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m56pAf3/12TQHH7eDD4tbpCjv5t0oQOoxHOFLr4f6XE=;
        b=ZRAQE8Izhu++fZy1xG9/8Z9ZIWxkV/PssE3Psyh2hBBSMqlwcHsIxa4+iQ31FW8KrZ
         2jFRFvtIh2kc3qOCxTZrM1fJeruNcNdioWi+i2iRfy4eHkQIRR+IBoQB1oh3KZ1YjkC5
         PhM72FwkhqmGxvWiyuxPgvLsI7qlsqGXsm8tSJV3/fWTiafRSt0qb7jPjiTj3oRdj70t
         gvPoelszHrLy1MOqe9N0rrpD/YpAN+3w/AUUwQhCbBPhllKWtwsUM25dNAHYos9cFFQL
         B8HOtUwyHmy716Wo8Is/U0qfxwn/SUlxH2YmtYyZ8g2BSxCsEH5LkzrN1Zv241ZyAnVa
         TBIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWtoJZGIVt/BUuGNq4KMcqMlKO+LwFjNHSmPAnzE52FjzSNlb20ybIBGU8+bqTsgmRF4Zj3brsadQRA3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx49VxCzCrmBwWkxX0EimcqmoGjIXPyVqo7qPa5CFy3Tr1+EgcQ
	Nu2R73PjezDj/TYuwHNo+FRQ11I2RdwrLG3VVAXQKVOdVRflCdAMhnC8Dwelm6ELkWow5WCKlTj
	lcWQ9bcu7hnqdXec+Turt93L4ikIHljE3unUQjXKc9ux39/kN64Zhe1TkVLnSXA==
X-Gm-Gg: ASbGncv+YdBwjAUIaeUQtfgZJeznhdYNSfumTnXLc2Xzm8lhSIBJCutUPv82NBHQso9
	/kXSzJigBK1DET9cwbtASJOBy0tRFtvPSg/8VScWA1xVQGK5ORwpSTatbBSI+MICL4T1MqjJFZk
	Fil5gQFhTdlRq6dhyrqr+OVa6B4gc9vcs4bPjEOQs9+KgRnCXt1BB+LiAmM9nQc+9wbuDd1qNYP
	uRxrSqzopF9fcaVAewb6bTb5UJBJ2tZhUxJx3reOf1EdpQRJC7beMyPOZY0JDVRw95Csbn7WgL9
	4GSL2ZJlLG+hdnfftHxJ/TH/DBw+NuKibD5nHK/1qkosjH3G
X-Received: by 2002:a05:6870:4d09:b0:29e:719b:7837 with SMTP id 586e51a60fabf-2bc99aaf44dmr12652944fac.13.1739996441783;
        Wed, 19 Feb 2025 12:20:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOdcXnpAP5VT98wQduj8iHZ9g14YA5f3YWOv7XwDN3ex16h3ex15yOmypTd3pGd+9sLBFq3Q==
X-Received: by 2002:a05:6870:4d09:b0:29e:719b:7837 with SMTP id 586e51a60fabf-2bc99aaf44dmr12652925fac.13.1739996441517;
        Wed, 19 Feb 2025 12:20:41 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2bd1d8fb86dsm525430fac.4.2025.02.19.12.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 12:20:40 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8ca57548-4b18-401d-bfda-95bc12216adf@redhat.com>
Date: Wed, 19 Feb 2025 15:20:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hung_task: Dump the blocking task stacktrace
To: Lance Yang <ioworker0@gmail.com>, mhiramat@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, Joel Granados <joel.granados@kernel.org>,
 Anna Schumaker <anna.schumaker@oracle.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Yongliang Gao <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>,
 Tomasz Figa <tfiga@chromium.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
 <CAK1f24knkxX34hNLRjT20mjyyOwasmXgXJBbTDX=7WYwiw9S1g@mail.gmail.com>
 <CAK1f24m-Ci3BvgfVYGW2tFSUEkPwiO9=0M_w4kpOt1qViiDXdg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAK1f24m-Ci3BvgfVYGW2tFSUEkPwiO9=0M_w4kpOt1qViiDXdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/19/25 10:02 AM, Lance Yang wrote:
> On Wed, Feb 19, 2025 at 9:33 PM Lance Yang <ioworker0@gmail.com> wrote:
>> CC linux-mm
>>
>> On Wed, Feb 19, 2025 at 9:00 PM Masami Hiramatsu (Google)
>> <mhiramat@kernel.org> wrote:
>>> Hi,
>>>
>>> The hung_task detector is very useful for detecting the lockup.
>>> However, since it only dumps the blocked (uninterruptible sleep)
>>> processes, it is not enough to identify the root cause of that
>>> lockup.
>>>
>>> For example, if a process holds a mutex and sleep an event in
>>> interruptible state long time, the other processes will wait on
>>> the mutex in uninterruptible state. In this case, the waiter
>>> processes are dumped, but the blocker process is not shown
>>> because it is sleep in interruptible state.
> Cool! I just ran into something similar today, but with rwsem. In that
> case, the blocked process was locked up, and we could not identify
> the root cause either ;(

Once this patch series is settled down, we can extend rwsem to provide 
similar feature.

Cheers,
Longman


