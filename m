Return-Path: <linux-kernel+bounces-522860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A54A3CF52
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB263B8B21
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921E61CB332;
	Thu, 20 Feb 2025 02:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PK6QRJH/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C10846C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740018368; cv=none; b=WzCzloT3Rt9td4ymeGPMJOf0QJCIGvVpI1R3fV77Z2q5pGJAsNj3k1xs/QnF4/WjeM/OsctrLERxce/cmKz1J5w3cbkUUVfjLe3GOgaMAyqI0Ayt7hZ0tG32EKM+jgrEYZdNiOZzFTCIZgk6zKM51TvUJyAOrsswRtRm0THBe2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740018368; c=relaxed/simple;
	bh=Kgl0I9qKxaohQJluNJTYElPUPS/VmBURETL7PeaL62E=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cHuX4jK8KIRwp87aNpfPopnlVYUlBcrAtbxiv8T3j7K7zjtxBhN9oc3og8RIdp1n9meWk/BE1fekK28eTjT6Te3UPbkbBYywcXYTdOiL8o8oCu2kfF6zupaU8G32wrSXT81+Yn77dav8ibLGV5DXFwVI5cl9G561KSZzVNHIWkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PK6QRJH/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740018363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tz6TwNHIIl1eKIpDBxUFJaXjCys92nDICCxDwSUHx3E=;
	b=PK6QRJH/OyOoQGQuDbXWlDkK8KxutxkgPcpUfA0lpkvsOCwoZe7adqZ26braMo5lTawLTN
	brVrgT5JRbhpo/bswdhmDNXLtBhg3gRrZbM5HPuQmlbXNxiAjB9ukb5/AtD5I/K9SYKOW8
	1XT59XC7IatiQqfyi+1LY0bhxX3Btb0=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-nKERzEIqOueNAkLGzBtI8w-1; Wed, 19 Feb 2025 21:26:02 -0500
X-MC-Unique: nKERzEIqOueNAkLGzBtI8w-1
X-Mimecast-MFC-AGG-ID: nKERzEIqOueNAkLGzBtI8w_1740018361
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3f411884e5bso156590b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740018361; x=1740623161;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tz6TwNHIIl1eKIpDBxUFJaXjCys92nDICCxDwSUHx3E=;
        b=ogXPrBmmcBPJCAWwpfgb42AFunzm+a7POLOObNeDFm0ICpGjGQbxrIMK74e7FYPhV4
         CakC3DIyGqV5dJoXVdnaAq2JIRoiOAJDSvfNfyFRgDsmUS4oWAkduL2Dx80yLk4kxj4y
         Mv5g9enX4s6k9+NwSi2SdVHZ3CDpsej1IPbv79ApawAxLUztWyetS2MYj12Xb6vPvh1h
         z7ESbFi+fgFFsTz2LPNqlJmSVqfQWx+0iiV5GC29f2O5Yc2QPNfWiDXrQAVT1xyc3nCU
         1z2LhZXmkMTSTMcqvlyCi5H6RlsBK0pMgY7RSJipdP9Tn4HT+0agRgxs7APvkiNj1Odg
         oG7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDr//3u5SpfdNGFG+IOkGn3qEu1FGppOegKkoBfmNMxOMm6d8zrAH6l91L8iiBUfwTHlZVGyj64+HarCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIMXv4hYxQAZ8BXUsTAXoKETcy6Hd0E6ESq9tiVm2+JwfbHnWs
	vCMUGZ5jq7F3pi/LzmD3XGjhacHFXI/8yVD738qzkQnmnoWDEdJYUa7P7k3gWkEsY0VjiaVBEvC
	EV6ScHJmdplYbs8suDPgF9o4xFAiKJEJtcu8y8LA6QLdJ3H6R5f53dqBd3DKQXQ==
X-Gm-Gg: ASbGncsGsVVKHrVvW41VqhlqCx2RtWFM/SuVfd07duPY82RJsMz3ak6y1PQf/Ad3WYJ
	Xl6YXWa2nk8gm0Kp2g7W+maqV9XkesMASQ5OPwYAhnCn0bMr88uTu+6LxJq2e8qziOJ37Jyrh0A
	QYJEfkZgysvK68dOSYHqk08Q75OblP0yJnfByoUfZg1HtTG9ydjr4+6QV0x/GPvs801AdAS9Uza
	txA6Xz4n+7pWORE2nxjNWvJ3oayrBK55cDEyHIK1cbpmbdwTCJ5xPUgb8riJrfZyhlUc3NNbUVk
	WqU3yfMGaGXrWYa0bl7MgAb+aWg1pKMtyinroari6DMYGSP9
X-Received: by 2002:a05:6830:7101:b0:727:ccd:4a80 with SMTP id 46e09a7af769-72712037a98mr15179430a34.3.1740018361454;
        Wed, 19 Feb 2025 18:26:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+1pTLV2juz3XWnrP6l8YrlhAGKreyIq4mE3Rwt2QTzHiDJTVBAxIgpErDaTCZyIH4jq56VQ==
X-Received: by 2002:a05:6830:7101:b0:727:ccd:4a80 with SMTP id 46e09a7af769-72712037a98mr15179412a34.3.1740018361182;
        Wed, 19 Feb 2025 18:26:01 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7272e96bc2csm1720420a34.54.2025.02.19.18.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 18:26:00 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <92c9b82b-2873-47af-a4ff-7e2f95f227d6@redhat.com>
Date: Wed, 19 Feb 2025 21:25:58 -0500
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
 Steven Rostedt <rostedt@goodmis.org>
Cc: Waiman Long <llong@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Boqun Feng
 <boqun.feng@gmail.com>, Joel Granados <joel.granados@kernel.org>,
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
 <20250220080908.fc1494f0f7c611b48fbe0f8b@kernel.org>
 <20250219185810.57561c69@gandalf.local.home>
 <20250220110800.42ce6b1b8e94a3b998d533a5@kernel.org>
Content-Language: en-US
In-Reply-To: <20250220110800.42ce6b1b8e94a3b998d533a5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 9:08 PM, Masami Hiramatsu (Google) wrote:
> On Wed, 19 Feb 2025 18:58:10 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> On Thu, 20 Feb 2025 08:09:08 +0900
>> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>>
>>> So something like this?
>>>
>>> unsigned int	block_flags;
>>> union {
>>> 	struct mutex	*mutex;
>>> 	struct rwsem	+rwsem;
>>> 	struct rtmutex	*rtmutex;
>>> } blocked_on;
>>>
>>> enum {
>>> 	BLOCKED_ON_MUTEX;
>>> 	BLOCKED_ON_RWSEM;
>>> 	BLOCKED_ON_RTMUTEX;
>>> 	BLOCKED_ON_IO;
>>> } block_reason;
>>>
>>> For the safety, we may anyway lock the task anyway, but that is the
>>> same as stacktrace.
>> Why not make it into a single entity?
>>
>> struct blocked_on {
>> 	unsigned int	flags;
>> 	union {
>> 		struct mutex	*mutex;
>> 		struct rwsem	*rwsem;
>> 		struct rtmutex	*rtmutex;
>> 	} blocked_on;
>> };
> Yes, and we also merge current mutex_waiter too.

I don't think we should merge mutex_waiter as it contains additional 
fields that are not useful to others. We don't want enlarge the size of 
task_struct unnecessarily.

Cheers,
Longman



