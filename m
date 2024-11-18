Return-Path: <linux-kernel+bounces-413211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419259D1544
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB593B25F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA741BD9C8;
	Mon, 18 Nov 2024 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NiTnu74c"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF45A1B6D08
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731946449; cv=none; b=eLHE16UajvFyhBbyG1bf7lAcjJYnykoeIIQJBho+wEUrpLOJWfmBQ1WY22b08tAodg9TXOT6pfyFc9/P4O+1EDhojwRCYvtLad5HWYlKbHo/U5afZ6Hgd9jk4tI5a3BA5sTFTnpzq85uO2UjTnxMUI4j3/bCaSg95s9aKPr3bjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731946449; c=relaxed/simple;
	bh=vUYlcJUjbev1i/9+ZP5KIlinBPO9JzcGVAfOO+t4xiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXrjrCi2laAgmWok8fNk1yHsi/bAxnPf3FTw62b7OzeZciRWBCJuKoovQJPQew61qkaeiR3zotpfIkbjLE03Pjybn3NqFQFZHffyO2QxJvluYe6CBWgvmbHyGkFMbFy6zipdlhHgiEJm1ZRYvrM4bKqqusc2QwbDYvwwyAIfXG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NiTnu74c; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460a8d1a9b7so500891cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 08:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731946446; x=1732551246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgQtX3b2sNjnE8zCLQLIEHU/IGPvSB2hdJmfWtj8vrk=;
        b=NiTnu74c6aWegdnG4bJoSHF0DdMXwYyKMVBpiBcxfuf8smvX2QhLYS1cYyMY6X8Ijo
         r1fNCLvx/Zln3WIc673FwhBGcvE2dYXqdWaBpujLFZcAk/zRjXrD9EAILxfmGHkPZEri
         5saznyZuMx3JAEBxGfx/uPOaz2SANumqTl8S5wIm8bWuQcTQfop3e28J1uNsjNVab7o7
         /13vj6xyE6vzQPEcRPgSkIk0MaXbA6vNSkY3c9PwnQMd6aqiM24wsn0HKYEw2hoEigE4
         wE4J2+Rp5cIrGUh0+adkPpzxNeyE9hEvn6HiRaoyTNdXBZlWrN6jINqQPJqQQhrycrO1
         LGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731946446; x=1732551246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgQtX3b2sNjnE8zCLQLIEHU/IGPvSB2hdJmfWtj8vrk=;
        b=IQleSD56b6k9xqwmu5W1QcQqUJhrHnkPPYbWbEuWghCOHFaPSQRjyRwmSAQKh4kyaH
         0hJboAZQ9WXBzn40x/EBirA/9lPXa3spzToGp9YT5xy0f0qRIwmGTICKKr6gggCcwgwS
         zytz1SHozloYqpUevwcW9iDyczG3KPeGXExUmv4IFTeMI/yCmRZepD5GV1U9KqH2Gv1R
         hjs0TgKGOK/FsL9syfVwotW/sgyIIV9LIEXWWUrA7MtZwLkeew7PiYRfYakL4MVopi8F
         585hvCKwdH5YtpoZ+LuIbVc+lwk0NHzHlgJehBF0foEH0N6+ktq7W+f1CkyCcTDZ0Num
         HgYg==
X-Forwarded-Encrypted: i=1; AJvYcCVbTQ08aJp6eaNr7k/Yb1FK2wAb2z4uDit39aDlOc5aGBve6K8CCUtVefmemLtosAJOx/yobIfCVGPhdo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVeyv2YJwmHk6sa4AXaW8RGXCcDn5TarOUbY0od5+ncXETxEBL
	2r4VgDmD52SSUo8KY9pxuIvxYAZyT+m1T/pzsPuhKCB9Vp3FhZWCjR7CxMh9I82BIQ1qb9o35zG
	Pe0ONaZgpNl4AD8UQ+dpWZpqT6l0A1po9+SFn
X-Gm-Gg: ASbGnctM+qfQyS1dJbuhqmRkssEdQja0duPaK1QDd/wJt3NPZoZ9hH5I+YKmN84WcW9
	OtGFMTx6Dv3xyT/vu+50c+ljsuxm57A==
