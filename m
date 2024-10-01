Return-Path: <linux-kernel+bounces-345718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D85DF98BA2C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158031C235D6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43201BF333;
	Tue,  1 Oct 2024 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="efNyB8Z+"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755011BE871
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780284; cv=none; b=W++PXW8cwoc5KoRlQSckEoUZf56Wna8WAMqZ0qVzZZD7vJje/xZ4d0NZi0PIrnpU9wVx67trDP4F20Wzs7l8BJyXOi78T/ZvZEUHP8dKspyLzc4azyf+878W28AjPsF+v065MDEG6YQCEGaaBOEg5i6rd+9eeDNGX0XVhTYD9hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780284; c=relaxed/simple;
	bh=60EhXKAteHv2MPzzdgUAD7FikabFpPaPZwrLroTEnQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgOZihmKYWqS3RffREb7TvYgCXRDIr5KVRsL9E1drVJ4yPUr0MejqSlQd0hrkgCQBZHH+Tsrf3VOXasln1aHzPBx7h3WoeEFqbu3bxvMG/Xym2KHGLfAy/7DlifMkaqF+s92o72iKnlVeI9IOmg7b5TegJqeVhnCxRN1ROoCvlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=efNyB8Z+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37cd8972738so2601892f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 03:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727780281; x=1728385081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1/SnEV7GpnCmA2f8SClpEwW0fcraNKH9MQf0vKkPjQ=;
        b=efNyB8Z+AvCwCkWkdL4h24U/TWX5Xmp4VJ2RIHSU9QUZq10Id9xKOA+YeAxKOonZW3
         N4rMc0/lYeVT6M95i6G5Yt1SfO3gBVE/ICwXCEkuhh0GmFyYLCNGTErEGPHWhr3Nkej4
         sK5r1Q9W/6vRsdu9BUXDIXvweyGRDHbczIK96DFbtJyvDuNTU1fdqd0nChksFaqqqA37
         0UgaQbZce0AD9LJX/4VZk1SYcJUgGAo5T9t7wFA8ijFvVvAfnJa5l/HknFFT5lzb5mZA
         1d87CEOFJwW2P7GDILhzwWM1tS9tIksUCAQnSNM++s1mGlXcpxE9gb87k1qzreuE1zfo
         kzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727780281; x=1728385081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1/SnEV7GpnCmA2f8SClpEwW0fcraNKH9MQf0vKkPjQ=;
        b=omyW81q3BCvw+GzgAiPNT0ypmOq97fwLzR8IUd8LW4/xDSZSfcSaAbMYjOgrAURk5Q
         nODhFOtemqJcEou3K79QUwL/hQk6evJPHBzQy6omSn881vXK3UyZqSuhEfQwt6ZFP3Ar
         vVF+vxOFtLXLIY8sUFVTtsOHOyJTE9L5ZQYgVP6jFA3repCvYKHO/yLh00yA3Jtpw3kb
         k9LWo8ZiS2vdhSYzJj75NqViRe+AewceW1VWvaBQRwOe/H6l/1FJY9+xOzUAlDai/HzG
         yDpW0zEsxRsKJY7XFoEL7OjbN9HkZSEOr30LdnefyN5MB1IIFodyKQ9E7FbUMmbhKj5Y
         TIdw==
X-Forwarded-Encrypted: i=1; AJvYcCVZHzyncCEKf/g45FWVvtIFM42uZrv1SDd3pu8Q3Iq77f7VWXCiVdOpI8E9Adc66wuwHB3+DfqCpIMbEZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSk4HzqSn4ZhMLA9k/y2eej5eNU5mXNrf+GOK0RSv82NJ1XHWI
	YHRVDHwNerduoVlW7T51SQWa4PAGVQwl3iykERUQusjBMvRA4P6f81QaQF0hJQCcAkBDV0Xy80n
	SH1FSuPzy0WRPsU7kzC0gJOXjtw2/itZauov4
X-Google-Smtp-Source: AGHT+IG/OuMrpizTXMK9ykXj5tQizpl0H0yQsEL9StHtl8bSdqhVYJ82YEbwzDkAtDBmCQuH6QaI4BhD+/admbTQT6g=
X-Received: by 2002:a5d:4a92:0:b0:37c:d21a:3d61 with SMTP id
 ffacd0b85a97d-37cd5b319b6mr9097510f8f.39.1727780280536; Tue, 01 Oct 2024
 03:58:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913210031.20802-1-aliceryhl@google.com> <CALNs47sMJzeZ0yEF9sc-VO_QEu4=jc3QBa1_fhnhX9gdETYaNA@mail.gmail.com>
In-Reply-To: <CALNs47sMJzeZ0yEF9sc-VO_QEu4=jc3QBa1_fhnhX9gdETYaNA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 1 Oct 2024 12:57:47 +0200
Message-ID: <CAH5fLgi4YNsLHFoKw7UsGbmpEaqeG4o5yMQAodZ1KwfExAPL3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: harden index manipulation using ownership
To: Trevor Gross <tmgross@umich.edu>
Cc: Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 1:16=E2=80=AFAM Trevor Gross <tmgross@umich.edu> wr=
ote:
>
> On Fri, Sep 13, 2024 at 5:01=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
>
> > +//! Utilities for working with ranges of indices.
> > +
> > +/// A range of indices.
> > +///
> > +/// This utility is useful for ensuring that no index in the range is =
used more than once.
> > +#[derive(Debug)]
> > +pub struct Range {
> > +    offset: usize,
> > +    length: usize,
> > +}
>
> Would a name like "DataRange" or "CheckedRange" be better here, to
> avoid confusion with core::ops::Range?

Probably a good idea. I've had collisions on those types.

> > +    /// Use this range of indices.
> > +    ///
> > +    /// This destroys the `Range` object, so these indices cannot be u=
sed again after this call.
> > +    pub fn use_range(self) -> UsedRange {
>
> Maybe just `.use()`?

Makes sense to me.

> > +    /// Assert that this range is aligned properly.
> > +    pub fn assert_aligned(&self, alignment: usize) -> Result<(), Range=
Error> {
>
> It would probably be good to warn that this alignment is relative to
> the offset, i.e. if you split a range at an unaligned point then this
> may not be useful.
>
> This is a pretty cool API idea.

Thanks!

Alice

