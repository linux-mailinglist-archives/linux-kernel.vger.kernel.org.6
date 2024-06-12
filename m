Return-Path: <linux-kernel+bounces-211508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AB69052DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A1E1C2317B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241F317334E;
	Wed, 12 Jun 2024 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuuORn9g"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E82171E74;
	Wed, 12 Jun 2024 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196466; cv=none; b=bnsT+y8M4i/epJLCMCRanDGpjYuBwqZzRyqAmpnsRH6zRVSiWvMUR5y4K/hhtKNL/yRcmgW90oeY0erLpR3LNeIdzPjBkPoXEMlr2U0RPWex3CJ2tLr6eC98RvYFu/R1GUbEPQVB28xRZLOPtql9DZeIAuRbwZQvg9lNPmTFqqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196466; c=relaxed/simple;
	bh=EjvWd0mj+eOkYhQuLqHIX0PbmS0P/byZIfoLbzlVWT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krMvoxfo/vFwWMQiwnP4DfoDV3WdzadHmow/B0y8wdH+EMH57ydbhVlENNQV6khAUFRii2Bga8l3S0mF7v5yxRYoym8CklGw/Ux3fT/WPJ7lDE3GmEdI62dXSvgYmVBrdzBylecHrR6qVXFqvqwpuyI8kMGyJEwVxM40/kDF8AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuuORn9g; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a68b41ef3f6so784969366b.1;
        Wed, 12 Jun 2024 05:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718196463; x=1718801263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExCQVXNtEET7MGCucxQdYl/UqmP/8g4RhkTEHjtnX+Q=;
        b=VuuORn9gOu4zjrafiMH3Ii9IvmBBj/ONTK25yLlCYokEBSiA64/0KZFkXZk+W1Hhw0
         AohmLMj8ekCNfdjOVvkhV3NuWJjmYrWzrOd3nyOfkJsSr6W1Rmb5vJYGzKjXpco4q+md
         LRbUzDNyh+YEzitV3SeIsQaezbtEsaS+AxVmZRrPJfZW8RHwUZTLSxsFrgFO6h6qolGm
         V8y0QJiRy4Qs6qdFb/ch+0QiyMemLFjhWizMqMY1uyivY3kzEwdYY3Nv30+sU7OBe47c
         QH7Sat8mkrlSTW4xWpyYj51oMySvUJ5LXq8ubz840hDIgwxORPYX1mwPmsl2IEdOULiu
         hulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718196463; x=1718801263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExCQVXNtEET7MGCucxQdYl/UqmP/8g4RhkTEHjtnX+Q=;
        b=Qg/RG/uhm/zVUWO7a9wKx9WD3cPQE9KB2Ml/P6TwaHaPiXDkkCBOv2FrPqpW3j/yON
         ODr9NoUtouoQ9hmBp0EeroXp0KF9+KumVNJtg59QSiBH5yBoBSxGgqMFYStYYuO6YvMq
         FyZa33yhbj29p42w+YuaWbKA9knRWVNc2hz806v6Fyvz5ObryCPVFzMYHuQmR7D/IgUb
         Mu4PgJzd/tIqnhHVFc4m2O1SlijVS8fWOhwKE9VzHdeUstABj7cajkwjs0Tu0+79AGNZ
         JcB7x05HTlYgmeHlCzugLtfbvl+cuSmR//W4Tup1HUSqHqhmPdiN+H9JuFZYeJxSBEwN
         Fs5g==
X-Forwarded-Encrypted: i=1; AJvYcCUWe7Mqq5Km4EC/0BkRNrCS/ispOjDLYkQ+IpH+YhCAXgP+NHrO+VW9h9qJI0gKvViDU9ksJRaPe4NV8AvPrtKO9itOVGnQE6aiRmqCkgBNzuseXhqCoUuHh3E52y7PY/F5YPmCjlpd
X-Gm-Message-State: AOJu0YwWJDoGbqoGWv+0hZn/AWTjn865pE0EIIBhTYYH7bk8py4phfe/
	4PYcsMlRWQsSa7zNqboy0LM+FPCpwGLXs0ltHFF4lnJw0ik0cQSHE5ymo3QP7labuhBVVNwNCvV
	f+zCP7Dyq6oGSgmYqfKF88xYrB/I=
X-Google-Smtp-Source: AGHT+IFGtgX9GAlMEMb8Er61ktIHPi6e9IqlIoV6hgcBlA4ZtB8V/ELwYHEttkrtVMeJZV+Vhnq/hUIYMT1aZedPoxw=
X-Received: by 2002:a17:906:1955:b0:a6f:1846:3a4e with SMTP id
 a640c23a62f3a-a6f4800a193mr94114666b.73.1718196462837; Wed, 12 Jun 2024
 05:47:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601092646.52139-1-joswang1221@gmail.com> <20240611142953.12057-1-joswang1221@gmail.com>
 <2024061219-reroute-strike-7230@gregkh>
In-Reply-To: <2024061219-reroute-strike-7230@gregkh>
From: joswang <joswang1221@gmail.com>
Date: Wed, 12 Jun 2024 20:47:31 +0800
Message-ID: <CAMtoTm2tUDD-CCs4wqigx9ZNqHjWUCA_F080i+v55vubu8wtmQ@mail.gmail.com>
Subject: Re: [PATCH v3, 3/3] usb: dwc3: core: Workaround for CSR read timeout
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jos Wang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 3:58=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Jun 11, 2024 at 10:29:53PM +0800, joswang wrote:
> > From: Jos Wang <joswang@lenovo.com>
> >
> > This is a workaround for STAR 4846132, which only affects
> > DWC_usb31 version2.00a operating in host mode.
> >
> > There is a problem in DWC_usb31 version 2.00a operating
> > in host mode that would cause a CSR read timeout When CSR
> > read coincides with RAM Clock Gating Entry. By disable
> > Clock Gating, sacrificing power consumption for normal
> > operation.
> >
> > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > ---
> > v1 -> v2:
> > - add "dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk" patch
> > v2 -> v3:
> > - code refactor
> > - modify comment, add STAR number, workaround applied in host mode
> > - modify commit message, add STAR number, workaround applied in host mo=
de
> > - modify Author Jos Wang
> > ---
> >  drivers/usb/dwc3/core.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
>
> Where are patches 1/3 and 2/3 of this series?
>
> thanks,
>
> greg k-h

Patches 1/3 and 2/3 are other cases. The maintainer is reviewing them
and has no accurate conclusion yet, so only patches 3/3 are submitted.

Thanks,

Jos Wang

