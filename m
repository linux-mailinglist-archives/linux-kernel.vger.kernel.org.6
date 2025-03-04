Return-Path: <linux-kernel+bounces-545266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEBEA4ECC7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0BA8C426F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3FB28FFC0;
	Tue,  4 Mar 2025 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hs0x47Gu"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E2727F4D9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110702; cv=none; b=azv6BDLzH+IvuBdsvsVGbPM0u/4Jdz5IXeh4L9++YVlkOlqC2e77Eq5iD8BTOXkc9bFmqhskc9j1oXEgZgzv+4NI812ptKR5+tQ8mx72wJq07MnV/PTS8U5yO+k/aMWA6P55lQ/IhA71obiTWH0+YQ6NlHiGoNl66jyjPBulAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110702; c=relaxed/simple;
	bh=t79luk5gNIukJyh6i+Wv7Arv97K595rpQf5m8ULc0FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rDqSYTdO5npuzPXVtpeIyVZXJMDRV25WT1GO+k+N8dS6MFtrC8M9YXTNNsfX41VYMJL0jGUEx5grsG1J+MGDBfePukw6g6U41vRKoz7+dza27i3bR/ySSerALLfDkjgesstCXrs5AzS4UkzHohaPgV8V/LWci8qXuaSykL2LuV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hs0x47Gu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abf4802b242so669273866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 09:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741110698; x=1741715498; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8ar6zXTooC+qWyNjyHLe77JrEoGxqI/5v2vCc8JEkak=;
        b=hs0x47Gul7wkkgoNw8UV9Eo+PRgIP/cj/hrkEJAWykijoFB8N9VfIFGUXiolky58i+
         gmrWPIK6MmLFbg8olu0uVhb5KxBvmLfEe+ETq+pXI8KSc6SeIzhb9p6VF+oTG+YRlA1a
         MrKgWiaQpU1aXaGLcB0HU/WS+728JO4+FJVcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741110698; x=1741715498;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ar6zXTooC+qWyNjyHLe77JrEoGxqI/5v2vCc8JEkak=;
        b=ZrwEPxsweC300hxQ2UKVb1bmt5fmLycp70vFMWJ4coKyCFTKoDwEPxRN3+mTiA3lVW
         QbPCpyu8mYIFwURvhgrzMjSWek4keTRBOLgr9ZjzxBFlFF5tCeSEQ+OvIRoGRs9NOyGT
         rUHUNlP6ZL5nfUnqKGGNnvoWhWFdavC4paYt/2ABuRSxu2kIldThjA51H+wKTldaiORo
         dYeUygl2X29u9luAxlDeOwTL/8yQnNZt+KhgcSCOhuAiW/mQp4GW2YQFGYOItKrh9N+i
         aScTsOSYe0oNfXjgScHe216PT0fM6DzhbU5b7gpv3aXsTxE8fr8EajieS6vxoddZyRrF
         Pxmg==
X-Gm-Message-State: AOJu0YzMrh/Bu1Ae5v64yLiQFJ6XBnt1G7kRU+aKeexSqrbplaHN+piO
	BPt7Ush61l79f2Ezoq5l329Cw6y389xemkC22scry6NtFCwC8tc4AMug+gYuKoKADC2fmKCfqSb
	Iuo0=
X-Gm-Gg: ASbGncs5JVeX+WE4sH4gxd1dV7RPFEqJmR0gSi74OvUuYpJ0G/7EtTPrag414ct+XJf
	Cx9o4tck+I/2fbiWLU5RM2dITCq9PSR0KlKgKuIB1zTDlbSd+Cg+EydW4N6KxdIr9VKbX0t8Z8P
	Znp6M6b7ZZq96FiiosMuZGUmeXhjezqItOEpD86u4Xtka6837D6vlljcj+9YLy8wBYIq7A9kYe8
	og1iIfN+Fc0KqMXBEeJuTrVX/AX8FWm/52Lm4ZFyO47RI3Y5HHpf58H6EwfYG98z7VZ7h0Aq5Qv
	Yk8ceKaPOvKbHtAQKMZ8F8+Y/pb8ZrcQ5oRIvwf3+sZyX+Cljr4noq+MiN3uvESQ49En8txi4Tx
	JRsNbpa5qvOCe2phfba4=
X-Google-Smtp-Source: AGHT+IH5yuJLav8ZkeIxi6sRAByJcYTEzwTvgXpSICn3CvWD/j7SFxcQA9mG1Tj6LNYLotyk316QFA==
X-Received: by 2002:a17:907:7211:b0:abf:62a4:14ef with SMTP id a640c23a62f3a-ac20d8470c6mr18003966b.9.1741110697867;
        Tue, 04 Mar 2025 09:51:37 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1ff5b36ecsm84276166b.179.2025.03.04.09.51.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 09:51:37 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaec111762bso1087726566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 09:51:37 -0800 (PST)
X-Received: by 2002:a17:907:3d88:b0:abf:52e1:2615 with SMTP id
 a640c23a62f3a-ac20d844784mr16705166b.7.1741110696701; Tue, 04 Mar 2025
 09:51:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com> <Z8a66_DbMbP-V5mi@gmail.com>
In-Reply-To: <Z8a66_DbMbP-V5mi@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 07:51:19 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
X-Gm-Features: AQ5f1JpAuV2PR2wWFAAmrlYAziJXOcwJeCn_7ccTAn4I_8dDZz982GJ7tyN4tkY
Message-ID: <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 22:33, Ingo Molnar <mingo@kernel.org> wrote:
>
> So Josh forgot to Cc: lkml in this 5-patch series:

Honestly, this all seems to be complete garbage.

Yes, so Josh found a problem with the thing that has worked for years.

Then Josh did it another way AND THAT HAD EVEN MORE PROBLEMS.

So now it's trying to fix up all of *those* problems instead, making
the code uglier and more fragile.

And I'm not at all convinced that the new model works at all. It's a
random "this happens to work around it on the compiler versions I have
tested", rather than some obvious fix.

Put another way: the old code has years of testing and is
significantly simpler. The new code is new and untested and more
complicated and has already caused known new problems, never mind any
unknown ones.

It really doesn't sound like a good trade-off to me.

                   Linus

