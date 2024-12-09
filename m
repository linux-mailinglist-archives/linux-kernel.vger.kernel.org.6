Return-Path: <linux-kernel+bounces-437236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A2F9E90B7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6B6163D4E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496F0217721;
	Mon,  9 Dec 2024 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPvN8Enp"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B3B21765D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741060; cv=none; b=B4eAwT5EIxp/7xFYUabmkMZJ2FqZhqGzptsxp6GnqijjNzeU/2P5zxe6X+CLPEuI8kiWAl+bv9izRFmhM7lYrIG6rMUEVQcjDW1gvgy0wKUoxZRmM17E2TjUzCFhCC1VNcqk81Cb8rzeckeToiRcTvmqBADiy9XS9XzyMqKZuCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741060; c=relaxed/simple;
	bh=6BqBE5aFm4ewSSXypyzZzTAT8ClVBUtCqUHdDBItBdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwiBHuQBLVh6F0z8HOE/FQTBLqoxz2oisYn+uKu/6WcbvTIzfHIIRRqZe5/HCh09ivKzQBlmmihl20aXps7EuZfA3Yis3FirU1zW2BZYVCgWtxUcFFYCbsfZnYYCwPNxID3aJOF8Vtg7AAKtxctaw8s7rTQ6yZ13BEfoxDcVzas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vPvN8Enp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434e3953b65so13546055e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 02:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733741057; x=1734345857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BqBE5aFm4ewSSXypyzZzTAT8ClVBUtCqUHdDBItBdU=;
        b=vPvN8EnpVNA5rc8qqkxAJtara8E4ZuJGvWUGneyLKIwD7jB7bidxhK8j8g2D/p/D/J
         uuJeOHoYpEJ6+pndgXVi3QOco4xlP32gd7Ic1vuKYTIO5gazrU27HaG6qCucTdl+IWJ9
         pkC47s2qo3K9wDjxlOX1sCB4fk3LtXY7Tu/sIC1JX3n8hHPmewCkm8b6FYt71iZ5kB8f
         SYF8n4KpLw3P1iZZmEchE40vzj1/ziU91MYpAIJaIO1TtUQnyhNC+BMGYYkN0tzcRqbg
         oB9UPSJNHsZCPZFlRIMORvEeTuKJptggfjvG56Uv3KqidFU9k74PlGpBGAHqLfZiApew
         1zQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741057; x=1734345857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BqBE5aFm4ewSSXypyzZzTAT8ClVBUtCqUHdDBItBdU=;
        b=odDxvk25IwL8rQE71TK+71EXotl9McpsFerTPiYfWcXJqLdgJea9njZIzzrAxzIpR6
         //EYXXsl+uZqDt+Yk7Mc+KEcP7gtXRJbui9gPl70MQwG/pV6K7tKHoFuFC7nTqtWReaN
         h7TuU4IC0RmzIG/8baNZljclj+S+OrLdDeSRxshcZOD4xYtt+e8zKeSDk9FVX55UMBuJ
         QeXxASKmeqVEsdfATvJgVPb9U15M40TZX/FSPoKpdgF66DZk7QBeci7l+OkemAehUdSL
         i7ixqUmQNV+hiip9lyZnl/dpJzT6BBDihjMoyUnS3p+e7cSkOi5mUSbSGnoiAIATO3Dm
         2qlw==
X-Forwarded-Encrypted: i=1; AJvYcCUb7TeGIlLKoV+Xoux3O9YTGFVWdCm3mEmOOacrsYQRC07f8hgDGBQNTj/vveurTN08f1AMhqDSNZPH0Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbdB91mNkDNJg5XIMU9zFHveOc4Kc/nV486rBpajPY1rF3xV0w
	T+6/8+H1lVTYcl+gvFsQ5iiQwcllaptjZKWn+NK+vDZEGQyogNHdz2qgbj8oWZY+Pw55yiR4P9L
	nrkvft7gvldk9l1jQptpKoF3S+9csGQLaWJUH
X-Gm-Gg: ASbGnct+Ia5ear1VaUtYqLFKabnV5Ml5WAsUEZtcmShiafiNW6EpmPd6OZUsut1cXYm
	zJkpa32pG580VUXUygPnZl7OioA1GqADGpfMTtsQ5F8y4j7/EOFC0M31iTlMo
X-Google-Smtp-Source: AGHT+IEtz09n9EgbFd7plwXSP8yb6/Yeh+KMUJh3CuOljqy6eQuyvRHTd05ms9lQNLPlGEDxjngHLcH/n7gSBSV505Y=
X-Received: by 2002:a7b:c8cc:0:b0:434:f0df:a14 with SMTP id
 5b1f17b1804b1-434f0df0c1fmr47702465e9.2.1733741057349; Mon, 09 Dec 2024
 02:44:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com> <2024120936-tarnish-chafe-bd25@gregkh>
In-Reply-To: <2024120936-tarnish-chafe-bd25@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 9 Dec 2024 11:44:04 +0100
Message-ID: <CAH5fLghxiX8PjJH3s+xcXpJTD_XLuKKEjRM2dOqXkX7n7PoQ6Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Additional miscdevice fops parameters
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Lee Jones <lee@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 9:43=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 09, 2024 at 07:27:45AM +0000, Alice Ryhl wrote:
> > This could not land with the base miscdevice abstractions due to the
> > dependency on File.
>
> So these should go through my char/misc branch now, right?

Yes, that would be great, thanks!

> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> No need to sign off on patch 0/X :)

That's just the default when using b4 to send series.

Alice

