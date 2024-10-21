Return-Path: <linux-kernel+bounces-374269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0789A67AD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E362EB22305
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B1E1F12FD;
	Mon, 21 Oct 2024 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcL+yw6y"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5FF1D220E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512727; cv=none; b=DBLD1cyQcAPBHJK5IaIkllqbJbjxUuYVxtrYlsTrhzOdtiv8V9yx6abkfd3wnrfUMi7NqEqImrHSYZnFTvbcW5Z4tSpbkJgqXUyWL/lBxNKxYPVRpdouOvGdjNvgpP/0MvzSVI69fHQ/QxIirhwZ1pKjpvstfLka00pEbmgM0vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512727; c=relaxed/simple;
	bh=ScfSHddVZu23+piJqKARNWnnHsW3UksHNVPYw2/ckr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pqERLF9EznldmslGwX4aBpz7LCD7zJvI9bIXz5Emdfjyz9YbhXHA72UOtGc5Qo+zaie4/D/ZPrkXOXrUHdXWLEbi8tyTLynu0W2HTjoyBQVFGMTWVLuJu7qoUqvGhSFk/LCqltY4DjIVGST8/srtdjlNWVIRz8GzyddMmMcovC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcL+yw6y; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2c6bc4840so3164629a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729512725; x=1730117525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xF6/Ic9v6OJ/Y6A3E/2TG5AwOYv4mf/4nXJ6EAwvg4o=;
        b=bcL+yw6yeFauMlCm4euuwsZD0x/FhfOtPW7waUBXxsvAkiNq+oeF/jAwYEGtnGKRsU
         YQyVWaQblTqHU5oav5WWw7waTv/hNbFDcK5RivF9V7tdJOtKBNkpW/g694nssFUBrOwo
         HAfucxujssDFIsx1vW9tXZqbTE45l6T8m/GVnHwJc24d0XE7DkUmjhE065LAjvtoBU4k
         +9IA3qs83DGDzVfOmoxOwe0czzKmHIJ+5OAahOMeS8TPHtNZ0VEke9HwyrYLB90NsAOm
         B3I01EIwZdCIThLX2hjjJHZ9Ke3nxMKy6XBBWdJsA9/xMRZ5iIs/5+IspXIuz8pe4NG3
         I8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729512725; x=1730117525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xF6/Ic9v6OJ/Y6A3E/2TG5AwOYv4mf/4nXJ6EAwvg4o=;
        b=NYnsRY+OtDGWQaGh2L8buw1S/YRlPXsB5ANwrNAP8EbdC0z3ldSDPTUEqK/v23SGtl
         CR66ranXbLG1Eso1BaCAI9S0+gn7+6kouPeRtR7V9YCypos0DNMvxwhEpjG/34GtfjR8
         LzAlD2zLsoZnwfKAp2c5US1QoCCvi6kh09dE5K8U2jO/wOElsKiMY+UERYBjjHgGCQZz
         WjksN32DjfmMw0yrRcOhKpIPEG0wpIM5yqBHKISPfLZQB2pT2+MfTOMs79y7GA997TUs
         tS19Gy2ryTisVoP7jM98LnJGitJ4VusyunL6L3BtJLuYT4qLtz6JAB8lxFAjtUh81dwd
         //DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjwMckZI0fleJ/mUALamTG10hFD4cpJcb4ca8N9yXhF6sB8r78opqoD8HQQ0qMGjnQh/2P/hY+p8E1QgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziLNXfj/BL1MbCX+X1+Rc3d095xFvbBEP4A42wOGiGCbOhJmdf
	iw0waaFG/1FU9az6Xq2GxSRfj6kG0Xrof8uMVKd8SWsnZUUtBbnm
X-Google-Smtp-Source: AGHT+IERztfGYJvtlKj55iQq8SK7tQD+rxLE3qOHXPCkCobZKQZqc3te3Y1jB7vqkAQvBSzXe1OIaQ==
X-Received: by 2002:a17:90b:1088:b0:2e2:e769:dffe with SMTP id 98e67ed59e1d1-2e5618da95amr14134329a91.30.1729512724821;
        Mon, 21 Oct 2024 05:12:04 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad4ed7f3sm3538944a91.38.2024.10.21.05.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:12:04 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: john.ogness@linutronix.de
Cc: christophe.leroy@csgroup.eu,
	hbathini@linux.ibm.com,
	leobras.c@gmail.com,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	naveen@kernel.org,
	npiggin@gmail.com,
	pmladek@suse.com,
	ryotkkr98@gmail.com,
	sourabhjain@linux.ibm.com
Subject: Re: [PATCH] powerpc/crash: Allow direct printing on kexec
Date: Mon, 21 Oct 2024 21:11:59 +0900
Message-Id: <20241021121159.331940-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <844j56v75z.fsf@jogness.linutronix.de>
References: <844j56v75z.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi John!

On 2024-10-20, John Ogness <john.ogness@linutronix.de> wrote:
>On 2024-10-20, Ryo Takakura <ryotkkr98@gmail.com> wrote:
>> Let legacy consoles print directly so that we can see messages on kexec, as
>> the commit b6cf8b3f3312 ("printk: add lockless ringbuffer") turned printk
>> ring buffer lockless and there should be no worries panicked CPU 
>> deadlocking writing into ringbuffer after shutting down non-panicked CPU.
>
>It is correct that the ringbuffer is now lockless. But the legacy
>console drivers are not. Allowing them to print directly in panic can
>lead to similar effects that commit af2876b501e4 ("powerpc/crash: Use
>NMI context for printk when starting to crash") was working around.

Oh I see.
I wasn't taking the locks acquired by console drivers into account...
Thanks once again for the feedback!

>Note that although printk is deferred, it is only the printing that is
>deferred. The messages are landing in the ringbuffer immediately. So
>they would be available to kdump and crash kernels.

I also agree to rather skip printing and leave it to kdump and 
crash kernels considering the chance of pointed out risk on panic.

>Rather than removing the deferring, it would be better to convert the
>console you are using to the new NBCON API. Then it would be able to
>print direct and safe during panic. (printk_deferred does not affect
>NBCON consoles.) What console driver are you using that you want to see
>the messages on?

I was working on qemu ppc64 this time but I am usually working on 
Raspberry Pi 4 (mostly for fun and study) which uses either of 
bcm2835-aux-uart or amba-pl011. It would be really nice to see them 
working as nbcon!
I am thinking of taking a look at [0] but If there were any other 
references, I would really like to look into as well.

>John Ogness

Sincerely,
Ryo Takakura

[0] https://lore.kernel.org/lkml/87wn3zsz5x.fsf@jogness.linutronix.de/

