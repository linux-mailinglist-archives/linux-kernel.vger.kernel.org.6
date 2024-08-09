Return-Path: <linux-kernel+bounces-281098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C2594D30F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2E8281668
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5167197A8B;
	Fri,  9 Aug 2024 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y/b+L+ua"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0833197A8E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216411; cv=none; b=MqPpFvEt9jck93q+mhuCMhPm1veefxgAXviMVSATKfeZQP7bmEfLCcGBQm0XTeOaoD1h/BAXbCpJHEGQSouHOmrMxTy0sF1QYgsHwmf9FkeXUeI4jBpqFsAow+Ev3MiYRgViYPflIJ3/aZdUIBjuQoWyR8lkTK71IiTxNuZqhKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216411; c=relaxed/simple;
	bh=zjn3YmKXlPxzbD8VKXj7SB08Iibw46diwUCwOIFAoyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhjBMb4TUwJTXQ7FjBs8Bhnmj1B5Xr2Sp1QlJv2W04I0MNSGQpmJ1hYdIowSuJCHIwxmBTK2zzzhtExGmcF0hMN1ZrI+RWZKKfhMNacjM5Ertnt+Qq1mOFd9/oennuo9zMeAvd1r0cHz8OJqViy94YzwQhttOdkx6VHf5FOu7CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y/b+L+ua; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135dso2788718a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723216407; x=1723821207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SQb4P6KW7DwW15iPQt+xRBs0vTrFbvLGmJcOvQXiPP0=;
        b=Y/b+L+ua50oAoynC1EMq9UDW8/xPtKQ0NkckzIl6L8K5HkHg9WjAWD1QN9kVMWip0P
         3sxALjTpeA9L8cR/IMYwFSKV/vFM2GxsZlSjxFirSDlQgcG9IAOBgi/moCp0SbsnjM3G
         XaHlVNBWNmtZ+6iqAni6I+wE7Thi2+eYvlOmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723216407; x=1723821207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQb4P6KW7DwW15iPQt+xRBs0vTrFbvLGmJcOvQXiPP0=;
        b=UTy2rZi0vu0zMYeAFSfvGAhvBy6MK1NqIXX//+uGoxveB+sdpdx1XLengofyN4dGSX
         7js/Hvzs1E9UtsfrTjAHVvQdvmJpWvxMUJGOzuizGu6gotyeY2mS4ehD0H3BpMofaXP4
         VSYdoooKpAXsn3MUgqdTCCC6DRZFOUn0aKxFe1mMaVvvg57SNomLm90UWoDHfWSmlvoE
         iagEGrQMulAk1wUaDGdzDI1aA0cAO0NKc2czYHreCvmZYp6FjPQUxdUtyKTed4zqe+OE
         zKBBBrzH9DhYL43oESYpfrm9+Ho8tNjM5KeuAwBYcQWDdGJKnPSfbm/39ypYLtEN+GA3
         tcnw==
X-Forwarded-Encrypted: i=1; AJvYcCWBSVEP9BwLfxAOmKlXZBfwbY5/7ImRpEE+9X50gEZXTngDF7bMkXw6hifv1xV6j/YNaT/qIL2Ofwuc/dJwll6VvREfEejMZiKWbHLP
X-Gm-Message-State: AOJu0YxWY+HklLGYSp5L6VtVmcegTMv6BNOZ3jd17zIju3zPYBVewM0K
	t1f/ettS6QShZtnAHgErVSmGB3jLhPfYppDq1nokMudoZ8x16YQ2KmxeV8aCniqRLbFAIz8z6QU
	iR/MmCA==
X-Google-Smtp-Source: AGHT+IFolwMJgIUqglc58CwYSdVtLjYMZXvrgAyYRrJb4R3AhpsQvYDpfY3m4F2X+jdyed+0j1D6mg==
X-Received: by 2002:a05:6402:5186:b0:5b9:3846:8bb9 with SMTP id 4fb4d7f45d1cf-5bd0a538efcmr1252564a12.10.1723216407099;
        Fri, 09 Aug 2024 08:13:27 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2c6e82csm1707315a12.53.2024.08.09.08.13.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 08:13:25 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aa212c1c9so296535366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 08:13:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXT+8qvrhwQK6AtQbQbLfbei+vg0zP8E6dAxwraZei09kZc7JjdbgQZpyUMlZK2vK4Xt/+4Ioe2pzpMJu/usxXP84v35vJ8BAsGzBdE
X-Received: by 2002:a17:907:7e92:b0:a7a:ab8a:391 with SMTP id
 a640c23a62f3a-a80aa65c854mr137777266b.45.1723216405166; Fri, 09 Aug 2024
 08:13:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
 <CAHk-=wh_P7UR6RiYmgBDQ4L-kgmmLMziGarLsx_0bUn5vYTJUw@mail.gmail.com> <875xs93glh.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <875xs93glh.fsf@email.froward.int.ebiederm.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Aug 2024 08:13:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+buZ5Efw4so9FbaJ5Q=xLr0+bcYDafouehVG93Msd7w@mail.gmail.com>
Message-ID: <CAHk-=wj+buZ5Efw4so9FbaJ5Q=xLr0+bcYDafouehVG93Msd7w@mail.gmail.com>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Brian Mak <makb@juniper.net>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Aug 2024 at 07:40, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I asked him to perform this at snapshot time.  Plus it is obvious at
> snapshot time that you can change the allocated array, while it is
> not so obvious in the ->core_dump methods.

Fair enough. The days when we supported a.out dumps are obviously long
long gone, and aren't coming back.

So I am not adamant that it has to be done in the dumper, and I
probably just have that historical "we have multiple different dumpers
with different rules" mindset that isn't really relevant any more.

> I would argue that the long term maintainable thing to do is to
> merge elf_core_dump and elf_fdpic_core_dump and put all of the code
> in fs/coredump.c

I wouldn't object. It's not like there's any foreseeable new core dump
format that we'd expect, and the indirection makes the code flow
harder to follow.

Not that most people look at this code a lot.

             Linus

