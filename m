Return-Path: <linux-kernel+bounces-355877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ACF995852
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C651F25E4C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A66215016;
	Tue,  8 Oct 2024 20:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RahmmyXT"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72D212D27
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728418991; cv=none; b=iIXtJ3VeCGQzy1LjwQQZqTKRrDOgmRMJNJOtaxVHcBvg4/2aWzIldkB1gGUZ4Et9EjwGXdQMC10osSQK9Dek4SmSNaQPyUUJcGpFKVXX3QaNNVM9sN/2jKClC48qM5F/cx7bVFGd25Ub7pvoULd/8zvMqA/EW1dMOXDsrfOZU4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728418991; c=relaxed/simple;
	bh=aT/4Tv8yTS3tZk2OBCayfPS0Z48rZON+uEu5E5vyko4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aESbQYYtV+o2c0EJDLYjOkFSE82e6XajU+2/LGHgIFv74aO3/emiftkR/02u8lEHWMmMAtluyJUbzCR17ITRx0Z1kA8ijhG2anKRJL0sOGrRa5oYLbm8d0IVRjPNfPUWwzbFO0K93SjnLQ5P8YARdnjSK0ZprTGVsntLFyhMVJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RahmmyXT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cbe8ec7dbso16885e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 13:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728418989; x=1729023789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aT/4Tv8yTS3tZk2OBCayfPS0Z48rZON+uEu5E5vyko4=;
        b=RahmmyXTzY5DB8NueEYj+fQpSk8ckdmdRyaNG5cyCBi21D1VvZzqleUcGStcODlAZW
         ghAXPsb7CBPYgBMCb6IWAoQ+1FADdb47huJoBLHZ/9Bo7QE3dFUB+yIf5HP4ZX+qhnuz
         SPWgPZJA6UwnEus/0SGl1mjny6FeFO7UjfVLQ1etZLpqMqDMbqHohOJ52sTo/gSo8ZQ/
         mkKxnenk4tAvCBznSxTt7dSnf0gyqm6UMckkviu9ivuBoHAHpMHZcMHsZpDwiCSwwNrd
         LAlZZt3OxBWpEFnNLErCC6ZCY6LJbqGd294cD679X/ugeT0Xk7DbbYO1khQKyelHhaCK
         Xd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728418989; x=1729023789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aT/4Tv8yTS3tZk2OBCayfPS0Z48rZON+uEu5E5vyko4=;
        b=I80TBz30Oq9DqAjHmorBq6MACVMDA8e3R43j264vaxcyWbAngE/wbXmAy6A+s1bcjK
         rpNcSLn8yDEm+KHt4llzZkd4T9kEKUiUm0UUlL8oFu+cE0+bbFW6yeoKNh//IWNYQW1M
         xQZpoxLVA6QMolTiSSLIp2gAwZW63P5Mx1/5jJdNapE7xspBtYgLVwzJ5ycH2tpW0a5T
         deGaK9QWqNTwZJXNWtUad8lBcMIbon7N3yWRLbQEJcsmvGC2v5nPJyw1D3GFOf1jqMBj
         qLVy6xAmDYMNUthNE+mjRYgG/XGIMnEh+9BBUnvnbI95McC2pkZ5H56GJJRbKh9kssUK
         f8hA==
X-Forwarded-Encrypted: i=1; AJvYcCWd5xA6SHWClBeKXYXslJ1llfMI85RTwBYWSGPdE3washCvRvJvU1/el7EJGkA01TIrWmudcz14q0Zf5FI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6lSM+Ax5hjZ9k3pbN2kAEwJ7mXl4NOMxeSxOweV1MzypnT1d2
	1GkKNLiseZow6S8NkcPPwcRzhQ9cNfsm67N/SGs7Sa1/JN2kH0VnqYp9lp0Mhfal2FLpfA1Fg2i
	TQjmUN+t42TOfc3KYvl/4k77wuOwkdWtmpl5l
X-Google-Smtp-Source: AGHT+IHXUIQZjrceGy2DNmHGyshwanbOpVyVoM7Mm1vllzb6eznDdYZ2tcjUOfsuDhIr71bTFFfEmbi5dRM+rdEoMs4=
X-Received: by 2002:a05:600c:3d1b:b0:42b:a961:e51 with SMTP id
 5b1f17b1804b1-43058c8bee3mr1131465e9.0.1728418988766; Tue, 08 Oct 2024
 13:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-rustc-option-bootstrap-v2-1-e6e155b8f9f3@google.com>
 <CAGSQo02oVWxazut2nyh-9K9gK+937zKCfYMBkT4EQE2CddvZtg@mail.gmail.com>
 <CAGSQo01FErmGbeu-+_kRfpQrO4xkaGuSo_zAXTmGHZuFVYXpNw@mail.gmail.com> <CANiq72=40bsTubsXMqn_Jjx8TdfuuE9Z+eQNFvYrVXnX9S1-zg@mail.gmail.com>
In-Reply-To: <CANiq72=40bsTubsXMqn_Jjx8TdfuuE9Z+eQNFvYrVXnX9S1-zg@mail.gmail.com>
From: Matthew Maurer <mmaurer@google.com>
Date: Tue, 8 Oct 2024 13:22:56 -0700
Message-ID: <CAGSQo03_GZCJrnp9WPxo2T3GJz8TCtucHNx6_rAr7xfJ6ybukA@mail.gmail.com>
Subject: Re: [PATCH v2] Kbuild: fix issues with rustc-option
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 1:22=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Oct 8, 2024 at 8:25=E2=80=AFPM Matthew Maurer <mmaurer@google.com=
> wrote:
> >
> > Err, slight amendment - I think you want `-o $$TMP`, and not
> > `--out-dir $$TMPOUT`
>
> We need the `--out-dir` to avoid temporary files being created in the
> current working directory.
In that case we should omit `-o $$TMP`, because `rustc` is emitting a
warning that it's ignoring `--out-dir` because `-o` is set.
>
> Cheers,
> Miguel

