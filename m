Return-Path: <linux-kernel+bounces-568373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F0A69476
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D134254B1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C991DE4FB;
	Wed, 19 Mar 2025 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATfAvBY8"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C4319B3CB;
	Wed, 19 Mar 2025 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400836; cv=none; b=jQ1cjoDWKwTYSsnzPSyeO8NXKjY97e4L987mwHpmhzG4R+BmN+SkoZHt+/9ZdKaaXW28jQ2ZzVGQAoDJtt4QLcQXutr+2VN8FzTxLulRPwJbczlCJOETSDKQDsXzOkbHhj2MAfzwsw7pTjc6+02pgQiQNtGcU9CD/+MaA1xR0F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400836; c=relaxed/simple;
	bh=XDbOPF/IzoK1I8Rnzb26Qf0qARjrPhkUyNrbgVryhgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/fPxGymQvxzYV4unESjDcHeoM6LJfCWnNrOSuw9ixYi4fSWlZ0g21VGjlGrUUhBfeNZaLbxsmoz6vbDzvLhxhC9rEKhSYYFgXqig10x3aIwFk8H3Lm463gfvhhybvDIrjHa2V1xLrwtLMbAQ6URDfGRPZu6lHe8/IsD/dxF3dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATfAvBY8; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30c05fd126cso65461771fa.3;
        Wed, 19 Mar 2025 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742400831; x=1743005631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDbOPF/IzoK1I8Rnzb26Qf0qARjrPhkUyNrbgVryhgg=;
        b=ATfAvBY8JbmIzGfn0beuVdRiLSGDYCu0lDQIybmWJkQgrON0CM/EfDeLqPNAYCPans
         dRZ62OKm7mm6EoATbheIAPetJ1BMuas5RPiVdpqytSzHiAJEsr9Tx00YkXff7itAyj36
         EbehZlsDCEpeVAoSapyYe9T4QZEAeQKv6GR0E73cKrZ2zBuQc5fCCelc7h601D6GSXYK
         nyXbUdUmLMU7pqf2/ErZw6ZDO0cROjlZGi7sPMDbA1jNCJ7jyhPFT0o6UHu7VwhDbfgk
         8B80gFL+/Ydt1mXHl/TM1LZ2mCQuJHKEVHrzVPjuB24bxYHfEgTWhc3zmRoOrDPkhxdB
         DKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742400831; x=1743005631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDbOPF/IzoK1I8Rnzb26Qf0qARjrPhkUyNrbgVryhgg=;
        b=d+9zAZfN/xYpRE14rxmQ7yn387KzCg6zR2KrafgY8f4S9DK0FNXxwbaWAk6BIKgypv
         qHbp3eOdjAvh894jrVOfGjNJAZ41apdKGmOjXJ8U9JBBM6rC7wcvKu/21/ANqVDzk1Fh
         ON1ABn8xx5QQU6L/ghO9RXzCq/fsGofvQFqWEda9xcakplIUNG08qRCaiCyZ0WowZtYY
         Pt/WvyXdRDZ4RukAekB/nQHDg/+VCju5jFaodxI0hmQOg5AxcqhTqe3wjpRLGzCKmrTY
         uP0i5MI4nBVc72wJG0AYGMRXTWoaQyaVTAbE5ffQKaqWPuUUgw/qFW7P43UGWnU3b1y8
         KNBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmyorb+4L/DW7KvcwML6JDarN6NtO3/0D/kt5apBrSmCsamQaw8yp7RYc9Kvh19Dv8bh4xGJMtRl8=@vger.kernel.org, AJvYcCUul2zjmGH3waUe78q9kSa+xzeIvP+BpSuipWwZ0lo7HXV2HSTzBxG7AgjDMDoAI45uyo6ZOPuhILJqtfVRm8U=@vger.kernel.org, AJvYcCVAq6YsjZfjuR9wPtgpoRAV3NSk0xkMGE7dWGqY2tKG//yuCq1RPxLaQ1/DH6fGGj+pQnOxRwNbO2NYs10Z@vger.kernel.org
