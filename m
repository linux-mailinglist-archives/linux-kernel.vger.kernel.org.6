Return-Path: <linux-kernel+bounces-313849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 538E396AAB2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F5B1C21A0B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0941CF295;
	Tue,  3 Sep 2024 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvIyoRBa"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D69126C03;
	Tue,  3 Sep 2024 21:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725400618; cv=none; b=UAo1/nHkPjXLCcvnt2DIMABW2HLwFHJ/tc9hnZJZscotM+Dz0xwOQebq50yD21BwPnEW3z0S5qySrdLV92MKyzNzc4O+3TiVMAXYFLSuNI1eDel6pr7nYRZBDsO/x/1A7By9/N5KByiqprYNF+JbwDbhxiFQ8Ir1pwFN4N4X+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725400618; c=relaxed/simple;
	bh=GEvdm2ML5hAmdyHvDrjNM6tMhQ+dZYtKLzN6HrIhslg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s1Afc3z6Itz4+HYSnCYfafYdqv7Ter1JB9sV/DZUQLgMYZkSdpwO7PPdKwfsaC08xYwJDTcVspbKcPsX6i3bubvwGblbh1j9XLDi2uqSC+WeDjmfU9WhWT/xCiTmTq0Xe3+BfVPLDf2Z48+VOxYr8i3fUUHpiZyw7H55Oe4E8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvIyoRBa; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-714269f312fso679127b3a.3;
        Tue, 03 Sep 2024 14:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725400617; x=1726005417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEvdm2ML5hAmdyHvDrjNM6tMhQ+dZYtKLzN6HrIhslg=;
        b=DvIyoRBa6txP6352ZGANFUPoo1U4zsGGV1R0FSmnmNbtyNv6L3eIGNRSpK5/U9i1Lw
         iEbb788vv23D1WDwgEUqyUvIwaphvCxD06HjIh9xIVnQrNC6L57kGfiyLwx9imMsRBkw
         /D73HcsTQ5p0lcs56Ds4ov5BuzZPvYTdKUj+XPUIntQ1X2Y1QXFLZHGhh+hcz2uxnv7e
         5sPUzJnFZiPWOEkjgMe2kg7tsN+JDAX983WHbHgwJE5RDzVfkJuroYNk8ogQUCWcCQBQ
         GKkECU1XUGcNr6tNcWUvxq0WTiM9DQKw/MI84zorzIe4u8l7nfpKkcCIrHn6D52xgHF9
         gmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725400617; x=1726005417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEvdm2ML5hAmdyHvDrjNM6tMhQ+dZYtKLzN6HrIhslg=;
        b=ERwpQDags/j+lqfCCN3pDnAAy2V1K0xUO+sr29V64G3hkdqzdXRIi3YSXGZmpta75Z
         L5mbDoXnNFzMbx42+Pnl4UCSx+A+rX6iw6meMxnLfgV55oQ7Gw2tHU5sZ7e7CwDlV6sb
         CtQTT8eShl75IQMCIc935T+bWmaw6MYGV0pdDed97pPyAAHZRDZvUN6Qz/J9EBQqg6FL
         Q4HWhig73JuiaVPG0JflRv7evxc5QYXmhbXYPq+QS3urpBoKPsft913Pf811jbTyz8eo
         z8YNwOt9fuo+IFIZhNiB7czhz/Kbg5dv4aW5IDzjM1g6QykBQez5xPqHncbSkCDCaeNJ
         gWDw==
X-Forwarded-Encrypted: i=1; AJvYcCWZQ7tnzK9FLQEPGT2KkngieBkzqN28PeS6Cv9RhFCjS95OBSX8MZbqbPq73LkBQFUzI0lvwWSIEd7BP37eUzU=@vger.kernel.org, AJvYcCXKG/DXVHPgDUOAdTuphkWpK8oHq5qKf+Aj6h71OniJRTip/ELes3uF3wpd9ND0aiWyVBQHgtJlUx5IXDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYpWJpDVnKSXm7cR8Ji6FaXtaICdLSY4TFw8XzjgsCGwUoXHAT
	yiNJOfpf+gWGjCp/lWJ7zPjBCR31ac8ElB39Xb6u8SMtynw8Q/j+M54mH16kA4cjECke3XXJi9V
	P768j8/MXmcvrv+aHdAeKb8VcG6Kt1ruV
X-Google-Smtp-Source: AGHT+IG9Ts3Rsy57/ISSeVLDpOmDsIkdYIbRhT/z7Gw6akfQlkLkFi8kvgWu54+P8ag3xH2HV/7eiTvLLg4TKi2x78M=
X-Received: by 2002:a05:6a00:6f02:b0:70a:efec:6b88 with SMTP id
 d2e1a72fcca58-7173077f630mr8952365b3a.3.1725400616650; Tue, 03 Sep 2024
 14:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902173255.1105340-1-ojeda@kernel.org>
In-Reply-To: <20240902173255.1105340-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 3 Sep 2024 23:56:44 +0200
Message-ID: <CANiq72=h3xQ8+b9kBYCxzAiGfpCgC18f7=AW+yNSDGG-dHv7VA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Trevor Gross as Rust reviewer
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Trevor Gross <tmgross@umich.edu>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 7:33=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Trevor has been involved with the Rust for Linux project for more than
> a year now. He has been active reviewing Rust code in the mailing list,
> and he already is a formal reviewer of the Rust PHY library and the two
> PHY drivers.
>
> In addition, he is also part of several upstream Rust teams:
> libs-contributors (contributors to the Rust standard library on a regular
> basis), crate-maintainers (maintainers of official Rust crates), the
> binary size working group and the Rust for Linux ping group.
>
> His expertise with the language will be very useful to have around in
> the future if Rust keeps growing within the kernel, thus add him to the
> `RUST` entry as a reviewer.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks everyone & welcome, Trevor!

Cheers,
Miguel

