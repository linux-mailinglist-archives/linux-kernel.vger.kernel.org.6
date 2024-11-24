Return-Path: <linux-kernel+bounces-420354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341629D7940
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 00:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D24E1636B3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 23:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629AD18A959;
	Sun, 24 Nov 2024 23:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwViBySJ"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEE9185924;
	Sun, 24 Nov 2024 23:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492572; cv=none; b=GBXhNnXwPia0N5aVwBWI9aJuBxl7MnyLmnpmCwFHW73cIm+Qm5QozXz0gvPYtpFHytQvHMcOO+LHLLn0PqC5xquPxNwWZLYyWFweqqzc+Z90EgQsVKIIcSNJEXc6I2CLaNjlkSDun1i+zBklFy/MzDh9sT1u1sQOsGNaQZzAbpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492572; c=relaxed/simple;
	bh=BEcuvNrj8JDYTsw68D9XSc1FNx/lPzGaINUfsEXci2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZ3ZhIiHv64AZSezf/hzgZ99amAHekG6AOUb3ChG3ym7QdGzFJZEf+fd3/5mRIrYes18LtrPCuRPMKa9kOcmMTkDGbkLTUOr3fVFOFApJFCTRO2ZTcQXo605sdxVka1/MqnMFNb2Yp3pAcUmK7wcu47/+Qr+Mvd6OEkFwCPxMtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwViBySJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ea4e97ca43so651944a91.0;
        Sun, 24 Nov 2024 15:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732492571; x=1733097371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEcuvNrj8JDYTsw68D9XSc1FNx/lPzGaINUfsEXci2w=;
        b=JwViBySJ6CZsGWb60k7qDW4tWc4ugiVossKYrv1iPDw2N8Xxpm6yebbqgp0kiJDQ12
         EiztQkA5nRY1JRntCGSJgJhGhiJ3LVy8fiMBUF5kbPZBMQNj60EW0DQoNHbytSLFj4Rt
         8uiOOudxgz0clWS6v0XLD5ghW3zqnHPd2ykMh6G//SOJ2cb+GIJCtk0j1lmIhNoc0cGZ
         RJbz6YoolIHgl1V/95Lr6QtW+Ukh4RV4mrvSb9sr1QZJuUhDsqRJWcd1m05AqF//hpJI
         qp063/LK6C3iWpAXRGfMte49WHH0ptttDrEduHjCVXm/YG3x4lD2M6rz0oyPs1qkzt6f
         xKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732492571; x=1733097371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEcuvNrj8JDYTsw68D9XSc1FNx/lPzGaINUfsEXci2w=;
        b=XdeeC+dQUQvRjS8UtnvG5NuwCYuFq06EhS+scz3kb9XqfnYArkWsvp27Lt5lXwRCRi
         3kcu5/Du6ZGZ/w3gMu74S7Nou1YBgPq2PAS1PDvUFpJ59EdMJt2C65MoVGhToIk4lEOW
         5M7lT6nxYGmu99I1owBKBFhuQp7A/TNW6FJQNzJy5aGqcniu0GOh6XuB2nquH58kygk6
         iXoJO4IpxFAy2KME5CYvhr4UfglaFLKIeFx1cYZwcZ+7luTM6EafwyniQo7qaJLXcfCz
         F/dFW5rKUbpI6PXfKVb9zdkhH8V8Yxe899AWfC4DcMbnP5Hwgjwngt1Hf2yGTVVBG919
         3N1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgx+b2bdyofNouY3AQlGTAtgGItQRqNWBiNaQZylM/ld1vzPc+BDfJJ4Wl9pykZJvJcy0JyAJG7ftN/Tb3ga4=@vger.kernel.org, AJvYcCXT00k2Q0ooZksNto8XBqa6ksgGUqFcHiRvQbtvb1jJR8J4Ub7Ugb+5uD1dd2egMefwC3IX9DJlMzi5V4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtDfZOkL8eTKG/17TiBa+hZksJTqZrbpLcU+aPzU1tah/Eq3Es
	hKNjD17BWUctdTgoeTK5insAPqQG3fAq7v6O/aHVPOKvZ0JsUZkntcvDNc7ScChRHRURjy+E8gY
	O07ouv1/aGwot/DJPVzGb2lrOiCc=
X-Gm-Gg: ASbGncvIgolYrI4xhHelsL+A832AIjyAUeufT602y0xlEDAWTZ927yE6Zq0FDT3kWHi
	6oaMCfHUNkmXqeOIBgpSZVub7lsBEfQ==
X-Google-Smtp-Source: AGHT+IFjUWF43u/ROhUxo9tM85utRv+Ecq1g4sHrpaDwuC22Uwm+z/tdd8bUZbed3ovdPCNk9h+NMYan8RA/Vm2PrxM=
X-Received: by 2002:a17:90a:e7ca:b0:2e2:c1e5:2df3 with SMTP id
 98e67ed59e1d1-2eb0e9a412amr6098614a91.8.1732492570768; Sun, 24 Nov 2024
 15:56:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117133127.473937-1-ojeda@kernel.org>
In-Reply-To: <20241117133127.473937-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 25 Nov 2024 00:55:58 +0100
Message-ID: <CANiq72=hN20i4ZcVFRVgbiGNtq=FDDOVjeyQt4gf4-BrE5nd_A@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: remove spurious item in `expect` list
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2024 at 2:31=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> This list started as a "when to prefer `expect`" list, but at some point
> during writing I changed it to a "prefer `expect` unless...` one. However=
,
> the first bullet remained, which does not make sense anymore.
>
> Thus remove it. In addition, fix nearby typo.
>
> Fixes: 04866494e936 ("Documentation: rust: discuss `#[expect(...)]` in th=
e guidelines")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

