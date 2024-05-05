Return-Path: <linux-kernel+bounces-169184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6378BC48D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 00:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C930CB215A4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 22:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47F413FD88;
	Sun,  5 May 2024 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDXmyFmb"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E33E48F;
	Sun,  5 May 2024 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714948516; cv=none; b=mHTSQ/IAAOqhBDLBraMSSmzRg63tO+P/rTA52y4RnTCdflrbly0B/TLZQ4FILVg7I7KkAiVEWxnfMx+3n7ZESukr9DrAmP7YvPilyK3Do0xPrY2zmj+o/RDixNnxu5BxN9m5Ez7xxzh2QFa2llrQybf+6cFJgafdpzt4iliGrHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714948516; c=relaxed/simple;
	bh=5nyiTBRMziL6N5Q12s/U+aXAf/VH5cNzREjrocYZTLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kmryf3FB9RiN9vHPKf1WGLC52wxmfkYj396mZfwe8OxKlNwxs3LmjcN+kSIkNmVa8ujxc7QHOHZA6S3GcifJluvD3Wg5RHyRxm3VcWaNGR6ilsPKMBClMGKvVFXAUcrxGYcGwrqv+calvtLhDOVSFrSr23H/NGKFXynb2pghRe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDXmyFmb; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f4496af4cdso1021676b3a.0;
        Sun, 05 May 2024 15:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714948514; x=1715553314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nyiTBRMziL6N5Q12s/U+aXAf/VH5cNzREjrocYZTLc=;
        b=FDXmyFmbyHhhqhDfCoT//WGDTteNYt2nQE5+SuJWTGTZ5Rn6kbjElDfQOA4vVsJo/q
         NpseHVNh2hzg0IR36L75U1fGvxD981qZYABgKfLq4afiaWvPYhsXtk5xG1RDFXkH7PeJ
         uuaovVPM9rD0ujRugNe4xWOI4VZMOMk2cdMiCfWXwif7PgfHxQs45Y03JRCfMo+SD5Lx
         HUBDzIEUW8YyugZNunegHVYOT3ZpX30WwNG+VoAEzKdEFmV7AsMfJ5QNqsRIQcobYI93
         xqe4QA/69fmCVBDrj2LwfeY1UOICv8RYYjiBkwHR/D6ZIyZIpRtHgTqEmaZF/rJU2lre
         Xnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714948514; x=1715553314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nyiTBRMziL6N5Q12s/U+aXAf/VH5cNzREjrocYZTLc=;
        b=RE4cYSmeKE61tCcgLiLFrTgZmKPm7zz6kzUM+ZhyfoUlnA8eJQgR81D6QvU/jVvnMX
         gv1HJn1flHXCGMksJA5Wmjy1tU/qujAbdzmoniv8pCt/nqGAueCPXFFP4pCl85hgn7kY
         jzua832x8wTlHOYRJdHlyTDuS9mSeuQbLdyJIw48gyHOEzPubFkGYI8xFqr3wL5pD3lY
         7hsCLA38PLd/JXbaV1oaZBqgMUshf0481EUZ1UpCAoVpS1nDCesB3VdSyXBr97+hGR2Z
         ungzztTeaKBwzZmmGfBySMUUJ3EerG4Hi/GgGl3riZX3FvbnD4Ho0Vv7r2UyLrO2MOqs
         NNXw==
X-Forwarded-Encrypted: i=1; AJvYcCXaB7KcU4cLHepEnp9S74EMJB3LgZhnSpEVbab3e1aaswzhpImaknCjmh5l6IcE3trSUkjSR9502OTxT23bJkOA289cd8B9pnn6Gr38OEwWiGgw4GnnqdmJAp0Gxew4WHjfDl0WHXRFRj6KWbE=
X-Gm-Message-State: AOJu0Yyu1NmqdbEdhf+7R4cKFCANnJD3N0o1BJaHk81oVnIkCWGHn+t7
	357Oyzg4UNqb9Ep17d/auc9f74eKSw/frQRvhngZULQOSAsNPjOKFsOUUPwo9/t9sIQUWmnsd0+
	7isz9iDbFtjNN8SYOrHwGcIewNHg=
X-Google-Smtp-Source: AGHT+IH7PuoU5b3Xs8+VHP178x4FKbxo1mR1uv20n2JhJfudeVeUD+yvCcY54OyIjFzbfc7HxxFfp2J6S3jj3t6jMI8=
X-Received: by 2002:a05:6a00:1483:b0:6ed:1012:9565 with SMTP id
 v3-20020a056a00148300b006ed10129565mr10204972pfu.15.1714948514184; Sun, 05
 May 2024 15:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401212303.537355-1-ojeda@kernel.org>
In-Reply-To: <20240401212303.537355-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 May 2024 00:33:49 +0200
Message-ID: <CANiq72n4TuUbKZGNEWXVYKj1f0B8KgjXntVg98FuthiqwVjk_w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Rust 1.78.0 upgrade
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 11:23=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> This is the first upgrade without the `alloc` fork.
>
> In other words, it is based on top of Wedson's "Allocation APIs" series
> [1], applied on top of the current `rust-next`, i.e. commit 9ffe2a730313
> ("rust: str: add {make,to}_{upper,lower}case() to CString").
>
> Please note that Rust 1.78.0 will be released in a month (2024-05-02).

[ Added a few more details and links I mentioned in the list. - Miguel ]

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

