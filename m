Return-Path: <linux-kernel+bounces-380213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE879AEA3E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885081F222F6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DC21EBFE3;
	Thu, 24 Oct 2024 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITv16AeN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FC51EBA0B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783301; cv=none; b=NwlJ5s8MoJUrKFYrqJW0Lw8HKrTi32iQLJG/aKeSFk40rSA8neMkBmFIyHDAZz7AD23T+9JeInwYU8VDfzKuxgbZdgnUgF+FJST6Z2H+rWURkNF5cufCo0WK43T7KrIhuY2wBE8EUVd5LQ8l7soJTEXd6TWpVSmvyll3KSM/2/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783301; c=relaxed/simple;
	bh=nW0TWG7Fc0VNjERMXMTr1agpaawOY2IgT9uj4bNwY54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYmjmieutwPAJFj5rSPJLpz+6z+KMlhVo7Wnrft9n0mJSiPShdBvsGTRKBplUjo7wQPrpJqDjbyJpCJ/9WhDt6z25O2o89B0MAKMWTJpTliCczTjz6yHkUDaU6O61irtiOCFWXomCmwA/+pCs+9z4pBMeNhwbAB/G3cMEF6srUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITv16AeN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729783298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qrw2RqXMP78nGKg8Lpv1jq5anNPyVA6VfKNmhQikqx0=;
	b=ITv16AeNu+x7if6/KKnajoyF+bKTTRvBJMxU2QsDBub7Av50fL3iI+0d4KwBI08TnLTyq1
	kRbDEgybed5pVUBD5toZuAIzVRc5huBy8wBemhNIThs0y79L3UrLLzpOLGQBtNP62UNMV9
	eSfeclV7sI6UcsG2BMhY8kE0rNW4yYs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-zcSTGwSfMMqBNbHWXjSEUQ-1; Thu, 24 Oct 2024 11:21:32 -0400
X-MC-Unique: zcSTGwSfMMqBNbHWXjSEUQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-460d8f8f5d4so16631851cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729783291; x=1730388091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qrw2RqXMP78nGKg8Lpv1jq5anNPyVA6VfKNmhQikqx0=;
        b=hl/4E4qqwVIMkUmIbM8EoHqS8RB9lj1fMyLwIzGeDABVWLzWOKwj5RCAPh1Yds6Cvk
         Sd+lmesVnCPC+7BFJN77eVMF4s9znfnyOsYnnqt6/kLGZdSRo8y2C7v8sbmhU05vjiQG
         FixMwjC2N9upDNHwvU2/zvaScZFJgC5dtBtRVQZzdjW35v7UHiXUz6CWpTXl844UvlGt
         jFblJoJYVOUwpO4FRsjvbHcND/Ur8Yv0pk28vDiVZzlR2eyipz3c//D5F48hqyc+roT3
         LAZik2fHffMMFoVA8mQN7DuO6QMlkVSfN0J+gwXN7pX7YS4U7Jtg1woPwe9QI/tloD5l
         0B3A==
X-Forwarded-Encrypted: i=1; AJvYcCWip63Gm/P8b9r0oxTuaNx/3ELPSSvjmZHRWFZpRi+vllekabGEkjf/ZvbkU56DAkBBkwfolLdzXjDj5pA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ7JVomoJzPqqrP5yfaGsYp61hzaQEEu4Io/0VIN+rpyhfiVev
	UEyxtd3R0Y2JZ8werW2oD92rR0mZ7+v+1J+oLYOJ94Qef31iRAufofwRjEO3dow/zpknAV+wsSu
	OgUSWm2gocBSAB7OZkdITyZ060edFOk+CtcPwAwf6ziL3wB9laoJhD6Q3qFOcSYIiyWXJLw==
X-Received: by 2002:ac8:498c:0:b0:461:2bbd:f96c with SMTP id d75a77b69052e-4612bbdfa90mr11593131cf.6.1729783291634;
        Thu, 24 Oct 2024 08:21:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENeP1TLULS4yPvQaHG4+jzlT08mwB6uRKJpkFnJDnX+eZo+AoJiFHON/m2ibWFVUzxSQuMdg==
X-Received: by 2002:ac8:498c:0:b0:461:2bbd:f96c with SMTP id d75a77b69052e-4612bbdfa90mr11592771cf.6.1729783291124;
        Thu, 24 Oct 2024 08:21:31 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3dab83fsm52808871cf.88.2024.10.24.08.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 08:21:30 -0700 (PDT)
Date: Thu, 24 Oct 2024 17:21:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH] vsock/test: fix failures due to wrong SO_RCVLOWAT
 parameter
Message-ID: <4xfrphsdl7p2aqu6w7diow5shsnjq263lhfudi4yiqxvkvcmkq@ti2hcdbkthok>
References: <20241023210031.274017-1-kshk@linux.ibm.com>
 <k5otzhemrqeau7iilr6j42ytasddatbx53godcm2fm6zckevti@nqnetgj6odmb>
 <ca6702e0-bdd9-4ab7-8fbc-e8b0404c9ed5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ca6702e0-bdd9-4ab7-8fbc-e8b0404c9ed5@linux.ibm.com>

On Thu, Oct 24, 2024 at 10:00:47AM -0500, Konstantin Shkolnyy wrote:
>On 10/24/2024 03:43, Stefano Garzarella wrote:
>>Other setsockopt() in the tests where we use unsigned long are
>>SO_VM_SOCKETS_* but they are expected to be unsigned, so we should be
>>fine.
>
>It's actually not "signed vs unsigned", but a "size + endianess" problem.

I see, thanks!

>
>Also, looking at SO_VM_SOCKETS_* code in the test, it uses unsigned 
>long and size_t which (I believe) will both shrink to 4 bytes on 32-bit 
>machines, while the corresponding kernel code in af_vsock.c uses u64.  
>It looks to me that this kernel code will be unhappy to receive just 4 
>bytes when it expects 8.
>

In include/uapi/linux/vm_sockets.h we talk about unsigned long long for 
SO_VM_SOCKETS_*, that IIUC also on 32-bit machines should be on 64bit, 
so the kernel code looks okay, but the tests should be improved, right?

Thanks,
Stefano


