Return-Path: <linux-kernel+bounces-566774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ABCA67C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C206719C371A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CF1212D69;
	Tue, 18 Mar 2025 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fa1IC5Rz"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D286B1CF5E2;
	Tue, 18 Mar 2025 18:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324068; cv=none; b=NebqGrw2+03HfCKOtZll+vHpzUNwB87SpBrbYuDoSNNSh7WiqfM5nruyoovld8VoxCEjDCWTBqW8A/yHbMGXytMLEWxCxMr1nJVL4ecsL9CkCme0zKpZkhEoVOwkHvc6f+JPcsiJvtVuk/pc8vTfmeCAou/LKqhhO8kxB5dL+yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324068; c=relaxed/simple;
	bh=swmuFDNWiyV2zihanJVcntmIOpWZVTEKBlp6su4cVwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHFXg017QQaMyJ7oui6poOz4xH8fGE4nkQ+9akQ1tKqY+kv+O/RHztKbtwWJJg+2YfNAmO2Sd4Bzd4GfSAgGtXSIV0zwV/aLgLvlJx0kWxNTYWDvPETz2qK3Tlj2qt/Lc5cWLnzHOvKVjrIrVf026mqiLHpg0ptc5vDzwQNJcMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fa1IC5Rz; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bf1d48843so57094641fa.2;
        Tue, 18 Mar 2025 11:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742324065; x=1742928865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swmuFDNWiyV2zihanJVcntmIOpWZVTEKBlp6su4cVwY=;
        b=fa1IC5Rz/v8529qwVHqTYzvAC3CchZqcDoj+SYoLTH7KUgatSvulQo6d6dNRr3K8Ah
         oAWkGgCPnq3laUnhH1YFPnbQw7xsF3/lrwgJLLrlPG6gWppfbaYjMOzqFhr6uQpYDj/a
         GsQGEX28vPBIV4aPWbBODZzJN9/1gr/MOlIqS+Y8Ir4tU+A6F8uk1bxibSmcefWK+WPg
         mseBFWBUUDdVaG4kUnxZFxkhUIE1bZ/r++s8ChvSqAsUBAQLWDR7bthGVsHzR7MZJdrJ
         oGJoTQqJ/qg6bz8sVhsIy1SoOUmwFeIifCBbMQl9RnyraemUgVJ6r09zdeMEWTf+GsQg
         Kz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742324065; x=1742928865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swmuFDNWiyV2zihanJVcntmIOpWZVTEKBlp6su4cVwY=;
        b=TBmlDKnBS6IKgsUA9j+oXpuHfj8K0uO00TqGLhEk8XgMIiHOpRBcP+9o4P9UGffOBW
         Yr+5cRPxeECyucieQEhEwKX/y88q9ukBftNdFjmzIJs3j0dkY7wBYnOThTV3WbeeDYI4
         8URVce8TjMQH9UZu6hlO5NBoRhfQ9yhlW5ymkaWOv2zKQQuhoUvGCkAXiB0XwUBrxQjw
         9ubnuCoFmodmTYQmzYAM12Size9CNkY3i/VHLHWcmtqW9ruqLIgsw9UqaOlgEtWiKVDD
         yAo89lvPgRHrMFfVM0bQfSpkb6nRp8Hnn6wjm8ZE6xnPMU90G2JWktKOYmdo8to7fxRR
         WLAg==
X-Forwarded-Encrypted: i=1; AJvYcCUNrXw0i3x8aO3ExvS9h0oY3LBCOmeoqgsOZLo2aHJPlgqgO2bvXRYPSach9oGxu3Vo2GevLP/65Aju6jG8GBI=@vger.kernel.org, AJvYcCVDz0RLoqtIgPifRxvvsp2CzP6UqWrbfHGQa99EpglPxVVsnibSqEh11XA4m8v9ii7G/Aj59zzSw9+1WnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsNZTk1/rh0Hxga9OF5Mi/I9yeKfi1qYfhBT8Vwq3FIeBXLdn1
	yOQ8xDhY57+X7ZKbFpsLiQH1i56otn3kSJ5TKjiw61QM2+PLwCFnnKSydRo302UZAYpXUdKjfeX
	+eOxT9nd7kL8/ook30wqc0eU4Kf4=
