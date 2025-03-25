Return-Path: <linux-kernel+bounces-576285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF80A70D70
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3BD188BEC6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764D025484F;
	Tue, 25 Mar 2025 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TvQJQQft"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B861AD41F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 23:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742943754; cv=none; b=Gc7RvH96UwmFCS6HFnqKwp1nD8cktaLnXIeMVXYtKrQEDCuCdVByQRZiLJTlDwHyEx55w2albvb/Zr4+4/vo6KbjSK99qD+WQpStmgFtfgl0wRTjWLCZ0tTwb7V33Mczhl8o+NT5FsikcdxYNktfqrWakTjE9mS3qtwL1h1CqkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742943754; c=relaxed/simple;
	bh=rvtaKCacTd+dMFEwCfsS4KnID/jFXOuQd2z1cHSbJkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbprBiwrUtKcQu6xrPII2JxVt6S8c/B5VRxnldfksKIvEVsxk9pJIxXFvXiUiI5aO8IO9Vy9b21qyAhTp8VKo1BBvgJkF9VTBbLk6F6/xAc588TV7Y3EtrWBSC51RW5bOKN7NDeJuFtXuLsLjyDlS3/Bi3ZqAMfEzI5ZROYoj24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TvQJQQft; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso62076066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742943750; x=1743548550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qpbsUEYRhF7ODaqFjujOp9s2YRkxd4ZLPAugypnEK7A=;
        b=TvQJQQftxjnjBEsYKJ4D4jIp0QLg5epctPeAgEs/wDiyWmlee4fD1sFifdmm8ADQQI
         i47MljpIxv8kYqjM2huld4rnbPT0rwhCa+/ImIXWAKNT/j6Anw5OuLBSdFH6MwC+c5VO
         4D3HvCz6xcc27e996+QJVNWyWqDMNanYGq3kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742943750; x=1743548550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpbsUEYRhF7ODaqFjujOp9s2YRkxd4ZLPAugypnEK7A=;
        b=EJTfsfGYuMraSpLZ6/Q8yQJgGIfgLEDdhzrlT2CCgj68LqpwzJwuU40skcPX20hySJ
         NLeCQXwWj/oi3IT25fklWptkdwJQrMI6/BhTtMLrgINhNQVnrMGdxUFJM6fPgwQYgGto
         dZGQ0vRYZHM/k0PgqOkhnRxqVOcP33mvMihvapW4iJgR07aDJFh/XTGCM/GqfHHBde5g
         G9/Eul5nLmhatEm8VRHR2R5uMDJ6v6PdMZSNk3xnrmpJLSwV+ytyTw2RbmhBAFSJY/No
         MaVo1ygX7DY2SYht76eBTGu7E0pweUC9rsipffIxIahxlFqLIKDK8lcqUyYJx6wL0QM/
         RWjg==
X-Forwarded-Encrypted: i=1; AJvYcCV9VG4vk3+wOC4tLr4HbvI/4+ee3kzk6rKPJYEPOMwH+UHOm6NJALKe+8662f6EjLeBb6Fs+qxZSZK4pRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDI2ICe6cQQOtdsgOBM/pWcMs+2endWhDQSjRAyWy7OkeS/SBA
	91urLjP1oxm+rlGI9P/ID3sUDMXUHlyuZF3Rv2e3SSrFutJ2v5yYHdQCYUzJy7W2NTab5uNSoYN
	1hMplQw==
X-Gm-Gg: ASbGnct7uQ3ffdOEYrumU93mvtdhIWK9Z2PNUwbmXIxf40s9k53kSyQQ3Dgidns8vcf
	dNL3kOOy04xBBJawm4Ce2rQ1acnuLDCLfZzTTU4rAP0NUFxZfCXyh4PlUlHwmYrZPHRemMaXSgW
	413vShBOtRFrHmxrdlY1f+9DAEIxOB1LLbwzmZT4q+1IgRs6FSJn5WXx2mAwOaa0ykEqZhUcMq4
	018EWpKeEDzo0fNhK+msZnwvXozRSK7hm1SSA4V1/pv5HG9pT9nkGgNzSnufhGFYZjmqPLm/U1B
	cO9agsNmZb6u+W0tHAYC5ciW8Nh+QGMqI+WhDc4VRo8RgOtPG9dPNR2QvbZlmcaXC9WgA8Ebbas
	TjJYh3MOK33vkfxGmM28=
X-Google-Smtp-Source: AGHT+IFR7U9lIJmUaY6kS0YSAgfr4jdZC+fS+DhFsPjpg2FNtY7S9CNkMid2lrCdxmLZYm5lekPzZw==
X-Received: by 2002:a17:907:3f98:b0:abf:6a8d:76b8 with SMTP id a640c23a62f3a-ac6e0a0bbfdmr164163766b.11.1742943750460;
        Tue, 25 Mar 2025 16:02:30 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbd4640sm909126866b.129.2025.03.25.16.02.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 16:02:29 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso62073366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:02:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVF9mYKHEPkO3A0dgpPWgVjDPnEVL6ynSICEcZsVSM/y3ACa1DeLYtAhocYt0uEkCwQnNnjzs6e01XxJ7o=@vger.kernel.org
X-Received: by 2002:a17:906:81d6:b0:ac6:e42a:fb4c with SMTP id
 a640c23a62f3a-ac6e42afbbbmr77412666b.9.1742943749513; Tue, 25 Mar 2025
 16:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
In-Reply-To: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 16:02:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
X-Gm-Features: AQ5f1Jq6H2w1UwofX9xTNQfWxTgnnyE_4keu9omt7uh5If6fR9mM7-LXzR1V2TI
Message-ID: <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Mar 2025 at 12:39, Paul Moore <paul@paul-moore.com> wrote:
>
> - Add additional SELinux access controls for kernel file reads/loads
>
>   The SELinux kernel file read/load access controls were never updated
>   beyond the initial kernel module support, this pull request adds
>   support for firmware, kexec, policies, and x.509 certificates.

Honestly, is there a *reason* for this, or is this just some misguided
"for completeness" issue?

Because dammit, adding more complexity to the security rules isn't a
feature, and isn't security. It's just theater.

And it adds completely pointless extra cases making the different
cases use artificially different code.

The commit message doesn't actually make any mention of *why* any of
this would be a good idea.

I've pulled this, but honestly, I think all those new cases should be
removed, and if people object to us having "LOADING_MODULE" for other
kinds of reads, then I think the fix should be to just rename it to
"KERNEL_LOAD" or whatever.

Because dammit, this "make security interfaces more complicated just
because" needs to STOP.

We are literally wasting enormous amounts of time in the security
layers - I regularly see the lsm and selinux layers spending *more*
time on security than the actual operation takes because the security
people have written random code without taking performance into
account - and I need to see *reasons* for adding more crap in this
area, not "let's expand" with no actual reason given.

So I really think that commit needs to be either reverted or explained
very clearly why user policy _needs_ to care for the difference
between a module load and a firmware image load.

Because I think any such explanation is likely complete BS. The
difference between loading modules and loading firmware usually would
boil down to "different hardware does things differently". There's no
obvious reason why one should be considered different from another
from a security standpoint.

               Linus

