Return-Path: <linux-kernel+bounces-358552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 905709980BC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE1928438A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B17B1E3DE6;
	Thu, 10 Oct 2024 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFy0h6Dc"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32131BD512
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728549467; cv=none; b=hx2tv4LkTrXd6sD2VTVU4lcIboRIMYPmdAlTRLinPAYcnqSmMl+c9FuxkF+9Kt+D2SMJ1bNi+NTryjiCxuAMcEvSiyTKcGFCy7vw/gWSObiyFIibGFwZ2JP6hEedeYn/zY6cqiH6zNcZZsB3Q9rKJJt2kBm6ouay6oA7l6sFM6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728549467; c=relaxed/simple;
	bh=9FMviRvNNGrKMjQx5y7ab9W6PoN4yQqeRZ8Lp8AbVgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvVp0O5coZg/FNly8DpBzikCMBrVSRVJSXDCqm5wwQaMTk87ObQrz+MRuI9jSHqvlQzNpmfwGWNqpukiuLEOaIJsTKrZCa/1MRP+JcTR4OdczjhG7ZzLdOdv75EgPyh8MFUX4rqkw5HM6mu7CRW5HIOIQ8TQ+62Wo+5FdufwkYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BFy0h6Dc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4311ae6426aso24955e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728549464; x=1729154264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FMviRvNNGrKMjQx5y7ab9W6PoN4yQqeRZ8Lp8AbVgg=;
        b=BFy0h6DcR8nSGgmSWEuxrXFyaIFynw2OIlr7YXHhNKX04RHGqMCrpMkwQk3pqp5ksK
         AIafqA6QVNpST635rGdf3vAE4w/1HunoTCkUrTjze+1zRGMFhs2+v5EkxjMCG3urpepM
         e8IH1mr111RmglDvvdqNqqU9YcZgjLJm/Oo3QqJzpZUl/UK4s6TShcORWIvikc8UMMxR
         7aIPL7tXyDrc80uJwXZcHzCxeuxRyZ0GswsbUi5SD3XYGukAO4LHEviB9z/ABPgD0xX5
         HpfM4c/sxyHPdCLRJ2IziRgjZlc87zOBe4tFstPU/S9+XYf6iw1Tjekwl+9NM6T+x3xT
         /I5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728549464; x=1729154264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FMviRvNNGrKMjQx5y7ab9W6PoN4yQqeRZ8Lp8AbVgg=;
        b=Zpa1qft/JC/ZhBzo3D39BfKVhmNpvD4r+VQXxXM7cqY8AvJGW1MNA7PA4FZgszbG2i
         nyUVz3wAxtpZbGe6/kiv86QgIxC2HTVH0G0XJEL/icaqFoe1e2aMwQSwnVRuy+4K1q8H
         GEaLQNMKe16Dp+lbb32rRZ5KjixurudxruleRU6fd+5n3bjqK8adawFiK/z4HIv+ebU9
         KwHswKunetVVUgR8EkogsjFLY5Z0WNoChvQZlboSoXzc/QKuepXJuCaZhRII+UiCeXJF
         GzIGEFinSJ1ADvv0ZXDJvALplQ9D7INj+sdZPfiVxuS1ZqvVStTJKPfTXhJ+0v+nVOxd
         SKMg==
X-Forwarded-Encrypted: i=1; AJvYcCXxSWbqNbbDpYHRafLjU9sJT7NfDAaqNRlIneVp7zM7drc/nz9uBOPFnE/G63/LJY7/iQtvYjTNCNd4KcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJj7I4AbCF9kUXr29eFKOQeXByO1jjt+nZAa3ydeEc+pHe+JRx
	QbEUWx9LfABIaADZk+riPJS4Np1goQdMl5soi033NQc2ccrwIbNme9qgRVJrLBYxI9FH3cELTDs
	VlM6Xz32OQVvowySWGZObJ6QaseZF+5kX6HDl
X-Google-Smtp-Source: AGHT+IHo7nvtYBfChOYg2s4EAqI+xEoiq97hn53e361dNMhfgEs18RdVrBlAKwV0JpOtmd2UT3msXVVB2YL5hQrF6o4=
X-Received: by 2002:a5d:5c85:0:b0:37d:4cf9:e085 with SMTP id
 ffacd0b85a97d-37d4cf9e0f8mr585415f8f.25.1728549464038; Thu, 10 Oct 2024
 01:37:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009162358.27735-1-tamird@gmail.com>
In-Reply-To: <20241009162358.27735-1-tamird@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 10 Oct 2024 10:37:31 +0200
Message-ID: <CAH5fLgi=ZjXs6KyG5ovaSSkRHCOsVb+3TFCnDvghYjE6w6uBfg@mail.gmail.com>
Subject: Re: [PATCH] rust: improve grammar in commentary
To: Tamir Duberstein <tamird@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 6:24=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> Commit e26fa546042a ("rust: kbuild: auto generate helper exports")
> added an errant "the" where one was not needed; remove it.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

