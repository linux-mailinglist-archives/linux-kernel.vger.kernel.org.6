Return-Path: <linux-kernel+bounces-291272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B65F956027
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 01:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66AB1F220A4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 23:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16022155C8C;
	Sun, 18 Aug 2024 23:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ6W8pQY"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140DC1A270;
	Sun, 18 Aug 2024 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724024459; cv=none; b=ZGec0xtLMnuTcgoCHXoSGddbWXp2ap1n5JTzOWjhJvawbVC1GhsCjTX2yyWhR+03omKUhQDMCjle2nClaybdxeblJ2qDKY/GA4lZV6Y+sfy394+cys8DcZ5U26N+1C3ZeFNEGLZOiA2Lf3E09adx5mKFUFdWGx08VwC++jfgN68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724024459; c=relaxed/simple;
	bh=JPMhUR53W1LQAo52Vm+lFmzisQ+6GX62iB0ve2z8pE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNqs3/xXmrNkBhuVE/eQoFSuP5jDeNRDrLNtMOjlrcwzyBhNhYQU7IaqSpqQWvHcA2clGRqGcJxbA0JckuGaFeuCaZayGkeONmBO5Btahjg+a11g2jH0+cnfU5ZDmm3owJND3ukzGZbMtaYXFxqaY6778g4MvJ7LThURojGgz1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZ6W8pQY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d3c08541cdso2743694a91.2;
        Sun, 18 Aug 2024 16:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724024457; x=1724629257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v59q99jiIZDGEhVy26WZsBaijtwbFioIky9kBjG5YAU=;
        b=QZ6W8pQY7xnAg2ntCZx8S1lpJpjtbcko71EPgcg37ZEpqexIqlKLdaDPnsd97EyGpT
         m5PE7aBcrHTArrigQcAhqp2L3WMms71+m2lww7hZQeqAFE8v3jq3Jk0PkiJAvokZ4QhX
         9Oro4q0ZTKx1bpaqYDn6Mg20Jt3WkaevDodGfCxqJWwT9WNW2p9u2WRPgUGlNueC/54Q
         96XKdWAoWXgL1+yxZRa+hnV2RWwDqyZkvbIqEmPLkGt+7u09LwJ0pr7RVO48v7dRmb+V
         E2WZqP9Ufr0S7pztqyeJaOhtGTnWtZSJRLA7H93HH/2ZbcaJAaRjuc6GWYRpoRg40h6V
         zd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724024457; x=1724629257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v59q99jiIZDGEhVy26WZsBaijtwbFioIky9kBjG5YAU=;
        b=kY+yA/S7Pe7N5meRvOoZBjZd/Q9P/UnY5CZARqPD3Tk5h4NU7SHquZg7o/A/lycYhw
         jhHyYY+LKwEJJD2uCkeegQMasoZPQ+/MR1/fnsabg9tRCBmjl6+J9mBSE3PphntxulWK
         6SrW31S1OXMs3GyN9Q3npL5/Ibi4ST6tohZf4WGKXyw3VbyhqmT13gRWM/eBHIRP3C0W
         Bk3uTvsWs24Pn4YSKj+FmHAy3a3l+XLChy4eLVf/QLDq2YgJJ4r2q1NJi+tf6Xllm0zM
         6Bb55ENvrIhAfs7Kh5+t3EvNshXZzQQmvvISd2Hopm43VtmYGynlFwNcupvlz8F6/RNX
         Oilw==
X-Forwarded-Encrypted: i=1; AJvYcCUTBtnBTJGkNB9pOtRVOGOOcHlLdNdxt3+5PtYuwk8ExdVN/d+J9xnz/FarrsTRVNajG4UrGsHUy5vw0CQ=@vger.kernel.org, AJvYcCVPH6CAD/CeJRWJIqSI0LVvhMUmqoGNYwmPq1Y40LseW3RVwS8xh6TNgFmLFVn8Py+cR9jaCDWLYV7TYLCuYVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq6cjPwmzeHKPBiVmWEr9xs9qq82oKvmRkLjwns/y1a72jAmyu
	FgGGKZQQYKVk4B4y2pS+zPbnMXiYiCp9IBGjSkjO4OzCJa6X7tgFMyBHi2u763Gk/QzrHaY2Z7j
	lI1G0DkchOhWI9Dp5Vv1aLNhtUeI=
X-Google-Smtp-Source: AGHT+IHr+4Y3IZRPArIsKEgxYHPD9DoLuxJrGQ3mH41DyA1LsW8Wi+0LpNAaO/mM0pECSMPf76jvhbu4/a+wZ0V++zY=
X-Received: by 2002:a17:90b:4ace:b0:2cb:5134:562a with SMTP id
 98e67ed59e1d1-2d40533a35bmr6498157a91.7.1724024456724; Sun, 18 Aug 2024
 16:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817165302.3852499-1-gary@garyguo.net> <ZsFEpjvE9osKDb3b@boqun-archlinux>
In-Reply-To: <ZsFEpjvE9osKDb3b@boqun-archlinux>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 Aug 2024 01:40:44 +0200
Message-ID: <CANiq72k81VrS+3Skh7gfYzkcxTsGscUJOhroV4MXH-LZgroZFg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: rust: auto generate rust helper exports
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Dirk Behme <dirk.behme@de.bosch.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 2:49=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>
> This also passed my test script (x86, arm64 and riscv build and kunit
> tests).

Hmm... I think you either tested another one, or you manually fixed
the dependency (`$(obj)/helpers/helpers.o`).

Or am I confused?

> Miguel, I think it makes more sense if we take this one and the
> helpers.c split one as early as possible, given they are treewide
> changes ;-)

Agreed, we should take it soon. I have rebased it on top of
`rust-next` and fixed the dependency.

Please take a look:

    https://github.com/Rust-for-Linux/linux/commit/0d6e3e8d3677ee7b5cccf9bc=
002e18f140c02a4e

I will put it in after we confirm we are not confused :) (and after we
get a linux-next round or two for what is currently there).

Extra `Tested-by`s would be nice!

Cheers,
Miguel

