Return-Path: <linux-kernel+bounces-564402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98546A6541D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13FE37AB0ED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C534C14A8B;
	Mon, 17 Mar 2025 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJtnUrLS"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6212C24503B;
	Mon, 17 Mar 2025 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222705; cv=none; b=Q1+N5Gsw1nx0T6SMkx4hsS7QD12X3kHdzujpzMHwKCjykejZtoSg62ceT/h68T7+HbPM+NjQOTSIvYhKrQ3NBsTBfEafFWlWrLMY6gmLqVeDe9lybDD5pEruAlLwSmdUtf4d0WExjlFN1/2Z3M+Epn9YHho5MVh+7+E6yn50nPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222705; c=relaxed/simple;
	bh=I9UUZU9xTvQrwwGU0Nw5G9RLvU6eRIOtq9X15cAuTGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nc7CaEHTRFvIwsSRaIgrRNwIT2zWNfbHrnPlPRZ13+lJ9eJeHPEjpVwQtm9l8MuAftXax5CDXv1AzIuHeL8cUPGY/aAh6ps5pG1smEIEYnDD3O9C7JzcAIaHimLNq2cjlwrLEuhOvhsyicJBeNSfBomAEG1+Pq4gjO0GeqpXyOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJtnUrLS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54963160818so5539689e87.2;
        Mon, 17 Mar 2025 07:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742222701; x=1742827501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9UUZU9xTvQrwwGU0Nw5G9RLvU6eRIOtq9X15cAuTGU=;
        b=lJtnUrLSHB+fgiDo9FHZnf7FCPgL/IT4Mq0I8l9GS7A/NRNWE8KD5AkiBN/aICqTo5
         uJfsqWKrp344KBREqPE9rtfJBt4zsdeBCGdloykaCY2YUaZHsA60D5CW0AZVtoY6W+fS
         +gmeGQJxwIW+lHrxIO9O5qcgmwmUWQhNGm+157Iwm/CBN2DuQ2NKNGcBUFKZNYHd7aLa
         1xNNPHgayZOMZAN3C72G9zmJp9/a0DHm+DS9Bf6gOgioCmgU4FkRZ1XLFkun7NyRoGkb
         l0FcoYwPEuhFFTaEx6HlPjDXr61Ltiuny7/epVpemt/anBqKV3oAm7IjBBzER4fTEzry
         Nm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742222701; x=1742827501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9UUZU9xTvQrwwGU0Nw5G9RLvU6eRIOtq9X15cAuTGU=;
        b=FOQkMzB94f/J0+syeu5cRbo5BqUOkYluaqJDNE/phkYvPTlcLwmMfGxhlEyUihQWXk
         ZGpIc0nwRuVR/oFPH2R2TlLa+mwKZo+DQQn90adEK0dVUufYDU4ULqHJWvBgFyoG7Mpr
         3jlKoxVivQc4kHBYg97psK6TkS/NoA4DuPgpuFPF5V6ajBAdtt6lkJBolQVSmg6y00w1
         P69Pjy0GENwhd/38l0WVrugR+S/P7zG8OMajrq7TuZm6SOnJHLAzr/YmORkOilm1hHnA
         W1Oyk4S4XlMHusIYIqXq61jWPSQqTZTcLb/M5pZeBaUHTTaJd+zn7mluPTpqGOdQmNsk
         yZHA==
X-Forwarded-Encrypted: i=1; AJvYcCUgTZcs9F/EyWQAKwJ7RwsTxO0zH68JwVTo1KXiJ7Uzq/J6a/nQXEWaHzW9kKEBr7bBxC+o96QUGsm3cRY=@vger.kernel.org, AJvYcCVhb8irAnc32wCLUb0FC0PrnmYxTuTWkHaYrKnbHQ3y8sJ+hm8oDJEXKHpJnwhcQ/vk7CGuc1CjiXS3IJJmlHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU/H5MpGg7pbFck7rj5hWAUq0/c3Fe6K1+3Lsoajpia5EKl507
	1G/YbiljZvmFIjlgkCRsnvp3gJb22Io5YLNeeTLOBSNBO/0LrQGrv933zFTGhQbaSLw1j1Y0fZX
	CcDaKiplKdVDOduQUMo6BtDzXEAM=
