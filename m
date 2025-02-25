Return-Path: <linux-kernel+bounces-530577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDF7A43542
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755CA188B0A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DEC25A2AF;
	Tue, 25 Feb 2025 06:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NO9IHf6m"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926625A656
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464980; cv=none; b=q3c2rQzeaG+CSqRHCjt3gXBVqCX461qYpUCyEA5nqUnoFhBgWBlyPSL/Kvz2UIHMf/wI329Nbx9Uj2mpUa1RmIulpp1N35N3fM6NkfLaSjSJdV/Vx0bG2lZhr1P9TK76e/bRR24H0Hh6u+tx6Kn7kftsQLUq94u86UsTPw152NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464980; c=relaxed/simple;
	bh=uKuBlokBvPGBuN/aA3ShwwrScxXjn5dY6lPoWkH0Y64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8Diln3NoXb4qcGoTJnbj4AOCGPP3SrPKUHXsGJKDlyXqO+/uE8hXuA9o5zkCTWtPvNiIDgM8Lrh7Ce5gvkMagw0jNURN2U0C7iRAON0P7wLjeK7HTBmVAolmIh4UpZfUwovzgZCwJOTAwF1g2D9ZHiIs2k17/0YkS+WYk7bx38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NO9IHf6m; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2217875d103so12072855ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 22:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740464977; x=1741069777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6z/8+91nHat9ckEqgr7u9U4KjYLG/s10VzX3531Ejw=;
        b=NO9IHf6m+Oyk46V34G74MZEVu23sgGUYL7KqgTTkvb5ahkRCshrhJU34o7znaGoEJR
         vylEpX2TnK2UMLueG9BB/QLH9Ba1m6acceCjG13QAJEtSfEfgyv9EfYIf4DsGhBh0uo3
         /tYC9U5L1LeLXLnBy9q3P2gbmmi1aSeo1xBFA479+0AaByHhJX+qr76YVKAWRH+O/H9v
         5ozVY4JV2ItP/3NX+JFyzkUcFTeCjBg6Y4siTkQFGH3ukGgvX6FNvjAhAw+jfVERbGnf
         T/0rlVlVPEoXiOqYlwlq98hVSkCJizDZA980Npic2wVnDxc+RBbEl3S/sNZORsI4N5s4
         ojMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740464977; x=1741069777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6z/8+91nHat9ckEqgr7u9U4KjYLG/s10VzX3531Ejw=;
        b=jw0Ks1t3BCZN11zTqOPDlwjoXTXaY0SvcA/ruIt5kgf85j91p0tMg6g1BNCmQ9IsaW
         u+/fIi+WcvvGAXto40aeuZOTOWkKQkSnReeugfWdZcu6RTJctt1nsKjYow4qhXRZtHDG
         LA3yKasO8lMjJWr0SXYDIKpGOdSO2ZxDPk9snK/J+XC8CwPd1AYziifzLjdWCK5gL3kd
         Wr5JLgWITseCPig1U5PAoumHKyj/gWgHJjU3g+B3DfqYYYBvsK9g/m+1mckFt1etejef
         OuI3Givo4y6r9e9XNY6OJs1mJrXl5yJMQAdACgZ/+Qw3MTFrNvz3rf+SyUQop0bALW4K
         8ZsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE5jmR5V1UFYzW0Nc6hVcB1XFGXbuAZIf4UOz1tiax737oHloeqxjlqraiLqV4Kx5A4Q5ZxSCI32Zpg88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQOGNAoJ7zXEG1R86wbZ7HcnfGbqt63tUJaIGWs7eysxkqwXRE
	I7RAx4hbvxXgEnLsDuH2nlJwagqLXCeI3S98AennUgfaVGJ0TESrwMtcYDRomEY=
X-Gm-Gg: ASbGncv8hE8rFZvNQ60vPh6sx0Al1gUanEa3U4mg4ySFKKjiURXqMn2/8jVDsJvPWyz
	PAB/JPtwo+4BkUs1Sx60LgrTNyDaMkSdlAYWiDYTmezz8UhtUPXUiX+LQ+xg4RHnySsYs1RwJQU
	S5iTl63dm8Ie9BmRw+xvN0Vkv/J/w3EJyw9VnrkqUADgMR9T6Prdyae9rrdhRibTkPOnMfs30Y/
	8TvE9vcIozDZbhaXHL/IvkA8MYGW/LaEjkAwWt5aux5Vi1j9ISGQvykeRDWnScD729FF6ZU+rB7
	1mVoF27VaLcmqFcprjriiIb2pKyoptANj/FA2azBLb6lQodSLPQ=
X-Google-Smtp-Source: AGHT+IHp+WTVqTQ28yaZi771O04yQ4aN3/6wJ/pB4pphXxS3ZSUNqRwvlD3gBEb/+/fcfdqAfPOsIA==
X-Received: by 2002:a17:902:cec6:b0:220:d71d:4666 with SMTP id d9443c01a7336-2219fff855emr99523615ad.13.1740464977368;
        Mon, 24 Feb 2025 22:29:37 -0800 (PST)
Received: from [10.254.176.198] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a000874sm6675515ad.24.2025.02.24.22.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 22:29:36 -0800 (PST)
Message-ID: <ffda0c9a-0794-4080-921f-99f0c31e2d6c@bytedance.com>
Date: Tue, 25 Feb 2025 14:29:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 2/2] sched/fair: Fix premature check of
 WAKEUP_PREEMPTION
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Josh Don <joshdon@google.com>, Tianchen Ding <dtcccc@linux.alibaba.com>,
 "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <20250221111226.64455-1-wuyun.abel@bytedance.com>
 <20250221111226.64455-3-wuyun.abel@bytedance.com>
 <CAKfTPtBzsX6GKZP_NGTONrkp96qx9uOHr0+XG7tC6ELy4tbHBg@mail.gmail.com>
 <6097164a-aa99-4869-b666-9dc7018c1f96@bytedance.com>
 <e1cfabab-1326-4cd8-a8a4-4b3fc4c1f7ec@linux.ibm.com>
 <9d9d7432-9a5d-4216-ac53-a0f333a35d8f@bytedance.com>
 <d1237acd-9e3c-4ab9-8628-31d98fcf7638@linux.ibm.com>
 <83f8b833-af79-4d77-a179-5065aec994dc@bytedance.com>
 <CAKfTPtBL4aPbEDOa8jJ+h2wQ9CLU80=0mQdrc07vfqBVswzAsg@mail.gmail.com>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CAKfTPtBL4aPbEDOa8jJ+h2wQ9CLU80=0mQdrc07vfqBVswzAsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/25 9:47 PM, Vincent Guittot wrote:
> 
> Or we should just remove it. I'm curious to know who used it during
> the last couple of years ? Having in mind that lazy preemption adds

TBH I have never used this feature. But since Phil mentioned a case
in debugging DELAY_DEQUEUE, I think we'd better keep it, what do you
think?

> another level as check_preempt_wakeup_fair()  uses it so sched-idle
> tasks might not always be immediately preempted anyway.

Right, thanks for mention that.

> 
> 
>>
>> Thanks,
>>          Abel
>>


