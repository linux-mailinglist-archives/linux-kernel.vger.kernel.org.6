Return-Path: <linux-kernel+bounces-210783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF5090489A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B831F23870
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD118820;
	Wed, 12 Jun 2024 01:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nngteK8L"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E95217BA1;
	Wed, 12 Jun 2024 01:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718157273; cv=none; b=kjUM2Z59/o0goTlCTm6le74+4fSCSoKtP+3ApIEy4Vemv31FDhMnjlOMaLYmYEzWAyOuKuVLhQl1thmh5hXx/tEWFVF2Bmw5vuwTlBK3Grj3G/3e+shgTFak8MCHqojibmhtDnwSN9+ra3wnVpBW+Zf3afB370aw0emHsHrWOwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718157273; c=relaxed/simple;
	bh=w1xnUv5Kz3/tY/ryCxn3oTJxNlt53fqlci48thBjbm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKSU0v8/zPIhcNm4sxc/Aybt8tzFmbbnx+oSOuyOPpTSxOXC+rzRQosMGsm5s4JBNLt+Wd5GuwhrGGhDjjZ9+YUWG1O6wBD7C9Wq5eElrlIHOtUhsFSnOkAkNiZQ9OJDAbey2In7BgxpVRkuzR3ZsWbtXJPuCMOimICm8vAEx7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nngteK8L; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5baeab9fd60so1452757eaf.2;
        Tue, 11 Jun 2024 18:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718157271; x=1718762071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwItdTmcPCVbWWTJKIwknMPMvZjx8Ik6YysUYQY2Gk4=;
        b=nngteK8LPCYdacW2VfNvMaCDiBMFpVCS2BT43gA4FzMsrcfOIR0Nx2AMKuVnsDkSMD
         yhVkghDaZ4zz+DnjjXN0CTIbA8OQ0/zhrTzkUtJvuuVUB9xdbpuIUUq1dNy4M7NHJwZV
         GG7tBlIHXkiAouORIiwX7Tch5O/Qz0acJDh32oP4uTMRQEF5v4bPvxsh4Tg2TFLN6A/9
         SjrQByYBVqSRsDY+9cKSb96HFsWEhW+4MjiwZ/904K3wmAWVBv5vV+47irc1u5lqejqi
         JkMN8VOa6KE06SGUe+XTe4/q6PV//Ud08+Bmoafpm/EBLZnd10yxG+VORHtjSeWVX5U+
         4lAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718157271; x=1718762071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwItdTmcPCVbWWTJKIwknMPMvZjx8Ik6YysUYQY2Gk4=;
        b=j7HpVRgNdkEd1nVUR/e/+ErxlVdH8Dmi5yDoDXG2kazMho5wwb3ATR+dUkELk3smtJ
         B+SFz4kIRIY6qO4QHFVJsgEyCbsbNDnSxfWnqVtuhfb3PJMqRz88Udo7bkd5ZL6r9CmU
         llCyzJ9JGErOWqKYbtSJqKxMShiTLQeDBvd+Avj7Zjxp3spsQay8DaSYZ+gfgnUWDa+h
         g+CrFxePIHCGDdFs2/gGzmR/P3bfMTrKKxkctuPhmjPGUpKwFBzlf3TKPJp8RKf8gXJH
         rjikE4z3YgF/hKJG9x5T+/DWEqYxEKbnHaMBeLoGesurhCNzjbf2Ien43LWl531BA5tD
         LsIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeFcxz5ZKPQJj0IFYAss+mUVaMSff7RBBFrT0qvnxBSORw4n/tlzNfQFnmsQ2fVV6dtHeiikXrxTpCZarEPF7GaMp0cdkunCz9KY5AFxR4tMRvGZpMyo6pn0/z58VYYc8LWRo+dPyZ
X-Gm-Message-State: AOJu0YzgIPBYI0I1uRMk1Y+1IfuCRRgSr3MCG/LQo1/+lhfi7KnCECa7
	QF9GzEUNGg9bxw3YohyIczrVZq3il8JUV2tJ4Kt9NNXU7hZZje4WsaPexsVK59UF9JDu98smt6j
	SzxaLS5YpAHMI8hxzj1hWLWr8a34=
X-Google-Smtp-Source: AGHT+IHKvXcsY6mlaFymMXwEWQLlYamCRCx2QwoAcHfH+QCs99TtpseiJAvy+X5wop0X5Jh0s7SF0rgNTsAUHA1+5tk=
X-Received: by 2002:a05:6820:22a0:b0:5b9:f2f4:6a95 with SMTP id
 006d021491bc7-5bb3ba15b36mr529150eaf.5.1718157271162; Tue, 11 Jun 2024
 18:54:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611044358.25689-1-dzm91@hust.edu.cn> <1c3c4698-c70f-4b04-ae96-a83c3b9bbc4d@gmail.com>
 <CAD-N9QXY8frJmxp+LWM9g2_8UdubzMushMEPGyM9Z-UFEHfN3A@mail.gmail.com> <5961a584-dbb5-40e7-8e25-69eb7aefcdb1@gmail.com>
