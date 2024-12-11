Return-Path: <linux-kernel+bounces-442042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 455649ED74B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E023C1684CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CF220B7F8;
	Wed, 11 Dec 2024 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YvRsnA53"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8014D225A52
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733949331; cv=none; b=BXHqr+nFEgD8nVYpkRD8DG/oiUDdoCMEldMr95/YF69N7Vq/4i84mfwvWugmo3M7kGfHjUN5EzzkkwwAyeeVi+fs1/+uFgZ5p3iyWCcv8kJzOWkIzQ4mEiI72oTyQvRJJxlS26vvyEKbJ9JVCVSOCEsstUomRBMc3y7FY1sPC9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733949331; c=relaxed/simple;
	bh=mBQNMYaRZPj4GJYLEP12uUPqMgwIV4RsKsIMDMqNSeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VW6XK/z4XNJfLsrasVRYwktAqLAXgCCO5FuJoDNUfKsm0SjqSPjeDgxwHq9jRiRadBKAxXMtx9040kfN5rGHcCu3CjxjL0eITiRmj28jnodjPnBQgiqyNiMG8vJ12uOuBspZUkwVFJpUj679bP3D7P3Sn5Sr5XFpjAR56SFxQzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YvRsnA53; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-215740b7fb8so2105ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733949327; x=1734554127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pj3NqJgTvcOXsidYtItq0d+PPAmb+aX2PnoBuGfq+g=;
        b=YvRsnA53s/zoDZWlStfTE+RfzdsbSFtYFRVCRtMw+PL/27+IKQSIExU6moc4Pa7dbA
         Pcnv9HwnBMb/g+Ey0TV8LhEucNXQSqmTmrxtJMSB0uhTaiax9eDE2lN/da9x9chsWcxb
         jK+o7l5vWNNV7b088LyHfgLUjCdVgZidQFPvam6aGKA3W1JD7ms2EO/jnlt5JWoEW0P1
         YZ7BkLjmjWWfQDLHu/ZQfwICWiDGF9fYefdiUhpkVZYQBg40TBsDHlvSmUeSgeNmOSmU
         9IRAF8k0nm/7FJsyJhbtBh0JXneEoyGjWMZVbCUi0FJcIeB833Jz3jUOBJTjWxqT+BlE
         tOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733949327; x=1734554127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pj3NqJgTvcOXsidYtItq0d+PPAmb+aX2PnoBuGfq+g=;
        b=uKWhpinW3l5hneyg5lqVK+goMgSQBWUukZkmBRHJckYF976LeKCyEbLxxKqkNvZx4r
         RRUCJDeCaZ4pYm8iIZ8MMTc6evIjopN++nEXGRPqxhankvvAiqCAfYvxaCX2BqkpF+p+
         tocxH/7zg+nmwNlRIE645ymnJYlZW3PBMH1W/zJfapN9Y6VlSV0+ajHu+W2yep5Q/AmK
         P7qN1Im5iiR+s8FA8btiA+VgSjt357wJNCGeOHYGBtfQwVdHmvwHHW/M+xX1VKu0ia57
         pqYxNRs6HjtEW4UWdR7i/8Hlc4PKOGeuiujKDMoGk600ojCmHjJWeGkcyb9+A0xlgaDR
         4aMA==
X-Forwarded-Encrypted: i=1; AJvYcCUkNNo7J+D5rlHBkJGvEujz/Q4e+tWDxyRz44kYNekM/Cc60YCLO/QvYKPVSaFkVJAsTDiHjVT6xbI7nug=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFBJw0l2bYOT1yo0geYMC0HUfLhqJAGF0f79VIyFJVqlJ/qGQA
	2Cj/51SVHy/adXInmX9YMwy0OEdHsdiUpfAqB5Y70XbSBSGbIdBN7vO9sTFfahiPZN3CzB2M7lc
	yDBdvLe3vQGQknzeFwXWCVVOs/FSIglBuIawQ
X-Gm-Gg: ASbGncvAmcLTmptxAoD+6ZmTqaLEMFXBx5Fkadu35aG9xT15zu7cEYdIEv+nHb5PfTm
	646VCngyX3BEUpiMmKadE7KdehF62VugaYZKMyZ/Ccl+R20Yh3cIEMpERAeA46w==
X-Google-Smtp-Source: AGHT+IFcL5A8QdkAaWwqAKHbF6R5mbOYimmmWoGRKcn8LA+nn2SqIpfSaqTFtXnfuXswNyFdWPiWmgnLMkM5hynVPDw=
X-Received: by 2002:a17:902:c94d:b0:215:5a53:edfd with SMTP id
 d9443c01a7336-2178dc99062mr483655ad.0.1733949326515; Wed, 11 Dec 2024
 12:35:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210213050.2839638-1-bgeffon@google.com> <20241210213050.2839638-4-bgeffon@google.com>
In-Reply-To: <20241210213050.2839638-4-bgeffon@google.com>
From: Brian Geffon <bgeffon@google.com>
Date: Wed, 11 Dec 2024 12:34:49 -0800
Message-ID: <CADyq12wv7rEU9Bv44S8Hp8amziLxhiS0uX9_6qYQr_eN0uFRMg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] mm: mremap: Allow new_addr to be specified as a hint
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Marco Vanotti <mvanotti@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 1:31=E2=80=AFPM Brian Geffon <bgeffon@google.com> w=
rote:
>
> When using MREMAP_MAYMOVE previously the new_addr was ignored unless
> the user specified MREMAP_FIXED. This change will allow it to be
> used as a hint in that situation similar to how mmap(2) behaves.
>
> get_unmapped_area() will handle page aligning the new address hint.
>
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> ---
>  mm/mremap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index fdc1b0f1b38e..1d2522fba0ef 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1205,7 +1205,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsign=
ed long, old_len,
>                 if (vma->vm_flags & VM_MAYSHARE)
>                         map_flags |=3D MAP_SHARED;
>
> -               new_addr =3D get_unmapped_area(vma->vm_file, 0, new_len,
> +               new_addr =3D get_unmapped_area(vma->vm_file, new_addr, ne=
w_len,

Marco raised the concern that since glibc [1] handles new_addr as a
variadic argument, existing call sites which used only MREMAP_MAYMOVE
might end up passing garbage to the glibc wrapper for new_addr. I
checked and it turns out that musl does the same [2]. So I'm not sure
how this could ever be safely implemented? Worst case scenario we're
leaking stack data as a hint to mremap, yikes.

1. https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dsysdeps/unix/sysv=
/linux/mremap.c
2. https://git.musl-libc.org/cgit/musl/tree/src/mman/mremap.c

>                                         vma->vm_pgoff +
>                                         ((addr - vma->vm_start) >> PAGE_S=
HIFT),
>                                         map_flags);
> --
> 2.47.0.338.g60cca15819-goog
>