X-Gm-Gg: ASbGnctPNDZe4uMuT3ybtOzCIEKxh/EmjecbHY8NfoGq3+E80WIg7uSjVRj23wdHeU9
	eToHhNYdD9QMgnzGovPrAHnPlEpPGkxevVu4ZSfdOoXVlPnVuKTVtVrcOvYK01f8mVivDpnHAD8
	B6M+HQEGlni9XE6tx2BFqiorxPIXRjYnO1EVis4aE6eQ==
X-Google-Smtp-Source: AGHT+IH+SqEyGAZZ24eNPcIxtUJyF0bhikDaGiIsUMi1wa3krgxKcnu/4iQO6CPB9gOH+rUwK6RfAXW5sS8bMSpxCNU=
X-Received: by 2002:a2e:97d8:0:b0:30c:460f:f56 with SMTP id
 38308e7fff4ca-30c4a87a9e9mr87857591fa.20.1742324064772; Tue, 18 Mar 2025
 11:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com>
 <D8IGFTJXS2A1.9JBD1UKGN4PX@proton.me> <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com>
 <Z9gL5hQWvCNy5XNH@google.com> <Z9gcqHihXLg6kcZb@google.com>
 <CAJ-ks9n=7fqtNr88co-EU7d9Wo1Dz1Wmp0p3K0b8RQE9mjrbHQ@mail.gmail.com>
 <Z9k9I6mp11Z358vz@google.com> <CAJ-ks9kcNvGqGrU1nKjYs_4XPbdxo2cW8Tj9JOGJesGO4StdAw@mail.gmail.com>
 <Z9mGv6ir4c96Of0Q@google.com> <CAJ-ks9mHvjPn98mcXh3q18nB5pPH6YBj3jf1YH6510bP-mtFtQ@mail.gmail.com>
 <Z9m_mfg5b0XE_HCF@cassiopeiae>
In-Reply-To: <Z9m_mfg5b0XE_HCF@cassiopeiae>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 18 Mar 2025 14:53:48 -0400
X-Gm-Features: AQ5f1JqMAiNzYzecWEi2y4ec92lESip9F7JsAHzZ328Eb5yNjyrtb4pHvIS99hg
Message-ID: <CAJ-ks9=YSN8VRUW6VTfThkN8uh42rbq9pBwvrG=EuW2wpuXx5A@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andrew Ballance <andrewjballance@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 2:46=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Tue, Mar 18, 2025 at 02:28:02PM -0400, Tamir Duberstein wrote:
> > On Tue, Mar 18, 2025 at 10:44=E2=80=AFAM Alice Ryhl <aliceryhl@google.c=
om> wrote:
> > >
> > > On Tue, Mar 18, 2025 at 10:12:28AM -0400, Tamir Duberstein wrote:\
> > > >
> > > > The methods you're describing are all on Vec, right? In other words=
,
> > > > their usage calls for a private `dec_len` or `set_len`. As I've sai=
d
> > > > repeatedly in the course of this discussion: I would prefer not to
> > > > introduce `dec_len` at all here. It (or `set_len`) can be introduce=
d
> > > > in the series that adds truncate or your patch that adds clear, whe=
re
> > > > its signature can be properly scrutinized in the context of an actu=
al
> > > > caller.
> > >
> > > Oh I did not see that you said that. Dropping patch 2 is fine with me=
.
> > >
> > > Alice
> >
> > Benno, Danilo: are you both OK with this? I'll discard this patch on
> > the respin and prepend the patch adding the len <=3D cap invariant.
>
> I mean, the whole reason to switch set_len() to inc_len() and have a sepa=
rate
> dec_len() was to properly cover things like [1] and Alice' patch by havin=
g
> dec_len() return the abandoned entries.
>
> If we now only switch set_len() to inc_len() and drop dec_len() then what=
 should
> Andrew do?

I'd be completely fine with Andrew (or Alice) taking this patch into
the truncate/resize series[1] (or the series that introduces clear
[2]). It can be properly reviewed there in context.

> Maybe we should just revert to Tamir's first proposal, i.e. keep set_len(=
) as it
> is, but make it return the abandoned entries, if any.

This wouldn't be my preference.

> [1] https://lore.kernel.org/rust-for-linux/20250316111644.154602-1-andrew=
jballance@gmail.com/

[2] https://lore.kernel.org/all/20250311-iov-iter-v1-4-f6c9134ea824@google.=
com/

