Return-Path: <linux-kernel+bounces-261509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4694793B812
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD3F6B2432C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B909313BC3E;
	Wed, 24 Jul 2024 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eiSVdvPv"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609A013BAC2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721853221; cv=none; b=ioh4LCKkIPTlbuLa9BlCv1XfakrSaTcIR7Wa8Z4dTs1GVnKyTMK+J5BqWhk1VfJ8v+Ak02vUWd/a7Wevmug9YiYVxreRk5Qa2Px+ZdZkXXvTmfkhuH38YE4GcmRhpHH6ntznZdQ2VGYo69o9aEng/iiUCz9zBAacWt+zKbEb3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721853221; c=relaxed/simple;
	bh=YKiXQ0FQII42XtSWYBmKhhzms+jDP96y2ZU89WKdZ1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMTkgGLSYm0qBSAJq9UsBHHn7d7kVy1j9NgVK0bcL+rYri9JkHRmefda9Jv/AZ8V2dYEV3IAMbCDyHt4eF01zc8kMtgazy7SKFRwKb48Ao3QqR8tCNaqDHaIbSm3ZIMEXK4UvpWbk1GAeaxNT6c+MZvjDDMBgITwpNWCn0SXxkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eiSVdvPv; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77e7420697so36890466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721853217; x=1722458017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GGwUg2nPLg5QfCofKSadD9L3fIbsRxXdwl/uH9dIJ6Y=;
        b=eiSVdvPvOPio+TQwIxeIqHTP6TpQ2+6UL5qlwhE8DQu6uL7hRYd3CUmEhjC7s+ysP/
         ZuuIsZmK2PrOYPYJ0ZfLFtNyw60QLO8tuQJ07rDg7r4HtBkP+Vqi1e/6pgMXRWTxa9Xx
         YGg72z80A0ATxyMTGqYO7RaxA49atLdGc7uuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721853217; x=1722458017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGwUg2nPLg5QfCofKSadD9L3fIbsRxXdwl/uH9dIJ6Y=;
        b=tiH5r4q3aZWBsmPsI4sWYTxMfTMrJ+WSyJaKkGRh/SwUMj9UOojB8OFPckRXcWpef2
         PJpzTJkmmv89ejPiPSfyBsAKtgF3no3KpLLCDF0qTtdX+wAIE3Aw91WUrRXOx40M/YEp
         plhZAhxE6kRTig+6MlOFW6fWRmtNszBrpWZTqjNAifOpSyBK/k0sFGoKSkjiKadFcN5A
         NrTHT1UbTwG/JRTEglAfBYGBj0sTB59FBVekkVb2Jdh/348W357cZiFQar7MmoXqecjg
         CxzCuBmLimlttGeat4CbTIxyTs2QzbYAMy9w3EtKhSEAWch5BVaHAmNMWF1uid/+B6wb
         Sryw==
X-Forwarded-Encrypted: i=1; AJvYcCUMwfJj8FrCrs6r6c91mPJrsjVcBEnMssBzLHet0kvezRVrlf887DszztQVR9J1h5noOjOKMMZWkk1Z1puzNA0p2TL9pnOWjwqFc8mR
X-Gm-Message-State: AOJu0YxxR2aZtukX8D8B3s1XAvnG3OQHhlcP7u13Ae3Wia9DThc759jv
	dJVq7t28OA9L5XTaPYXHxa8mzJeMGg6FOBtUR2vS+MOybenNAmvIxUMJeSmAw82LVsHhq3paND0
	jVFE=
X-Google-Smtp-Source: AGHT+IEapjP1d7TQAejGybgM6vWUQP6aFzKWXLZxNXnefKFz6Z/iUVZQWb3yGy6g7H4M6T1OpRFo8g==
X-Received: by 2002:a17:907:7d88:b0:a72:7245:ec0a with SMTP id a640c23a62f3a-a7ac5087b94mr48532066b.58.1721853217308;
        Wed, 24 Jul 2024 13:33:37 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a8beef9cdsm240947566b.89.2024.07.24.13.33.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 13:33:36 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7b237so377066a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:33:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUq28cLCcThZIm5VdH/2BmEe7Pos4LAzrcy4T/16LiqspeCrg8qfDl0q3avyCEx+nfF7ZSEIgrzgI/7jkW/qRWy2SbVeMuNXY3uVIJP
X-Received: by 2002:a50:d797:0:b0:5a8:2f2b:d2c9 with SMTP id
 4fb4d7f45d1cf-5ac2ae7ad86mr240465a12.21.1721853216423; Wed, 24 Jul 2024
 13:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zp-_7R49fIHgIhaq@pathway.suse.cz> <CAHk-=whU_woFnFN-3Jv2hNCmwLg_fkrT42AWwxm-=Ha5BmNX4w@mail.gmail.com>
 <87ed7jvo2c.fsf@jogness.linutronix.de> <CAHk-=wh+cxX2Sxc6RPBKkgYO67o2mdVfW6sQNMYc_x2QoP4LOQ@mail.gmail.com>
 <ZqC-TW7ygSSF3MyO@pathway.suse.cz> <20240724124743.GC13387@noisy.programming.kicks-ass.net>
In-Reply-To: <20240724124743.GC13387@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jul 2024 13:33:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJrCwOwj4myGgpgyig9dX37hir1S2Xdeg1=kVS-hPzAg@mail.gmail.com>
Message-ID: <CAHk-=wgJrCwOwj4myGgpgyig9dX37hir1S2Xdeg1=kVS-hPzAg@mail.gmail.com>
Subject: Re: [GIT PULL] printk for 6.11
To: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 05:47, Peter Zijlstra <peterz@infradead.org> wrote:
>
> So.. I've complained about this emergency buffering before. At the very
> least the atomic consoles should never buffer and immediately print
> everything. Per their definition they always work.

Yeah, my personal preference would be some variation of this.

And when I say "some variation of this", I do think that having a
per-console trylock is fine, and buffering *if* the atomic console is
already busy (presumably with an existing oops, but possibly also for
"setup issues" - ie things like "serial line is being configured" or
"VGACON is in the middle of a redraw or console size change
operation".

And yes, before anybody speaks up, that is kind of the approximation
of the current console_trylock() logic. I am aware. And I'm also aware
of how much people have hated it. And I'm not claiming it's perfect.

But I do think that the *typically* important case is "something went
horribly wrong, and the console was *not* busy at the time", and
that's the case where there is no excuse to not just print out ASAP.

And yes, then if some oops happens _while_ the console is busy
(possibly because another oops just happened on another CPU core, and
now *this* CPU also hit it), at that point you go "Ok, trying to print
now would just make things worse".

And a lot of consoles may end up simply having to buffer, ie if you
are using a network console or something, maybe "not buffering is so
painful and involves thousands of random network cards that we
realistically cannot deal with it".

(Same ultimately goes for slow serial lines - there comes a point
where waiting for things to flush just isn't worth it)

So I'm not saying "never buffer". There are very valid reasons to say
"I can't very reasonably print this synchronously".

But I really do think that we should never buffer "by default". And
that's why I kind of hate that whole concept of "oops_begin starts
buffering". It's exactly the kind of "buffer by default" mental model
that I was really hoping we'd never have.

            Linus

