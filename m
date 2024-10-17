Return-Path: <linux-kernel+bounces-368921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16169A1699
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1E51F23687
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C8B1388;
	Thu, 17 Oct 2024 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qlcmjviz"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4656D2F5A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729123803; cv=none; b=tkokYAiNxVz+cJnvOCDc9nu5xwPjGhE6uJKc1TZbhQ6UXxh03askMcF4L+eRezqWBZR10TJWq2paeKQQjTlmSOo8mXMXKR85bjy9ZDFmsG4PjerHe9MxiGaZL+f+mxwMQVYX04+xIG88HmjtXncxORAeUHZg/LSLzdLzVX4yxPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729123803; c=relaxed/simple;
	bh=IlO6uTCwFsYUVRbfNrr8hXDOR6fAvnjyaa8Rrpvdxnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BH3AeaHBkOVji19kjv4vy0hA2Bmzd1kvJeRL2fgyqO9Rv97d7WL7ZzXs7TtMPqDx6F4F/3Xn+SBT+V6FpO6loF5C7vX9KeQb3FSxqyK58NRkEBOm0p1e7UD+ZO3b41gUlFCghVJz9w9XzCMEc7Z9ubs/cXrIe8xli7t1hWHq+oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qlcmjviz; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99cc265e0aso41650366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729123800; x=1729728600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zLK8NZJ63lThqHunA+xhjqEZN8qClvg0Kr82H/Gl4Y=;
        b=qlcmjvizg6klgvLUDXhjyP0tTSs4xWDeHji6vzzlXipZRANQhes7aK0uxSdOLwNk+x
         mQUwJQTX2qo6Ubt2Xd+bBp/gAfesqkqa6Np0j05exT4LxxFnv3HTfa7hh0RRlc9McpEd
         +aqeatd4QtGTeOiiEL6bgL9zEDXMEDadp3hmHFepLYiKqX6iNmw4ic2aJq37aDczRjuR
         837oZYVD2/4QPZEvk8VqHybGuZfGv92rw17rziugm1gtxJgscyJnw/53prn3gfqy/S4W
         x4C7/r0fTOvXUHXUtbQThxtgXepdzENrQqLad3LDz1uXcMkayTwRGFQhNHstA/0IoZpv
         hfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729123800; x=1729728600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zLK8NZJ63lThqHunA+xhjqEZN8qClvg0Kr82H/Gl4Y=;
        b=guCZnzwyBnzldduTrIjVlWzCPpmw5Ou4wu+INvXzmsLX5+IgPTuvdM5VlD/Kx2uLp1
         r0adm4t9AN2actVWljNOBZECZieGn30WsBiUiFsrh01ENG3ldJW+B2595TDB+KZeUto1
         QNWNj50qrARzou+stsRZaXiFtil1SYHeMDowQvFv8q2hNIXLBE5Za7EkZ7H9apaOg2cL
         NppBpwXDYwW0+2wcqqdhe4jIFYcg79qoIzwxd6KrQyQchsKAaiUo4/FBQfj1aj6Z/tgh
         F9mrzbzarXpqL7xZO76G0tYzkTNRHzVfNebBYx8GCi5xvw89IQuHxk6odISewsyieGyv
         E7sA==
X-Forwarded-Encrypted: i=1; AJvYcCVkPbo2MEm/32WQ+WojmARZRasy96FGJkJr807c/Pdm7WHDKZSti1mSpHNdvFQ+MCWnovrcFkWVI5/zokI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM/BRmiMzbwNbKlhyPVoxQoLFsLjtQx70O6fRAmhHHQ7xYAuvW
	4UzlIjEZZQXhlZYc/5UaiMhdmXPN+lEfrQnXlAvrxYOO/DOCuxLMUpviXsJ1jpD235hQ/Kx9nSg
	eM5zNfoNHR2S0WLHhdrytJMDg77xYi0eWmRU=
