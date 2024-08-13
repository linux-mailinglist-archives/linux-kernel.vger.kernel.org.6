Return-Path: <linux-kernel+bounces-285126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E20E9509AA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DBF281ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE511A0AEA;
	Tue, 13 Aug 2024 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZEgZsGw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9086E61FCF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564898; cv=none; b=WhIj2CsyGdMzLo87KYJ7BxZpzhXcJOgC3/M2nAM06+DxkDpNd7892sSbedGlXDrLcXFd9MJgBZD8abANV6hNpcsmJa3J6AxMO85LH17yqUCcDWhwYYBqVstXDwkQLbPiTVPC1VIdGF373kHpD2/7jeojNGN90EDrqsrFwcRC/sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564898; c=relaxed/simple;
	bh=pb5iWyGbLBoSRfc066A41J8/Por/3wIu1JOSbbaHA7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fsZxbYsv3iprnnMNt2EtuaQXzCN2eZXO7ZN2xTvaaMtClnzPZnq6K5AiaWRjCX98d98Pp0D+nnb27J+GnWlzHdvoDGwRiKes5iB7oFRtXFwgl5DvZCp0IIz/yH+XFidM0Vjts2B3M1BkP9eNrgWQIDEPvJGvV/BRXFGnamLxyjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZEgZsGw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723564895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b5sTfG8EAhu68ZB0jEuQAT/8JuG7U9BrME4k1pn/3mk=;
	b=cZEgZsGwC91jGYSPLMRF4IQaGfJmMsdEG7hg1eywXdWmjQ0pOXZTB/K7/m9C+DQjnHQsL9
	2s2QtOU5iSO8KF8P+45S15Os5kciSs/Uda4ZwCyfgPueOO6kPgklwLqoRvxPT9RZjNhlvI
	HXXUjt2hIfq7LPNIDE6msRU8fSlYhwI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-gewpz5zHNLWRr7eGVvTuZw-1; Tue, 13 Aug 2024 12:01:33 -0400
X-MC-Unique: gewpz5zHNLWRr7eGVvTuZw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef22e62457so58320311fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564891; x=1724169691;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5sTfG8EAhu68ZB0jEuQAT/8JuG7U9BrME4k1pn/3mk=;
        b=YYpfS1eBxUgU/RxFMBFFNZGBe+oJO/C1mCrOEdFyDkMc/DeS6r/++vrYc1tve/QnGC
         L1QPkOX5Gyb/urK+vKbHCtDpPXzVRJ+U/OcRKFxgIzd58lS8N92hrjr4KRn0xWivZyIw
         +MOLBpOvrAGGbZUdCsHl9WfJnMLxEmSRNo57Dnb3zOA6ETbN8FKctu3iOaqoU+nhrv1m
         hfOlSrwCyie7giktETzMmRLS6boxAWxZaofMPnrDiB+MwWPJ/iTkYneduKPLfj0AjpLU
         OlGAOr35n5HqnOhjFiV58WCEyuBsSo/oO99WV/1BTf8XHIWee7PqbNLlC1PYM7YKJ/Dx
         VopA==
X-Forwarded-Encrypted: i=1; AJvYcCXetFaAgAYulKMPp5gayM7dLwEqU1aLFJsFyMtJpZ66XJdBY7aekOPkNVkLorm4wWJofaYxFZTd3qddfApI935D3xbDEYd6jJfEfwAw
X-Gm-Message-State: AOJu0YxDpABcQja6rFJU0J7jJ7Zy3LKby91fBb1j8LdyCvoBn3TRNkuX
	xGL72Ski7s+jSbhCF6ddWkaHlvoEVrNcMPxvsdqaPUmHRReHGsvmFJSlB0ijOg6azo1doICB8vg
	UQhq3sQq9rppfLp27TYMqGFtssGuLuUkrnsVAj13DB3YyuU015PVMIAzTgnJWog==
X-Received: by 2002:a2e:8182:0:b0:2ef:2ce0:6ac with SMTP id 38308e7fff4ca-2f2b7159b18mr26043321fa.22.1723564891158;
        Tue, 13 Aug 2024 09:01:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDVbG5v5nEDdy/okoFzo4viEw/a96f3I306vHv1Wu7okdK1LYg4YOioEsPtg07VeG2gjICSQ==
X-Received: by 2002:a2e:8182:0:b0:2ef:2ce0:6ac with SMTP id 38308e7fff4ca-2f2b7159b18mr26042931fa.22.1723564890495;
        Tue, 13 Aug 2024 09:01:30 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a80f4181439sm79513666b.190.2024.08.13.09.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 09:01:29 -0700 (PDT)
Message-ID: <1186d821-41ce-47c2-a7b2-70445816ed1c@redhat.com>
Date: Tue, 13 Aug 2024 18:01:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] KVM: x86: Make x2APIC ID 100% readonly
To: Sean Christopherson <seanjc@google.com>, Michal Luczaj <mhal@rbox.co>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Haoyu Wu <haoyuwu254@gmail.com>,
 syzbot+545f1326f405db4e1c3e@syzkaller.appspotmail.com
References: <20240802202941.344889-1-seanjc@google.com>
 <20240802202941.344889-2-seanjc@google.com>
 <eaa907ef-6839-48c6-bfb7-0e6ba2706c52@rbox.co> <ZrD9HHaMBqNGEaaW@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZrD9HHaMBqNGEaaW@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/24 18:26, Sean Christopherson wrote:
> On Sun, Aug 04, 2024, Michal Luczaj wrote:
>> On 8/2/24 22:29, Sean Christopherson wrote:
>>> [...]
>>> Making the x2APIC ID fully readonly fixes a WARN in KVM's optimized map
>>> calculation, which expects the LDR to align with the x2APIC ID.
>>>
>>>    WARNING: CPU: 2 PID: 958 at arch/x86/kvm/lapic.c:331 kvm_recalculate_apic_map+0x609/0xa00 [kvm]
>>>    CPU: 2 PID: 958 Comm: recalc_apic_map Not tainted 6.4.0-rc3-vanilla+ #35
>>>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.2-1-1 04/01/2014
>>>    RIP: 0010:kvm_recalculate_apic_map+0x609/0xa00 [kvm]
>>>    Call Trace:
>>>     <TASK>
>>>     kvm_apic_set_state+0x1cf/0x5b0 [kvm]
>>>     kvm_arch_vcpu_ioctl+0x1806/0x2100 [kvm]
>>>     kvm_vcpu_ioctl+0x663/0x8a0 [kvm]
>>>     __x64_sys_ioctl+0xb8/0xf0
>>>     do_syscall_64+0x56/0x80
>>>     entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>>    RIP: 0033:0x7fade8b9dd6f
>>
>> Isn't this WARN_ON_ONCE() inherently racy, though? With your patch applied,
>> it can still be hit by juggling the APIC modes.
> 
> Doh, right, the logic is unfortunately cross-vCPU.  The sanity check could be
> conditioned on the APIC belonging to the running/loaded vCPU, but I'm leaning
> towards deleting it entirely.  Though it did detect the KVM_SET_LAPIC backdoor...

Yeah, let's drop it since we do have a test (in userspace).

Paolo


