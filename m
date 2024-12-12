Return-Path: <linux-kernel+bounces-443328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E729EED32
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B689F28546F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D313223338;
	Thu, 12 Dec 2024 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtOqMdK6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8214F218
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018131; cv=none; b=FF1rAJj4WTWsWPXu6XPMhDP4K9A4mtv0M0Ob8d6A8kFSQqX42wMUkKnGDOK6zfZWKeU+cEajwR/hVdFtWD8BbLIimSPbciyahAX09n9BXWhuLMfPV3sByTNveqneVhDs9W1IUijRmnuQ7NxEvKVYwSJSKbvplEA1gomrsFke+FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018131; c=relaxed/simple;
	bh=fukLmqnaJraW/2v7q2qULQxlYWaXiBQWviatK4l3x20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rNSUrysWl9UxojZ1OsTxLznmYRV+osc+hjhqlhTQHtIwBvLlCEh7xBuECMOKuvjst3hlgf7zumnAWjMpeiiQTFRQfTmdYLkKt9by+ZkTw7pKn/GPYszm1xeSwWzQ0qPjxycUwrUu66GBwu10vNX+XXnhaqwfqUa79xG8h26KS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VtOqMdK6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734018129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GwnYZoIOyRvAz2iL7Xc1JQqOWzhArnZy+3zS3Tov6v0=;
	b=VtOqMdK64uAjCO+nX+Tf7ogwm/pfp9MTvDcl7hOswzz8tFtShr5aptAQsNU8Z40L7BsAtm
	sXp0gmFDNZs6Wj0C2UUETScLGs0JsAQ3w9DUrwm5fN9rJqVfeWI+eL40PyWkRnRu+4XPk5
	0ppjzYJLZlnoyJak+ZOvwJfWLLR0jm8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-I297Zr4KMPWIDvNNBIIK1w-1; Thu, 12 Dec 2024 10:42:07 -0500
X-MC-Unique: I297Zr4KMPWIDvNNBIIK1w-1
X-Mimecast-MFC-AGG-ID: I297Zr4KMPWIDvNNBIIK1w
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-436225d4389so5984515e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734018126; x=1734622926;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwnYZoIOyRvAz2iL7Xc1JQqOWzhArnZy+3zS3Tov6v0=;
        b=poUzRGFq2XYDT4Mq/D8cogjpp1KWbrY2LnseiD5Ql84jAHKvW9oqpyjQ/IdYeFDsbD
         2T9EHGz8s+CHLF3/bGYs9a55MZzR6BarZ2+huZfYvz7QGKUGgOHM1/aToNggiArjUd3a
         u7xCPJhWkLM/QIv85Kp+se3VC1oM5guWtKBMVArbvAneOdaG2uEAXHrLU3pa7BPovrgK
         dqOv+2yKoiZcZ6001YsGUhHh1XfHbEigPuuB8nsBEbpNJRhbF5DgPSCHrI6TWzd2mpdn
         DIIYJ0DxpwNrFnm8/+PAX4y9knrg/ynrmsgu/vRUAsrL3eoIT5kJpbEX+LV48fJKyZ5g
         uVMA==
X-Forwarded-Encrypted: i=1; AJvYcCU865yXWwvdh9tKiDeyopeHLcJ3/FiKFolUYykn/H6TmgALRpMG/8jvyiLNlld3C0ZSNduZEkpygKeRMB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWNvjCOFVJDk0GX96qScoe1mRkJgz6KxYcBTuzTceYAmX2YFTL
	JmztD8QIh3r4vQgDh1ymrWWElFjyFsJKwH+oKR8tvC84JPTH1dObLAC+sROIcWP1dHkDhKsXs+u
	YsOie/mnc4TL1gPcwyf4R+xTrRyixFWI5/4VB8CSTtqPVd2uX+mt24jIG4paGmdJjFTCawg==
X-Gm-Gg: ASbGncvl247P0Fion4POZRW9aKoToH2vZ7VxSnwmmEr1QXYkRs5vJKq7eXkqdtuepCv
	ETePQlvmeaDl1BBFE2+dzzWs9Dd+j/EfOJLawFvdwSlSyNAVS6eHeMKbtnyTxebrnheU3F12c6o
	JknW6rnZUn49HiIU4KvvCK8h3n3NHGX0szWcfKWpdSW1P2JMmN+r/yjTkxLw686JbHDe55XkPwC
	s/pGFCmgLRozwFLb6scXksQWjUqtCcXbilrHEKL0dtRm0d0aoe6qCTzIGi9
X-Received: by 2002:a05:6000:2cf:b0:386:4332:cc99 with SMTP id ffacd0b85a97d-387888069d8mr3157731f8f.17.1734018126219;
        Thu, 12 Dec 2024 07:42:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsodZpbrf8J7/oaYzyqOrF+t95qa3MPBpLVtsfTFotrDy5D819vIPk3Y7tmLvjrhTY14AivA==
X-Received: by 2002:a05:6000:2cf:b0:386:4332:cc99 with SMTP id ffacd0b85a97d-387888069d8mr3157708f8f.17.1734018125894;
        Thu, 12 Dec 2024 07:42:05 -0800 (PST)
Received: from [192.168.10.27] ([151.81.118.45])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3878248e61dsm4325250f8f.21.2024.12.12.07.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 07:42:05 -0800 (PST)
Message-ID: <3b440ac3-391d-493b-9384-218bd61d7e67@redhat.com>
Date: Thu, 12 Dec 2024 16:42:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] KVM: x86: Refactor __kvm_emulate_hypercall() into
 a macro
To: Adrian Hunter <adrian.hunter@intel.com>,
 Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>,
 Kai Huang <kai.huang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20241128004344.4072099-1-seanjc@google.com>
 <20241128004344.4072099-7-seanjc@google.com>
 <90577aad-552a-4cf8-a4a3-a4efcf997455@intel.com>
 <6423ec9d-46a2-43a3-ae9a-8e074337cd84@redhat.com>
 <Z1ier7QAy9qj7x4V@google.com>
 <0751a7b8-f8d3-4e27-b710-0a2bd7d06f7e@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <0751a7b8-f8d3-4e27-b710-0a2bd7d06f7e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 08:32, Adrian Hunter wrote:
> On 10/12/24 22:03, Sean Christopherson wrote:
>> What I do deeply care about though is consistency within KVM, across vendors and
>> VM flavors.  And that means that guest registers absolutely need to be captured in
>> vcpu->arch.regs[].
> 
> In general, TDX host VMM does not know what guest register
> values are.
> 
> This case, where some GPRs are passed to the host VMM via
> arguments of the TDG.VP.VMCALL TDCALL, is really just a
> side effect of the choice of argument passing rather than
> any attempt to share guest registers with the host VMM.
> 
> It could be regarded as more consistent to never use
> vcpu->arch.regs[] for confidential guests.

Yes, that's where I stand as well.  There's reasons to use 
vcpu->arch.regs[] when "decrypted" values are available, and reasons to 
not use it at all.  Both of them could be considered the more consistent 
choice, and I think I prefer slightly the latter, but it's definitely 
not a hill to die on...

Paolo


