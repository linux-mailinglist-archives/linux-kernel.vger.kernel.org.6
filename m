Return-Path: <linux-kernel+bounces-182352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7298C8A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 18:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1CF1C20A01
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171F713D8B8;
	Fri, 17 May 2024 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJstNmSH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F813D8B6
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715963712; cv=none; b=Hs0NFydI99ST5TUxfbdttBbjmtK/Tp2neKShJ/aREYeGtTz6JkTwSxPlLwe+LJU8d2yw6XEgGDZT4PgVfw/hOt6AdEzwVv/HNx7/eiLlMV4SzY9F+7Xmdr5oobWmPAnk7zXDr5Cn09fB5gEQPF5eN+6V1D/borHqbOyNq0XuQgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715963712; c=relaxed/simple;
	bh=CK3agC6rs1w1n4s2ZLnkcwXvTNbsYeUjeOXNrgffLqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJ1drfN7Gy9sHjLrt7eQySCgsJwt0qageksZv4QfZiTpMLmZCNKK84siwWJeV6TS1fr5icDWp7iOylE5faVeaNhNCKUdEuOjvTvwPIvc6IwFaiyTM3vuTbqyadhwSWyRlofq4TqLUXYXKYnWGeh/p0NKvGEWh1zxKbz7WeZ734E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJstNmSH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715963708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QGr87EvmQ2eY+XvddpcpgzToCcCzn2nyVCX2F0KXF14=;
	b=LJstNmSH7X+T/ERrK/BeCyodEpOkuuJIsWkb7+HbDJUWkaA+ER2ybya8fuA0qtzLDaziAV
	bm/sNXwS4VpA0xZm4HoDZNCUDkgyU6ppqUCwIoCHDAcuYHMa+QeVVhDxuowPnO7YbQ2PqT
	zwonc2PeOwDZ86ebGge2hPSSfRKBat4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-0EzyHd3aPM-yGDFXC84RHQ-1; Fri, 17 May 2024 12:35:05 -0400
X-MC-Unique: 0EzyHd3aPM-yGDFXC84RHQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a5a180153aeso576710766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 09:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715963703; x=1716568503;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QGr87EvmQ2eY+XvddpcpgzToCcCzn2nyVCX2F0KXF14=;
        b=SXXixtGPcKfSQmbPGFsUG/vUE6j5BMKAy6IhoaRhIUUImV8PlJdqP4cIKBk1gd88aY
         viYxu4LVmgGr8SrUJGT+c20BhqWOVa3auXQa87t1he34sok85wIL2qFNbOXQmfryn6MZ
         +3NvlrHwE5gKPkgISEVTBijL/qqC/E9xb0JgCTcsYU2mVZuU/Hg4ZYOhh+rijLBgSQAJ
         LAIrPq0bUBovq2pBkYqm9psnpIaK+doLEvLJq1BmmB3e9/ZUsInoNGg1TT98NXLXmY5d
         HGV7NR5vlIKOOkmj7uHTzir6mcwh27gDLE8pudHfCNyhsBaVGoGYQ00c4JPJif/6aJp+
         kUkw==
X-Gm-Message-State: AOJu0YwRmcjf1Wy9Wf5P6L0vcLykAdyqYakkFoTCkmEWfrNmLFygh8mb
	otzJ3MXgOLFUMAdv9acrF7YwLjEgC6q9EWeX+Tu1mBALGNQhhlhYSlKojax71Uy50D4UAPZ8re6
	JWuNqQvjHrSG6sdrSbQ6KHVpRgtFom/uz1h66glh5c/gdNF8ib0umfrakix8+FA==
X-Received: by 2002:a17:907:980d:b0:a5a:5496:3c76 with SMTP id a640c23a62f3a-a5a54963cdfmr1603516166b.6.1715963703403;
        Fri, 17 May 2024 09:35:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9fQoyN0idlh9uq3pfbOZ9nmynTDs7dwbBmWRUMQwcC4oM5DuTa2SzGGKVAGbmlO4chOSG3w==
X-Received: by 2002:a17:907:980d:b0:a5a:5496:3c76 with SMTP id a640c23a62f3a-a5a54963cdfmr1603514366b.6.1715963702934;
        Fri, 17 May 2024 09:35:02 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.155.52])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a5a1781ce5dsm1123813666b.42.2024.05.17.09.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 09:35:02 -0700 (PDT)
Message-ID: <7c0bbec7-fa5c-4f55-9c08-ca0e94e68f7c@redhat.com>
Date: Fri, 17 May 2024 18:35:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] KVM: VMX: Introduce test mode related to EPT
 violation VE
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Isaku Yamahata <isaku.yamahata@intel.com>
References: <20240507154459.3950778-1-pbonzini@redhat.com>
 <20240507154459.3950778-8-pbonzini@redhat.com> <ZkVHh49Hn8gB3_9o@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZkVHh49Hn8gB3_9o@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/24 01:38, Sean Christopherson wrote:
> On Tue, May 07, 2024, Paolo Bonzini wrote:
>> @@ -5200,6 +5215,9 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
>>   	if (is_invalid_opcode(intr_info))
>>   		return handle_ud(vcpu);
>>   
>> +	if (KVM_BUG_ON(is_ve_fault(intr_info), vcpu->kvm))
>> +		return -EIO;
> 
> I've hit this three times now when running KVM-Unit-Tests (I'm pretty sure it's
> the EPT test, unsurprisingly).  And unless I screwed up my testing, I verified it
> still fires with Isaku's fix[*], though I'm suddenly having problems repro'ing.
> 
> I'll update tomorrow as to whether I botched my testing of Isaku's fix, or if
> there's another bug lurking.
> 
> https://lore.kernel.org/all/20240515173209.GD168153@ls.amr.corp.intel.com

I cannot reproduce it on a Skylake (Xeon Gold 5120), with or without 
Isaku's fix, with either ./runtests.sh or your reproducer line.

However I can reproduce it only if eptad=0 and with the following line:

/x86/run x86/vmx.flat -smp 1 -cpu max,host-phys-bits,+vmx -m 2560 \
   -append 'ept_access_test_not_present ept_access_test_read_only'



Paolo


