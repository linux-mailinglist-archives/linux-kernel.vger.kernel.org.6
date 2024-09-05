Return-Path: <linux-kernel+bounces-316593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1954996D1B4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D57B246B0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB8419006E;
	Thu,  5 Sep 2024 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S8xiPHtK"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A008194C95
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523942; cv=none; b=gPPrKihcxDBNUORtCSPicYa//VfQBU+5IKWjs3JTDC47YaH68holDB2jH/XkbK0UeLYUV57QZWOtlQHYQgTdLisfjfHM/HPkayqNVByPKTY6/hrhyDyAIt+lleY7CtezlxWU/Vo5GH/XUku7/ht5vA7A/RP+FN28NC5NfQH8mQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523942; c=relaxed/simple;
	bh=rSIoNT2lPLs96YVVwRh5JllJcJJ2SY8FNEGfw3S1XSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujC3PFGXjesQr4tA0dnwCmpqTSVppgEKwfvpfvRXHdVaaVozpBt07xIm3KzGKVL/96R3PHHney+72teKMvThVzlmofaj3RFnNi0A8XiUClaspRfCpeIOsyLIjGlCWiqH30KKCJ6ccA5YFZU/++ezeFI7QvDz/j2xnVgj/8NdaWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S8xiPHtK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c3eef39eso236708f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725523939; x=1726128739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSIoNT2lPLs96YVVwRh5JllJcJJ2SY8FNEGfw3S1XSQ=;
        b=S8xiPHtK5tNT5PSZhh1Jjp9ekK1+OnLY05p9jf4OnkYlPlwIhIZ4+N1HhNFthj480K
         aJ1zPCiJ0uXVIdORH/Nx5TAnc9sS/Wbx+mrbvwkXRjBFsFM/4H4c0OyNMIGBzxZB1WtO
         rrk9+q27m7Kyt39SUj+cbil55XoHskktXq/yBKdfBerA2s6UMzbFm03PF2a1iXZTetCh
         rFtrJhuYNvkrhXfUeQVOUaLxxMTa19hy4sR07N9YUqh4pXTwv5hunbEqgXGpEOsMAjc1
         kNvi0RYQqjlR+LzooOgvChdSA9iL1YY6xWYWHRqjCEeTQwaTkVK3Da4Sc9SuCp1J3pSW
         OvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725523939; x=1726128739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSIoNT2lPLs96YVVwRh5JllJcJJ2SY8FNEGfw3S1XSQ=;
        b=nIdkAETi00lKQnBfwvt3QLiOrI+TmoKoVlOZq8qixRk/qZ1GLB4fyhkyuAhBizlBGg
         mK+9K0fzL1OmA/VXcb0AdsuSaIYzLrRec6C4Fq3RCzaUgWHjEqiX+pMXNa76Kl+Fy9B4
         XWnwOr5jyAu2LmXYGYM0mqruyzDtABHzqCAdGSgvHSzwO6J8uxZzGlEHfTXxNyFGtKdp
         8OSbwwmFRMKzZXiXTPGSBhUJhDfrVDBgE5ynDmo6hPvKW1TKu3Gee+EFCALWYbZmRkCw
         l2GR2Op+a1Svdy6T0SRgIWODloZtVs2oOPPC+rZpE2Rj9XieNqUN6w4KZSy9c1bomSgz
         d3ow==
X-Forwarded-Encrypted: i=1; AJvYcCUPT61wVW8wGKG88IPmGRVzMXZIcaPs5UWzB6ybhzAx5lomC86jXXz53ujOmoYgKByf6chgYq7POSfMTAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyUDeqqyynRxjajzl5pbaWQEhHajq6ACl3Um7kOgHO/6n2eQPa
	lFjgEbqj9b+pfaqdNf92nHrH+g5D19bPf7XTLvv0QsyZo5s9hc9Nrpr/UAxJpEH4at6rG3HStRd
	hGCpkQW5dmXSDYXGPPAMKb3O9+x/XyJbpGdk8
X-Google-Smtp-Source: AGHT+IE62Epsi0v41kZrmq00wKSCQR34/0qV3MJKgYftCiq9+X1v5PTgR44xXkcmKdvrW/zHlM01xfs3FnBHh4EANoM=
X-Received: by 2002:a5d:424b:0:b0:374:c64e:3fe7 with SMTP id
 ffacd0b85a97d-377717f4f33mr3567902f8f.59.1725523939035; Thu, 05 Sep 2024
 01:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-12-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-12-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 5 Sep 2024 10:12:07 +0200
Message-ID: <CAH5fLghOG3tSySfn4vnxU7v_Y26ZQcerQT7-4pUJZpYv1zGM4w@mail.gmail.com>
Subject: Re: [PATCH 11/19] rust: introduce `.clippy.toml`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Some Clippy lints can be configured/tweaked. We will use these knobs to
> our advantage in later commits.
>
> This is done via a configuration file, `.clippy.toml` [1]. The file is
> currently unstable. This may be a problem in the future, but we can adapt
> as needed. In addition, we proposed adding Clippy to the Rust CI's RFL
> job [2], so we should be able to catch issues pre-merge.
>
> Thus introduce the file.
>
> Link: https://doc.rust-lang.org/clippy/configuration.html [1]
> Link: https://github.com/rust-lang/rust/pull/128928 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

