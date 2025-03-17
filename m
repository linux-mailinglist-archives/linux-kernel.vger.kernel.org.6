Return-Path: <linux-kernel+bounces-564281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1224A651DB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8BD3A627D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F60D23F28F;
	Mon, 17 Mar 2025 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWJJsANt"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C96423717C;
	Mon, 17 Mar 2025 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219625; cv=none; b=uJvHVyBNGhK0oxadS7wb7ANwv1IiWKQh0OMwRsiiVOy1e1ZSUoN5Svfby+XxsA5JrLYgG/1wT5V9wG1KrVnbswzdTtgFBpJkPhEXNM1nkXVDGmacLx8wmje8T7trz3xOG2ehfzXocKlJfmzLFPuYpuDYp1fGkzS20jpR/+ryCVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219625; c=relaxed/simple;
	bh=w894LevxBGGRPh8vYZ4i+pBWMWSqEu93O1T7hzhnmTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1mpwG4X+2aS0I1ZV8D3rvMYBck3kXyptPoAtna73DhzTZS4eKFM8Di228BKVaW4Yfyub/Yv1WyMFw/wzC86sK4ARXYqbPHG1xBFru4v+MACJFSWq3UnI5pBr9Uc48XXspQh6SP498KEN0oN9IRz5dWrLJ6fzdWLx6VFnLwUYfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWJJsANt; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30795988ebeso46191341fa.3;
        Mon, 17 Mar 2025 06:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742219621; x=1742824421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w894LevxBGGRPh8vYZ4i+pBWMWSqEu93O1T7hzhnmTs=;
        b=UWJJsANt9pqjYm1OLVoFmGJEM15DkUHKAy0Y1/l0WomtG2EZbo3f11XtuSbblnscgl
         jOF4MjEiRhxuQs06sYPJMe2eIBiP5I2h+Au3OZ492BqNgWfUhwQDxmMDvfXaViptqvi4
         jGAeueqkxno5G/5RZeIrfUW6pr/bGl9R/F4GY1+2U0n/E78CBrn0ycGdtyhQ2t7+nKZ3
         j4cpgxvuTMfAF/dtMPsJhy2OuDGlbdQCAx+NFxeqNxRJ2K13Rl2lXb81fHYLpHoZ1VsR
         uQbjPgdz+citjZP++boYJI/tmM4DFOvcUabjbfVsN6ZiOtNM4almygorVhUvAYOo8SsN
         u41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742219621; x=1742824421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w894LevxBGGRPh8vYZ4i+pBWMWSqEu93O1T7hzhnmTs=;
        b=R/sPDnxuuyS+r+ZdqRfgaNYP77sTSioMwJT0IMd5eYptlTcbfCbi/hBqWxDv/WnQAq
         9ZUxCw/EbSMiOagDKtvz8W4aDo5KFBEXUChZY4zrOsy6DqaOvlE4vydQuWUSU789GPcB
         karPsXAj82DWreQfvPXabbRAqxCaFioLoGpn3oFlPhJsFQXkJMenHek87jMeXzO8fNl+
         vwz7DZO8EE7iDghdnhzr38ZHjq3/REEB0eYkxtTw7XvK4bU6/+TQl0RBPOTW4jlfBGcQ
         64xOEZ3Z9zB1R3YVSn3KN9kfDKheGncz8uH9O4R+Yhg5jL2YfkeyrpbO+qR5Hoj5jQrN
         3fvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL3Kl1ca9iUO3qOLlX+EBjReWd3CbGVV+OxrpXQCQHFRxpj/Hp1+QfKVRsCRxLyyiNOOkpxKzwkOoyRaBBWqM=@vger.kernel.org, AJvYcCUL4lW8ZkxdtSSDNu7b99uS47Oz7NecE3Q2tXuFyfDOtsiJuWk1wl7vnb3qZVWfgHZbU9KJujc4X7yy3Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy/p6ePhqJjXXWp3gWtMv8OL8Khq5eQfawVuj4RSJe3Tp3cfPU
	i0LW5O2AniTCiKW48B+eI0sP9LR9QtryIiOHMYCdddECxrme/5q+GiZmBppP5xGt1tW/bXqeIR6
	gSPGjzK4Zy6G3O6wkzI8+B/2fTss=
X-Gm-Gg: ASbGnctIC2+ABPxf7KKA0SVmZPkcN3DP9YbV7XpOyI4WufD+AbtCF2ynn2LcNFE/FjT
	jiEOJAOePVuq0kqhOcVGnTW8AW0Ko84KLkMNBOrLUFwKaDICMoOulpmPOwPkmUsfgSXO4PT1qFJ
	L9bDpk8jsOzl41oKMAnRlN4zU/0A9QltSB9WvkU+c7XEyx20Go6HPsPKjXDCjM
X-Google-Smtp-Source: AGHT+IHw7fz93SSva0ywBv3KjPQS46f7I++a9EG+9AJHR+5rthaM2FQDQny+joqvYCGDQzhtUt4vlSxwZkW0C7eR+3s=
X-Received: by 2002:a2e:a546:0:b0:30c:5c6:91e0 with SMTP id
 38308e7fff4ca-30c4a74e129mr66902771fa.2.1742219620987; Mon, 17 Mar 2025
 06:53:40 -0700 (PDT)
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
In-Reply-To: <Z9gcqHihXLg6kcZb@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 09:53:04 -0400
X-Gm-Features: AQ5f1JpaMc_6dbAG2d6vWkGKQ2EIKB1GI658lNc9zi7qbVQrJG32wjF6MS84U6E
Message-ID: <CAJ-ks9n=7fqtNr88co-EU7d9Wo1Dz1Wmp0p3K0b8RQE9mjrbHQ@mail.gmail.com>
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

On Mon, Mar 17, 2025 at 8:59=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Mon, Mar 17, 2025 at 11:47:50AM +0000, Alice Ryhl wrote:
> > On Mon, Mar 17, 2025 at 07:34:44AM -0400, Tamir Duberstein wrote:
> > > On Mon, Mar 17, 2025 at 6:04=E2=80=AFAM Benno Lossin <benno.lossin@pr=
oton.me> wrote:
> > > >
> > > > On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
> > > > > Add `Vec::dec_len` that reduces the length of the receiver. This =
method
> > > > > is intended to be used from methods that remove elements from `Ve=
c` such
> > > > > as `truncate`, `pop`, `remove`, and others. This method is intent=
ionally
> > > > > not `pub`.
> > > >
> > > > I think it should be `pub`. Otherwise we're loosing functionality
> > > > compared to now. If one decides to give the raw pointer to some C A=
PI
> > > > that takes ownership of the pointer, then I want them to be able to=
 call
> > > > `dec_len` manually.
> > >
> > > This is premature. It is trivial to make this function pub when the n=
eed arises.
> >
> > Normally I'd agree with Benno, but in this case I think having it
> > private is preferable. The function is safe, so it's too easy for
> > end-users to confuse it with truncate.
>
> Thinking more about this ... I think we should have `set_len` and
> `inc_len` instead. That way, both methods are unsafe so people will not
> accidentally use `set_len` when they meant to use `truncate`.
>
> Alice

Isn't it fine to keep this function unsafe given that it can break
invariants in its current form? As expressed earlier, I would prefer
not to make it safe by using saturating_sub.

