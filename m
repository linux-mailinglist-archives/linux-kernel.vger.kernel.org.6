Return-Path: <linux-kernel+bounces-201161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70B08FBA96
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6116CB28D35
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C72814A4EF;
	Tue,  4 Jun 2024 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPOs20eu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20CA146D6E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522233; cv=none; b=nE9CxmxaLxoaJG0JVIDTxnI7zLs4abVgbjL1iV+FRby+tErokYWEV9EJXevunZatvCm+mVq5gXYhrInrlT14zaSYzkNVU/Ro/lF47Es2gYZEkHmJH6VyV3b2bl5H2FREBz3C4mRueCEYCv53/A0s7BdG9mDcPMpkmB5ijojRDcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522233; c=relaxed/simple;
	bh=wPLeSDOvdCECXcFpAN4ZDJ3MlHpY5M0TsqlTmyIL1Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SusrS/G6ldlMz0aT5rgAUPYgw34ruwh0plM6JsRXbtG3d17e4qeM5+ku6b5cFyU0wWsDXelmVhWmWPWnLL6KIz5CuOaJkLmWZBG12VKcpzEqW/stoFUzf3hZPlEku44J3i6jcxFDljqOpolfyh/bPk2hp4LtJHNFHhTRs4kE3k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPOs20eu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717522230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Ymw5zXDic4congoakqXbMR2mGlryQF0NO8XZGs40oY=;
	b=jPOs20euN/2usv/MtpH/Do5osRoA1zu25VeTP5zC38cLqu3hqDjHOY26f1iJ0eNtmWssvW
	Enfz8ZE9sGaRQFoZaGoi5HbrrCZcV9hWL+n8tBmYPQ06SB8TAUqHKz+tfT9IstWPpMakL1
	i1nl0XteqrO12/a/tzP14XhyZXWLEMg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-y3csJvHFPZ-QhliCX7bYzg-1; Tue, 04 Jun 2024 13:30:28 -0400
X-MC-Unique: y3csJvHFPZ-QhliCX7bYzg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a68f654dc69so146451766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 10:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717522227; x=1718127027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ymw5zXDic4congoakqXbMR2mGlryQF0NO8XZGs40oY=;
        b=ImvOQz+Ko2tP2sHuK31/sCTiZIH77La34onbq2qfDgAjOiNlnR7s3f5bA7udKMu9SN
         wZXhnVk3DBaTkCNFX18iiopETToP7klubh2+W1GDVfC4CQ1uRhmUbK/B5C6kzUWjiysI
         BURDPP8ho/hQq/sl/ADyHzXyvvkBbIRaCyZ6MNpFJI3X1VC05r0Ylu7BuPfF6/fnEuka
         1JbqLE6PZa0V7CU5Jm67fh5S4lcj+P5Zm8coB1jHnmh/AziBKVvzcwcBu/JJtMgkCSjQ
         PxJ2I3KTvfNTkrY1y0kD5kjgWaGvn7HH2WWi7lWdDlDarZ95hl2QuklzIn33cZzFwPaw
         68fA==
X-Forwarded-Encrypted: i=1; AJvYcCWJDHgHyuV0T9PaSjD2bITShw+tmsgY4v2snq7tiEbqTUURCV6Oz7oZCe2RcQtix1wlSd1guDAfVHnAAg4okL1RlBWscoFD9mF6Fc39
X-Gm-Message-State: AOJu0YyMD0QEzGypYQAW/Lpsi8SAEqPdarep+Z05KXGJOqKXIAtydVMc
	nKQ2sNQ3sd1DxyEU6hlfs7yry4aqhBL6USOUg8gcgT1UxtP3RTjy6cMmDnq354gsMmN2kdOAL8r
	yXsn+qwjMv47dtry38bpR9KLdtC/LH3Lf6jFOx4EwDb9Z0NH2YvoNdGvtCUaRgg==
X-Received: by 2002:a17:906:79d0:b0:a66:19cc:167f with SMTP id a640c23a62f3a-a69a000e331mr13083066b.59.1717522227366;
        Tue, 04 Jun 2024 10:30:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0ar9GRGBnY+hZrCfLEQSve+fGeR8qjjudoxWp43R2pMbqvRAKs1C9heXH+rYJnXPqGJx2jQ==
X-Received: by 2002:a17:906:79d0:b0:a66:19cc:167f with SMTP id a640c23a62f3a-a69a000e331mr13081166b.59.1717522227015;
        Tue, 04 Jun 2024 10:30:27 -0700 (PDT)
Received: from [192.168.0.161] (host-87-11-37-195.retail.telecomitalia.it. [87.11.37.195])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a69089e774csm325115166b.8.2024.06.04.10.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 10:30:26 -0700 (PDT)
Message-ID: <245df412-42f3-4a76-894c-b3481661f7b4@redhat.com>
Date: Tue, 4 Jun 2024 19:30:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] sched/rt: Clean up usage of rt_task()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Metin Kaya <metin.kaya@arm.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, Phil Auld <pauld@redhat.com>
References: <20240604144228.1356121-1-qyousef@layalina.io>
 <20240604144228.1356121-2-qyousef@layalina.io>
 <b298bca1-190f-48a2-8d2c-58d54b879c72@redhat.com>
 <20240604123745.71921f39@gandalf.local.home>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240604123745.71921f39@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/24 18:37, Steven Rostedt wrote:
> On Tue, 4 Jun 2024 17:57:46 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> On 6/4/24 16:42, Qais Yousef wrote:
>>> -	    (wakeup_rt && !dl_task(p) && !rt_task(p)) ||
>>> +	    (wakeup_rt && !realtime_task(p)) ||  
>>
>> I do not like bikeshedding, and no hard feelings...
>>
>> But rt is a shortened version of realtime, and so it is making *it less*
>> clear that we also have DL here.
>>
>> I know we can always read the comments, but we can do without changes
>> as well...
>>
>> I would suggest finding the plural version for realtime_task()... so
>> we know it is not about the "rt" scheduler, but rt and dl schedulers.
> 
> priority_task() ?

rt_or_dl_task() ?
rt_schedulers_task() ?
higher_than_fair_task() ? (this is bad haha)

I am not good with names, and it is hard to find one, I know.... but something
to make it clear that dl is also there becase rt/realtime is ambiguous with
the rt.c.

-- Daniel


