Return-Path: <linux-kernel+bounces-569842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BEDA6A868
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EEF41888B35
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA47224248;
	Thu, 20 Mar 2025 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5HAxdiy"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA397FBD6;
	Thu, 20 Mar 2025 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480152; cv=none; b=R9GaASNUAV/JK3Wi+ZQh2mPGKeCTLxD28nDak52PEbbNEI+A7i6dUn4k4rJLNoeVl1RcVLTwqltN5C9nWT9qMd86yFD64gEOUqbowqOnkTlFgSP+YNsO2N2qdlpAzB6NUVioPkS4XJYy4GgsiEVfCcSJtJ4BY+EyN8U00X/qPJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480152; c=relaxed/simple;
	bh=jdSpzcpFMSxD+yHrtxtYUj7JjrIBKbvo4JpzpwSGQ0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCeBxRobevqkcAz8iVx8AGQBfXm5FqW/8yCYBJtnZJA/BEZkKOyndWCTB6JqfdypkE8jdtw81GC+AhdYivLWd6YyD74irHpYTwnjzCuPwyUqZW9CBfZ5PlG6WbPmt8C5SVE4XdXAJBm6enFQTaHD4deIgs9NBlSI4s7/T8TfSwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5HAxdiy; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30c461a45f8so9176361fa.1;
        Thu, 20 Mar 2025 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742480148; x=1743084948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdSpzcpFMSxD+yHrtxtYUj7JjrIBKbvo4JpzpwSGQ0o=;
        b=X5HAxdiyMyGD5HhpMA0Q4ZzG/ZKbfDnPglF7/lgkf6zGHJOGsoRA1w6nSQG3BaAeWZ
         O/Xik50J4KXMxn+rlzS7/ZmX5Cg30O796pWmAI+F7qZihAR+JcwJX8boisVGdg8+B+Qd
         RuL1F+5yc4z56Qf+XY0aORzaW+kBAglHJ7BEUzWecekJuHtG4uqKGTqQUuE6YKKUmBLW
         XzGEEblmhkE6ltjWsygwN80LOK7c4YL5o/MwEFEXT0diXzcrSnbheVwixFfPiJCFsntx
         ET54D5dKx9Tt4eDLXUC0nGU7Jya2SKqC06whKv5Zz0vcreq+8whjk3DH5sF708vkbIFa
         cUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742480148; x=1743084948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdSpzcpFMSxD+yHrtxtYUj7JjrIBKbvo4JpzpwSGQ0o=;
        b=WgdeYpaoFq5qzAAONH28isy0a6tr4k6omk606Kv55DL82WZWaHDum56wdtPm4HM2Wg
         1dWr0fU5h5dgG5LARyVKjFJI6Uf1Z4aEpDrs0P13uSaX3ZoCWgAn1nYk9fJ6rYZf2ih2
         rdwXuIv1cjsFqm0VMZnu27maiTOwUsPz/q1x4gOQV3V+K+6AGtAtbmzn/prRbq53IKTq
         1Dc6XI59KseUQ5xtFZys2MW55GYqi5yIVRzygqsIqQCXdINAV4xdbqXypdAV51sQDzC6
         ImLKzomVIO/Lovnn24jCILJvR6TEK9XnxEP/7CIJCeHsQCidWJEomIDzsxFlRGXcHr9e
         7r5A==
X-Forwarded-Encrypted: i=1; AJvYcCUCfhmXY8BRT2aQWUZQ5hGb9EZC1KITt3QTqH8HHxE/T9SnUe0o4u6gCTwDAvsdYzpVSrySGCthc/i8wGk70rs=@vger.kernel.org, AJvYcCXyZCk+Xqho4Uw2HbNl/LnS/bd0zmUJKWYuctVD7D2fMJCWMC0eE66CoenijonZujeW7KDbDS9wL8WGJ+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrY/gy9rFyrNdfTUKxTlnWyhYDYCetHFJ52/MR5OrsdDNwdnWJ
	45aWPwcv4WAMrP2FEDcb9uBJFMBFJawzWdn2Qk6F2VdOtQn6mDY8pf0ncJwqAVdGtsQh6GqFcjf
	SMFsVd5Okk2X7xuGngAw4onYCZ68=
X-Gm-Gg: ASbGnctSaDym91m1bkRgeL+8ZMmPhKun4zF4Y2BQneFYbavd8ZRd7oGI/fy5rftEri2
	0ZD2Zc9QzXpj/KthWrr+MU1on1Xx3mi849lxqQ3wfGmhZJGkBQMwVOfvAKndNqJqd8M801lhYl9
	URiFyQRiQSRBw/6sbkNH7Qt+Dv4n6jaNwMssuh7+zEzw==
X-Google-Smtp-Source: AGHT+IEFnvDpyUhpQ0aq5SjcgsYomornya+aah0zvslRXJWqXW8zpVnOjTwNC1PWjWbtDIKQA9FXGFP+BM6hudsprBc=
X-Received: by 2002:a2e:b88b:0:b0:30d:7c13:8a88 with SMTP id
 38308e7fff4ca-30d7c138ae1mr1309301fa.7.1742480148246; Thu, 20 Mar 2025
 07:15:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319-pin-init-internal-quote-v1-1-19de6a33a257@gmail.com>
 <D8L34IUZGXWX.D2LSS2S2NAN7@proton.me> <CAJ-ks9nTmno12ZC4DnLxV_b0NLUK5Kn5K+cRi4BEvKtveQzJjg@mail.gmail.com>
 <D8L5JXRXHX0N.UIFZ5M15FB3S@proton.me>
In-Reply-To: <D8L5JXRXHX0N.UIFZ5M15FB3S@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 20 Mar 2025 10:15:12 -0400
X-Gm-Features: AQ5f1JqlJFQi6BV6NIpZvwrqkCi2Dgkd4NnCLQajuoYyZ5aMPFD7lL3SZi06-xY
Message-ID: <CAJ-ks9mwNiJbr4MN5jfr7KCJc8j=B5=MUfX9XfhPg6yeRiFK=g@mail.gmail.com>
Subject: Re: [PATCH] rust: pin_init_internal: fix rust-analyzer `mod quote`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 10:10=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On Thu Mar 20, 2025 at 2:31 PM CET, Tamir Duberstein wrote:
> > On Thu, Mar 20, 2025 at 8:16=E2=80=AFAM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >> I'd rather not have this change, since this will introduce a dangling
> >> symlink upstream [1].
> >>
> >> [1]: https://github.com/rust-for-Linux/pin-init
> >
> > I agree it's aesthetically displeasing. I'm not aware of any
> > alternative that fixes the development workflow of this crate in the
> > kernel.
>
> I don't think it's too bad, and this code is going away soon-ish
> anyways.

What would Andreas say? :)

I don't think the going away soon argument is relevant in this case -
the same applies to the dangling symlink.

