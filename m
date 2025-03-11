Return-Path: <linux-kernel+bounces-557033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 289D2A5D2B0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1992189CE6D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F5022B8D9;
	Tue, 11 Mar 2025 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqvDo0VO"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CDC1E9B08;
	Tue, 11 Mar 2025 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741733316; cv=none; b=DNZUgYNuQX5IcXH4ZF+iH28/MFeJ/Z6h6W8IdLVQLHXuDM2p2nykkPCt4xDFpcsV/7lxovpyZTdyXJrj7To0/46b7xunES4T4ntHIWZfR4SDbl+Or/F6NnFqJ44pB6vaBy71XGiSBpImRFvZmMoXUv4gaOtApNt0ODmYykwql90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741733316; c=relaxed/simple;
	bh=dzR3kg1K14SryKr6V7a4hqA5XeQjyj+BkbncRdQT7FQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0qG0+tS6UtWBR6BNZ9I+NzrWCoOaDsWJk2q3VhSUZWqhVKYEDzDDmoU/faTSfzhAEpjoDqtgj3eKjEadMb/WHRAwkjvNdSIyW6/yTpxCiVeN/18/mRZWLb1vQVHLWPpGQ9A2zJP36tji5SKOuMUtLGfv447/RBEZT4F7XNCs9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqvDo0VO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-307c13298eeso3890421fa.0;
        Tue, 11 Mar 2025 15:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741733312; x=1742338112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzR3kg1K14SryKr6V7a4hqA5XeQjyj+BkbncRdQT7FQ=;
        b=kqvDo0VOmaXAY87w7OzGIhGFc3UVXjH4Yb+Ewxl/lLDZosnxeLIy/zm+4AXntw7iQu
         BUA1lMuiE5I5JMgKUPmJhKbo+0t9b+c4URStbT2SUGCGC+7nYAaKneiWt+Vxgn5sxFFn
         PmA/cfGVvjAAkvEHqCrxOrt/RJYwPUygAXFDRWN4D3lpPl6DhFak+N7qqW90Ez0uo/oO
         5wSnQMeeOu0XiLkUktaLtEcVqbtWtQaaz4FPpb1HGxw4xdHSWmdyuNx4X+V0ZTWJiSb9
         efuqDtZPzTwfnM70kSmrbpLWIIAu49Lsb1hx5NvAdEl9lHFySX1HLalMDboy8Jw2MqVF
         R5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741733312; x=1742338112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzR3kg1K14SryKr6V7a4hqA5XeQjyj+BkbncRdQT7FQ=;
        b=AI+54wW6PU5niFkwVdBcAw4tCKapdTeOVA29c8laj30VEQjrPafwXqZg1tEubHO/6O
         Blg/rhbvRopbKZSPmcJhos172nqwXu8hBjjU+Kr4dOCS4usqvNbuuyr0SrE+nNV7xbJg
         saRgIFoAMjwzArUqcufKln3pjv8iwXLtdkYsDyLnkgBbjIm+hbaC9IkXsl6bQv3LEj6v
         Vxun2farabKgpjTynlnrRkKZK7hzTyn+X4tseZ4u0bzSyoTwiREThRyB0kxeBauglvNt
         Wet+NrV1cRkLWHQBip8L9vPf95f7SOz4Ls0zW374adrhXZjClk/sUK1Dmul2KAQqckF1
         3BVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLUlS3Hgp8WcuvWckL9u4nubAMehCLF5nj+mZnYD36VMwJPWsOrvKZrwE+5jM+iKeUPUeEHc/OiBE0zYc=@vger.kernel.org, AJvYcCXPCSHgufmPzkoVg0XVMU/m8bEBXknUGibIh99f+/oqI5gm6U1kXn2gVo3vw/S05UPj/T6FKSI/FbBbFBuGO64=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuwqJPfbA51LJ6rgXTQKOgP3l4E43+YpCgXfI0H4Vj9wW7PQMg
	JF2pts+i6LLrYQmwrxhCopGuWxwfhT3aRbBvWVEMPQw4dUszry/GzsdgivZbpnKiQznPiaHgrli
	9RfnXPLlpFWtpUudyEtJuhdcmqt0=
