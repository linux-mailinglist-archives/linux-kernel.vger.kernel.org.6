Return-Path: <linux-kernel+bounces-329516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0F2979239
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 18:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09B87B218AB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 16:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834131D12E9;
	Sat, 14 Sep 2024 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNZ0IbL5"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8CC4414;
	Sat, 14 Sep 2024 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726333061; cv=none; b=YQDQ2tEvHUL52yTCBOznsh1zNeZG1xp7Ky38UrHxqvNFjWfncjQEnKKqhVsZG9OTY3apjNddxP9tVYUJtXYJWUFEN78MOMxP49tlZS0cbD4KW3/Dww5J0kAELxwiBG/Ka93wUzNS/J8mFP4mgm72Fg1NEEZZ92AN6y1+CKkXJ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726333061; c=relaxed/simple;
	bh=sWamHUsY/1onflk8CIeKOaBisZMhSZHiw70nbhdLc2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdI0OPXST8wgsFh2xHtmoQ2MGQ0GIpNGQlo7tUsJyX1NbluFnosw08M9Qli+XVL57SdBEviFPNtwUS60ik/yU8HfwjST4rr0INH3nDUTsJd8qJrN11NiiDz1pz7kyriQjagtvudBNwl463yZ4hquWVk4K1xFKtEgNzU4J23qPaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNZ0IbL5; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7d50e7a3652so2119439a12.3;
        Sat, 14 Sep 2024 09:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726333059; x=1726937859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWamHUsY/1onflk8CIeKOaBisZMhSZHiw70nbhdLc2o=;
        b=JNZ0IbL5fLRue6pFXp7XiGuPFE+djmvrAD8dGqN29d2d6DvDGkZoqSaDEeeRiTi9fz
         w2IajTDXQeODT6n7y3xN4XSx7ht/H1AP/hVeeOrBB6eFKjFw7GOIkQUmQHSlpuBqatmn
         DL4PNL12BtIlZo6tO/0rvaA5/io9iXI4u6OSm9TFlrRw71EKLY+r2Qw+oCP8H6IkwzzL
         Ke7gGjXLrqGeerAIxKdWX8EUWpA8fMDJBCCiuKYfPcYVVKXIuiFqK1htaICNyXCpUWnb
         siX+Bvkh5IqiPnQk81B3vwdD5nsEGNK9b61dcLW3JuV8J/hs7fop0VW5+UI/kmwoR30U
         Jy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726333059; x=1726937859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWamHUsY/1onflk8CIeKOaBisZMhSZHiw70nbhdLc2o=;
        b=vdNaOLG/TihuI/mYjmz1bJ/hgMvCZxXdX/BXHsx0ezQiwiQx9RKzv2aJ42GbD+Ygyu
         BtxpfFnWbo06kbPBJb9OKaswi75nGoDyjsBQPqy5g5lOY/F91/WmkH3nx/bdw26itML0
         rN7uX1j7S/AykgwqTwWAK9uYx5YNRt6WWPUVRBZ+nTiTB/yq3vxRzvihRS3uf+SPorsJ
         AXT+cGUU5MO4QTc1TiHbAs8PpMhri5nSVe1cRccBiaLFPXO+QgpUDi8P7EnQp3ifUSYg
         G28pw9M2pjTEhiUl8teWDK+xwu4kZAeBZymoCGfMNwivxRst35sIg9YFxDKkH4GeHLpA
         JzIA==
X-Forwarded-Encrypted: i=1; AJvYcCUqFA3VgMdA3Dfq61syWt1W9cqdCLY4hBJZ1xvoPTrM+TUMz75tyAQiXEKH+Rd+tibxI/rss1H2oLkTBGXj3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yye8lCtklcz5FUflxLI3sGhQM5RY+Jnn+aTvPwEuQsecPomNJr3
	7jE/RaS6vnICrmzXO45b7G0HTJSmZMdFKPMXx5hXKOq/Rv+ddn2hRwt6xVRpiBcMT0mC7cEKKV7
	sBBleRTUrm99caw6TimUuDBHDnjo=
X-Google-Smtp-Source: AGHT+IHdJq2AvKX1ib+0MKP9D53s3u/6TP280RdkZBHn648wSqhY+E9pVg2teLVhE+lnQyb8WtH9haiwMUpc0t1GthI=
X-Received: by 2002:a17:90a:10c2:b0:2c9:359c:b0c with SMTP id
 98e67ed59e1d1-2dba006d66dmr12134919a91.28.1726333058750; Sat, 14 Sep 2024
 09:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa1b4059dfac001945745db02b6f6d9db2e5d1cb.1726072795.git.hridesh699@gmail.com>
 <7877d23adba22e2f89a61efc129ecf1b0627510b.1726072795.git.hridesh699@gmail.com>
 <CALiyAo=Z7SCwCRD_2rBnQrkF71q4MRyMjqJZy8iWGAuFqOmWUw@mail.gmail.com> <20240914174249.107a1533.gary@garyguo.net>
In-Reply-To: <20240914174249.107a1533.gary@garyguo.net>
From: Hridesh MG <hridesh699@gmail.com>
Date: Sat, 14 Sep 2024 22:27:02 +0530
Message-ID: <CALiyAo=ZdFy0bR03NndODmE7vP_JRzxs52-z=iXKQbO_Z6rtYg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] checkpatch: warn on empty rust doc comments
To: Gary Guo <gary@garyguo.net>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 10:12=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Sat, 14 Sep 2024 21:01:24 +0530
> Hridesh MG <hridesh699@gmail.com> wrote:
>
> > Ah, sorry. I did not intend to post this version as a reply to the
> > previous thread, I wrongly assumed that editing the patch manually
> > wouldn't have side effects. Should I post it again or is this fine?
>
> I don't know what happened, somehow in my email client I saw the old
> replies to your v2 patch becomes reply to your v3 patch.
>
> Did you somehow reuse Message-ID between v3 and v2? Not sure how that's
> supposed to happen...
>
> Best,
> Gary

Yeah, I did not run git format-patch again to create v3. That messed
everything up.

