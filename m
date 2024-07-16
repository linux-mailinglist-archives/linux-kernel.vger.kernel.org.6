Return-Path: <linux-kernel+bounces-254422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2F3933305
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CC41C226D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ABC1448ED;
	Tue, 16 Jul 2024 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TEJl6pAu"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6647335A7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721162633; cv=none; b=jgZqg6BS8LcmbwvX52cf0acU+NFnVZp4GthNXx+N0CBZ+5yXcyCYhJ8Y6DP1kIFWkk3b+458kOpTaafiwuldksi+7Of54He7exWufRMWD8IuDPwG6tpWjoNCiKn48mLQNqx+xPOs/mZYCGiKQRfenynSuvypuIFryYnb8ZxRQYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721162633; c=relaxed/simple;
	bh=1KWCKv/9inKGII7KtToWHIt3Df0DdcGGOvAj6/wIBTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSHhLL/Efqh1u2NCR+kiGfDJnZ4rf62a4Qilqe/pK5Mylz5ATDzOIIUzJOTjKpchHUJdNiCapJXszks7YW4EbIUiT2c6lYct3nX5iE6yFCgA4E3HTEx88qiVxqtBCWiVugTTK9I3gwTjA+uiyMwwpt4N5T5qb0IjU2AaL7jJ6FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TEJl6pAu; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-595856e2332so7751822a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721162630; x=1721767430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FUaHQYTLzRHBKTZzDYfY3JozSjPXKaeTqwHBAMUNNtg=;
        b=TEJl6pAuZmYe/ZF35fsXHCcXu+ZmOKUnBneMhW/bYrY0T+F8ZYBnNLany/x9345VEu
         LaXagyyBbRN1v1awNaM8+fgV5lkoQD4VDIiHUd6/KJp5Gfi53f2UsMBdYfdRCBFKTkdL
         dZLY7SiHHQv7TyWhPUZ8FNL3mMyXuOBsfDa4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721162630; x=1721767430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUaHQYTLzRHBKTZzDYfY3JozSjPXKaeTqwHBAMUNNtg=;
        b=ZwjHwiw7V7fPxtwS0QBPWBCno7vYVMgLutoIau4BJAJR+ipU2BB1q1UrsCoPjdFwdA
         l9UBbnLNyXVbaCPYQ4tZeTybMYSbqW1ScG5Yi4O2U+z3oHdJ3rasLK9UaYWag+OIrZOz
         +5uyqJYrYP9kPYiSiz8g25/RgSYiCZflJm7rueattWMGbLZZam0vTJOj6jJbtrU+5Ct6
         +egPaAVwScgHMlghC/6qTkzke599L3yfTin9EWXSIv/OBztTFpDm2iNVV3l5iooo0Nop
         olThwuo35xtc43T6eBlCDjMFxUxiZ4VEnXuQF9pVb+r7DC8KNtUCGKow1y6cqLgbyIcx
         08Tg==
X-Gm-Message-State: AOJu0YzgLSP8P3ivriu7ykJwFVdN0sW4ThxPKaceJwzt4qERjvMZ9UiJ
	zWAMGdPH5Ouz1dX8RrvukloJGYGM8QRIsVEXIJh6KuJkd/DbmACr9kT9qGXEi49tFAselkcD+uS
	3FE8tMw==
X-Google-Smtp-Source: AGHT+IFIcBK0TVSdrpQgArEIseAqttLBGXbuXePXzdC8HOSOSXjfo3qKVOtn0HKCEevH4AJbB8w7uQ==
X-Received: by 2002:a05:6402:2792:b0:57c:7486:3f7d with SMTP id 4fb4d7f45d1cf-59eef25b1a9mr2693502a12.19.1721162629864;
        Tue, 16 Jul 2024 13:43:49 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b2504b8c6sm5575205a12.37.2024.07.16.13.43.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 13:43:49 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77abe5c709so725153066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:43:49 -0700 (PDT)
X-Received: by 2002:a17:906:7c44:b0:a77:cad0:5a92 with SMTP id
 a640c23a62f3a-a79ea4367a8mr225972766b.24.1721162628850; Tue, 16 Jul 2024
 13:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407150926.4864BCABD8@keescook>
In-Reply-To: <202407150926.4864BCABD8@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 13:43:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wioGrBpYXENm73w0OHvzhFtETgkaUH+5LYovRWOHJpZ0A@mail.gmail.com>
Message-ID: <CAHk-=wioGrBpYXENm73w0OHvzhFtETgkaUH+5LYovRWOHJpZ0A@mail.gmail.com>
Subject: Re: [GIT PULL] pstore updates for v6.11-rc1
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <keescook@chromium.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 09:29, Kees Cook <kees@kernel.org> wrote:
>
> Please pull these small pstore updates for v6.11-rc1. (Note that since there
> were no pstore updates for v6.10, this is based on v6.9-rc2. I forgot
> to do my traditional merge-on-rc2 for this tree when v6.10-rc2 happened.)

Note that this is exactly what should happen. No need to do any
back-merges if some sub-area has been quiet.

Sure, if some branch is *really* old, you might want to do a
test-merge just to see if there are conflicts (either textual or just
due to infrastructure changes elsewhere that cause old changes to not
work in a modern context), but honestly, even that is just a "nice to
have".

But "missed one release" is not very old in the big picture. We do
releases relatively often, after all.

So then merge conflicts like that are on me as a top-level maintainer,
and if they end up being very complex I might come back to you and ask
for guidance. But honestly, that's quite rare.

IOW, I'd much rather developers concentrate on their own branch and on
making it very solid, rather than worry too much about what has
happened elsewhere meantime.

(Of course, that's all for the simple and good case where you have
clearly separate trees - which pstore largely is. Some other areas get
a lot more "this is affected by other changes and in turn affects
other areas", and then people there have to inevitably be more
involved with what has been going on).

                 Linus