X-Google-Smtp-Source: AGHT+IHoE7/aCHotukRoUu4H4VbQ1/F4lGejyuSD3dcDuVxfpACZZ6+M09T7GFjLtVDZR877r1fa0KWxO45WSo9TeDk=
X-Received: by 2002:a05:622a:2988:b0:462:c158:9f5b with SMTP id
 d75a77b69052e-4637156d12fmr5824231cf.19.1731946445606; Mon, 18 Nov 2024
 08:14:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117170326.1971113-1-tjmercier@google.com> <468d41ad-9f89-4a83-8eb1-9bd7efaf1367@ursulin.net>
In-Reply-To: <468d41ad-9f89-4a83-8eb1-9bd7efaf1367@ursulin.net>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 18 Nov 2024 08:13:54 -0800
Message-ID: <CABdmKX2203KMx5P2x02C=YFCtiR6b5u2JzLS9SbPRh08FzqAKw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: Fix __dma_buf_debugfs_list_del argument for !CONFIG_DEBUG_FS
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 1:15=E2=80=AFAM Tvrtko Ursulin <tursulin@ursulin.ne=
t> wrote:
>
>
> On 17/11/2024 17:03, T.J. Mercier wrote:
> > The arguments for __dma_buf_debugfs_list_del do not match for both the
> > CONFIG_DEBUG_FS case and the !CONFIG_DEBUG_FS case. The !CONFIG_DEBUG_F=
S
> > case should take a struct dma_buf *, but it's currently struct file *.
> > This can lead to the build error:
> >
> > error: passing argument 1 of =E2=80=98__dma_buf_debugfs_list_del=E2=80=
=99 from
> > incompatible pointer type [-Werror=3Dincompatible-pointer-types]
> >
> > dma-buf.c:63:53: note: expected =E2=80=98struct file *=E2=80=99 but arg=
ument is of
> > type =E2=80=98struct dma_buf *=E2=80=99
> >     63 | static void __dma_buf_debugfs_list_del(struct file *file)
> >
> > Fixes: bfc7bc539392 ("dma-buf: Do not build debugfs related code when !=
CONFIG_DEBUG_FS")
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > ---
> >   drivers/dma-buf/dma-buf.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 8892bc701a66..afb8c1c50107 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -60,7 +60,7 @@ static void __dma_buf_debugfs_list_add(struct dma_buf=
 *dmabuf)
> >   {
> >   }
> >
> > -static void __dma_buf_debugfs_list_del(struct file *file)
> > +static void __dma_buf_debugfs_list_del(struct dma_buf *dmabuf)
> >   {
> >   }
> >   #endif
>
> Huh I wonder how this sneaked by until now.. thanks for fixing!
>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Regards,
>
> Tvrtko

Thanks Tvrtko. Upstream there is currently only the one use where it's
called with a void pointer which doesn't generate the error, but
KernelCI caught the problem on an Android branch where it's also
called with a dma_buf pointer:

https://dashboard.kernelci.org/tree/5a4c93e2f794001a5efa13c0dec931235240d38=
4/build/maestro:6737e60d1a48e7821930345d?tableFilter=3D%7B%22buildsTable%22=
%3A%22invalid%22%2C%22bootsTable%22%3A%22all%22%2C%22testsTable%22%3A%22all=
%22%7D&origin=3Dmaestro&currentPageTab=3DtreeDetails.builds&diffFilter=3D%7=
B%7D&treeInfo=3D%7B%22gitBranch%22%3A%22android16-6.12%22%2C%22gitUrl%22%3A=
%22https%3A%2F%2Fandroid.googlesource.com%2Fkernel%2Fcommon%22%2C%22treeNam=
e%22%3A%22android%22%2C%22commitName%22%3A%22ASB-2024-11-05_16-6.12-370-g5a=
4c93e2f7940%22%2C%22headCommitHash%22%3A%225a4c93e2f794001a5efa13c0dec93123=
5240d384%22%7D&intervalInDays=3D7

