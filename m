Return-Path: <linux-kernel+bounces-374928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 150A89A7212
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA0F1F25C18
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F811FAC50;
	Mon, 21 Oct 2024 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhRln9Q5"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5FB1E573E;
	Mon, 21 Oct 2024 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729534409; cv=none; b=cisK1yhYDhsdV3zUMU1gKo4Ugwd7vWBHOwSSDGeR8Ny0QFCSRQON7m2e3kE9do+zlwa2Mk029XZL//yxORvfs8YlKwvcng2/ZLbKWqFpGyy9PAV9+xCGcGEwoC4MyraMDrNXoNmN490MJVclnj7HvDIHzSKjiQ587fItSfVIaxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729534409; c=relaxed/simple;
	bh=bJgud164RD2MQYC+B0FUMsPPQp9pfAsq7hChCNAAOmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCAozP9O6J+Pcf2txwPXLpLHD49MtCXdQ5UPlqWwptfeiV5Uy6KZcYjfp1kYfYIVPumma8Hte2GX5F6uzT/RKuVJs0VC1yHY8DLllb3t8xA9BR4ub6CNjcB3CypgCk7dmDfd9/xdarCLk4tnqRPJUToE2SVflR59FZwCJQ5UAoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhRln9Q5; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2a96b242cso673017a91.3;
        Mon, 21 Oct 2024 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729534407; x=1730139207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g54jDDiGhngyCAbe+hrcsUOBeSv+Nz+dWdRmMvTkP04=;
        b=XhRln9Q5Sj1upyqg9JDLY22pwsDo28+QDgfaia51KE3a+9P0gnJfPipYtwaL+ursyM
         Z0pKAQ6fniBNWCVLCEhn3Svnf0LIdl1RxgB3bVSUflFu87ncX216hAGfnx5Z6c3+uyyP
         6RS77oJerVzoER8GYzYXZfyuSCTNjPJ6AoWQL0YDpzXVXNnyIXijLztSdgUVTgHSxtlJ
         WJzqrKgNTBgrwDqQiMHqecm9LQPjp0Br97qQpqJ1LbM1CcKbKJv6xSutL7hmciH7bqNm
         DaXlyvLxShqs+z3fvk0lfKJy7XwBZKKTzqWBEj1QsJsgrNaz9JzLASj60kTmKX69/k6x
         Qp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729534407; x=1730139207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g54jDDiGhngyCAbe+hrcsUOBeSv+Nz+dWdRmMvTkP04=;
        b=BgM4JYwio5ARODFD1WjbeMQtZseJRL5VcngOiHIQwXLu1LemSlmwGGfXUi/x/VH02g
         Hy/EPN4xq0EuZN+96tqQM4AFzZI+QSP1k5iJTInThGJsl/K9z200MQj3HpbmPblci9Th
         LsA0KdAh6nIT80Ua1FPAQlVj7a0nNRyGJRyucLxopsac49Oik8uGKJLrvIuMXQMfNkwn
         rJoncy+IymgczKS+EHxod7kF5C/BpAMt1hoOBkVfN4BFtXd5T9UJrT2pfxA6vlb4LiN1
         qPmQHvNvLolHQATaWzLuanzuVd2vECXP8QfnMIKPf+AXvB3qjx2eKrzE/trUv/l8t/ie
         kFKw==
X-Forwarded-Encrypted: i=1; AJvYcCVCjGmBnr6T/h/jfD3aaKF2WeJDYzT/T3ByeBfmvqW1KeFpctqVpOjQ223nB9B6ZguWL32ifKU9a4bNPTY=@vger.kernel.org, AJvYcCVp5RS6QLbO2bCOdXjFofSHwMmoLqEiuW3VGBJAh2AK0/nfUhSIl581KdVMeXvhj0AyOiy3M6RVXS9PW/XJNf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT4pzk8uzdWE8NASCHqJeIXw53IdNhpRKxhMz2w3mu4rBVZId9
	mDKxvwW+hgXpmXskynYvnbtC/fi/up3G7roGGExx8gmFlJkUAhmWvI9O98VVbTR427mRlhzTLZ5
	r72ZwE/ENsiRr1g2c+V1i6XPOFTQ=
X-Google-Smtp-Source: AGHT+IFWdXiyh2BH1wiyKebzZOgvmMk9uObaXSUIC7gXp+nFBZve+5gkcGuTKyiIC0c6v00A1oZIIe3Hj2k1K4ZAGDc=
X-Received: by 2002:a17:90b:4ec3:b0:2db:60b:eec with SMTP id
 98e67ed59e1d1-2e5619f8a85mr6176351a91.7.1729534406863; Mon, 21 Oct 2024
 11:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-page-align-v2-1-e0afe85fc4b4@google.com>
In-Reply-To: <20241016-page-align-v2-1-e0afe85fc4b4@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Oct 2024 20:13:12 +0200
Message-ID: <CANiq72=yDU=5xRVp_BLdocqHe0hfs6FiAhz6dwpbfyHckQSudw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: page: add Rust version of PAGE_ALIGN
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 1:34=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This is a useful for helper for working with indices into buffers that
> consist of several pages. I forgot to include it when I added PAGE_SIZE
> and PAGE_MASK for the same purpose in commit fc6e66f4696b ("rust: add
> abstraction for `struct page`").
>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next` -- thanks everyone!

    [ Added intra-doc links, formatted comment. - Miguel ]

Cheers,
Miguel

