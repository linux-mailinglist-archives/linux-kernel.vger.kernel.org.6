Return-Path: <linux-kernel+bounces-536658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF8CA482BA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A08166600
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4345126A0E9;
	Thu, 27 Feb 2025 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUiMJRgS"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC5B25EF95;
	Thu, 27 Feb 2025 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669136; cv=none; b=nqaqfYS+C2xY/jfPY2r0IA/t+uCLiAWpv0jvZ+4PFFnk3mZ1H3LmZPp5h/eVjMXxYdQcwWX1by84Jz7fHxo3mwn7EbDAIrAJao1w5U2Kd4I2WxIDFugLQbRuOjo9nhSo+vYL6xgJHaUf8OBVOVDjOFr6sShigFMfVNKbnnwhTnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669136; c=relaxed/simple;
	bh=hJrwlkkUVzio2wpaktL0L/Hd3mV1lQuzrfSl9WaxFYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEo2MwDsthTWq7UTsq/Z77aRE2njcjDuPPv+Tzi3YaM9EaeiCCo3mata46c7CVP//9Q5ilnUIx/aHWn/0+0OjpVzwKO4KPBJAK/7lOTRxoQdGIaBGnY5n9QbieH7TVaMpu3HN+PIrE0pLmlD9dpjvWYWazTRCreEdoCJDVwcSy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUiMJRgS; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30b8f0c514cso436841fa.2;
        Thu, 27 Feb 2025 07:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740669133; x=1741273933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gfn+uCBojQ5GG4YhEtPCwqVqkPReqrK18jN+sTrUXsk=;
        b=lUiMJRgSpkQZ7I87tRjErpeTY1z+fGGtk10HXB5a+HWt9JDZ523VdnxWOgWzZzxjO1
         g2WOAQRnb26oA7313QBQMBQpJqXwMODMu7yW86aN9YvMjzFbSve1Z3ZIf9XocngaMXMA
         pYyDebv2jskc4SraENyk+KuP2uxMtmdK46G2yUgh/ANpZDm+2oBoGbhx4lM0XwdCyc1J
         iswTmrEd3CTXaIygZYf467iZLRhTAa0OrhFO8czAooPaKpks2LffB/3bAXNAFmpfrJQ9
         gamVSb/qcIWWFC8SGZy/dKneWEkkyWmgkCcwzehrSX4E1zaNiUYk+YJcVhANinTPTjf3
         lmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740669133; x=1741273933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gfn+uCBojQ5GG4YhEtPCwqVqkPReqrK18jN+sTrUXsk=;
        b=LSiEu8UJ4tFRHWtlTaJwjB7mLumz4/fsfeK0etROh9YMMabRiyOQRPoeA+uULprhxc
         Qx7AdDzwNtS4ncj6SYFzdl+A4dwxbY7tTMulRvYzpdLH96xZnjYmBFfyZgaJdT3ENWrL
         ki9aM5dkx4E6bEglT0DA5+Xw93kWlhkTyKRns+DdYFVmdQf4Bf8lvahl94YN7cpblkm9
         pWaP2EQ2r6lcnougOe45siWZcaBOvqF11oMTFb7zrnU6HjbYe4poT9fNCPf3hAPM9nii
         keaVE3t1pM9qTttCJhe9WBzfPhF6/xLJ16T+KtOmRuDGF0Mpdb+Wwmuq2+DDPsALX6Rs
         xQiA==
X-Forwarded-Encrypted: i=1; AJvYcCUOlMQZ0ozgYPEEXwVfsZI3GtUAOvhqS5QmSwR9xK/YHACRPqtVe7M+RK0K8Bc/oeYXVRh7ugFIb/yzZ5E=@vger.kernel.org, AJvYcCUzBWJ0CojA573awJ+kCHsL/feLc7CSeo1eLIHgC/Rl13in0Njtj2B8k8eLThKKw1UYWoo6T0fit0y4Vw7qyVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZiU0DifDiyEytOYuTG0kZ/gpqGGzW3+EtcZbwXfqIqJkRfInI
	4Ho88yXWaKPz660HfOwUaGGeh064FuDz8qKrMgrh9Xls+NSuC06vHd0kz7WMMca8QE0TyWshLQR
	QhEJ4R0BBsdatxKd6FXQiPVPKTrY=
X-Gm-Gg: ASbGncuYhTbGFM630PNcmUxasPQgRVl0cUPnBUUhY+C1vXpR7biLoKK32x/SnrQ2er7
	WOTYvHNDzlJHY7UhzDmTNhYSn+3fTDL659m1YGESVnoskb0xtikqMzG3hEXRm2GeCl237p8wNFB
	Tg51od81vO
X-Google-Smtp-Source: AGHT+IFYBk+YziZEk93I++dkzEEbDPv17C0AA2w6xghnGW4Zz4shpUZmiwyGABiKGPFGjhTpVLPMBVow9YrGLugSLhU=
X-Received: by 2002:a05:6512:15a9:b0:540:1f75:1b05 with SMTP id
 2adb3069b0e04-5493c57ab8amr5115849e87.19.1740669132707; Thu, 27 Feb 2025
 07:12:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com>
 <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com>
 <CAFJgqgRxfTVxrWja=ZW=mTj1ShPE5s-atAqxzMOq5poajMh=4A@mail.gmail.com>
 <91dbba64-ade3-4e46-854e-87cd9ecaa689@ralfj.de> <CAFJgqgTTgy=yae68AE29oJQc7Bi+NvkgsrBtOkVUvRt1O0GzSQ@mail.gmail.com>
 <6983015e-4d6a-44d4-9f2e-203688263018@ralfj.de> <CAFJgqgTJ+GBvdkZf4bPHPoUgJj5ZzENZaLzVV2bnDOEG+3OMtw@mail.gmail.com>
 <7ab2de35-8fc8-42cf-9464-81384e227dba@ralfj.de>
In-Reply-To: <7ab2de35-8fc8-42cf-9464-81384e227dba@ralfj.de>
From: Ventura Jack <venturajack85@gmail.com>
Date: Thu, 27 Feb 2025 08:11:59 -0700
X-Gm-Features: AQ5f1JofZL_Q1A2kDOrsV-NIHTRm574zSmREXnrOEzf8tZhCp6mWng88DDVecc8
Message-ID: <CAFJgqgTeq0Zer8b1Dk0D2Cvo3t5BUTqxh_7OF7eCkLtjmm8Mcg@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Ralf Jung <post@ralfj.de>
Cc: Alice Ryhl <aliceryhl@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 2:39=E2=80=AFPM Ralf Jung <post@ralfj.de> wrote:
> > On the other hand, RefinedRust reuses code from Miri.
>
> No, it does not use code from Miri, it is based on RustBelt -- my PhD the=
sis
> where I formalized a (rather abstract) version of the borrow checker in C=
oq/Rocq
> (i.e., in a tool for machine-checked proofs) and manually proved some pie=
ces of
> small but tricky unsafe code to be sound.

I see, the reason why I claimed it was because

    https://gitlab.mpi-sws.org/lgaeher/refinedrust-dev
        "We currently re-use code from the following projects:
        miri: https://github.com/rust-lang/miri (under the MIT license)"

but that code might be from RustBelt as you say, or maybe some
less relevant code, I am guessing.

Best, VJ.

