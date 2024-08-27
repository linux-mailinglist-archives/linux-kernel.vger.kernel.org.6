Return-Path: <linux-kernel+bounces-302867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2134F960472
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C8BB21CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFFD198A2A;
	Tue, 27 Aug 2024 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRfG1kwP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2411714A3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747570; cv=none; b=Oh3XZn284zqOlOz0y2rID5BtA6OmE2crG6kSGTjVnPGV5OiBRUnP7wogvkIwP/7j0TJdd0bfvH1xcQRfFl06a3H4vJNQtfAqZz5Gx3cVhLdDmR7DSs6urJTVDjraIPy5RoK2hbM1DFMJELE0c3CqufL08uYsFUQQ6CUUU2nd/vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747570; c=relaxed/simple;
	bh=w3e2l/LkFkI1FKRdLYSz+PC3KjWBIaRK2n5Zp2WvPWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SFMKQ7MWBH66Yh5F0tDsmT1mzouflLr8lG+9qFy5Fbi4e5tOS24FecYItG04WuMwyhtA2mrqg2jViFr57PBtISB5iAWS8DqrVoFT0DvqW/PuDcOxGkn3XPzW2G0JGi5hSq1J8k9ehfTd+wy0A+OZ9Zccs/L7qZtUR8Ha98nBCmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SRfG1kwP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724747567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y6KVgv1IL2HPmMPmJO9/W7wft0+lwNpol6UUqmyiHZI=;
	b=SRfG1kwPvOzt4W39a1evTjhKRsqDgbJPsyHQbZkIaZnotstQMDOLmQth1e9hrDbRSL28KG
	H5a0S+44crr5+ja2zjw4D16Lp5ZjjwwS1wqdQojQ3x5pnuM0H8sjl3Yt4EQuZ3TFz/VS2v
	+mtgEJTb+D1Hyw5a7Se43RjtgGufNx0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-9t-MYUx4O4aUgdBGp29P7g-1; Tue, 27 Aug 2024 04:32:44 -0400
X-MC-Unique: 9t-MYUx4O4aUgdBGp29P7g-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-534363ab6a0so4833373e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724747563; x=1725352363;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6KVgv1IL2HPmMPmJO9/W7wft0+lwNpol6UUqmyiHZI=;
        b=XAtWspumX9gs3L3bjsJxj2aU3k85ZxF/eq9Ry6tQgfPR9u8gIMOzePhmaiPVq9yU2t
         DldRQsODJ0zt7LujjAtQOFD/fZDBUvpA236PITgG1n8rXopE4NtBOfSlUrYv+bRwuf1f
         JgGkVcHXDIy+pbO97tE6iEk+ix7KqGi2yhx9xHfplDomohgabF8TjASSAMHMkaQcnKoR
         mbyAIG5bIr6zZMPCnaf8Ud+g5SAUKxWXlGSsdTW5H7hIEFuLSoXT/mtjv4DXR5EW1AZu
         Z6DO6Bi2tV/IcpBipqemSMl2DI7pvtYYYk1EDHV03ZTF6OS5QRoqaH0BlsQbPowdm/dX
         /t1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTS9BGNdx5FUazTEQF3ZO+8M+HDZo9a3OPZlx3D/S786Spks8JQknzY1TLMTMdjx4JP6P3Mh53PugQG3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrmJCq4EDbgUfho3qS4BemPi8W4IHos8ZAMspMv2xV/fNwgyOk
	WyJBsQJDdn37qyemVJX3mPAX1qM8mSf52KtixVGonEP+gt6eYT8Yp6CC+Cc5hDiw+/KcXUiKPz9
	SVYf1z4rNsmGFpQxYyvSAm/b9MtVzqxRZQipuwvsXeHVdLBHMKKRvz/dTKCba3Q==
X-Received: by 2002:a05:6512:1395:b0:52f:cbce:b9b7 with SMTP id 2adb3069b0e04-5343870c302mr8057098e87.0.1724747562929;
        Tue, 27 Aug 2024 01:32:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKg67blLe1ufYFNA3yQVBWOA7L339P3C4Z2XLP23b4E0lZT1vUhPQUB9g2nPFuV3RXc6LU8Q==
X-Received: by 2002:a05:6512:1395:b0:52f:cbce:b9b7 with SMTP id 2adb3069b0e04-5343870c302mr8057068e87.0.1724747562285;
        Tue, 27 Aug 2024 01:32:42 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e582de25sm79641566b.122.2024.08.27.01.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 01:32:41 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: stable@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] x86/hyperv: fix kexec crash due to VP assist page
 corruption
