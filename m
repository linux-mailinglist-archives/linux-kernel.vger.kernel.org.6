Return-Path: <linux-kernel+bounces-261233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7569E93B477
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C4B1F2319D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C363F15B554;
	Wed, 24 Jul 2024 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jyYXISrx"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F6415AD9C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837093; cv=none; b=lJNQG2ifjQf8KilfI6k8iAcSn6PevTFq67C4K3n8b7ywbLZyMP1vV/wOk21Os3DEd0nfaHKVu9lrx1hmduwrNv8okXKKDOylGlxvELOf73Xr1KQD814yv+cnzoE5MROge20p+uMhTHtqyXfbMm2SDsZ8e7xCDAnZdFAs+UG7SQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837093; c=relaxed/simple;
	bh=ikr5gBDonD2HiJyXw8Ll+c9f+0oV8ZZiCajLfU8r9Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KvtMNh50dRm6SopMNss2Ehs8mhzl74ddbYOZ9FXFoAFHkqrfW2gNzW9FHZMlvFOsQ6VRuwzyB/tblcZaGd8W+QeBl62b0Im9mXIEeIoF78UORPrKM/rN3F9/xYN2/6IdNCdkYH+mkVQt99xHi6d6EDAq2uxmI3s4zL9GUCmjK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jyYXISrx; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-26123e59c8aso455866fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721837090; x=1722441890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=73tMw1OHE7WOpgExgYC8KyJEfylv1G/UmprndBPGk5A=;
        b=jyYXISrxwa2vUMpBoRErfN6E/q685nrZbbiKJ+nyHSdzBhGKMY5MkbEZQHnx1vbAVP
         MTIRIu9qm0XSbyqIOwSOJlLyUVL06YJSWKKK1bgkp7Lrs5n6Q1kVTayRhUAiyIwKiqxJ
         ekRjh16KB5+J08+hKaHNItUBrzYCH8ZVvQcSLoPr2etrCn5+uvZzy2JYOJUeBnKhI3uP
         LE6VTVzuclybkQ9qF9xzSU5GAwA+uRu9tdjFxWjj2RUYbRW7HRqzD4VBT1R6iev9YB5F
         kh1lsqaJxwrBUmf2c6OkNaLQVVggl3FmlRLuNoQcUHomcFrsOgLRrDd/3UYAM9ExhtrH
         K0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721837090; x=1722441890;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73tMw1OHE7WOpgExgYC8KyJEfylv1G/UmprndBPGk5A=;
        b=SYbblEnTyFHei1k9+iw32qUYLifcckMj31yGIB6KwX2CYSDDQ/7Bu9uLSH7kN3mdXD
         EChF4BPOOQI4PAB0ls3PwHq9rU2c1haSsqe5G6GCKku+PsjuUZBuaCng0ZrJM4SiMBB2
         ZC4KcEFPst6DU4GgpXDwxo+icaK6LCOus4ITfBneSRNxASqvXvjZzumZJJ/5K9O7HUB/
         dzweJNqv7MM95aS/ui5XdpPuqbwcQCgIasM5VaNwNVfJUjmFPlUbCyGdSYTkv9ULjSff
         1r+ESZhssP12ZVXiAuJsIFysDctd5hLDgKmvbyTloX9CNkVdRG6/AfdjS8jdHFY35Myx
         K0xg==
X-Forwarded-Encrypted: i=1; AJvYcCX6l4HoV/6kOq49uVDNXRlAeueNs3IkqBb9PiYJB24Sk3YP9ITTdJukVdOvZfayAzES1I4D0UxG96FwsGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywji6ZUc8YaNkGSX9B8cFqA0cedbzNyLtcndOQqfmujFpRMPmuP
	hRr3MDqE+k3ls1p6sRvm6yWCUSfBukMu7SGXf2g7oNIde0jITq6fsM+L+3vLfRc=
X-Google-Smtp-Source: AGHT+IE9gRK4HqlMFJboJ1JjeeShuFTXZe9GG2HtHQujHg3wQqWC/zNQbJAHHcwTFZ2c/kgv/Feyig==
X-Received: by 2002:a05:6871:5d4:b0:260:ccfd:b26f with SMTP id 586e51a60fabf-261215b53a1mr7829383fac.6.1721837090055;
        Wed, 24 Jul 2024 09:04:50 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2610c771ca0sm2637301fac.20.2024.07.24.09.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 09:04:49 -0700 (PDT)
Message-ID: <90188833-f819-432b-a865-bbba14166e46@kernel.dk>
Date: Wed, 24 Jul 2024 10:04:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in
 io_req_task_work_add_remote
To: syzbot <syzbot+82609b8937a4458106ca@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000fd3d8d061dfc0e4a@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000fd3d8d061dfc0e4a@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/24 4:51 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    933069701c1b Merge tag '6.11-rc-smb3-server-fixes' of git:..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=16e38d5e980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c062b3d00b275b52
> dashboard link: https://syzkaller.appspot.com/bug?extid=82609b8937a4458106ca
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149e5245980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1388c55e980000


diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 2626424f5d73..1aaab21e1574 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1137,9 +1137,10 @@ static inline void io_req_local_work_add(struct io_kiocb *req,
 	BUILD_BUG_ON(IO_CQ_WAKE_FORCE <= IORING_MAX_CQ_ENTRIES);
 
 	/*
-	 * We don't know how many reuqests is there in the link and whether
-	 * they can even be queued lazily, fall back to non-lazy.
+	 * We don't know how many requests are in the link and whether they can
+	 * even be queued lazily, fall back to non-lazy.
 	 */
+	req->nr_tw = 0;
 	if (req->flags & (REQ_F_LINK | REQ_F_HARDLINK))
 		flags &= ~IOU_F_TWQ_LAZY_WAKE;
 

-- 
Jens Axboe


