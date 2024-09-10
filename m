Return-Path: <linux-kernel+bounces-323618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D24F97406F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE90B29504
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8541ABEC9;
	Tue, 10 Sep 2024 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlljolcC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207FB1ABEBA
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989483; cv=none; b=cpAetbXuMT+VS+fqL5znAz9sQglpCWWnA3Em/baAyshVTpxW0tiRer6TD+kff2YtrMlKyaBMnBiELhbc15AtX+3S2q/xPGZKOSKqWmP6QRGbcQ2QCMHxk0GslajoyKwRvgKLBiIv2bRDdVcpmRjbV6kx9WX2wuipazOErAtrlEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989483; c=relaxed/simple;
	bh=zLg14Q65wu05Yz0CdocNRo3LsUGTtqQTpYBpH3ca0cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSGjEVwF64nKmzReGNUWmggOfvT3Gz44s4ARGR8EDQL89aPYI4F0EHcpvkm1rj/gNag58YtKk4ajZmIiLUYrb34EkR8Lwoo7ZTgttfCaIy3jMAt8QrSBbuJ14LUAjDaIjmBWzkAhRJLBk9czkX/meUxdlAIwyZG4X7MGFau2rpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NlljolcC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725989481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xLcvqp5chP2dPZGzNdVbZn2ZJp4vCGE1ONukxZlZVHE=;
	b=NlljolcCUMhmPknznN9+Oj6I2oJdex4PeeCki9gE4ax35/dVwztKEZkBfqgRDEQhqAu9/m
	jVRgwFvJxeiMY4j0L7nQTA+RD0kINEt0zJwGc1QBHmhArsGKZFq2+IPtoU9dB2WCNJYG64
	VY32f9YpobkLOMdYs/iQFcPXJWRIpOU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-oLSN8cAJMrm5jIbRxkfTag-1; Tue, 10 Sep 2024 13:31:19 -0400
X-MC-Unique: oLSN8cAJMrm5jIbRxkfTag-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42caca7215dso27281945e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725989478; x=1726594278;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xLcvqp5chP2dPZGzNdVbZn2ZJp4vCGE1ONukxZlZVHE=;
        b=V9RbOMxaw2PM35gTfnqiHuzn5wZk6QRHV8q92Xd6Mh0c+nGOIOcyLz9tsFnvkTeCRs
         ZaUrlLDye1CTfLs2ZK2L76OD6a+0Z3lB+NX32xs5k3PhU/WRvztLp0v2pLUkhSu8LgnL
         1t0Xh5VUVOXc1tABh5U5uNBZRpqES8Q2Ivb0RtBs7oqJV3kzUrH6f5dH9O1HlWeddLlb
         40OUdRjfmjZzJUs0fsV1IGk30L5xKCgHoxk5JxuArsQvgdhqbnl5hK77Wt+5W2mh1OpT
         1dd/HniuMdU4OwIGjeG3ZvDtKbud4kjjJDXE7iO8vrRncB1Lpe/8ZMvoL2JeshNhQ5XW
         eJUg==
X-Forwarded-Encrypted: i=1; AJvYcCWrWaPlgg0hdpUVVSZDhP8FVVBJgh63+PYu5wgs7g/3gcnSM6pART6T+BTnczg8I7VxBol4x6MS/xYUsAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2wSPppXazKqwvRC7YHqwWMTmJZWlap4dH0A++SylnKd/qrjdn
	tVz1thQC3zFveOJ7D93O1IUqKYbQntCLfkjS6iWOD1fnEn3JGepyydwlJCaXj5phAJmHKURv4w2
	U8ewfVqeOVu4DEWPQFNtrHuCFCC5PgLB47PQckuf2XZfag4VufJ9RyVCThEUmCg==
X-Received: by 2002:a05:600c:1c16:b0:42b:afe3:e9f4 with SMTP id 5b1f17b1804b1-42cad746525mr90187305e9.3.1725989478426;
        Tue, 10 Sep 2024 10:31:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFM6s6VhdPe9bBCCI8bOowhCo7zDIQhAJP38VRyGZKXGtWax0aiQPX7UTyQyQY8XSUWwg0yg==
X-Received: by 2002:a05:600c:1c16:b0:42b:afe3:e9f4 with SMTP id 5b1f17b1804b1-42cad746525mr90186995e9.3.1725989477901;
        Tue, 10 Sep 2024 10:31:17 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37895649bafsm9642275f8f.7.2024.09.10.10.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 10:31:17 -0700 (PDT)
Message-ID: <7ba0756f-3a7f-4aed-b0d1-d47c1d4cbd5b@redhat.com>
Date: Tue, 10 Sep 2024 19:31:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/25] KVM: TDX: Use guest physical address to configure
 EPT level and GPAW
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, seanjc@google.com,
 kvm@vger.kernel.org
Cc: kai.huang@intel.com, isaku.yamahata@gmail.com,
 tony.lindgren@linux.intel.com, xiaoyao.li@intel.com,
 linux-kernel@vger.kernel.org
References: <20240812224820.34826-1-rick.p.edgecombe@intel.com>
 <20240812224820.34826-23-rick.p.edgecombe@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240812224820.34826-23-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 00:48, Rick Edgecombe wrote:
> @@ -576,6 +575,9 @@ static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
>   		value->ebx = entry->ebx;
>   		value->ecx = entry->ecx;
>   		value->edx = entry->edx;
> +
> +		if (c->leaf == 0x80000008)
> +			value->eax &= 0xff00ffff;
>   	}
>   
>   	return 0;

Ah, this answers my question in 21/25.  It definitely needs a comment 
though!  Also to explain what will future support in the TDX module look 
like (a new feature bit I guess).

Paolo


