Return-Path: <linux-kernel+bounces-342796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 186BA989311
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5108828591E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 04:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069923EA76;
	Sun, 29 Sep 2024 04:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Onnyaj0j"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0143BB50
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 04:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727585530; cv=none; b=FIkE9R/3dziVxFup+eAFFn7hPNaKn7elbhyYF4aAFfbJFB6NTif9EVTNNdHSuBEeRR1gP3VRmcm+3aozSJtwNoBlN+E7HxLfqfsxN8qe6xBv7w5QUJYY/P5NXOj7fs2xf1RK7UWz3Rp2J8Fpw+QxqRT6MCLaqw9Muy8pV0/QTBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727585530; c=relaxed/simple;
	bh=jS0EBvC7XMwFo9M+zQPcxKM1gJbWMDlWI+8/9TQt4Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8a7mEy+YWZrq4pPYFQNUKQZ4wHhEzTOjfBRap0jAcCOwQEDNNhy152jYvwyH/6fGVFCrO5K+VozEie02qLi6icnCeBHCJ7DpSVaD5hpZzOvBBLT8vMHOLVHYbmG3aTffOfufaGiflQP9xDeUQ0Zh9TBxoPDQSljzzYWORi2g2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Onnyaj0j; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6dbbe7e51bbso26683897b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 21:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727585528; x=1728190328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jS0EBvC7XMwFo9M+zQPcxKM1gJbWMDlWI+8/9TQt4Hg=;
        b=Onnyaj0jSK1CT0qSPRY803oXGkqi3wJVuK42olufxicOsT4Bl1RiyONp2HTDkb6IPo
         z9QN/N6J1F27JIiiFp1EpfkH9r+NWUJzIGG2T9D6kemzeCNuMdrBIs9X9BqhVGDbEujl
         ihSG5evkccIzLZUSMnC7PM9DEqp/FlI2NTYAXKbAKAvyORhWRsWCkaTdgaMZVJa0ud5u
         iLsM671vpMtiP5CbZ+QZ4JLOa0BUWHHX1s+ooDimsUIFnJt9xbZ+7V/BPW6HkOzHcHb8
         zpBY8AN8SCeuPIdmIFlZszJZ391pWObmXQwxeOZHBWP4UrLY3kAaJgvANg2pHiug8PJG
         LRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727585528; x=1728190328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jS0EBvC7XMwFo9M+zQPcxKM1gJbWMDlWI+8/9TQt4Hg=;
        b=Fvw/p3J4zxNU14N90q3iXrOr+hb5QII/uRTgz3/2M1K+R5SNKfuObFBKjrGVlEpUqJ
         cZQ0gQVOPQa2T/MxVgy6e6eTJfSTSDLDDgmxPOpct6WGgP+J0USJHY8XK8myk7R6QDj/
         7+OrTc6KzT9UxdnGE6HDmguujmpRlOatkO4uNUiGIrqX9eGBaLdkAkpuy+AJdykJWRZg
         vt2XkORn4WCxdUPu9I7CQRlSK4+WH3TbY0q8sperj7fbfG0pZQpPDyr5frNs+msWHYwB
         Us9uyojJRMYVC0KVUFZizIEw+z5YUE6IeNnutGwlLvnJPvV7lksr1fkrGODOTn4BarpH
         we9w==
X-Forwarded-Encrypted: i=1; AJvYcCUCEranan9lUgdVpz4LxI+4tK4KZ1qTZv3DpZwtn8Wfmb3j5mSedlJQNbXLVPUNCM0EYElZuKQzZLCx8Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCAuERIdZBE/Vaj9b9KU3verZLAM/A1YJrP7ZVMzkdWAX92Brf
	tFJX+QzcB2Mk4/Lv2bI+jkLUq3mGkdTBBjB6y2OKA6rP9weNhK9JRE0VmmdszEuwolpDUJU6bSp
	vZvO5kpsH4i3Vq7Of+sGAyyxO9zkYy45VnHyHEg==
X-Google-Smtp-Source: AGHT+IHMo7X9/akLsAQal83FgKc+F7pvFVjQlHUFGrQQNk51EFPSY353VuXd0b6yO+OVBgyvQdIsjKfkuOP6FlzPnEo=
X-Received: by 2002:a05:690c:4787:b0:6d4:b774:e503 with SMTP id
 00721157ae682-6e247603ea2mr46816127b3.41.1727585527889; Sat, 28 Sep 2024
 21:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-14-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-14-ojeda@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 00:51:57 -0400
Message-ID: <CALNs47uHcW3fSfE1nvfy_m=J5H51S_B5CvWK1HsK0FDKW=bdww@mail.gmail.com>
Subject: Re: [PATCH 13/19] rust: rbtree: fix `SAFETY` comments that should be
 `# Safety` sections
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> The tag `SAFETY` is used for safety comments, i.e. `// SAFETY`, while a
> `Safety` section is used for safety preconditions in code documentation,
> i.e. `/// # Safety`.
>
> Fix the three instances recently added in `rbtree` that Clippy would
> have normally caught in a public item, so that we can enable checking
> of private items in the next commit.
>
> Fixes: 98c14e40e07a ("rust: rbtree: add cursor")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

