Return-Path: <linux-kernel+bounces-300561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F33695E51B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 22:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96808B20C1C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 20:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E44516F0C6;
	Sun, 25 Aug 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gna6gxaf"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29006481B7;
	Sun, 25 Aug 2024 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724617337; cv=none; b=YKjkDqhx0S2SmCAsv8QQFUdAxfTRz0CYrH4jODQJs8keLupjoLG5X5XaQVBIxgv0Iiwk7/GYwLQpoopaZaDyJQYK3AXgskFWHq8voreN23Vw1Lemogtm65++jPaUg9uJNspseDe2M4CXpHNnrIQxT2jdN38d5MWYVRRhkQwE9I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724617337; c=relaxed/simple;
	bh=GYSyNOK3k1Vwvu+qUM78Phh1+2YeSoxQg85u3iLzFEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXV1B+LEnlbVRvx7H08CvFzCQ2jIfwUyhuN18vS8qOGbR5fel/H4Ky7lAGj9/Al+C40VXLGQ8apGR23gFSi8cQO+bXVQK27puxAjze5Qs+qjBQ8JVpQ5dJYjzAXE3HSbRykxudJuHbdchGKBUQ5rlq8ONQCMauFFOLxCh8baGtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gna6gxaf; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-72703dd2b86so603170a12.1;
        Sun, 25 Aug 2024 13:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724617335; x=1725222135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/YBMbb7bDw+tUfEn9ELV8y2Lwvjiv14mYFxssAzGRo=;
        b=Gna6gxafX0vdznZIHox3IJa0ix5nZB7Yo/kmGR5aBoGOKW23yGjfZAW5NgRQublkUV
         5RhsNPAc2BbpV99W4ZRLPqaNg1g3FqEd2ilVBpmm6scuZJWSR5JIcZM+iWRkIDcxgwnI
         sGFvtmty3FxW4niDB+l3QU7lg8wh1SrDJlVFQ3O2Bn23+NtsXMSAdgANO22RNENj4KXb
         vsvwOLCpJw2kyTaiBGtlYnmUxeNPo+qsMvCFCpqIpMa7rhoeswbCvrkI2QvKwHl5gIr3
         S8iLh/dhEn2h21ZqB2sg5Yyr0hIUCnEVPqPfrErmEvfMiPS8n+jyT5rg6NmPbMf/7ock
         LamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724617335; x=1725222135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/YBMbb7bDw+tUfEn9ELV8y2Lwvjiv14mYFxssAzGRo=;
        b=HARJI5/ZZmQtAog6oAei00UIBPNWF8fknxzKFAzMt+pugObZBMrs305feeE1RyY/jd
         3PlbOOKl93DPdJsHDvBV3fTO0H5sTMO/7u7oFrRtZGqfDJYaQ3DVZI9AF0kAO2DEON6I
         Jbw7IB0GyHcRsnrdtB31sjCfW9YcNA7GSKgwTMbr5qobihT0lcx1Cuweo5Bx7voxxiQQ
         hQxishhI/KnT6fUiApG9qynAEOdqupn93weXQI29Zj2eSvQFs6VWGX8zJ4GBlZ1wnm0I
         Eq+Tp8pMVsPidnEjs1l1ZqqIW3o4r0qrNHIYDOotH58ZwvDE4JPo7Km9t0k+BkWI/f7K
         3Mtw==
X-Forwarded-Encrypted: i=1; AJvYcCUJyqidWOmiWje7pMLBUNc8kB6cRgb/twhUcPVjXNINcxa1qxNC6m4rw/a1bFfhiFqc+WCUuWGif7B5P3uw@vger.kernel.org, AJvYcCXAPHyQ74jeCcPcKVvkviKZx98tCd5Xfdg1aM0S8YDauvaMa/D7TJjauMu1U0h10vGgNaxREiKjS1A=@vger.kernel.org, AJvYcCXvVwtl+b45lkghPlALXLODTMrT8E7wItD90nOb7jsl0IRkzqXCXFVZyNiRcWk2LR3kiKl/qM3lREH9rqydaUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT63UNu40978haGVtgDXfofa5roYhaO4d3Vik9g+wke+FRWgBE
	1uDBYuEj0Fh+8exHjgndTtsIsJy9dw1aWeR+DHSuRa2P6hGCrsIrAlM63qnfLBQYnNSa/abvCaK
	SYsNtnWf/H4APx9XCMf/FV5v4y34=
X-Google-Smtp-Source: AGHT+IHCmep9UepNduc+XY5Tzud3PFNGZ8xoRBKUCUNs9JGrOraBzt1yGvUVLlvm+mlvyPkNrStBGRCpiayAi7lCJI0=
X-Received: by 2002:a17:90a:ce97:b0:2d4:d74:ea4d with SMTP id
 98e67ed59e1d1-2d646dafd3fmr5964512a91.5.1724617335360; Sun, 25 Aug 2024
 13:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818141200.386899-1-ojeda@kernel.org>
In-Reply-To: <20240818141200.386899-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 25 Aug 2024 22:22:02 +0200
Message-ID: <CANiq72=gTVwJmD8eW5Yoi=rROH4Kf45+0NLDVbG41xmTr+XKGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: rust: link to https://rust.docs.kernel.org
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 4:12=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> The Rust code documentation (i.e. `rustdoc`-generated docs) is now
> available at:
>
>     https://rust.docs.kernel.org
>
> Thus document it and remove the `TODO` line.
>
> The generation uses a particular kernel configuration, based on x86_64,
> which may get tweaked over time. Older tags, and how they are generated,
> may also change in the future. We may consider freezing them at some
> point, but for the moment, the content should not be considered immutable=
.
>
> Thanks Konstantin for the support setting it up!
>
> Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied series to `rust-next` -- thanks!

Cheers,
Miguel

