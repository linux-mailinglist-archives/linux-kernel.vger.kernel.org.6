Return-Path: <linux-kernel+bounces-398729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 679C19BF53E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFA31F23C01
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A93C208217;
	Wed,  6 Nov 2024 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cik0xK+A"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C5136D;
	Wed,  6 Nov 2024 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730917824; cv=none; b=M8wfkFOwH9Bvbakzzk6t/8wYd1sstFBXkh8Y4/d41VTD5AL4vGa7/n+uBDePRFZ0HMEVZ6xMjAlpNl2IVRQEEm8FhLqeJO4PScqTqOvowPOsdrz0eXcB0UCYYt9Dn/p1aH1srkAdeUc0vDN6b4hdxsXpn3lHFzUGA4UpJNJ7F0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730917824; c=relaxed/simple;
	bh=gF5yzVYH46mvGRFeqrnnwmfx2DTqUT/8f1nV3OgxZoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTGKGNLeDwT02dat/gToUF/7sVb+uL9JEyu/4yZn14yOOG+EmyU2lzM5Yc5KhcUt/pH/YegmNcMRoHTkCrX3DID1GJ3xcB7nxmovn5RF20tyHCsDKDuwHrBxoxsI4BIy+EvVXLUYqEx9KKnbBOXY3db18+3Z2iToGluqm0C+lDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cik0xK+A; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e31977c653so12974a91.0;
        Wed, 06 Nov 2024 10:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730917822; x=1731522622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gF5yzVYH46mvGRFeqrnnwmfx2DTqUT/8f1nV3OgxZoI=;
        b=Cik0xK+AA9hQuH9OMezILM0sNxwAHeFesL5aYOSrhsRXZCuHK3KnIwGv/81tF03VFu
         GJBW4ZGtyXkNrZaMl57NBwfKjWj2pvqFKGjSTb1jEs5hmnvSAfK1yE7JGhpkbNJkrrOf
         6stgVu4xrWl4ehEMLx5eDKKdAymdlsXXzcNx/+kHXxbHdWckLx9aqljmuA1/zEQPvqYw
         CBSTOUwJa1BGz/9ee5IcQCWeUVXHw5Jcdk3FIiwYTp7Ktd6Y44JU+fqgQkEnEwnsWeGR
         kq6MQOVhX2HoQVR4lkq2l31jAEuihsMsVDz1R6nieZVFB6chfq0I8S/WMN1riMr6kxH9
         OTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730917822; x=1731522622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gF5yzVYH46mvGRFeqrnnwmfx2DTqUT/8f1nV3OgxZoI=;
        b=N7eFdQrqa+uHW1nFTUuLzPWhwtBgO6nRDqpvitaYFH+5GK8w3D/xZwV7uT+Gc0bDU0
         QOcLB+UYIm6G4O5fhLk3FupoZ/degie+SQd7AOlrLNR8ZCfM8jTaWe7MekK/PpfyhyOh
         9ZAccEsA49M6Pk/ya5kKufe26COdEBUSrKxQ0lsVVecSyo5oHvw6ZHte687D6Mpn1EsG
         BKrXYUJokX0VvOaqF8CqiTvXR5nDArqMDGWrwr3SxGCr7qY7JPcrnExXWz3UDoKR+i3F
         GlasNTkHBYcxxh1T55hYUTrs8emwP7GzqC0Kp6XlbsnjEWc4smFwGkf4Vu0ERZQLlMu/
         pB1A==
X-Forwarded-Encrypted: i=1; AJvYcCU9t7D+wMg+Ky+EMYwCYiqEeMPt7iKKj6CJVb5nov3KGTK0ckFteQzb+YchUsj7BiWvamuh7YN/7RPrL2IBLLQ=@vger.kernel.org, AJvYcCXhFvCz1DkeJ0MMnGyJ5cqkz4CUei9MshceT68nnq2pSfwRjxGzut6lsrCGsImz3CE51xdIXWbTWa08kJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmM17AFFiaN9HTNQolMoJBPMaETwlXr/Hg8wDb49nxjnqp39tA
	c0JtMBTX77x0VtWXnoQgoprFvf7AY4nW/erHnnbO4vDbx5/EwNPQo7BHZiSO+SCWUgGrSPOXZxV
	ev+J/SU3ibOjjpxhq2oLsaV5oFio=
X-Google-Smtp-Source: AGHT+IGugjNzUPl9S05Fiqq/N1TaSPnc6TQF3WdZmgyKufOmNd1/JHc9uWZB9T7rqhi8og8VXuAxKNd762hhNfoQcn4=
X-Received: by 2002:a17:90b:164e:b0:2e2:abab:c456 with SMTP id
 98e67ed59e1d1-2e9a4a8c9edmr137897a91.1.1730917822407; Wed, 06 Nov 2024
 10:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104-simplify-arc-v1-1-a4ffc290f905@gmail.com>
 <ZylNvC8enwPG4IQ4@Boquns-Mac-mini.local> <CANiq72nQ6b1wO6i6zWW6ZWeQFN4SJVB28b216FDU70KmtCbaxA@mail.gmail.com>
 <CAJ-ks9=xW_WWZXB0CbDvU-3otkYs-TY+PSYeiPyidM58QujC3g@mail.gmail.com>
 <CAH5fLgjXXE32k2VuC9yGrNG7ib5vo7V+fsvRxWG0ijopK7MDCQ@mail.gmail.com>
 <CAJ-ks9=b=UEp9KCZ5_dE5yDKWZ1BEfnTkAtS4LiNQ4wzMgdT4A@mail.gmail.com>
 <CANiq72=MmpyquVfi=796v0BAmx6=yuy_gvzeRgUVPhpq8E4rrw@mail.gmail.com> <CAJ-ks9muM0RRtawt-C=vwT7b29rhsHbh1FjpX7LbJ=a05tLuPQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9muM0RRtawt-C=vwT7b29rhsHbh1FjpX7LbJ=a05tLuPQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 6 Nov 2024 19:30:10 +0100
Message-ID: <CANiq72kBo4x7D92Xe7Wkvu=Jj+YmMH+-ARiovG+SHt9BYECbvg@mail.gmail.com>
Subject: Re: [PATCH] rust: arc: remove unused PhantomData
To: Tamir Duberstein <tamird@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 5:41=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> The upstream changes to dropck predate the PR I linked up-thread which
> landed in 2017. Since this Arc code was written in 2022, it never had
> any effect. Isn't it proper to keep the "Fixes" tag?

If there is a bug, definitely yes, but I don't think that applies is
-- this is more of a cleanup, no?

Sometimes things are marked as "fixes" that are perhaps a stretch
(e.g. a typo in a comment). It depends a bit on the maintainer and how
we define "bug" (e.g. does it count in docs, or just actual end
users). But here it just seems something is superfluous, at worst, and
it does not need to be backported either. Even if we kept the tag for
some reason, I think this belongs in `rust-next`.

But if I am missing something, and this does indeed fix something that
we should prioritize, please let me know!

What looks more important, to me, is to clarify/document why (or why
not) we have it, regardless of whether we keep it or not, i.e. having
thought about it, I think it wouldn't hurt having a line/comment even
if we remove it.

Thanks!

Cheers,
Miguel

