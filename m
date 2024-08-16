Return-Path: <linux-kernel+bounces-289403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E279545D9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A67C1C243B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F062148304;
	Fri, 16 Aug 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhERtfXL"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E08513DDDF;
	Fri, 16 Aug 2024 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800780; cv=none; b=ajH/7hVUT3GQc8VQ2cF4N+ihowlTCKHWL/dw9SLQYPMs3295eVejkRYorKBOH8UDaIJmxTNMBVli82x47I5Ru8IM+l7CTrFhmVBsEtpyG3GWbmgjkeYCgdHeAI1yRWLV5l2DdR7viEnoTlwEsbb1tWxRH7cXuFhuo3arp56LdJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800780; c=relaxed/simple;
	bh=vzV7s0uXOhnuzB9vBu1I619DnFq9lY/7GwRKYcwaB+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W01oyoXn0npHOqoV5fScPpGsmoonFGpv4redcwcw9IPwWp0Bg8dSDfIb8xM+SLIeAcugJ94tUzcqHWjlg+gf4ZZnI8TrmlgDIUxaWYejY1F/CxM4M6xg6ht71btk2iwrzuBosl40BwjRUqywnUg2B/Uzn3jgoiqcA+PoxCotqJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhERtfXL; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d28023accso1459885b3a.0;
        Fri, 16 Aug 2024 02:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723800779; x=1724405579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4K2SAW8wicjlsk7/nPqqUv3f0uftRhtXUIcN9ovpuH0=;
        b=YhERtfXLg1tWXo67aNgFc+fpCLa7AJp4n4THTcxDAaQttITzgudYZX2Wep36L79HzX
         UmZcvjjOop9B3Nz1M1G95Yqn7wAMUj5JEiRwAnQ+1eSHVPlxsLuKtTIZgq+XgnLk1Bss
         8iAHYFZSBH5ui8iIPNKKeNnAX+vUzv7wrBF7GAo2QG1N+b1jttYR9IYZRoboY/k4/Lku
         7N/yY25LORdP9Q7H36ZK5VeN4ePC7tqoeuISiKJwFv924k911yogw+fQ1JxfxjJ0Q4n2
         rcF4ZWTrTIlV4+G8iBO3HPW39QLmzudw0rJPQvh7F6XpMFkoLzEycaXA8lj/tkh/tqRb
         HQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723800779; x=1724405579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4K2SAW8wicjlsk7/nPqqUv3f0uftRhtXUIcN9ovpuH0=;
        b=MQqkSPL5bCt0VFMPVFJgv+H72bvKCA5yRF6zT02cjMRPfYBSQpk01+0i2CaS1+QueF
         YNs0goL4+nUfEdooa3RMroYi5brQkF2CMn5xoOVfP1or8T8ws7kztoafbSiw+8nDnd/a
         1aAQX/O4XNZm3iARavLgEGPXvA7I7i7K7N3Luv9VvYuoJb+btshEM9aXElBewq/mk3Bp
         gxrBTfLiQgCIePQ99+L5PSe6ZyU9LKpn5DsnG4NjwPGPzR1HVh95i5e+Pe6ZBF3xOOpg
         szlnViUZ3AsRKCUrdMOa9+6CxZOv9D5K9D7xNAtpuONVS6KjlTwmBZAZgi73ukIO5EsI
         UXPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIjzsGdpOweK0nb+3d9jNvHPomuYmgiOIZXFj9QeD8nrSac9YPvmnFQmlNKs6Bt9F62le0UYm9/OIiMRfXu16l36FtIX63vXh5iJokFDj7pho14DLv1k5WZ9HO/k22ojliU8A9ZcjK
X-Gm-Message-State: AOJu0Yw5rmXJ5GsJHqSqdsn8EJD92DqnB/HwleJ1zo6gos+Fx1RUBejI
	jKV/ly6iyiSYtbh6JvW2GlsofAne36e+9z1U+Jr8JZCDpJ9ysbW67YYcvd+xl+xi+JebT9LJDg3
	xmemd3ZpO98vYtrf4zaeR8AW7cjU=
X-Google-Smtp-Source: AGHT+IGuiyJCkiCZWSgYr+KLXxSH3mI/mynqTtCAGa3wQ0oyjddENi8mNVdupx9Sg5znl6H1+pcYB5g0cTCiV2dC1Po=
X-Received: by 2002:a05:6a21:3a96:b0:1c4:c7ae:ecea with SMTP id
 adf61e73a8af0-1c904f6bc33mr2730930637.11.1723800778713; Fri, 16 Aug 2024
 02:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816092536.2444105-1-vincent@woltmann.art>
In-Reply-To: <20240816092536.2444105-1-vincent@woltmann.art>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 16 Aug 2024 11:32:45 +0200
Message-ID: <CANiq72nN+x9FR8whpiEFtUr+4gkBN=pfw6URO9VO31qtX7=5Bg@mail.gmail.com>
Subject: Re: [PATCH] rust: Remove erronous blockquote in coding guidelines
To: vincent@woltmann.art
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>, Julian Merkle <me@jvmerkle.de>, 
	Wei Liu <wei.liu@kernel.org>, Sven Van Asbroeck <thesven73@gmail.com>, 
	Adam Bratschi-Kaye <ark.email@gmail.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:26=E2=80=AFAM Vincent Woltmann <vincent@woltmann=
.art> wrote:
>
> -    While sometimes the reason might look trivial and therefore unneeded=
,
> -    writing these comments is not just a good way of documenting what ha=
s been
> -    taken into account, but most importantly, it provides a way to know =
that
> -    there are no *extra* implicit constraints.
> +While sometimes the reason might look trivial and therefore unneeded,
> +writing these comments is not just a good way of documenting what has be=
en
> +taken into account, but most importantly, it provides a way to know that
> +there are no *extra* implicit constraints.

Doesn't this part of the change make the paragraph be outside its bullet?

Thanks for the patch!

Cheers,
Miguel

