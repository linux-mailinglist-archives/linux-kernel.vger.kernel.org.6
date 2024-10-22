Return-Path: <linux-kernel+bounces-376492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B269AB255
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D9D1C22432
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F147C1AE843;
	Tue, 22 Oct 2024 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjHZZN0i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C37B1AA78A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611758; cv=none; b=kijEZcWm7sMuMIOXx6v69QJTSICpVp2LZ8vtjc/S8TSLaWZqLVQ0M9HHIzrgNkf4hd8zlTTOrg4WA/sUJu4kcOaGopP4QWfNye7dgsC0k5ZOf/ohHYvLVEbsKAVj7du5CP8wCUdmtRPgG4vmOMxSMMfzRU/jdy4+em0WFWO4bX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611758; c=relaxed/simple;
	bh=KkcEm1heH6qM45iY126C0mw8JOB2BZ9tijaBhfgtQKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N2LCRWSe+tOrsY27xy4qQJYqV2gBtw+3d8QIiPZevCmYsjpRQ4Lay5kygQMbaHonjt5bq7V6bGEaGpDYj53Ot4cBiPgECEtkDmdd4flvR1SwC30jqhbBplcEePV2qmLLXH9y8jry1/E01X7NgO38tW09WQxVJ/eQFFInycb7Dtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bjHZZN0i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729611755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N8L0a2sNf8Nx+hrCNRPwEPYwI1EyXVV6XhvDB3voaRA=;
	b=bjHZZN0iOt0ib1LJHgEClcgxiPaSr9oqDgm3cIqto/2IatNjOu77K8ZFFMmk69PWxt/hf7
	OX+Ues/L6kAuVu3I1tluMp7mtbw0zw7GP5gSYR5WIfUzcP3cZeVGKY5ssPae8qO3pXS5Oc
	oaHLpvVldoQa+3UcejisUFpDLpBOFa0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-3j5MmCliPwmxvU1Czep2qA-1; Tue, 22 Oct 2024 11:42:34 -0400
X-MC-Unique: 3j5MmCliPwmxvU1Czep2qA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315d98a75fso40970155e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729611753; x=1730216553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N8L0a2sNf8Nx+hrCNRPwEPYwI1EyXVV6XhvDB3voaRA=;
        b=iu6MTwoUhDQgl633CGPNwR20nIzNUEmoccXkeymbW0uqrYDVm+urrXEo/Hojjzx/aH
         y2UXwko7eriGYKSfTgN/rkhL8FS/SZJJcTrM67Anmt4PJEhEm3ReIPtrGWZeOCi0UPVR
         u2Zlm/GVN2m8vnPalkK9kWseDU3PIQvMBG199Ud5nd31HXcle0HQmK070LS2PydOt/Sl
         eeKJeKopIruMa1MeHJ0erFEfjh2Bp2fnLATQmM3F4sxlKnK1jDSF2Pq4geAguUr4trxn
         MtuDKRVKK57VIV5PIpkjuI2ool8RwuxVDyDmaXHtraJ3j6V8zsoTRfaoqy2ltNX4aDxp
         ezPA==
X-Forwarded-Encrypted: i=1; AJvYcCWGs5kD0lVU1JkhPTLWrvqwEWR/wqYMTlUt1RMkWSPUJm6UEj9eshCLLl06c3zQ4ip+QeBkclSKCnhLII0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQvfFoggY1NO5E1jxZGbvCziuLu3RMIz45+gDKAsVVPzUXGBKk
	QqC8dKtNDOF0ChJYgYT2Veu4hPpfkESTlKYnjOT0s5PUPDzJ9z04YNn0JugovtQ72chMYl3K98U
	2Hmc/qVgaA998VTjTyT5/aFG7/KT5T+h0nx0pcSWGy+eKhkRFhtsdHnM8oWOtgA==
X-Received: by 2002:a05:600c:3b9c:b0:42c:bc22:e074 with SMTP id 5b1f17b1804b1-43161691787mr133832265e9.29.1729611752894;
        Tue, 22 Oct 2024 08:42:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwhKXrMzx/Cinc5O+rDnGcIjpf0iXTWlE+y+uSlSf/DDzlAuZPldVlein9rgfYdLZHT7HkOQ==
X-Received: by 2002:a05:600c:3b9c:b0:42c:bc22:e074 with SMTP id 5b1f17b1804b1-43161691787mr133832095e9.29.1729611752514;
        Tue, 22 Oct 2024 08:42:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cbe64sm91537855e9.40.2024.10.22.08.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 08:42:32 -0700 (PDT)
Message-ID: <e9e80c32-2988-487a-a1ee-fab0caa863dd@redhat.com>
Date: Tue, 22 Oct 2024 17:42:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] posix-clock: posix-clock: Fix unbalanced locking in
 pc_clock_settime()
To: Thomas Gleixner <tglx@linutronix.de>, Jinjie Ruan
 <ruanjinjie@huawei.com>, anna-maria@linutronix.de, frederic@kernel.org,
 kuba@kernel.org, richardcochran@gmail.com, linux-kernel@vger.kernel.org
References: <20241018100748.706462-1-ruanjinjie@huawei.com>
 <878qul802d.ffs@tglx>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <878qul802d.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/24 01:26, Thomas Gleixner wrote:
> On Fri, Oct 18 2024 at 18:07, Jinjie Ruan wrote:
>  If get_clock_desc() succeeds, it calls fget() for the clockid's fd,
>> and get the clk->rwsem read lock, so the error path should release
>> the lock to make the lock balance and fput the clockid's fd to make
>> the refcount balance and release the fd related reosurce.
>>
>> However the below commit left the error path locked behind resulting in
>> unbalanced locking. Check timespec64_valid_strict() before
>> get_clock_desc() to fix it, because the "ts" is not changed
>> after that.
>>
>> Fixes: d8794ac20a29 ("posix-clock: Fix missing timespec64 check in
>> pc_clock_settime()")
> 
> Jakub, I expect _you_ are going to pick this up and explain to Linus and
> the stable people why we need a fix for the rushed in "fix".

I'm sorry, I noticed this patch right now thanks to Anna-Maria head-up
on netdev.
I'll merge it into net before this week PR.

Again, I'm sorry for this mess.

Cheers,

Paolo


