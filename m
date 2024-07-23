Return-Path: <linux-kernel+bounces-260270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C7193A540
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AEE51F233F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0D41586E7;
	Tue, 23 Jul 2024 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TLKx7f9v"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199D013B5B4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721757921; cv=none; b=jjUVoqOdGsE1MWtmkyBAq5UMOzQaVkBmFc2Y2dy5LwTUyNPuN40eEkK7/hJzBKFzH97uqmXlrC6I8ir93GyR0BwvTBtASCOXaqAShJP0nuOKM5j0/oMcq2ctEvmnXakhFreSczpQe8iloRn1rSWKOmdtpIkRO+2ubKcoAPqkTIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721757921; c=relaxed/simple;
	bh=p16Kl+/h6SFb3QdRQaiGCT82C2IdSvh1iZgreJNmEEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWAoZnXsx78DP5lW0LEfZo8EGtBe6jxyzrYl6bxyiFaWfmeuH1OVnFsyaUu0u+ceMlT+HHu1XPJAY9W7d0kfWqgKToMy1wmb5g4TuRHZKss0fcfyw8U85DJQVogMwcFSR9CZ8aJuHA3udKJxxpGr5O/yNmaXCoOQkZho9DnQQiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TLKx7f9v; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso19031566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721757917; x=1722362717; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hsGKAY1d9cfwS3hv7NQu8xmVyigzJFwKRal6P2bPrxY=;
        b=TLKx7f9vaEtBVchMKuCNSUC2F3YP2XgIxp5Ek+TfhyW1xTsxT9DTF23I+WJYbOj47I
         rjoG2Jw2zKTgYfQpI3Z7QGck8OJot0jsyXLsuGhiQVIPnyaYtzKGJSHNRAmN0tGQpd7K
         1R9Rc1m3NQW30xezxGaoIJlZsc8viD6mJ4HgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721757917; x=1722362717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hsGKAY1d9cfwS3hv7NQu8xmVyigzJFwKRal6P2bPrxY=;
        b=Px0Z/CsYZYKaTVMXSYX9Wq02eigCz1oPCuY0ynvcQh/+jDzwDWla/p2kAEApxgC4pT
         S5+9a4i9M5Bj8r6/J8wV/ILVzAjV6K0zTXndBMyvwRrk7PelnKR42cDa4Rslmrn1GLGK
         x+jkx7kj77f2uzvwIwXy7+fcimOOfdshZBKwXZgBiJbNXxzTD3oUt4rTKb9pizaxX7cb
         FyLwUmfZlhTaZbgyRyrgsjRoWQlFpVcmlVYTcLwBenTeYfverEU6e0JdJ8u0nlUKn+Wa
         zQIerW+mpu1Zw1OAk8XbOqYupff97W/ZgT4iVCQ51s2R0LqjQL0lcyJVtqk4z+lVP0ZW
         sMcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWfDqr9tigl+ToG1FFLMFAvlrINGgW+oFNlX+MWoMU/QpMlXHHD2lg5RefFqKb1KyigYCHuWN45Ye7fRD1YL8Q5ZgPOBT1ViISf9WN
X-Gm-Message-State: AOJu0Yx8QGYZ2qKLVwWlv8002NpVd0JZZ9tv9n/d/2KPVRTqLt8w9Tb9
	pqTqKVUrFMlpq2aigjW+usmxXb/8JUfncqXI0JiD5/wpnlTEcFrSqHniwohpMs1pW3wUpfCKn+z
	1Ac4=
X-Google-Smtp-Source: AGHT+IGigB8fFtTfopkogVMa4VllFihqkcjjS3/clveH9+CJ/xWQlDvDjQHi5RI0hgQAU6sNXHJYyw==
X-Received: by 2002:a17:907:3ea8:b0:a7a:a33e:47b5 with SMTP id a640c23a62f3a-a7aa33e4e31mr137821066b.69.1721757917086;
        Tue, 23 Jul 2024 11:05:17 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c95111fsm565152066b.216.2024.07.23.11.05.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 11:05:15 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a3458bf7cfso5138337a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:05:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5V3r0RHO+/EmSYazSY+JrnQRXyHRAt1fEuj2XhWNe2U28s0XCqiSxaw59LhEiGCzESz5Zn8a3MvUzNq7i3DzCzWPDE5sOfFR68R38
X-Received: by 2002:a50:bb04:0:b0:5a3:d140:1a39 with SMTP id
 4fb4d7f45d1cf-5a479879b3fmr6428692a12.1.1721757915396; Tue, 23 Jul 2024
 11:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zp-_7R49fIHgIhaq@pathway.suse.cz>
In-Reply-To: <Zp-_7R49fIHgIhaq@pathway.suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jul 2024 11:04:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=whU_woFnFN-3Jv2hNCmwLg_fkrT42AWwxm-=Ha5BmNX4w@mail.gmail.com>
Message-ID: <CAHk-=whU_woFnFN-3Jv2hNCmwLg_fkrT42AWwxm-=Ha5BmNX4w@mail.gmail.com>
Subject: Re: [GIT PULL] printk for 6.11
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 07:38, Petr Mladek <pmladek@suse.com> wrote:
>
>   - In an emergency section, directly from nbcon_cpu_emergency_exit()
>     or nbcon_cpu_emergency_flush(). It allows to see the messages
>     when the system is in an unexpected state and might not be
>     able to continue properly.
>
>     The messages are flushed at the end of the emergency section
>     to allow storing the full log (backtrace) first.

What? No.

One of the historically problematic situations is when a recursive
oops or a deadlock occurs *during* the first oops.

The "recursive oops" may be simple to sort out by forcing a flush at
that point, in that hopefully the machine is "alive", but what about
random deadlocks or other situations where the printk machinery simply
is never ever entered again?

And we most definitely have had exactly that happen due to the call
trace code etc.

At that point, it's ok if the machine is dead (this is obviously a
very catastrophic situation - nobody should worry about how to
continue), but it's really important that the first problem report
makes it out.

The whole notion of "to allow storing the full log (backtrace) first"
is completely crazy. It's entirely secondary whether you have a full
log or not, when the primary goal MUST BE that you have any output at
all!

How can this have _continued_ to be unclear, when it was my one hard
requirement for this whole thing from day one? My *ONE* requirement
has always been that the printk code ALWAYS does its absolute best to
print out problem reports.

Because when an oops happen, all other rules go out the window.

We no longer care about "what pretty printouts", and we should strive
to always try to just get at least *some* basic print out. The kernel
is known to not be in a great state, and maybe the printout will fail
due to where the problem happened, but the kernel NEEDS TO TRY.

           Linus

