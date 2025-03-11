Return-Path: <linux-kernel+bounces-557000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C803A5D22F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC6F17BD19
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A38A264FA3;
	Tue, 11 Mar 2025 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIHeJ4+T"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D6222425F;
	Tue, 11 Mar 2025 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730448; cv=none; b=NexZX1aXzu3BFIPXB52/zapbgFSlDmCPHOuMsGn6BGt/7E9aC3ja5jBlVNahGtxlYSQ77/msBCNLLkRIgZCJ55ZDraAo8jkCHUL7SWWF7gOftMODcf6vGLrxcBYTL20VMPcwFhZX2ViAcqUK3jMPCXW+BLjV8sEUjXD+Ypuq9SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730448; c=relaxed/simple;
	bh=Rneh6RCXI7eVbgvGNv8c52GLdcTmVoxm9gAf3PKEjuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbXzzRj5XO0hH3karzpDBu7ZzODWFI6XFZB/LC7yj2WL7EGzf9jRBCyigJ6am9+XW/8CBIZ/pxXvYfxIzlo93DKK3HggUWc1qiYuRGCWhcb+baRMFbpUq7Vxs1zV8ldvIDZY4XtRIDADXcTYbxlH2vIHcPQG3eDfv8E51E/7jTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIHeJ4+T; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff66327419so1563711a91.1;
        Tue, 11 Mar 2025 15:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741730445; x=1742335245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rneh6RCXI7eVbgvGNv8c52GLdcTmVoxm9gAf3PKEjuM=;
        b=nIHeJ4+TWZ3xwAula3pYJZmFPAqRYqx9f60FqYO8UNNTRLwXTMU7A67vB3LDrByMwH
         SIuM3P+YzG4vY2xOWM73kVZfq2gHh+kEZbLDOHBgpqYNYMiTiurNuqyZHUveF7n0ohD9
         SRBgA2dhQJH2RkY73lthBxMlOH2OiLCpy7hr3r0dZne2ganSP6Qdzf0FF9TDsWj1V4zf
         GECnCUd24RP7uu4S7WXazUCE8xx9TNE9w378s90zCFPtkhLTjg1+S4miDFkr7UQJwO10
         /dG6vNcYrBf3Y8LjmnzljcTgg8abPDNGTFJ/GSPIJkSfI8kpFZTpVSdIKrMJ4u3iHmz4
         22yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741730445; x=1742335245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rneh6RCXI7eVbgvGNv8c52GLdcTmVoxm9gAf3PKEjuM=;
        b=kFGcGaVORENbnUF78It85ybGHmi14H5LWQ77LzWZc0p+N5kmn2XvwJwLmNLAwL0cT6
         AQPLgr2h6iKDOfbhJ3jp4clazzn33s9MpIk938Q+5Btgjdxb2v6YPyejKeGkUIfcZ45R
         p4F+Muxg9msrI7K+3UGoh2bxg31/COSpTCBD4GAWDwxr6nDOQQsI8vH4ewLq9aF8hHqw
         PnsGiPrqW25f0LGFOozu0QGm2etxdqqq5aSiXrR3QXS3alKg4dI6dzbrgsDg+L6uTgKt
         sb3AoHdjRJuxbw6tjCE2WYTmcVsFr+E4rxVs9ij6QJwx/yJFnGBM5wuqrCEShzhU7/oY
         URNw==
X-Forwarded-Encrypted: i=1; AJvYcCW4wnVthjik+2lJ+HCn54oFBKUCQl2joxrcz4GA4noe0niDZSRxUs/iu4ZeINhJ97KWGKe2AYE/tIaTq7o=@vger.kernel.org, AJvYcCWvgMRGFbCg9CLhsjZxoB91OOL0VFgMKL/jqSX7pqsYblJEn0CP4u+ovQTUemSZBXAlNmrYh5rHVdhQp86Wx6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYIOGF2bxeebKkZ7Yoja84gN8juE9A/f9LSeAkzT9vwuEPELHw
	lQz1Mg9KShSmSQ2XOqlmqiyy/SZ2LC2Pg3i0EbZXVt0DLJ1fgaS0U5+jz2O88s0tFONbWKDn2pZ
	FqoAppzzTpjQcXCBgwylCrXG64cs=
X-Gm-Gg: ASbGnctty9CIwvxGcCgjlxDpjWffWT5lS6ywEM1MT5cyhZW+h3Ik4xKvCOLN1r+G2d8
	YSBk9K2Q7hkFjOEazogvapMZjnVDpcjrwnITg/lAcj9lKc/44I1hi/bm/3K/EWNuWETl9+OKulv
	teUxbr+dk0fgwgAOOCcNAVWCFh7g==
X-Google-Smtp-Source: AGHT+IFlE5YIuDYHDZa8nRrelvV0jwCZ3acNZPl6icSJLZ4XBzWjtq64xn2dz9xNntqHG3w1fsEMNU5ZWTgvbA1wEXY=
X-Received: by 2002:a17:90b:4d8d:b0:2fe:91d0:f781 with SMTP id
 98e67ed59e1d1-300ff724478mr2471430a91.2.1741730444778; Tue, 11 Mar 2025
 15:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-rust-analyzer-bindings-include-v2-0-23dff845edc3@gmail.com>
 <20250210-rust-analyzer-bindings-include-v2-1-23dff845edc3@gmail.com>
In-Reply-To: <20250210-rust-analyzer-bindings-include-v2-1-23dff845edc3@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Mar 2025 23:00:32 +0100
X-Gm-Features: AQ5f1JpFBu3sU8smtONUMJaWsoYZFqlOwNk8Ue4Zygb6CVCM0-PD6CRvhECF73I
Message-ID: <CANiq72=YhXGKLuEfvK5XnAsc0sbuf4FBRt_GnzmrZoW_L-S-ow@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] scripts: generate_rust_analyzer.py: add missing include_dirs
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>, 
	Fiona Behrens <me@kloenk.dev>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Asahi Lina <lina@asahilina.net>, 
	Boris-Chengbiao Zhou <bobo1239@web.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 7:04=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Commit 8c4555ccc55c ("scripts: add `generate_rust_analyzer.py`")
> specified OBJTREE for the bindings crate, and `source.include_dirs` for
> the kernel crate, likely in an attempt to support out-of-source builds
> for those crates where the generated files reside in `objtree` rather
> than `srctree`. This was insufficient because both bits of configuration
> are required for each crate; the result is that rust-analyzer is unable
> to resolve generated files for either crate in an out-of-source build.

Originally we were not using `OBJTREE` in the `kernel` crate, but we
did pass it anyway, so conceptually it could have been there. So I am
not sure if it counts as a fix for that commit, but it shouldn't hurt
even if backported.

Regarding `include_dirs`, it started in `kernel` before being in
mainline because we included the bindings there (i.e. there was not
`bindings` crate), but it should have been probably moved when it was
split. Nowadays, I guess we still need it for
`generated_arch_static_branch_asm.rs`, or is it something else that
needs it? I assume it shouldn't hurt, in any case, so it looks OK.

Cheers,
Miguel

