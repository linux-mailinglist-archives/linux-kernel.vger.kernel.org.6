Return-Path: <linux-kernel+bounces-566302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA2FA6760C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C01616E4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEC120E00C;
	Tue, 18 Mar 2025 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ac6bOJav"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DB020C006;
	Tue, 18 Mar 2025 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307188; cv=none; b=iz3XZa7AkiWLxwGq4T+b0rL/D3YyARXdeWQPNqDGNHjPUHZ2q2dQ3N5Z5T6DPdkGZisoKlWKeHV0hzX+T7AQW/RZWoxzDHScyM9tnijuVQsujRZilqaItRIQUHMBt4iVYPUkUfDrxD2868RPWzrGk4CG6caZyOzP8H2z9MtlfSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307188; c=relaxed/simple;
	bh=H89p4OYYGj+sC4YJVID6fjRfmbSEwHTEybiH1Dbrt4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0nWQjNjKQl2mXfQAVb2/WjXxUahpe4SHcSUEyAwvf2hBXKV614IA2jhI+dBbJFhQvu89qXrULJ/5CEEz+efTdvupAiZq50P7N8qmbXidle2Wo6rAZ6xDiF/BPMfcm3CyIovH7P1gu9D/B8rsLQmVaEJWG+WcCrft873qg62YJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ac6bOJav; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so56627221fa.2;
        Tue, 18 Mar 2025 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742307185; x=1742911985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72bnBTjIDKCr1qm7WXIa/G5tnGBA++WbTcwV/E0sbbs=;
        b=Ac6bOJavSxe9g5VxTNyrPEKm/kHo/Bp7hJQBKJ8om5kgjxpq+pX31ZbA9ckdDHZyDE
         ixY4DzFiljQbbSE11KeuVHe3YKMeNVEKgNSUcRvkDhkRSLNW1Mnhd1zzzMt03cRj2iAU
         PlvX7Oq726B3OHYCWUpWjWOC8lxkdnu3d3WSZiJknAuu1BsLOzeCWI+y+RExztrGdYCf
         tdZqT3reACpG0H+WfDh0FBOOzhZk1DA5OZa8l73d81hrXTO06LAOltSf3TJPpfHIpba4
         jNOS73GbbvyOR6GQlEL0EGbS1hrKaZsam5qWrJXBzwZpwWgvTxPPh6pn4zuVVif255cu
         df1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742307185; x=1742911985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72bnBTjIDKCr1qm7WXIa/G5tnGBA++WbTcwV/E0sbbs=;
        b=W0lSDoU8EzD5Ie1PmLifF5PDpORu/AxqRWsqhpKOX5L99XR+bXd6Trgh/6miNm61DA
         AsEzPVH/yVsYP1oVTxc/Gp0epQ0zA+0KiKiRwdhChUy2RizoZAlqCQaCuEcUPAabIiP1
         6uBycS/yXk40AnrwbEBv86XlPtH1q/FDikjgHxrAmuCCbwz4P+Ugak+Qe/fUz1XMqOHT
         Xn/IDmYU+m0FfKpJ5wxS6zo8emkCmGhHGfp/BmMHSfAEA4egh8KMpaIhRJ/xqn3IImvP
         OT/uWoprPECjAjq8qyn4hmrXBwyKS09WEufKGic20QJ2ylRlvB8iV0xfvPNd6Blge1qc
         0fSA==
X-Forwarded-Encrypted: i=1; AJvYcCUHwW6mjhokplOu8fc4ZrpwUTIBrCFvMFYIBFZx0uEEtD2GrhIlpJ8Kd7+jZ9G72QPht1EK8NbKdhVJbwbxfUE=@vger.kernel.org, AJvYcCXE7nYyyWhp69niRUndvO2W9cULEzSfimx5HzkUJ9n7eZdMB/DsVwTKqi3aRuAfMSVSzb1q2Zn2PISREWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8GanTAcPuR34hB+auEQgzxr0glZwB5+3dmDBJHSyBI4LC9zqk
	CX7xSTaWF6heNQfDVPCuvFS6GbZx1TS1JyKMO7WCROtQDOd9xahLdnSXbgC6p8ZSrEvyGE+9e+2
	3rSgTbu2HfBnc3flkAK8DT4yRIA4=
