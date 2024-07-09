Return-Path: <linux-kernel+bounces-245350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CED3792B194
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE281C21EB0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101FF14F9E7;
	Tue,  9 Jul 2024 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbaurVyt"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFF013E40D;
	Tue,  9 Jul 2024 07:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511453; cv=none; b=MEwzCexkk1s81NhQM8H5xUfTak4C03QR8p/NwKtDwVrpyMQjTuVo9STXRabLu/ellbFN7ho8M05noZT3QV2Wm6QvwWKC7sX1WZjuv77NtYSHKGTiuTOak1nIoIvUojDh1XLGy9L+hzOvUgBGphSqqMsyQMvgmhDmBsKBHP30Kng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511453; c=relaxed/simple;
	bh=TQ28huYJGc1vxPUcB4gFQYIifpANRfJ0leOytDhyW1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKq7ANBGWSnutV3jxm7aCRTaao23JqMUsiAH5AiShb5FNKa2Dhdngtr3NOU0eTlCbR0rRGdNKB5rPT6pTDDvbWw5fjokLYixRA9tgoWCzcg50ypxaWHC3gzKT/nzNhBwB3brseSGNdFc7t8CmB6Pgfdljo5bmLwO1R68zm/Q25s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbaurVyt; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c9e37bdd6fso1777168a91.3;
        Tue, 09 Jul 2024 00:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720511451; x=1721116251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQ28huYJGc1vxPUcB4gFQYIifpANRfJ0leOytDhyW1E=;
        b=cbaurVytd8iQNhCDC5lF5mZOueNl1eXCXCVrKbqeDOzWwbbI90BEYyls/iAb+2DQ+O
         Ho9hgTJL/1bXK6gosl6+H2LnVR7nuJW3l+b7tBuRzbNsolpveywQzLAkq2jFAGCnl6Az
         /byBukb44gzUOevUQ11Y/lATMZj+TttawfJgnLPZXkNJTCgF62s2O80IkFFHzwZvY9OX
         stjW45OnWwfrF3JOf01ZSa36n3Nklyyxnjm5WeGZwOIFf06+zYDK0nrEGXz06YvleWxO
         /dikP3zzof3pOMh7rzwAO6NdsLoKNgXxDh6w5v5OYe5dFghwbbvrEpvp3/0ywdzi6lNj
         U75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720511451; x=1721116251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQ28huYJGc1vxPUcB4gFQYIifpANRfJ0leOytDhyW1E=;
        b=BL8f0ZLUnMBOtCexDI1gYx/7YiHKN9XXomMqJUEffPBofvbg6SAizFmhPIqSzf0Bgi
         svkMAB/Yp/QG6f8TwLVQl7XGgsD93herpFef79QsJwipljy0UewWcjEKmjiB+wPzG+UO
         Qsf+A8LIGwfZqyA78ToBxvLRh/RxPqK8tBF1FNGGOt99Y/FDRte5MezMmT7qwPrXEkrg
         /Z5YJzSiHWLeO4qkfIR/0R/sKrNszG/BdZb6oP7djE5qeIFf/VA1GCEs6tVT+CovHZrq
         MHQiYJ9navGp9/42qcejztiuQDG2Wf8hfwQZN1zHafYqlmktzaVStL/ormk281nfZgd7
         8iOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBmtbQGKsQ5d3VF5WjJmrfSCiirdMjUDwnC1nYtyuXqtgDuusu14qSSMy+tmM7acnx7AfW+Wzh/tN6dvKZ5VrLQKnPad1ft/oSy7+vBdBBq9c5VVgIsaV+5y3sgqfTJu0D3i0aCYXRY+ez80I=
X-Gm-Message-State: AOJu0YxutGXJKhLqbtboC9LaFGe6fTG+ACRMiK4xwG88eAP3StDkgfnN
	rfVO0Pyzqp97xkpkHtCTMNPbzzX8UCcCzpFiE62MBG2I6JFFAwpFt7urD5WpcckjtrQyOJ8i+FL
	pkb6kmokURqVlwdkhGfs9q68Mp4U=
X-Google-Smtp-Source: AGHT+IG0pwQagQxgvrF1dEz3gZV8+kHPAJjv1qDbx5+lsNSGIuRkmKhptCdl8s53If0lyPj5qY8w0PfRXItHMJgHLRc=
X-Received: by 2002:a17:90a:fa8d:b0:2c9:731b:8561 with SMTP id
 98e67ed59e1d1-2ca35be11e8mr1734516a91.8.1720511451386; Tue, 09 Jul 2024
 00:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024052258-trifocals-engaged-8d80@gregkh> <ME0P282MB4890A180B99490CC65EF64FDCCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <ME0P282MB4890A180B99490CC65EF64FDCCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Jul 2024 09:50:39 +0200
Message-ID: <CANiq72k1zKMFmNYdQWPa=S==wvFN22B+rt8D+U5-7VAQeD2Djg@mail.gmail.com>
Subject: Re: [PATCH v3] rust: kernel: make impl_has_work compatible with more generics
To: Roland Xu <mu001999@outlook.com>
Cc: gregkh@linuxfoundation.org, ojeda@kernel.org, boqun.feng@gmail.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 6:09=E2=80=AFPM Roland Xu <mu001999@outlook.com> wr=
ote:
>
> Make the impl_has_work macro compatible
> with more complex generics such as
> lifetimes and const generic arguments.
>
> Signed-off-by: Roland Xu <mu001999@outlook.com>

Applied to `rust-next` -- thanks!

I thought about keeping the original example, i.e. non-generic, but it
is a minor thing and we test the non-generic case anyway in another
documentation block above.

[ Wrapped message to 72 columns. - Miguel ]

Cheers,
Miguel

