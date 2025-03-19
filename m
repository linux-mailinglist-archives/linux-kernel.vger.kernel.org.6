Return-Path: <linux-kernel+bounces-568494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B14A6964C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8717E7A14FD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43131EFFA8;
	Wed, 19 Mar 2025 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr9aPgDq"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0BC35942;
	Wed, 19 Mar 2025 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404985; cv=none; b=nPm9gDmoQEKPepy6/a53sSHyJHKVNjBSsuBMM8xR/PgY/QgHTiUyZM5vFDNh/PG517IIJ6YY7otH1wGhKt0JLhXAZQEJ/jV/icV26DoKeBrqLBJjHrpx/qkgaC67C44368dFd0nDD98zbNHDmN037pXEVrw97Icm26cy95MtHY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404985; c=relaxed/simple;
	bh=hsaYUgrXM5qfLvhH06tltZQdRCjc5tEs2EI/X9vdw2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfXFbYbxkazIEW7dWXBDq9ll68BRyeGMMHt20bp8jyY/FQ1osYANYb0SDowtTDCh0Xkjxq+VM0mnP20+Tfh4/bKXXLzQarCnau2IZQOpb3TwEDHsX05uxZth2W298U66t5a6TcuhSGtdi5DYSgHXpAFLFbFrRlv7BdfxL2+SwTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lr9aPgDq; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-307c13298eeso12584741fa.0;
        Wed, 19 Mar 2025 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742404981; x=1743009781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsaYUgrXM5qfLvhH06tltZQdRCjc5tEs2EI/X9vdw2c=;
        b=Lr9aPgDqdju3vuKRhsZ3J658hOerO7V3Qqw+NaIbTU9o5oMKLovHsAA9nj3HE0o+yI
         gYRmMQ7XoDSC4QC7NMLsHtZfAHmt5HzIuL7rSgHMPdKULa7rGMQAA9vclRYavs8UPxTv
         2Q+mLb6RGK3F+iYtE1BFB9tefhZpoC1LB2pw0OedwPw4NpRzXJfLEpyplXm0NcFuixhd
         /a9tKX0AtBvw3N7tSycbSRF4NzKLSQ4TJuZalgQp3ymavSr2/PtrrKqjzk5xOh/XbS2y
         sfhUQFqflpva0mCZ5wweEPX13NNKvBAOhAYyGzQXH+Q7W3DNq6Ak+BNTtlfK83B/sHpM
         JwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742404981; x=1743009781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsaYUgrXM5qfLvhH06tltZQdRCjc5tEs2EI/X9vdw2c=;
        b=aARmSsYz8XtfEM7nzK0jMYKeBskK/vjjHY4DRm/22HNVn5BP++t2/+1rSaWLuHLCcw
         wvy8ww1yHLgodlSRpTlFzJ8CsEhErFJe09YOJQN5CT70LbGniSfkI0QWCkOZOrsVw1Mm
         3m+bp5AvQDazY2K9+OgfV9HPhs3OdzN5AL9sbrDwS4SHBcFI1lxDXA5VQTNjBO2KtW/B
         GanbisHXkxJNN3PC6KKC0vSxCxhheKXJhR3MlI8LmfJnBmGxwpVUt8R9h29sStHgp+8m
         adAaBBkUzDe5GX9x//vWJVl5bTAL2qa2RR20yoXPh0UvYv2WR59EvyH1Nds55AeMjCHE
         H+xA==
X-Forwarded-Encrypted: i=1; AJvYcCUAoJjjbX2jDRBF0pd6FYp8vDHKq+v1OPMyYfcvjd41QnrUSWNw9kiAYTwETtNZ7uGBuDB3f5BA3BM=@vger.kernel.org, AJvYcCWY/bLw6CePpr4+PI+7GMA9ZGtiRT8dAx2sIMDy2YG10nBPuQrfZE4jYpfUo/exd40JrBFg00JCN0cQGxab@vger.kernel.org, AJvYcCXiJPB1gAIJnz+5eiVkJtSEwknZa5YzLm09MiftJ4CQNV0m5wYgBpESHUU/Xn2kyhTzIt8Byl5Z6eb9RyxjF70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4bktso//HhuglA2cYrNNbUk5yZnSUplZnH+sF/F4g3oE9o01m
	6D/3KjsdKMqjnk6Nzx8XO+PMKTBaSdxzxW3E4NJCK6/9l65QXfRfHdH6UqmQEXmOL4s86nrifTt
	StScJpyaJYOvONlk4LK1IvR82I5w=