X-Gm-Gg: ASbGnctKpOMNv0a/2tzERQl+KGNQKxR0QYGvIJt8QG/Dl3IVG+sz978q0SfMIbfR7ku
	uxcwIQ9MicTi5djIcNKf+XpVvaCpBi9Wp2j9Okaa1eFt22OytFu0jlxcR4+5XPbEE7dJZ+I71Bk
	xFwZESetClc/7EOxbH/jxQ+8jzmgQExZWjEYMnb9iXyw==
X-Google-Smtp-Source: AGHT+IEFwE3j0c+AGnRg/jMplwSpgNBf3PgCA0uRO3le3RzB/4cmx8TBP5O2sJOeqQcLRFBdaavlinjHGb+C/xo7YzA=
X-Received: by 2002:a2e:9698:0:b0:2ff:56a6:2992 with SMTP id
 38308e7fff4ca-30c4a8f56cbmr94278651fa.37.1742307184344; Tue, 18 Mar 2025
 07:13:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com> <D8IGFTJXS2A1.9JBD1UKGN4PX@proton.me>
 <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com>
 <Z9gL5hQWvCNy5XNH@google.com> <Z9gcqHihXLg6kcZb@google.com>
 <CAJ-ks9n=7fqtNr88co-EU7d9Wo1Dz1Wmp0p3K0b8RQE9mjrbHQ@mail.gmail.com> <Z9k9I6mp11Z358vz@google.com>
In-Reply-To: <Z9k9I6mp11Z358vz@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 18 Mar 2025 10:12:28 -0400
X-Gm-Features: AQ5f1JonjhIK7QCRT7C5_1BeFtn__gYXeWN9fROjL_tTCcM7aCpLxLjMXXxelIc
Message-ID: <CAJ-ks9kcNvGqGrU1nKjYs_4XPbdxo2cW8Tj9JOGJesGO4StdAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Danilo Krummrich <dakr@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 5:30=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Mon, Mar 17, 2025 at 09:53:04AM -0400, Tamir Duberstein wrote:
> > On Mon, Mar 17, 2025 at 8:59=E2=80=AFAM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > >
> > > On Mon, Mar 17, 2025 at 11:47:50AM +0000, Alice Ryhl wrote:
> > > > On Mon, Mar 17, 2025 at 07:34:44AM -0400, Tamir Duberstein wrote:
> > > > > On Mon, Mar 17, 2025 at 6:04=E2=80=AFAM Benno Lossin <benno.lossi=
n@proton.me> wrote:
> > > > > >
> > > > > > On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
> > > > > > > Add `Vec::dec_len` that reduces the length of the receiver. T=
his method
> > > > > > > is intended to be used from methods that remove elements from=
 `Vec` such
> > > > > > > as `truncate`, `pop`, `remove`, and others. This method is in=
tentionally
> > > > > > > not `pub`.
> > > > > >
> > > > > > I think it should be `pub`. Otherwise we're loosing functionali=
ty
> > > > > > compared to now. If one decides to give the raw pointer to some=
 C API
> > > > > > that takes ownership of the pointer, then I want them to be abl=
e to call
> > > > > > `dec_len` manually.
> > > > >
> > > > > This is premature. It is trivial to make this function pub when t=
he need arises.
> > > >
> > > > Normally I'd agree with Benno, but in this case I think having it
> > > > private is preferable. The function is safe, so it's too easy for
> > > > end-users to confuse it with truncate.
> > >
> > > Thinking more about this ... I think we should have `set_len` and
> > > `inc_len` instead. That way, both methods are unsafe so people will n=
ot
> > > accidentally use `set_len` when they meant to use `truncate`.
> > >
> > > Alice
> >
> > Isn't it fine to keep this function unsafe given that it can break
> > invariants in its current form? As expressed earlier, I would prefer
> > not to make it safe by using saturating_sub.
>
> I guess that's okay. But I would think that with the exception of
> `Vec::pop`, the interface you want for Vec methods that decrease the
> length is set_len, not dec_len. That is the case for clear, truncate,
> and drain.
>
> Even for the Vec methods that actually use
>
>         set_len(original_len - removed_cnt)
>
> they make this call after having previously called set_len(0).

The methods you're describing are all on Vec, right? In other words,
their usage calls for a private `dec_len` or `set_len`. As I've said
repeatedly in the course of this discussion: I would prefer not to
introduce `dec_len` at all here. It (or `set_len`) can be introduced
in the series that adds truncate or your patch that adds clear, where
its signature can be properly scrutinized in the context of an actual
caller.

Tamir

