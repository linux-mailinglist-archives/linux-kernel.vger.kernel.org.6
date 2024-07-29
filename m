Return-Path: <linux-kernel+bounces-265339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B59DE93EFC0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ADFD1F22CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8318713B290;
	Mon, 29 Jul 2024 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KGsu3Q1D"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB6328B6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241246; cv=none; b=U85NPmOcKkhCpX6XN/lA3r4YHceboUvjUZK+k/a3MsW7il3KGOqaDt97XyR1YIqVGzkvXJHBUCgscenBPirg45sZCXR71ix28PryPGPcN55sxWJYnny8QNb3YSKGfk5sukNSCVWxQQRJ5DIh7w6Y/0gF656BVvVD/aor/ERLqEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241246; c=relaxed/simple;
	bh=Jc/yDwLVhh3gMXsJFU8w96eM1E2mhjBwq3UMMwIXeEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVQDupjQudUcgd7gdZ0addUMU/7sXAj69wJY+G5WP3+ZbxbS7IRywRnDeeEI8XfBMQ+XRnZnZh36ih/A5tZPwOCMR72Ln1r04RL/u8KsewUaiwPzKLxKHKjB9NNqL1QeoW3r7qKN2+3YdnlEgJBBNxOuSLYhEG4FEbYmB3P6ufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KGsu3Q1D; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso2685846b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722241244; x=1722846044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+pFeZ4P48tvuzIG9htyZFnSY65PVaQA4nh8ph0/3WI=;
        b=KGsu3Q1DoitDtRI5wwtnQ4Pfhx+n9cYY9K6eeqd30TzA+pr5pcXnR9V/0MjfRWBP68
         43phB5hJ0bEYtj49hx5wu0zngkOcioGNvc++9jBWA0AjmsHNbafVqoCZGCHBqUGPEMW0
         KkXTqZu12+jZu6AYZOcEL7sXZCZF9k2PnijJSp1uWz2VA2eFxEd59tJ78oQrHlHLSX3v
         GjaW4+JOL4UneMbUi/6ODoj+qQRrydJy3AL7LfcjfZrvcXVDMj8nFRxC/fxOUWghKi/o
         TR889UUX3gBF84vSTym9U0fn5Ex6herid1HqbQn8hFzeazjaMbEOXz0c4JwAUdEphJbc
         15Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722241244; x=1722846044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o+pFeZ4P48tvuzIG9htyZFnSY65PVaQA4nh8ph0/3WI=;
        b=uGoQN5h253K+l9cs5jvgxd17L9ScXmiLs13zH0ymyBDt3R5l1mGCFCjMi7Q1KUuOcI
         /9b4YJlf61fpHD8bX/HCFAAtI1fu++QmlfFC7K6pZolTofNJfotbxrU5RovAQYJGN86Q
         bza7en6H6x7z1lOwrWkqRSeT61BK/C95+VoEMnVZs4xTPBB+qzyjbntjhU/cjrqqMNX8
         fEx5HLBZ+538a/7vD3yi2iVGsg5qnSBYrGFw8W/5BXoay+4pAkM3fKtWeBQm5aJIBpuf
         p88B4Z/aCdZ0u8BvpS+2aSNPLgEIUjHsViH04Xvn+lP1/Qxix1ZguXvAFm2iTpqrUq//
         bCQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU98BytoOHGgt8fmwLUTQm9+cQMyOcbvsdyJPlFXwqRK5Tkhso5P+ahMUov66DRMB2+cCb0GCQ+45HvlKj4llR7TP2atO+MHUVnwb8W
X-Gm-Message-State: AOJu0Yy1IeFxeE8h5Qq8pRbSScHXWCN9o7BC50VI2hbik85r1CWjLwQ8
	OSnfjIbqjtDkeTkpw+SEqW2X+ZR7FKcCKD/UJRJ0XvyqAu0jJ5JdINWiCXEnVLc=
X-Google-Smtp-Source: AGHT+IF8OFIsxCPdlzvvitOC7co3heWIrbXTxI9wgY1iu2ZGXp2d8MMe6XuAJl+7obBXvepYuV5xhQ==
X-Received: by 2002:a05:6a20:7289:b0:1c0:f751:47e9 with SMTP id adf61e73a8af0-1c4a0e0401fmr9948651637.0.1722241244443;
        Mon, 29 Jul 2024 01:20:44 -0700 (PDT)
Received: from [10.84.153.104] ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d37b9asm76986385ad.114.2024.07.29.01.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 01:20:44 -0700 (PDT)
Message-ID: <ce019e81-7758-4586-b54b-1d9e078f9ca4@bytedance.com>
Date: Mon, 29 Jul 2024 16:20:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/fair: Sync se's load_avg with cfs_rq in
 reweight_task
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Cc: chengming.zhou@linux.dev, linux-kernel@vger.kernel.org
References: <20240723114247.104848-1-zhouchuyi@bytedance.com>
 <01e68be1-dc49-448c-9338-70ececd0bec7@arm.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <01e68be1-dc49-448c-9338-70ececd0bec7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

在 2024/7/29 15:56, Dietmar Eggemann 写道:
> On 23/07/2024 13:42, Chuyi Zhou wrote:
>> In reweight_task(), there are two situations:
>>
>> 1. The task was on_rq, then the task's load_avg is accurate because we
>> synchronized it with cfs_rq through update_load_avg() in dequeue_task().
> 
> Just asking: That's the dequeue_task() in __sched_setscheduler() or
> set_user_nice()? Maybe this is worth mentioning here?

OK.

> 
> [...]
> 
>> @@ -3795,7 +3816,9 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>>   		if (!curr)
>>   			__dequeue_entity(cfs_rq, se);
>>   		update_load_sub(&cfs_rq->load, se->load.weight);
>> -	}
>> +	} else if (entity_is_task(se))
>> +		sync_entity_load_avg(se);
>> +
> 
> IMHO, the 'if else' path needs braces. See
> Documentation/process/coding-style.rst '3) Placing Braces and Spaces'.

Thanks, will fix it in next version.

> 
>>   	dequeue_load_avg(cfs_rq, se);
>>   
>>   	if (se->on_rq) {
> 
> [...]
> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

