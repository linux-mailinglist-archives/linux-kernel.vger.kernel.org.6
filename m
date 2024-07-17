Return-Path: <linux-kernel+bounces-255173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B03DB933D11
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30081C23505
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CA41802DA;
	Wed, 17 Jul 2024 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VM4+2FV9"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387B31802CB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721219846; cv=none; b=S5f32EgsWvrdI3+zx+zfMOV3eBdYWk4dWU34q0f1/bkVQOsxRJhxgQ0/ElXWb0o+tib+UoaYS32dVNup+lJmDrexIlI9eEiTh/hksJkfOJ1i+CNjMbj/LlkHpPyHyzSKKmgK6MoZEzykIcmwO4pY4FdyduBExXX2JaTLyJFAe9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721219846; c=relaxed/simple;
	bh=To2/88cJct93m5DNCzgnvI+zTkRftsfNkfDd4QTg6OA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EObkTBcmoP6VbiZehpOUwB9jBaXUxZc5u5Qxg+PDRxRyfOsbUd8DZMhxW8UNPP0LDsTVzqsUMraM5A2pgxTTSQXiFsPeV6XyrYW157XBFpSMGvdnfmAYVjPQcaaskreUUfGcwqENdMtnIKBihVrW8XM5c3XTrn3rvMLQos7uN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VM4+2FV9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc418f0ea8so13382255ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 05:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721219844; x=1721824644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zb3PLWqlVsgK+FIPxtuluf3x1Y2KTw1JLlOu4g5CyyU=;
        b=VM4+2FV9fMHh5YaNccpsrhqUJ7OveqPy8hHlYMFsGZf9vuu8p/lGZw/KP6D5ku3oRB
         izq3UXuFRK5ERHHTVsKZxjFBOynqUFws2enyY815y4nu/gWxGquVwlbrJUbiogmCkpKf
         NO0Y9OwygBYKuCZdscO/R/yBmz2P3aTbZkD4hHxPlr6nbByKLIkKh7ujQTeBZ2vvDHj2
         AmE+cM23leur6kA22rz7M9HIBCGEq5933GU2QaNedzZOhprxeLMdOXuruPskOfamLXQD
         sRZ+ETuyk0nMhMIWGLEBcXKroIWc7+vltm2AdgT/m3pV3qROf6BWQYFteLUn8fklBWLo
         ZxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721219844; x=1721824644;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zb3PLWqlVsgK+FIPxtuluf3x1Y2KTw1JLlOu4g5CyyU=;
        b=lGBYa5OaQEAP8ilzddjWsVrahsnzb5ImZUAbAE/aRZVBKL48WQKB/zABzXvX8cv0nn
         xC+TU4pwg1YknjUgB8dlR5UNUqAcLhjYHhbzeLOSLi6QiAIZmhSpklILaSJvWoKFNvQT
         nGGkYVI9q6fYCu2S6Vm+f9kJkYzSPCu/kMKOWp0Nal7qGsqeVPq44pv+0i9YdxU1XQ7U
         bcXmCFRjJEwiPUFGEWfEtdOUGBla5J3WN50FtVf0r0T4F8rUyrf4FEtqJXrN7bfssh3c
         gPjzq/BQdeX1zmuWJxJYklGwS0DsRmzpZ3bCMom7Qf+P7vMdFgoYusE0MB+rKF4j7igZ
         P/hw==
X-Forwarded-Encrypted: i=1; AJvYcCXvRGgk2G70/GwtxzxcKtCrDDFPx36G2ub0Euh5n+5jPIaMhUcx2wQ37qZ+rtDr5R2xw0Ix7MbkWX006Yjk8yyqywTe0X4HUqcLBOah
X-Gm-Message-State: AOJu0YxLxQ5NHt2e4gA48GzBCR1cgdoQlCE6RxzS5/muA4gCBarCWehx
	3a4v28OWY0QMzxa4zogFrEbtOYCQkU4VTeAsWXw+VyBs5/xiJCOXSRRTIZTdtr8=
X-Google-Smtp-Source: AGHT+IHCwlsx4HLIweHhT/PTyl598burR9i+myX8rWZmT+eOIIoUNkbj0CGW/oAT8ES84SxAIF8TdA==
X-Received: by 2002:a17:902:e80c:b0:1f9:a074:b82d with SMTP id d9443c01a7336-1fc4e13f3c6mr15553215ad.22.1721219844498;
        Wed, 17 Jul 2024 05:37:24 -0700 (PDT)
Received: from [10.254.66.151] ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb6ffd3sm74280635ad.55.2024.07.17.05.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 05:37:24 -0700 (PDT)
Message-ID: <866f9ea0-b472-41eb-b5d3-59c0894b6fa6@bytedance.com>
Date: Wed, 17 Jul 2024 20:37:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Remove cfs_rq::nr_spread_over and
 cfs_rq::exec_clock
To: Chengming Zhou <chengming.zhou@linux.dev>,
 Vishal Chourasia <vishalc@linux.ibm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
References: <20240716150634.21247-1-zhouchuyi@bytedance.com>
 <Zpel7oyBNTpkLiPS@linux.ibm.com>
 <9b0b69bf-dac0-457d-a4dc-4bea18eecc43@linux.dev>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <9b0b69bf-dac0-457d-a4dc-4bea18eecc43@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/17 19:25, Chengming Zhou 写道:
> On 2024/7/17 19:07, Vishal Chourasia wrote:
>> On Tue, Jul 16, 2024 at 11:06:34PM +0800, Chuyi Zhou wrote:
>>> cfs_rq::nr_spread_over and cfs_rq::exec_clock are not used anymore in
>>> eevdf. Remove them from struct cfs_rq.
>>>
>>
>> nr_spread_over tracks the number of instances where the difference
>> between a scheduling entity's virtual runtime and the minimum virtual
>> runtime in the runqueue exceeds three times the scheduler latency,
>> indicating significant disparity in task scheduling.
>> Commit that removed its usage: 5e963f2bd: sched/fair: Commit to EEVDF
>>
>>
>> cfs_rq->exec_clock was used to account for time spent executing tasks.
>> Commit that removed its usage: 5d69eca542ee1 sched: Unify runtime
>> accounting across classes
>>
>>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>>
>> Acked-by: Vishal Chourasia <vishalc@linux.ibm.com>
> 
> Looks good to me! Maybe it's better to add these to your changelog.
> 
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> 
> Thanks.



Thanks, will do this later.

