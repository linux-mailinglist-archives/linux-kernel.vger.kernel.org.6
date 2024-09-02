Return-Path: <linux-kernel+bounces-310482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0983967D9B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 03:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E60B2825E1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 01:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68548224EF;
	Mon,  2 Sep 2024 01:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvT2hFL6"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2B6225D9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725242022; cv=none; b=AFRFvInt5gu2/rh0usABXR1p6LjG9byGUEpSSko58TmYr9GdxvUuQ8sXDCkA8lD+UN6un6EIufO+Hhq/uLCccf7692A3+VzP88FeJEYwEv/7bVHyFHFvbqcFN6/fQuwwEklGPW/yobinG1zNk7KBspOvS04lBeTum5KpLpT/Gkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725242022; c=relaxed/simple;
	bh=5KPqX+tLpiHuMvd0pv73RszLlE08Sy9qvpJ4tsDQnrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrX515qhv5+WsrsB4TSRinKrxYoxkLifjEuV57yCd/XoNvn5ri+n48WmIELTVA0/Ra3LarctcX4HYtg0VWs1JxPCyHDeOGnSGoBBgEUFvRVVX3pmNekqLkFRnDFp/s9AddTB7qbn4PlFucjZCOgmKB52Pa8Zad4B//qvuo4jqtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvT2hFL6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d8a54f1250so667701a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 18:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725242021; x=1725846821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fyP5aDz0R/gRER/agXZOL8jT6PaxganlgaLK4Ts88cM=;
        b=mvT2hFL66C68yUHSPRSsRYgI3vso7Wl+Jmdz33OMKP8hTWGfDaE1rK61yq2hKtl1lG
         Y0B5mAFwVyIXVM+z8YZcjmhj/hAqupRfAXnIdOz7CVpoCd6z0Y4bNIL5O12etQ2KlC7o
         E3NiWMOv9yOs0Oi0I8uV6Ohq5Ic64vBBVJaOrTnMsp3p+hPD7/Fl3jVQ7LyLac7HkCJV
         ucDvMYtzIx0lQPZOUeI3YCOY6e4OXwG3oOfF2OZ5iVWJIyWRBZHnaMgaCa1gE8NPPi+J
         FCsfmQPr8sZa3a37sf35/I1l+IyHsIRg5K0wPRClCA7lbLjHFnF+xNpkhWJz03IukpmO
         RLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725242021; x=1725846821;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fyP5aDz0R/gRER/agXZOL8jT6PaxganlgaLK4Ts88cM=;
        b=fe3ruKAJSs+ZoIg8YLZSFtQt2/wuZIhXGxmYEouxCYmGkgQbqUxV8MvJpG2euDn7b8
         5LRim8uCfWfciLQm2MxSbRInwuriGlYEhFK+o7j6KlF3x8DG+THVBqaKNHgbwRpZvDBi
         fN6HWZzbIsIJJMKacgnGeKnvqiL4z5zYe1JtpD1YyUQefQQXCH6bwqCFOwp3zDhDEKLJ
         riBvMj+WSiRaIm/8DCmS3a03YE1S72vWZn4OeCjMeFvxIK0aSWvsNvL7wYblPTWydn1m
         GUaNPKxoO5cngy0VHK13ICKIqREMZ2xojcv7q7h/5hFdrZ0bz4kFMCnizDq0LSl2nABs
         jOqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYze6Mp3MC74NTl1TbN/yf+8SshDGo4pO5CV5noFxevGrnTfizT18vP+FNp4t+8UIGTansSWzPsmDDYrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFZtm6K34ahMyshnKchGDJPDxCHY4xi6CCNqD6h7rbpL5NmHMY
	KA5bmbTWPCbJT+0RqTS4u5sQFc1uHrAXKILyrf39jubTE4ajl6sN
X-Google-Smtp-Source: AGHT+IHvBYdMun9onEhBNHM/CPJ12VzBY2PcBvi74m92DhN8bO+iMuO2AG0YvlPSW/AXSYBPdpR/Tw==
X-Received: by 2002:a17:90a:eb88:b0:2d8:8bfd:d10b with SMTP id 98e67ed59e1d1-2d8905ecf1bmr4861340a91.26.1725242020400;
        Sun, 01 Sep 2024 18:53:40 -0700 (PDT)
Received: from [192.168.1.6] ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8aba505bfsm2695080a91.8.2024.09.01.18.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Sep 2024 18:53:39 -0700 (PDT)
Message-ID: <fbca5a6c-d1c2-488a-a605-7403aa7db21e@gmail.com>
Date: Mon, 2 Sep 2024 10:53:33 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] sched_ext: Implement
 scx_bpf_dispatch[_vtime]_from_dsq()
To: Andrea Righi <andrea.righi@linux.dev>, Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, kernel-team@meta.com, linux-kernel@vger.kernel.org,
 Daniel Hodges <hodges.daniel.scott@gmail.com>,
 Dan Schatzberg <schatzberg.dan@gmail.com>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-11-tj@kernel.org> <ZtMpIb38MSn5r4-U@gpd3>
 <ZtNC6l9nUEPnneag@slm.duckdns.org> <ZtOH1YlEgyP45UkU@gpd3>
From: Changwoo Min <multics69@gmail.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <ZtOH1YlEgyP45UkU@gpd3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24. 9. 1. 06:15, Andrea Righi wrote:

>>>> +__bpf_kfunc bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq *it__iter,
>>>> +					   struct task_struct *p, u64 dsq_id,
>>>> +					   u64 slice, u64 enq_flags)
>>>> +{
>>>> +	return scx_dispatch_from_dsq((struct bpf_iter_scx_dsq_kern *)it__iter,
>>>> +				     p, dsq_id, slice, 0, enq_flags);
>>>> +}
>>>> +
>>>> +/**
>>>> + * scx_bpf_dispatch_vtime_from_dsq - Move a task from DSQ iteration to a PRIQ DSQ
>>>> + * @it__iter: DSQ iterator in progress
>>>> + * @p: task to transfer
>>>> + * @dsq_id: DSQ to move @p to
>>>> + * @slice: duration @p can run for in nsecs, 0 to keep the current value
>>>> + * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
>>>> + * @enq_flags: SCX_ENQ_*
>>>
>>> Hm... can we pass 6 arguments to a kfunc? I think we're limited to 5,
>>> unless I'm missing something here.
>>
>> Hah, I actually don't know and didn't test the vtime variant. Maybe I should
>> just drop the @slice and @vtime. They can be set by the caller explicitly
>> before calling these kfuncs anyway although there are some concerns around
>> ownership (ie. the caller can't be sure that the task has already been
>> dispatched by someone else before scx_bpf_dispatch_from_dsq() commits). Or
>> maybe I should pack the optional arguments into a struct. I'll think more
>> about it.
> 
> IMHO we can simply drop them, introducing a separate struct makes the
> API a bit inconsistent with scx_bpf_dispatch() (and I don't think we
> want to change also scx_bpf_dispatch() for that).

Dropping @slice and @vtime would be cleaner in terms of the API
interface. Some use cases simply move a task from one DSQ to
another (e.g., from a shared DSQ to a per-domain DSQ).


