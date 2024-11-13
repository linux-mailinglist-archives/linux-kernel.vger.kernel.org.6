Return-Path: <linux-kernel+bounces-408028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF0B9C7918
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10A6285875
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0B71FBF63;
	Wed, 13 Nov 2024 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4UlMaER"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC152309AF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516150; cv=none; b=snBpq3qQuXS536LklFbcmt1TgWUk0MWysSjmZUYkGpLhqjBQ3E0LfV1tEt8o8rDiNo07CvP2lBKRb7KVs1M4WS4/US3SodOB8jKvfy8cylNuXsxulaB2BJYh7ooN0sp3hLB20XVT3GOnZosHZ7kmb8lVnCdubfbxq45MPZNDTXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516150; c=relaxed/simple;
	bh=06AuL1t5SxzpsWna3tKpXpi4dmGvZ4g957HKiDaKnAs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PX0lyxte4umVjRicuWA5i06ZGcg/kO25/KEN8R8CIite/q7ZPqkfajRmJcFgZUSAqP7Z5aRNaM7L0FKAW7x0hXYSbWQm/yIqa/iTA65Rglk/32DDGYCivgXOLk/6i7dB5zPmGdsYvOCRNKAClZh1DkyIO80yEUBob8FyqHRkn3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4UlMaER; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731516148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=06AuL1t5SxzpsWna3tKpXpi4dmGvZ4g957HKiDaKnAs=;
	b=D4UlMaERcAKkLYy5jTDIcSVyEKCGbs7vSp2tHH1sNU53r+WC/lQ8fGw+35+ytPslAHQkhA
	jun/FlSMMWhkQIUELayelf0/pdSW7c+QhefZ84sV+2DlVRGa/Y2FwpA9SyH5daCtqJLvp9
	c7Tn2ZwhZk3Jx5IJqsqapZvSBrUm4JU=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-FRocP6COPjK_9VzmvES_JQ-1; Wed, 13 Nov 2024 11:42:27 -0500
X-MC-Unique: FRocP6COPjK_9VzmvES_JQ-1
X-Mimecast-MFC-AGG-ID: FRocP6COPjK_9VzmvES_JQ
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b7974696so84720325ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731516146; x=1732120946;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06AuL1t5SxzpsWna3tKpXpi4dmGvZ4g957HKiDaKnAs=;
        b=RYryWjREm8qgszoFIugLBcrwN4EBQwaMJMqwO490PaiaGTCqQR+fesq7tYpioN2CRw
         49caidX0hG3TFIEbwcy3nvfFcZtN6XvTKKBR/Z7loTcFEU3bYG7XOyiyoBvKepyeEVpv
         7PNocnfPhaW8I7iowEinu/OQZWiCr9sEIy6+PEDxLGz9rhJq0zikBaxUREUgdRfO9GLQ
         wHNdlCsDzO6P3Cvpd/28mEKTIl0wEqVUHLzQ+WWJm6rsRbQvzG4LC8uOBOsB8YPRHSAE
         jsL5zbEmJeUOViB1TMwsf9X/D+wg0tGjNMv2MUD1oBb0EfTnUPbODC/Y3Uk1AMlo3lDt
         9tFA==
X-Forwarded-Encrypted: i=1; AJvYcCV/Rq9ywECOwal6ZsFeddy5/wLGUTo7zuwuBd3AVzaBUZKzkXVElHmgdsTu3w/8YElQ/mIiDdPfCWiCIac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzObQgdNQd6dERUJ/nF1avt3lpDE4CnOV3FKrtNr55UobARMlAe
	YnBhLM3HbDBKoIH92yZVj2Ppmyrxc4/SwDSNeLywf7xetx2dwezDx+/ESGyjYBf3HFR3qkNj3jP
	gSGSOgYpmahEkT8nXLirn/Y7nDg/AS3SOcYcVw6xv4iPR7fnQztNBC6Nzi9/JLg==
X-Received: by 2002:a05:6e02:1886:b0:3a4:e75c:c9d5 with SMTP id e9e14a558f8ab-3a6f18d894cmr192853765ab.0.1731516146238;
        Wed, 13 Nov 2024 08:42:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUbIKFahDMQG8rFZFHphfEkZG3wiNYQDEx1w6j+e2DRXkWnNHOwvRmePXoBiCQQRiblgvtUw==
X-Received: by 2002:a05:6e02:1886:b0:3a4:e75c:c9d5 with SMTP id e9e14a558f8ab-3a6f18d894cmr192853505ab.0.1731516145943;
        Wed, 13 Nov 2024 08:42:25 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de787d7051sm2902209173.85.2024.11.13.08.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 08:42:25 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b7c75f06-1ab5-48c4-b2fb-521508f20f9b@redhat.com>
Date: Wed, 13 Nov 2024 11:42:23 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/deadline: Correctly account for allocated
 bandwidth during hotplug
To: Juri Lelli <juri.lelli@redhat.com>, Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Aashish Sharma <shraash@google.com>,
 Shin Kawamura <kawasin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20241113125724.450249-1-juri.lelli@redhat.com>
 <20241113125724.450249-3-juri.lelli@redhat.com>
 <8e55c640-c931-4b9c-a501-c5b0a654a420@redhat.com>
 <ZzTWkZJktDMlwQEW@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <ZzTWkZJktDMlwQEW@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/13/24 11:40 AM, Juri Lelli wrote:
> On 13/11/24 11:06, Waiman Long wrote:
>
> ...
>
>> This part can still cause a failure in one of test cases in my cpuset
>> partition test script. In this particular case, the CPU to be offlined is an
>> isolated CPU with scheduling disabled. As a result, total_bw is 0 and the
>> __dl_overflow() test failed. Is there a way to skip the __dl_overflow() test
>> for isolated CPUs? Can we use a null total_bw as a proxy for that?
> Can you please share the repro script? Would like to check locally what
> is going on.

Just run tools/testing/selftests/cgroup/test_cpuset_prs.sh.

Cheers,
Longman


