Return-Path: <linux-kernel+bounces-291226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A271B955F56
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 23:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE27281632
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 21:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DC41553A6;
	Sun, 18 Aug 2024 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeiVCDOl"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41886171AA;
	Sun, 18 Aug 2024 21:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724016742; cv=none; b=menn3k/3IQM7FL1pr0r5uq3tFuLxgOP5zPN4gGbjWp+VOul81PhvxFGJSN/L1xk+0DDxwDQTJicdR8+j1nQIas0fbKrNsex5RVwDi2a846/Kql2/GlkCNr1iQT+KKp689jH1u1l7b2swP9jr2Rp6rdVEieEMRFvewbzsgCe6dvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724016742; c=relaxed/simple;
	bh=slo1f0s7A+qKMeAVSW4YhxGHwyG6Xv/ynlW4B8Qu5Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvjHQMJMOqxOYX8aZ7uOJouYEIA6YlpgLnLjSPprw/+72SNHXm/Z5ZvE//ha8BcpXTZ+7IcetWaQWaIRwTISt4hI7wXDhZakOjTczlt46aQuq9Z9adknBfl9Ch5eibANL3Zknx2jqjPl2rZ3bUoKZck0iQ2b1ao6PFqc2CDfWeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeiVCDOl; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7a0e8b76813so2819202a12.3;
        Sun, 18 Aug 2024 14:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724016740; x=1724621540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slo1f0s7A+qKMeAVSW4YhxGHwyG6Xv/ynlW4B8Qu5Eo=;
        b=BeiVCDOl+ebwDGoa7VCa+44i1kkEpZRqYoGaIQY6xWpSU27xj5wcHWY5FnMTzXuk1I
         K2A1kSB2eMdvQMaLXExw58HiWKaA2S2JlWGU8TOhi/CYdqI/GZI57OdNcokC2vSlYJwx
         WtVbKxd1ywFjIhM2Ymrg6OksQvAsm022aKSC65v/C0gAfg3nnsQ9XYweLgpSSUcKKbON
         7wvANpyxFfQRtY8HwB9W/vAUDlM53sSb0xOdCycHJmmJEVlF3W91ePpbh1YS6O58bSLi
         AQE8opszqUjBoxalScTrjFSuoRe8pafpl8n5Ft6cWGqXpnAjWHp/USrRwohcn8CsybLE
         4+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724016740; x=1724621540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slo1f0s7A+qKMeAVSW4YhxGHwyG6Xv/ynlW4B8Qu5Eo=;
        b=t0aGRu9sk1XDKVJrgxOd4PmoSoZSpx6QEr/MrFKfZ1yXA3V+1VUJNt9PBSF2sYdjzs
         nW+qkpJ69IUL9osICdxKZESNIB0ghBghymi2EKX4hLW5T44Umvj4F4hHu2SRms2NWTmL
         juCtEtY69R4CpuQ9baxut/+/GKKwYB4B5/GkjaWa3XpXZrYhCzuoQky/4mSUAC7+bgEs
         E6A9FHBiCKIbw3R8kLng+9xrlUWg2aKQn1wMZ6vlPbsivH5zlz2GZsi71Ta2MqIX7R6r
         BxdKgFP20nJRnF/7ENX99XCbfjX3K+ar8ScFHjOu2yiasaNx9SoSdSqTLpGM0s4JqsBK
         L1bA==
X-Forwarded-Encrypted: i=1; AJvYcCU+fKaL/bLuRAT5hZUrkAFAw9uTVKxzd5DV4nmD2vnWwPjGQBWCv0MOH53uRpb9mvrm0X7yFlxwmTkoEMMIWJlGZvbd7+XaiFLuGaA26srGybcDn0BpjHcAex2mrxkFiQvh+C8JqRRcUJdreME=
X-Gm-Message-State: AOJu0Ywz29Q9C/qG98mEswqQ3v8QCLcTuo4yoUHA36tH8rISr5n1MDdo
	H/hKeNVWsG/KhWvnYppFbcAGTe0AEtI0KxnwvIX7K64Exs6meMzgCSND2QZXhDWdEZ9tH7yVdZO
	gQoXSXjKl0T8vGpwm2sZoLOGkBU1mxQ1s
X-Google-Smtp-Source: AGHT+IEGgk5tCAbTO3GXxGScXewJNkkETGQWZi6gcUEq9lhz5V4xvoF11Y09Lt9WGoCE+QOpHoX/JpxFsVNYPGFN4wI=
X-Received: by 2002:a05:6a21:1789:b0:1c4:6be3:f571 with SMTP id
 adf61e73a8af0-1c905026114mr12251183637.39.1724016740359; Sun, 18 Aug 2024
 14:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730182251.1466684-1-benno.lossin@proton.me>
In-Reply-To: <20240730182251.1466684-1-benno.lossin@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 18 Aug 2024 23:32:06 +0200
Message-ID: <CANiq72=fNWhgXDjTg_3j--3JYRb38iioUZtO=xydTo3ZQiivyA@mail.gmail.com>
Subject: Re: [PATCH] rust: types: improve `ForeignOwnable` documentation
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 8:23=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> There are no guarantees for the pointer returned by `into_foreign`.
> This is simply because there is no safety documentation stating any
> guarantees. Therefore dereferencing and all other operations for that
> pointer are not allowed in a general context (i.e. when the concrete
> type implementing the trait is not known).
> This might be confusing, therefore add normal documentation to state
> that there are no guarantees given for the pointer.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

