Return-Path: <linux-kernel+bounces-566736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCC1A67BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B63165C99
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39404213227;
	Tue, 18 Mar 2025 18:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMNo3oak"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0441C21019E;
	Tue, 18 Mar 2025 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322522; cv=none; b=mfx5RdcST63dbT7nJRwaGOigMD9uQGUhLxXR6e/T4c53GG9FqqVuQTMKlZb0hHC25cD8UcrNotWwGC/IPifDBxmEl0dyuElJn4THPXktSM4dSIk1BHUFvgLiRvNyaeF04KGvrCihPpFSpCYtcutQ0yDhk3PdNJZuVKfSUGsFsyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322522; c=relaxed/simple;
	bh=BHtDkUF4GEXQWE5bB/wtsqUmcgm6GjPx9hsFXZLh7Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqbYke4tXe42Lm06pAiA4jTg1hHjge+HjvZbtc8yO158zXiysQBSrMJIbkMl2Z/W3sx89QMSNRUVW9iGdbAvPoZeUMttwDy9waseJ3NINxvWGB4sdFCxqpL9m2fA40Me7cs/skh1g94ZpFHDsB2kdtSNl1pKV/sDvLeIYJ3CfrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMNo3oak; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30613802a04so67770931fa.2;
        Tue, 18 Mar 2025 11:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742322519; x=1742927319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHtDkUF4GEXQWE5bB/wtsqUmcgm6GjPx9hsFXZLh7Eo=;
        b=PMNo3oakD6MA+kk2vd/rX+nJqku7FB6hlwYveHMLCayQV0d5ZooEM46EYW1dk06asu
         17PkqY1BGKPohshrdOOvZgk4FkBHMpgiMIvNotbnS/btXVieIwGRBmzEdGEQzWN+EUb7
         gsukZB1BkqRBxn8iQhI/C8Mi4DO4+Q1NSkeozIhKizD8lx24Sh/YuRpbU9noEAtJr9xQ
         bgIOicxqg4dxmf7uYCC0e9eSzzX7w1si7TG+jYEdB+xTxOznJngEw6LKQAdsMlldzAz8
         lC4x1hikriKhchxflwIAQUCgpb8VhCibz73M/qJ1H+ITFILGJoOl7GoVyTMOk9p87+++
         NR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742322519; x=1742927319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHtDkUF4GEXQWE5bB/wtsqUmcgm6GjPx9hsFXZLh7Eo=;
        b=XQpW4K7GY8hPXOoi2ImC84b7/5i95UGMwaEvVyPaBxt2XnsRDE8bnXF4BB90G8oxPy
         IbGUalEIE6MSws+dGl6Benkqq75iAvRHN2PztX0KGWr98yLwoSWUNcwbPrPIHBN/L00T
         DdAFG55EVhYC1C1r06/bDPugxfdsdAUrRIeataX8PWBxbP1APMLD9VzZAFdBsICUV5FB
         edeKHqU8+P4BZ1u0IsoYnppxQRl8GGAWjykWCakz6lh3PTni25Xo+W9DZndyXLFOSldn
         CgOrs5ik/lwMxv+/sbPFSjdANtzT/002qSWJrgti4kH8ncA3b2vNp5aKUhuMq/IfXZv2
         XaRw==
X-Forwarded-Encrypted: i=1; AJvYcCVEiXtWdT6ShFrcIn7/1GbhM+QyqUkzR26DI7n5YAvUTfqekrAEEfIsUk27vC1BQfhCTLSA/9TuGfUJDlY=@vger.kernel.org, AJvYcCVk2L820ZUIEKlaoKAVJw6YOr9B/924I/mgnBTHztGgSLnQ4xsghjqlASKXh+EZ7vRk6hMA3f5jJ/Qb8ER7Aac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5lNoMHK65kBZWNCbL5YJxg9ttI3nKlrHoWWw4swS7E+bh9aO7
	QBTjl/a1pyDsB44UP/kBd52SPbj6Lqu2EgucGjfRGDpApP2+7ayUdRTMFdZWTpUM/WXCPIQcydi
	xnxs6HiUbkij6/PJ6L8rnEw1XjetE6JAB8y/cvA==
X-Gm-Gg: ASbGncs0dvEmu9y+b7PJo597bU3UEns1jUb67UVh4rvA2CWSu9zn4yGlK0gk06m9yL5
	KshS39wm+Gj9SvkiR59ki00lYPzoXYNjzriptZqjXLPjtPS/6rLBXa8HcG+GA1tZZDGja8Z+urn
	cGp+Q0OtFOokKKh3VejNNXixpwVjkBVUvKoCPR0shKDOr8/1f/WUZH
X-Google-Smtp-Source: AGHT+IG2h+piPhsMLzie+Qb4k6gsEXqMWr1CS64uv2t5OYlxPm4TG/FZ5e0Ly0kXQFS0Kd6ZCj6OBcJ1VVMTyXYwTDU=
X-Received: by 2002:a2e:be8e:0:b0:30b:c6fe:4500 with SMTP id
 38308e7fff4ca-30c97549310mr39187821fa.10.1742322518767; Tue, 18 Mar 2025
 11:28:38 -0700 (PDT)
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
 <CAJ-ks9n=7fqtNr88co-EU7d9Wo1Dz1Wmp0p3K0b8RQE9mjrbHQ@mail.gmail.com>
 <Z9k9I6mp11Z358vz@google.com> <CAJ-ks9kcNvGqGrU1nKjYs_4XPbdxo2cW8Tj9JOGJesGO4StdAw@mail.gmail.com>
 <Z9mGv6ir4c96Of0Q@google.com>
In-Reply-To: <Z9mGv6ir4c96Of0Q@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 18 Mar 2025 14:28:02 -0400
X-Gm-Features: AQ5f1JrTgymBH_chfQDlNcA_P-PjOrmRzEaI0LnLwR8qZNsy7RFvjRZT6JoB6is
Message-ID: <CAJ-ks9mHvjPn98mcXh3q18nB5pPH6YBj3jf1YH6510bP-mtFtQ@mail.gmail.com>
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

On Tue, Mar 18, 2025 at 10:44=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> On Tue, Mar 18, 2025 at 10:12:28AM -0400, Tamir Duberstein wrote:\
> >
> > The methods you're describing are all on Vec, right? In other words,
> > their usage calls for a private `dec_len` or `set_len`. As I've said
> > repeatedly in the course of this discussion: I would prefer not to
> > introduce `dec_len` at all here. It (or `set_len`) can be introduced
> > in the series that adds truncate or your patch that adds clear, where
> > its signature can be properly scrutinized in the context of an actual
> > caller.
>
> Oh I did not see that you said that. Dropping patch 2 is fine with me.
>
> Alice

Benno, Danilo: are you both OK with this? I'll discard this patch on
the respin and prepend the patch adding the len <=3D cap invariant.

