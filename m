Return-Path: <linux-kernel+bounces-256143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D47E9349B7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF512853C5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2121E768EE;
	Thu, 18 Jul 2024 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TunnX+tv"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D771EA8F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290826; cv=none; b=bytEHoRvND3zv8sW+j1GRgAX+lIK67yWm+hrPjb8q67pS40GfU+Om/Z+l22t942m7hQX6MF6DyEGKIPA3jmZ0mmFgbZGGI2AQehKLym64H2r7rpGNpVUKnZYKlnmB0tXq9trLLsab3cfenoakUltHsGAHq5Bh4xjCO9owMShHcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290826; c=relaxed/simple;
	bh=wIlP3vxYiZQz7DlYZptBzAkZ0z2V/MpBSpUcwowUwI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1YEOUpdJtkYXATa2lsjsS4kxrv9unGmFaLK33c2xB3YXMOMuCF+m2TFYU4qaIVaEwtBdGEHCS9Cy8f2Qldm1h73KiMUXE43eaejyrDI4grQuxFvP0k43UHW15qlNPoxJ05D4LxAAhuvEoZBH8MfQq34oajzyBJccxIf3eaEDJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TunnX+tv; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70b31272a04so1115327b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721290823; x=1721895623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nI+gUtWsEz/D3kTb323tMNCV4WxP0ZMUHl9M0eK169c=;
        b=TunnX+tvma9ooG4X1STCh0ldKkX2YbMqNWK5qm4wPPf7Heqpb3LIPnU1ZrgmGJFZrP
         tThgKXvzYlV4I4lau2Tkb0fg48znXl+OWCnHBjGDAveeDBwkcsjI5gPY70OH2YWeHPQa
         Z+pP2MCmpv0GVNF6G2U9adfB5FYZQRsbNkaPG1x5UaxG//OKxM6YCAjfKspAcSBr3Lf0
         KzWWX4dA8IWHw3SncK64wtHdjjbwHH3WQXJu1a3FIOOkipgDHgkzAZ5RcrPRxDqMLH4G
         fd6v/tJ+2FQSw8A2TSRj42FU9Hu3xqoe3DxTpc0UMocR1ZE594n0MKDN40VYg5zpjY4U
         r3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290823; x=1721895623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nI+gUtWsEz/D3kTb323tMNCV4WxP0ZMUHl9M0eK169c=;
        b=IrXKdKd8AKgN6E5ZoMvO0iHZFSe6Sv/dG9H3kBanZBahEstr8Fm5YngJXeS6ideDG7
         AbdXvtMCU3E8rk67sjFapwfXoQAUoQImhWEW9e3M6sM8tDPRQg2MbSgUBvEn2FSvCffY
         9SF83RoP3NpmJnH1HpxqknZqa01zOfnHG3/1BJcDeJxoxei5Zt2Dsj5El2HXkRc/A9At
         riU+Xu0sm5AyS6ZelVwF4XDVcwRhM9v6tNG4mHT+wd8HjcdMhPXQrQoibhjmXReW6aRi
         jyPanLpeud2xZ4S4RtX1++qDXHPrmDNR3lwJs/9OE6llFNdxv/JdyQMILhrSQwuJ9z4+
         ZSnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUHSxpZE5PKFyY1ORP7CeaXC+XDmTbNoKNKaqlxiAohbQLZMhQ/eouDdIpnhS4X/ErSevWoVxfIu/LM7OSYLzxyZ9xdQnz3Oxm5oTE
X-Gm-Message-State: AOJu0YxNxAcFzJOeMUpLHiNHNS3ThWEzaUtECJx8afGSLIe2vwbhXtUi
	82Ki4FSXB7E/SaUbR2YdxFK54sIWcA41XRgKK7ThHZVJKbmRTYLB/lPV7a1+Coc=
X-Google-Smtp-Source: AGHT+IFVGxfYd+I48xnoJr+z3ji7t/hEk8/u2yRWsUsWw3N+vaibv/D275yGj4hTzWYQOV/2ZYjhmQ==
X-Received: by 2002:a05:6a21:6d92:b0:1c0:ebca:964b with SMTP id adf61e73a8af0-1c40791f2ecmr3758686637.23.1721290823441;
        Thu, 18 Jul 2024 01:20:23 -0700 (PDT)
Received: from [10.84.154.236] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e386d7ad4sm7227399a12.69.2024.07.18.01.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 01:20:23 -0700 (PDT)
Message-ID: <d39bdb5b-6f98-496d-8e14-eef123681519@bytedance.com>
Date: Thu, 18 Jul 2024 16:20:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: Remove cfs_rq::nr_spread_over and
 cfs_rq::exec_clock
To: K Prateek Nayak <kprateek.nayak@amd.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: chengming.zhou@linux.dev, linux-kernel@vger.kernel.org,
 Vishal Chourasia <vishalc@linux.ibm.com>
References: <20240717143342.593262-1-zhouchuyi@bytedance.com>
 <3a2efbd7-075c-2a93-0ea7-51566362f17e@amd.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <3a2efbd7-075c-2a93-0ea7-51566362f17e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

在 2024/7/18 11:28, K Prateek Nayak 写道:
> Hello Chuyi,
> 
> On 7/17/2024 8:03 PM, Chuyi Zhou wrote:
>> nr_spread_over tracks the number of instances where the difference
>> between a scheduling entity's virtual runtime and the minimum virtual
>> runtime in the runqueue exceeds three times the scheduler latency,
>> indicating significant disparity in task scheduling.
>> Commit that removed its usage: 5e963f2bd: sched/fair: Commit to EEVDF
> 
> scripts/checkpatch.pl complains about the commit description style here.
> The above can be reworded as:
> 

I will send v3 later.

Thanks for the review!


