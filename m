Return-Path: <linux-kernel+bounces-174598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2C08C115E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACA7BB217FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5D83AC2B;
	Thu,  9 May 2024 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhUt2G8P"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799CE2C683
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265567; cv=none; b=BebMzfrU5aCRRhz7L9OXUX+77mygMqFH5t7NTMEAwTCl6NT2R13CRNbQps/magQl8er6D91AT1FOO3XBNk7dpOjxqk3DwFnrFJqfhXMxxKrFra3glNewQ4VAcHJOIT2gL1mfcx5lFK4qcv/RceT5flHBAbcjhg8Myg60cMopHfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265567; c=relaxed/simple;
	bh=e4tPfjYMgnYgzdvbv0igdz0nugwTuBFyfkXUhHnWO+Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=EqhUPOq5DqI/HU/+jS40y0+0TTL4Hv/PhCmrScjgkUtcpUqqd+JcRUN2ptfAox9whXXDXCGvEgpPyIiJXwr0NKPxDZSUNdSvJFIQcPjXAnMejvDbUXwx2N5cifGwb3yTTcpw2t/fO57qiotKOWh59BNbCNGxymIGeu1MCj2w8MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhUt2G8P; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-de462f3d992so997149276.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715265564; x=1715870364; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ve3gsjSEOvuMwQiH+NbsNTGdRZOJIKD3aizKaJe9iMY=;
        b=AhUt2G8P8msXJyetbTrdCz7Hfo7QLIpmzfSi9IHwQa9+R2nN75MH+6ulp77rE3qsgV
         PCkayFvVep7B1CA/dNx0Z/+T72Zj4imuGVu6JxOcm+l8TlncpRGcbtBMepDFEBYYnIwi
         YkAWd45zO4jvaKsbnbI4XpKSy1eZitR7HEPaMxwqIjXr0081XtzhFydcP/kMbrAJ9NoJ
         T1EAQO0DRK8UQQsipsZ7O6OdRfO7ciTH+AbzisOro1uzWpzZL1yJwiUIs/rrK5McCUY9
         jtS/fVo2DlKbz6ktTilFUCi0heaQISgFwYA/U3M82nTBslto69CmyAUn8OWCwHDJs2oq
         a8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715265564; x=1715870364;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ve3gsjSEOvuMwQiH+NbsNTGdRZOJIKD3aizKaJe9iMY=;
        b=ATfLT6BBCHLdXubkvFOYkIhSNUB64rmfX/6LCGVDQWzjLkvHdZvRiWq5NpibYBdWWM
         Lr+0iT01vxnXtjZYGBK6f2jXG8HNa3mha2IWIDfS7C3PlcmQTmpn3frLftGbDQ2Msugc
         /TQ6EnFYm394PEWGQvpYBFQWRRSLWyURCkKXVAO7JHHZ41woZ8RR8eV0Fwk7Y5I/tXRd
         TrcRYIkPV3tRzqQxso1sGK/lwB2JoYwyxZZj6Ys+f4LjCacfVfW8syFZ4j5qxZpPlRB8
         P/I6xqsOz1561ERP60P7HPFk8t2yWLgmdBcYdlEepi50b7TXm8uO85RPuo3mVoy81pLG
         7rwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5Baiw9dZRO0KGXynOfAeAN3KoPKWgFLtVdXu2aW0Sw9mOZqyrtNAWDZHRJ7J2bXMQ7jbdrNtyaja80B4bqC9cwFhtd6QOjWt7NG89
X-Gm-Message-State: AOJu0YwS3FUK/JucrqOSH/Dg3gDqSNxqWcYlrh5o8+U6Iyarl95nBYUF
	qRTLfG+t6mkJgsmlU2dx9qmb7lHp1cVK5Rb7FTHXqTa2mVLSTcuy88C/zKx/ybRZ12h//vifepf
	b8LMk0M1VHG1NdiFmBIuBH2Mr5uXVc9Oe
X-Google-Smtp-Source: AGHT+IG6wgVzO4zc7zONilTMrqCTYYFU85r0vA2D88Md0hHDMTcQI6+jSbHXu5hwYuT31uS/w79bV4xSPvo8Xmkevb8=
X-Received: by 2002:a25:e206:0:b0:de7:61db:9fa0 with SMTP id
 3f1490d57ef6-debb9d036e2mr6003130276.22.1715265564433; Thu, 09 May 2024
 07:39:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Thu, 9 May 2024 20:09:13 +0530
Message-ID: <CAHhAz+isxCcxq3QLqmapcQwvZDYb-PL7FAi2cFMgFwXVNU2h7g@mail.gmail.com>
Subject: Seeking Assistance with Spin Lock Usage and Resolving Hard LOCKUP Error
To: kernelnewbies <kernelnewbies@kernelnewbies.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Community,

I am reaching out to seek assistance regarding the usage of spin locks
in the Linux kernel and to address a recurring issue related to hard
LOCKUP errors that I have encountered during testing.

Recently, I developed a small kernel module that involves ISR handling
and utilizes the spinlock_t primitive. In my module, I have employed
spin locks both in process context using spin_lock() and spin_unlock()
APIs, as well as in ISR context using spin_lock_irqsave() and
spin_unlock_irqrestore() APIs.

Here is a brief overview of how I have implemented spin locks in my module:

spinlock_t my_spinlock; // Declare a spin lock

// In ISR context (interrupt handler):
spin_lock_irqsave(&my_spinlock, flags);
// ... Critical section ...
spin_unlock_irqrestore(&my_spinlock, flags);


// In process context: (struct file_operations.read)
spin_lock(&my_spinlock);
// ... Critical section ...
spin_unlock(&my_spinlock);


However, during testing, I have encountered a scenario where a hard
LOCKUP (NMI watchdog: Watchdog detected hard LOCKUP on cpu 2) error
occurs, specifically when a process context code execution triggers
the spin_lock() function and is preempted by an interrupt that enters
the ISR context and encounters the spin_lock_irqsave() function. This
situation leads to the CPU being stuck indefinitely.

My primary concern is to understand the appropriate usage of spin
locks in both process and ISR contexts to avoid such hard LOCKUP
errors. I am seeking clarification on the following points:

    Is it safe to use spin_lock_irqsave() and spin_unlock_irqrestore()
APIs in ISR context and spin_lock() and spin_unlock() APIs in process
context simultaneously?
    In scenarios where a process context code execution is preempted
by an interrupt and enters ISR context, how should spin locks be used
to prevent hard LOCKUP errors?
    Are there any specific guidelines or best practices for using spin
locks in scenarios involving both process and ISR contexts?

I would greatly appreciate any insights, guidance, or suggestions from
the experienced members of the Linux kernel community to help address
this issue and ensure the correct and efficient usage of spin locks in
my kernel module.

Thank you very much for your time and assistance.

-- 
Thanks,
Sekhar

