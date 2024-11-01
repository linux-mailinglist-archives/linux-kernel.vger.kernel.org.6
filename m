Return-Path: <linux-kernel+bounces-391827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FB19B8C1E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6CD9B2165B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11621547DC;
	Fri,  1 Nov 2024 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LnVgUeTN"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C162155896
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730446532; cv=none; b=DQTtjsrFh6GIp+8xov/2TxX+HgOChiXvw2wMOg2oEySUW92FUa7XBZN4ZoS1MG647PDlxnG0vqnkbP0f/M+y7ykv4BBZwb4zYOmC8kFe/4G+68DoDq2xIpy4Xj5UxFW4fMwueSBWbwXo4fwIDkhOAhmFD8SFRdvPyf4nxpObvlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730446532; c=relaxed/simple;
	bh=P0vFwttNHOzKZmv1rgw7+ANWTxzIN8kOgv/v0uO+NJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upv7ATwTnylicVIDGdMKZtjEtw01GXA44wHWPeuRhw2NUX/cP58QSO7kj80I+PUriZBVSPA/gLRWNTD8kLzghQfyp6pxBzfyZ4smvuK0r3qYlFJCZzVK+kj5H6gTsS/clZMwS7GNerhSrUbfU4NE5ATNZii6Tkbto1ysfLic6rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LnVgUeTN; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7aa086b077so196250966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 00:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730446528; x=1731051328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ypPJ1NrY2u9lPq4g9XmzWPa71sy3ELLPD5dFtuw86o4=;
        b=LnVgUeTNAwK+oAKDytaNNIe5/lQoAfSQZliGwe26vxEMuaMT0b1MQmSJ7WQjA64i5V
         YHiXZwFxtS5kIKdShi0j7ErtSt0lIzYfW1uB9Sk6MDyedQhuUJ5rmJMLzPu2CTvdibBV
         7dOzgauOWfG5EACivTBkmZ1fNdNivv2zjbum2Me3hkuczhzT3ztg5mmy5LYTIca+dP04
         dPXPXTXAFyINgVLDxZVSJO+pcq8+cPgbL+rD7k9uh2c5kcUByxRpfNzoI8vXwZJ7F6ws
         1CtiLQXwKHnx2PrQU42kUUa/iTklKMG4Fm19kIvT08cA8xKhJlEPoesdgoiITucPbXkC
         Opyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730446528; x=1731051328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypPJ1NrY2u9lPq4g9XmzWPa71sy3ELLPD5dFtuw86o4=;
        b=iT7xMz1l6Fm9u4A5x2z4P66yF/3ejYswVH6DbSDwM+1Bc2OAc3VpnRRu/JbPQ608q7
         tmOTQ4Yo+oA+XTsZr4sgsemdIUZKVV1jm9DV8b+nwdrTz+YRn47p8phRW15lWC3qvurB
         j0Mf8PC9d/XgaNQxAGXyzMRzChOOyqnqJxdt4yUN/T8MKxSZzNPKMasq+CnLQwYVNsB0
         tev2Or2GCoL1fE7cDRwvs+nANIWmlGWIFuT52DgP1UkTJ21Dm+SxzkfH4TSDWM45NpR2
         qECB6DUVXz6VSRT2pi/awoZbM8NNFJwVD+fGnS1JRILs2H34SSxLVJ4UIKtPOsNHGwLp
         h7Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWpM5mf8x3OEBvjpDoca3+rGTZ8ipt5rvR/M6u8+iWW/Hif6/67K51VaMi8C0R+ur/nQyxPMgBOhJivIhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2UammLQ0S9fiWfgabDegXDHmpJtg1O2oAAlWkNVF9KcBK3vD1
	kEfhH2q42r8iQElFXp1eEsBcBcWg5y1eHT7BRz38MopN1cNvGjFhjgPE+oKweQc=
X-Google-Smtp-Source: AGHT+IGE691V9XaGzpelyrEeM3zXC4X8ZhHOENA5a+Ka87tc9j22idhGt+6KNAt7B8tZ2d4Zag54Jg==
X-Received: by 2002:a17:906:6a12:b0:a9a:3718:6d6 with SMTP id a640c23a62f3a-a9e3a7f2373mr1127478466b.58.1730446528154;
        Fri, 01 Nov 2024 00:35:28 -0700 (PDT)
Received: from localhost (109-81-81-105.rct.o2.cz. [109.81.81.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564e96a9sm150993266b.97.2024.11.01.00.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:35:27 -0700 (PDT)
Date: Fri, 1 Nov 2024 08:35:26 +0100
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
Message-ID: <ZySEvmfwpT_6N97I@tiehlicka>
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
 <ZyHwgjK8t8kWkm9E@tiehlicka>
 <770bf300-1dbb-42fc-8958-b9307486178e@huawei-partners.com>
 <ZyI0LTV2YgC4CGfW@tiehlicka>
 <b74b8995-3d24-47a9-8dff-6e163690621e@huawei-partners.com>
 <ZyJNizBQ-h4feuJe@tiehlicka>
 <d9bde9db-85b3-4efd-8b02-3a520bdcf539@huawei.com>
 <ZyNAxnOqOfYvqxjc@tiehlicka>
 <80d76bad-41d8-4108-ad74-f891e5180e47@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80d76bad-41d8-4108-ad74-f891e5180e47@huawei.com>

On Thu 31-10-24 17:37:12, Stepanov Anatoly wrote:
> If we consider the inheritance approach (prctl + launcher), it's fine until we need to change
> THP mode property for several tasks at once, in this case some batch-change approach needed.

I do not follow. How is this any different from a single process? Or do
you mean to change the mode for an already running process?

> if, for example, process_madvise() would support task recursive logic, coupled with kind of
> MADV_HUGE + *ITERATE_ALL_VMA*, it would be helpful.
> In this case, the orchestration will be much easier.

Nope, process_madvise is pidfd based interface and making it recursive
seems simply impossible for most operations as the address space is very
likely different in each child process.


-- 
Michal Hocko
SUSE Labs

