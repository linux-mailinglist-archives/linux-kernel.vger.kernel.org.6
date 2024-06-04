Return-Path: <linux-kernel+bounces-200746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D278FB456
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62B61C22525
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC01BA49;
	Tue,  4 Jun 2024 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNumM4CT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7EC63E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509050; cv=none; b=W7lpTeYGxpqJdNKIAqLWcvkQBKqi2L1Xs3HqkfDEsooWv2/4muVw5WJTo2y8OUBoVQgQlDicrgD532jMvvPW83x+QpJGAd89MgKBCshXQeACTQVAF/Kw2/MW5McuPxQssvpYUn9kQxTolzVQxiPb29opjfj8N8Qb+j0KcgzEhRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509050; c=relaxed/simple;
	bh=HGrF2tL4w7a7Rmlc6G9s37xvs7pZ1x+R4NOwXaeZfC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLNvhluEWZZBJJWjyFLLx6vGmwxYXDoIQs2MzY5Ycl9R5bpyr8DJ3W3kzZ5z545zyhkMRUmaDPVoVUeLYN6Sf6/7KLJS6eVF93J5X8ukPY1H3XPDxw2eBRCE390CHF84jEaiHZJW2bYGolBkFxyPT1bY73gWdEVPyHF4Na4Rs24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNumM4CT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717509048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=u/pd06+ksW1iJGXtXxv7mdOfhdSquA4khvqGMWC/0Pw=;
	b=iNumM4CTNBGH8khZZ3oVh/qTizsgcqPkH+2NTCFmp0xsU7qKyxEiF+FPGgmB8j/0bCSNU7
	JzjLoaF/lcoQGoA+9pgKZgv50FK8L+bFtiTIbhuqklkjMPsO/ihTpyVAhOHecraUUxrY3z
	oqLSzPfhAAtA7qM4UxaRaVlNT0yMDXA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-NFvHBCoRP9WgfhVU-VMlXg-1; Tue, 04 Jun 2024 09:50:44 -0400
X-MC-Unique: NFvHBCoRP9WgfhVU-VMlXg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42135f60020so23336145e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717509043; x=1718113843;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/pd06+ksW1iJGXtXxv7mdOfhdSquA4khvqGMWC/0Pw=;
        b=uJPYB+o5+cz1+yj5sDtRcQUGes79Sun9NohV/GtL5tGOkWDgspuS4g7p9B+egtlveM
         GWE5AGHCFhDZ0sQi8t1SphGz2QFRALPkMvl6I+kd8ofIr2idYCjB/ZIizKzzxE33UenB
         7Sj2oL/AcuPN3UfqqkY2YT1Vyp12rcE2xFMBLfisi46a7EN+XOpXpIIKnN1faj0HkALm
         wpL8aLJvYLABRADXykEFR+QBGRkejjcsB51H+uW11FBU7nbAIwMBeq76THH3QbyVz0Li
         7RImgBPOwXkYqanaNSswwTRRp26cjJdHbRjARAjYGmqLULgIzAoIuHPGoEK18+KK1U7H
         Q0wg==
X-Forwarded-Encrypted: i=1; AJvYcCU4x11oOjPavX0OO+LtPFRlyC8ujUMegF6rQCAMJCbvWk5gDN7rFSdQksyS25nAfwuuFRHfTowWLkCCpqUhnQ5ZNDGounRn4tmlla6j
X-Gm-Message-State: AOJu0Yzv82fuUU8rxCj+XUPnpHjZweke6NRU6zl4cXS9to5m446IHday
	uS86guul46ij/jxmZ5UTnZupS3iWU0yqzxmSPLZ02VYkBXBVabA2MeOXqdvn1Zje50n7cuCmQuc
	MPhYpUfj1w/uHTjvEIXrL+ktRhb2lB7b07P3HhUW91OGTZ+Jo1X718HQ6RFM1bw==
X-Received: by 2002:a05:600c:5026:b0:421:15f:186a with SMTP id 5b1f17b1804b1-4212e0bfe7amr105938545e9.39.1717509043564;
        Tue, 04 Jun 2024 06:50:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBeeiLuUqL6x+5wi6STHFYO0416+ZGfZC7HExXsv6Mj8v9Nr0tg93Xr0FzR304lmJAk8rwtA==
