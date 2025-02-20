Return-Path: <linux-kernel+bounces-523771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF41FA3DB0A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CCC3B8CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8661A1F8670;
	Thu, 20 Feb 2025 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dinCZ/DN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C79B3C3C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057218; cv=none; b=mfNtbzxGJVq3vPRqt7UzSs4Z7X0+mUbgRAJneceneV7hSQ9sZXzj11pU0S87Qo1T7PovMGde6Yf55pbwGeazdZUqs0MSRe/ETR9qulS91xdFhM9uWdqBVqemb0iwZFQuw/MYedMizCEGSeJjFwlx07uPulFX7hwde/nLuoYzdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057218; c=relaxed/simple;
	bh=6pqby0QmGSRbZZAyan/T4KEF3pkd0eamtLEQbHarphY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D8ejKWdbysraT48GXiysANPB7zHKX1Bv/qGRAFUnv1wjp0bsuTMtq/WnePW7+lgD9xl3QYTd7ut8pAV9F1k15DkUdZqoc8ZWF7CQYtBfVe0j1GzqNps7l/WsQQSUwJ9kbagXpYte1r4PZeEvXmkqHikiMssWJ92vaVB4C85vsKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dinCZ/DN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740057216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRwMu7e0ceR1Dgr7qaos9+En2kyirds7dYdEYKFuAug=;
	b=dinCZ/DNoZOwMhqdj397N63/EtptU8sIBLAi79ZAyAmYpdjxmy33B4el7FobMrBSLNBdOG
	PXj2zEScq+U4kRNSmfwUBGU4qDMiwj7Nwq/6/vHSFfQlkcoPkYAY9Y95o/UN7GVJQYjKeW
	B5D4qt3+gYnT2oYHGuKmScoqY5f5eHo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-bIWuTXKRN_erHH8eu441Eg-1; Thu, 20 Feb 2025 08:13:34 -0500
X-MC-Unique: bIWuTXKRN_erHH8eu441Eg-1
X-Mimecast-MFC-AGG-ID: bIWuTXKRN_erHH8eu441Eg_1740057214
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-472012f2edfso15532061cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740057214; x=1740662014;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRwMu7e0ceR1Dgr7qaos9+En2kyirds7dYdEYKFuAug=;
        b=DDPo8d9HwwleMw7c2Iejd3DpbmDNm374Z01ES53NjQQ0glI3Aw4ftZ6OnYNcgVBp4g
         xsSrHRVzOKYN68cSvjmW4xDSpdXRJ0DXPkLnGKq7MeLFnDTMlWKKBlWvTZhlUxBZu9Fz
         L2f9Yz4uuQXyCWmnYNJkmFRaXe5BdnW+AM5aarzavbCalqJvDsSmbaaHo5xSpGjl+WyI
         +OwVIeb16IksrQ2/3H61Kk16OT1RTUnRplFDhUnDmsaVn+E7Y4gfCNIQA6d+3/p7fhQX
         LfucXs7jxwARDXV/sH+PGXgOvXvHzdLca4QYAw6TdxewEp3tKBRxFS/Um7PAH11GXi9J
         Az1A==
X-Forwarded-Encrypted: i=1; AJvYcCVCSObmysbhpzmEZNU/frc9xJBrlXtpQM9dOVYfwVV98B8nQsfTi9A2UwXUMXS0fcuW9m3rEYtPWeOdDY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTWJfac/qdnXsk0Au+JLbl0tT0z1CNybfvXLgf3naURTlIl0Aj
	+IPiQkpiKu0VO6ce3E7JbOYM0tQUM8DQ1kei7VMECDkfXeStCT7jGjyZBuW8X3VXOza9ZKaaTQe
	QQjf+DDRnkLe0rcUiKqDfaev1tVaeLiVfewWvesQIhE00JbdEy91P46hjtbKfjA==
X-Gm-Gg: ASbGncvpp2BDQPf+1Ej8RwET8chCvlUTPoZXA3Qd595e/28KgFGUtWcBGyGDlFu2lbM
	0hltIbr1o/ivU3ZvnN0TbsERBUz6umXg7hSgnzpCmCR7w+U3DVipPlXSECkiyCuYPENbLgF+heo
	vqYaZERiwNSyDxbgNHEMnXxmWMBdCDTjq+6otDuA+/e/w9nA+5QSU6B3/w5sLi6S29ktd6NndE4
	qO7g1rVA4x7+waa4NsI0CbbAVMkES77XxG3OqaRONpWsygkq6+iNjH5a0jNKhgJ8x1Rz/ArHvGz
	Nvsf9K278YL7GlaWiElkKHyTiKaadcowomcChc8V3sp837Eu
X-Received: by 2002:ac8:5f96:0:b0:471:c78d:8d84 with SMTP id d75a77b69052e-472082d520emr103517551cf.43.1740057214427;
        Thu, 20 Feb 2025 05:13:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGD+qphUNuAPQf2oT13JuhFqAIdVj2mI/geMANnLSv7BrPqLTILeTL4glZCJoafX/ZnUZWiPQ==
X-Received: by 2002:ac8:5f96:0:b0:471:c78d:8d84 with SMTP id d75a77b69052e-472082d520emr103516631cf.43.1740057213554;
        Thu, 20 Feb 2025 05:13:33 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-472056e87c6sm24826551cf.12.2025.02.20.05.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 05:13:32 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3c09df17-79b2-40d4-a560-f6b1ddbbb73e@redhat.com>
Date: Thu, 20 Feb 2025 08:13:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is hung
 on mutex
To: Steven Rostedt <rostedt@goodmis.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
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
 <d8c01f69-34c0-45cf-a532-83544a3a3efd@redhat.com>
 <20250219204153.65ed1f5e@gandalf.local.home>
 <20250220114036.e22e388402a00f7809a81dee@kernel.org>
 <20250219221141.09f9fe48@gandalf.local.home>
Content-Language: en-US
In-Reply-To: <20250219221141.09f9fe48@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/19/25 10:11 PM, Steven Rostedt wrote:
> On Thu, 20 Feb 2025 11:40:36 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
>> Hmm, right.
>> Since the blocked_on must be NULL before setting flag, if we can ensure
>> the writing order so that blocked_flags is always updated before
>> blocked_on, may it be safe?
>>
>> Or, (this may introduce more memory overhead) don't use union but
>> use different blocked_on_mutex, blocked_on_rwsem, etc.
>>
>> Another idea is to make the owner offset same, like introducing
>>
>> struct common_lock {
>> 	atomic_long_t owner;
>> };
>>
>> But the problem is that rt_mutex does not use atomic for storing
>> the owner. (we can make it atomic using wrapper)
> Either that, or add to the task_struct:
>
> 	struct mutex	*blocked_on_mutex;
> 	struct rwsem	*blocked_on_rwsem;
> 	struct rtlock	*blocked_on_rtlock;
>
> And just have each type assign to its own type. Then you only need to look
> at each one. But yeah, this adds even more bloat to task_struct.
>
>    :-/

Another alternative is to encode the locking type into the lowest 2 bits 
of the address and combined them into a single atomic_long_t data item. 
Of course, we can only support 4 different types with this scheme.

Cheers,
Longman

>
> -- Steve
>


