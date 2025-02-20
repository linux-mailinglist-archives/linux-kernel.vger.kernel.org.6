Return-Path: <linux-kernel+bounces-522854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3F5A3CF47
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04BD16CD28
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA491C5D7E;
	Thu, 20 Feb 2025 02:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7+jY41a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F21194141
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740017718; cv=none; b=k+hqRqKOdPb11mzdoRS0rIh65vdnHsxW/Mrc90SKbwWhvJcNZsa/FYiFstxk+FAJGmED5RfV2WLTczVf+eHzpXxo4c53TLmXTdxGtBzPumVbDlmvi3mRvH2VW2wm913EN0BdocMCX/PSuNhKievHMpesDJOBjm8SKzcRMT52qNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740017718; c=relaxed/simple;
	bh=2c9tYn7eP1R9rrXiS11Y5Ntlx9iLIm2YEjhLlVNWmHI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=U6s6cQudkwuWD40W3TDgyDgdQedXewSTG7Dzm90Hes8MCGJDJydH6VNZIgta24kJvIUHeXEF604CybZ7Q+yvtpBAtBvh2APC3XUyid7CiPrgldHEIlhd+gMzwU4A88knX5JhKs3HsYzIh3O2VSGdIuTusUFaIDQ86xkxvvGI7zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O7+jY41a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740017714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wu5Vn28p7MixYC+/9v+4ssvT0nmU9JWyu/14w9WYEg0=;
	b=O7+jY41a8+KHzeX6l3WmCPsuVZa/qaTtzKCH0ajy1MDO90LXNy02IvIi2tDfjOea7XQpSi
	XWjc6vyCKpCojiBTQj5av0NulaCWz6IIqt3Q1qMMf1eij1IsnOQTtzyUtmD9v9bebcPEyM
	mTfotu5JBTx8ykQsW2+tl+ToWSn60UU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-cPFFaHvZOw-sOVqf1ssLAQ-1; Wed, 19 Feb 2025 21:15:12 -0500
X-MC-Unique: cPFFaHvZOw-sOVqf1ssLAQ-1
X-Mimecast-MFC-AGG-ID: cPFFaHvZOw-sOVqf1ssLAQ_1740017711
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3f414d029c9so193378b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:15:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740017711; x=1740622511;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wu5Vn28p7MixYC+/9v+4ssvT0nmU9JWyu/14w9WYEg0=;
        b=jCHM7SR45j0CW5HsUwD+1zdVUDz8AjTk8BZ0BwtudbF30DniSUYjs0+xrToff68CXO
         tFL5xp0tvs/PS3E1Rf0LBoHNUzJpRV4u6MG6xOQZWmuF1Qr+/DxKPnrR3HgDCbF2PMnm
         KDXGfjvf9dHApUhL6etak0MbRk3d0qw/VsoFVa3ekrIutdGtT7qbJgwU5g2xGcHckczQ
         o29coq2grtQ+DyrfVCk3vuK8kyyBxkEPbFqarJBhAmjtfLOlOQz22nuB3JeT3Y9qMQ1A
         egbZbpTojdFZIGgDNVUd4W52fOkP6Gf5prANO2VrQklezBzoZD7ebs1SGzAKNTmCzF/4
         AGDw==
X-Forwarded-Encrypted: i=1; AJvYcCUf3sSSKYfj5n1UMwVw20JM+HksGhA/t18uvfVDNXXhJ+zJv01VIq/Y5VPXsx0hsX7VDi9Kxc848+FlMps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2+keVaik1zpYcz2j8o7Pv9SHnZ0aaJ8Bqiuwb0P3ccRp2qLLp
	xLR3gfUDZRwZSWSh2ioysJIBgs+afonwa5HFsZIkbxOxMuhv6BfyVx0OQ3uQwZyow71a5AK/lXs
	z5G9vv9rRcr6JZ0OaZOlxwAm3doMNXDHIhfu7sHvUMooG/m+pE+Y3OaM/YOy7Og==
X-Gm-Gg: ASbGnctiL6OiXgJ77UhsktuAKxrGOxicBY5ua4zBXDTlFZwtf11DvaJVPu4kAWDCZpd
	0UxZWwz41mavMnV9W98Z8LCaUFRLdApZUGvy3GafHPEBObm2WxZDicM5nkpvrV1U0RytwZYvbyh
	PU2YA+1LguItPjfgbeBx42X7FtARwS5Pj2KI9QWgcNpFvz0AQDrn4apysK3V4g2Hlf2Ums0fbSq
	QbGiR5aG6QW2RQdC+Usi/r4WLB0D7O2z5kogsrdkfrEsrrSOec8f30WZooijMQ6Qa55992jDDYE
	VOwqmjdjTQt6hL9lHU3u851iIyXlGqLVeC7h50cScHbLk96e
X-Received: by 2002:a05:6830:6117:b0:727:3f3e:53ba with SMTP id 46e09a7af769-7273f3e5497mr2806113a34.26.1740017711530;
        Wed, 19 Feb 2025 18:15:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW68eP8r/6kxUFYP+2oduO7DOaqKrtuTM1aeIejvCopjqxsLRzJQJhvDewuc0CLFu7yEtrXw==
X-Received: by 2002:a05:6830:6117:b0:727:3f3e:53ba with SMTP id 46e09a7af769-7273f3e5497mr2806093a34.26.1740017711226;
        Wed, 19 Feb 2025 18:15:11 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7273a14070esm720434a34.49.2025.02.19.18.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 18:15:10 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9f9150b4-1cf5-4380-b431-419f70775a7d@redhat.com>
Date: Wed, 19 Feb 2025 21:15:08 -0500
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
Content-Language: en-US
In-Reply-To: <20250219204153.65ed1f5e@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/19/25 8:41 PM, Steven Rostedt wrote:
> On Wed, 19 Feb 2025 20:36:13 -0500
> Waiman Long <llong@redhat.com> wrote:
>
>   
>>>>>> this field, we don't need to take lock, though taking the wait_lock may
>>>>>> still be needed to examine other information inside the mutex.
>>> Do we need to take it just for accessing owner, which is in an atomic?
>> Right. I forgot it is an atomic_long_t. In that case, no lock should be
>> needed.
> Now if we have a two fields to read:
>
> 	block_flags (for the type of lock) and blocked_on (for the lock)
>
> We need a way to synchronize the two. What happens if we read the type, and
> the task wakes up and and then blocks on a different type of lock?
>
> Then the lock read from blocked_on could be a different type of lock than
> what is expected.

That is different from reading the owner. In this case, we need to use 
smp_rmb()/wmb() to sequence the read and write operations unless it is 
guaranteed that they are in the same cacheline. One possible way is as 
follows:

Writer - setting them:

     WRITE_ONCE(lock)
     smp_wmb()
     WRITE_ONCE(type)

Clearing them:

     WRITE_ONCE(type, 0)
     smp_wmb()
     WRITE_ONCE(lock, NULL)

Reader:

     READ_ONCE(type)
again:
     smp_rmb()
     READ_ONCE(lock)
     smp_rmb()
     if (READ_ONCE(type) != type)
         goto again

Cheers,
Longman


