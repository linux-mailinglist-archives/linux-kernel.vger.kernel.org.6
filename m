Return-Path: <linux-kernel+bounces-312629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB1296991D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD9DB29157
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD6F1B9849;
	Tue,  3 Sep 2024 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/oW7hIi"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58CA1AD270
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355833; cv=none; b=dO6Knz8RxnXcCMhT2AyOTQIV9rnaNOv72DDXfpLdxXTHBHI4RUrBC4taMk8/Bcap2yt+sPOAo4G1ZjgGgGi+BhcofHwaUqfmCbDqk1jJ+XpfV4WsanYdxqJRxWJOss2G6DmGGq0DBH14jaIlfP3866m8zdOnO6eRphXoynBm1sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355833; c=relaxed/simple;
	bh=GX5ZZXyvWa0yGb7R8h/1b2TOpRvcfTrEtH0LDTqF0Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acQcd/u48lIqpgFX0b+erVSXUUnxsk5JjQSmCfk5ocx0R+p8wh52KMT0iWeo2pWyrw7vT8GiPL7RdWBXnxPLBCorROSLzPnjFo5w0zJY5cMUpgSYJ7F2JtMEtvZiF9vicmw6stMIhlroXzSzql//q/IdKgNXbADbAHipM/cCoPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R/oW7hIi; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso42089685e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725355830; x=1725960630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GX5ZZXyvWa0yGb7R8h/1b2TOpRvcfTrEtH0LDTqF0Lc=;
        b=R/oW7hIic26SAKg+zT2DqDvgllZJdBidGT9pr6PpY+IjYxBo0imhd0DMJRivmYrfzx
         nKuHPJQpml6/ILzHyX1wkRsGPSfBf5jFCbEv7fur8yJKOPRk3Ajl3hXUn1iSHl4IqBfv
         bGAefJivqSf1zcAn6RYa//fXK2rxhOZJNLrT1fMzVrRgyJ/b8GbFVpgP6H0drzKQLqxa
         WsJYDM7+JBgZZGMryCP3WwxlG8qKYMKE1aetrIop1eTPYTNxtVvz0qX1Avqt+rTVY46j
         UMoZ3Gz6vmQG91QavkwsAzZy/Ho3LxM136GUXb52uNruWxGL3v3gThTgTegm3cojQE+e
         6ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725355830; x=1725960630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GX5ZZXyvWa0yGb7R8h/1b2TOpRvcfTrEtH0LDTqF0Lc=;
        b=XJGJY3KchF1jtL5wQFxelYdM6WRiT8MvWAz34lftj2RoZUTbaZ4L9QUZLZg8scFreV
         7r2BN3SnkE5MdNPEg8A+phkG5LxX/gntIahVcHnSFX8181bvEGIXCYY6n3OSqTT2lsBt
         4+DFQc2PI8igBCk8MP3kKN/g21zDtco1ANsDyE/NqOVA7iuh+ades4wDg3ujATaXFpRO
         Ia5ODwWKty25LDHSVyWM86iBplrz3UtF9qyO1nEf/lW96Lmc5rJt6ID5ePiMuAp4guw/
         B1tHPPQeVBRSCUASvgkjhOKuMMWsRDNxderq+1RTRfr3DcRBxulzHOgOG/nBIXN7yEOg
         Sv3w==
X-Forwarded-Encrypted: i=1; AJvYcCWVIzhh3nw0EhqO/8xEvSNPigbq4yRWRfCHBYwgTcXcs5/N5zohzuyAQPNbY2jHrhePgfCj7ZY9TP+29xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQS6mdI8RJhWJJYlsHqgxHd0amPNS3GYh3u7mVdPVVw6yRZ9BA
	gl7vTXcbKvoEo5pBiFaxd/wGV7vI2n2CK7hqHRNpKPXD74FK/FlR1nPTT3d4LzN6bUK2ysHnQ4F
	0MgQiVHEGEsE9SSyzhEo55X0QSCFaVpZOa1Wy
X-Google-Smtp-Source: AGHT+IEStut0eCsHI0DJyv+WcU4/DFOb5+cqPAFzWOXkNnUFxED0ZPmrR60Fk63iost8Uhe3FPANLlMBj6BuAnyCFyM=
X-Received: by 2002:adf:f08d:0:b0:368:785f:b78e with SMTP id
 ffacd0b85a97d-374c94554camr4058991f8f.13.1725355829775; Tue, 03 Sep 2024
 02:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903091700.172734-1-benno.lossin@proton.me>
In-Reply-To: <20240903091700.172734-1-benno.lossin@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 3 Sep 2024 11:30:14 +0200
Message-ID: <CAH5fLgihM6OeuVrAhSXAqb9RDKBa8p7+EOsFuuqkGu-OzoapZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: sync: require `Send` and `Sync` for `Backend::State`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 11:17=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> `Lock<T, B>` implements `Send` and `Sync` when `T` is `Send` or `Sync`
> respectively. Since this does not depend on `B`, creating a `Lock` that
> is `Send` and `Sync`, but with a `!Sync` or `!Send` state is possible.
> This is a soundness issue, thus add the bounds to the respective impls.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Currently, B::State is set directly to `bindings::spinlock_t` or
`bindings::mutex` and these types are pretty unlikely to be Send/Sync
on all kernel configurations. If you're going to make this change, you
will need to change these types.

Considering that B::State is already stored in Opaque meaning that we
don't run its destructor either, it's not really treated as a normal
field right now. Perhaps it would be better to change the safety
requirements of the `Backend` trait to impose restrictions on the
thread safety of B::State?

Alice

