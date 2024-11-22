Return-Path: <linux-kernel+bounces-418230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC209D5EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A3D1F23CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306E21DE89E;
	Fri, 22 Nov 2024 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjdC2Sbb"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49010171088;
	Fri, 22 Nov 2024 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732279000; cv=none; b=KcZsmsb8R1yidCoY1TDnN9QH+g6xyISqcVw/qDhxXse83/RxeQuc9HmjE6zv0X8SU0YKRGRnDQY998LRNGaA94U1aj0ozIQUimyHx521mJhdvi38l8G70Ewx3kNECe3z/B7/lmraRizlwOsyo0Dhf87OSjQz91TqwM05oHb51tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732279000; c=relaxed/simple;
	bh=VT5wHf731wbh8njvzCjsMOSHE3tDpULOk8zBvrcr68M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZ+FP5IF5VU2MjVtV17kufgvMBgGKIlOvaOg/dPg4JtU3lY1YoNO7Km6GkDrCl//Qe6oRbMAshSRouH64oR4BEe6XxmtU1h3AAjzIXWYw/2ENWUavjMiAFfakcLCOhXggxBFHSk1n9isnIQuhZuApB4Xla13ZcRhvbsL97T9Qcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjdC2Sbb; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ea4c418488so259671a91.3;
        Fri, 22 Nov 2024 04:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732278998; x=1732883798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F27MCrwLjZ+dSHo8EUEX3qsIzyan2TOuBGm997yug5U=;
        b=kjdC2SbbIp9G9EIy7lpCb2RvmGY37XxTufpV+5lDQj4h30cmCbp6RWESGCDOVrvNW5
         0a5UNdRxKzHxm7xftEmheTcCONgt9A557qCF58yy1u9lSp4kfQh2reM7eRAwamYabinr
         s++VgjqU+hfAIK/5kIznlxHjjQmmqCeoBSwcW+LAGgQryzCrEykMN6gLlxrKr/kmpzF7
         xHt4YdPBMtTBC4ljh3RDHwrpeNBsRE293zR4JRTs33X3O71Eh9tRjw23KJbWUkL/5D3K
         tWLc40YJk9x2UjzNiscQw/of2P8mYwi0jrKU/QUngNvgVYMALpZJQymsYvDlTri5pcpb
         iELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732278998; x=1732883798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F27MCrwLjZ+dSHo8EUEX3qsIzyan2TOuBGm997yug5U=;
        b=S4Cgwe0kQH4dgSRjGVkCPZYBB47twAJkFdho5eglu2yYW2wONKVztbk51F0YGI+34x
         gOfdwWw7YaVZBazAN0eVqnLxRMMaz7VcDSACzsTqXdNBQP3Jt+6VTUgplEcU93QPpC3K
         BfIyEenUQo3gUalxuhxebZ+VWa8Qi1LOtxQwOeYBt8IJxgs0ybS9krwvQNA/cTm4UZ11
         C92M0l0YsYvlpBioh54iztslU6n8+lkI19JPy+xPJEbjaNWm6Y8KEykBWlDZ/Tv67OMR
         HS3wqssnZBelzXyJylg3e10WRWtzsExoMpgvaVE4PyLSgCWGQcW5f3+dmx6Xwp7eCNua
         mauA==
X-Forwarded-Encrypted: i=1; AJvYcCUM1QDYgRCV+6gr7087FfhoFig9ZvjNXCmz0yTmRL4p5YQyX/qDq+oZdgdHnosIJ1VLR6yITuixX/PfGWY=@vger.kernel.org, AJvYcCWSgmrdMMpxO0imHgcntT/jrFTxxI3ZzAgH6q4V6dhs3D065JRN7WzjEz4OjxJBS8K9ckqbvm5vENPBuHkWxs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+VhTvzGs6Bfjn/4TwooTnOpnKIu9+a2ZQBpCr2MX9CePUL2GJ
	++zsgYcAY5YHr6s/26Sr2QAEwVm+2oAWxsAtBILV2cqqQ6oSwTndElD+sYC4EMDB5V59mcTAzIr
	XJXByhF351zghg5wtHmf4QhcyShQ=
X-Gm-Gg: ASbGnctAvlcU/xO31J9ULj+i8gBpSDmdkS3Xr10BriIUKKqlGeFsj9C8KVZ6HdxieZO
	VAu8AezMYdKQbWZG8ViTqIGtX4f+CAwA=
X-Google-Smtp-Source: AGHT+IHhPCO0vdeIxqGWd0XUwtfa2VOzJMpx56irGG05LdsS2/MOHh+aFlR7WLGo0brL0o/+4ejLZuodz+cvLBwIkag=
X-Received: by 2002:a17:90b:4f44:b0:2ea:956b:deab with SMTP id
 98e67ed59e1d1-2eb0e87f52fmr1444049a91.4.1732278998474; Fri, 22 Nov 2024
 04:36:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
 <20241017-hrtimer-v3-v6-12-rc2-v3-4-59a75cbb44da@kernel.org>
 <25I5c2B_KkmqpaLqb6jsZyMd9WMhQbTaIKyUYY5cKa8bvR7--HvRiXJ_5cDiyde31tnivT5_C_5IJ6XvLqCusA==@protonmail.internalid>
 <73814ac7e363af44ae6e410f101feb75e94244ef.camel@redhat.com> <874j423p7r.fsf@kernel.org>
In-Reply-To: <874j423p7r.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 22 Nov 2024 13:36:25 +0100
Message-ID: <CANiq72mkBufEV43HcZZVKB=1UDxOrpweFxeZJBXt6U0=vPMsdg@mail.gmail.com>
Subject: Re: [PATCH v3 04/13] rust: hrtimer: implement `TimerPointer` for `Arc`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 4:52=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> No particular reason. It is often easier to rebase things around when
> they are on their own line.
>
> Are there any code guidelines to follow on this?

Not yet -- we have a mixture of styles, though we typically don't go
to the item-level like in this patch, and instead have done it closer
to the "Crate" or "Module" styles.

Ideally we would automate at least to some degree, but currently the
relevant `rustfmt` options are unstable:

    https://rust-lang.github.io/rustfmt/#imports_indent
    https://rust-lang.github.io/rustfmt/#imports_layout
    https://rust-lang.github.io/rustfmt/#imports_granularity
    https://rust-lang.github.io/rustfmt/#group_imports

I agree that deciding on one style would be nice (especially if it is
reasonable to expect that the style would be eventually supported by
`rustfmt`).

Cheers,
Miguel

