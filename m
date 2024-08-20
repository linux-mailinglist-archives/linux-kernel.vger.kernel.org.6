Return-Path: <linux-kernel+bounces-293637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615DE95823F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0742835E1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D279518C332;
	Tue, 20 Aug 2024 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsSDqzOD"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7409918B46D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146197; cv=none; b=RQzG3i2YqyNTmlpjdaIgAh4udAzrV8MbTppyAIu+qY/Qktd9AL/i9XrMnikKAAlWuN3VPzVdljOEBWbBJrTggGxrG55Suy3Gd/zwa2NF1J8lmTtWoJxkN4GT37QsJusIo5lUMeS32Bmp5xeiHWJfry1t7HpKaJ5N6c1mnSLKjNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146197; c=relaxed/simple;
	bh=sb1jtCDxBid5WSwcFani2QSgicCBKLpqb69hGoPzbD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PunFDnMK7TJS5+sY4Nq9Ze/7IhCmd5Noygflnx328Uv1xAJK++HbPs32noYDjCHRETYjbZWoCT2dnPZ4SYDtZZ9/MKOjkxn3D8e8zlzt4sG6w4gxHMzSk++7B/DseHTwgzZH527DPwF3ExqlZF2gf8TKg4lVh+2rctVYwGB8Y1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsSDqzOD; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4fce23b0e32so161658e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724146194; x=1724750994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GU+ib55SwosTEGR00XVxXfPeAl62oZ32kSm5gFZVL0=;
        b=jsSDqzODFCSIqJGYfzZX0k6te1EdRitj1zocz7HKQNhiEHVE/fJbyScnCWy7AjNrmw
         d2b9FK0uOO98DOhhp0G73mfVNH0jBNlzacx7EzKdB/IB6FMcjU8M+6wQ5xV3wEZcaPM9
         yH9fHxHPdWjQLWpOtgrWA1oRQGKKQqlK4mdNaY5Lei6i28FjU7Xyki9RHzXOHibJyNR1
         o1BG5FVhe0rVMVh1MKAbtWMb/K78yG4YsaW9vDdY0tBe4cyTJ3fsCkg6TFJ179JsQbUT
         gHv38yBVrWkgaAUJqUOVBMbuLU4H+lf/FlnM3E6bcIUE71EFtI6GHGCa9osdxGXfBwM0
         dvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146194; x=1724750994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GU+ib55SwosTEGR00XVxXfPeAl62oZ32kSm5gFZVL0=;
        b=HMUli0Q5iItqJ2fGmONdjeoR6zL2B8fBqfsXzbEb9Ab1MmsegAX2Mze5er8rKxa+58
         Nro6QRcwc0iLkY+a6UHchFf5H9ytVobW/0ZwX1oPVfUMYoFjsX7vs04pVPqA4kx94phE
         eGjd6cOZT+QSFX+i6csFrWajjX+FeH5PesgNDXaPnHViCXww0GTIuJZv8QXGI+KWuDIt
         O0VnX3TtkxGJ9hj5psE4z8qhX0083Et08vcctUJxztm4IX3lBPR50nSqhteGzSUzbaO4
         UZWf0OyiwX4zGfp79opa+Y1tiS7RA1Vkls1vQXcktuBoA9a3TzoVWiZlaAhD3Wh9sjs4
         aCjg==
X-Forwarded-Encrypted: i=1; AJvYcCXtGXt1kHM4HRBDQyGCZYmT4Tji8HxA1p1D2kKvH/LT926ZazE5hUVdZlQvSixg7ycIZcAb3vjSWcGGGF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIeMs76epyv3kGvDOVT/NgWVNXMOaQcYBASr5H7k6T+IAq/6m/
	EMXu+pxy0xwpr2/GBjQfmzdlgNSyAwYDjkQJvr7TtJMcSxOwb5PaVD2Jg3nDW0by3Hwy5duyObH
	Yx/ySYp/dq+LuJpo04WXZl4sqKgCKLKTN
