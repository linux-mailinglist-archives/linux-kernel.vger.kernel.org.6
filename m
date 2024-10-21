Return-Path: <linux-kernel+bounces-373982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 392E39A602F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D3C1F2294D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A48E1E3DF3;
	Mon, 21 Oct 2024 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUmFwwtL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F74E1E3DDC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503250; cv=none; b=M2vYTuGUedQGmnfhsxEjYORuDQtxiTKauvwPx8PrbJ3e9GKPyBtjx8G6i6qBO6+1uL1vtFRs0C+klCqoFHbMG4v1IENRkXhsanK1vJnnch6rTM2jKm9/1I23rgbql3dcexyTDcfQKrmravzfE/fPn6/3b2l+VOoQg8k5pOXeXrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503250; c=relaxed/simple;
	bh=WKXZCgs18X9S5ywX9Jm7kT5M22O5Qvm/MvLJ/K2dOVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3Ck1d5VnpH25WKSS1a5JkHN5YOkEGW9HrM9eYY4fkxWC3lPGs4qDpK21rvmB4ozy4oWryJWAlcLhld3K5D4SB9igndtM+onYTwHvNraFksyUiSUXf800ji0QzOqfibyIon2cnBjl+IuKNs/u5jM8Y1NKIMBQVRCbkCRPDfWzik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUmFwwtL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729503247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N1qrMQuES5B03MGFeoy/Tls0FHqUcPfUE/C/kE01yJ0=;
	b=YUmFwwtLmWur6OAr9+ziPzsb6yYNAtuHIS5uVfdpYRyRaaCNXqLVv1PU7+BPXKAb0I+kcx
	0TlT2v1sP2/Hu4IAN2bdMSNpLMHmjigMoLB2yKLz+rCDqExVuwqHd+HhuqfLS7A2b0qnUB
	yV/6ySbUpobdKFyNutj0V/QtIpoa2pk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-60Tvb6b4MDWDlg5hr9a9gg-1; Mon, 21 Oct 2024 05:34:02 -0400
X-MC-Unique: 60Tvb6b4MDWDlg5hr9a9gg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539e4b7c8f4so3595279e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 02:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729503241; x=1730108041;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1qrMQuES5B03MGFeoy/Tls0FHqUcPfUE/C/kE01yJ0=;
        b=Kp17myoecq9myDxR9IbMjGJf/dJj/tUknPudKC/kNfZ24Fk7jJqQd/MNku8ix7dYHo
         pMi6YCe8r8izPfqafg9lfZGhDMkD9Ss1r7oN/2CtZbjFdXa8VFdpkgwMenqLq4OBtGth
         0KMECAtMiD9IiTJ/Pt/4HhBRb5lEhq/8csuaeJzUY2xLmLRU0XgOR22UEyQSWkbFSneC
         nv73MfKHtsiJkgIaOhlyEoUY1nBoxr3pNQ4tXoSBTnK2x1+jkptNYpDrlhL3GyId9Sj0
         tppioXYl8N+AJ/OFe2chHyzzy8lNt3bG9u3RPiy/G8RNSq6koODpTmhUy0D4m6o2bE9N
         kTyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeEOO2Qy63aOpjKuCyBtT0o/+V/TfnFWqsyi/vquc5VRRW127Q0zuSeJeA8leqDyKFauPHvFpC8d/27d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuZk3/z/OlCtxIXKk3nuzyGZqK4RPsmlYxNadojFO7rIkVkN5z
	naV9tb9EmQzjXGUQGkvVt/J5UDesfcjbtqkhevC+6syBYMg27zy1pZONS6jk1kKGN5J5cEgiYAz
	3bimb+8VcYZSXFazX/tijQVTWNU7KXA2S7bXYtmojvMJWgnCf3pIFKJoh0tZdQQ==
X-Received: by 2002:a05:6512:b19:b0:539:df2f:e115 with SMTP id 2adb3069b0e04-53a1521993cmr4562870e87.23.1729503241164;
        Mon, 21 Oct 2024 02:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9rOgj5iTkXbIp620Wgo630E2yBpSB1XyYMCGTDIjsvmCiEgeU3T276NXuPJl62rHEL7ftng==
