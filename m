Return-Path: <linux-kernel+bounces-209154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC38B902DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58875B21F81
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCEB10A3D;
	Tue, 11 Jun 2024 01:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J0tcoW/K"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBB3DDB8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718069080; cv=none; b=k0qm5LcCbYTp8v2DMShRB/lS/GheDkvCn8npT9kgBUdwF71APgFkA5GS6VXbQrvgtS7t2NbHa6kPTa7+4c33t4U+vBukJAodB0BN2tLVwtob11eA9XtZa1H2vAxcszHTnfcJwfd16v7Lz2YOkil6gc6b8DEOqpshrwnti9yrtkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718069080; c=relaxed/simple;
	bh=D2mY0PxworDetejFBvMMJPM3s8A1YQGEEiK9nq7hZKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9FtAvht/z0prZA7L+FHYCPJaCMHY/wObTCETNTdF6Q7xeDy4zka+p597ubD95HWIVWQQk0hK1kto/pN08LXS2ReAkLIE/m3ot3D/zBmpRbmNAe5N4kO7s4yiHh/iUESVNW1UffzlYryjRrPZLItDydQoaXZj9d+Y1iuk0fxZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J0tcoW/K; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57c83100c5fso482852a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718069077; x=1718673877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c7ZYubABZSpYrLP7RVmTG2Pj59U8OWIrsQrqs7DlbNY=;
        b=J0tcoW/KBgdMPuLf7Gk4WmnYQAOFKXVunxkAsMJYjh2x36jYBITHxO7+7gOFPqY+l0
         hZ8AClvwKoXmhAmPaLHHcwElxx4ZTnaMN5c89+iapkjfTUwL5EmDlYiIZx9s1G/Doek8
         VUB5QDxbGAEzvn/CXrEXaqBo3El431zCe/3Wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718069077; x=1718673877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7ZYubABZSpYrLP7RVmTG2Pj59U8OWIrsQrqs7DlbNY=;
        b=oSkd37u0vJRak7CpzDQBIY0X+ZcwyIMVdF7P9bGl8Hv97C7tNo9cDJU2bC+COug31H
         EDOFs7Roa7RGg+LojbzuS9GbhFZF5JPkloKeglrRA/u153Wfv1L67kx836iziEAV5Q4E
         AFlu/K+htT28gUYNDU19kxDzGdg324Xo0fKbLGmRrj1dKAlRkxHZBgJsJR9ZuE9xUi8B
         QsjZ1cct9ZOMIguCoDdVytGoUOLFW8qvuPnGi03mzTaEMUObrwKHXd4t1K4driCx6iyg
         AnuM2wXT5c15713JeN313lbCyWCbl/Hi3+zsb89F7I5SsqihZ1UtcpNOEFoB4MSenHQX
         mGYg==
X-Forwarded-Encrypted: i=1; AJvYcCXFpnwHouH0MrSYJMOAZdCTpb3HAjS87idaeHOn6f5d7vmBlyvonC6xibKrmzWbdy9B/xkKzW1YZWWA61ES5UHCvix7uF8pLQ1HA7Y0
X-Gm-Message-State: AOJu0YwSxGUdnZVrVTShC7ZNTsUid69B4+OV52CiLubX4ztdDzQ2devX
	muapD/XEsrcDstyh5yi5R9gihFvjRDDS1aQvMzjoPuNixEqZVV63XlHHO+0+NHefJJeVIEb05QF
	Knjs=
X-Google-Smtp-Source: AGHT+IF68fM3oOAMvVRDOkXvK/L7NfQxyS9O078pTujWqe92bWsUETPM/2M/BMK1MaX0rdPpLgRm5A==
X-Received: by 2002:a50:cd1c:0:b0:57c:73ff:d13e with SMTP id 4fb4d7f45d1cf-57c73ffd1b2mr3801166a12.31.1718069077182;
        Mon, 10 Jun 2024 18:24:37 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c7d3d5efbsm3510348a12.64.2024.06.10.18.24.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 18:24:36 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5751bcb3139so528086a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:24:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9TxJEiciPT2Lf9BJbM65VcAcWYAFCSJY8A8RNBy2/wLjphINfdkgEQ2K1es8LqQxARIxsTX2hqu6fWrY83dWPfvXRKzT9pksqnW9n
X-Received: by 2002:a50:d648:0:b0:57c:8c45:74ff with SMTP id
 4fb4d7f45d1cf-57c8c45751cmr1347189a12.41.1718069076241; Mon, 10 Jun 2024
 18:24:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608193504.429644-2-torvalds@linux-foundation.org>
 <20240610104352.GT8774@noisy.programming.kicks-ass.net> <20240610120201.GAZmbrOYmcA21kD8NB@fat_crate.local>
 <CAHk-=wgb98nSCvJ-gL42mt+jt6Eyp-0QSMJLovmAoJOkQ_G3gQ@mail.gmail.com>
 <71FE7A14-62F6-45D3-9BC4-BE09E06F7863@zytor.com> <CAHk-=wjTzFYo2+eQJpb56Df8sNDW7JEV=_6Di2v-M5x2kv06_g@mail.gmail.com>
In-Reply-To: <CAHk-=wjTzFYo2+eQJpb56Df8sNDW7JEV=_6Di2v-M5x2kv06_g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Jun 2024 18:24:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdsN=dH41MO+gASWZkexCgrwK6CGT=NvpA3xsVXEhxBw@mail.gmail.com>
Message-ID: <CAHk-=wjdsN=dH41MO+gASWZkexCgrwK6CGT=NvpA3xsVXEhxBw@mail.gmail.com>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Jun 2024 at 18:09, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Doing it in general is actually very very painful. Feel free to try -
> but I can almost guarantee that you will throw out the "Keep It Simple
> Stupid" approach and your patch will be twice the size if you do some
> "rewrite the whole instruction" stuff.
>
> I really think there's a fundamental advantage to keeping things simple.

I guess the KISS approach would be to have a debug mode that just adds
an 'int3' instruction *after* the constant. And then the constant
rewriting rewrites the constant and just changes the 'int3' into the
standard single-byte 'nop' instruction.

That wouldn't be complicated, and the cost would be minimal. But I
don't see it being worth it, at least not for the current use where
the unrewritten constant will just cause an oops on use.

                Linus