X-Google-Smtp-Source: AGHT+IEIYbRgLp4w1V9OzdXHNdXr1RoUsCm776UbA94uFv0+YtzUMfvMszjilV4jsApA1uQBREkczS90OGqvv9AOBcc=
X-Received: by 2002:a05:6122:c96:b0:4f5:1978:d226 with SMTP id
 71dfb90a1353d-4fc6c5abfe1mr14790348e0c.3.1724146194017; Tue, 20 Aug 2024
 02:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819025207.3808649-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240819025207.3808649-1-hsiangkao@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Aug 2024 21:29:42 +1200
Message-ID: <CAGsJ_4yQMN+j2UMWO3ycRqiwh16sOQoSQSMatNg667Qzr=QmPQ@mail.gmail.com>
Subject: Re: [PATCH] erofs: allow large folios for compressed files
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 2:52=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> As commit 2e6506e1c4ee ("mm/migrate: fix deadlock in
> migrate_pages_batch() on large folios") already landed upstream,
> large folios can be safely enabled for compressed inodes since all
> prerequisites already landed in 6.11-rc1.
>
> Stress tests has been working on my fleet for > 20 days without any
> regression.  Besides, users [1] has requested it for months.  Let's
> allow large folios for EROFS full cases upstream now for wider testing.
>
> [1] https://lore.kernel.org/r/CAGsJ_4wtE8OcpinuqVwG4jtdx6Qh5f+TON6wz+4HMC=
q=3DA2qFcA@mail.gmail.com
> Cc: Barry Song <21cnbao@gmail.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thank you, Xiang! We'll run some tests and update you with our findings.

> ---
>  Documentation/filesystems/erofs.rst |  2 +-
>  fs/erofs/inode.c                    | 18 ++++++++----------
>  2 files changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesyst=
ems/erofs.rst
> index cc4626d6ee4f..c293f8e37468 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -75,7 +75,7 @@ Here are the main features of EROFS:
>
>   - Support merging tail-end data into a special inode as fragments.
>
> - - Support large folios for uncompressed files.
> + - Support large folios to make use of THPs (Transparent Hugepages);
>
>   - Support direct I/O on uncompressed files to avoid double caching for =
loop
>     devices;
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 43c09aae2afc..419432be3223 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -257,25 +257,23 @@ static int erofs_fill_inode(struct inode *inode)
>                 goto out_unlock;
>         }
>
> +       mapping_set_large_folios(inode->i_mapping);
>         if (erofs_inode_is_data_compressed(vi->datalayout)) {
>  #ifdef CONFIG_EROFS_FS_ZIP
>                 DO_ONCE_LITE_IF(inode->i_blkbits !=3D PAGE_SHIFT,
>                           erofs_info, inode->i_sb,
>                           "EXPERIMENTAL EROFS subpage compressed block su=
pport in use. Use at your own risk!");
>                 inode->i_mapping->a_ops =3D &z_erofs_aops;
> -               err =3D 0;
> -               goto out_unlock;
> -#endif
> +#else
>                 err =3D -EOPNOTSUPP;
> -               goto out_unlock;
> -       }
> -       inode->i_mapping->a_ops =3D &erofs_raw_access_aops;
> -       mapping_set_large_folios(inode->i_mapping);
> +#endif
> +       } else {
> +               inode->i_mapping->a_ops =3D &erofs_raw_access_aops;
>  #ifdef CONFIG_EROFS_FS_ONDEMAND
> -       if (erofs_is_fscache_mode(inode->i_sb))
> -               inode->i_mapping->a_ops =3D &erofs_fscache_access_aops;
> +               if (erofs_is_fscache_mode(inode->i_sb))
> +                       inode->i_mapping->a_ops =3D &erofs_fscache_access=
_aops;
>  #endif
> -
> +       }
>  out_unlock:
>         erofs_put_metabuf(&buf);
>         return err;
> --
> 2.43.5
>

Thanks
Barry

