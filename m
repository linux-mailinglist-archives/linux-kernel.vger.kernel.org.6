Return-Path: <linux-kernel+bounces-209344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E83A90330F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A86C0B299BA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677B5171E49;
	Tue, 11 Jun 2024 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKeUGnWL"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C63F171095;
	Tue, 11 Jun 2024 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088672; cv=none; b=MAOcEc16MxOTy9IlRHP9ZRNpVW08jhmsOt8FXOAtIwz+ffxUNTf0l33DzN9C4COQsjkrizyQ/malfuoHKinsjD4QQQ/bkKrbD5PAaJYjcXBXm5j2APjCBpCqJp5oZc7wSTdCGj18QopC7b4UXwMaCl8fCwD0aVMm35EJ430wqPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088672; c=relaxed/simple;
	bh=rUa3je+zR3hzG/i7MDNkyCbaYObWejZJyObVPHSyKvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IX3QOhwmY5BxebtdvpEc/yV3qAuSDIK1jAnTB1e3A+OfciVMzWr4rEtHzXBwOCyQ59ek8rjFjXrAXpLh5Rntxsjomu2oNax5fFTKjKBiIfoeg+e9m9YSSIwQ/h6npf2AUYp+b9ZVub5Wxn+eFSRYNmhPLepl6c7s2jcxfDZHZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKeUGnWL; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b96a781b63so1868538eaf.1;
        Mon, 10 Jun 2024 23:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718088670; x=1718693470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpnts+Nh6070QgyEiYohqxq4WT7pXn2sNWuj8PckQXM=;
        b=gKeUGnWLxDQAtrkK9KYiHAbeRoM1HvYVZcNYhbZUSTm5gD+i7ZfvFnu2+C20L9khAx
         +alpKjfe8YjgfiYptBMfddyDIxBW0PG+AX+XtcLn3U/5R4FWJUfboy/Q1ZCedGukLqgP
         BpWq6bKoWOB8QYuB7fovjThW8Fmo5f75PVQoPntGDhlIAQYS46O367Pkdu1dVFIXqaPx
         qLEt5gYe9i1hD9cMcXzg8rb5+kn17uc07JfFfGq+BnCJG250zxIV5iebJy6Y7auVBmNX
         SFcp6PuVtQgmXetyZYWsoogfZ0T8J5hVV8STi0ttVONpiizt3gpEB+geady6A8TpFPMg
         RK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718088670; x=1718693470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpnts+Nh6070QgyEiYohqxq4WT7pXn2sNWuj8PckQXM=;
        b=wv/EwWGHjS5r3EURALPmUF804c3/5X3ACF5LzVHW0zmbgHojHAym3hSwNv1g8aCApA
         biawtGYkf7jIL7X7s3AqxOEMH/Q0kbWDKbdC9VfCyw6Zkf6NmQdXEALYmJtauF0kKuxl
         lsrprzE6ndhKVXvo+QjamwrSN50oIB3dhdYYVhmATxjXQArU1aD0SqYPXQuek1itFTE6
         uhFfIfNzEX3e4Jcs/0/xqGtXLoMJQglsrDPNZUrvodFscPGjydgQPRhUm2i03q1/mZnD
         UAykk0zyi2nZRBvkl4JBfDTzw1c/2dprEEPbmsmDPETm15ERWJbgXJ4eTlCVI4mx8k92
         FuPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzhvlzwxLedsLdAmpl5gx3WcLelzhcp03cGrA+ISjERm8JEsao5UoaWAiyYdljPNMwOQfCvQOhsKKYb4YAZ9F6e7i4F3gKptkDzT1R67kGvOQG9wlah0JOJobJU8VgHqtloMFmCH7q
X-Gm-Message-State: AOJu0Yz3lCFo3AGOCwCBkzGfwnliyQVyLlZGvLO+AY0HrR/6+rBnm9vu
	zfB/s7SR9DMZZSYQaNtTPnk1MZ9JWkpNNStnPGxbgIXTs2BKLsU/9Xn+pONlgUPPm8KKV91KQXT
	BBRqFzg3L0kfDOu2wikWMw/IN93Q=
