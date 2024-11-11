Return-Path: <linux-kernel+bounces-403814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1921C9C3B2D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD424282FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7823115098B;
	Mon, 11 Nov 2024 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d36tH/7K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01B614B077
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731318316; cv=none; b=Ja1PvZ1O3+3ldEYmu7SCLLetgp+Dpext/z9+UPfqu41vRAhV+2+nnU1r1qXWzbm1gn7Jm90uQl2NmmzGfBLkn4f4tEk2fWuPekv1hNJrM2lhly2tYPYDj1kLiDQwXqhY9Oqqbjkh+UQOZrSnutLpL4rClWxK+fL8+sjXtBRi9LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731318316; c=relaxed/simple;
	bh=PWfW0lFMI5RmAHxKxkJSlqYpc9lS6EKv7V47dSqwzac=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QIh+4qUGBjboNSxh6lhRfhltC2BDltYK6FF3t8uxssuQVRoPNq8bPYZ4dc9vVBRgPgJqvJEgJboeKIfaQJmvd9WOtW7LkMuHo0M2LRZrP4d5H+PRqVocyF/oKpHwX8DRuGRiMX/w2k4PzBRgB0nEeEg6cpXEZAC5PhnifDI7JfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d36tH/7K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731318313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DI32CLbzb4DIFTXlqgOJDrTrgAtvb1MRfZIjDM0s6K4=;
	b=d36tH/7KJQeJxFL2tjnFRKtof/HCGTnfqcZ5SP6dMwbEKjpUgXOFxYPEFcI8IRzwYsDGKx
	YkSVC/vAWzfvBa4epfop0oMd1/AsbC5eLnzQzOjzoqBGWGLv8WGL9NWNTVEeuXeo+iaeTI
	TPtmOXpu2XDGzCNu2vICoD2eLtCAfyg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-cp3PQl5oOTWMA093au1mQw-1; Mon, 11 Nov 2024 04:45:12 -0500
X-MC-Unique: cp3PQl5oOTWMA093au1mQw-1
X-Mimecast-MFC-AGG-ID: cp3PQl5oOTWMA093au1mQw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d458087c0so3179706f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 01:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318311; x=1731923111;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DI32CLbzb4DIFTXlqgOJDrTrgAtvb1MRfZIjDM0s6K4=;
        b=QoKcbGHxIZDlZQIWSzq2mfrCBoJlvRkOJk3QSt1rJQFcR+ihtZSywxU06QrF25Sx7j
         W6dTkHYcGOelYGzhMKaHTzB3QxXEOwQDyiHkO+SGU5A+xh1IlTaNu0uWAcNtDoG4CRdr
         6wUbEW2TeZjCZAnUibEzYs1isp7UQD9vO6iCeaLJKRSrtkfNtFdIIRd1L2ZuCrJNobhT
         HiR4SJfAwvXf9NvxCT8H950mvghpf3ZGrPJSJjxcmuxOVHvs2746FBAmG47ROuk5ac6i
         tT+FXqRQqTJsoVwe93sqLITRDdiszcp6uM6mI1M8UPZW4LUPy3jW0F2CQDukjHgs/Q76
         wG2g==
X-Forwarded-Encrypted: i=1; AJvYcCUt4wuG2Czy86YAh9BTWA16RH+8pm7LkQlZ1oNGZxUVu/oBykPskRNg8hqzCKbR+dJKGkxCA6Q7aBllq1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMGhNjBLzgF/vMuKswerG9xWohJrQpyXKTXrWfXx9XDjfpn/mJ
	CS8F36SpD4ynAG5uOVRHnlBhwToOOZn8MZ9G0Wku7QBea3QirPN/6GRNJRkbufMzdDjEzLgF8/X
	WasOu4N9awOYMFHciJmbAyBvzAZMePDTxV75798JaoNgVEK73gzD8hC/5Bh4zqg==
X-Received: by 2002:a5d:6484:0:b0:37d:47ef:17d0 with SMTP id ffacd0b85a97d-381f1a7e56cmr9692894f8f.13.1731318310918;
        Mon, 11 Nov 2024 01:45:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkx47a+5gX71EbGG6j/ekhWkGU6bjTm+udfO6AHpx6dNLjpGkYa+wbY14xEkB/RjavGxg1sQ==
X-Received: by 2002:a5d:6484:0:b0:37d:47ef:17d0 with SMTP id ffacd0b85a97d-381f1a7e56cmr9692861f8f.13.1731318310462;
        Mon, 11 Nov 2024 01:45:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c730:4300:18eb:6c63:a196:d3a2? (p200300cbc730430018eb6c63a196d3a2.dip0.t-ipconnect.de. [2003:cb:c730:4300:18eb:6c63:a196:d3a2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97c976sm12316138f8f.28.2024.11.11.01.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 01:45:09 -0800 (PST)
Message-ID: <638e9672-850c-4bcd-bf5c-46a86be906f9@redhat.com>
Date: Mon, 11 Nov 2024 10:45:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] WARNING in get_pat_info
To: syzbot <syzbot+16b1da89309a06cd0e3a@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, bhelgaas@google.com, bp@alien8.de,
 dave.hansen@linux.intel.com, guohui.study@gmail.com, hpa@zytor.com,
 jannh@google.com, kirill.shutemov@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
 mingo@redhat.com, peterz@infradead.org, seanjc@google.com,
 syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
 torvalds@linux-foundation.org, x86@kernel.org
References: <6731a6c4.050a0220.138bd5.005e.GAE@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6731a6c4.050a0220.138bd5.005e.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.11.24 07:40, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 79a61cc3fc0466ad2b7b89618a6157785f0293b3
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Thu Sep 12 00:11:23 2024 +0000
> 
>      mm: avoid leaving partial pfn mappings around in error case
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11df65f7980000
> start commit:   7758b206117d Merge tag 'tracefs-v6.12-rc6' of git://git.ke..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=13df65f7980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15df65f7980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=921b01cbfd887a9b
> dashboard link: https://syzkaller.appspot.com/bug?extid=16b1da89309a06cd0e3a
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148adf40580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1704ae30580000
> 
> Reported-by: syzbot+16b1da89309a06cd0e3a@syzkaller.appspotmail.com
> Fixes: 79a61cc3fc04 ("mm: avoid leaving partial pfn mappings around in error case")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 

As discussed elsewhere [1], the patch [2] from Peter should fix this one.

I should probably resend both VM_PAT fixes that are on the list in a 
single series.

[1] 
https://lkml.kernel.org/r/262aa19c-59fe-420a-aeae-0b1866a3e36b@redhat.com

[2] 
https://lore.kernel.org/all/20240712144244.3090089-1-peterx@redhat.com/T/#u

-- 
Cheers,

David / dhildenb


