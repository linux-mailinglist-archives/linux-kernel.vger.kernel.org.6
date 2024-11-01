Return-Path: <linux-kernel+bounces-392291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8329B91FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7810284E42
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FA119B595;
	Fri,  1 Nov 2024 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g0Qan6nO"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1344D168DA
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467687; cv=none; b=GJLIgkCn7NPmlWl9Ezw2hsVupXoULd0Zi71YXCYl7aFYz4SZRjPtWCqFl0VDm3RMhiYCxkuR9pgWIBM48QEuZ5kxV/Kc7kiNVFDLcfYy85uhWmHio0btatvJf9bEucSVVK8ESHBm9sjFzMcdk4HgKcO7IYlw8mj6t3lGgKk1YAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467687; c=relaxed/simple;
	bh=aKnunhQNGkbFxu3tpoPPwaFfkOFrxlKJiaYeDYx8j4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRvNFXLFjgpimCISs4FyC2KvgrqePkSxHyn78iyEZViYlAlUEqHAAXSgIVuiagk3L/FqHimjThzbbIx/4N6ggluoePu2/9EqGpOW6EXZqDtoqR7B/HjDZHM43y7ricswqMeMy2jK4Obz+YX249uRHR95PisnAfQUSf9nmVQAJAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g0Qan6nO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99f629a7aaso316317866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 06:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730467683; x=1731072483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7IPe6J0XouRhja9jovBmbBp0WbnhwjBFmpnKQuywTw=;
        b=g0Qan6nOOQjd7miTQzQYulvrKqlVR7mbs9U2dQw19ht+MgrqpxoEPJzn26e37BcypX
         zPOnJNCRpWoNfJnv6Fh7E8WbAdBN6Y7yu+8eJFnUgSZHEedVQrne8EReSRnSA9lte9+V
         uqGBg9BncTDwb3O6VOLYqw45O7EPPvKCuUlQovJKSHiSsc+2azPCO9+lMBHXGsqIu5rh
         alb1JBqNujpDUvhCFdfraymCuyet+DYaO7JUUrJegH/bGExRZeUEB89tYkYejDLEPpNB
         MyD/KYAdw+WYorAYmHNW7h+7/xQgnMXcp8MWuNU6AUsdNsexyo177moaMyXsfFyRNbKp
         cyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730467683; x=1731072483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7IPe6J0XouRhja9jovBmbBp0WbnhwjBFmpnKQuywTw=;
        b=R/kF/kjGezrcWq2MlgYpmcwlVHffVrVoGGAxI1WOifh9PszdubOGZJQ5uBlb1w9beB
         18eS3NqVVitz6GpC+VHe3Ue8/3s6hGsThl2bZlYnCrgr3GuEYRNNivSedm1bcrzR6vhG
         +6n31FpVHR0oZvI6KmskZo9Pid2ig4MEOvhC5Cm5zQJJYPsm78RxXk/1kmhglhkBvtNG
         14HHnuMQYbelV8vAhkArK0c068l30S8E1Dak5RA5CIwPeZFUjNUbKO2wky7b+2eDLlSb
         ZUJkWlF/Sp6P0Wl+E8GPmCWgXkAvzRuJEVGmErYPmgJIdSah0qTeDXCaHuXK1Fa5+deR
         pUBw==
X-Forwarded-Encrypted: i=1; AJvYcCUnOoF+SKVd/8IAfjH39eoLzD2HnRk9HMyjcpbwzBMrpGz/wPVMdrMzSwSHQsmGMGoxFhK0F7nQX4a1YoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzymcVBnws4ltaFaGSAG6Gy3kF2otbe9nwzoAvHJpIDalLh+7HW
	P67H4mmIkqIFjBE77EwvX7AmGmAOt6IZNdyUe9pBzjNGqdREaIdgXqYicTN9swQ=
X-Google-Smtp-Source: AGHT+IHjBlIzk1T1OigPtqH0JpYx9GMUyR8/T5/k82f9nEsie8ENm7j2/lVrdgJjpJDhjvnX8HAz9Q==
X-Received: by 2002:a17:907:9714:b0:a9a:ca:4436 with SMTP id a640c23a62f3a-a9e6532ca84mr329527266b.13.1730467683426;
        Fri, 01 Nov 2024 06:28:03 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565e0969sm178760966b.101.2024.11.01.06.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:28:03 -0700 (PDT)
Date: Fri, 1 Nov 2024 14:28:02 +0100
From: Michal Hocko <mhocko@suse.com>
To: Stepanov Anatoly <stepanov.anatoly@huawei.com>
Cc: Gutierrez Asier <gutierrez.asier@huawei-partners.com>,
	akpm@linux-foundation.org, david@redhat.com, ryan.roberts@arm.com,
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
	hannes@cmpxchg.org, hocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	alexander.kozhevnikov@huawei-partners.com, guohanjun@huawei.com,
	weiyongjun1@huawei.com, wangkefeng.wang@huawei.com,
	judy.chenhui@huawei.com, yusongping@huawei.com,
	artem.kuzin@huawei.com, kang.sun@huawei.com,
	nikita.panov@huawei-partners.com
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
Message-ID: <ZyTXYnbDfGYGuxlt@tiehlicka>
References: <ZyI0LTV2YgC4CGfW@tiehlicka>
 <b74b8995-3d24-47a9-8dff-6e163690621e@huawei-partners.com>
 <ZyJNizBQ-h4feuJe@tiehlicka>
 <d9bde9db-85b3-4efd-8b02-3a520bdcf539@huawei.com>
 <ZyNAxnOqOfYvqxjc@tiehlicka>
 <80d76bad-41d8-4108-ad74-f891e5180e47@huawei.com>
 <ZySEvmfwpT_6N97I@tiehlicka>
 <274e1560-9f6c-4dd9-b27c-2fd0f0c54d03@huawei.com>
 <ZyTUd5wH1T_IJYRL@tiehlicka>
 <5120497d-d60a-4a4b-a39d-9b1dbe89154c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5120497d-d60a-4a4b-a39d-9b1dbe89154c@huawei.com>

On Fri 01-11-24 16:24:55, Stepanov Anatoly wrote:
> On 11/1/2024 4:15 PM, Michal Hocko wrote:
> > On Fri 01-11-24 14:54:27, Stepanov Anatoly wrote:
> >> On 11/1/2024 10:35 AM, Michal Hocko wrote:
> >>> On Thu 31-10-24 17:37:12, Stepanov Anatoly wrote:
> >>>> If we consider the inheritance approach (prctl + launcher), it's fine until we need to change
> >>>> THP mode property for several tasks at once, in this case some batch-change approach needed.
> >>>
> >>> I do not follow. How is this any different from a single process? Or do
> >>> you mean to change the mode for an already running process?
> >>>
> >> yes, for already running set of processes
> > 
> 
> > Why is that preferred over setting the policy upfront?
> Setting the policy in advance is fine, as the first step to do.
> But we might not know in advance
> which exact policy is the most beneficial for one set of apps or another.

How do you plan to find that out when the application is running
already?
-- 
Michal Hocko
SUSE Labs