In-Reply-To: <11001.124082704082000271@us-mta-164.us.mimecast.lan>
References: <20240826105029.3173782-1-anirudh@anirudhrb.com>
 <87zfozxxyb.fsf@redhat.com>
 <11001.124082704082000271@us-mta-164.us.mimecast.lan>
Date: Tue, 27 Aug 2024 10:32:41 +0200
Message-ID: <87wmk2xt5i.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anirudh Rayabharam <anirudh@anirudhrb.com> writes:

> On Mon, Aug 26, 2024 at 02:36:44PM +0200, Vitaly Kuznetsov wrote:
>> Anirudh Rayabharam <anirudh@anirudhrb.com> writes:
>> 
>> > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
>> >
>> > 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go
>> > online/offline") introduces a new cpuhp state for hyperv initialization.
>> >
>> > cpuhp_setup_state() returns the state number if state is CPUHP_AP_ONLINE_DYN
>> > or CPUHP_BP_PREPARE_DYN and 0 for all other states. For the hyperv case,
>> > since a new cpuhp state was introduced it would return 0. However,
>> > in hv_machine_shutdown(), the cpuhp_remove_state() call is conditioned upon
>> > "hyperv_init_cpuhp > 0". This will never be true and so hv_cpu_die() won't be
>> > called on all CPUs. This means the VP assist page won't be reset. When the
>> > kexec kernel tries to setup the VP assist page again, the hypervisor corrupts
>> > the memory region of the old VP assist page causing a panic in case the kexec
>> > kernel is using that memory elsewhere. This was originally fixed in dfe94d4086e4
>> > ("x86/hyperv: Fix kexec panic/hang issues").
>> >
>> > Set hyperv_init_cpuhp to CPUHP_AP_HYPERV_ONLINE upon successful setup so that
>> > the hyperv cpuhp state is removed correctly on kexec and the necessary cleanup
>> > takes place.
>> >
>> > Cc: stable@vger.kernel.org
>> > Fixes: 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go online/offline")
>> > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
>> > ---
>> >  arch/x86/hyperv/hv_init.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> > index 17a71e92a343..81d1981a75d1 100644
>> > --- a/arch/x86/hyperv/hv_init.c
>> > +++ b/arch/x86/hyperv/hv_init.c
>> > @@ -607,7 +607,7 @@ void __init hyperv_init(void)
>> >  
>> >  	register_syscore_ops(&hv_syscore_ops);
>> >  
>> > -	hyperv_init_cpuhp = cpuhp;
>> > +	hyperv_init_cpuhp = CPUHP_AP_HYPERV_ONLINE;
>> 
>> Do we really need 'hyperv_init_cpuhp' at all? I.e. post-change (which
>> LGTM btw), I can only see one usage in hv_machine_shutdown():
>> 
>>    if (kexec_in_progress && hyperv_init_cpuhp > 0)
>>            cpuhp_remove_state(hyperv_init_cpuhp);
>> 
>> and I'm wondering if the 'hyperv_init_cpuhp' check is really
>> needed. This only case where this check would fail is if we're crashing
>> in between ms_hyperv_init_platform() and hyperv_init() afaiu. Does it
>
> Or if we fail to setup the cpuhp state for some reason but don't
> actually crash and then later do a kexec?

I see this can happen for CPUHP_AP_ONLINE_DYN/CPUHP_BP_PREPARE_DYN
because we run out of free slots (40/20), but here we have our own
dedicated CPUHP_AP_HYPERV_ONLINE and other failure paths seem to be
exotic...

>
> I guess I was just trying to be extra safe and make sure we have
> actually setup the cpuhp state before calling cpuhp_remove_state()
> for it. However, looking elsewhere in the kernel code I don't
> see anybody doing this for custom states...
>
>> hurt if we try cpuhp_remove_state() anyway?
>
> cpuhp_invoke_callback() would trigger a WARNING if we try to remove a
> cpuhp state that was never setup.
>
> 184         if (cpuhp_step_empty(bringup, step)) {
> 185                 WARN_ON_ONCE(1);
> 186                 return 0;
> 187         }
>

Personally, I'd say that getting an extra WARN for such a corner case
(failing to setup cpuhp state or crashing in between
ms_hyperv_init_platform() and hyperv_init()) is OK. 

Alternatively, we can convert hyperv_init_cpuhp to a boolean to make it
a bit more staitforward but as it's uncomon to do it for other states,
it's likely an overkill.

-- 
Vitaly


