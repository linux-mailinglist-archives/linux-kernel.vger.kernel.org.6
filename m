Return-Path: <linux-kernel+bounces-444810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD059F0CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12BC1884FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DEA1DF97A;
	Fri, 13 Dec 2024 12:58:46 +0000 (UTC)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB6C1DEFEC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094725; cv=none; b=eeH5cVAKZwxYHCOYz75fTxdjesbURWqnZqbujIHpZ9bisbi3YRB7DO8UKbnxn9IW5eRYCYbvITlWt9c8EGIyWiQWgXcv1Oum5Tjl4k/qdmXjzl7wM/VixbtsDtry4oyiSD/073uI3p/YLLynHXRGv8SaDrmzPVH/7OvukDM0HTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094725; c=relaxed/simple;
	bh=6h6jjY3T5AxQ8CPWuFFwmeKkjENfWUoUvb41TaKM3xk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CBxVeaO2DxBG0HPwhl7xb/0IKtyZEmZZh0S3CxCA6nIgoO8Wq4cEqGyyw6KHQNNXccL0huaX+CKKFO1Nle8nPN3sW6fjfPQ9S/nNylDeanSa4CQapqGVGPL5vPVCQ7GV3r1xoS+uI46EkTkNIg/RdeDJGYeMVP/yS33zFAyvgWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43618283dedso16233315e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734094722; x=1734699522;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVdkiN2S3nVz88SBGrHYN0y/4Qu6+jvQgegsjjfAeN4=;
        b=wuihxaIO3tYGOeHvu03DUQIo80C4ZgU4pAlUN4A/XbBvTRk7ceD0qLJjHRH0FNt5kd
         BkxjXBPEP1lgNjxRIU7zFOMHAPHAJx5zB5ae9KWNdcmwoy9j0VfC8Fk/t9FeaMGmxUfd
         07fylqfHlV/r9bxKfGvXYVYDjCImGChkh1hfVu8Fxrgf59IRArk0q9D9HCIOrdItQyje
         PHvvC2hAp3mz5VCIosKPjTZsX2/0GxwfkpMNbm4hYgm44eYqBi7gwaWTF6cdjufwLqzI
         1GyCK6LXDX6Gkd8stLWRHlrzJIWPBIYWUDvflDwtIDzDK+OwQPdexzNEsng3l+r5gaNb
         /hZg==
X-Forwarded-Encrypted: i=1; AJvYcCX6z7u46Ze0dyQLy80Vx5e6s14PmZhCXkzH3AOdG3K4CRruK9JPBTlGDCSI+sHGJEI0Ha69RpdeIMa8cV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu35WFYAL7YvyHALWdohnxcmVtlLKdz0mymZaO6/P2JTv6Bbjg
	ioiLQimZVjr2zGBzsT4eXhft/X/ylTjT26+hHq7IrNbdtqm26rMf
X-Gm-Gg: ASbGnct8Y9xrC1jWfhqNWbhBZXg0tZbF6BR40gQO4bbw6IDDntQkms7/n3qUjL4UqKN
	EwAp6wBQJiDh1HkwftojfNvAussMBY2yiC2LXWau9kqWCtygVoXoW+WTKS+M/97ETHzS4VBp3kO
	Yu5XaZ91T3l2GmpC261j21XcMZoQOIf+2lLbCFeJEQJuXESY8lvJ/adlKKs7hrKCavtCQqqrX/x
	yu+VSit/TsU70XUQo+mI1ktDa2tZl9Qbui3ibM7qxxOLD+aaI93jmNFOuNqzTYyvhj4LYYM56j9
	MJ7Agc2VF57c
X-Google-Smtp-Source: AGHT+IHjeHE35qvXsXf5lUsQ/X1rVThH29OVVJwbXY+JjhUc6TytgST0nPR/hluw7Z1nH3aehgJCBw==
X-Received: by 2002:a05:600c:b86:b0:434:a90b:94fe with SMTP id 5b1f17b1804b1-4362aa39a2cmr26432855e9.10.1734094721772;
        Fri, 13 Dec 2024 04:58:41 -0800 (PST)
Received: from [192.168.0.13] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559ef45sm48437055e9.26.2024.12.13.04.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 04:58:41 -0800 (PST)
Message-ID: <20023e07-6287-42be-8753-7759f6dfca7f@ovn.org>
Date: Fri, 13 Dec 2024 13:58:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Juri Lelli <juri.lelli@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Joel Fernandes <joel@joelfernandes.org>,
 shraash@google.com, marcel.ziswiler@codethink.co.uk,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/dlserver: flag to represent active status of
 dlserver
To: Peter Zijlstra <peterz@infradead.org>,
 "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
References: <20241213032244.877029-1-vineeth@bitbyteword.org>
 <20241213125147.GC35539@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20241213125147.GC35539@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 13:51, Peter Zijlstra wrote:
> 
> 
> Thanks, I've invented a Fixes tag for them and stuck them in
> queue/sched/urgent for the robot (although I don't expect many
> complaints from it).
> 
> I'll graduate them to tip/sched/urgent if nothing comes up.

Thanks, Vineeth and Peter!

FWIW, I've been running the version of the patch from the discussion
thread for 50+ hours and didn't have any issues.

Now running these exact patches for the past 5 hours and didn't have
any issues so far as well.

So, even if a little late:

Tested-by: Ilya Maximets <i.maximets@ovn.org>

