Return-Path: <linux-kernel+bounces-242507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4529392890D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0545D1F253DC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D7514B07C;
	Fri,  5 Jul 2024 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTKkXQhp"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8F713C8F9;
	Fri,  5 Jul 2024 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183978; cv=none; b=D2kR/2MyFbrpzOPduEne9uLWOUz/6O5nKyPm8hcpN5R/a43xa2tqXpEF5m4YhKf9AHVVrPMSM4WOaU7SvEmVFSw3lqxmhALtMVKNLTjIt9Y6LiVA0BRNdwq8yzb6TAnNEo5/ivhGaxjczjeB57nNAxShED7FY365FSZzzZT42vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183978; c=relaxed/simple;
	bh=Ny4NipcrdKMJRHgPMlWIpSzIm0jwdGYQDrlVbxourss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoBaxUGGXB59vKRe/62X9ileJEqE/XWDpBt6+479PzXdUKOR1VossWZ028Pi6oySvlw1v00D9QkiXOzZmixBGJDkKCPlgkmmxW7id1U5pfgbBWc0LrtOFRNOunO7ryAskBQQmyDw3pSLlCPDD20W6ldaGnSeNMkmlZPSd866/Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTKkXQhp; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c927152b4bso1097205a91.2;
        Fri, 05 Jul 2024 05:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720183976; x=1720788776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ny4NipcrdKMJRHgPMlWIpSzIm0jwdGYQDrlVbxourss=;
        b=KTKkXQhpsNhk1XrfVZa7a3IuLgIaLUiZSWFKcsI2h1rli0GJSz2hfDxi/vE+wHz4b2
         X+5cAfscs1bKE/7IWJbAKNc5cLTS0TrFwZAiy0LQSNXV6SfXjLXpDL66jHqcBorSpyz4
         Vlxq5YOQTiUSL1olcjkDSMVldVVe9ZTSoX/Kp6bt3rIS4IhObuxBasFvYk7CD/xs1mKu
         ZdjauF9ouLj0S8FjkPJPf6HG9nMpjD8sOee2Rt5WRO99qy/6ha9a7KLI8E4n4NxlMLJC
         nFgWxoi5fECmVHTwvcA7gxX/C2GRZTZiiW+VgjOQt5FqnQWwfVe0pJCeJcBcp7NYemcd
         cuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720183976; x=1720788776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ny4NipcrdKMJRHgPMlWIpSzIm0jwdGYQDrlVbxourss=;
        b=PG8XSeZQOG8Lm/MWybo/POL+DoCWTvxzavHZVfy7lB84kaGeUAk5AW8kcIQYZSvSyA
         9wjbf4PgER56Bo3kiDUe27dM1SiK1FnVQMyaGNSsgCCzn0woiTJgcDFcnIlVZIdfsYPZ
         LW4J6uJHYXflgA/6qfCw5JkByk2uHQOmqPkGcO1QLU2uP2XY5mVcSSrSaCv/XCWibFb7
         da2eVQfTLKDsaDmTHzpocDmZ0nphPy1VUXtz77m2EcSMp3nUOqiFEIbKqtpf9VfFfv9Q
         wNnHVlEnNxgaa+BsefvkEh0URUeOE6twG2JdwPJbNVa/lTmZmTBBimjiLQvvuJ0RMuuQ
         dcag==
X-Forwarded-Encrypted: i=1; AJvYcCVYW1edjDFlaIxE4LmmiFL3ojidoACRN0gPdObpXH2f4vNB5u2r2GytInQBL0LPgeID1YXdK5+os6/TNfH/1p1h8inx6ldoB1TcZeSLa28Fiab6JODi9g/14qkgOlNKeTpModnaRbUVCLkdMXQ/xhFOCRWZOm6l4ASPhrI0bQKC/bGFITQO6Tg8gdRM5xJze9N4WJBP+xWRPruLVDH9Q0lRYMA=
X-Gm-Message-State: AOJu0YyRvFINIGI0IWEn0kD7mOWCuO6dgwxPsbwBPJy5j3OPIxcnVaGw
	W3t7xg8pjUMnDz2eJXgrWZKYZRwr9TkTGtYWZZJLanWL4B1O8YatVC9lNPgAl+D0UMym9R7AawZ
	vZrLc3LR8iwaCImxU+TIFZdojr7k=
X-Google-Smtp-Source: AGHT+IEzG1wQ2tyKmgXA6YWzUKo96HqR7GDGf+HBNV2kpFi+8P06yzDR0xNhdvTYwQ4FFo4HCneqcI3eTwMsgMHmaek=
X-Received: by 2002:a17:90a:de91:b0:2c4:aa78:b48b with SMTP id
 98e67ed59e1d1-2c99c6b954emr3709128a91.38.1720183976081; Fri, 05 Jul 2024
 05:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701183625.665574-1-ojeda@kernel.org> <20240701183625.665574-14-ojeda@kernel.org>
 <ZoeQVYda-AZN6PYy@gpd> <2qwdfogh6jd5uixxjzlagmtfvnykk3x4ztqrn4j2v6qoref5rx@ooj6gq27bq4z>
In-Reply-To: <2qwdfogh6jd5uixxjzlagmtfvnykk3x4ztqrn4j2v6qoref5rx@ooj6gq27bq4z>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 5 Jul 2024 14:52:44 +0200
Message-ID: <CANiq72n6bYt0AKNxad2+gjwHKQ1RiDxAbjm-2u20L8TcSZE-9Q@mail.gmail.com>
Subject: Re: [PATCH 13/13] docs: rust: quick-start: add section on Linux distributions
To: =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <debian@fabian.gruenbichler.email>
Cc: Andrea Righi <righi.andrea@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Jan Alexander Steffens <heftig@archlinux.org>, =?UTF-8?Q?Johannes_L=C3=B6thberg?= <johannes@kyriasis.com>, 
	Josh Stone <jistone@redhat.com>, Randy Barlow <randy@electronsweatshop.com>, 
	Anna Figueiredo Gomes <navi@vlhl.dev>, Matoro Mahri <matoro_gentoo@matoro.tk>, 
	Ryan Scheel <ryan.havvy@gmail.com>, figsoda <figsoda@pm.me>, 
	=?UTF-8?Q?J=C3=B6rg_Thalheim?= <joerg@thalheim.io>, 
	Theodore Ni <43ngvg@masqt.com>, Winter <nixos@winter.cafe>, William Brown <wbrown@suse.de>, 
	Xiaoguang Wang <xiaoguang.wang@suse.com>, Zixing Liu <zixing.liu@canonical.com>, 
	Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 8:47=E2=80=AFAM Fabian Gr=C3=BCnbichler
<debian@fabian.gruenbichler.email> wrote:
>
> Debian (for building firefox and chromium), and uses a -web suffix for
> that:
>
> https://tracker.debian.org/pkg/rustc-web

Like for Ubuntu's versioned ones, it seems not recent enough at the
moment (i.e. for the current kernel), if I understand correctly.

Also, it is a single version, i.e. 1.70, right? We didn't use that
particular version in any old kernel version (we moved from 1.68.2 to
1.71.1 in commit 89eed1ab1161 ("rust: upgrade to Rust 1.71.1") back
then). So I am not sure how useful it would be, but if you think it
will be in the future, perhaps it is worth mentioning.

> https://tracker.debian.org/pkg/rust-cbindgen-web

We may use `cbindgen` too in the future, but not currently.

Is something like `bindgen-web` also available for stable?

Thanks!

Cheers,
Miguel

