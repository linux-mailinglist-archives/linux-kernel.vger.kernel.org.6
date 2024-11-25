Return-Path: <linux-kernel+bounces-420738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6E19D82BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4B9163D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB10F191473;
	Mon, 25 Nov 2024 09:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iHiHUsXg"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC382500B4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527925; cv=none; b=umSM9YByl9P8FdX9mLwQ5UULH880C7FfO6+NsJoeHvELs0uyuoFFdpOV8esZ1ppNyB6xBuYZAyeGe9UOADyywTaPBXeaWFvFf3UZgxT+amdh0t747mLojWPt4spp/roOf/bIjj7cYavaiQm3cyEC75b3xfYc0qU3cTvq0lZ4FuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527925; c=relaxed/simple;
	bh=8GWbrppTY2SdRiB8p/3spnrWMuOqZHHKbGVh/ni1TaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkW6AlSbD6tPVrniOvvfsCqxbC7tlgooEUkJM2zIk6AW3VBky+PZ3gxZuTHysqGK3htGAtlgtdHo9Pxf3XmEyc8XdGNNdF1EtRy388h48gSlU5cnrSuyAiEjKMi5/P0FMxmegH1jubrXiXkt/suBV7vJtcV8WiFPmhCWQVOhAHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iHiHUsXg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso38256665e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732527922; x=1733132722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GWbrppTY2SdRiB8p/3spnrWMuOqZHHKbGVh/ni1TaU=;
        b=iHiHUsXgm9F0I6pbuZ/u9clJWvcF5/BTBJ3SlzENgziOY4b03DLli+kn8TgZHQy0mS
         ZhA6bxoO/k6M8wTGPk9Jpc3Cxh2v41S3ESzvN03jkl+mhgL9rYtGtv5XEsSYDYsAuh0l
         ViPHt0xBRzD7G8x6JNIqToLHWIKmnLhd0ELk/5R1nIe/NkVQhToF2EYa2eaUF2wjNkQ3
         tWmVIaXMIUU4dsn05Y9LJSSAPEypqP4Nk2rBLweGm1XjYc5ruiRD8TXb6MeIqweVrS+3
         cLx8LlhGQNGOkEoe3crTOTLQ+U4iaRwEMbb9nLNaxSCs02szSAvvyH0c0iCS8/3YncGc
         0thA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732527922; x=1733132722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GWbrppTY2SdRiB8p/3spnrWMuOqZHHKbGVh/ni1TaU=;
        b=tmbmzrgJNAnUGwk5651wRBTqH7x0YOVVbmHNJAeTlLc1/ZC6ADOWUsH2oFfjP+D5WX
         7QyRnQS/0tSQ4eEzkd7Q2Tmyng8eiamtOOeAARjT83riFn+77K9V7svPy7Uyw4gejl87
         e7C3uI5qcua49KxLo2vUI+/wzVQz4IV1HNDZCcbswyxymNJzluiEGvZ2J6eLUlSwoRvy
         mEuVMxTNINwGERtdoBGlofU+Z3bRFZkB98qACTNPXhbvVyvsBdeKwsU/lxFgZY9vFGga
         /dYjWeOaKzsvXECDBm8F6ErUS0rDQN+uW4ogApwqPJcQiQI5pXlA+NRuv+qmX2vPU7pv
         KwqA==
X-Forwarded-Encrypted: i=1; AJvYcCWAcAmk/6QdRnQWzh6eGUJqZySus5wDxIkp7G/RflHtBagbvJvvMMtjp2TFfDNfLo6clenXO8Hidmw3sAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU2nzzOK2eOvB2d332Ep1SA5K705bGN/3ciVheZ3jgw6ycn9Mh
	Qm+NpGYhAIGNFjfC38xGBck65cUA0dF2I3unkYj3K5xozfOkERpqWvSzoQTHLod7S1L/vaQbu6c
	RJQVoCYQw9I4RFNVJyhyI8Gh4MUVrapzvLbnb
X-Gm-Gg: ASbGncuaSeg+x+WBmM8EbIXxDh5ONBIYw/QMIAqrFsi7gAK3Mt9HPiCoxW0c7589mq5
	qTM1sNOy/1n1OrxLcv8En7y99TXE/q1kvTaMcisg3ykW5OriDmP6QvqG9AwhqbQ==
X-Google-Smtp-Source: AGHT+IGMe//ja59s2KtnkXWASLS4/7cHUSPDFQmfLfQzEv/lOhx3Gg//+rAV5dCcd3lozbWK7n3eI2qxPCsTUq7WPdI=
X-Received: by 2002:a05:600c:4fd1:b0:430:52ec:1e41 with SMTP id
 5b1f17b1804b1-433ce42845fmr110108165e9.17.1732527922183; Mon, 25 Nov 2024
 01:45:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123180323.255997-1-ojeda@kernel.org> <CAH5fLggg5f0KpaObVtZc7WaxHjUqbhCDsn5CwnA5-3df2HEjnw@mail.gmail.com>
 <CANiq72moPEL5s0T3ELEDvWiE6Lz5oZv2hZnziV5A60EP65bkkQ@mail.gmail.com>
In-Reply-To: <CANiq72moPEL5s0T3ELEDvWiE6Lz5oZv2hZnziV5A60EP65bkkQ@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 25 Nov 2024 10:45:09 +0100
Message-ID: <CAH5fLgjEDXHGLf+fAyzZwGtX+sjuCst6P9Eg_eyLjujd2datYw@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: set `bindgen`'s Rust target version
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Christian Poveda <git@pvdrz.com>, =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <emilio@crisal.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 10:42=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Nov 25, 2024 at 10:08=E2=80=AFAM Alice Ryhl <aliceryhl@google.com=
> wrote:
> >
> > Just to double-check, the problem is that bindgen currently doesn't
> > get any information about the rustc we're using, so it may generate
> > code invalid on the rustc we are actually using?
>
> Exactly: it doesn't at the moment, but eventually a future release could.
>
> Of course, people using the latest stable `rustc` would likely never
> see an issue. But there may be people e.g. building `bindgen` on their
> own, and thus likely picking the latest version, while using an older
> Rust toolchain from their distribution instead of, say, `rustup`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Sounds like this might need a backport to 6.12, to prevent issues
appearing on the LTS in the future?

Alice

