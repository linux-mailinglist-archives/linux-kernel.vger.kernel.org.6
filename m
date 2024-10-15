Return-Path: <linux-kernel+bounces-366703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A7099F8C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97EC7282BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843671FBF47;
	Tue, 15 Oct 2024 21:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9nby1db"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47771F80A8;
	Tue, 15 Oct 2024 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026821; cv=none; b=u5FFuJOgpjnemBhclZTwOb8YJoZ/aDrOb4IMdEHk1ypJp8sQy/qh7QMTPY5bJnZlHuDm5hfHHqApeuJT0s70j1+AwSf7Sgg++qVtzDdRpU0fgfksx9K4OKzX2kAnRRR2z+AnHjGVInei4veIoV2MAw6ZtQIAGoxnUL5lp7rXQhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026821; c=relaxed/simple;
	bh=srU30wlT2wsVrJmZPkwMohWcppPywLLb+E2fsMsQAPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muvqn+zGN2bmPAy+cysIk4f3AnzGUY+xVliM0oMtNJHyPROJ6J8VBJ6OzfPcMC7+2ddBp9WE9JvfVplbL38yTF8SweWWTzaqxzIq+kLTl0yxufSfuX8ZXQp44KJl+FgOE2vimT+3aGGVzRZHoCFZDZAfSa5hIHpkuDGZ9uJSk7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9nby1db; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2e31aacbbso451852a91.2;
        Tue, 15 Oct 2024 14:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729026819; x=1729631619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOu0ihc9uIYIAfX2AUeosgsSEBssXUcp9S/hXeZuKE0=;
        b=Z9nby1dbRvpJkRCIWBnj4DCmdyxl6ueOFuwkabCBjecKajUyo9k9HazvtztBsgNYOW
         RF/IWSEtqJiTd4IzMpDTUEPes0Pxe4EPzfqaI73Ynlk9LjWSwHclKqA81ZqyKiMSgyun
         ivrs1MxpDa71JZiqBsAt46zH5V+DQ2S238vR1hPTbzSN8dg0QrSubmO5mNARobkFZYkK
         3CkosEiqSKMcxboMRWv0F4idHvQAih1+BmHYLSYP/dDGEtvvxOMydkk7bQlBn6THjjRj
         60v80JOHQrqrU9bNXBF1OaqM40Rxx6WfhVLAXMcYr40GcsBAcp0m9Oss0lK+L8i551bs
         6GRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729026819; x=1729631619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOu0ihc9uIYIAfX2AUeosgsSEBssXUcp9S/hXeZuKE0=;
        b=UkChtQ7+ko96IUrx/nMNZEmisqHboJO23ja/u+qLYHepj70WTodiPSV9OLny3YsJIv
         GL5TLQOU+92qWs49xP5H5FMUGH4TAwm4YCgURk7v6POA6qHFR8/miXgal1LfIv7pU59S
         FmT8c+FSP92e4GebEdi5qWBTLEiO9EuMBmH8sPJldNNI7jKNNHIz8ysR0oBnCejImNiG
         RkTuO1UVV+cbK3ShjopUJwFvyRcyvLL1t5FJT7Sm6RjUC43lIenYxC/Ja1KMtHgTvE90
         n0pq7r+n7AwGYgYGcvwM7FdUVXmOT/0fXz1sWIJEFB3rSuW7xhOblKtGFWr/MPv5XKth
         FnEw==
X-Forwarded-Encrypted: i=1; AJvYcCW47KNUq3VCQemVfIpdJiYXoGlqZCE+UI1kgWs6ngv7Pw4xGlVnMOBJB18eWFpD0LOhQU8Xt/NkUIdMhs5cjAk=@vger.kernel.org, AJvYcCXD2VLcL82YSRUzrgk1dDCQ19s00fBdv+WvruOPFf9nbEukxbDQIjHaZbkL2MNhgvMeJyy6yuPUz2huZ1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd2ig6bfZ3ntQWA/PQp9mo9CdeiDa345lxkMn468kYgxCNhfA3
	5CLSFDBDfEb0QTetOfvsX8a+kFdompjxzqSZj36p+MzZPGUpuzVI3bRNz8smW+g3BLzrZVtm4xB
	ZZdaT4NO8Bpm1Apx0PAshtjHuUu6wa7r40Lw+Eg==
X-Google-Smtp-Source: AGHT+IF8kAzRKBXrIifOwRFtD+RFl1CuI4fQA97YZBFOx8cLVWjZ0lhvVZZy/fop5x2p1PZi1RwSxhR23jOZe0cVkCo=
X-Received: by 2002:a17:90b:2092:b0:2e2:af5b:a18d with SMTP id
 98e67ed59e1d1-2e2f0c55102mr8932393a91.4.1729026818903; Tue, 15 Oct 2024
 14:13:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004154149.93856-1-dakr@kernel.org>
In-Reply-To: <20241004154149.93856-1-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 15 Oct 2024 23:13:26 +0200
Message-ID: <CANiq72=d4hGNvw8tYNdeVozaMsnJ2BTxhZE_a4sRe73pMC5K=Q@mail.gmail.com>
Subject: Re: [PATCH v9 00/29] Generic `Allocator` support for Rust
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	akpm@linux-foundation.org, daniel.almeida@collabora.com, 
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com, 
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, 
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 5:42=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> This patch series adds generic kernel allocator support for Rust, which s=
o far
> is limited to `kmalloc` allocations.

Applied to `rust-next` -- thanks _a lot_ everyone!

    [ Fixed typo. - Miguel ]

    [ Added temporary `allow(dead_code)` for `dangling_from_layout` to clea=
n
      warning in `rusttest` target as discussed in the list (but it is
      needed earlier, i.e. in this patch already). Added colon. - Miguel ]

    [ Added missing `_old_layout` parameter as discussed. - Miguel ]

    [ Reworded typo. - Miguel ]

    [ Added backticks, fixed typos. - Miguel ]

    [ Formatted a few comments. - Miguel ]

    [ This patch starts using a new unstable feature, `inline_const`, but
      it was stabilized in Rust 1.79.0, i.e. the next version after the
      minimum one, thus it will not be an issue. - Miguel ]

    [ Cleaned `rustdoc` unescaped backtick warning, added a couple more
      backticks elsewhere, fixed typos, sorted `feature`s, rewrapped
      documentation lines. - Miguel ]

    [ Fixed typos. - Miguel ]

    [ Added newline in documentation, changed case of section to be
      consistent with an existing one, fixed typo. - Miguel ]

    [ Converted `kasan_test_rust.rs` too, as discussed. - Miguel ]

    [ Removed the temporary `allow(dead_code)` as discussed in the list and
      fixed typo, added backticks. - Miguel ]

Cheers,
Miguel

