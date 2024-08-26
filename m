Return-Path: <linux-kernel+bounces-302111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEC695F9EB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3AADB22CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554F212CD89;
	Mon, 26 Aug 2024 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b="japOw5UI"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AA61F943
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701604; cv=none; b=SG1XAQOVQ3dmKb59yuTHONjwGQuXLiQN8pJkks9J/xCH2ToGLyFEDiCQuhKOdZaqCfUkanULdojPUK0nWYj80nwBLx7GL6+IivL2vL8kE4uoOmavg0bxojPW0BnAZhsdk0Ijedv09fyReWR7TM3vUMlf4GKmmWSH/bwd1LJzqIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701604; c=relaxed/simple;
	bh=xZC7Y7GU0zcEzKHChNxej8vT90J9J2UDFdj42WyJprU=;
	h=From:To:cc:Subject:In-reply-to:References:Mime-Version:
	 Content-Type:Date:Message-ID; b=rxoC5QOaOoeMKdzZIOXnRpxkPTFvZhiVdlEk+ATTRlbfCv5vOlEsVqi9uPks2L5tuDiajliJWVFFXgi6jhjgAmtK7eR4eFSzw9aNf61xT0at2frAdOmcmAmWrWMCAbjx34dwEd3PYqmYua+B51F9G2Pn4LuiRB0d64Mhu0PgflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu; spf=pass smtp.mailfrom=vt.edu; dkim=pass (2048-bit key) header.d=vt-edu.20230601.gappssmtp.com header.i=@vt-edu.20230601.gappssmtp.com header.b=japOw5UI; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vt.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vt.edu
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1d42da3f7so299399885a.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1724701601; x=1725306401; darn=vger.kernel.org;
        h=message-id:date:mime-version:references:in-reply-to:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ldNdAhKKzaSqr9ERET8WGas8/RLyJLHDmEozqXzjuf4=;
        b=japOw5UIijQy92voZhL2yL3GCHpl3DyS9tX/a7nCKFUwlPrTkBW+BAbhxxFkCdzbjY
         mHLN4+gqAkm14Q7YQVmbEG/MvEJacBc2wRzPfSg5m018trP7et4GJhLkgT6eUoxFxpA1
         yoIMfQ8Zkv8gciTusIHoxInL/xY+4nmP+L6riASdX5cczEpkmT7s9NnaCX/3KG1+rvJf
         TOB+OwECKXeFV6WPACNdd4FHXf6nVWxYXbdvasVzFBPLfwCsMcTlLwDa6nCfVOQM4oxw
         0GFz/R5x9dDHu3zSsTUnFqCJ2WbC63zntiM+VPN0wl7qtJHo5M7Nv4pOppeBJUC6yufq
         /ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724701601; x=1725306401;
        h=message-id:date:mime-version:references:in-reply-to:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldNdAhKKzaSqr9ERET8WGas8/RLyJLHDmEozqXzjuf4=;
        b=ij566bbLOzySILnW9Xo/oEHNtE4ggTVS14IOTsvsKEGXloMw69YNEvj/CAbaKdnkpC
         Gd+EjbhRn7HLIDebrAA3mxmnGaZ8MrmpYElLjVvKnJjR7VA8xj5EJUUQA7HOBWvXXqLE
         zrzrqvF3ZWoO0iPoSr3RjqTgWR37eYHbqpaCfODBdem5IJV8hK2SN3Ao6wHoAMVuaD+e
         EcxAVu9Hwz5aetPJ5dxo1rbQIax2GRM2TD1zpsNvYeCIlMsG//m2UwCRpWqCR8hCbCVP
         UYZg9X1TEta6kmnltCp6u86F6dk6Uk1TbSeLFH86gGzsPJhCaVoIzWzHOD6mJVsC8Iu9
         qePA==
X-Forwarded-Encrypted: i=1; AJvYcCUoXRkwsG3sB/BE/ZwZNvD4CTVIoScg7qnv9AxUTTZ8czokdOl2YZBRylQh8uVEYw1Lwq9H2ZOvKjXnOLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyypRLz5A34Wjh0Dd7cx5Y5pgtdLsEv9QR+4kkF5E1aQYslhUyu
	KKCxncowVa2+xZcw3g5AnXjCkO7hnzJTF5IcMvf0wXbZcosLv5T1K1Ug7JmBf4I=
X-Google-Smtp-Source: AGHT+IHSt2ZDjFKsrx8cKZdACVC77PYM0eLmNVQqOPrI9VKnbgSdrVONsF4R2q9XInSB/Qof3/IWCQ==
X-Received: by 2002:a05:620a:2401:b0:79e:fcb5:55e2 with SMTP id af79cd13be357-7a6896d66b9mr1306069385a.5.1724701600998;
        Mon, 26 Aug 2024 12:46:40 -0700 (PDT)
Received: from turing-police (c-73-31-28-59.hsd1.va.comcast.net. [73.31.28.59])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f41d415sm485696185a.125.2024.08.26.12.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 12:46:40 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.8+dev
To: Muni Sekhar <munisekharrms@gmail.com>
cc: kernelnewbies <kernelnewbies@kernelnewbies.org>,
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: Query Regarding Stack-Out-of-Bounds Error
In-reply-to: <CAHhAz+hjhZQnTWX088EmMDbszAJrrBQBqkhvfiMjxQPNtWbkqw@mail.gmail.com>
References: <CAHhAz+hjhZQnTWX088EmMDbszAJrrBQBqkhvfiMjxQPNtWbkqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Aug 2024 15:46:39 -0400
Message-ID: <212937.1724701599@turing-police>

On Mon, 26 Aug 2024 18:04:39 +0530, Muni Sekhar said:

> static struct cmd_info *find_cmd_entry_any_ring(struct intel_gvt *gvt,
>                unsigned int opcode, int rings)
> {
>         struct cmd_info *info = NULL;
>         unsigned int ring;
>         ...
>         for_each_set_bit(ring, (unsigned long *)&rings, I915_NUM_ENGINES) {
>
> In the above code, a 32-bit integer pointer (rings) is being cast to a
> 64-bit unsigned long pointer, which leads to an extra 4 bytes being
> accessed. This raises a concern regarding a stack-out-of-bounds bug.
>
> My specific query is: While it is logically understandable that a
> write operation involving these extra 4 bytes could cause a kernel
> crash, in this case, it is a read operation that is occurring.

Note that 'ring' is located in the stack frame for the current function. So to
complete the analysis - is there any way that the stack frame can be located in
such a way that 'ring' is the *very last* 4 bytes on a page, and the next page
*isn't* allocated, *and* I915_NUM_ENGINES is big enough to cause the loop to walk
off the end?

For bonus points, part 1:  Does the answer depend on whether the architecture
has stacks that grow up, or grow down in address?

For bonus points, part 2: can this function be called quickly enough, and
enough times, that it can be abused to do something interesting to L1/L2 cache
and speculative execution, because some systems will fetch not only the bytes
needed, but as much as 64 or 128 bytes of cache line?  Can you name 3 security
bugs that abused this sort of thing?

Free hint:  There's a bit of interesting code in kernel/exit.c that tells you if
your system has gotten close to running out of kernel stack.

[/usr/src/linux-next] dmesg | grep 'greatest stack'
[    1.093400] [     T40] pgdatinit0 (40) used greatest stack depth: 13920 bytes left
[    3.832907] [     T82] modprobe (82) used greatest stack depth: 8 bytes left

Hmm... wonder how that modprobe managed *that* :)


        

