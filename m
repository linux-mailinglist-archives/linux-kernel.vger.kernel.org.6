Return-Path: <linux-kernel+bounces-430447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059FF9E30F7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEBF1284138
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089BC17C61;
	Wed,  4 Dec 2024 01:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3gB1ifz"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00393FC08;
	Wed,  4 Dec 2024 01:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733277435; cv=none; b=GCwU1u5KxkSNScgR1m/OmAHSAe9Tim15xC4j0pWSrvE/s7o4jmnagPXsXIBLpW1mIMJZTqR9oiOsZMlETtDc82ewx6MSQj6TEyTUkbShNNBzpXL8xBAD0ISQa++CYYkSPrW1Kg5FUi1whARJedxBBsUsg5WXag0Uvr3kXH6JgV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733277435; c=relaxed/simple;
	bh=PX1mmHn/QtMjg2I3xevbnz7ToycK/QmBTCd0l9QaCgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DnyiYzcXejNqYl7UgcFlld/FoMhYKM/YQNNDctz8+WRbK9shFePYZ8c8Ux8W2zLT0qCM5MmYT4rKsXzuvETFU1Cp4r16/9ZVT5ijsc0xf2bjYrbLUpj/yBET1fHoKgZqLahZXO8a5gvhAw+4SVgWix92ekeSxHAK5OlTcD8BBf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3gB1ifz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-215b13e9ccbso22220325ad.0;
        Tue, 03 Dec 2024 17:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733277433; x=1733882233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3191qi+yrf9ggK6zVNjyVofvrDWMeLv8oqbIa7X5iQ=;
        b=S3gB1ifzPc2fjWGcEunreCD0a/p/NX2ij4fVW+4RMsReLvU5tMellc3gYo1rlIsJkq
         lINHKkRYQAXigTa3/v22zOkYYgQSRkl+gT6tcx5OnYQsO74+754VX+J5htRZM+4/AlKL
         V+t+MVy/231qxBIXUPeXhk5LvSHWVoDfO1tcboizIuRXvM3dND7dGfiNweYPCAAr3Q1w
         pNtX5v3OFyLBzshhF4me0C4mMcMzTYbyJAm4QjwM8S6BOjWfP6/QUurIb2+ea6DcVE+H
         Xo1fOAqlaq9bF/jc9X3e8XRY4Om0POh86BY9dQQcCoGRBMave1FyyeDpu5EkPTfdiUm3
         gzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733277433; x=1733882233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3191qi+yrf9ggK6zVNjyVofvrDWMeLv8oqbIa7X5iQ=;
        b=DT7norpEe5VrmfEc6WIyGMkENs0g3s7RbiGq5KjOBS1lNC2mD5SfL+zag+H1uOv9fs
         BZmnP7NRXSeRC4yCjF1ub8YTjRgFGa4E3Sc3VtFzObLj97sXoh/BAtP8hSIz5JN7Pe4J
         U8M1PQ10EKmMcQdonzIDE1ltB41IXDgViMA3UtNGE7fyR+RLGQConw8cUWcC86zdNnK7
         tcS4W7iLQu+EMgMAxzC+Jbaj8mbrVm0ksj9Jp1eQfykLMTQHoZS20MU4TqL1UmxUpOlj
         2lzf1LWdeiNBTWsx5sFIJa8zaUphSL3kwOd8xmQrqtAV4AgmLzxgNM25lyjGbXntqthm
         Tpfg==
X-Forwarded-Encrypted: i=1; AJvYcCUUg2JXH28VcyuumEF8nhi7jLuHit8wWavZfBCIi7l/qwQu2n0ZB+dZSYf/XVe6Z5tFXHfJIOt7Z4oYGkB2Bx8=@vger.kernel.org, AJvYcCVvg+nRG7Md+Z1J7Hzgf49TOJ8S1yuWv5i4HW3u6LYqPEaQLWFZ9FKaUi/yutpCTYCIQQwHljV1CJr7mrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRHWDZZNYDdGQjpRBUdJyvY+Xmah1s6BkIQuJhZHdPP9vaWr0v
	OgYhJoU3iY+3DWIfJAlmml4BsS7iH4/+6DH10YRzN8z+zHGZkSWBrZlx4opA
