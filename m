Return-Path: <linux-kernel+bounces-413255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF979D15E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09302828F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580B11BD9F9;
	Mon, 18 Nov 2024 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5SZyhzo"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F641B0F1C;
	Mon, 18 Nov 2024 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948730; cv=none; b=ejpEGrWvcuFnqKVHN70CHxMvxm32kI55uLLikE9lNNKFCNwKtdpJjsHeDm7Itx+mTBdLYLyardx9QX+mLqpoFU8FjUO7jtZexY/vN2xr+hM1YsSszTEzCcySBS7dn6TWZtEfP3DgoqPxHlBLH6wCZnT5eTBe+U5Z/pBsYKlhknA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948730; c=relaxed/simple;
	bh=y3YxOTjy8J2Gu+uSpzZwxYtD3Og+KLDtn3aZ5JbtH8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olkbcU/yiZBdlrT9Id9JV4yj5Akwo6NS+FWpxdqZ6DWBSC6Y/Raw38FiT2mxQH/7+fXOfUUgn9fH08F9D79xFuIr+/YSGGwMdHnERL7pJ/+OfLLO94O7tnq5giJ4kn3uaJjPzIUypK8Ft8wulOQerN3OwiSopdMju08Y2EDL2Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5SZyhzo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2121858db03so1040015ad.2;
        Mon, 18 Nov 2024 08:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731948729; x=1732553529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3YxOTjy8J2Gu+uSpzZwxYtD3Og+KLDtn3aZ5JbtH8o=;
        b=F5SZyhzoQnqrO/C5wx6sV7TwITJgcnwY6/SsA3aYJlcrmrz/uCcY1/24dc5jmjccPz
         XjDd4CS4HezYME0RFdCAuwQsmXOxVZ8QYODqIoCeURAKJpAOjR1JbSkx2FfNALZI/6xd
         2V6C4OE021IVAVlnjs661qMUAfOo4vYhwtR3UWu4ebffDUooLUwg6ZvCkov24XYYPLUT
         t8hkX2rkllkFFbpFYClD5n1bdxiwC9Wuo51hrlZco0OIM2eoIJElE4Q3bNmZKGLrtTk7
         Wa+3jDK+HXqyGOG20N00YljW9dZoLfTIIbk3zhyz5qPKcq2XniZm+ib4GlYGmZrD4iRT
         rQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731948729; x=1732553529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3YxOTjy8J2Gu+uSpzZwxYtD3Og+KLDtn3aZ5JbtH8o=;
        b=XaZNHLjaP41VSQO6td+OrE1UeOmp/3VXA0IDy26t2G9gr9AJgRktoZyHKUiq4g7iBB
         GHPlOo9sEtde8YHy5mVCsh1I8TRO/ChtkWjt6oxmR8BjwT801ySbGt6O4cwTnvvh3aHN
         VxSU4SceKHchn1w9qcUI5BtpB3MFheX1739vzceywGHDlLFbsclNAyWEnSRSsTZvTOse
         31O5vNmKy8UqOjg5Pge2c48KS2sKuBBMwFkdahF5UqbJGw+9Owl5dZsKWAsq0t5KoMy7
         uR15E3EZYeNJoIew2yJmTDCQ0y0Vm2Uk9H7ooK4Vech8CbrfSJKOloyFaG8vBXvw5ZIQ
         6bmw==
X-Forwarded-Encrypted: i=1; AJvYcCVbhPD9vf9d62lgTuQqWJ30l71WN8qHK1OuEXV1a8/aCLY6cWfGSZgensQ/ELMLvf6wcJpjEcfnHcGUVGk=@vger.kernel.org, AJvYcCWKUnWsNxCIeYmJ4TxWpzrkpUbsA35buYyavIyUQmSgkyk2qn3K6jIpr+013CXeWIgftdWZYNaHJcZltWM09gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLpFtg+PcnVcYkGYfTWksAgDtfQodWcLTgBgURhkVThCqVllYZ
	imtix5lT1OwSzNpnmhSm1e/AQHlrkD4hxONJRkSFzHd/6mvzdfGpCmCq/Z96sqDKtQmXCE+JXtH
	06X5OE66aoWMktyBYI0wQ8sZVrf8=
X-Google-Smtp-Source: AGHT+IFhTLNuO/iZ9wjJasIhzAOKPrDHwGg3OeSzWihHBzoXmMw9qE8g/a1zv3DNURaTq6zsirYooYLim3kFy73SKtY=
X-Received: by 2002:a17:902:fc84:b0:20c:6bff:4a26 with SMTP id
 d9443c01a7336-211d0ef6e18mr66685165ad.15.1731948728551; Mon, 18 Nov 2024
 08:52:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com>
In-Reply-To: <20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 18 Nov 2024 17:51:56 +0100
Message-ID: <CANiq72=13uaXS+mptTiQZ7OLpyO_=r7-06cXEujFqtej=150YQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] rust: xarray: Add a minimal abstraction for XArray
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 5:33=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> This is a reimagining relative to earlier versions[0] by Asahi Lina and
> Ma=C3=ADra Canal.

Ma=C3=ADra's latest version has both of them listed as co-authors in the
main patch -- how close is this to that version? (I see some bits that
look fairly similar)

Thanks!

Cheers,
Miguel

