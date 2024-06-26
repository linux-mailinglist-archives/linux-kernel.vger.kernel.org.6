Return-Path: <linux-kernel+bounces-231046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E46F791856A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7FF1F28E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8A318A923;
	Wed, 26 Jun 2024 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JRnveop9"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260841891DB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414687; cv=none; b=iYE8L8bxMikTffdO+WnntNSKPaNnjbWobG49wQ4qejiz4KD3J4QuqtbnkXvJ0EDesVOfLCMHO45fViMgdGriHzOgkjGi8cCdoWYLg6vX5IlwqJ6mb6G4mWWYmC1r0f/2+P7gTY7ugtVHsbU30dzYt3Ah6Y9yaxmcEqnB3F1J1ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414687; c=relaxed/simple;
	bh=zlW1Gsw4PMDM5g8A98aNiufUf4hys6dDjvPYrZGabhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fA/rsiSZJt/M0E5DTcJ2TbAdlvUqodpQcF8FtperTQJo5U0R4BmOC67dHB5jUL6w7zXZ1tjj2+6mp+cau/80s2IgNGmgo7HsPSl8HqlY01635sMsKrpGtoSSUrkAh/1KAdCccvrfV3pBpUzYPB2zFSjujLooc3UrpcducMuVKuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JRnveop9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d106e69a2so545531a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719414683; x=1720019483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bckuE3bo/bLr+lOHm+Q56EnpXfPkv0JuYCdUqiqIzFQ=;
        b=JRnveop9L1pz4UdIFI68z6wcYLdP2GioSKFNGTKUPxyPmdPmb7ntjb8tCWIxTg4y9q
         4UEqQ2tYuARK8aw3R5vRd2r23zY/S159NO+EOmFquehhU2gmeXpb21t99vMDVCBiPnhX
         xeu9a/wPfIca3Y/rzR1Bd4jl8dfRUgN5+N3dQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719414683; x=1720019483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bckuE3bo/bLr+lOHm+Q56EnpXfPkv0JuYCdUqiqIzFQ=;
        b=t9acb5Z0O0RHN4WJqW05qfY9macjuHny7NrAcvaZfckBExuSQyZNVU/xTRauFDO0rE
         V6HzhUhRn8dzvm8PGoNXXkTk1SMb1t2z+SaoTMjXkQyJ1hJjl+/eONoenKNPacPU4nSH
         8oOIq4x2nKL0MRRKDl97CyXZ5qrctcPnzJYLlDcgnLvVi466Au4G/llTw53xL7jg89hA
         psxPNIJDLJG6Vuk1nxOB7lQ4AqzuDXv+fLvvWcADes44O06IyeHlQ3UqOkr5ItpZfH8t
         p1NBUUwgDymM3chKJcLKHu99FVBecXXts8y4b8MT5n8l5vExsa+XueypLOfr9y9MWaWz
         /Fgg==
X-Forwarded-Encrypted: i=1; AJvYcCXyJdy8KyXAl29KcnntZp4MzJ6YblBVaBd47mf6m2GvpV+Ynw7SjSqUcbqSLl1XiomFlrTgyok3PUxK7e9VIN4Pp3ZVWC18Sp74FH27
X-Gm-Message-State: AOJu0YyIgUhN4YxObp64+0tNzR1p9E+KTFMighT2/KCap+Ac1M5jntdW
	+ZFhRivhkZ3pznorQ5vv0HZorsrq5CngjZ73L2oms5rl9TKxWWzs1IsOGoo/i2fvry32B7oIx/Q
	c9SepiQ==
X-Google-Smtp-Source: AGHT+IHPlvUB9YeGqd+Py8glm3T0a2fNNER8eBW6r9b8aJoKBUXL68ttUSJCHjAKsgxMl9GIplMFPQ==
X-Received: by 2002:a50:ec99:0:b0:57d:6bb:d264 with SMTP id 4fb4d7f45d1cf-57d447aad47mr10033966a12.1.1719414683255;
        Wed, 26 Jun 2024 08:11:23 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3048b93asm7512570a12.56.2024.06.26.08.11.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 08:11:22 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee6eso514111a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:11:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1saQJekuz2aAl5bTHM1hbyWj9F1r9VoAOKWqy5PCCmxWXFpoWk0S4CEwP2bm4+HlGTyotpgqPy1wMcqvDEWN8bKKt42tGRT5Lp9ok
X-Received: by 2002:a17:906:4095:b0:a72:55b6:4b66 with SMTP id
 a640c23a62f3a-a7255b6543emr726093966b.13.1719414681872; Wed, 26 Jun 2024
 08:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiWEgSo2Tb_bih7mnS27zAPL+RGg_7yX4qK1f710-j-Ng@mail.gmail.com>
 <20240626010924.478611-2-torvalds@linux-foundation.org> <CAFULd4YUBGO1wmsacsxm5ZdbKu++evNC0NbLpGjZVQFTeJze7A@mail.gmail.com>
In-Reply-To: <CAFULd4YUBGO1wmsacsxm5ZdbKu++evNC0NbLpGjZVQFTeJze7A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Jun 2024 08:11:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whp_j=txQ+bGQqsf5_2fY0vM3U4Ssy6S+Yhg4ugYHdMZQ@mail.gmail.com>
Message-ID: <CAHk-=whp_j=txQ+bGQqsf5_2fY0vM3U4Ssy6S+Yhg4ugYHdMZQ@mail.gmail.com>
Subject: Re: [PATCH] x86-32: fix cmpxchg8b_emu build error with clang
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Jun 2024 at 00:39, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> >
> > Still doing the 'oldp' writeback unconmditionally.  The code generation
> > for the case I checked were the same for both clang and gcc, but until
> > Uros hits me with the big clue-hammer, I think it's the simpler code
> > that leaves room for potentially better optimizations too.
>
> You probably want to look at 44fe84459faf1 ("locking/atomic: Fix
> atomic_try_cmpxchg() semantics") [1] and the long LKML discussion at
> [2].

Christ. That use should be invalid.

The only _atomic_ pointer is "_ptr", not "old". Anybody who gives
something that can change during the operation in "old" is basically
already doing random things.

> --quote--
> This code is broken with the current implementation, the problem is
> with unconditional update of *__po.

I think the only thing broken is that quote, and the crazy expectation
that "old" can change.

But obviously, I had completely forgotten that whole discussion from
seven years ago.

I don't actually find a single use of that invalid code sequence where
somebody would pass a non-private pointer as "oldp". So I really think
that part of the whole discussion was bogus to begin with, and
presumably from some other code base.

IOW, I think that example of a "classical lock-free stack push" is just broken.

That said, I can't find a case where it would matter for code
generation (every use will always do a conditional branch based on the
result, so the conditional assignment is practically speaking always
"static" anyway by the time you do branch following.

So I'll just send out a minimal patch with *only* the %esi changes.

           Linus

