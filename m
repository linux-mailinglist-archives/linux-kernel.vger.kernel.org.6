Return-Path: <linux-kernel+bounces-304747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05636962446
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C5A28615F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDDF167DB8;
	Wed, 28 Aug 2024 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORx3RLsv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F2C15B57A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839565; cv=none; b=Nw6nkxaUMFCADQVxIE0jXZXhOkQqxF96E81D5YfLX56LQq8pnpedfk6NZMozBZYvzeVshhYcbPzmdwPuj8pjp9cmIYwoHmWjur7jQHGpNXC3kmIj0xYdOR9sbzaJUh2VlxdMAXntasNKlO4Ird7GR+o1cXP0AwJbawHotKjYLqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839565; c=relaxed/simple;
	bh=2XvJc64B/U/QMqr6FF7+wLBp7Bkwd5nCWU1lj6+gito=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZDqVSqRR7y2lL8rwt9jXxAB7JtLhSl4Wcn+d0AFSB7iWkKV1ysLcz/udvHwpPCN9n7hIiacLgnzhHE/NP7DpwnwrOS7v2a6qxyDkF0gjAt2vjQmVFVGCLwEbxMOa7bIr0pZO+xnW/b7ySVdcDMDW/Iwjot/aS43F128kLgpjUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ORx3RLsv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724839561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tRmVdsuaeaXT+vWtHDk6nUxAnO6rQI8j0TA/B/J7KGY=;
	b=ORx3RLsvrYz55k0nyZtW1RHJqbCgT7aM9+jC5IrkDXZg9N6k/20lE7yRoEGWcWkcW5Ja3E
	544wnCnRiKWhSDsGIOISnPsMFFq9LNMqn/Qz2xwdNQeIqUItemavaCLZXDA3oF9RaZzCNN
	LJZp/eDKt6B4weZdNx8QbtyoEM57QQI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-uvfAtWEAP4-J4rT2z3dIYw-1; Wed, 28 Aug 2024 06:06:00 -0400
X-MC-Unique: uvfAtWEAP4-J4rT2z3dIYw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42b8a5b7fd9so42398805e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 03:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724839559; x=1725444359;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tRmVdsuaeaXT+vWtHDk6nUxAnO6rQI8j0TA/B/J7KGY=;
        b=xCrN49eNJ76L4gL8PJxnZiwWPujmTzJpdSXNqF/LjB2LNnOX/PhltqsbwD3xDb2QY/
         z90pRhXm9IUM+KYW1UkS/2bIzqcHBb/VMOQdtn1lQ087VKJiAz7eoTTecR3RBYG0GjfD
         0UkRFO7URQryr+brwMLBtOZ4r8sVEV2jHz6EMYPngqmj/HsjOGFLDW4wzDNmQfJ/s2VG
         elcqXTkuPJQOWKOMPKkBCmrZdWVgqdlDuo/VM2Pp+HMgByJHBZCnWE51k0Ok+Fi78sVv
         k1I/Ak+4xJVr7PSgqVKeGVMqcTAHGddg++cTEYIN9uCSPmWiMEgtAcDpPrZ4ArQFyDlc
         KW0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyQtysG46m0HnWRL0EwgDdQSqTRv3ndFEP/+11Gx29ziQBf6TwBgYwCoVcorAiaJR6H0vPZo65zSJo5aI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu8cPbi4goFa55reRn8nA0thm0jPeW90IUccB+oHT2GJfbgSVY
	gk92vdY5DwjjQ0G5SAL/xaOkqS2QMDZ6HfmyyOZ+RrkRZch27VueujvxcoeAlZDEva0w/pCIiSE
	Ej6ZozP8A03a4zEHwrOBrOzZ6/y5iD5pCNhncoEYFWzwPZyt5pEn+eOzHbVwA0g==
X-Received: by 2002:a05:6000:18c6:b0:373:b87:55d8 with SMTP id ffacd0b85a97d-3749680ad5emr846158f8f.3.1724839559123;
        Wed, 28 Aug 2024 03:05:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT+kfWitKfxzXFWbzOCGHn2BUvujtChV/VhC2xiw95wlizX9KdHXZUGWJ5ZVZ75/Dr89T8+w==
