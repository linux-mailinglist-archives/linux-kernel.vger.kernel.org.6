Return-Path: <linux-kernel+bounces-259555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B9893984E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 04:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED2BFB21C06
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 02:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556A613667E;
	Tue, 23 Jul 2024 02:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="E8uWOK+i"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11961E868
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 02:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721702082; cv=none; b=NG8+JU755XgVjWl6GjFhIcP0wVmLRpv78dNpxHQOOZFlcigirWnr07qNDwEknafsnJdLi/Ly+53Htk6nwH4q6PFjJUvyhNYpVfcNxz/2RKoh2bjyLjRYbjpOAguXAisNDmFlzoIHBMaDAqoRzpRw5eVzycXe0xqVYTkoj4vijJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721702082; c=relaxed/simple;
	bh=Xf2qaICEkVFol/IRycYECKAnAfSiyh8wckcQ2xuAwx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SL6XcxUyv1hb8ZWJQkiEK/lsrCgiS9AKVVY/JJS6zJH5Esk9pMzQgtVbnbYI7pH2VflOXkXK0jOolFdXAw41GN1mbzUNSSutrPznx40vU7fkbH+ZgrhnTWh/s4ShSHUhrXGE7ZboY3cZJ63Yk+cbarwjhJp+TjQQVDKaKfdEGsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=E8uWOK+i; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d9db222782so2947994b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 19:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721702079; x=1722306879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fxg5S9t12mtoHWzkaXa0+YedOQYm1qhgOmIpE417iWE=;
        b=E8uWOK+i/nUjrwDw6Ok+NZpukI8sqMD0AC4tXp4JAjChAnwoDiX5+gcYKI52iQ6XyR
         H5Jlf/FMPd9tjSFpN6PDfNCas9WW+nnoD5FiYwR9w6FYHrks/6Y9tHb/xmuRq3ipMink
         t1TEGALyxWXTP+nYLOgQ3MKtl4SZzCmVjzEgBU5Tx6a13wsSMYL01XfD8pBKSKvoPwXa
         22mBI3K92doVeE6te2g5XHqRaCOTDrBlQE739HR7R84YNTmQ0eY/HENXDzvMge/2Td7D
         hilxaYkfh+Eju0v1Df/3+qzch0hbfzsT/9Wxc1DlJG9crcpTnWzSA+fBO3kBeESo/M2v
         4USw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721702079; x=1722306879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fxg5S9t12mtoHWzkaXa0+YedOQYm1qhgOmIpE417iWE=;
        b=QTmnX0CMW4eYEBiDtJRMNaP6EXA2qCh6RV7zOnbF7l0JRvETLYIwF61ViLoEKqboCo
         j873rbB3+XbsDNbI2cp9ukVYOj09AJq2to1x3dfmlVPPRO2fPBWV4/RoF3sFIK8V2mpE
         qFUo+4d4y8qF4Q81Mj4ono9BDoJpQbEexLgBcxmiRf4TA1XNWTjjfbez8iQ7hDgYGXlq
         3oqlVAKxDjGNJGHJwXPUs/f1XhIIpu+xFSw8mnN2kuN4FeE/NbICsFFAOZqWqQbnXwdA
         UQWjCKS2hF7LcNHpk0DnQPIlocvV+mCPDUNGjEj3fsPI6wqh+0iOgBD0rYcd0UJzR3VZ
         gt+A==
X-Forwarded-Encrypted: i=1; AJvYcCVaUzc7TsqYIRTieGohRCapEGkE2vtQpK5BlkVgs+Bw7vbiw6PeA3BtIYxFfa84G+jAadPmfUs7LgpaAaPKfyxP7Iz1PM2Jt3uhP0+3
X-Gm-Message-State: AOJu0Yy7PAPjf6KeyXO68UM/NEn7H4HEQbwRcNaLQ+vGJcyXQE5hGh0R
	w5WxTuVPvwGu29RHCp5vUYfkFiVda/uKschaTDg6wP3VWnBhjmWbr8xKhOoQbs8=
X-Google-Smtp-Source: AGHT+IFVxJeuqpQKkZlTndotd4MS692L2bU+9kdh4fyjBEbzmqwZCi4RDaug6Q7Y8Wvb9064L3f14w==
X-Received: by 2002:a05:6808:189a:b0:3d9:38ec:3d42 with SMTP id 5614622812f47-3dae63977c3mr11025073b6e.49.1721702079554;
        Mon, 22 Jul 2024 19:34:39 -0700 (PDT)
Received: from [10.4.208.146] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0a3dee64sm5350555a12.15.2024.07.22.19.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 19:34:39 -0700 (PDT)
Message-ID: <afc464cb-1d47-48f8-b56c-59f4c7b92eef@bytedance.com>
Date: Tue, 23 Jul 2024 10:34:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/core: Avoid unnecessary update in
 tg_set_cfs_bandwidth
To: Benjamin Segall <bsegall@google.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 mgorman@suse.de, vschneid@redhat.com, chengming.zhou@linux.dev,
 linux-kernel@vger.kernel.org, joshdon@google.com
References: <20240721125208.5348-1-zhouchuyi@bytedance.com>
 <20240721125208.5348-3-zhouchuyi@bytedance.com> <xm26plr5ysij.fsf@google.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <xm26plr5ysij.fsf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/23 06:24, Benjamin Segall 写道:
> Chuyi Zhou <zhouchuyi@bytedance.com> writes:
> 
>> In the kubernetes production environment, we have observed a high
>> frequency of writes to cpu.max, approximately every 2~4 seconds for each
>> cgroup, with the same value being written each time. This can result in
>> unnecessary overhead, especially on machines with a large number of CPUs
>> and cgroups.
>>
>> This is because kubelet and runc attempt to persist resource
>> configurations through frequent updates with same value in this manner.
>> While optimizations can be made to kubelet and runc to avoid such
>> overhead(e.g. check the current value of cpu request/limit before writing
>> to cpu.max), it is still worth to bail out from tg_set_cfs_bandwidth() if
>> we attempt to update with the same value.
> 
> Yeah, this is silly of userspace, but we also do the same sort of check
> for shares, so sure.
> 
> We do need it to be inside of a lock though, multiple threads could
> in theory write to the file at once. Just move it down inside of
> cfs_constraints_mutex and that's fine.
> 

Thanks, I will send v2 later.

