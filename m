Return-Path: <linux-kernel+bounces-515104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9181CA36028
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F1D3A5596
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A31265CB9;
	Fri, 14 Feb 2025 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNyWlDT5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C04C263F2E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542666; cv=none; b=PsjWWX5ghsMa4mTABnQ2b52mpHbCq5ohAGjSOXCBfX+XLqrNUqw3vV6W24AdwE/OkAdYDln5g1O+PZ3Us+01SKa456FhbSI/kL2slTyl0iMny20907Z7lJQXKGZzFOMLRKoMAQPBPLDzp239VBL8bHEYU+4U3BeLRU0cwVUa55o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542666; c=relaxed/simple;
	bh=JCXEm2l4gcHbLu3QN62NhahhVyn6aU38KSlNB4wAFpg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VpW807a5yVX1z2/Cl1z8J+GjGfITimckX+bgUPH3VgRCfAXlgboLWo9KyV06KwqykoBBMqfKR5NewaBTk9bwUk3ADAT703sepnQB+6pa51mLHA9KybbICMEAI3gWtq9ih+M48l2kpMo51G4U66eZFS9pUvEA1pF3HLBAVmPd6VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNyWlDT5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739542663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wrUYRhRxFfGgRZ/7tX5o3nBHGzEAvDzAfxtEVpTmJWU=;
	b=VNyWlDT5psBnHGgXPmpUUgvwSVu2teVc7s96c3o8stnWX50ES9hbpFY9BsqEaa5qedkBHp
	SgGzrDuUj8CQu6LYt46QQgZHM+QtxV6Clw3Pizb4/4/DYJVcYN84TmYVHcJjz+iZHwfwRY
	QVL1uaFjD5YmoHCQWxkfKVHRibeDmUA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-CA0vwpSyPUChO_jo9F-kNg-1; Fri, 14 Feb 2025 09:17:41 -0500
X-MC-Unique: CA0vwpSyPUChO_jo9F-kNg-1
X-Mimecast-MFC-AGG-ID: CA0vwpSyPUChO_jo9F-kNg_1739542661
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c07249127bso369758885a.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:17:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739542661; x=1740147461;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrUYRhRxFfGgRZ/7tX5o3nBHGzEAvDzAfxtEVpTmJWU=;
        b=aYxgfSiPBMzsVGX26IWrI+vs3j6QMRU1qyKdNKhRWinAGDkHXoFhBCPpDfc1+wdCOI
         3RfNSMkBfXfRwHZPDcR6bhrz+ulTD/JUMhoszzLu2m3OCR4KDW1EXJYjMP8alEcdqQCs
         nuFv38Nc4tbCaf2ILIYfT/BkdKWjeExw4R0tlMniREYaM1ORdO6SWiUwlG71wiS9F+N1
         x/wOywyy+K6zk9H7GznAk2KeLISygwru7n43hSpTrVCkisN1vshBXbVUL7Rd2L8R0JVu
         58TlMulZCXCeHY14rbuW1qGTwxxT01zX07lSnY+8ijV7dUwLUMhVDDSKnp1q88lsQNbn
         sfXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv2o0Xi4eoFRdzsXMXpvxpZOoDKl7TiJsPgJEBYAIJCNPZFxfx39Z37q37Tmg7Sxpn/F6WQH5VBvYNOB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTLCaA8bam37J3YfNh/9cqV+mqfQHCXhAl7ak+luyn7sg0Egmy
	eVOKXbcox7bEUGkzC6nT+StJ+hOTgl5ekm6hAbOLsEu0hriWAK5sY3FQ0luZoiS+SD5Bum9TgvK
	PP6ck6/dMIvPEiYHxzYD8wB1dTFjGu/DAAwAmqsol2BOhDU934yiXzDsRPT89Nw==
