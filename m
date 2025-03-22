Return-Path: <linux-kernel+bounces-572593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F22CA6CBF6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 20:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC04E7AA434
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 19:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938C8233712;
	Sat, 22 Mar 2025 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="NKkRKj1k"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5314D1AA791
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742670741; cv=none; b=CBWRx13PROLhN2vKQ9H82/EfkBrLZZV+8Wwrx6+Vsz5KZT2Rb3Zw52FQx7aZ8BUWkWNeU69T2XFGB7XQVrd6B8I7t1y+zScEaHDdtoonY1PTdkxphq7ijlbZkvVxNq9a9veHA3nwbYhT6GYPmeQeuhWe+FHruB9F49ZccftFrsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742670741; c=relaxed/simple;
	bh=Ms3GzoMd0rlk4O2lv0P7VKB/JXaNBBDottrVBUZkhXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJniLYoj3cKzoMoY4wo19eUPrvyfiQFRjGqWJZmBNa5v7sGQqV7lp2nl6k1OP25k8Z/TITuwDk1NiIcaRGtHqsz72qVk02b6FkkBlbWxdgOrtrGMpyiHoZJc8/t1T/w31SU8OQ913v04Mcane3k+yCx3LRZYUylPwR5E0iLS+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=NKkRKj1k; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6feaa0319d8so22733547b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 12:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742670738; x=1743275538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xc66qLysPvi281ZD9mTakiRweaXqO3hMAEWrZlpzBs=;
        b=NKkRKj1kiT/HQmu7ibaWo0/LNpusXk8Ar/5FeSLeH+saNcYNMyJWURQX2Iv+IXbltR
         44TwBxHyYkNmkaiFLCLKFTL3uzOhknmC974TPHuyPHL+8qe83Zpl4TTtKahg/syAyefj
         G1Exhd3VOx7FFCIa2Honz/z67Tor/gkCr7Q/aTv3ytcWpM/1OvI8KFfP4T3lVWNq82Dt
         RjyqrarQJskwFIue9SlxnRHQ0JSVL/89g8rzO3tHNMqAWDY9Rc+O3K/i0HAq5XViqBqC
         keaZ2w9i8MFb6shtt11rKJn3PvvZ+PuGXJehe2N4CSgFCdNxEzTwFAdoTWC6TVWbs+XE
         L8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742670738; x=1743275538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xc66qLysPvi281ZD9mTakiRweaXqO3hMAEWrZlpzBs=;
        b=LFzZOstcQbxnbx34VbmCSxasBY79mUx9GfHS08g7cJWePgq7QiMi1kkYEsa2jdWmMN
         WX8/4NgE0SmBB71iWnoVVUdXS+/CDVn9qZpuq8Tb5FmV0MatGHl3e9rRVO8dXZFfMwYE
         lXFEdn9G8bMcPK4xWHlobnk88FDOLhD17a5iBf4mpwtCyxYP2wSu2Syv5saaa4oNaVce
         tNizHRLMx3m66VGqdN1KyRH7W9YxK7KOTGjS2gVRnneb/3T+qxROBECytK8V1LY/RH34
         fAs1tseK+v9RXPxMj2vsWl9rQFjpIyKuxO1dPn5vblBv57DH+xMXGa65pvTVj0A4avSX
         pz5w==
X-Forwarded-Encrypted: i=1; AJvYcCUa/UU8MiuuGTU1WPdDRYeVn5uV5sfnJvaZLhz54ijdfG59FuwtEeegpKV2dJo4r1iijwzvXirzzcJFgyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSxgDGsK6zlmBZqJj3aB3F0/J/dZBvZ4dz9b1sbntOL/DRLW2X
	+pFAc1E2GQlu6S/wQY+yYKzq4Qu19EvbRO/1DGFrMpUEFLiwAVZjQH5n4fs3SnfeaQoZGRs5iVA
	4gBI=
X-Gm-Gg: ASbGnctSPav1PrTMKXuXHHn5ScQOChqoJVL6K+lUA4NdrNnbR3poMC2ah2ZBuQ5gVtv
	rLJkiAP49MN706zkqBOO+fW8QQ6Y40jbdLRAlJ2s+AD2JZDO20qVEHqI64Mb2J8ldI4WHm4uqcW
	RJgVx5AhL+wZIS22Ni7zByL1aH0u3ClMgfgJC2WIkFME4Q6pgv/RckVANHWxt8xGLTJhTw1kvvF
	tWa7NiAJRkdHp11j21g8g1tgK/2AP4jKtUSRXX/ZYd13pEc4iyW7RnxCN9oXBGvuAoM13UVsDbG
	hLn96QxvHFOIUcwhC5frKgjxOaCpWW/zU6MrbVk4zlkivTYXvYDXZFu/KbcAZxhFdn1ZdYopRQ1
	n42Gh04MJDCzfcoYdExIO6c4sVBYHROBTAC1UPuQd
