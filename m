Return-Path: <linux-kernel+bounces-422634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B9C9D9C45
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA6AFB264C8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590C11DACB4;
	Tue, 26 Nov 2024 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d2+fmP8e"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217091D8E01
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641332; cv=none; b=jfg3J+fhM8E3RMnMDuthS+T66W1/yTgIPcANZBdA/MNrdD+2GQbUYyfOP8vFDyiJrX+EbKamGhVmFMxmt4/KZoabjmRDczLT0zJ0X42a8nMc7Jr2B0hx8SdT5ZjjLP0IhxM/RoRwLzZf3C2POVdhD9961qCdVUZILBexH5HK7to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641332; c=relaxed/simple;
	bh=VqAQFe7mntOdBAlVZcfHJCCujSRH2afcpIxBiKlUtXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7jerZy8B3MM/7Bk7JlbkdazWVlX7UTvDiBvN0DY5jHsomaq5vkO1m8TJUobWarGAHzZj7xRzlqq+RWGWS0wgq4A1Ci2rA2fih+IYFdzvmHTFjz7O8vQrufcMc0lfoq6vOQf+SlGfQJX7NCTOTpCNsFEOxBRSpARvnWjtH+9TlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d2+fmP8e; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d027dc53ccso11532a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732641329; x=1733246129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqK5DtYfTpwNTtQIv9zMAjmqjKBcmKak3zeZPF/XA5E=;
        b=d2+fmP8emIw/mqhYSogXkAeeJUgeVW1eY33MigLxLQNLNIdywRExgAZvipcArV3Utj
         e4za2on+sBaxouPRUls4+3BPAOlPIyCyg8utqwhAfCxUm6n9NPkjYeLceNP1CEPinLFH
         lX20F0ZtRX9GSJ8oBOuqOtSCjkQzSl+QWtQiIfz40Ur6e09rl0QzLTBvIAW0bI4lPIl5
         8Rig9qTNrt74TTkrtDUBqPcHsbADo8+DqKXrsHN+pvUfPmFno8IwNYYa+E581t2sweDl
         5vXWo2rbSralz+S3ka7+cVjA59uHZgKXa8vL/UnouMuezx1vb9CPV6HthJ7UanIgIGus
         lRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732641329; x=1733246129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqK5DtYfTpwNTtQIv9zMAjmqjKBcmKak3zeZPF/XA5E=;
        b=mVo/BS6iuxzF/KQtiDk93kULrHfk+KEiUTdNseSssaXPDrPaWIokt1aFCWS+QxboyN
         pgs1UMp42s+RdVzycfMR8Ol0SV5+kAyONVZOsdQHyuCIhrarSTkY2xkqAS6RDPmNlxRr
         J+JupSwHV1NotkBXU9kXHgUG7XXh3wCl6aRfk/srUros6Hkt/6bp+slsM/kOhlYDQkcp
         7LDZMDdVSE70i3hfF8d71C6YlCvrhV6nX26RGKmZtZX5UFaTsQv3qgBIQSLgMNtp2d/D
         vxFTiU7ieYNtoFPrLLslUrelCp3jNBTn93T2nz+wyam9yfmwg8Olm+gO+Ll1+Oietfz+
         WH/g==
X-Forwarded-Encrypted: i=1; AJvYcCVC83YDSfgAB3GaLIEX6By4xwvYXwxiT6fugZV6VEHBzf7NN+KgKV42lKiqQLhhqKMzwqIUYGogFI/YdNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyh8VoBB0eTxKnK9ndJPfXBecH4hGBgSpJ4M+UP67sXRjsXIiJ
	VMw000D1hRFDlnoHGFQagOv4+GS3T5yj8kkQh7cxsnU7CoUngKRn7gTTf5yMMGf4y0D66vToWeN
	iY8AgFowAkeuf1XGzahFhnp4FQXpQwnA7yfcn
X-Gm-Gg: ASbGncsYuOYK3H+O4s9dA8Z9uvcISl8QtlzzbTp+gtfNEvPpKYX0Kz/gRa4tOgozYqJ
	6xOBg5f9v4RyqbxAfW1Ej32zUep4hWGlczYvEbbctCfgteXxviwUeTlwGu2A=
X-Google-Smtp-Source: AGHT+IGZRocPcPSEtcuNErKj4DIDiJvXUShdMqtpfNV3ra7ee2dGktWA2YG43z+yQQWKUgLsr0A6/dsgXytzrSe8JgI=
X-Received: by 2002:a05:6402:282:b0:5d0:6bc0:7706 with SMTP id
 4fb4d7f45d1cf-5d06c91da98mr93597a12.6.1732641329016; Tue, 26 Nov 2024
 09:15:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com> <20241122-vma-v9-8-7127bfcdd54e@google.com>
In-Reply-To: <20241122-vma-v9-8-7127bfcdd54e@google.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 26 Nov 2024 18:14:52 +0100
Message-ID: <CAG48ez09fS1v2gWbOFx+uQd7Lj+z2x3LhL3hfpQzpVHdNJ5UJg@mail.gmail.com>
Subject: Re: [PATCH v9 8/8] task: rust: rework how current is accessed
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 4:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
> +impl CurrentTask {
> +    /// Access the address space of this task.
> +    ///
> +    /// To increment the refcount of the referenced `mm`, you can use `A=
Ref::from`.
> +    #[inline]
> +    pub fn mm(&self) -> Option<&MmWithUser> {
> +        let mm =3D unsafe { (*self.as_ptr()).mm };
> +
> +        if mm.is_null() {
> +            None
> +        } else {
> +            // SAFETY: If `current->mm` is non-null, then it references =
a valid mm with a non-zero
> +            // value of `mm_users`. The returned `&MmWithUser` borrows f=
rom `CurrentTask`, so the
> +            // `&MmWithUser` cannot escape the current task, meaning `mm=
_users` can't reach zero
> +            // while the reference is still live.
> +            Some(unsafe { MmWithUser::from_raw(mm) })

Maybe also add safety comments for these nitpicky details:

kthreads can use kthread_use_mm()/kthread_unuse_mm() to change
current->mm (which allows kthreads to access arbitrary userspace
address spaces with copy_from_user/copy_to_user), but as long as you
can't call into kthread_use_mm()/kthread_unuse_mm() from Rust code,
this should be correct. If you do want to allow calls into
kthread_use_mm()/kthread_unuse_mm() later on, you might have to gate
this on a check for PF_KTHREAD, or something like that.

Binary formats' .load_binary implementations can change current->mm by
calling begin_new_exec(), but that's not an issue as long as no binary
format loaders are implemented in Rust.

> +        }
> +    }
> +}
> +
>  // SAFETY: The type invariants guarantee that `Task` is always refcounte=
d.
>  unsafe impl crate::types::AlwaysRefCounted for Task {
>      fn inc_ref(&self) {
>
> --
> 2.47.0.371.ga323438b13-goog
>

