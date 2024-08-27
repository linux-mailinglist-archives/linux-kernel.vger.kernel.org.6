Return-Path: <linux-kernel+bounces-303753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F639614B7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3121C24087
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17151CDFCE;
	Tue, 27 Aug 2024 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jDMGpJe4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE591C5788
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777738; cv=none; b=gnLq+/29ScoEtW45wxZ4M3RIKk9cOQmavAV6/AkUa6vm+lPzBErI6am+rHH1bX5oK1fjnomPVBF4kinV+VVK3LvWUwG6lsa2qp9dLRWRXBYgMb+n8/RsYi+8In3aWHqAYsTS8tFayqPzTuF9VIGk3ZgDXVx3Ja9KOUwD9bHNeX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777738; c=relaxed/simple;
	bh=lrrYIG7in/QR4AMy4ffSfWIq+2Jt3VMtFMx3YJ2o+E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A60lbJCbfSaXKZBUNoLzbPsit3haU5pJR1HOOKymEQ+p7QsmlzFylmZrUMs8MvILht1ayCWWZrwpm8HfoI/wFNvAqIsCoYwLVNw+yTvZ6Aib3AosiwpbzyCo5oobwMy2sT9FLwUt8Orfz8VBMPYEQkdq2KEZIGZLcTtvgroYs2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=jDMGpJe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD532C4AF63
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:55:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jDMGpJe4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724777736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pT/Xdh5+T8GlMlK/jW0CPUYYdVUk10nShsIg0lBI0xI=;
	b=jDMGpJe4MAS+kU+4Pdr9LRaBUvPQ9zjPsUfNNSjAhnCAn18+O/YdBd9Fmah5Uzn48cYB2c
	qMoLY7YVkzibqXbkjjbxBBhtzrhp9ZVLZF5zeVw9Cit3m7+AqDqGCiwv5oefvUlph7YRK1
	1rmYVubRhJ5chtMEIIPJmbRmg7WpsRk=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 00b8ce63 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kernel@vger.kernel.org>;
	Tue, 27 Aug 2024 16:55:36 +0000 (UTC)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-27051f63018so4567388fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:55:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YzgpE9cRcwN/Qz8dEz7UvZ5a87e8yhgeEJRj3Edi4PyxQBcwUSL
	b7/D3FiE8ZXp8j1J6HTpIVg5s+rpAiMrbKSmsnjwZx9SjrWdurD/Y90G03uosmswimRhIyl8qky
	Fo+twp0uTo/2M9B84McWpztH2PX0=
X-Google-Smtp-Source: AGHT+IFaXR2bwF03p8eVlxcaocMo+O4Guka092XVHmvCP/yFHHu2Y7y2NO++PRR78G0P+iAxA6isu94K0/5YO7a/roI=
X-Received: by 2002:a05:6870:a10f:b0:260:eb3a:1b2 with SMTP id
 586e51a60fabf-273e63e6bc2mr15811940fac.7.1724777735245; Tue, 27 Aug 2024
 09:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827151828.3326600-1-Jason@zx2c4.com> <20240827154822.3330270-1-Jason@zx2c4.com>
 <ea693ce2-61dd-4885-805f-28aa7e60ea28@csgroup.eu>
In-Reply-To: <ea693ce2-61dd-4885-805f-28aa7e60ea28@csgroup.eu>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 27 Aug 2024 18:55:22 +0200
X-Gmail-Original-Message-ID: <CAHmME9p9vEN_zcwgFt07m7jtHJ3cxkN=yEQNNb5h8uYShJrajg@mail.gmail.com>
Message-ID: <CAHmME9p9vEN_zcwgFt07m7jtHJ3cxkN=yEQNNb5h8uYShJrajg@mail.gmail.com>
Subject: Re: [PATCH v2] random: vDSO: move prototype of arch chacha function
 to vdso/getrandom.h
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 6:53=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 27/08/2024 =C3=A0 17:47, Jason A. Donenfeld a =C3=A9crit :
> > Having the prototype for __arch_chacha20_blocks_nostack in
> > arch/x86/include/asm/vdso/getrandom.h meant that the prototype and larg=
e
> > doc comment were cloned by every architecture, which has been causing
> > unnecessary churn. Instead move it into include/vdso/getrandom.h, where
> > it can be shared by all archs implementing it.
> >
> > As a side bonus, this then lets us use that prototype in the
> > vdso_test_chacha self test, to ensure that it matches the source, and
> > indeed doing so turned up some inconsistencies, which are rectified
> > here.
>
> Side bonus that I dislike. Or ... it is all that u32 key stuff that I
> dislike.
>
> If it was really u32 I would be able to read it with a LWZ instruction
> (Load Word Zero extended). That's what I did at the begining. But if I
> want the selftest to work, I have to use LWBRX (Load Word Byte Reversed
> ...)instead  because the bytes in the word are in reversed order in reali=
ty.
>
> So either it is a table of 32 bytes, or it is as defined in RFC 7539:
>
>    A 256-bit key, treated as a concatenation of eight 32-bit
> little-endian integers.
>
> And in that case it is not a table of 8x u32 but table of 8x __le32

It's a table of bytes that are 4-byte aligned. Or, sure, a table of __le32.

