Return-Path: <linux-kernel+bounces-339242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65A098619F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0D71F28F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11CAD512;
	Wed, 25 Sep 2024 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yvmOtMvs"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475D19F11C
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274486; cv=none; b=R8VU46b95m+TmhPr79d3wmtP5UcFeybpj8h3NOMIDKmVHxQHcRuWCtRTiPt5ZBz/C3x6HM8IYhBE4MkREPr9vai/4ech5j4skYiucyoeEVqmhlXBo7mZlu9HiHu9BM31oh0UkHHCfcSQoNpdtuVO6PLennvlFUwBQNURE6AqQHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274486; c=relaxed/simple;
	bh=obC/7/KH2c7jTGLio49zTh/+gYmG1p+8KVkj8WjaOGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFxatal2y41ZwlPXBS7XLHoZH/ze+6bD4bLc65JYm75z+cf2Jjs8sheWdUSv1mRAMwm6pfyq4UOyc3T5RkRKZZJOBy1BKKkc95PJvqzRvkwYtsRDDa+eIZINqeu13bhWVgoOftzRUB3/oCrAPIUe21EV6b9rPd/rNx8lcGSh/Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yvmOtMvs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so87086475e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727274483; x=1727879283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obC/7/KH2c7jTGLio49zTh/+gYmG1p+8KVkj8WjaOGo=;
        b=yvmOtMvsyuqmWcKgosMMwuDw1YNcL0c6yyyeMt/KM3XnwBDe7IxheCrJR1znqGIF9V
         Dwx47snfHh90QJxC0Tmsldo/M6jhry9+OTBhP97Ji9OPuV/5jQL8UCfhOU6OQyxhcjDl
         QZjZSqpYwHU6iucuQVEYlkat6thzuNK+yW+nMNJ3zlfSCJp95lD0gZmoMhHB0MpPHXuL
         A1u77LA2+myI2e+iqoAZjqdyxs7Bj7npGbhZ9GkljUw3EJLy4ZxaRgOjL1Km6vr1S3eG
         qXv+Gp3WhtVqhnjWrmIMyMVn+VRJhVArzE9DK1Ywrv8y1zvOV3Z2M7X6gCgPD8Xwgl55
         A3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727274483; x=1727879283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obC/7/KH2c7jTGLio49zTh/+gYmG1p+8KVkj8WjaOGo=;
        b=hskB0AcAfxiJNOasLvuDri9Dc7SwC1ndm9dFEnFkgZRfNp8xFhLABcl8i0kDn3sStu
         dIHLJIECWuovRtKeqMdc9Bto1a2ci5xF7pCL1MER6OTleWFHY0hgsUmtoZGS0ZC7Jeod
         9Qt6flgrUOgr6XjLCSfhp+Tsvb7QRa0He6eHq6qipUvepoeVIwogV0oIq450v35TnK+4
         SFFoiQBXD3IbZAi7pc/tNt7uvuKp78Xwdrsy2uYeWbFKZKy5aqklbVXaJnvE/DQcxwyW
         hAULcJHvUIcw6MDhbzoXvLWWgd2wqJUfB7dMAUSyClqvAkrR8lEyZn5AKwqFOinC76me
         PRhA==
X-Forwarded-Encrypted: i=1; AJvYcCUzUtnqGxl47RBojXUR2F8K/Ecka4LV0W+psi8LnKfpxFjr0pEnSeeMhQXWLG5pNDnRBbEoBiQVzLzZ5Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfKJSUilg28VHXZNtAvsAkQAsjTUxwuWp4DZbcMgED3XNQvV/2
	/1BkZ90s1Iw9F/DV+USk7qF95m5q1mpsbsMteXR+XC4SVRIILZhHcki71xTLlNfFdtFDrRFL9T7
	2ZgaFzH1RH3MXxrltZN33eNoZnAqbXxQWI+RQ
X-Google-Smtp-Source: AGHT+IFd9vRwftTt8XvUpteeBh1GBHyoPi/G9HBBRN0TTqfaKPh4NZIR8691AkkQ6GlnqZn4WH3b/ayxYAoChf7kkaU=
X-Received: by 2002:a5d:58fa:0:b0:374:b30b:9ae7 with SMTP id
 ffacd0b85a97d-37cc24c511bmr2574271f8f.49.1727274482535; Wed, 25 Sep 2024
 07:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925141944.277936-1-ojeda@kernel.org>
In-Reply-To: <20240925141944.277936-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 25 Sep 2024 16:27:50 +0200
Message-ID: <CAH5fLggG1n5RMHcE3ZWjz4m7ybG86gwSAsnh2NU5pvTL+zqQgQ@mail.gmail.com>
Subject: Re: [PATCH] rust: cfi: fix `patchable-function-entry` starting version
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 4:20=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> The `-Zpatchable-function-entry` flag is available since Rust
> 1.81.0, not Rust 1.80.0, i.e. commit ac7595fdb1ee ("Support for -Z
> patchable-function-entry") in upstream Rust.
>
> Fixes: ca627e636551 ("rust: cfi: add support for CFI_CLANG with Rust")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