X-Gm-Gg: ASbGncvQAzLlO6OQQcr50VNmWjCkWhUQ2sp/Pm4ej/qPx0aosxpZEmBdX0M/BPXAITd
	eoiGMDlfR1M+4vSeKs/B0HY1diqO4lsxZE6PF97pY1BcRI+fWKJ6TWR7+q0kDLjUtyiE5vxMXB6
	V2P9EcuWYurEVhlpH0gCb5Wx03ynA583nfsrgQEEIsnSCcaEuTJL/a
X-Google-Smtp-Source: AGHT+IEjO2m1zIXw4HFAj9tm3S3oc43HEXQnmavT/Wdw9EFY3wTfyK5+LzJIIT2UTtXDcjxCFrMJwxSj2WzQC4KjEys=
X-Received: by 2002:a2e:90c5:0:b0:30b:e73e:e472 with SMTP id
 38308e7fff4ca-30d727aac9fmr1171781fa.14.1742404981302; Wed, 19 Mar 2025
 10:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316111644.154602-1-andrewjballance@gmail.com>
 <20250316111644.154602-3-andrewjballance@gmail.com> <CAJ-ks9kAROOfyPtxMe6LE4-UPsvXca2sQ2VDjhRchZp3HLddGg@mail.gmail.com>
 <D8JTWL8JY7DM.3IVH6FZ4M49CB@proton.me> <CAJ-ks9k+A1+0CWXZmD2m0+jRqTRTNFn-=d9VXqytiOqvn4BR0w@mail.gmail.com>
 <D8KBFC9M74H5.4ZJ2SJK06SGR@proton.me> <CAJ-ks9=NQrz3ySacKt+XXm2vS+Fn9gjmtqAaaoz1k=iTG_1HXw@mail.gmail.com>
 <CANiq72mnT73Mb7RJhZjf4de=_Orv4pipunMhOersOj_aqrFA-g@mail.gmail.com>
 <CAJ-ks9=23qEqxT5rivsbfNYC6iUP4RXsKbcDU9XDx32ERnKbYg@mail.gmail.com> <CANiq72kfgDVkKAeX1SiahEoo13+kHrcvVY3hMAfRPGjwErCt6A@mail.gmail.com>
In-Reply-To: <CANiq72kfgDVkKAeX1SiahEoo13+kHrcvVY3hMAfRPGjwErCt6A@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Mar 2025 13:22:25 -0400
X-Gm-Features: AQ5f1JrVVB0KaF0SOHg6B4PqxeZ26bWmx4gdmbRKGmZX3gyzx8re07gIpcxQEmU
Message-ID: <CAJ-ks9=mbqMdguFmnRP+t-P2OC+oYGVDU2oLtT1dZzY=USESEg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rust: alloc: add Vec::resize method
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Andrew Ballance <andrewjballance@gmail.com>, dakr@kernel.org, 
	airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, acourbot@nvidia.com, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 12:43=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Mar 19, 2025 at 5:13=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > No, I meant avoiding the check. The existing code already explicitly
> > checks `new_len > self.len()` before evaluating `new_len -
> > self.len()`. This means the check occurs twice. `checked_sub` reduces
> > the number of checks by 1. Perhaps my wording could have been clearer
> > ("avoid *an* underflow check").
>
> Ah, you mean in the function you suggested, I see.
>
> I think it they all may compile down to the same thing, whether
> overflows checks are enabled or not, and whether the version in the
> patch or `checked_sub` is used or not. At least in a quick Compiler
> Explorer test it seems so, but I didn't check in an actual kernel
> build.
>
> The implicit check is gated behind the other one, so that one can be
> removed, even if values are unknown -- we always have optimizations
> enabled, even under "debug" builds (assuming "debug" means overflow
> checking enabled).

Yeah, this elision is what I was trying to allude to in the original
wording. I still think the suggested code is simpler, but gave my RB
either way.

