Return-Path: <linux-kernel+bounces-568427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FC9A6953C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 549A77A8A18
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3A11E130F;
	Wed, 19 Mar 2025 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQTSIL6p"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82151B4138;
	Wed, 19 Mar 2025 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742402636; cv=none; b=ZKT/kTH0UDIrV7cbV3zbCrM32NWN1AVUuciMopqmQX0yIVEQQSEXVZ2u1K7tITzxE/7g1bPtCO73Chn8qogjusIhPoc++rVKkVvtl/tSMjAr6i+B0tG6z4+HTPV5QZ2nKXYSoGm0qzToRjnIR4dfniLPEyYx3oXMCbMAqfxd3M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742402636; c=relaxed/simple;
	bh=G5BNJ4m+r3o40jW+KqQYzYpok7VJ6qTlzwR/jvK1izM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4OG926ZT+T75C+bHKfzzqRcmyjGrKXT59iRx4cIMWUlLQuZt9khQ2kNMiBNGTwywaBFgpHxu/pqqJRh+WeyFmpl1hhY0J9RxvFsEZbEyTFbVLdIT8OO8yIBZ/0rxsvUjiXXo3xDMmYmRmUTn0Y8sVzZfKjDk/PLwx2tUI9OCPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQTSIL6p; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff7255b8c6so893625a91.0;
        Wed, 19 Mar 2025 09:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742402634; x=1743007434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5BNJ4m+r3o40jW+KqQYzYpok7VJ6qTlzwR/jvK1izM=;
        b=lQTSIL6pQqAZRe4xmfN/OVsVrqZSTjhV9DBmiBTVOXPYNmqOIF5xxp7KctZngvH9gL
         J6iQ+let4bV9OYD5HnualOX0+msXhXl1knriit0tdqXz6wYfOlS0UnKp7k4xlOBkE5IM
         thCLw9CTMxepilB2OfRIlCWYBlbslNwLlA9NYD/6HQ12VNcY6jNLfsolCynQQL7TciK8
         ExheSFywIqrrPDXcqWkjCM3m2uT/HYT4Yb0aZpzJiYv3wbxAq4hmiLWT7ZqjvbYEZAdz
         yfxCpXaZhNGzP7K45QG6jbhhGG6Oes/QI0PX6PhH9kNboGSStJV1UBxW8VKGjl/GLOl3
         7i5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742402634; x=1743007434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5BNJ4m+r3o40jW+KqQYzYpok7VJ6qTlzwR/jvK1izM=;
        b=Tc2LDH/vZPQ0u2sOoEp+hCfIhPKxD6YCqBKO1F3p6+Ybw/iVWtL6HOW11qOyenp644
         hcriw3z7fifiR7RekAFtcZbn8rQrqLyxIiykWdE6e6M1SHnFpwGksR2Vj1739tTlSPH8
         9ytZ1fx4dGxj39c2mct7jAj+Kcx/OyGUsJtCX16vSM71FoMQoh2g9I8yvy7IgHCCfspL
         EP25igcPm59Tenfea6k9txnR0OwkOyqsF3ijWd22ooYf7FjJyP4Djt4LF+ydDliaYz9Y
         XYgzz3QbRmi7qH0PDa8kHZCS4MOPYkasqrGZYU0qNM29o/faSY4VFW1chy5dxVPCeZvF
         WUqg==
X-Forwarded-Encrypted: i=1; AJvYcCVcja7gmOuEurZo91edA7tCzOp7LTE+61nY1mPhIq/wyAafqzNo3W52jOArBGEFS75wK8wCenXOaWQ=@vger.kernel.org, AJvYcCVn38kro/jf8rXAJAoAOE/sSYSMz0QFkIl7HxKQ92Dj73XvlaYn5/ThYGgZ8zgZMgp1mHJSA6RNiLxl0VkS@vger.kernel.org, AJvYcCXA8Acp/BrvfhJuikdm5lkkJ1s9w9fqctTnUSnEcAZSf+32nV1RPGEzWz6/4y1XrH5PWAmcoc3fdWmjK6hxlAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwCOsCu/2aiFmCRmIYjvap+dwgTZZCTUi0KZmXrVHzfZrzzQki
	06owJRz54EeLqycVNkILrxaBKxl+kv/fupSHebBAqvuVyxKvqTlbQxXz/uNXCd7fGSkhpqE1NzI
	WKnutwBykjqUA+HuEiTvT6LvJ6oo=
X-Gm-Gg: ASbGncsmm4dHFaP4Hvb0COm0nq2RsbMzgAIALHpxqwnxgLrKILPBAxqX20B7G2QQssd
	xEXhjQudnYa6ICIetyKcqt8lxPDKen+xohemKOglxKCHe/yGk56f6B4SYPDbow+5RmepwLMagw+
	StTtElIMwTA8V1fvV+/nZOyxwsWA==
X-Google-Smtp-Source: AGHT+IE6prSwtYU8jejOPsFrwL3RDnyz90ZHDcNbMw1dnn0qFUyiFfKtLcqRpq6p+gU5DbquskqSKPCLBmcBo6KTjo0=
X-Received: by 2002:a17:90b:1c08:b0:2fe:b972:a2c3 with SMTP id
 98e67ed59e1d1-301bfb7e9demr1882412a91.0.1742402633787; Wed, 19 Mar 2025
 09:43:53 -0700 (PDT)
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
 <CANiq72mnT73Mb7RJhZjf4de=_Orv4pipunMhOersOj_aqrFA-g@mail.gmail.com> <CAJ-ks9=23qEqxT5rivsbfNYC6iUP4RXsKbcDU9XDx32ERnKbYg@mail.gmail.com>
In-Reply-To: <CAJ-ks9=23qEqxT5rivsbfNYC6iUP4RXsKbcDU9XDx32ERnKbYg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 19 Mar 2025 17:43:40 +0100
X-Gm-Features: AQ5f1JoD8JRbysUimai1WtvAXi34kvhXnv2WVJ5eMVKyON4mEJVuBdVGab5J3Xw
Message-ID: <CANiq72kfgDVkKAeX1SiahEoo13+kHrcvVY3hMAfRPGjwErCt6A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rust: alloc: add Vec::resize method
To: Tamir Duberstein <tamird@gmail.com>
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

On Wed, Mar 19, 2025 at 5:13=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> No, I meant avoiding the check. The existing code already explicitly
> checks `new_len > self.len()` before evaluating `new_len -
> self.len()`. This means the check occurs twice. `checked_sub` reduces
> the number of checks by 1. Perhaps my wording could have been clearer
> ("avoid *an* underflow check").

Ah, you mean in the function you suggested, I see.

I think it they all may compile down to the same thing, whether
overflows checks are enabled or not, and whether the version in the
patch or `checked_sub` is used or not. At least in a quick Compiler
Explorer test it seems so, but I didn't check in an actual kernel
build.

The implicit check is gated behind the other one, so that one can be
removed, even if values are unknown -- we always have optimizations
enabled, even under "debug" builds (assuming "debug" means overflow
checking enabled).

Cheers,
Miguel

