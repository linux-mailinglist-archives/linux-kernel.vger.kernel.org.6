Return-Path: <linux-kernel+bounces-378157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8212F9ACC28
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F481C21464
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4C51BBBC6;
	Wed, 23 Oct 2024 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsAZytnI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4CC1B85CF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693301; cv=none; b=TBMD3+16+2Jj6QTq8ADcVFoQaM+xMcf5QXGW7gVz/4VRMpb7cvaQN+BtB13kn7qD3T6X+rPeny5WKB/N67V+kOr7IXxRqhLf4r0FP0rmh4fsjVs5AhZmsTGegf20IJAGAB1UsF79fNpZoqETrDNzYFmKCy58GOb5OUgz8JEYDFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693301; c=relaxed/simple;
	bh=52dMawAHwQ7RNNnXpl/xtqLV4IPsAGgschkIAYdfJSE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=HCVX4cKWHFlakv6GCJhpgfqfpO+ASq2ld5Q2arTfzKff/rnrmK2PLRqM3+qQxHgaRCofVB1lfNbrxRRhQaV08ICWcb6z/0v5reK1UhYkdLuVcgXXaYdXK6s1VmsBy/i/J9ooiQE8luqGywMBwLxNWNKrbgVoSE31pI+C5HUPRSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PsAZytnI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729693298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vfp9d3d8uVA7GnaHHJHdQM2rjaldOFFUaSWnLGejGFk=;
	b=PsAZytnIAZe3NiuGQwffdJP8V+xjsjpijVIB462gdYGJaBGpQep1+WeVTS8C+N+XNKWJx+
	NyfGpsdlosdsWKynWPxIS69/4aQ/99E/oCFn8USZKPjrbvUmL+qfdeWV7v32Bd+SrVMdL7
	bj3GsApqtOwEIMLSPmn/wfUf26j1TbM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-w0_Nj0DsOHCkAomiVgBeIQ-1; Wed, 23 Oct 2024 10:21:37 -0400
X-MC-Unique: w0_Nj0DsOHCkAomiVgBeIQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d609ef9f7so3407982f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729693296; x=1730298096;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vfp9d3d8uVA7GnaHHJHdQM2rjaldOFFUaSWnLGejGFk=;
        b=NvZ/QMefTzWbaLRutRRyLW727sKdatL3o1NvQdomBEIEW5FbBakQ69aFwKMg/kZRyn
         9NrFOvGm731P8D1m7TMJY+DKXhP2hUqVKFDON5BxwxqDUT2V1mJSpDzcqJdU+Db24jbW
         sKLp/SuIu/BNqZ0fKe7d+ui+II73g0/jCUvMH68mHOw1SYZstH/OXgE6/+dZIodRiJBp
         FA8bHHwbHrmegIwPcdkq5ZrN9LurZmsCGjAuUa9mKEB5g215tsfEdnyFQvRQVYWCOX61
         ceru1NRUoFPkYsEvDS6+w9YIAjMMPvc+E+OUmNbe7U2Pio6PAVWP5m2a5GdXpGPou/Y8
         ACEw==
X-Forwarded-Encrypted: i=1; AJvYcCWO/zfIPELAC6hkBtlxWpJtq176fKVzMw9DqGONTwTv27VU0FgF3Evwk3Ew7Y8rxfkr41jRBJ43MS0i6X4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzosF2CLA9Z09CPKE2SIaWZqrUIcvEFLj4VwKqAK7GG5QwjJav5
	dYpWOyEnIwU14aTz9k8MDCRx6PKFxhizROe6gq8Kay25yTaCQkNrnFaFTLQd5Deai4FEo4LRAVO
	8tQlQWOptZU4MOcW2dDnglfN3s9baz5spx9tnRBgrmhE3UtWpr2Dlq68TnIgEJ1+NzOuSjizV
X-Received: by 2002:a05:6000:191:b0:37d:4a21:c754 with SMTP id ffacd0b85a97d-37efcef0b96mr1810688f8f.2.1729693296015;
        Wed, 23 Oct 2024 07:21:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXBBg1WsjjrYFcskQf9ozXLy/26dl5Tjca13X/pcduCD8lrZbgn1I/1UI5i2A8xhwdxsWU+Q==
X-Received: by 2002:a05:6000:191:b0:37d:4a21:c754 with SMTP id ffacd0b85a97d-37efcef0b96mr1810671f8f.2.1729693295587;
        Wed, 23 Oct 2024 07:21:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b93e76sm9024308f8f.82.2024.10.23.07.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:21:35 -0700 (PDT)
Message-ID: <3afb4ea2-88d7-4099-9e53-e82416b7f35c@redhat.com>
Date: Wed, 23 Oct 2024 16:21:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] posix-clock: posix-clock: Fix unbalanced locking in
 pc_clock_settime()
From: Paolo Abeni <pabeni@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, Jinjie Ruan
 <ruanjinjie@huawei.com>, anna-maria@linutronix.de, frederic@kernel.org,
 kuba@kernel.org, richardcochran@gmail.com, linux-kernel@vger.kernel.org
References: <20241018100748.706462-1-ruanjinjie@huawei.com>
 <878qul802d.ffs@tglx> <e9e80c32-2988-487a-a1ee-fab0caa863dd@redhat.com>
Content-Language: en-US
In-Reply-To: <e9e80c32-2988-487a-a1ee-fab0caa863dd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/24 17:42, Paolo Abeni wrote:
> On 10/19/24 01:26, Thomas Gleixner wrote:
>> On Fri, Oct 18 2024 at 18:07, Jinjie Ruan wrote:
>>  If get_clock_desc() succeeds, it calls fget() for the clockid's fd,
>>> and get the clk->rwsem read lock, so the error path should release
>>> the lock to make the lock balance and fput the clockid's fd to make
>>> the refcount balance and release the fd related reosurce.
>>>
>>> However the below commit left the error path locked behind resulting in
>>> unbalanced locking. Check timespec64_valid_strict() before
>>> get_clock_desc() to fix it, because the "ts" is not changed
>>> after that.
>>>
>>> Fixes: d8794ac20a29 ("posix-clock: Fix missing timespec64 check in
>>> pc_clock_settime()")
>>
>> Jakub, I expect _you_ are going to pick this up and explain to Linus and
>> the stable people why we need a fix for the rushed in "fix".
> 
> I'm sorry, I noticed this patch right now thanks to Anna-Maria head-up
> on netdev.
> I'll merge it into net before this week PR.
> 
> Again, I'm sorry for this mess.

The patch is now merged into the 'net' tree:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=6e62807c7fbb3c758d233018caf94dfea9c65dbd

and I'll send it to Linus with tomorrow PR.

I forgot to mention Jakub could not reply as he is off-the-grid for a
few more days.

Cheers,

Paolo


