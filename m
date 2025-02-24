Return-Path: <linux-kernel+bounces-529167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265D8A42099
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E2F164FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9717E24169C;
	Mon, 24 Feb 2025 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TFYsQgpo"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551A923BD0B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403708; cv=none; b=WXiz9ns3KifeCkRpT1SZcc/FvPs4pKfWhfylOmi5gjMIoLfDZzHmXjaycBoFfF22VsbcdBsaHT5DblwAnLOiNZJMWx7T3GgthPnGJaJH2MFlY0J6CXM0Au9PjDjT6zUOYPJ18lWjFBoEmfEDn+CkM6T1Wg1gzyg3tnfmXxp7kJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403708; c=relaxed/simple;
	bh=UC4C/gLXlYeaU+2nbW8ScE72rBoUIWmUAYRX/fb/ZdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=us3Q0qzsJgEHxatq9KErk00aPgnYEI3Zfl4TXjQfVNjFbc/OKmXcSMMypw82vVufF2jIRElTwK5/0BqSk2xqeoeSQnV/9ICfPQVZiwq4HbbadEj/JMBlDweGoQy0whNtBph7UpB7d75L76o+JdKHVwT07KPts1eXu5IfvDFOvnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TFYsQgpo; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-307c13298eeso51185961fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740403704; x=1741008504; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdjxlLUu+pJ+QW9swl34bk6A7OB4CzuBQkoYVc/V2/g=;
        b=TFYsQgpojAKpb6sHod1kaE2fwgeOSUgCPfLgz48MgNw4FtvRag0pKUCO5TdPBLsme2
         QnjLtNxSHn1AFgWNGeLwr6QXjMXlmm2gteRPfrpxR9XTiMjIX2sSnqJrsLQjfU4B/pVu
         xrhx0DFU7C7iY0z3vEyowiX1sv5Oo9X9vSeLefq1LRRdfBifYbylkxEw5cku/d7DFabg
         uBVAlslccYc7do/YcnkjEwkg91V7+ud9YGkBeuf2frX4CMe61Lw90AvCAXHBpGttGTKp
         fk2cV6WwzhrSneJ0zJNuXvkwBzx2g6W80P9XnfMdqa6tOwYdpHkiGVkTKxCElItJhdmv
         L2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740403704; x=1741008504;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdjxlLUu+pJ+QW9swl34bk6A7OB4CzuBQkoYVc/V2/g=;
        b=sLRaReV+14So/lzGqi9Y2ymfL0YPprenWmMOVRAJGn52eW/F2g7IUTTYfGIWrodY5G
         ylrlIFSO/JZibyZ9CXEdWGNZFY/P28vHlIJqNGBk3KeV/LNRsil14sCYggWlLLDiTNJH
         FLfrqAVskFlEB0BShz7WlzYLR4K1i6bofYPwnKrotuG/d653OSMFpQVZWMfsVFseMrh1
         8N9k5rMBYt5GNTjbnRYHnIzF3ip1dGO4CFP+p7ST0S2Nr3fRk5ASWIbVpWEMXms/E5LI
         UJYaTmAPw48tbKkxricYgQVH4R2nNrmLJHUlwjhvGvtF+Xtts7NUukk4pZlE2Ex+wEvE
         cnfw==
X-Forwarded-Encrypted: i=1; AJvYcCWWD2ILxdVNYF4li3OBGTmbpTww7FtW38yyfAl9qntoQ7R5aZ27DwNeUJsw/1QF+3kgJuW4/QQu7eVaw+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YydfREl/RTUGfdrr24E75JzDNrJrGWou2ZYY3jHqOoeOLosBwX5
	VBwLR0BLEQNJdfJquiC9QR10okfXmWac/8Lyqqw5eLj93rIu56D83hSTw2jSEm/MDxkL8jGyf1a
	ZZbG2cmynH3wZHBCwJH/Z3cUVaJSKnmr4kqgIFcdMLtSZc+y3Gw==
X-Gm-Gg: ASbGncuXW177iVZvxLPLo1a0hZRDVJ2Ai7RHWpFubA2uTTKg4z9rIYALvW24Drapbcv
	qiQxTlNVIcqC/UdJkMmDuWATNPLEDTp3njeGs7LK3YmD5Og4K6A6M+1YEJvBpaLJsFWKhWUIbZE
	StamHoexy+uN7IszvzcqgJwoeHSWiL154nbYHZ
X-Google-Smtp-Source: AGHT+IHzaYYXdL4tJZSj9UBbZXRJIX8UjBfULMzNdqQX1xUNtG5OFoHY5WaKYsnLC2hoa/0GRY8BZK1db3wuOtwCfX4=
X-Received: by 2002:a2e:9696:0:b0:30a:2d68:a80e with SMTP id
 38308e7fff4ca-30a5063faf9mr57285881fa.14.1740403704287; Mon, 24 Feb 2025
 05:28:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740403209.git.dvyukov@google.com>
In-Reply-To: <cover.1740403209.git.dvyukov@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 24 Feb 2025 14:28:13 +0100
X-Gm-Features: AWEUYZljLH5EgBhoWT0UVDBgDmF3uAVnwBuxNAFbY9Sxe8utMn0I6qmLDmCtqPQ
Message-ID: <CACT4Y+ZX_HxZQbbmeDnbZgvVqY-p-k+UO8XP7oAMmZMnxufXcg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] rseq: Make rseq work with protection keys
To: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com, LKML <linux-kernel@vger.kernel.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 14:21, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> If an application registers rseq, and ever switches to another pkey
> protection (such that the rseq becomes inaccessible), then any
> context switch will cause failure in __rseq_handle_notify_resume()
> attempting to read/write struct rseq and/or rseq_cs. Since context
> switches are asynchronous and are outside of the application control
> (not part of the restricted code scope), temporarily enable access
> to 0 (default) PKEY to read/write rseq/rseq_cs.
> 0 is the only PKEY supported for rseq for now.
> Theoretically other PKEYs can be supported, but it's unclear
> how/if that can work. So for now we don't support that to simplify
> code.
>
> Dmitry Vyukov (4):
>   pkeys: add API to switch to permissive/zero pkey register
>   x86/signal: Use write_permissive_pkey_val() helper
>   rseq: Make rseq work with protection keys
>   selftests/rseq: Add test for rseq+pkeys
>
>  arch/x86/Kconfig                         |  1 +
>  arch/x86/include/asm/pkeys.h             | 33 ++++++++
>  arch/x86/include/asm/pkru.h              | 10 ++-
>  arch/x86/kernel/signal.c                 |  6 +-
>  include/linux/pkeys.h                    | 31 ++++++++
>  kernel/rseq.c                            | 11 +++
>  mm/Kconfig                               |  2 +
>  tools/testing/selftests/rseq/Makefile    |  2 +-
>  tools/testing/selftests/rseq/pkey_test.c | 99 ++++++++++++++++++++++++
>  tools/testing/selftests/rseq/rseq.h      |  1 +
>  10 files changed, 188 insertions(+), 8 deletions(-)
>  create mode 100644 tools/testing/selftests/rseq/pkey_test.c
>
>
> base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
> --
> 2.48.1.601.g30ceb7b040-goog

+LKML/x86 lists for archiving purposes

