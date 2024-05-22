Return-Path: <linux-kernel+bounces-186086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D06E8CBFBA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A6B1F23884
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC798286D;
	Wed, 22 May 2024 10:52:08 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820AC8249E
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716375128; cv=none; b=XP7rpEMJ1TfGwN19Ey0KNxwEs6+PyXNN15It348OoI6ZehoHhc7hCKOazOjM+hQyViNYimgWpT0Rwad603PjNRHiKm0yyMdQHp8HtZZwSyyyTH1ObUk5CRm6zQBiozCxBDpdBdqXJA0IWdvwWSBpbPuenShtYubob9TTVY5qiyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716375128; c=relaxed/simple;
	bh=Gfe1zauU7zE0SZTCKbwkP1teRyttZxutx/5efnInLmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJlSnLU63pLGj9motzKwkw9mfspz9G+PObjf0eGcYc0+Jq0R1r8Nrbf81Mox3xRdzkvc4U6NRTuHv5oZcuZ4gJzA9yCLW1bHJZYfrvA9Q+ydqwpVhBKmMfuGQNqwzFl1rnVQurQbnaBwpt6JQlY5sCRxvQ1mu4fG02p2kB8WROA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-354cc708ac9so166263f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716375125; x=1716979925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n56g6uLn9XHCQVlQi59pqGIFNFw6rViiab33YGUq9tI=;
        b=n6dinq9Oqd7+tPs81JBk1EkK1UZIaCmmZ/VtTZtQ6C+ZmLKJdZMSfpDa3VyLFpKS3k
         Xk4zSBs0kGi0lpdHQgFXNBDBhpRbkJF++v5jfqTFQdSrkv9XM8ipZZo8vpf5rLVdqFw/
         p17GmP3jF+LIZkTy3FFp60aqiCzYOstXo8dAEpRpPvban2dP0u8d3ynWDUOH9g+D3t0A
         1WfuDozfuNsUb9iQ9Ztro4GcHhtZZoGwE2x4MlCyv04VQX5c4s3cJ448FRWIkH+8fxwj
         ddUrDN4yTxnlv+PaodjfNDJ3xAKPi3cstr7vfsEz21hFLiseo1ABUwduT0Rw6W6qv3Lc
         iMAw==
X-Forwarded-Encrypted: i=1; AJvYcCWnJzqjdhslpwDn6eiT4JHNhtoAbDqRb2s6CjhvQND+Qm8k76wTnYxVF7ohso5jEIYKCtGGBgingk08kdSRCcOlm5RPVk1PgeU92EO9
X-Gm-Message-State: AOJu0Yy3XWpecS4aEmN87oU/iKPqStt2D0TtmhG3FOwmBoEiISa/ibTn
	vLB5PDeOJW0tJY4DUfLYgTnC49SQL7KcHK2cWVMAFxnaWY4bSMDw
X-Google-Smtp-Source: AGHT+IEZJBgVSrF/9DB5H155p+7sN7q4DxBtkVsX5am/DrbLl8psEfn4k669Y88n9u6iZh/wjeiBXA==
X-Received: by 2002:a05:6000:4021:b0:34f:42d5:1897 with SMTP id ffacd0b85a97d-354d8d8de53mr1418462f8f.3.1716375124688;
        Wed, 22 May 2024 03:52:04 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbbf9esm33855151f8f.91.2024.05.22.03.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 03:52:04 -0700 (PDT)
Message-ID: <b4302ee2-584d-48b1-b0fe-77035879c15e@grimberg.me>
Date: Wed, 22 May 2024 13:52:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Nilay Shroff <nilay@linux.ibm.com>, John Meneghini <jmeneghi@redhat.com>,
 kbusch@kernel.org, hch@lst.de, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <945416af-3f8b-40b5-9681-49973beb2cb2@linux.ibm.com>
 <3b8d33db-f2c3-469a-bfa0-8fc52594f243@grimberg.me>
 <95fe3168-ec39-4932-b9fc-26484de49191@linux.ibm.com>
 <da35bc8b-6813-42c8-b446-8a07b08db156@grimberg.me>
 <073ae18a-a80e-4a95-a093-36210a3bb230@grimberg.me>
 <ba2a6973-ba58-492c-9785-31e50ab40957@grimberg.me>
 <8f5ad047-be0b-471c-a708-f2bc464d29ef@redhat.com>
 <b3ea2812-1110-47f6-88f0-0e9c028c350f@linux.ibm.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b3ea2812-1110-47f6-88f0-0e9c028c350f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22/05/2024 13:48, Nilay Shroff wrote:
>
> On 5/21/24 20:14, John Meneghini wrote:
>> On 5/21/24 06:16, Sagi Grimberg wrote:
>>>>> Exactly, nvme_mpath_init_ctrl resets the counter.
>>>> Except you're right, the counter reset needs to move to nvme_mpath_init_identify()
>>>> or some place that is called on every controller reset.
>>> This however raises the question of how much failover/reset tests this patch has seen...
>> I has received quite a bit of testing with failover and controller resets.  I shared some of the testing that was done at LSFMM last week.
>>
>> It has received enough testing to make me confident that this code is safe.  That is: it won't panic, corrupt data, or otherwise do any harm.  We believe the error paths will not be affected by this change... but I agree that running the error paths could negatively impact the accuracy of the nr_active counters... which could lead to an inaccurate outcome with the queue-depth policy.
>>
>> I agree the nr_counter initialize should move to nvme_mpath_init_identify(), or maybe be done there in addition to in nvme_mpath_init_ctrl(). I'm will to make that change now... if that's what people want.  I don't think it would require any extensive retesting.
>>
>> /John
>>
>>
> I think with Keith's recent proposed patch for fixing io accounting on failover, the
> nvme_mpath_end_request() would be called even for cancelled IO and so the nr_active
> counter shall be adjusted correctly for cancelled IO requests. Having said that, IMO
> you shall consider moving initialization of nr_active counter to nvme_mpath_init_identify()
> as that's common function invoked from regular controller initialization code path as well
> the reset code path.

Yes, and preferably with a comment explaining why its there (despite 
having nothing to do with identify...)