X-Gm-Gg: ASbGnctxk85Ym/fOnw1LnAKzzmm1vWnmjZ258EVb18AhSywYjSMNfm2s6NexOqcvskh
	CxT/N8c6BRPXMUhEjmdMxcc0b7684v3evtArT4tRNlBrb6yJhQ7qFQmw3ZFBwrvIk/L2pnOpnCN
	vJECwWAqVTBxC7TYYZYpnzNe+1QTWBYk31zqTCjQVgHMyejv/KH5s7AMu8p6fsXCQsfrBoSGA=
X-Google-Smtp-Source: AGHT+IF3JAfAXIUF+NuWBSrB2XsRb0hI5WwzvClIdeM/wPhB37Q0y77GqEYzF/dxZr7Zm2q+Rl1U9kdXJxwf4DkJfFg=
X-Received: by 2002:a05:6512:4029:b0:545:2d4d:36de with SMTP id
 2adb3069b0e04-549c3922a93mr7587701e87.31.1742222701310; Mon, 17 Mar 2025
 07:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com> <D8IGFTJXS2A1.9JBD1UKGN4PX@proton.me>
 <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com>
 <Z9gL5hQWvCNy5XNH@google.com> <Z9gcqHihXLg6kcZb@google.com> <D8IMCFZJ2G7C.28DHUZGDB596P@proton.me>
In-Reply-To: <D8IMCFZJ2G7C.28DHUZGDB596P@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 10:44:25 -0400
X-Gm-Features: AQ5f1JrDRBoi1LGAjMTLj-9hXRnAueqDSej0TOGbktcdahId8Ppxkhjm_exSeTg
Message-ID: <CAJ-ks9kEpC=7jK9CLNKBWYpoOyAo_Wr8eyvaYf0ZSiC8m-VREQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 10:42=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On Mon Mar 17, 2025 at 1:59 PM CET, Alice Ryhl wrote:
> > On Mon, Mar 17, 2025 at 11:47:50AM +0000, Alice Ryhl wrote:
> >> On Mon, Mar 17, 2025 at 07:34:44AM -0400, Tamir Duberstein wrote:
> >> > On Mon, Mar 17, 2025 at 6:04=E2=80=AFAM Benno Lossin <benno.lossin@p=
roton.me> wrote:
> >> > >
> >> > > On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
> >> > > > Add `Vec::dec_len` that reduces the length of the receiver. This=
 method
> >> > > > is intended to be used from methods that remove elements from `V=
ec` such
> >> > > > as `truncate`, `pop`, `remove`, and others. This method is inten=
tionally
> >> > > > not `pub`.
> >> > >
> >> > > I think it should be `pub`. Otherwise we're loosing functionality
> >> > > compared to now. If one decides to give the raw pointer to some C =
API
> >> > > that takes ownership of the pointer, then I want them to be able t=
o call
> >> > > `dec_len` manually.
> >> >
> >> > This is premature. It is trivial to make this function pub when the =
need arises.
> >>
> >> Normally I'd agree with Benno, but in this case I think having it
> >> private is preferable. The function is safe, so it's too easy for
> >> end-users to confuse it with truncate.
> >
> > Thinking more about this ... I think we should have `set_len` and
> > `inc_len` instead. That way, both methods are unsafe so people will not
> > accidentally use `set_len` when they meant to use `truncate`.
>
> I agree for this on the public API. The way I usually saw `set_len`
> being used for decrementing was truncation without dropping the old
> values. And that is going to be `vec.dec_len(vec.len())` with the
> current design. `vec.set_len(0);` is much clearer in that respect.
>
> But for the internals, I'd say that `dec_len` is nicer, so for `pop` one
> would then use `self.dec_len(1)`.
>
> How about we keep `set_len` and make `dec_len` a private, safe helper?

This discussion is _way_ too speculative for my taste. If you'd like
to do this kind of thing, I'm happy to drop this patch or the series.
I'm not comfortable adding API whose usage I haven't seen and don't
understand.

