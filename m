Return-Path: <linux-kernel+bounces-310180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC959675E9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 12:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C4D282148
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 10:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F18152178;
	Sun,  1 Sep 2024 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lD7mo890"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7A014A0AB;
	Sun,  1 Sep 2024 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725187123; cv=none; b=YZa3W+VsHyDNG4VVZyxaAC1g5TLJhhV51n6RZPuu1qlf2vYz1G3tHq+kn31JMZHAfO5YZl/y6CnvR8P7ik/FQZL7oQD59yj9ggYzPbtb4bCIfsDdOEsLuwdKjVczIJsIErFTKbWcLqGtEhJd4MArS0FxcZUszrvPTusICinGDQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725187123; c=relaxed/simple;
	bh=RtbrHR8X01m8ZmauEKuNsNd8YBX31NLA3tjo7E1zYhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4t5nfoxk3YE7RBNORu3uvX6dMae0anLgOOeHzE3X8cZLVuc4L99yMYUN7Gd6rduWSqKF0fKQb3U6zCykMQHyoLbrlBK9y6/yKr+d121eXcZFF5Is4S8OON9wTBBsyAaYDb6B6u1oQDiLF7U3Qf4lHjO1cyMQpqIYfqcImgoTiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lD7mo890; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2705d31a35cso2061152fac.0;
        Sun, 01 Sep 2024 03:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725187121; x=1725791921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyzhfAO6X5H2nFlBE67hjFSOfmqgByxBU/TMolVNnCU=;
        b=lD7mo890bhKPI87HDp3SUygYcWDKbz7yilxu/8t3EnUoAkZ78W2SktNgfmL7/cXDPn
         Gn0JT96nYd6UHQqPBN2ZAtpw8/MI+JiktqPihuZ5n4oYbMVI4uOcqaNIGmbVDmPIoVcH
         zRUhmBbGsxsilIgpeR/DXEDiD93uq0bd8w0LHTp6x5hHAtG867q3nEtKIv60UaM3mIK/
         wgqLDB79NHWyUpdwRIM/5lQHC1kEliJDpW+jCW5fv13K+BFhh9h9Yezk7b6wA//Q2eXU
         xhBUJV+E2ui/CAotn/LJeP7NJOFLPI04vI22wK1fuN6kfKw6asXIRVaXposbXJCeM3Xx
         HQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725187121; x=1725791921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyzhfAO6X5H2nFlBE67hjFSOfmqgByxBU/TMolVNnCU=;
        b=XCrnWJIBfl6KPUK6Gm+dmcq5Vta+fbwMlh3tbAMoOfQmMXP9fkjpMY+Ov3w75ohsSQ
         /Ddz+EJhuu/cuX8f0ekxr/S3Xwfl25P6Ev+o5ecCk2MLyTb1+/ERb/yY1uAr06UrqmpX
         LWE/2pdUU4hw3LO6cNzAG12BXcfBHSf80SMIEJ7d+kv5SE3v1p+aSyciQNqMi+k6Ezcq
         0/b/w74W5+ZVsn57TUOUhehp+7gRYK5RPK5uF7PMJvb6BTMGlilCssTFl5XsPH8MVitf
         qbPyy7OvwiG2YxIAY3hL8GQOVTv0Si/zJsjOS5bHpMInRNgY0L0esEUw1DAbDmNG+Ulw
         zDPA==
X-Forwarded-Encrypted: i=1; AJvYcCV5mEMs5pAYCKgsyuF038CmQmutNLmUNceHqBFzcySxertfb4C7RlchEgbs0tr8i9lXorISqRXFRsQ=@vger.kernel.org, AJvYcCXTmaIkkosRWl2suvB2Yt1S3j2dwUl1DHQtcCd2OzhC8mPc1DaXH7rmVomsQeP4eA0QymWkJd9Nqogigh3N@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9vkGcmUFYG/5BbUV9oh5DW0IWLrmGeYUM+oYAQkgOjPt1QW8m
	H0zLd0w9s36q85E++rjVr4mASqrlg9J77cMuWFoipyuOKXAF5m+DtRa21a/rbL9vTkhAh7s6CM4
	9Wdm+7Ej53l6vZqm3CDxwQGRcQ8s=
X-Google-Smtp-Source: AGHT+IFwDrFIRchFBPeU5Cmhdf8kTcaSFA4UqvIROjrdvU6DSkfFqOLzuG6/Nk75iyrmFNWILWDA+pXxJaqlFWVRaBE=
X-Received: by 2002:a05:6871:1cc:b0:25e:b999:d24 with SMTP id
 586e51a60fabf-277cc63f0f9mr4474832fac.0.1725187120778; Sun, 01 Sep 2024
 03:38:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <35904aa5-9851-4894-b953-689904bf33ca@hust.edu.cn> <58b7c7d2-f60c-4a2d-9cb5-d583182bfef4@gmail.com>
In-Reply-To: <58b7c7d2-f60c-4a2d-9cb5-d583182bfef4@gmail.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Sun, 1 Sep 2024 18:38:02 +0800
Message-ID: <CAD-N9QXks-bFxz+4NVbuvG7BJQZrRiodHXqSadqzdA-ammsM1w@mail.gmail.com>
Subject: Re: [PATCH v2] docs/zh_CN: add the translation of kbuild/gcc-plugins.rst
To: Akira Yokosawa <akiyks@gmail.com>
Cc: dzm91@hust.edu.cn, seakeel@gmail.com, corbet@lwn.net, 
	hust-os-kernel-patches@googlegroups.com, justinstitt@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	morbo@google.com, nathan@kernel.org, ndesaulniers@google.com, 
	siyanteng@loongson.cn, alexs@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 1, 2024 at 2:03=E2=80=AFPM Akira Yokosawa <akiyks@gmail.com> wr=
ote:
>
> Hi,
>
> I'm not Alex, but let me chime in.
>
> On Sat, 31 Aug 2024 17:34:11 +0800, Dongliang Mu wrote:
> > On 2024/8/31 12:11, Alex Shi wrote:
> >>
> >> On 8/31/24 11:48 AM, Dongliang Mu wrote:
> >>> +=E7=9B=AE=E7=9A=84
> >>> +=3D=3D=3D=3D=3D=3D=3D
> >>> +
> >> there are still a lots of sign incorrect. Please be sure everything lo=
oks fine in a web browser after you 'make htmldocs'
> >
> > What do you mean by "sign incorrect"? I check the html rendering in the
> > vscode. It seems fine to me.
>
> You are right.  There is nothing wrong as far as the reST specification
> is concerned.
>
> Quote from https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.=
html#sections
> (emphasis by me):
>
>     An underline/overline is a single repeated punctuation character that
>     begins in column 1 and forms a line extending *at least* as far as th=
e
>     right edge of the title text.
>

I see. Will send a v3 patch.

> HTH, Akira
>
> >
> > Dongliang Mu
>
>

