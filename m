Return-Path: <linux-kernel+bounces-316602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960DC96D1D2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB362811ED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B541E19924E;
	Thu,  5 Sep 2024 08:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LbRXe4x4"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FB51991D0
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524163; cv=none; b=a4nJWL9nBE0y/e4aGheXX4s3sbUcrfRpq5+j2kE3Rx5EP1D03HLwitNHBkHVDX9rPUFhsT1SM4BNVAt8nE0u23Dg0J+duS0+eozEMbxMQJqJwDm4qgRSb6A4fjqIdkyZER4eqbmUjgcaUOBWycCw6giwtTas7dUkMtwptEmv3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524163; c=relaxed/simple;
	bh=zzEfaENRIqRQl0JbYcNKk5MHDb85IJy5SJDJt767CxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nb7SpJzLMvrtwoIvxkP8mlfs2J0stnlxErt24Mbkbkt9XgL6jArU62PF6VBw4UUww284eZqdAdZZJb7IqWWcD8868OkIK7B2gCEks3pKRUOgg2pG45bfqOSP+xyAvyXQyQTFwybbOi3gGq4pHPtEhdsKkEISnn2hVfQdobORcDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LbRXe4x4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42c7b5b2d01so4314885e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725524160; x=1726128960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzEfaENRIqRQl0JbYcNKk5MHDb85IJy5SJDJt767CxQ=;
        b=LbRXe4x4V2G4d3x+k4gr0uEDrvMhlC7P3i1R9+VrswR+tJFo4qXR4z794I+1f3xINW
         j4L0BV9AMxqrtxFIgGADGJoWGR1CmEhipt2wmT4XMum/ohLLMW+nHKWoPrZbnRrhF+Cd
         0OJz2cJguCJfBxu/UBEBAdpc1Ptp3/nN2sOyy/qHAdYQCp1wyE7Ryq8PXYxuWDdaZYfR
         5SLwOGwRzcl9nDFz+Q28JdaiNX7j68ZlgmhDW6WUUI3lP4kpEvKjAys/NC2jX5sNritq
         WU4SqXyTb3AvrbHzfkDn59HAvlfqcr1qRisdRuwF73iYMI9vdg0uMMBqpYoh1W8xwLao
         8jzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725524160; x=1726128960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzEfaENRIqRQl0JbYcNKk5MHDb85IJy5SJDJt767CxQ=;
        b=bORhxGPTp7oqjeYYc4SjcKtQ6HEXIaDYxBmMJ/JYxAhu7NixVwwtelOc0c2/HW3jqo
         vnbBpNwOIeY1vVNm+aYqh7dLaScBHFm95aS9MJ5CrHC8SLEQ8vhspvQHsmVphG+Sd9Db
         LksqiCpbPIoY/CTPYQMZRPqA4MrnFRByDSLYNQbUQ2z9IvXXtjMIBJ68RbKWobiXyEDY
         +L9JPkok3VPC8GBemRL1bXAtPTXhuHi7R8uQm/8Lj71Cnf0mVm5dzhjWdam2uvAjZ/T6
         xQa3TmhCY0ehy1I1vFmB8hcAK7jl9rLdF9I1TH9C7k0hj3jb0h85/3oLzpcGpzOFOQZK
         7x3A==
X-Forwarded-Encrypted: i=1; AJvYcCVS54KyHX8b/EPvm57a/XPF7QRTsQctfEvSJbnqpWB2fJARNA/Fa5fUANPX2Fn05cwEm7cDi5Evn/TrQdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhpY4b53Q5dwcogRuSdwDvnapGVIlPZElIdGqC2hKiTHhr/PEG
	1HJ0ImRCnluf8f2Gu/bGkyl4yLuvjFnNIVHWBC6Us7rkxO1nn4P2mYB8N4FKzDcrj3ckX84KEm0
	7IOVgIlbahNz6TK3W/BdS9z10DykunxNL+Z2x
X-Google-Smtp-Source: AGHT+IFGe9FwF4ew6fPFdL2Ygl8vPEA3LpCNMQCfRGgsrU2sesbleRr+RS60eiRwK9tP5YwgxFA3l6MeMRDAa53pyQU=
X-Received: by 2002:adf:e6c8:0:b0:374:c3cd:73de with SMTP id
 ffacd0b85a97d-374c3cd74d5mr12499736f8f.35.1725524159551; Thu, 05 Sep 2024
 01:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-17-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-17-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 5 Sep 2024 10:15:47 +0200
Message-ID: <CAH5fLgg20kDCJfD_6+fTSogOnpqK0x3a6eKaTahgSvdgfFzSEw@mail.gmail.com>
Subject: Re: [PATCH 16/19] Documentation: rust: add coding guidelines on lints
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> In the C side, disabling diagnostics locally, i.e. within the source code=
,
> is rare (at least in the kernel). Sometimes warnings are manipulated
> via the flags at the translation unit level, but that is about it.
>
> In Rust, it is easier to change locally the "level" of lints
> (e.g. allowing them locally). In turn, this means it is easier to
> globally enable more lints that may trigger a few false positives here
> and there that need to be allowed ocally, but that generally can spot
> issues or bugs.
>
> Thus document this.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Wow, does C really not have an easier way to do it?

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

