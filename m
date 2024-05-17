Return-Path: <linux-kernel+bounces-182300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DACF8C895A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E848E2839A9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4979512D778;
	Fri, 17 May 2024 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdTt9w9a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2992412D203
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959859; cv=none; b=bcil16Hvu6MiOS92t7huzDsr1lu9MkTgMIZRSMVVM3pXsllOau4QNCsgfXkvMrggxWGSayQNI9Vil59BfFqGCT5WiMOuJfxfwWPhxbdhi/fHsbfhw6HbwiuYlNJmHg3Ca/dCrvJdUVz/mPheEWctb4s1DrzN8nB1sBNveX2Yo2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959859; c=relaxed/simple;
	bh=oscng7hubUk0pbg5Km/hVar1kfLe5//OlAe5GTYQFis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEUQv/RdCMlH69BgMxD1EK6yPVc3EktwRUODVRxPkKY5+7J2+Sd6Y21wdx+/zHj3eVNwcz2XcApcD6RJxGWK4Lbs7mkMkoPAkM332YI89UnfpB0gpm08U0XFErbMue8OzgshZxO9APYZBG2fUqNqRB/WmND6RrGyDdwbDNL25cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdTt9w9a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715959856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aFq04/L6JW/eUr0Iijo6T20CVRsDnVggIdQMSpb6ERg=;
	b=BdTt9w9aVdxw8gghxzNNfXrFBd58S06yleF165NE8EZm1yYXBYmjlOq4su5QyTORk4dmb7
	mRjrlthqxdHe+lpdczj10LRu7wEC1ABWtRU8CJVCCITVqcBQxnQnHKJx8+cKWqcuKCzICJ
	AXaliPcdi+mCeyoro2C8sgsCf8szp7U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-MFz5rTBoNDyYroQ9U61paA-1; Fri, 17 May 2024 11:30:54 -0400
X-MC-Unique: MFz5rTBoNDyYroQ9U61paA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a59c69844aaso541188066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715959852; x=1716564652;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFq04/L6JW/eUr0Iijo6T20CVRsDnVggIdQMSpb6ERg=;
        b=MtshnxOyCo5kCiptiIDOJI27Adm22t3HY9qvJ0JkUwOJEcWePvixL3WDRqwdjHse9i
         80kiqLA+g5s8KLlDQwN1O12FrH+AKuBmJEFTcr2iAUPO5+PU+BIV9uxYmP2yDtnHUh3e
         yGOWE6kwcDBNnc8AO04eLRvNCyLipW452nd3fPIC9OCRJO1/l3gYx5TbUH+GncSvVZSJ
         LxZewd/WkPdQCHIYfnAJCjKSBXJAtOsJezOW+pAh2e5em4HFnuRMqwkOP+1PGUzAgYv2
         V2mxVgdZUyCazPvhTGTeuiqtRMDoIrTlUvv/v/xUJgYnhfZ8RJM3hAnabAlh/fEUDi2y
         ZYAg==
X-Forwarded-Encrypted: i=1; AJvYcCXCU0CzAHGCBQGLbl7DO4rMbls0J9+7SsyXMJWh+jzfXCGbSOhzYLIaI9czRfAgFFEJt44YA8A5apDbiSvslu7UtdMeVNmKzwYSMWQl
X-Gm-Message-State: AOJu0YyaqeecMGi8mqXOwOdZtXotlVZ5zieNyeJ1atFGwgmiHJY0JUaS
	Q7HWKo4ioacgcnCKOk8pWKv72NnsJSPC30KU/fjOZNx9l21gP/eBsbfJPDodjleCTgj3r2A2a+G
	l08Syyzb0nJxqk34EjJnQZFfmk+65aWhoMtDMwLJBa7wTnqeXmgwYnizuovnDnA==
X-Received: by 2002:a17:906:1d05:b0:a59:c9b1:cb68 with SMTP id a640c23a62f3a-a5a2d55a759mr1601328666b.7.1715959852775;
        Fri, 17 May 2024 08:30:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD9t0MkoarZLjzEIqTUeL+tD1HnvH5GYALueos75VgC81hkYokcukSDCqIUCF40pqzjnMctQ==
X-Received: by 2002:a17:906:1d05:b0:a59:c9b1:cb68 with SMTP id a640c23a62f3a-a5a2d55a759mr1601326766b.7.1715959852326;
        Fri, 17 May 2024 08:30:52 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.155.52])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a5a17b17865sm1117591866b.204.2024.05.17.08.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 08:30:51 -0700 (PDT)
Message-ID: <7df9032d-83e4-46a1-ab29-6c7973a2ab0b@redhat.com>
Date: Fri, 17 May 2024 17:30:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] KVM: x86/mmu: Introduce a slot flag to zap only
 slot leafs on slot deletion
To: Sean Christopherson <seanjc@google.com>, Kai Huang <kai.huang@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 "dmatlack@google.com" <dmatlack@google.com>,
 "sagis@google.com" <sagis@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yan Y Zhao <yan.y.zhao@intel.com>, Erdem Aktas <erdemaktas@google.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>
References: <20240515005952.3410568-1-rick.p.edgecombe@intel.com>
 <20240515005952.3410568-3-rick.p.edgecombe@intel.com>
 <b89385e5c7f4c3e5bc97045ec909455c33652fb1.camel@intel.com>
 <ZkUIMKxhhYbrvS8I@google.com>
 <1257b7b43472fad6287b648ec96fc27a89766eb9.camel@intel.com>
 <ZkUVcjYhgVpVcGAV@google.com>
 <ac5cab4a25d3a1e022a6a1892e59e670e5fff560.camel@intel.com>
 <ZkU7dl3BDXpwYwza@google.com>
 <175989e7-2275-4775-9ad8-65c4134184dd@intel.com>
 <ZkVDIkgj3lWKymfR@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZkVDIkgj3lWKymfR@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/16/24 01:20, Sean Christopherson wrote:
> Hmm, a quirk isn't a bad idea.  It suffers the same problems as a memslot flag,
> i.e. who knows when it's safe to disable the quirk, but I would hope userspace
> would be much, much cautious about disabling a quirk that comes with a massive
> disclaimer.
> 
> Though I suspect Paolo will shoot this down too 😉

Not really, it's probably the least bad option.  Not as safe as keying 
it off the new machine types, but less ugly.

Paolo


