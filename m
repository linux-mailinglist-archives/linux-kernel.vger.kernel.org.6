Return-Path: <linux-kernel+bounces-268975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE240942BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDC6281B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0B71AC44A;
	Wed, 31 Jul 2024 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAmb5gv0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321671AC422
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421108; cv=none; b=BR7pNAJWisjepPSnoPP9sjR9ZJYWTXe1Irxx1vjyMb87/I3vRbZAeerVHpS+YyiqtgNEgkUKEzLq0u1cLWc0psD+ei6N7yvrK0dOc4BAjR2GCADTLc+egUq0l9ep87seffL3usOXPR/vkX2ITefatUsslS4jx4hGmQLEmWDHIZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421108; c=relaxed/simple;
	bh=+PrbklTeRiXOHSRdGh97gn5y602otpyl/4PgxVx+Rds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fp86Av5bZ4NgRgV9+e0QGaLapfo1/ooXZMuePQHdW+Q5hMQO5L5i5sm8g+iiKu1H11r35Jb8mGpuBVf0NkVNAUNM9CxLyxmWF67Q+Ez/tyPcRYSwaaIn2Ldvj15qw+Bbvm8ICpS1zmycqIalFN4HdlFZB4VuvL+c8jfH/w6xrQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DAmb5gv0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722421105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+NI98OckWfv6J2NFyowBM8d76asTvKwKn+KYX73y9eY=;
	b=DAmb5gv03bWtgVsdU/zKgC4hooFvaYWoIm5mQQiQZSpHmP1vN5e3o8SMNVF0+tEY7S+C4I
	4iEIzcRVgfpgguncLkFti1RtPtOfI/V7pVX07mz6OQgsuJugZMAKpfIRuCNocqd90fYdQJ
	zd0VrglZQEd04QyqjBB7MYWWvPLVA8c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-dH3hm5SgNvy4ag3YKk0bFQ-1; Wed, 31 Jul 2024 06:18:21 -0400
X-MC-Unique: dH3hm5SgNvy4ag3YKk0bFQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a74845546bso5309500a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 03:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722421101; x=1723025901;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NI98OckWfv6J2NFyowBM8d76asTvKwKn+KYX73y9eY=;
        b=GZp1S70rSDkIIHVU7P/1v6OFEHYHzPIR1MY5YQgIO0n14xGlnkf+ZaI4Y/JymjO2pk
         p0TbLozkta/WKZTDcrCqc6MO2LAc2/3t87etRqIyAsAnJkvAMZHkbbOFSQ5W2C6AiKZ6
         xxifmjo8z7T3Sttm/zWY9qHBycUsEPpWPLO1kW29znN8v4wPpXSHKaUjFsrEjez0MKeE
         R3GX1U2Bpi4C+VPwAXd7NN6Kh5jTMBAie/ZuKcEf690KWPI9TDl7DQ9eKvp5uQIcv+lR
         AA4/oF4aT+DzfmpkQGSa7ngLUu1VObNHJ5nNnSeo/bJ8X5ytb7bl7STp+UqRCLYKxXzm
         QAvw==
X-Forwarded-Encrypted: i=1; AJvYcCVx0mUkUxur6WO5dxKUqy34GqJvhmUc+jGTXnG/45kd1KFyhcfx/0G3zJOHw3+ugW6BU24jZLFpWxwFTfKegXSkGC+wEqdsCAFomm1/
X-Gm-Message-State: AOJu0YzU00zzyQtxDHHLJGUOGjRa6cleJrbYAFUTOMMRjAnZ3gTiXjn7
	hfy3PNgH5d2QMXYYgKY/oa6W0I/hqdEVBB45MbmPnxksYKOEGQr32QDB7iW2YAsfKiGj63KZ093
	aIzGUGE0SFQeHH+dYdPtH8dnFdwp7sUTP1Pm8OrLxDwJ+3VV0LAXJJRs+3hTG4Q==
X-Received: by 2002:a17:907:3faa:b0:a7a:9f0f:ab2c with SMTP id a640c23a62f3a-a7d40087cdamr1036565566b.29.1722421100744;
        Wed, 31 Jul 2024 03:18:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbiyRYwcc7mzxbNr2j9CKiWLwtYHnw4iXERZ6Q+gmmNAwBwkH3zd03419QU5BCHgaYtt01lw==
X-Received: by 2002:a17:907:3faa:b0:a7a:9f0f:ab2c with SMTP id a640c23a62f3a-a7d40087cdamr1036561866b.29.1722421100197;
        Wed, 31 Jul 2024 03:18:20 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a7acab52d51sm750409766b.79.2024.07.31.03.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 03:18:19 -0700 (PDT)
Message-ID: <a76a83de-5dfd-495b-904a-878e1483e5f6@redhat.com>
Date: Wed, 31 Jul 2024 12:18:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 48/84] KVM: Move x86's API to release a faultin page
 to common KVM
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>
References: <20240726235234.228822-1-seanjc@google.com>
 <20240726235234.228822-49-seanjc@google.com>
 <96df1dd5-cc31-4e84-84fd-ea75b4800be8@redhat.com>
 <Zqk72jP1c8N0Pn1O@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Zqk72jP1c8N0Pn1O@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 21:15, Sean Christopherson wrote:
>> Does it make sense to move RET_PF_* to common code, and avoid a bool
>> argument here?
> After this series, probably?  Especially if/when we make "struct kvm_page_fault"
> a common structure and converge all arch code.  In this series, definitely not,
> as it would require even more patches to convert other architectures, and it's
> not clear that it would be a net win, at least not without even more massaging.

It does not seem to be hard, but I agree that all the other 
architectures right now use 0/-errno in the callers of 
kvm_release_faultin_page().

Paolo