X-Google-Smtp-Source: AGHT+IHsE4jfVydcXURhpGjhqB4eEQmuD0zuPj4fmy0fAJaGVWb8puJbGIexicHThFmTVfvDvurpp8i9ibIRohfxc4A=
X-Received: by 2002:a05:6820:229c:b0:5bb:1310:5f37 with SMTP id
 006d021491bc7-5bb131063e5mr3400172eaf.3.1718088670145; Mon, 10 Jun 2024
 23:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611044358.25689-1-dzm91@hust.edu.cn> <1c3c4698-c70f-4b04-ae96-a83c3b9bbc4d@gmail.com>
In-Reply-To: <1c3c4698-c70f-4b04-ae96-a83c3b9bbc4d@gmail.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Tue, 11 Jun 2024 14:50:43 +0800
Message-ID: <CAD-N9QXY8frJmxp+LWM9g2_8UdubzMushMEPGyM9Z-UFEHfN3A@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: Update the translation of dev-tools/testing-overview
To: Alex Shi <seakeel@gmail.com>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 2:36=E2=80=AFPM Alex Shi <seakeel@gmail.com> wrote:
>
>
>
> On 6/11/24 12:43 PM, Dongliang Mu wrote:
> > Update to commit 42fb9cfd5b18 ("Documentation: dev-tools:
> > Add link to RV docs")
> >
> > Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> > ---
> >  Documentation/translations/zh_CN/dev-tools/testing-overview.rst | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/translations/zh_CN/dev-tools/testing-overvie=
w.rst b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
> > index c91f9b60f9f1..d89d0ec1d4cc 100644
> > --- a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
> > +++ b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
> > @@ -99,6 +99,8 @@ Documentation/dev-tools/kcov.rst =E6=98=AF=E8=83=BD=
=E5=A4=9F=E6=9E=84=E5=BB=BA=E5=9C=A8=E5=86=85=E6=A0=B8=E4=B9=8B=E4=B8=AD=EF=
=BC=8C=E7=94=A8=E4=BA=8E=E5=9C=A8=E6=AF=8F
> >    =E5=8F=82=E9=98=85 Documentation/dev-tools/kfence.rst
> >  * lockdep=E6=98=AF=E4=B8=80=E4=B8=AA=E9=94=81=E5=AE=9A=E6=AD=A3=E7=A1=
=AE=E6=80=A7=E6=A3=80=E6=B5=8B=E5=99=A8=E3=80=82=E5=8F=82=E9=98=85
> >    Documentation/locking/lockdep-design.rst
> > +* Runtime Verification (RV) =E6=94=AF=E6=8C=81=E6=A3=80=E6=9F=A5=E7=BB=
=99=E5=AE=9A=E5=AD=90=E7=B3=BB=E7=BB=9F=E7=9A=84=E7=89=B9=E5=AE=9A=E8=A1=8C=
=E4=B8=BA=E3=80=82=E5=8F=82=E9=98=85
>
> Why not translate the words 'Runtime Verification' here?

If you translate it into "=E5=8A=A8=E6=80=81=E7=A1=AE=E8=AE=A4", this sound=
s like a very general term.
So I keep the original English.

>
> Thanks!
> Alex
> > +  Documentation/trace/rv/runtime-verification.rst=E3=80=82
> >  * =E9=99=A4=E6=AD=A4=E4=BB=A5=E5=A4=96=EF=BC=8C=E5=9C=A8=E5=86=85=E6=
=A0=B8=E4=B8=AD=E8=BF=98=E6=9C=89=E4=B8=80=E4=BA=9B=E5=85=B6=E5=AE=83=E7=9A=
=84=E8=B0=83=E8=AF=95=E5=B7=A5=E5=85=B7=EF=BC=8C=E5=A4=A7=E5=A4=9A=E6=95=B0=
=E8=83=BD=E5=9C=A8
> >    lib/Kconfig.debug =E4=B8=AD=E6=89=BE=E5=88=B0=E3=80=82
> >
>

