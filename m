Return-Path: <linux-kernel+bounces-322566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2240E972AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C37A28641A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98971822E5;
	Tue, 10 Sep 2024 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtGBuBtL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1A117C7C1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953796; cv=none; b=OO6zHtKNDl1m83TqWnvcWJUq5PQVT3GR3LcOqK4mdJD20ugDbsPsMRgLEDd6ngxsKInD8sap1ATdeAt15panzYakkp+p3SfEeNBRpxbQxnBJoE093y9j14jgygLwlefUkGUgqWZ8Mtz1AcLaiKkHMRBB3sQh0WytB6EUt3jHhCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953796; c=relaxed/simple;
	bh=vqDoUCzJjSbqrkM+d9vMmu26ILSQB+jjKg96vinHDbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9qm+48C6NaYw+OkcxZJUPfKIFnQpUtvlZTWXD7CJlx/SxcDOEjJfqfDNjuMlt79x1PrxPtxBRHx/aQWVO5Zzsv45mLeJQkna6eGhRFcpXFcO6dvrpedsTz57ceniTlrWI0bl0MVUYFkDVsZGxpEysyExV86qECTRod7nluljzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KtGBuBtL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725953793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bukCso29aKam+9maewuaC/NZhaRQP9BCYwY472MO8DI=;
	b=KtGBuBtLQwYishGsoWk+rgahuz2v/DdGUGNYb94FyQF6mYA2POl4mPjBook2qm6f0MKxT/
	YQ0MMl53JlEtZU5BwFc+CHV8VnIFkn0omgA5mBtKW4VOZm6x9LYThLl/rwgCRE73wip34n
	VOMF816n3q6awmSN9B+VB+GRBoofGOc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-4ZihNf1MMquayvyWeW7-ig-1; Tue, 10 Sep 2024 03:36:32 -0400
X-MC-Unique: 4ZihNf1MMquayvyWeW7-ig-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3750b4feb9fso2617494f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 00:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725953790; x=1726558590;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bukCso29aKam+9maewuaC/NZhaRQP9BCYwY472MO8DI=;
        b=YK6MOrqJ0be6nqhUQWzmw/bi7zha1Q4X2ypdqFlGqCKwdOQ8rz3S1+dZh1QD7w7si7
         zFIVmxpFFiQmFImVq8Ezwl/my5O61w1BK/X3Hnpj3qgF55VgXY0pxtAtYD4+WLf4sP8C
         D6js9JA0VeTqcpeV7/Fvdc7bOE+cPxafjybeWY782bXqI744+u8n2zYWOMqYSrARRRkx
         +Bxio7gGQI83Udgimbv3ZqrzjuOHzw6AQtRC+TsoHMCBvUZ4elKFf8zdeUP4J+MOv7v3
         6FkwWWiA7a2XjKZSz1LpI+ztGH8Y1Ca1IgSjXJOF2FRVmG66LedJMCd14SPbIqMR7RgZ
         uypQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdXM9d9bV0BoS1D8B8lLYze16N8qEZrY3jTdKjUp0qfpOwgrwju026SQLyk7gcZ7ORjQcyW+uuhrb5rZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhSjDFErRzcEfNiBq0AWlkcCXE9nVyP3LMRlOR4k6TtTwf62e3
	hDuqp0HbmuF2Lrv2Etao/JXgzvnb/BTc7VjdImLPI7HV5aipr9uKMEf9ypvB/ZqIAybwrkgHLBc
	OsdfSYWO+QxpoED/nV+/IX3vXpZtnpn/ErvivR6xN7DgZumtVyzBAxkkIGHOk7Blfbm4waRIB
X-Received: by 2002:a5d:4b4b:0:b0:377:94b:4f51 with SMTP id ffacd0b85a97d-378a8a3f05amr1121316f8f.22.1725953790025;
        Tue, 10 Sep 2024 00:36:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHCCkfOb4EqRM6UgsN4gnFTzX3BY9gFEsVBg4YPpdXui53Uv6lrFYm9BHJW9I8Y4rjNzAtJg==
X-Received: by 2002:a5d:4b4b:0:b0:377:94b:4f51 with SMTP id ffacd0b85a97d-378a8a3f05amr1121298f8f.22.1725953789490;
        Tue, 10 Sep 2024 00:36:29 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37895665babsm8098993f8f.47.2024.09.10.00.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 00:36:28 -0700 (PDT)
Message-ID: <c22f38df-0cf7-4eeb-8632-94b9b8b4a55e@redhat.com>
Date: Tue, 10 Sep 2024 09:36:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/21] KVM: VMX: Split out guts of EPT violation to
 common/exposed function
To: Sean Christopherson <seanjc@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: kvm@vger.kernel.org, kai.huang@intel.com, dmatlack@google.com,
 isaku.yamahata@gmail.com, yan.y.zhao@intel.com, nik.borisov@suse.com,
 linux-kernel@vger.kernel.org, Binbin Wu <binbin.wu@linux.intel.com>
References: <20240904030751.117579-1-rick.p.edgecombe@intel.com>
 <20240904030751.117579-5-rick.p.edgecombe@intel.com>
 <Zt8dRVdkT2rU31jq@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Zt8dRVdkT2rU31jq@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/24 18:07, Sean Christopherson wrote:
> Paolo, are you planning on queueing these for 6.12, or for a later kernel?  I ask
> because this will conflict with a bug fix[*] that I am planning on taking through
> kvm-x86/mmu.  If you anticipate merging these in 6.12, then it'd probably be best
> for you to grab that one patch directly, as I don't think it has semantic conflicts
> with anything else in that series.
> 
> [*]https://lore.kernel.org/all/20240831001538.336683-2-seanjc@google.com

No, this one is independent of TDX but the patches need not be rushed 
into 6.12.

Paolo


