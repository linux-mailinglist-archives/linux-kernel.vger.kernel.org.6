Return-Path: <linux-kernel+bounces-279648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7483694C009
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312C728376D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21A0191F8B;
	Thu,  8 Aug 2024 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BODccGBx"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E7218FDB7
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128180; cv=none; b=c7mxik5+bNE2VORRHY9bnICEqdm30RhzIr6ardL57wIjjqSs8a9+OG+6oLO4FwryKoNIeO7JGmtJuWnjheElLe04rQHE63dq98zD8gbPzrwfPKISX2EQstoRjKU53kKmEDcfrOxc1arOXfPmCnJPlKj3Cwg5Kmqga9+G/9fO3yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128180; c=relaxed/simple;
	bh=OaKUVVRydamSGqGopKHi/L1XiQ2lIF3/GwmnAhSDdoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcntcy1zdF2LP1ymyOqaRbNMyjnatSFZ0FOywFdbBlqcwWUU+a+8knf4zkK/hArpU/nnvObPJog+1HsffiC8nk9MEZ8OTDtErm+0WuLbZJUU8nL6Y798oqtdGCQAr0RPUf16w324Fk2kAXykex7abJ6F/r80SurMgJWsCuVl6ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BODccGBx; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-368526b1333so1280550f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 07:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723128175; x=1723732975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jv9gb3TPJoZtfBTwu5KhtnLtJz/V1TQePAfnqZ3cjz0=;
        b=BODccGBxsxeJ+ZLeJXtaJlY4DC4wrPU1DnWFWbftpC8YqaqofDC4OeGasb+cgZv/9h
         5DLxv7mkM1qbp84YuwtEJfQCTxc6KdYSGn+VwWt+oTs21J5JgmqUXKBJrxNzKdId7Q3Y
         MoxiPy2rqToTLdmXaqLvb3KWEpeiz1UVeqOPYwvXnnphkerIIjV8HxzoiPQTCmvxMj2x
         StbeCLUL2WZcOPa9/EV1wi2sZIUsZBjX0KV3OMeMqRLua7Nc81Ud+1cXPBzRysWBaMuD
         oEUztoZ5+ZJuzgEKHv5fm03o1OuUb/dT9GiOOpImhZEdvYRQVk/T9++rP9kscUAO38Ay
         i7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723128175; x=1723732975;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jv9gb3TPJoZtfBTwu5KhtnLtJz/V1TQePAfnqZ3cjz0=;
        b=lBpJW9N/bQQfsBJaIIvpJnUOpvCC6HbRNtKDPsSbOXaxgIS/PAypCOvLfsWKqcs9rj
         9TqYfdzG0/sndy1iNgpkR/vCGHliDmeCoFF60mIUkdOmZ5JpmxS2DPVTz4vOe2D+gkPi
         B5iW7TDwLWX0ZxvqWrx5KyfvhqGBcouvFEn6zXvu5PSc1idxJDhep9+WldGBWyqnQaat
         +scLogAZBFCmw8QyOJxa5x8JVLC3zV4jL6y05i/0DZ89UPxGKFM1PR+pxkVw6IFIQ52F
         tmEwgZr/aHB1npH6uH9smOWMwQcEDPd7hKAxGCadry1505QiDGblEUTKCYukVyoBpbHq
         cPrA==
X-Forwarded-Encrypted: i=1; AJvYcCVyla3bKv95jgbK7i7vJfQvDz/Fw1lBn074xX4uGmdSenWBywSzgqaQGkP2pzzfZBrRKZ9+PEDctrLvTVsCf+oFQXdHjpdyFmOwk5J6
X-Gm-Message-State: AOJu0Yz4riDMiMU3Roh16HYifkdpsJIWB1m8zayjZn1CWLvksph72c7/
	d0APmq+wgO8tbczNX7Z37chHiCxdI8H37jog0sFORjvehlI/1HOFwehcEuWRusw=
X-Google-Smtp-Source: AGHT+IGfHetkju187eiWx/ciHnZOqqXfWCLQz3E6ZDrUpHQOpzLG8ZnfGN6zwAylwTHSvHr33bT8Fw==
X-Received: by 2002:a05:6000:e08:b0:362:4679:b5a with SMTP id ffacd0b85a97d-36d2815552dmr1988101f8f.16.1723128174493;
        Thu, 08 Aug 2024 07:42:54 -0700 (PDT)
Received: from ?IPV6:2003:e5:8741:4a00:60e5:7bee:fc48:e85c? (p200300e587414a0060e57beefc48e85c.dip0.t-ipconnect.de. [2003:e5:8741:4a00:60e5:7bee:fc48:e85c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059719ebsm78438585e9.18.2024.08.08.07.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 07:42:54 -0700 (PDT)
Message-ID: <5389eb85-873c-4ae2-a916-6fdd0e5b496d@suse.com>
Date: Thu, 8 Aug 2024 16:42:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] xen: tolerate ACPI NVS memory overlapping with Xen
 allocated memory
To: Jan Beulich <jbeulich@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <20240807104110.18117-1-jgross@suse.com>
 <20240807104110.18117-6-jgross@suse.com>
 <90d67e10-6e35-487e-a9e7-611a0fa3b00b@suse.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <90d67e10-6e35-487e-a9e7-611a0fa3b00b@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.24 14:05, Jan Beulich wrote:
> On 07.08.2024 12:41, Juergen Gross wrote:
>> In order to minimize required special handling for running as Xen PV
>> dom0, the memory layout is modified to match that of the host. This
>> requires to have only RAM at the locations where Xen allocated memory
>> is living. Unfortunately there seem to be some machines, where ACPI
>> NVS is located at 64 MB, resulting in a conflict with the loaded
>> kernel or the initial page tables built by Xen.
>>
>> As ACPI NVS needs to be accessed by the kernel only for saving and
>> restoring it across suspend operations, it can be relocated in the
>> dom0's memory map by swapping it with unused RAM (this is possible
>> via modification of the dom0 P2M map).
> 
> While the kernel may not (directly) need to access it for other purposes,
> what about AML accessing it? As you can't advertise the movement to ACPI,
> and as non-RAM mappings are carried out by drivers/acpi/osl.c:acpi_map()
> using acpi_os_ioremap(), phys-to-machine translations won't cover for
> that (unless I'm overlooking something, which unfortunately seems like I
> might be).

Seems I need to hook into acpi_os_ioremap() in order to handle that case.

> Even without that I wonder in how far tools (kexec?) may be misguided by
> relocating non-RAM memory ranges. Even more so when stuff traditionally
> living below the 4G boundary suddenly moves far beyond that.

I don't think kexec is working in PV mode.

Other tools: time will tell, I guess. I prefer a generally working system
with maybe some tools failing over one not booting at all.

The only other general solution I could think of would be something similar
to vmlinuz on bare metal: a "small" boot code looking for an appropriate
location for the kernel and then relocating the "real" kernel accordingly.
This would require quite some effort, though, as the boot code would need
to create the related page tables and p2m table, too. I'd like to avoid
that.


Juergen

