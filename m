Return-Path: <linux-kernel+bounces-276670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BB89496CC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82D30B2743A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D79614B965;
	Tue,  6 Aug 2024 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8L15hyO"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8AB482E2;
	Tue,  6 Aug 2024 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965364; cv=none; b=kor4UkjqXWaDZjaqze3uwcw/azeQkoKtHXmqKDTbjmGmJjz1PmMRcgn/P1xpk2z6bbSWz+tT4xSSfFB8n1mYRzyOHEx6IuzubKO1rTwR+cpZSom0KWvNthIrJX0jDaBwNPuMlJwOnBTEg+rUKmP8Cg6JypOf/juyNoWq7/fZdS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965364; c=relaxed/simple;
	bh=/mO63XZtQ2CoGPEq/ODUwo/fxXZWPxcKmKWOXs8cOm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1zF3gC+QjhN8VnFr+xyqJ+SV1GNJoUM//XQA5PlAt5IKXmTaS+LPp4a7hbYHUs3cP8qcPVhCpzOBOhjnVG8a/AtdGGYNb1Ic8B0KdNmcXbLqNIa+YmlxaAq+fbvwFMf3xZyOAFZmUEA3j1RkcsWwbXSf5ZPw+fH+zl+1sf8i3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8L15hyO; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7aa7703cf08so785013a12.2;
        Tue, 06 Aug 2024 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722965362; x=1723570162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mO63XZtQ2CoGPEq/ODUwo/fxXZWPxcKmKWOXs8cOm0=;
        b=a8L15hyO7IH3qxMgtwVxTHMF5XAk1EUeXabsWS5IknHnY0Uk+KGZDtS8A2FLBtUfDP
         2Mg32E3lkATiasYgekKQepzBllub9DXP9cUZwKVa5+Ps1/xfaxra/2mtj0UKe4Q6MJmN
         g+Mm/Qi72MW6sFknTNTxOBX6v2HNA5Sh10pQ7UwyxEySevHwTlve6uPRwDEQENInAkqC
         LyCyOc7+iGZN4KCHv/v7hCepyaFUrJdNlRFnzJMSwubzBxRwOtXSOz/LLQuu8QPmyieZ
         W0DHPlLUKKk3VKo7+wcs/zlwbqGGFNn6Fl56u6soVegx0YjV3t3DfnU6GSNwQVZt22Nq
         mpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722965362; x=1723570162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mO63XZtQ2CoGPEq/ODUwo/fxXZWPxcKmKWOXs8cOm0=;
        b=Un+YBQmbD5Qob1MntHiZl1vSD0wrr9eQ9gRP2SIEjg7c1m3Beed1/Ad3rsT4Wg4+Az
         Q/ASgzFPf+3xJSSlDe5hGkZcYtfzOOAn91LE1JnYQgenDNcoViYxVYgwtXtrTUZ/a/G/
         8jlZkv8QryoeXwIUVWe37iTD4iCf3dxo5qm3U6LXALNQe/FYVrnEg8y4UHnPS/uRtMs6
         HFDFFuKYw/8CICiMTs8gv+aWrctrs/oqmFEoZ8pE/icPQwv0QGKspuoOKswlR+78UnQE
         xCazVhCEmMQ4/TzJ3W94kFMTdlxUbi0JZDflhKbYRMAt7eM7hhBH35Yqx8A7ZYWYiru4
         Mvow==
X-Forwarded-Encrypted: i=1; AJvYcCVd3a4Nkznb5tJlIoyoLgzoVvKLqiOJ/xbQLDpR610a0j9PcU0R/YCyVGEmutTF9TWvNlXnVM0qHX3IagG/qoLNWguhJIYZuR9Wsfb1fATiSLeQzSRfT6UgkjHVNxlxdqwuF3Z10vgewV/D2Y0=
X-Gm-Message-State: AOJu0Ywc8ThjrV8IDqtdNL9Npk5T8UuZ3crpuaiTRov+7S3cxLZBPuT8
	fCeBslh2p52jP9+u8g/eUOXKCdnT+SKf/8TbaAkObLHLlNHkkfuB+4Toj7qSci28gaGU7ky9rFE
	PAtDK8ua57eyQ1YnTBPGNhakkY5M=
X-Google-Smtp-Source: AGHT+IEqmlkOrOpHnuT5hIPP11PVxraNzyx2ZFFVa0SdMxmx4BVxxFuQsrHyiFW9CmGi8/VWZzAL2o2es9iF/8Qmz1A=
X-Received: by 2002:a17:90b:4fd1:b0:2c9:7aa6:e15d with SMTP id
 98e67ed59e1d1-2cff945c29bmr18157027a91.20.1722965361870; Tue, 06 Aug 2024
 10:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-9-dakr@kernel.org>
 <ff0826af-9430-4653-abe8-25fb80cd0e97@proton.me>
In-Reply-To: <ff0826af-9430-4653-abe8-25fb80cd0e97@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 6 Aug 2024 19:28:45 +0200
Message-ID: <CANiq72mbrxFqqRMpdbuuOCy+mKtjFbLaSd-OVd_ntOeqaYRyzg@mail.gmail.com>
Subject: Re: [PATCH v4 08/28] rust: types: implement `Unique<T>`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, 
	akpm@linux-foundation.org, daniel.almeida@collabora.com, 
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com, 
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, 
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 7:22=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> I think I already asked this, but the code until this point is copied
> from the rust stdlib and nowhere cited, does that work with the
> licensing?

No, it doesn't. They should be put into its own file with the right
license and a paragraph about it, e.g. the other `std_vendor.rs` files
we have (if it is just about `Unique`, it could go in the existing one
at the `kernel` level).

Cheers,
Miguel