X-Gm-Message-State: AOJu0YzG/kChWBY8O7CENdEXe093QDMk8m0fBzhaDTKzSR12/bt2MbCY
	TBu1cUGPA/nmAY/sy00DwyHJiGdQ6GsY7Ho2ZI7AaIJXE7peBexZdI29W7c+/i16JcbDY/Zqx2u
	ILwHc5GOn8aNG0azkgELuMFZovw4=
X-Gm-Gg: ASbGncsnNSiBbvAMqhThi/JrQK7lS73EDaYGT6MX1LRKgcsKgl1Ur6mOyS26BeFJVA0
	CV4xFlBiSuAm5rVwn2fTJJNu0efSnbtnAjU8Eumrks3M3z8BMYFndJW720Zf1nKISQdCe01ZOSe
	QhPaFfIDlQcQwp8eAfcySA4zVwLBz/X0ekl1bbNTSWnjGpEYdLcboi
X-Google-Smtp-Source: AGHT+IEJ3So2YBqMFG1H7zUP3nZCz8Ilj316FGI0GTnGNuZimGSXr6pVQD8hc47p7L1xCLjbHX9v5p4tc9HL1dohNVE=
X-Received: by 2002:a05:651c:b12:b0:30b:9813:b004 with SMTP id
 38308e7fff4ca-30d6a452d54mr17601071fa.34.1742400831169; Wed, 19 Mar 2025
 09:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316111644.154602-1-andrewjballance@gmail.com>
 <20250316111644.154602-3-andrewjballance@gmail.com> <CAJ-ks9kAROOfyPtxMe6LE4-UPsvXca2sQ2VDjhRchZp3HLddGg@mail.gmail.com>
 <D8JTWL8JY7DM.3IVH6FZ4M49CB@proton.me> <CAJ-ks9k+A1+0CWXZmD2m0+jRqTRTNFn-=d9VXqytiOqvn4BR0w@mail.gmail.com>
 <D8KBFC9M74H5.4ZJ2SJK06SGR@proton.me> <CAJ-ks9=NQrz3ySacKt+XXm2vS+Fn9gjmtqAaaoz1k=iTG_1HXw@mail.gmail.com>
 <CANiq72mnT73Mb7RJhZjf4de=_Orv4pipunMhOersOj_aqrFA-g@mail.gmail.com>
In-Reply-To: <CANiq72mnT73Mb7RJhZjf4de=_Orv4pipunMhOersOj_aqrFA-g@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Mar 2025 12:13:14 -0400
X-Gm-Features: AQ5f1Jqd_NgzJUOjvgmIsFxkHSPFGuA73TqCCOq_M4gNiWmI9ySs8ijiU2gDWQ4
Message-ID: <CAJ-ks9=23qEqxT5rivsbfNYC6iUP4RXsKbcDU9XDx32ERnKbYg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rust: alloc: add Vec::resize method
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Andrew Ballance <andrewjballance@gmail.com>, dakr@kernel.org, 
	airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, acourbot@nvidia.com, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 12:06=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Mar 19, 2025 at 4:59=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > If we're talking about the same thing then I think we're both wrong
> > and the correct phrasing would have been: "you can avoid underflow
> > checking when CONFIG_RUST_OVERFLOW_CHECKS=3Dy by using `checked_sub`". =
I
> > was referring to the underflow check implicit in `new_len -
> > self.len()`.
>
> `checked_sub` always checks (if not optimized away). The config option
> is about the implicit one.
>
> Do you mean avoiding panics?

No, I meant avoiding the check. The existing code already explicitly
checks `new_len > self.len()` before evaluating `new_len -
self.len()`. This means the check occurs twice. `checked_sub` reduces
the number of checks by 1. Perhaps my wording could have been clearer
("avoid *an* underflow check").

Tamir