X-Google-Smtp-Source: AGHT+IGKshaTgbMcpr9UNssd5GQF9rWZ6akyX1Lym+sKao77CEU4NvOIGlBPRgaIF+zI1BiKem6ung==
X-Received: by 2002:a05:690c:fca:b0:6fd:2321:567f with SMTP id 00721157ae682-700babed947mr87056967b3.8.1742670737953;
        Sat, 22 Mar 2025 12:12:17 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-700ba7938e6sm8572027b3.64.2025.03.22.12.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 12:12:17 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
To: tamird@gmail.com
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	contact@antoniohickey.com,
	dakr@kernel.org,
	gary@garyguo.net,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	masahiroy@kernel.org,
	nathan@kernel.org,
	nicolas@fjasle.eu,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: [PATCH v5 01/17] rust: enable `raw_ref_op` feature 
Date: Sat, 22 Mar 2025 15:12:09 -0400
Message-ID: <20250322191210.1926380-1-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CAJ-ks9=GHVfd=iRT73DviOD=6dio3U7wQWLaXAhKr3UG5-ivvw@mail.gmail.com>
References: <CAJ-ks9=GHVfd=iRT73DviOD=6dio3U7wQWLaXAhKr3UG5-ivvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Mar 22, 2025 at 02:24:30PM -0400, Tamir Duberstein wrote:
> On Sat, Mar 22, 2025 at 11:08 AM Antonio Hickey
> <contact@antoniohickey.com> wrote:
> >
> > On Sat, Mar 22, 2025 at 10:16:01AM +0000, Benno Lossin wrote:
> > > On Thu Mar 20, 2025 at 3:07 AM CET, Antonio Hickey wrote:
> > > > Since Rust 1.82.0 the `raw_ref_op` feature is stable.
> > > >
> > > > By enabling this feature we can use `&raw const place` and
> > > > `&raw mut place` instead of using `addr_of!(place)` and
> > > > `addr_of_mut!(place)` macros.
> > > >
> > > > Allowing us to reduce macro complexity, and improve consistency
> > > > with existing reference syntax as `&raw const`, `&raw mut` are
> > > > similar to `&`, `&mut` making it fit more naturally with other
> > > > existing code.
> > > >
> > > > Suggested-by: Benno Lossin <benno.lossin@proton.me>
> > > > Link: https://github.com/Rust-for-Linux/linux/issues/1148
> > > > Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
> > >
> > > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > >
> > > > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > > > index 993708d11874..a73aaa028e34 100644
> > > > --- a/scripts/Makefile.build
> > > > +++ b/scripts/Makefile.build
> > > > @@ -224,9 +224,9 @@ $(obj)/%.lst: $(obj)/%.c FORCE
> > > >     $(call if_changed_dep,cc_lst_c)
> > > >
> > > >  # Compile Rust sources (.rs)
> > > > -# ---------------------------------------------------------------------------
> > > > +# --------------------------------------------------------------------------------------
> > >
> > > Not sure about this change.
> >
> > This change is so I could enable the `raw_ref_op` feature for doctests
> > since the minimum Rust version 1.78 still has `raw_ref_op` as an
> > expiramental feature, and will throw errors at compile if a doctest uses
> > it. Is there a better way to do this?
> 
> I think Benno is just asking about the extension of the dashed line.

Ahh ok yea that makes sense, thanks Tamir, sorry Benno I misunderstood.

So the reason I extended the dashed line was because before my change 
the dashed line perfectly aligned with number of characters in the line
I changed. I figured it was supposed to match the amount of characters
of the line.

Giving this a deeper look it looks like the all the other dashed lines
are maxed at 77 characters. 

I will update this.

Thanks,
Antonio

> 
> > > >
> > > > -rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,lint_reasons
> > > > +rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,lint_reasons,raw_ref_op
> 
> This looks correct to me.
> 
> > > >
> > > >  # `--out-dir` is required to avoid temporaries being created by `rustc` in the
> > > >  # current working directory, which may be not accessible in the out-of-tree
> > >
> > >
> 
> Reviewed-by: Tamir Duberstein <tamird@gmail.com>


