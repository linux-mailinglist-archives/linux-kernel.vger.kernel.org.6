Return-Path: <linux-kernel+bounces-525942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F76A3F7A4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A691A177666
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC9D20E038;
	Fri, 21 Feb 2025 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KghgJ7Vy"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D894E1DA53;
	Fri, 21 Feb 2025 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149209; cv=none; b=o4WVHDXguwrXmJe1Jr3n+OXGH4PAN8yKaIPjBcvEyP5K0iiCWOguoA0EOvTz3vMLrvNwtt1Tg5i/kEwvDSB4FW9ZZ6/zYTAqQ+2JaHKW6P2neqFFGeJWCFlDTAPaZ1GKiD1KbSA+W7AoWUoqXhP27+4cpghP15rCKAGnp0qC8g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149209; c=relaxed/simple;
	bh=5GOU+RIMfCC5N0gNEUaBFnynin/UwOsQsntoyaSlWqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzAvU1teZ4fP5J47hD38wacnykhbisrA+LfUoc6pIv6OCopq3OyuUhVfaCAbKKZrkVsK0zcavwAPwrc6t5uFl2pU0dm+Euv8YddQzGIFR+DTalh0AuvPJTO+NvwO27Pbx9TJ9Pu6Pjpwx3aCKuYU09TM9YBPTlVJDkAE0guB7Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KghgJ7Vy; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-307bc125e2eso20791801fa.3;
        Fri, 21 Feb 2025 06:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740149206; x=1740754006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6W8WbGFo8CWgWYywBvp5OKFnvaxV0YCRUMlkTvha3ZE=;
        b=KghgJ7Vy9jtpqHUnxJY2zaCrOWxngN5wRmk8XP7ZHV6QpEuRjo8kXJHt6+JFnBcPso
         jXuVw1U7elw4kQO6b0sZRAnrED69Yd/Meer6reiXCUX2wIZsB30C65x3PzfQuB5Mvnxf
         sPZw6wdUul448uVaTaO1I4AQb+pPc1Cg0Z25HCIv5/hxddFd8dHPLQqqI2k+Mz2wIXC4
         AiJZEgCZ/qMuDs1iWPmujCjgA54tw5bC7FyxJBc+4SGRDBQJI2eG6DbRAtIyQm8w/TNH
         B9v8GPh5m5OxHauD9Sx+18bC/rZRjGFq4u20JCh+QzgwL+l6i7YR7L+Xh1nwvLY1PqdD
         lJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149206; x=1740754006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6W8WbGFo8CWgWYywBvp5OKFnvaxV0YCRUMlkTvha3ZE=;
        b=ixY0UiqHrbpgZH/fWFprL5BQg/9sXVAMIbuRbtSeXq6a0kgGjJhqMRKW6Tr0mkFOh/
         LoSHhJpXy8Umoc3G4UTv4HOHA8r7RA4WYk9hpbbuH0DTtmrmP2LAVCVYG7YHMOUjr3Eo
         PEOf+JK9/uydbdH3Ot6uRe5yuhOxQWt3TjunnD06n5SDmdbYcYpMyCQgw6AgQ5o6zn58
         ZLpd0nirGfijPMw6bloTdUNm9pSz6ritwUoPSVtjAQd8g+SF4HGaiIFUmWzPyl5tVbW9
         6Jjo9cnaAoGMz3UbOxcSmT2q35HInss8mnozQ8obhSm81iOsSk+vhOSLM8NdA8GVGB9L
         lb4g==
X-Forwarded-Encrypted: i=1; AJvYcCVzM4gr3VSZk49LUFR6fUdiDNFOYY9wh8PvK0twEl53MYa+fteQwGDF9trCa4ByHd1wjMxqMvUvPvwMrw8=@vger.kernel.org, AJvYcCW6dFgBbdtGsLm9GAwHgOyYGp03oImo4qk5gj6p1f3mKzAPA2ve+nCMiO0XA4eulDrWHSu2F6JB0tkOBPFEQqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUWFjSSdupdit6OARPj6YooFt416i+ZxiRSt9VmdGtqCwIzuhV
	ak91kpmBSaNNAMRUgp9+LExBaFCWwChOZ1tjYbgRs5ukvNs1YMWv1AcAOuU+5rOz8dMRQpmJ+pW
	esBZxE8xHgdmALjdgYZKsDWywa3Q=
X-Gm-Gg: ASbGncs9v9GpYw1bNP+PjuI/p13fMiDKOKxx+DIgL4k+l5WJobUZkBXkD5TyTc4/Oc9
	nFYjMhwAcSUcZCmHjCVIbsfLv9BJh40OqmKSGhdsAOelV0ZAduAvQtqrVanrVHvcL7mo9A1u2nA
	xdRGPIJPlObd1JI9Lx+cKIZQdbNWWTqoBCXfPAeURs
X-Google-Smtp-Source: AGHT+IElrI9KTo+gODJDgq/zIjPYKjl+Qr5uMMLPLsXW0QDD+KQtvWuMXiFonZl3R8QnrJ/25gE9xkg47ViIKsFgU1w=
X-Received: by 2002:a2e:98cd:0:b0:309:2283:bea8 with SMTP id
 38308e7fff4ca-30a59994e41mr14438821fa.34.1740149205041; Fri, 21 Feb 2025
 06:46:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
 <20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
 <KDmrJnQA2_Ojf67mD8WA_UafgVCACRRleB9t-D_1yl_bua8e1VWdGQAUvmMGHscqRHu1gzPJCKe_BfotutZm5Q==@protonmail.internalid>
 <CAJ-ks9ncOyGyQsDFOBxg-7wmXkrQYiZr6H6eEFWsFstk=p1uAA@mail.gmail.com>
 <87wmdkgvr0.fsf@kernel.org> <djAeSx8DNZwss2-UqXGmhVPqYm2z4LhKWC70jPHPisd1w70qmpmOfVbHfhqJErhoFwVFM8IpbTv4MKkk_BIpQw==@protonmail.internalid>
 <CAJ-ks9mNidHZvWkFJE1jExc2oVk_bbJpiO_DRMrWu5nYhTpKgg@mail.gmail.com>
 <87ldtzhexi.fsf@kernel.org> <87cyfbe89x.fsf@kernel.org> <Z7iQcDa72XnJ5zGC@Mac.home>
In-Reply-To: <Z7iQcDa72XnJ5zGC@Mac.home>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Feb 2025 09:46:08 -0500
X-Gm-Features: AWEUYZk1J2lmqhCaJhG6uOBA7TXJ46zV-bEeC2VNizbAo2dhpik8C1JEQG5L9q0
Message-ID: <CAJ-ks9kQccoa7znFNzWAgi6_G0TKvLUARWPZ_Dbed1C-d4Lr+Q@mail.gmail.com>
Subject: Re: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, 
	Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 9:40=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Hmm... if you mean:
>
> trait HasHrTimer {
>     unsafe fn start(&self, expires: Ktime) {
>         ...
>     }
> }
>
> Then it'll be problematic because the pointer derived from `&self`
> doesn't have write provenance, therefore in a timer callback, the
> pointer cannot be used for write, which means for example you cannot
> convert the pointer back into a `Pin<Box<HasTimer>>`.
>
> To answer Tamir's question, pointers are heavily used here because we
> need to preserve the provenance.

Wouldn't the natural implication be that &mut self is needed? Maybe
you can help me understand why pointers can express a contract that
references can't?