X-Gm-Gg: ASbGncvkC50c0erO59mO+DhFepHbzv2lFCMRaEDJRxKzCrXpOLdg5u22W8ebJPPbJx6
	816WpKHrRnh2MgvGIENN7EUBPCjAM65Wksf7+b2M5cVJm61xCWJzQGAl2ENOrcTqECeCoXjfndy
	2IVi5jt6Pgg2lDi5zkNR1BLCOh325cvr51DqnOhw7At+czhg/o3jFCQJ6cHXXD
X-Google-Smtp-Source: AGHT+IFxMazR1y4/csYbs4VOZ8XRn6mkT33q1rVlcrzb3kzugmv2Hw9L7yvG3rNTi5l6XJM+TG7+4ahm3dNegRjZn34=
X-Received: by 2002:a2e:be27:0:b0:30b:b78e:c445 with SMTP id
 38308e7fff4ca-30c20f38e92mr18965061fa.17.1741733311563; Tue, 11 Mar 2025
 15:48:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-rust-analyzer-bindings-include-v2-0-23dff845edc3@gmail.com>
 <20250210-rust-analyzer-bindings-include-v2-1-23dff845edc3@gmail.com> <CANiq72=YhXGKLuEfvK5XnAsc0sbuf4FBRt_GnzmrZoW_L-S-ow@mail.gmail.com>
In-Reply-To: <CANiq72=YhXGKLuEfvK5XnAsc0sbuf4FBRt_GnzmrZoW_L-S-ow@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Mar 2025 18:47:55 -0400
X-Gm-Features: AQ5f1Jpl9_Sj6lG8M-83eKmmb-4Da8JvHR1rAi4ULp-KBjHodXODi7oCoMrPEno
Message-ID: <CAJ-ks9mSqxzV8F=SwGeHpXbRZ1814Cxk+AiyMnyjS5h94JqxFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] scripts: generate_rust_analyzer.py: add missing include_dirs
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>, 
	Fiona Behrens <me@kloenk.dev>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>, 
	Boris-Chengbiao Zhou <bobo1239@web.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 6:00=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Feb 10, 2025 at 7:04=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > Commit 8c4555ccc55c ("scripts: add `generate_rust_analyzer.py`")
> > specified OBJTREE for the bindings crate, and `source.include_dirs` for
> > the kernel crate, likely in an attempt to support out-of-source builds
> > for those crates where the generated files reside in `objtree` rather
> > than `srctree`. This was insufficient because both bits of configuratio=
n
> > are required for each crate; the result is that rust-analyzer is unable
> > to resolve generated files for either crate in an out-of-source build.
>
> Originally we were not using `OBJTREE` in the `kernel` crate, but we
> did pass it anyway, so conceptually it could have been there. So I am
> not sure if it counts as a fix for that commit, but it shouldn't hurt
> even if backported.

Ah, I see. The reference to `OBJTREE` in the `kernel` crate was
introduced in commit 169484ab6677 ("rust: add arch_static_branch").
I'm not able to build at commit 8c4555ccc55c ("scripts: add
`generate_rust_analyzer.py`") but I would expect that rust-analyzer
didn't work properly there for the bindings crate for out of tree
builds because of the missing `include_dirs`.

>
> Regarding `include_dirs`, it started in `kernel` before being in
> mainline because we included the bindings there (i.e. there was not
> `bindings` crate),

I don't follow this; there's a bindings crate at 8c4555ccc55c
("scripts: add `generate_rust_analyzer.py`") - at least as far as RA
is concerned.

but it should have been probably moved when it was
> split. Nowadays, I guess we still need it for
> `generated_arch_static_branch_asm.rs`, or is it something else that
> needs it? I assume it shouldn't hurt, in any case, so it looks OK.

Yes, without it `generated_arch_static_branch_asm.rs` is not found by RA.

