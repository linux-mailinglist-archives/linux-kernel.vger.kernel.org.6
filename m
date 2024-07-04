Return-Path: <linux-kernel+bounces-241345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6486D9279FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DEE528277D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0308D1B140B;
	Thu,  4 Jul 2024 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGhj3S83"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2081AED31;
	Thu,  4 Jul 2024 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106809; cv=none; b=f3hoBWHenIWOozvfgvIKYq/hM/IeTtJSt4XJ0OAc1VBKLOrv/o5Jtxl2kN6OlIAaD59zWDtYET06ILNl73EKlP/+FQvr9+g3mf9acxrmxQNbt7i+EQz5hJNed+oe/W9B1D2r9UbWizGne+XaWkb3TDDOkxo8Aul8AhGBK48xmFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106809; c=relaxed/simple;
	bh=MSME/Bhyf+gYGe96NNTB+BN2oAnq+gcEg2DaDsIkQ6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXjziM+b13K7VLP73QayZ245b/UO0CdiPHgoo4B1PHOtQNi0GO9eilWTMuQGXdnCfV5EeBcree0fl87rT3iNUx8jXRSkALIuQT2opGpJa1c8Ohfpb6yI6bMGsk2n04YXGpPWq1Bnj01DvEZ3WzsrpXYXCKmKQPYsFUpOHPj1eQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGhj3S83; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c927152b4bso550560a91.2;
        Thu, 04 Jul 2024 08:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720106807; x=1720711607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSME/Bhyf+gYGe96NNTB+BN2oAnq+gcEg2DaDsIkQ6k=;
        b=cGhj3S83tUm2OovpcQBrIjc4dAarTrFbygb86B3v9DNHpQAQFPNzQ5FnzJzm5lqtNZ
         yY87lFOVy4dNFz6hb9X33Fz3rgTvxbxZUDgYWzsnyS7CRX+BhXYNyKbkP0QyoGRFpGEV
         qHGSY7HVzMeDIpnzC6YDlXqmu6XFTHML+xcdK6Wdc1mddqdFTV9p+p4igxyIsyrrwrO6
         bdBdUClql1dHs5T9c7qz9+f+ztDZcFQ2K+ebKAfWOSn/uUvuNS7vd9xha1FDCpKGBEwc
         V9fB99BiM2hYYsWHlNm3Jn561Xi1uu+o8u4OY3OS0VSKFmywX/S7NyFfErUpEbHR1yiu
         CsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720106807; x=1720711607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSME/Bhyf+gYGe96NNTB+BN2oAnq+gcEg2DaDsIkQ6k=;
        b=jgi0Fxj9hJ3Ny9ZBU3euj18cbXzgvyfNMKrq7rLpki3pD8Nio6ilan+nVBd8JoWFzA
         AvPtU4VnNzeaeQX/AAebsr1sr25mZhHks+sE1JQVTx8jOVc7NvB2ycVB06pRUsN/TvMo
         9vXglxpQp9PxBsvT3E5yoyTlsG/onyQ8BEssTjSXTh0cvJgFFOSo3g6ngbFOF8KuSuhJ
         ULZYPNdoprtWOlQc4qfCdYzji9Ml3BZrzKy085Zvoaw3NxKZLlatrY/mGi8PdU19F4Z2
         isixId8KnRCQyDuvk6ESS4Of22CAureTeXfdOAs5vgrUAiNtq7zCgjWAcK+ekeXQt+L9
         UZwg==
X-Forwarded-Encrypted: i=1; AJvYcCUOLo01VAcu19Lb15yTEoBE2bhnYpsqiRrmNuqsVmLe76OFNPMhBMmg1HP8h2gzY3EPBh1fnpJv956XcyitwtNapJUR43/mX1qJFYdLb12g7q0AARWgsw0meJlGzFcuDn6di/gYyVSozsFEdEM6tZohdLicTvYm/K/3wEfjKfVOrMUMrXnjU8J0XK0tCkULWTeTFg6HMYOwhwBHHoHZyAV9R0A=
X-Gm-Message-State: AOJu0YzgTkHAbi6I0euDBqAkIKLlUbpyrH4sfWJtrlTyzYDjGFVBmWfA
	onj1UO1y4cbm3hwntVmf6sRN+XJdC0rVbkQM5NEapmTmSKTj8XEAJghyv7Urv510N9vLZWf+FTB
	17mUz9t8KnW5GF/8vMOQkUskA2ao=
X-Google-Smtp-Source: AGHT+IEkUFA3sOH4ngyuIImRoRx17p6zqMQ7VBlnOblzn2dve9nvHTgy9+zJPLllYLzX1QFWuCt41+GDCTfChLoPZSQ=
X-Received: by 2002:a17:90a:b88d:b0:2c9:98c2:f6d7 with SMTP id
 98e67ed59e1d1-2c99c502d4dmr1502962a91.5.1720106807206; Thu, 04 Jul 2024
 08:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701183625.665574-1-ojeda@kernel.org> <20240701183625.665574-7-ojeda@kernel.org>
 <70F3F3DD-AAE6-445A-AC16-C71A06C4EA06@kloenk.dev>
In-Reply-To: <70F3F3DD-AAE6-445A-AC16-C71A06C4EA06@kloenk.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 4 Jul 2024 17:26:34 +0200
Message-ID: <CANiq72m4Js+ym4Tuq2sNfVGyxPqx=pZ4VK455dfocd8OuuZUxA@mail.gmail.com>
Subject: Re: [PATCH 06/13] rust: start supporting several compiler versions
To: Finn Behrens <me@kloenk.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 4:45=E2=80=AFPM Finn Behrens <me@kloenk.dev> wrote:
>
> One idea below, but fine with or without it.
>
> Reviewed-by: Finn Behrens <me@kloenk.dev>

Thanks Finn!

> Would it make sense to not advise the min version but the =E2=80=9Cmax=E2=
=80=9D or just latest stable version? Min version should work as well lates=
t could potentially be a bit more optimised if both work either way?

Yeah, that is a good idea -- we could just say `stable` there.

In fact, it makes more sense, because this is using `rustup`, i.e. the
Rust-provided binaries, and the Rust project only supports the latest
version (so far -- there are proposals about LTSs there).

Cheers,
Miguel

