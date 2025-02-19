Return-Path: <linux-kernel+bounces-521782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C979EA3C234
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 254B47A69DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC371EFFB0;
	Wed, 19 Feb 2025 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhrax0jh"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C84E1EA7C0;
	Wed, 19 Feb 2025 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975596; cv=none; b=ecrINkh3XcrQahm0CH8/7cPWovYFyDjenPrUyB+rZEbuvGL0HqtG1+UqMC0CFFbMKx/ks38SRC+p7/tkf7IbIzYczwxSLNBSSX+fFB7uFLyHtYtK8A/tSqq5/T+aVLh7950VOFLV54npNfUEAueu1ozdzLsNFJJeNSA9xeufUnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975596; c=relaxed/simple;
	bh=EwqKQLBrqZdGo2nOl3OWJ2M3vIrSDqkQtxNLnilyFV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AR9Ow0dfSxHE9uRiSn0AjvWVXCQ3qKPgGPg45c+zOvgZI0S0eIIxQrth3aZxmGHDjdlgUwd4E9oswlFILe4sTrwN92TYM3t4iq/gFlsnXTaXwWaK0HcQLoFQaXessgjh80Zq+uSCgg+vNK+7foF22QHMlsG9+YB3EA1XOx/QKmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhrax0jh; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5462ea9691cso1243182e87.2;
        Wed, 19 Feb 2025 06:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739975592; x=1740580392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwqKQLBrqZdGo2nOl3OWJ2M3vIrSDqkQtxNLnilyFV0=;
        b=nhrax0jhn7NHbb73+s71rZR/PZOHa+pguOxeqe322pHUvebQ6vHWgXQjGX0mBGrFUP
         I73joAaB/sjvoyrhCZe2DFAAr8bm5P9+ikuzlqo6R3+ZMwQZ7q3L2l/eznSrCAW0mnUV
         uysgxNvB6Un0fbGJ9zLUgxfjh8PcwQ77rnaSLRN8r/54Ia2hjm1Vf4PFgqqmSVuILWko
         getq2wPZVG7KWCjIH4aSHMBf0fCX5BClTLWomVV/XdII1Enk0iRfnF1EskX/VIgmEFo9
         QbXlTuocUNgSBlDhoRAv2aBntjs9RBom6gC2fI6zy3a0F2s+KfJmW5A4QUAV9ZkfJ7ag
         l3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739975592; x=1740580392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwqKQLBrqZdGo2nOl3OWJ2M3vIrSDqkQtxNLnilyFV0=;
        b=dXKXatGkQhQawR9fhR6njvrLMqxs/eHmrk89+b3WgV/8KQ3kIPiL89Jvho10xAVDh/
         Wy1VJFwjCKAyyjAaJC3ejyjuQFuCj4aUis+8tr2Uyg0EBKADZynRyBX1tPV/YdQkUQbY
         yUsIG2OOJFbG4IRg0hFPHfTFweGfc0Oa0hlmxQHYXoE7RSh6J6UrF+ymcFYfEffUH45z
         QcQmJCjvRP7ekiqWLzXBR3GA8GkZ9FtxRgvGO/pm4KnQgWaYVyy1rGV37kYDa0cvXrbL
         RFsGOpaRGu7iJYizYODHqOHMsn6AjBBzxx30mh34WiEZ6DrmgbkQ15yg3OZ0E10HnqZX
         fPfw==
X-Forwarded-Encrypted: i=1; AJvYcCVoMxQVahBebDhzAe7+NC/3Dp/1Nkj8skgeywbwkWpZuiR25QVFICVoxSjF199RmdRCu+N70QtjRwKC7V8=@vger.kernel.org, AJvYcCX4cRhPveWG1Y5rC17WwKcyyOy253PibVilO5HOeko/YAYXxgzTkXXCt0tWXLG7DFJMKKDPiwnq44k/tQZaLoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/qISCnL4mPoePrI0OAYdWDKByGGpqKBSztLyUJMgE4CsWfYLv
	6M8A03mI5QETbYY+BjWpB8HoWi3ifFdFSdHwy+keHBDKD+O4cLr4zCNxVPPBEy0ArBeLwjf2J0O
	/Im/gWae1xJOntvzceYqfa3GYQdE=
X-Gm-Gg: ASbGnct12l1vcBaYSq6vX8gcDEIO8kd9gfUglxdJeAF+9G8VmTwkNvMRykL+zuH2BG4
	Sv+cdcXXzlGspGHQUasi7f6lwsLQv6HNE5sEhZa13+aSgGHyLUBEFyHXKmOwkgAo8AeX/M6y41p
	Sebz58AOYB6lPc
X-Google-Smtp-Source: AGHT+IF0trpyo9U23QoXVVbC+J/EGS/xPFcNcqE7i/8gGVx+T8ftlX4poX8leCUCuwOEpI1Xbdak24UljYuRb7k0RBQ=
X-Received: by 2002:a05:6512:ba6:b0:546:2ea9:6666 with SMTP id
 2adb3069b0e04-5462ef17af9mr1858980e87.34.1739975591559; Wed, 19 Feb 2025
 06:33:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-cstr-core-v8-0-cb3f26e78686@gmail.com>
 <CAJ-ks9kyozt45VeXG7GBTN-ejy_HGMOekFYFMmzS8AbEusZMWQ@mail.gmail.com> <CAH5fLgjUuCo5Ayx4WCfnrVAC1prvUbY-pvZdinkAb+KcSOWvpA@mail.gmail.com>
In-Reply-To: <CAH5fLgjUuCo5Ayx4WCfnrVAC1prvUbY-pvZdinkAb+KcSOWvpA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Feb 2025 09:32:35 -0500
X-Gm-Features: AWEUYZkukcYdvGsaT4hNVUarHCSF0QpSSReovbKfJ45ER4Jk9CEfW_I7LMDQNV0
Message-ID: <CAJ-ks9=JMWQMTdJSkdVGJus1mcRQWZ-34B_s4Ti7ab5NAdA6pg@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] rust: replace kernel::str::CStr w/ core::ffi::CStr
To: Alice Ryhl <aliceryhl@google.com>
Cc: Michal Rostecki <vadorovsky@protonmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 9:21=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Tue, Feb 18, 2025 at 5:05=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > Gentle ping. Trevor, Alice, Benno: you all participated in the last
> > round of review - I'd appreciate it if you could take a look at this
> > series.
>
> The primary thing that comes to mind looking at this is that losing
> the Display impl is pretty sad. Having to jump through hoops every
> time you want to print a string isn't great :(

There's the practical answer and the philosophical one. The former is
that core::ffi::CStr doesn't impl Display. The latter is that Display
implementations aren't meant to be lossy, and we shouldn't make it
ergonomic to do things that might surprise the user.

We could add our own UnicodeCStr which could impl Display and be
AsRef<CStr>. Do you think that should gate this work?

