Return-Path: <linux-kernel+bounces-306508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6124A963FE6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDEF2846A4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC9C18DF6F;
	Thu, 29 Aug 2024 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FY/nUrAc"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E398A18D620
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923545; cv=none; b=eMz9wdxTcGPcr6G5snLaK0PYUMXJchQXJpFv44aLFfpAZXkein4rUe7ajLSpkkmMNgOfjvBpn7f+R6XUsj9siDx9dQ81qx2RREfTHn/ACgLnngIBamBYRm3qjpe6NKltc0pndYb4N85acmDoXLT29BM6HRd1bdL24E1m94F7Euk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923545; c=relaxed/simple;
	bh=CT1NrinGO5014VpmYUcxqfnX/jp6PyGlishQ729IXKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDuXnmhwM1ST1J+OECY6ChLfaqenjSQ38q+nelDkt4E7hWcKYGAggua1sFtYUh32R6ibxRE2HVhjw7pQn2gOjM1nD3F2UOABpIvFKofw1qW/lz0Ltcbm1L5krq6p0VrJOIVyaiRi+EAm5UtnnVfkGVPAxFwjKiKqrAmuE/BgBjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FY/nUrAc; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-371c5187198so269552f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 02:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724923542; x=1725528342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CT1NrinGO5014VpmYUcxqfnX/jp6PyGlishQ729IXKQ=;
        b=FY/nUrAcFGIpGpkCqoX1+41esI3hYojrD3flUCBystVmjUPF3a8a2vwLnCFR8LZab+
         XNK/A1kdsKKVgD/tw3/JTg2BT1nI9FrURbXJt0TXEgs8d8ZQQkBsvPBFLgAc8rlsB4RO
         inazRXLbyuQHskcBWAXDBX2fXASBrY3ouqBWC1KoJlQaSzvpKFk2QzSUy/Rdna+M+UyA
         O5oKA6Ir1ovW1ZDJQzL0uCH1aBlK5S/U5t81a49X522XrxccX4i2z64cSCK6Yvbzl9Ac
         vBdUW28Ov7FQbYfW6ArisqbKjKguyvrtSGNRcEYzinJxSDvRy6eYcbSKQGoKwgC2x97+
         Lx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724923542; x=1725528342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CT1NrinGO5014VpmYUcxqfnX/jp6PyGlishQ729IXKQ=;
        b=NfQ4Se67sOccrtg5VNPRnk0WqtxmHIbspsUof4GekXuiOzEgJriUXG9GxcGY5bIJ/u
         zTrJkUfyTaEQcx6+Px1IjYe5fHkrerOCku27ZFpg5CcuCvcmOkbD4tOX/wbqZMoN2kHQ
         h+BTol5Y9jE3SZEaZ7aZs+Q1XBrniTKoXsuy36z4WhN49VIjRbB/EACxaLSJBH5vMjXh
         0OkRlrV4+LasiBI9nEEV473Z9nZbK93G7bCMh4QWp/bVMZ0Hq1pAVV16G2sYK+RgND6G
         HrZB82jNVuE5D7CBF2ADdoHtzm6yRzZT0rGx4OIDvDb9WgJfaqoEPnPuVKWQ66MzowCE
         jioQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRvdiQiWGo2rNiXK+Ng5ztLuiNsec0Q5IOxKhEf/N26YqXzFgFLWpCqh5+FRH8NckWV46sfdLUwI+1yPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW45gUqaROUwC8a4BIFK2HGunn9/2PsGLs0DfEREvDMhx5yIvy
	rztRFSoavsSwV1VBfvKdvDm2KQyZJP/d8AssbGgZii/z6Ldp9m32PsbylXBotzcZ8UeHwTe9LiB
	wuJxU8HZvKgNh3omGM6FTD5jeWcf9YrqOHv97IUaVqtOb9dl95bCP
X-Google-Smtp-Source: AGHT+IH286/cFVq6KBEsx6+MOl6k2ruznID0/auN8nOm/FgRic7fdxCibatkZrNQf/zCYqM9fW9KfGWwcgmHxSqxWF0=
X-Received: by 2002:a05:6000:124c:b0:367:98e6:2a1b with SMTP id
 ffacd0b85a97d-3749b526f18mr1600873f8f.4.1724923541861; Thu, 29 Aug 2024
 02:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828180129.4046355-1-boqun.feng@gmail.com>
In-Reply-To: <20240828180129.4046355-1-boqun.feng@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 29 Aug 2024 11:25:29 +0200
Message-ID: <CAH5fLgjmUOLb63xgv85GLt92vr6ghSbp1T_vKjPK143061SeMw@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: Provide correct provenance when constructing THIS_MODULE
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 8:02=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Currently while defining `THIS_MODULE` symbol in `module!()`, the
> pointer used to contruct `ThisModule` is derived from an immutable
> reference of `__this_module`, which means the pointer doesn't have
> the provenance for writting, and that means any write to that pointer
> is UB regardless of data races or not. However, the usage of
> `THIS_MODULE` includes passing this pointer to functions that may write
> to it (probably in unsafe code), and this will create soundness issues.
>
> One way to fix this is using `addr_of_mut!()` but that requires the
> unstable feature "const_mut_refs". So instead of `addr_of_mut()!`,
> an extern static `Opaque` is used here: since `Opaque<T>` is transparent
> to `T`, an extern static `Opaque` will just wrap the C symbol (defined
> in a C compile unit) in an `Opaque`, which provides a pointer with
> writable provenance via `Opaque::get()`. This fix the potential UBs
> because of pointer provenance unmatched.
>
> Reported-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Thanks. This probably didn't need to be an RFC.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