X-Received: by 2002:a05:600c:5026:b0:421:15f:186a with SMTP id 5b1f17b1804b1-4212e0bfe7amr105938365e9.39.1717509043157;
        Tue, 04 Jun 2024 06:50:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73a:3a00:a025:9b06:549e:c16b? (p200300cbc73a3a00a0259b06549ec16b.dip0.t-ipconnect.de. [2003:cb:c73a:3a00:a025:9b06:549e:c16b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4213709a0d2sm115216505e9.26.2024.06.04.06.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 06:50:42 -0700 (PDT)
Message-ID: <af28ece4-0a94-4e3c-979f-062044ea0cf8@redhat.com>
Date: Tue, 4 Jun 2024 15:50:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] 6.10.0-rc1: segfault at 0 when reboot with kernel config
 INIT_MLOCKED_ON_FREE_DEFAULT_ON=y
To: David Wang <00107082@163.com>, yjnworkstation@gmail.com
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org
References: <20240528151340.4282-1-00107082@163.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240528151340.4282-1-00107082@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.05.24 17:13, David Wang wrote:
> Hi,
> 
> My kernel is 6.10.0-rc1 with CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON=y, and
> I got following screen when I execute `systemctl reboot` on my system.
> (The text was extracted from a console image, there may be some parse error. And my kernel was tainted mostly because of nvidia driver)
> 
> 	42.855067] watchdog: watchdog0: watchdog did not stop!
> 	42.905871] show_signal_msg: 14 callbacks suppressed
> 	42.905874) systemd-shutdow[1]: segfault at 0 ip 0000000000000000 sp 00007ffcc8af7318 error 14 likely on CPU 6 (core 4, socke 42.906017] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> 	42.906080] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 	42.906143] CPU: 6 PID: 1 Comm: systemd-shutdow Tainted: P OE 6.10.0-rc1-linan-0 #244
> 	42.906220] Hardware name: Micro-Star International Co., Ltd. MS-7889/B450M MORTAR MAX (MS-7889), BIOS 2.80 06/10/2020 42.906308] Call Trace:
> 	42.906329] <TASK>
> 	42.906346] panic+0x31d/0x350
> 	42.906375) ? srso_return_thunk+0x5/0x5f
> 	42.906411] do_exit+0x968/0xad0
> 	42.906441] do_group_exit+0x2c/0x80
> 	42.906472] get_signal+0x876/0x8a0
> 	42.906502] arch_do_signal_or_restart+0x2a/0x240
> 	42.906544] irgentry_exit_to_user_mode+0xc2/0x160
> 	42.906585] asm_exc_page_fault+0x22/0x30
> 	42.906619] RIP: 0033:0x0
> 	42.906640] Code: Unable to access opcode bytes at 0xfffft fffffffd6.
> 	42.906693] RSP: 002b:00007ffcc8af7318 EFLAGS: 00010206
> 	42.906736] RAX: 0000000000000011 RBX: 000000000328adea RCX: 0000000000000005
> 	42.906794] RDX: 00007ffcc8af73b0 RSI: 0000000000000ea8 RDI: 0000000000000001
> 	42.906852] RBP: 00007ffcc8af73be R08: 003b459fca9238c4 R09: 0000000000000069
> 	42.906910] R10: 0000000000000008 R11: 0000000000000202 R12: 00007ffcc8af7330
> 	42.906968] R13: 0000000000000ea8 R14: 0000000000000000 R15: 0000000000000000
> 	42.907029] </TASK>
> 	42.907328] Kernel Offset: 0x21a00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 	43.081928) --- [ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> 
> 
> I rebuild the kernel with `CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON not set`, the system can reboot normally.
> My guess, some memory is zeroed unproperly when reboot?

Stumbled over that as well [1], maybe because of the messed up 
interaction with fork()..

This should be reverted. Waiting for Andrews reply on my mail before I 
send a patch to do that.

[1] 
https://lkml.kernel.org/r/4da9da2f-73e4-45fd-b62f-a8a513314057@redhat.com

-- 
Cheers,

David / dhildenb