X-Received: by 2002:a05:6000:18c6:b0:373:b87:55d8 with SMTP id ffacd0b85a97d-3749680ad5emr846131f8f.3.1724839558236;
        Wed, 28 Aug 2024 03:05:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:1700:6b81:27cb:c9e2:a09a? (p200300cbc70617006b8127cbc9e2a09a.dip0.t-ipconnect.de. [2003:cb:c706:1700:6b81:27cb:c9e2:a09a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6397dcdsm16626955e9.6.2024.08.28.03.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 03:05:57 -0700 (PDT)
Message-ID: <a22f114b-e86d-4ddf-b13f-4020b53c97c3@redhat.com>
Date: Wed, 28 Aug 2024 12:05:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] prctl: allow prctl_set_mm_exe_file without unmapping old
 exe
To: Theodore Dubois <tblodt@icloud.com>, linux-kernel@vger.kernel.org
Cc: Ryan Houdek <sonicadvance1@gmail.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Kees Cook <keescook@chromium.org>
References: <20240827215930.24703-1-tblodt@icloud.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240827215930.24703-1-tblodt@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.08.24 23:59, Theodore Dubois wrote:


> As far as I can tell, the original purpose of this check was simply as
> the easiest way to work with a quirk of /proc/self/exe at the time. From
> the original patch[1]:
> 
>      Note it allows to change /proc/$pid/exe iif there
>      are no VM_EXECUTABLE vmas present for current process,
>      simply because this feature is a special to C/R
>      and mm::num_exe_file_vmas become meaningless after
>      that.
> 
> num_exe_file_vmas was created to preserve a quirk of the original
> /proc/self/exe implementation: if you unmapped all executable VMAs,
> /proc/self/exe would disappear (because it worked by scanning the
> address space for the first executable VMA.) Keeping the quirk after
> switching to just saving the executable on the mm worked by keeping a
> count of executable VMAs in num_exe_file_vmas, and zeroing exe_file when
> it reached zero. You can probably see how it would have been annoying to
> handle both num_exe_file_vmas and this prctl intending to change
> exe_file, and it's easier to only allow changing exe_file after
> num_exe_file_vmas has already gone to 0 and made exe_file null.
> 
> However, num_exe_file_vmas no longer exists[2]. This quirk was taken out
> because it would save a bit in the vma flags, and it seems clear by now
> that nobody was relying on it. These days you can simply update exe_file
> with no interference.
> 
> Recently a use case for this prctl has come up outside of
> checkpoint/restore, namely binfmt_misc based emulators such as FEX[3].
> Any program that uses /proc/self/exe will, of course, expect it to point
> to its own executable. But when executed through binfmt_misc, it will be
> the emulator, resulting in compatibility issues. Emulators currently
> have to attempting to intercept syscalls targeting /proc/self/exe to
> redirect the path, and this is not possible in the general case
> considering how flexible path resolution is. For more detail on this see
> [3].
> 
> The above seems to me like a solid case for simply dropping the check.

Interestingly, the man page states:

"You can even type /proc/pid/exe to run another copy of the same 
executable that is being run by process pid."

Is that still true (with that binfmt_misc magic) once we change 
/proc/self/exe? Or does it with changing /proc/self/exe to point at the 
non-emulator exe even work as expected regarding this documentation?

It's a good question what will change if processes start setting random 
other stuff while they are still executing part of the original binary.

commit 4229fb1dc6843c49a14bb098719f8a696cdc44f8
Author: Konstantin Khlebnikov <khlebnikov@openvz.org>
Date:   Wed Jul 11 14:02:11 2012 -0700

     c/r: prctl: less paranoid prctl_set_mm_exe_file()

temporarily switch to checking that not other files besides the 
executable are still mapped.


I agree that b32dfe3771 reads like this check was added primarily " 
because this feature is a special to C/R and mm::num_exe_file_vmas 
become meaningless after that"

Reading mailing list discussions, there was a discussion regarding 
security risks [1] with the conclusion being "We must not trust 
/proc/pid/exe in anyway. An attacker can always execute another binary 
without calling execve()." [2].


So with that in mind, no objection. Clarifying which effect this has on 
what's stated in the man page would be interesting.


[1] 
https://lore.kernel.org/lkml/CAFLxGvxEDs=RG7tX+j6XEUx2+wEvuCGipUzh2vSp3rj15Rq6zA@mail.gmail.com/
[2] 
https://lore.kernel.org/lkml/CAFLxGvyCRAq6t8_ni+VFUVpOGJ4-iz0i=PRFEFpVJ+ZaPEb3-g@mail.gmail.com/


-- 
Cheers,

David / dhildenb