In-Reply-To: <5961a584-dbb5-40e7-8e25-69eb7aefcdb1@gmail.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Wed, 12 Jun 2024 09:54:05 +0800
Message-ID: <CAD-N9QV-LqraTPVgt3CayyPKreVRR3S4SvFkwkqPKkVpuegJcw@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: Update the translation of dev-tools/testing-overview
To: Alex Shi <seakeel@gmail.com>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 9:36=E2=80=AFAM Alex Shi <seakeel@gmail.com> wrote:
>
>
>
> On 6/11/24 2:50 PM, Dongliang Mu wrote:
> > On Tue, Jun 11, 2024 at 2:36=E2=80=AFPM Alex Shi <seakeel@gmail.com> wr=
ote:
> >>
> >>
> >>
> >> On 6/11/24 12:43 PM, Dongliang Mu wrote:
> >>> Update to commit 42fb9cfd5b18 ("Documentation: dev-tools:
> >>> Add link to RV docs")
> >>>
> >>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> >>> ---
> >>>  Documentation/translations/zh_CN/dev-tools/testing-overview.rst | 2 =
++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/Documentation/translations/zh_CN/dev-tools/testing-overv=
iew.rst b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
> >>> index c91f9b60f9f1..d89d0ec1d4cc 100644
> >>> --- a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
> >>> +++ b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
> >>> @@ -99,6 +99,8 @@ Documentation/dev-tools/kcov.rst =E6=98=AF=E8=83=BD=
=E5=A4=9F=E6=9E=84=E5=BB=BA=E5=9C=A8=E5=86=85=E6=A0=B8=E4=B9=8B=E4=B8=AD=EF=
=BC=8C=E7=94=A8=E4=BA=8E=E5=9C=A8=E6=AF=8F
> >>>    =E5=8F=82=E9=98=85 Documentation/dev-tools/kfence.rst
> >>>  * lockdep=E6=98=AF=E4=B8=80=E4=B8=AA=E9=94=81=E5=AE=9A=E6=AD=A3=E7=
=A1=AE=E6=80=A7=E6=A3=80=E6=B5=8B=E5=99=A8=E3=80=82=E5=8F=82=E9=98=85
> >>>    Documentation/locking/lockdep-design.rst
> >>> +* Runtime Verification (RV) =E6=94=AF=E6=8C=81=E6=A3=80=E6=9F=A5=E7=
=BB=99=E5=AE=9A=E5=AD=90=E7=B3=BB=E7=BB=9F=E7=9A=84=E7=89=B9=E5=AE=9A=E8=A1=
=8C=E4=B8=BA=E3=80=82=E5=8F=82=E9=98=85
> >>
> >> Why not translate the words 'Runtime Verification' here?
> >
> > If you translate it into "=E5=8A=A8=E6=80=81=E7=A1=AE=E8=AE=A4", this s=
ounds like a very general term.
> > So I keep the original English.
>
> Runtime is often translated as '=E8=BF=90=E8=A1=8C=E6=97=B6', so could be=
 =E2=80=98=E8=BF=90=E8=A1=8C=E6=97=B6=E7=A1=AE=E8=AE=A4=E2=80=99

How about =E8=BF=90=E8=A1=8C=E6=97=B6=E7=A1=AE=E8=AE=A4=EF=BC=88Runtime Ver=
ification=EF=BC=89=EF=BC=9F

>
> >
> >>
> >> Thanks!
> >> Alex
> >>> +  Documentation/trace/rv/runtime-verification.rst=E3=80=82
> >>>  * =E9=99=A4=E6=AD=A4=E4=BB=A5=E5=A4=96=EF=BC=8C=E5=9C=A8=E5=86=85=E6=
=A0=B8=E4=B8=AD=E8=BF=98=E6=9C=89=E4=B8=80=E4=BA=9B=E5=85=B6=E5=AE=83=E7=9A=
=84=E8=B0=83=E8=AF=95=E5=B7=A5=E5=85=B7=EF=BC=8C=E5=A4=A7=E5=A4=9A=E6=95=B0=
=E8=83=BD=E5=9C=A8
> >>>    lib/Kconfig.debug =E4=B8=AD=E6=89=BE=E5=88=B0=E3=80=82
> >>>
> >>

