Return-Path: <linux-kernel+bounces-240723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB9B9271AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72034B2181E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19FD1AAE07;
	Thu,  4 Jul 2024 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR9rB9dg"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3CD1A4F24;
	Thu,  4 Jul 2024 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720081689; cv=none; b=XQZUpdEYnYL6XO6Rjcs/12twhhApefQbH5e58C4TVbdxIhx4cr6+UXkYZU/PRicIxFbMdKjqU/1tdmTtuNaMXlKobK/qE0NgkBlx/Ud0O76qnHIA5wLchgSGOioOsDOezdDNVI4Q0MD9iSgYv11M2qvkjlmAiZ2QhxdqxbyKnDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720081689; c=relaxed/simple;
	bh=NACgDJXBWNPYw9Ngq7uQTOiENa1dwMYocn7viIg36Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rar9TFPLSXHZl85/evU9vGyiyImMMDNi4eT+quDZnmoa08+H0jGrRsApB7hcezOnkBZQzYsB2ML+zDlo2NrzuSYpkk7s5JkbnfHx9JO6tqprGacsCb0sVPXLLlofUl4CUalIEZiFkk7+pygHHRBaBedcgXpIFAKHfPbY1fe6M5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PR9rB9dg; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c9785517c0so308279a91.0;
        Thu, 04 Jul 2024 01:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720081687; x=1720686487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqmuX6C9I4AJfUwdN8mu0VpBGXtWyEp985SM/nEyh8s=;
        b=PR9rB9dgvdMRNrIme3+fH9C0hGyt3jonwYEmRXbGqgDJ2Jyg3/wsQT+pvOWXDlwG+N
         Jijp0C236DhFgiW3ejN6SUVxQz7FhIKimAuz6M8ZifrVMvOnmyy4hUPucvf+uNtfmqBU
         yx6osiKp0g8pmCqxaHwRyRD8Skn0YYU3xoiQRpAY24V+G/wwxQmsFqvRgVt2t1qaaP6B
         fGU0iPXVYiZ5lIqgJ6mfk81UMz9s3GXA/KumR07PqQMDXGB35QvExlh65hi73i56yZes
         ph2j8E72N5zK90Z/Lb/4ZVI1W+GnCehCqcPQzXsQvPY3313ooD0I9Q9cG+RTGzs8gxzi
         U5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720081687; x=1720686487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqmuX6C9I4AJfUwdN8mu0VpBGXtWyEp985SM/nEyh8s=;
        b=PrEDZLmg1QNIJDNNLodjWfiJcqWVrVvRFyJ3zOLaVCS+E6SyMx+adQK2ZcbLZgNUqi
         QbDF5G7C/oOossjHtfs1T/8IS0csOrwJ/7GE1cEQYsNBmYwt4ysFEFMc7NboS6APllay
         Qehh10743Ydo+aI3o+z2qTBzo4PciBCaL9Tq5BIHxze1i5LwDvpg45FfyUA/d2hn8i8W
         kMxCIJXZpEUZm7V/xNDlNbippYfQoTMnHr6LJk6syJh4TJUxkQaAkA+f3/OGq6Rfr/k0
         gre8MeOgkLEo9qe/9SW0JelwqJozhM6ZAMmN3WwnY/bEHuSGIoZ0CqWmt7pVrgpjrqUJ
         f6og==
X-Forwarded-Encrypted: i=1; AJvYcCUPxgncqE4Vj9Tl7yDObx2NJZtH+jF5V+87+r6BoOGswEIrGcoMlLcH4Mdc1xivT2uE5qMMiGNB5NfwNLBXrysGNlxLwzITjLBeNwThJ9lBl1CgOvpx0p7lfTp1jJj0Iw3oBqcgXtSH108X6d0=
X-Gm-Message-State: AOJu0YwPn2YdEVbAdSafR6EuoSbRXj5DsEw7Ws+aotQKKd8HIMiyjZmr
	TaSxwegVogKUio2kiGRrpOkoKUMjYxthnXV0DiXix2jdjVpBQo5314sf3z+zMRZQ3u9phqSW5F4
	tkAVl60Sf1lJkYUgNJVkL4pdgqm4=
X-Google-Smtp-Source: AGHT+IEpwhI5B0ua49mWTjBo4KXXy9eQRzJQa3Fwh6aYFAXYWC3S+24kRsdY76+yGN5g+sXoux0AVXwMQNSoWcarS04=
X-Received: by 2002:a17:90a:f2c4:b0:2c9:8f97:d2ea with SMTP id
 98e67ed59e1d1-2c99c6cc3d9mr671455a91.6.1720081686806; Thu, 04 Jul 2024
 01:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703154309.426867-1-jfalempe@redhat.com> <2024070417-husked-edgy-f527@gregkh>
In-Reply-To: <2024070417-husked-edgy-f527@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 4 Jul 2024 10:27:54 +0200
Message-ID: <CANiq72=iqquz3a0sN5BUa=-hxW3WBZTAKdA6HxwTh7rGBJJBsA@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/panic: Add a qr_code panic screen
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 7:03=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> Wait, we can put .rs files in any directory now?  I didn't think that
> worked properly yet.

We can put leaves of the crate graph (e.g. in-tree we have the samples
and the PHY driver), but not the rest of the graph. The former fits
just fine in Kbuild (which is why it was good enough for what we did
so far), the other part is what requires a rework of how things will
work.

Cheers,
Miguel

