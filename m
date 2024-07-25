Return-Path: <linux-kernel+bounces-262527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E92E93C83D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F261C213F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FB42E64B;
	Thu, 25 Jul 2024 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4jz3CDYg"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3FB210FB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931571; cv=none; b=mZD3MBFB/zP5PfECk2f+nuN2RpgfJXb5hmYzRaO2O8L3jWuEdskZjPA5ZhNsvfyQDBxuUdcIj+/LLr2fqhfs0Jwx8+Ws6KqBIWN16RyA0II/vMTfO7axcHzBlKqdSjUuFaAgbHOcFvo7kMv8kpDrVB/5241+sLPjxhbr9V3w1C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931571; c=relaxed/simple;
	bh=Ue5vF5Ixtm0O1c2YnWtk0OGg5UItE1cxouPFbqUWkBs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uoazs2bkkADJpJMput8ChKKk8FuZ0yHE2lIUj8RtIpdZPwN0SaU1fQco9lPFjbpeqkcVvFEBe4cRFKbl9pQ5l/XGZJ6vV+Omb7lsOt8C8pcQwbAdjlavBRejGg97/VKXZe45Ee5n4tUDKVnDK1pTXUtAbHc0tdz67BG5FpPcqXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4jz3CDYg; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fc5acc1b96so12218695ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721931569; x=1722536369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9+cWinSd71QUFpeng6pkfteDp9R+YDOSFKPyk/5CKIQ=;
        b=4jz3CDYgnbX66UdDS5vj6bDN9m1+8C6pvFDrGymgpok0XBtnjzpBxKJ1p5706qSGI9
         ZiGnksugtzi5psMDaKn3yQEX4tsMe/c3ganC401oIcJjoMvXvt0LWakHkd9puCGRtI/r
         Mrw4l5fh9BYfW/NopviizdjgFGS2GkG/MbAoRgSUJ7xV/G7mnxsOKWmSEFsaWUm8I+Ao
         A7Y+txGrX4pCdqjXO4JjBXRdDKql786IIH9GZ8eMgxpnA/kkBuCSCj4PhLqUxh7SzxXh
         3HAT3DkjPd3o/pLocircC1SpjoLDTjqCp3juBOEJyq0yV4LnJ4QFqxxc/TdJcUSwm0Gq
         NVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721931569; x=1722536369;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+cWinSd71QUFpeng6pkfteDp9R+YDOSFKPyk/5CKIQ=;
        b=fSw8a2/bqA3D/JYyYE7RQj0MiZyuhYmzu1mRMdeiS4d+ox13CFNQj9RPwPBU53wyz1
         9xhXR4fkDUxnqlOXONunOjyqRamq7wa/kE0mRyBnDTwEzA83Mj+Xl5aKKo5p6V+7wJDU
         VhAQhMew8QhxfNuh//leCOLm8mIj0s4PImGBr0KYkIS2gyi63oBFvjYxS5N85rmZWgGB
         Topv9etu6rUImREQA/56wfNvrlUb8Ag8Ey2S82xyHo2k9xksNYPhdjESm9uawYWrU4Ng
         uXxDL46NJm8n8mWuj0yKMX2nEprYFvfNk9fxsk8TtVF6rgBTA6HQqJG40ttdsYdrwmaO
         0Wuw==
X-Forwarded-Encrypted: i=1; AJvYcCWkuduabya80DKmxSKZtUaJnf7mwpbeogvXQq4Dgznetv4W/64nY50RW2LMniIRloy1aMlmaoBD13ttbKF9eVWuaG/PGmelB80WJWqC
X-Gm-Message-State: AOJu0YzdiFi5WfiDe2mPTazHyYgNaeisNkOnSbXFxHWCX3u3reSSPkV9
	5e9TMVLZpaNlH4ybG22gnhw5Df7UXZWCqIStrC4FjK+BO5hE60fbVG6+htmdGY2ZVOGYrHP0QYW
	ZbA4PesCEunOAN6COs2n3Xg==
X-Google-Smtp-Source: AGHT+IEq0/Qf2aH7olYk0jZU1lYwwK43xAQuSUsE/EQnG/wMgzk9gQAK1/L4A02IBfsH1aseVKWvPS3Vq/ZyFeT5Zw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:903:1ce:b0:1fa:acf0:72d6 with SMTP
 id d9443c01a7336-1fed909f356mr1844455ad.3.1721931568714; Thu, 25 Jul 2024
 11:19:28 -0700 (PDT)
Date: Thu, 25 Jul 2024 18:19:27 +0000
In-Reply-To: <diqzo76myc5x.fsf@ackerleytng-ctop.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <diqzo76myc5x.fsf@ackerleytng-ctop.c.googlers.com>
Message-ID: <diqzzfq55o7k.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v5 07/29] KVM: selftests: TDX: Update
 load_td_memory_region for VM memory backed by guest memfd
From: Ackerley Tng <ackerleytng@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: sagis@google.com, linux-kselftest@vger.kernel.org, afranji@google.com, 
	erdemaktas@google.com, isaku.yamahata@intel.com, seanjc@google.com, 
	pbonzini@redhat.com, shuah@kernel.org, pgonda@google.com, haibo1.xu@intel.com, 
	chao.p.peng@linux.intel.com, vannapurve@google.com, runanwang@google.com, 
	vipinsh@google.com, jmattson@google.com, dmatlack@google.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:


> Yan Zhao <yan.y.zhao@intel.com> writes:
>
>> On Tue, Dec 12, 2023 at 12:46:22PM -0800, Sagi Shahar wrote:
>>> From: Ackerley Tng <ackerleytng@google.com>
>>> 
>>> If guest memory is backed by restricted memfd
>>> 
>>> + UPM is being used, hence encrypted memory region has to be
>>>   registered
>>> + Can avoid making a copy of guest memory before getting TDX to
>>>   initialize the memory region
>>> 
>>> <snip>
>>
>> For memslot 0, 1, 2, when guest_memfd != -1,
>> is it possible to also munmap(mmap_start, mmap_size) after finish loading?
>>
>
> Thank you for your review!
>
> Did you mean "possible" as in whether it is "correct" to do munmap() for
> the rest of the earlier memslots containing non-test-code?
>
> It is correct because the munmap() just deallocates memory that was
> recently allocated in mmap() in this same change. The memory set up for
> the VM is not affected.
>
> <snip>
>
> If we are not using guest_memfd (region->region.guest_memfd == -1), then
> we need to make the source and destination address different by copying
> the contents at the source address somewhere else for the call to
> tdx_init_mem_region(). That is what the mmap() is doing. This temporary
> buffer then needs to be freed, hence the munmap(). Without this copying,
> the destination address for the ioctl's copy would be the same as the
> source address, since those very same pages are provided in the memslot
> for this memory region.
>

Update on this:

Since TDX requires the use of guest_memfd, this patch will be simplified
in the next revision.

The checks for region->region.guest_memfd != -1 will be removed, and
there will be no need to do any mmap() or munmap(), so those will be
removed as well.

> If we are using guest_memfd, then the destination address for the
> ioctl's copy will be taken from the guest_memfd, which is already
> different from the source address, hence we can skip the copying.
>

>>>  }
>>>  
>>> -- 
>>> 2.43.0.472.g3155946c3a-goog
>>> 
>>> 