X-Google-Smtp-Source: AGHT+IGMVkShiuutDs4xn/HxU/SXYSXezquXUEdikNqROO75/WvPvitz2eCesf0/uCyp+8GS9LoyAmdByQLs5DB4RTA=
X-Received: by 2002:a17:906:c113:b0:a99:60c8:f2c4 with SMTP id
 a640c23a62f3a-a9a34cbc527mr492691766b.15.1729123800140; Wed, 16 Oct 2024
 17:10:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <A499F119-5F0C-43FC-9058-7AB92057F9B3@toblux.com>
 <Zvg-mDsvvOueGpzs@archlinux> <202409281331.1F04259@keescook>
 <21D2A2BB-F442-480D-8B66-229E8C4A63D3@toblux.com> <Zv6BEO-1Y0oJ3krr@archlinux>
 <E8E64A72-3C1C-40D2-9F07-415F6B8F476E@toblux.com> <Zv61dCaxScXuOjZg@archlinux>
 <202410031424.45E5D19@keescook> <Zv8RIs-htdc-PtXB@archlinux>
 <202410040958.C19D3B9E48@keescook> <ZwNb-_UPL9BPSg9N@archlinux> <CAGG=3QUatjhoDHdkDtZ+ftz7JvMhvaQ9XkFyyZSt_95V_nSN8A@mail.gmail.com>
In-Reply-To: <CAGG=3QUatjhoDHdkDtZ+ftz7JvMhvaQ9XkFyyZSt_95V_nSN8A@mail.gmail.com>
From: Bill Wendling <morbo@google.com>
Date: Wed, 16 Oct 2024 17:09:42 -0700
Message-ID: <CAGG=3QVcsuN0Sk79oZWjY_nNTo_XfGYsDT3gc7vEmLyS8OK3rA@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] erroneous buffer overflow detected in bch2_xattr_validate
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Kees Cook <kees@kernel.org>, Thorsten Blum <thorsten.blum@toblux.com>, kent.overstreet@linux.dev, 
	regressions@lists.linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 4:41=E2=80=AFPM Bill Wendling <morbo@google.com> wr=
ote:
>
> On Sun, Oct 6, 2024 at 8:56=E2=80=AFPM Jan Hendrik Farr <kernel@jfarr.cc>=
 wrote:
> > > I want to separate several easily confused issues. Instead of just
> > > saying __bdos, let's clearly refer to what calculation within bdos is
> > > being used. There are 3 choices currently:
> > > - alloc_size attribute
> > > - counted_by attribute
> > > - fallback to __bos (which is similar to sizeof(), except that FAMs a=
re 0 sized)
> > >
> > > Additionally there are (for all intents and purposes) 2 size
> > > determinations to be made by __bos and __bdos, via argument 2:
> > > - containing object size (type 0) ("maximum size")
> > > - specific object size (type 1) ("minimum size")
> >
> > "maximum" vs "minimum" size would by type 0 vs type 2, but I think you
> > do mean type 0 and type 1 as those are the types currently used by
> > __struct_size and __member_size. Those are both "maximum" sizes.
> >
> > >
> > > For example, consider:
> > >
> > > struct posix_acl *acl =3D malloc(1024);
> > > acl->a_count =3D 1;
> > >
> > > what should these return:
> > >
> > >       __bos(acl, 0)
> > >       __bos(acl, 1)
> > >       __bdos(acl, 0)
> > >       __bdos(acl, 1)
> > >       __bos(acl->a_entries, 0)
> > >       __bos(acl->a_entries, 1)
> > >       __bdos(acl->a_entries, 0)
> > >       __bdos(acl->a_entries, 1)
> > >
> >
> Thank you for this detailed write-up! I'm sorry for my late response.
>
[snip]
>
> So in conclusion, if turning off the calculation for a pointer to the
> whole struct works, then I'm okay with it.
>
Here's a potential fix:

  https://github.com/llvm/llvm-project/pull/112636

-bw