X-Received: by 2002:a05:6512:b19:b0:539:df2f:e115 with SMTP id 2adb3069b0e04-53a1521993cmr4562842e87.23.1729503240709;
        Mon, 21 Oct 2024 02:34:00 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:36d3:2b96:a142:a05b? ([2a09:80c0:192:0:36d3:2b96:a142:a05b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570dd5sm51388215e9.3.2024.10.21.02.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 02:33:59 -0700 (PDT)
Message-ID: <4a775fd6-cb07-46eb-aa15-026e61317c16@redhat.com>
Date: Mon, 21 Oct 2024 11:33:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] Wrong value of __NR_userfaultfd in
 asm-generic/unistd.h
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>,
 Kim Phillips <kim.phillips@arm.com>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <3d07e4c3-e413-4378-82da-265a477bedb3@collabora.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <3d07e4c3-e413-4378-82da-265a477bedb3@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Am 21.10.24 um 08:48 schrieb Muhammad Usama Anjum:
> Hi,
> 
> The asm-generic/unistd.h file has wrong __NR_userfaultfd syscall number which
> doesn't even depend on the architecture. This has caused failure of a selftest
> which was fixed recently [1].
> 
> grep -rnIF "#define __NR_userfaultfd"
> tools/include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
> arch/x86/include/generated/uapi/asm/unistd_32.h:374:#define __NR_userfaultfd 374
> arch/x86/include/generated/uapi/asm/unistd_64.h:327:#define __NR_userfaultfd 323
> arch/x86/include/generated/uapi/asm/unistd_x32.h:282:#define __NR_userfaultfd (__X32_SYSCALL_BIT + 323)
> arch/arm/include/generated/uapi/asm/unistd-eabi.h:347:#define __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
> arch/arm/include/generated/uapi/asm/unistd-oabi.h:359:#define __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
> include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
> 
> The number is dependent on the architecture. The above data shows that it
> is different for different arch:
> x86	374
> x86_64	323
> ARM     347/358
> 
> It seems include/uapi/asm-generic/unistd has wrong 282 value in it. Maybe I'm
> missing some context.. Please have a look at it.
> 
> The __NR_userfaultfd was added to include/uapi/asm-generic/unistd.h in
> 09f7298100ea ("Subject: [PATCH] userfaultfd: register uapi generic syscall (aarch64)").

This is not specific to __NR_userfaultfd, just take a look at some of the other 
syscalls (e.g., __NR_membarrier).

Now, some of the files you list above are "generated". Doing it on a clean tree:

$ grep -rnIF "#define __NR_userfaultfd"
arch/arm64/include/asm/unistd32.h:789:#define __NR_userfaultfd 388
tools/include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282


But now comes the tricky part: an architecture defines whether it wants to

(a) Use the asm-generic unistd.h
(b) Use a custom one

E.g.,

$ cat include/uapi/linux/unistd.h
/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
#ifndef _LINUX_UNISTD_H_
#define _LINUX_UNISTD_H_

/*
  * Include machine specific syscall numbers
  */
#include <asm/unistd.h>

#endif /* _LINUX_UNISTD_H_ */


For example on riscv arch/riscv/include/asm/unistd.h  will include 
arch/riscv/include/uapi/asm/unistd.h which will include "asm-generic/unistd.h".

If you follow the flow on x86, you'll find that it will not include that 
asm-generic one as default.

So the asm-generic variant only applies if an arch wants to do it in the generic 
way.

$ find tools -name unistd.h
tools/arch/x86/include/uapi/asm/unistd.h
tools/arch/arc/include/uapi/asm/unistd.h
tools/arch/riscv/include/uapi/asm/unistd.h
tools/arch/hexagon/include/uapi/asm/unistd.h
tools/arch/arm64/include/uapi/asm/unistd.h
tools/arch/loongarch/include/uapi/asm/unistd.h
tools/include/uapi/asm-generic/unistd.h
tools/include/nolibc/unistd.h

Consequently, the asm-generic one should never be used directly.

-- 
Cheers,

David / dhildenb