X-Gm-Gg: ASbGncsq+oegb/erc3C2pBZU4VdeklhOAdyV5PwMrvRVA+cgtrUysDgAjp+0p+TJaRg
	UMKfP+MkLvl8rn6HgzwaU6P//9gAPAKCaSZ+IahN7uKBfqI3fH9YB/uTc79UvnU6glVK9sRqE/H
	SpqqNJbUkVpF84CSsqr/pDSut1T21bB45Xn5EqqVNp4DVosO4TC2azYCKjfW3fH3NAfsYNETYc8
	JzA5Dy4qs28ivWOvtBWgvrCc4Lii+rmMnkZrPnQBm410c2A+liZ2UPuWQJF/tejZ/yZ4W+R5P34
	b51Haaxtjl97Sc6Toqv2ubdomRT2Ec6mtilPyEgGvN/MX71l
X-Received: by 2002:a05:620a:4442:b0:7c0:6419:8bd3 with SMTP id af79cd13be357-7c06fc69c98mr1707212785a.22.1739542661454;
        Fri, 14 Feb 2025 06:17:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFY9maWHpPjpw8PFEyE47thojPlwSxDO4sGn3xrsMNWv1QHYKuDV7jBpb7t4bXZobeHknOclQ==
X-Received: by 2002:a05:620a:4442:b0:7c0:6419:8bd3 with SMTP id af79cd13be357-7c06fc69c98mr1707209485a.22.1739542661143;
        Fri, 14 Feb 2025 06:17:41 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d779201sm21536016d6.2.2025.02.14.06.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 06:17:39 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <812ea88a-b79e-49e0-ab3b-83cd40b2851e@redhat.com>
Date: Fri, 14 Feb 2025 09:17:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [cgroups?] possible deadlock in __run_timer_base (2)
To: Peter Zijlstra <peterz@infradead.org>, Waiman Long <llong@redhat.com>
Cc: syzbot <syzbot+ed801a886dfdbfe7136d@syzkaller.appspotmail.com>,
 cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 mkoutny@suse.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
References: <67a9136a.050a0220.110943.001e.GAE@google.com>
 <2aaa1663-fa9c-43ce-9421-60019899bac1@redhat.com>
 <20250214101959.GH21726@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20250214101959.GH21726@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/14/25 5:19 AM, Peter Zijlstra wrote:
> On Tue, Feb 11, 2025 at 09:14:12PM -0500, Waiman Long wrote:
>> On 2/9/25 3:43 PM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    92514ef226f5 Merge tag 'for-6.14-rc1-tag' of git://git.ker..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=179453df980000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=1909f2f0d8e641ce
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=ed801a886dfdbfe7136d
>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>>
>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>
>>> Downloadable assets:
>>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-92514ef2.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/c4d8b91f8769/vmlinux-92514ef2.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/c24ec4365966/bzImage-92514ef2.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+ed801a886dfdbfe7136d@syzkaller.appspotmail.com
>> This problem should be fixed by the following upstream patch once it is
>> merged into mainline.
>>
>> https://lore.kernel.org/lkml/20250127013127.3913153-1-longman@redhat.com/
>>
> AFAICT all these lockdep reports are because of an earlier warning. Fix
> warning, report goes away. Notably:
>
>>>          _printk+0xd5/0x120 kernel/printk/printk.c:2457
>>>          __report_bug lib/bug.c:195 [inline]
>>>          report_bug+0x346/0x500 lib/bug.c:219
>>>          handle_bug+0x60/0x90 arch/x86/kernel/traps.c:285
>>>          exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:309
>>>          asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
>>>          expire_timers kernel/time/timer.c:1827 [inline]
> IOW I think we're focusing on the wrong thing here.
>
>> Peter, are you planning to merge this patch? This is another instance where
>> the old way of calling wake_up_process() inside the lock critical region can
>> lead to deadlock.
> I still don't love the Changelog, but yeah, I suppose I can pick it up.
> But I see Boqun took it and I'll get it eventually.
>
> No real hurry there I suppose.

I know my changelog is sometimes too verbose and may contain 
non-important information. I will try to improve that in the future.

Cheers,
Longman

>


