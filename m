Return-Path: <linux-kernel+bounces-515692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6707DA367BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EFF1893514
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4558818B470;
	Fri, 14 Feb 2025 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="OhFQcNKx"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBAA6AAD
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 21:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569635; cv=none; b=ZIl6wHN9vAX8sAjUgK8yvgIhAlzJT0e/aLztvzjsAUylTu/IZekeu5h6UpGNqfZm5zg18vIOLS4cO6yhqfITS2bpXbe1GQHEFZjnsYD2nVi0NjELK5is7gFBY1H28H9Dj2I7PT1laQbgS7YrGxXFdo7MI/ePozykK3v61mmTO8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569635; c=relaxed/simple;
	bh=sPrHjyB7ZPEKXqDVTRDLXSWkXWDHoJbDt80UqOOKgaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuW08USYLQE/0VFvNltfX3GWHV/rs+IM4p3B3ckXw5pc05WSMx7U++LuMWGcVYsM6zwv8XQcoFYA+FA1G6O8UAmzx843yJArsm/ygIiw+s7TMpGjhcF1sem9e+L9RRBQjpqxBIjMKY9zsG2HIx671MZYGpkHTFDHixBm1fb5E0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=OhFQcNKx; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54524740032so1636626e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1739569632; x=1740174432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPrHjyB7ZPEKXqDVTRDLXSWkXWDHoJbDt80UqOOKgaQ=;
        b=OhFQcNKxsMSHWBZYbPNAs4xwco7lqrK6ZAMdDSwBa0LRwcwuoJxndebADMH3vfskEb
         p6cI1YgXQC9nwSXJvF1HlN2S2bVr4zxB8h2AGJv0fkdOB0oRqnVxV2Ym0G7xoyvRFnPX
         YgY+ThIdo0hXZPVigPYkbXkKKt47eDr1H79co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739569632; x=1740174432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPrHjyB7ZPEKXqDVTRDLXSWkXWDHoJbDt80UqOOKgaQ=;
        b=lG/kZ+3gNEQvEkB5j98qgbwuQZE93RL2QG87BfghEn0UWrsi8aW/clj3X+KCX5iest
         tEzpvT7RYlLsetLuu3yBXmQMyyqRV77SESh4UD4aPfrRVn4PlLDwKqSd7Q+kKmE7P0nz
         dioHJj1zxke1RWMrZP2Zh+JmbSTYhhxhq2TG7k06Tbtud99eYKnjndYYnBG6JbmBre/8
         hvG3yg1NdqMEv7T6GGL8wfQa6xhX+jZQDhhwejlmTbpu6x/wlc5i1Wth19WeFCBsHArz
         C92nMcRf6GcPpQGYV4T5S8etcvbkRq1dm52G4oD+z1U5qrY1RtocL+e/nAZuzzYe5Sxy
         SEmg==
X-Forwarded-Encrypted: i=1; AJvYcCW7C+Ablr2LxVTB5O7lwnd5WY+uOgYqwpfszNvYhlyDLypGzersAe3Y0q2IWXHr71okD+NFA4Dh6ZcR+aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySkYnrbu11i4G4bKL3XxC4lIrwsOxkqWgsOtI8OZiRN5YOpq5H
	//eFMemqtOEa9Qm06oOe8rOscCHjKNwGjr+6022ZvAGRzFEjOQb0WzuKcmGP8WfdJub+Frp8P9R
	6gAwqCB8wuqjeZWPOecq3/0cGF6E/Zi6uY5hKRA==
X-Gm-Gg: ASbGncv7IZ9F5UpN0fKyDO07L5xlSXZk1nwFmE4nW4aOXjrLX3iqcSLdk+muDIP0jkJ
	pD00v5RltvAtacdLABKRnAwwVsH1KjZkWI98sCElsFAWkLHqNg0YRB8xm/bBbKfHIEe0KPnyD
X-Google-Smtp-Source: AGHT+IGZfHJGA1kl2ksp+VX8NZVZ/NtQgxO8KN5MDCBG/nThtsVDl27BgELuGsdF1JJSR2FyzMBbA6+syzVK0LhHZwU=
X-Received: by 2002:a05:6512:6c6:b0:545:2b68:936e with SMTP id
 2adb3069b0e04-5452fe5c675mr368049e87.25.1739569632059; Fri, 14 Feb 2025
 13:47:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-printf-kunit-convert-v3-0-ee6ac5500f5e@gmail.com>
 <Z69isDf_6Vy8gGcS@pathway.suse.cz> <Z69oxhkUzTfJ6YKi@smile.fi.intel.com> <CAJ-ks9mck4DzX+WANxKSmcN=mP9ztgwWETXLmX_F-gy=EhmLNg@mail.gmail.com>
In-Reply-To: <CAJ-ks9mck4DzX+WANxKSmcN=mP9ztgwWETXLmX_F-gy=EhmLNg@mail.gmail.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Fri, 14 Feb 2025 22:47:01 +0100
X-Gm-Features: AWEUYZliySt2EpIgG7ZYOAvFUg1UiYEq1P2CaYZ90n2fK0WzUtLwjUi2YaJ10pw
Message-ID: <CAKwiHFjnY-c01rvkzNRz=h=L-AxRMyUtp2G0b17akF82tAOHQg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] printf: convert self-test to KUnit
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Petr Mladek <pmladek@suse.com>, 
	Arpitha Raghunandan <98.arpi@gmail.com>, David Gow <davidgow@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Feb 2025 at 17:53, Tamir Duberstein <tamird@gmail.com> wrote:
>
> On Fri, Feb 14, 2025 at 11:02=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Feb 14, 2025 at 04:35:12PM +0100, Petr Mladek wrote:

> > > I have just quickly tested this before leaving for a week.
> > > And I am fine with the result.
> >

Thanks, Petr, for demonstrating how it looks in a failure case.

> > Seems reasonable to me. But I want a consensus with Rasmus.
>
> I have a local v4 where I've added the same enhancement as the scanf
> patches so that assertions log the line in the top-level test.
>
> I'll wait for Rasmus' reply before sending.

I think all my concerns are addressed, with the lines printed in case
of error telling what is wrong and not that memcmp() evaluating to 1
instead of 0, and with the final free-form comment including that "ran
448 tests". If you feel that word is confusing when there's
"obviously" only 28 "test" being done, feel free to change that to
"did 448 checks" or "did 448 individual checks" any other better
wording.

Rasmus

