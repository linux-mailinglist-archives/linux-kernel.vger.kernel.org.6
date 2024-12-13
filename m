Return-Path: <linux-kernel+bounces-445465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878C59F16BC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 20:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E998168380
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C2319006F;
	Fri, 13 Dec 2024 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHmtHzs7"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3906518FDBC;
	Fri, 13 Dec 2024 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119310; cv=none; b=k+NXgo2bi5Qq731JLhjarGc8HTjBBPvWttgVWmZ643VnQkD4TXUkPmu96eS3uENpajXMbq5oYjR8E1L7KuoEVLfi12/V63H4wiGcyYtRdvPw2zQP/npiIRxsHIkgjR0V5PMICtj/v6cOcccbJ8VcytaFaGQCk3YSToHpeaZVoMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119310; c=relaxed/simple;
	bh=Vurc2KP5+4QVBFbuVs0dP6ku4wF47ulD09PvMRB9tcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOQiR3b8wFQYWaJWFIlBjgiwQ20/6V5ezK1pppzTFVV1gwqkR346jopFAwo7HfT92nasheEPHsuQNxsEb2WCihh8MjjKUPC2bpMxqsJ17qZJGGaPNqpGaXRvaCGgMa3diWX+FSxk4CqZhdeWLtHw19BzmEcMUlbzW8vXauTGWE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHmtHzs7; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ffd6b7d77aso24204821fa.0;
        Fri, 13 Dec 2024 11:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734119306; x=1734724106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vurc2KP5+4QVBFbuVs0dP6ku4wF47ulD09PvMRB9tcs=;
        b=BHmtHzs789y8Yf+zIhgGo+gN56tqXNK9arTHWRcOL0FlqjYRo8ViEM3EDZ7UZTi33d
         LFAaATAa9nPseitmE7zXfX3PcWyEWbZV36VM0CXv9uJ9uJvoUa4Zvm618iaEt7Jcxjwu
         WafO1RlO+JjM7/jTduj6052HzuC2EEHO1DNZ2lFuvDq1dEx7lVtn9YjDJOnoi3cQjfko
         kA4NE7AN+dim/KHh/UYNHGHguWgeGtneseFNE3cHkyOIO0idHQP8F+kksBd3lVVpRiLy
         Fl2Z6WJV25m3O7vKBm1Vu8Ttv+WeXzTDZUkiHeezJf2TNgMEfmES75kgj/9ZmFMwvLNX
         lAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734119306; x=1734724106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vurc2KP5+4QVBFbuVs0dP6ku4wF47ulD09PvMRB9tcs=;
        b=WY3dKXIZSXmCKLAEv3DFVbbQ5wPV2SonYSjbsK9pkKq7XA8t8j1jX+fUeIiL3+ngb1
         hCrswG0tSSX2tm06bvpC4+u+yon4GE5YSwlFlZm3usoexDhxDhX00th9qPNbQXE8oZMk
         o2r7fWKQL3ra951DYcEqCKzRaD0Ypj1M0fSsMd7AqItdc4OjursBV7HLdDZ1e6HiUa3O
         W7j0IIZu3VYX0ymjXYThDcbmJLvcH0VwB+zfh4QAMNL9z1/2/cmu21yHPU3G7ZxcBZHw
         IG2jNolQOMOV0vgnxGwq/rPPWB488DtyavLlJOv8GtbstaDPGa7GQP3w3ZIdrpbHzxPh
         oMGA==
X-Forwarded-Encrypted: i=1; AJvYcCVfEYMogoC3khAl9CQgHqMnphJPraU/2DUmdNPEKsUlq5EYP6KZhRt7oE26rJHsue67QiroqRU657SqDp8=@vger.kernel.org, AJvYcCW2AuUGJLbaNgRINVvwqhFUvbqjlH/o2cT51kWHQ+HW6jp9Xr9NBX9idvvXY/GeapH03ukd3Xl9tDNK0kBLVe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIpYsFcJCBh3ZoZHVm9sZxHeR1Kasmm0YeIk9E/1FYuf7AIDes
	z8ukG3t6qA+4jbrfrvUiDqvLTvdXHHZtjbch3aGWJvDfz6qVc3AxULNYhB9YDuupCRE7AQaCp3z
	NQCglIM8OVYNx7pGPEZWHDVQdCbc=
X-Gm-Gg: ASbGncuvO6YPIxvPWvTHzh2+M+5BWlHiVQ/wt6lUrVzXvRIg2ZwYj3sMkSO6p4KWSMl
	MheBKhLpp3AfHHfPimwSGAfmBNPpZTWCQHbCPG3aRVoqaZiy4fFV+ag==
X-Google-Smtp-Source: AGHT+IH17SKd1N5WM+nUHWjBPw4lVA6yJSnG+3ibZJg+4DznHci1+1zcaAYOmwEdSe1dTdh3frDPUkmyZbhMe8oELsM=
X-Received: by 2002:a05:651c:b0d:b0:302:29a5:6e01 with SMTP id
 38308e7fff4ca-302545666d2mr12979291fa.2.1734119305957; Fri, 13 Dec 2024
 11:48:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-rust-xarray-bindings-v12-0-59ab9b1f4d2e@gmail.com>
 <20241212-rust-xarray-bindings-v12-2-59ab9b1f4d2e@gmail.com>
 <CAH5fLggwK0LXAsBnP3FtFHCnEzzBNNZfsCy3iJ6w=nT07CHgVg@mail.gmail.com>
 <L-1MAJJDE02BClBz6dbLWTKAz6RM33gupqt5fPEyX9tYoW43aDrrH4oY-OerHc17mpVTgy6j4e6_EauQQY8Viw==@protonmail.internalid>
 <CAJ-ks9mTEcRg6=ZiYFX3ebHSYgMwTv692ufUdTCoA1vX5E1nNg@mail.gmail.com>
 <87pllvczag.fsf@kernel.org> <CANiq72kEk5y=As6rOSe6V7w7AV3qg7u3Dd+PKtwWzzDEi1a1RA@mail.gmail.com>
 <CAJ-ks9=_nO292bvG=ir1o8dLvc=MGdT__m0pU48-qn6YdwSJVQ@mail.gmail.com> <CANiq72=f94m5mG69+wvh-x7xX_-sbRuq1OzMfOtkNJhwWstqcg@mail.gmail.com>
In-Reply-To: <CANiq72=f94m5mG69+wvh-x7xX_-sbRuq1OzMfOtkNJhwWstqcg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 13 Dec 2024 14:47:49 -0500
Message-ID: <CAJ-ks9kU6JrKLUVw-Rvph8Fi5EZX1EgJey2KCHUFn7J=BYjx5g@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] rust: xarray: Add an abstraction for XArray
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 2:38=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> Personally, I would rewrite at least the `if` one, since it is not
> really how we write those elsewhere. The other one, since you are
> building an iterator anyway, I think it makes sense. For similar
> reasons, perhaps one `match` you have could be an early return
> instead.

I'll make these changes.

> But it is up to the maintainer. By the way, I don't see the XARRAY
> maintainer nor the list Cc'd?

Oops, this was an unintended omission. I'll resend this and include those f=
olks.

