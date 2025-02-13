Return-Path: <linux-kernel+bounces-513790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0769EA34EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0CBC188C03D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3D224A077;
	Thu, 13 Feb 2025 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGRAuJxp"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD93124A043;
	Thu, 13 Feb 2025 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476350; cv=none; b=l3WA72TDKpTNO9u7iRWWQx+AcuQbItcJJ4FmYwjIOrLxbsOGnO2VOW8ZLFpftaK1xGVcwwX3wsvEtoK+y2Za7DYU7cFtj2wbVjGx/RsHhFpqeCuDFMwF9jlfvBykhg3TByiC2XwCddHs3EUocN8M5Sqa+DFdajgPpVfj0URzboI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476350; c=relaxed/simple;
	bh=uwaceXBbc9DYhWrRaNpwMVDjME8wm5WFYH6UetaQs6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HikhYIDPW34wQyW5waoGHUhMmdUn3tsclCDUFgGkvWpv0NRLMVPoNhjqW3pV7J65C8Qmdxl5gjcPYJaKMa9oVSD5r9M82NjlQBKwc+oy1YmQxusUgFp7RVa8Cfuaq+dm52juwnsFeSdclNpuz+++KK+LtvZ0as0OtDfshOjYXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGRAuJxp; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fa0f70bfecso276766a91.2;
        Thu, 13 Feb 2025 11:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739476348; x=1740081148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwaceXBbc9DYhWrRaNpwMVDjME8wm5WFYH6UetaQs6s=;
        b=gGRAuJxp2MSfiHis6gjGvnylDfVHERbXX4hC+AlinSIaUYKC5YeATjdFxrWXwZFlY6
         t/IMzWaFHBCMrBigwEkvZPFScvw2lKZMHZyhPGx5k/OpilZ84P50ruJEAE5P3UuAC4sz
         XqtoKIhDcCAwBoJNGiEO/oF512TjtqEkbMLywn8sMmj66SCAPE86DaOe/T/IRd1sGI05
         nLmSFWNGxyRgu+3nGxEhflxITTi18SXd8V9coSar6Y6H20pxo5mOqEg2veUkvOZVdI++
         Rj6slYMiM1Rigpp5jtiavvb1QJgoYLdRjFtFpS54wFp3ROl58SezS6eGOoiMqjoIdrNc
         4HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739476348; x=1740081148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwaceXBbc9DYhWrRaNpwMVDjME8wm5WFYH6UetaQs6s=;
        b=YFA5VCF5/2T5+7qryrLv+g/wgpOcePpSeKBN6KWtulCPXx1IkM1/NmicVikETIpgjq
         0rXeWbTpITi6OtBAXTat9ZirwNM1fMtVKpJBD8hK+qsbAa2qUi3eLZZOka7ygJ7NFEG1
         hYPEj+7nIhFlO/8qTMNovhNNHJXTy3kYN8akc6rJZTJLP46T84PJm2yj2bTxf5SIad+g
         gdGNDi4QQyXApGC4cwKW/7femD9COSPPujZEaO0sI3M3kZ7O6zS0rlE9B+cqrnbWndQj
         8EPfEUBYLu1fUvUSPekGS1LIyY/z+SWlvF0u5J8M7alllNyRw1GTrIsQmq56EySUsh0n
         tR2A==
X-Forwarded-Encrypted: i=1; AJvYcCVHpYeFpFwPKw6O2Uofrx0ssAD2+cY4mAH+KXfUzGqHQxOEe2ip9wm7vYkJBV5hDzMHjoPvNBWrNTJ6X6Y=@vger.kernel.org, AJvYcCXKT93JtuQXddXI5QtQW6JGWYOg8Bh48dgpJJw3UY80HId5aSaJlXxQg9foB7TCSyag3JMjpfUmzrPFv1BFV0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKJHPsrLDM7BFNYBY8WU2UKq73Fi0dHtDCJcOGrAaLFMfNbGLa
	sgBm2sBKEqW2DpXrZS+G94cMi4z7TkhV7AJLKYEK9DXGhxgcrTAS9QznoNM2PjWg7MxayRWYQCD
	Z3/h8qXBvM3I7VXjofxEWSLtBOKA=
X-Gm-Gg: ASbGncsgDbrNfewjeK+iDsWi/ckHyW8nlbrNy3lwz03RPe3pMFVzdI/XGkVPgOrN9kU
	ze+BhxvUuyafQlz1aal4pP9uxHDGks4sYWxd2jWxfye/vDF6BWPrBUinsOyU5FUH5+TuGL6fV
X-Google-Smtp-Source: AGHT+IEiv/zlIZZbyCdj/X6Q0o+jGzwhquBkcBkXIEbWfZa3doUwn+Fbd2U3g1vBfbkjWtWIz0ax/rMiMtuVEGcMgXc=
X-Received: by 2002:a17:90b:4d09:b0:2ee:d372:91bd with SMTP id
 98e67ed59e1d1-2fbf5bb3414mr4940846a91.2.1739476348047; Thu, 13 Feb 2025
 11:52:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-vma-v14-0-b29c47ab21f5@google.com> <8130a6d5-a7e5-402b-b05c-2d0703ac1ed2@lucifer.local>
 <CANiq72nBx3cRTUC9HWVR8K64Jbq3GCVMss5wuABzra3OLhRUQw@mail.gmail.com>
 <c8e78762-1429-4ab6-9398-ce52370eec08@lucifer.local> <CANiq72mKyvoyk_tgbMKUdzs-sJOoyEH7f1M9ipiET+XYgwCqRw@mail.gmail.com>
 <2d132129-fdf7-404d-b1f1-8ee87b838dcf@lucifer.local>
In-Reply-To: <2d132129-fdf7-404d-b1f1-8ee87b838dcf@lucifer.local>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Feb 2025 20:52:14 +0100
X-Gm-Features: AWEUYZlaLFLcNnUiCyCAZuinnyDyfGxQjG8KCqfTO_s0QUprt9i-zxzyahMMZh8
Message-ID: <CANiq72mpFzCdg8GJOZe=q8hnSbDv__obJbkCV0o-fP8iXOirrQ@mail.gmail.com>
Subject: Re: [PATCH v14 0/8] Rust support for mm_struct, vm_area_struct, and mmap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Balbir Singh <balbirs@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 1:16=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Ack, for the record I'm happy to help with any work that might come up.

Thanks a lot Lorenzo and Liam! Very much appreciated.

Cheers,
Miguel

