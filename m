Return-Path: <linux-kernel+bounces-421236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5BA9D890A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2327B3EC4A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15791B218C;
	Mon, 25 Nov 2024 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j89huD/p"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A386D1B0F29
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546195; cv=none; b=g1+xje2MmxMLmU080f87skYxM2khdqza6YnjRaAIr1rzMKpOBZqDeVOsnTVj6egs9Y7ynYqZNN5/XQr/5GbALmeF4xux3OevOHjYsyqL9bN9PEDRznt8+q6X0izPoO2Je8zXyH5zFY09IP62Zh4OSNgQr8pV1ThL502cmLdyYRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546195; c=relaxed/simple;
	bh=dAbgSjlE7BHjpYvWFjjFe/8qIbtpsQbBqeKvdjt4idU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJtNSlvv2zu5xiMfnG+D2KfH3eZgRuR8TZpHUvXDUopOown9Hwlvbsk3kAuUyWB9dMpamJb5JFpJVFylpIgWKSLgJ4cuLyi6k6yWYpgMZ1NrFLV+32XzqM56KLsktTW/XUq9yHB3koFU68oMaT2wHgVMDvPltSev7HjpcHhQBo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j89huD/p; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3824709ee03so3252093f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 06:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732546192; x=1733150992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAbgSjlE7BHjpYvWFjjFe/8qIbtpsQbBqeKvdjt4idU=;
        b=j89huD/pfFFRnQPGafsk/B3KJEC88CyidqpLHlpfRU9en/31tGhjb93nQuStw7GLVE
         UmfYI4DYiYUao/x4jAMr0CxYLGnMdaOEMuUoaiWJny//2NgJZLQgNA0NSXnp9GK6P2uP
         qbrmoAaY9UlBRPxJCSN+hDtYF1q6mdWsDl5CNRYpo0kX+/wKb6xSi9QmGiVLt76T203k
         952zErcV8HOdc+nQ74vERV6OPNna+jSVeINjF9eIquYsurhSb6D+acj4Oyf3oEH8oWhx
         xgARZo8CTu6f1bw94KvAvy0QYrfhvHm3TgGYfE4MPRQDPQ1aiQG2aWEn22OjDqixYn74
         Iy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732546192; x=1733150992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAbgSjlE7BHjpYvWFjjFe/8qIbtpsQbBqeKvdjt4idU=;
        b=xDkAd+yGk3UBLTKplmeykrAN0vjJ7SmOZ0s4HV8RTmEzHiZOm++Skj4AfvbsptsPlk
         yB9doO2HOrG07rHf19t6cPhbS08eLiIegjvm8lJhdji6F2LCR0TliFk/tC718A11gJfH
         7YSQpxKvcmEMhMmk6mRPB3RCKJTbDaNCaiitdfxYuccxZFpAo54RbnYSI1Cb3VmALxUX
         2XYMtSK1Vsv61ci24Tfox2isOicqg48EI0mj0bRhIEWPxZKlIYwyuIbkqq9MP0rUZw73
         Wk3nOm5l8ibfNmftEVlZ+LM2JRIWsxzvvMbqW+R4mh1T+opLwEUzmX43fHnlV0SColka
         WdaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPhx26K5zMRMSB9NlVxBKlCDtL9fGRFTrL7ohWMNNIALFU+lV4jDNlB7WcJJ4CVSmJrPkaK56MpdttHSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJfGmLXgDuocEx994lCMIufBm0b+om/jc28eR/Kzajf+93U++J
	HvbFD6xkzxw64YRmt19839bKh/wKvF72U8a82i+i0fTaFy0Uui6LOJCZC0gyrx+59WqokScKVh7
	KHlL0c83wU81MlXd1nuqC+qRBMkn/ELEZxU85
X-Gm-Gg: ASbGncuqBcy73vRW5U3V0TWip+dm3+TagnUcPVx2xv0KfkObd4jIfFvKQUlVLgIHh+n
	enZQFHv8TOSteX5BKv1SknTofVtSvkqCxmtUfmnAwoc3+4gkeqIN2XTV+ntnPJw==
X-Google-Smtp-Source: AGHT+IGbMI2V5UG4TYQHXXcHAsi1VbCR39/nAXqnjLOsuCpADZz06hxMT0ZmK3OIPpNpQ2qz6heO+nOGG8nweykUffo=
X-Received: by 2002:a5d:6c68:0:b0:381:f5c2:97c9 with SMTP id
 ffacd0b85a97d-38260b75a12mr11739482f8f.25.1732546191871; Mon, 25 Nov 2024
 06:49:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-rust-xarray-bindings-v10-0-a25b2b0bf582@gmail.com> <20241120-rust-xarray-bindings-v10-1-a25b2b0bf582@gmail.com>
In-Reply-To: <20241120-rust-xarray-bindings-v10-1-a25b2b0bf582@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 25 Nov 2024 15:49:40 +0100
Message-ID: <CAH5fLgjpE7a1jy+W-ZdscrR3D3FrO21iVNd1L-7WY0jGcwQ9mA@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] rust: types: add `ForeignOwnable::PointedTo`
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 12:48=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> Allow implementors to specify the foreign pointer type; this exposes
> information about the pointed-to type such as its alignment.
>
> This requires the trait to be `unsafe` since it is now possible for
> implementors to break soundness by returning a misaligned pointer.
>
> Encoding the pointer type in the trait (and avoiding pointer casts)
> allows the compiler to check that implementors return the correct
> pointer type. This is preferable to directly encoding the alignment in
> the trait using a constant as the compiler would be unable to check it.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

I'm not super convinced by this way forward. It introduces more casts
to/from c_void in code using it, and forces us to expose internal
types such as ArcInner. Does anyone else have thoughts on this?

Alice

