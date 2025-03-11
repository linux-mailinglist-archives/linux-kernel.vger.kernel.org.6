Return-Path: <linux-kernel+bounces-557057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15829A5D314
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A8D17B5DC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A7B22DFB0;
	Tue, 11 Mar 2025 23:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQsAXcDw"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3E0233120;
	Tue, 11 Mar 2025 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741735204; cv=none; b=GHK8M9hX2xOtRfIy0ZbJ/J0UAMsyfjFD0BvammU5UZLAVBWEHCAh3UYocn6BFEGR3nyKDM7aqQrZBb38bj5gu2fOKCmo/CHM12BjJxkH0X0EoDgRCd5bNSRqPEDBe7VUtSyDFBN9l+i3VtcL4/8ijANSW3rYGf7vJQY1bPrKxWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741735204; c=relaxed/simple;
	bh=RWNybGVzz/LGb1S8gWHQfkrw4kktSlEUJF8LNV+qzeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KK/f10jDG6olnZb+jEcTnE6qZgk+RlT2HLQIYWPzWu/kO1lgGAhyW0AY9SfKvHOIa2OliZXP2oQaVmH+MqvNSnWCRvqPuDdq0fx1FcHyOVkwe802oHteqkBayDgs19LkFpcJgPBwO73bbAbz1BiqXSIgw7ySuxlZXgSZNQj69lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQsAXcDw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2217875d103so13296055ad.3;
        Tue, 11 Mar 2025 16:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741735202; x=1742340002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAUgXMKaBCt8jE7rE61tKNziPcEFBt3jzJkm5qy/uqg=;
        b=gQsAXcDwu/EBNQk4ELbrI+EBgUyKYjxJsR84RT8APCzyTlhru6+e0BQvBBm1UrROaZ
         yCjctj04IF2xBe0TQvlJKnQqRWHamx9egzlCY93HM+sepQcpt20pH4u43wIYMctE6eUM
         1Y8rlJiduiX+3Lwg9VawH0RXLQh1UEDak0OlTuU0/iZOWSWEpOuVoXcM6luxamUUH3dL
         0deTHmr5/KZ6rIIBGb0Ro+7QNnvwuc2aZedK+1Rko+P3/pX46mpcCPvvAhlfSxslhMT0
         dFsMyLtiRBh5CiCVmEQKVkklTjPnGcUHmUwjoWKCpDx6pSNVhvg8ob7HEVM09m69FNuY
         WASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741735202; x=1742340002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAUgXMKaBCt8jE7rE61tKNziPcEFBt3jzJkm5qy/uqg=;
        b=Zvt2eUmd6kOTrSb3Kd/vAYjggN2uCELpbbXvprGT2Goiqr1GBnQB8fuisw6iBsSX0k
         bbZVfrZ4I8tCUuPtA0eKDfYTfWfZYU8DEJtNEWOThOpm3eP6Av0s1oLqsNhc0sfADdd/
         nMj/drvn5yS2P1iQ5vG7AqNmLYiAMR6ZEh1TAuCpO+KbU4L6jT/Z2X79X/VI30nsSure
         Ka54stOaov368cpMn9lal6bbOdsICvXWm1P26iDOg2znIHlytyCWOSNzMNG2FAxm1RVH
         6o6v0Qadsjpab7am9gw6TZq1fam5BRv6kSpcKottSdpBoTkca6BLyGRrKhCfzzss13mn
         A4iA==
X-Forwarded-Encrypted: i=1; AJvYcCUGFJPjULx1e3/X1a07uhW6R0gzAAi4oN7LQamNJLpWHzkxo862RDqb/NzgBFp590DQqdLdgL4sgWseDouUb04=@vger.kernel.org, AJvYcCXqMC30fBXn+XcXLtQQ4ymuoeiTGSdGx+vw1rzPf3H/cJ2dPAkZY0KQpWsjNeeIJeNZ84cHVZDJqoK52rE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhcYgFK7JcwusTHvJDy81UxrcvRpwWdEhCehyMq8AOKnEh5r1
	xEW2lk0A8Z+/oWEFJFHOaTbbD6WPLk4ui4uS25bO7GYRXkpNZcHPv7FspnCJV834r5rUneewbY8
	WQP3ZmhXbPKbNF2r6oHsCv2Q5oRg=
X-Gm-Gg: ASbGncswda7VbXqtrciCPEH9FmMjajDL0QguaAFwk0ywiXktMlnKJWn4GxS2h3OHfCI
	f6u85gh/sOjOOon3oh6g+AdC5ROJ0qp49O+0AAu5nvbbCT6ClPb8AwlDnhdzRTqJTEYJfvidV7w
	eDu1+lVjbpAhwy/4h2r6GPYld5TuXgkC48L7Cl
X-Google-Smtp-Source: AGHT+IE/KHuRNLhh1ySUuLCaJj3/AGeIE3rdkArsyCxx5i6QVa1Yy1UbuDoLIkjRAYC33kLdHpH7yxo1M0P2bxA9/SI=
X-Received: by 2002:a17:902:e841:b0:224:252c:eae1 with SMTP id
 d9443c01a7336-2259326ec92mr27457635ad.6.1741735201955; Tue, 11 Mar 2025
 16:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-rust-analyzer-bindings-include-v1-0-6cbf420e95b6@gmail.com>
In-Reply-To: <20250210-rust-analyzer-bindings-include-v1-0-6cbf420e95b6@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Mar 2025 00:19:49 +0100
X-Gm-Features: AQ5f1JrYA7EY46JGpv_p16l0CwWMnsXV2E8BWnBytRcltWC1CFpxQ_OkC1HGz4A
Message-ID: <CANiq72mWZ6YDECjvnhGdWOGmVY0PQJaJdwY0sHJLc1h4p9B6ww@mail.gmail.com>
Subject: Re: [PATCH 0/2] rust: fix rust-analyzer configuration for generated files
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>, 
	Fiona Behrens <me@kloenk.dev>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>, 
	Boris-Chengbiao Zhou <bobo1239@web.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 6:56=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> The individual patches should be descriptive on their own. They are
> included in a single series because the second patch uses a function
> introduced in the first.
>
> I've confirmed this allows me to navigate to symbols defined in
> generated files as well as to the generated files themselves. I am using
> an out-of-source build.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Applied to `rust-fixes` -- thanks everyone!

      [ Originally we were not using `OBJTREE` in the `kernel` crate, but
        we did pass the variable anyway, so conceptually it could have been
        there since then.

        Regarding `include_dirs`, it started in `kernel` before being in
        mainline because we included the bindings directly there (i.e.
        there was no `bindings` crate). However, when that crate got
        created, we moved the `OBJTREE` there but not the `include_dirs`.
        Nowadays, though, we happen to need the `include_dirs` also in
        the `kernel` crate for `generated_arch_static_branch_asm.rs` which
        was not there back then -- Tamir confirms it is indeed required
        for that reason. - Miguel ]

    [ Slightly reworded title. - Miguel ]

    [ Slightly reworded title. - Miguel ]

Cheers,
Miguel

