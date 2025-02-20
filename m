Return-Path: <linux-kernel+bounces-522856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF9DA3CF4B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88233175083
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A885E149DFA;
	Thu, 20 Feb 2025 02:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UA7O4m7n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81606EEB1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740018099; cv=none; b=FtQ2hWM8FX1yLiA/mkoKrt8CcvIjEqL19ifnBCqxavQK0OyoT+QN1jETqTyZfgn19UZXuC+q7MBebEkx3KqYnvg9vAp6QaoNO+37lpqg0+keEKSEoocAYLD2vXsvrv7mOIQkvnVpOkKWgSmHK7KFKwU+NnQsnBbJcEmgUUw60ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740018099; c=relaxed/simple;
	bh=EwekpqeJx1HAlQ2dBHVmHCJjQ82SII9oLA1iHNo0ef0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HcuV7esm6/YH+rUgVYJhGV0KVy/2N9DEASNCoPVwkZ960TiiWIft1KZVrFzr1f7AHW5juf12Urlv+W+RqdPRKKE9mw3QQ6/GZmS+hSoB6bubnYK5xjqgJiSdWvLg9Gdh6n8OxYPORk8vwTc7MxS85I0VC1XAtlbC9jfz5YaExDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UA7O4m7n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740018096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FHybRSR5i1eGg5nmMYpSKjOvhPedwv4PiwOpMMgXN44=;
	b=UA7O4m7nZCACmDYOsULhD0vbg3N7coJdL1uhZNfsI2O62aiz1wKRrNgi3OtDponzFN1b1L
	hY82eQNSTcoyTP6StwEVa/a/UgYVY+ieFTDoTHcb3qsFE8GEvPPCt9AHeoIfqcFnx4bNMv
	IHVLZDdG4TwgXX1Jz6f1F7rMS4ag43I=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-MPv73avtN_u_Vml6TwThKA-1; Wed, 19 Feb 2025 21:21:35 -0500
X-MC-Unique: MPv73avtN_u_Vml6TwThKA-1
X-Mimecast-MFC-AGG-ID: MPv73avtN_u_Vml6TwThKA_1740018094
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3f404c95049so544140b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:21:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740018094; x=1740622894;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHybRSR5i1eGg5nmMYpSKjOvhPedwv4PiwOpMMgXN44=;
        b=oqhcEEGVGwQyLzCb59WFuUJvlWZzTKoLWyGm5T8Zgrmyasqb185my5skQ0xUiLJo1s
         tQFSVJ9YnIBiUtqBp+74Fj5e/KLFgQ8whcGsBKy9PGZhQdMsKV4OdVosh3Q+IICsiS6M
         2yxwGd4sj0tpwpSxTfRmt4IJc0x+2391Iy2aRsaacYyq/UbNBK//h1uammHQPk91GbYF
         6otD5qygt9MWUjZb9Fpn4RQs3Da3kI0XMHbnbFfh88WYxi21IYPmm9if3bc4olyIfSYr
         886Iu4t4JUVaGwNRT8UsPCj+sOfZ7m1X3Un5O+8+5tWFm3H2KDVmQtxtfJjHlmc9XDC9
         PblA==
X-Forwarded-Encrypted: i=1; AJvYcCV68d6c9FCKDJYnP9Ttpx/AZUahoPmlJ3ps2uSLFADRL+grWVdGtYOVaMVJ6A2NrdPhnRi0SkNHE6xlVug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza8eymg0JQxjegppzqZo12GcFNHawpJBu7MSWq32hUYwgZUakx
	wHCU32Lg6WM0DqUy1tPZBsg1Sd7GIQUvxCt7VrhyPT+SqyajlchsZ+rXseM+IV3NLxgNXWUzNgQ
	4Wu/5K8d47NIqf4J8cXC8gZ6MIa1btVClWNQPxFiBlUrfxLXA9A93fBX8IenIKw==
X-Gm-Gg: ASbGncvTyEp8WEyEEfRJXuJ8Vjp4PPOLA/seOt6jOWeVXjXcY8lXGH/C+wj4wDS8luH
	Q8A9x/0XE2c4rGg5oNiQccw34PwskKXd7bPdP3cSyYcQsMQTIGhbbcJSuF/PwMLMPwdxQ3fRHS8
	/4H4FGwxUg8uCWWTHHW82ge/rWpmNLnyL8QNPFwCaojarJzCTdoe9QcW/n70RFmY1aCnZNfIotz
	/0SC3hIDWcjvwt/rMqsTkeCLD1LUypLZGhg0SJoH/Kpz9DKRoqwqvjm/JEK4AevJIXAJl/ZwDA0
	W2fiHNa1jSjAVB1fprHZlALLhtL3zntIlySX2NbS6eh/Rl7+
X-Received: by 2002:a05:6808:3509:b0:3f3:e683:2f65 with SMTP id 5614622812f47-3f41b8e7f6cmr605510b6e.23.1740018094347;
        Wed, 19 Feb 2025 18:21:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9DyLuyMsEb1qp9kxU1c9rXXAS2qcMyZkDdBLplMkq/Vx3N+Mav/Gxp/nM/ZaOcNuJ2iIODQ==
X-Received: by 2002:a05:6808:3509:b0:3f3:e683:2f65 with SMTP id 5614622812f47-3f41b8e7f6cmr605494b6e.23.1740018093970;
        Wed, 19 Feb 2025 18:21:33 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fce96898aesm1741888eaf.26.2025.02.19.18.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 18:21:33 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0948872d-06cf-45da-81d0-397197fdbc67@redhat.com>
Date: Wed, 19 Feb 2025 21:21:31 -0500
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
 <db4ee5e9-56bb-408c-85e7-f93e2c3226dc@redhat.com>
 <20250220075639.298616eb494248d390417977@kernel.org>
 <20250219185531.1140c3c4@gandalf.local.home>
 <20250220110707.a314d394ccf68575047e75cb@kernel.org>
Content-Language: en-US
In-Reply-To: <20250220110707.a314d394ccf68575047e75cb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 9:07 PM, Masami Hiramatsu (Google) wrote:
> On Wed, 19 Feb 2025 18:55:31 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> On Thu, 20 Feb 2025 07:56:39 +0900
>> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>>
>>>>>> this field, we don't need to take lock, though taking the wait_lock may
>>>>>> still be needed to examine other information inside the mutex.
>>> Do we need to take it just for accessing owner, which is in an atomic?
>> Updating the task_struct would be in the same location as the blocked_on is
>> anyway. I would make it into a wrapper function that is a nop when disabled.
> Should we make it depends on DEBUG_MUTEXES too? I think no. We can introduce
> a different kconfig and wrapper function which calls debug_mutex_*().

No, I don't think so. In fact, the mutex debug code can make use of the 
new fields for additional checking. I believe DEBUG_MUTEXES should 
select the new option.

Cheers,
Longman