X-Gm-Gg: ASbGncv91qpslZuSuP4L6T+Mdbhc1J/0SYpO54eEqbIcvtRyaBKLd0ebtWxj00HEyCj
	jHuddLCnDUt8bo2okeNJ9g1KIMUUueZ4MmIHDzV3jZhLlgiiovvy/4GriESxHiuoEdanDrdYkow
	koqr97rYrS84WhUAQ8p6VfTTQimbhTWqLykwYZ39JniIxh+RiVxZr3r0pmRaLNEbXgwZz9QI+v7
	/38gMqQmJOm8F65y+pd7oJpxlXBh+577Lm1t8jyu8+auee0TlCRsEBkDS33UqgPo2XROi0LE0AB
	A8S402s/4B1ucBR4nYLzX18HRQ3N
X-Google-Smtp-Source: AGHT+IGWqL11z241WcLN4kNqYdPWBNXYQA1bJwSTWmVM3neN+2CywO6LKUdpn3jBA7M/92Wi+Gn/ZA==
X-Received: by 2002:a17:902:f70b:b0:215:7287:67c2 with SMTP id d9443c01a7336-215bd15deddmr63921295ad.42.1733277433178;
        Tue, 03 Dec 2024 17:57:13 -0800 (PST)
Received: from lordgoatius.clients.willamette.edu ([158.104.202.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2159ebcf60asm37977515ad.108.2024.12.03.17.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 17:57:12 -0800 (PST)
From: jtostler1@gmail.com
To: miguel.ojeda.sandonis@gmail.com
Cc: alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	jtostler1@gmail.com,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: alloc: Add doctest for `ArrayLayout`
Date: Tue,  3 Dec 2024 17:57:09 -0800
Message-ID: <20241204015711.635816-1-jtostler1@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CANiq72ksaJcpjHi8=vuWLTLLfik9smaqY9oJXjwtieXgJ6Gy9Q@mail.gmail.com>
References: <CANiq72ksaJcpjHi8=vuWLTLLfik9smaqY9oJXjwtieXgJ6Gy9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Dec 3, 2024 at 12:48 AM Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> Thanks for the patch!

You're welcome! Thank you once again for creating these opportunities!

> A few procedural nits: please Cc the maintainers/reviewers, especially
> the main one (Danilo) -- for that, please see
> `scripts/get_maintainer.pl` as well as e.g.
> https://rust-for-linux.com/contributing#submitting-patches for one way
> to generate the arguments.

Thanks for the pointer, I've got that fixed up now.

> The "Signed-off-by" tag normally would be the last one -- that way
> people see that you added the other two rather than the next person in
> the chain. It is good to mention the tests etc. that you have done,
> although normally for a patch like this it would normally not be
> mentioned (since all patches that add an example need to be tested
> anyway).
> Finally, a nit on the commit message: normally they are written in the
> imperative mood.

Looking at the documentation for sending patches it's unclear whether
the commit message for a v2 of a patch should be modified for cases 
like this, or the only changes should be the in patch changelogs,
after the marker line. What would usually be the preferred course of
action in cases like this?

> >  /// Error when constructing an [`ArrayLayout`].
> > +#[derive(Debug)]
> >  pub struct LayoutError;
>
> Ideally you would mention this change in the commit message too -- it
> is the only non-comment/doc change, after all :) It is also important
> because, in general, so far, we have not been using `expect`.

Same as above about v2 patch messages. Should I add it to commit, or 
include that in patch changelogs?

> > +    ///
> > +    ///
>
> Please use a single line.
>
> > +    /// ```rust
>
> You can remove "rust" since it is the default.

Fixed both of these.

> > +    /// use kernel::alloc::layout::ArrayLayout;
>
> This line could be hidden -- it is `Self`, after all, so it is not
> adding much for the reader. We are not fully consistent on this yet
> though.

Done.

> > +    /// let layout = ArrayLayout::<i32>::new(15);
> > +    /// assert_eq!(layout.expect("len * size_of::<i32>() does not overflow").len(), 15);
>
> See above on `expect`.
>
> Moreover, since it is a test, it is fine to panic, but recently we
> were discussing that examples should ideally show how "real code"
> would be written, thus using `?` etc. instead.

Changing it to use `?`.

>
> > +    /// let layout = ArrayLayout::<i32>::new(isize::MAX as usize);
>
> Perhaps we could consider an example with an smaller argument that
> still overflows, to drive home the multiplication involved. It could
> perhaps be a third one.

I agree, I think adding a third where the length is set to
`isize::MAX as usize / 2` illustrates how when `len < isize::MAX`,
the overflow can still occur.

>
> Thanks!
>
> Cheers,
> Miguel

Thanks,
Jimmy

