Return-Path: <linux-kernel+bounces-200163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB678FAC11
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAEAA281F6F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ADD1411F8;
	Tue,  4 Jun 2024 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AItAhizs"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF26C140386
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717486283; cv=none; b=SleZq8KwkonZFugyqPEmrEXrt7YtNTPArs9Qv6uyH5vOBZ17q+lQ1bxWuCH2YvKTYqyGAxSqrVWE2zay22sUR4sQ8HFBJffsaHZJtAgFfj5ewJmMUcWZOsX2AbMMiV3OwtjPqkuJN0RPt5hE7lImDcIsWzHc1vpe7xL31gU36gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717486283; c=relaxed/simple;
	bh=a7iEkEZkCBk0eqmsqUSW3iJ+17Unk4H18KUeIBKKp4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtNvAptheZrCX+iBegFkkk6fMiJLPmD+I+POtBZan/4ohK379PlgQSVUTsBpwqjzRhKwMjDPD7d5RWrRI4KFkwAaUX757JKXNVTRym+ufaDbgRJwhXmUW9Q4t/3wm6kezg3Tdp/YIMeyvTTXZG+/a+KcmFtBRCvwg0o18irjTFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AItAhizs; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6302bdb54aso662077566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 00:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717486280; x=1718091080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7iEkEZkCBk0eqmsqUSW3iJ+17Unk4H18KUeIBKKp4Q=;
        b=AItAhizsYr1A8znqEfGXYwM4+CXTej69o0VVS/FG/KuapLdVEzjC5T2vxlB0ZuTIyg
         9ZyJA3aUjgrTsHBKKGuvEQL/O8OPFLlih35HITiLBN9Xxfl7PGcpr5zHnBGgs/vH8/ik
         +fXLqgqZsSHBJS4+5f6bw7cJZDed4h12/+JqrQxjNfVG44rYpGyDDz5+vtkvqD+QJAhZ
         SPe3Z0I91Z/Uxb4glQp+KZgYv3JiOc8RqPsqgvaKKtrbq4A5YmrFdDldSApMwCQDCUNI
         dKJBEBPcg0bnnDIuitZSiBpBtu5KdP+v1GALxb6l6R0KLRoKy3udXDjaAW50YXB5r/CD
         TtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717486280; x=1718091080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7iEkEZkCBk0eqmsqUSW3iJ+17Unk4H18KUeIBKKp4Q=;
        b=uxARIZd+mfnaoUCiO+59O1SlduLBrZQVo7+o1HtkaUr/o7/NjiALiqmETrleMtRV8a
         qOfkbZ4nhqrmjY4T0wNwEUocIaN/mQQtZ6BkaQo/Iv/Mi1/BxMJt6nveqA91sQdEhi9c
         NU5DlBdzje6WWbE8pPGaF2PhkEI3rps/ZasDNmYUX9atLRrDR8yNotah2klMD/2x690o
         2xSsD95/hOSCHTGsrdVGL1yD8jHhZ9lkzkMyTuJUmn6gcKcQOvMzYriGWOqfaPIio2qP
         j49zvzlIQ4AsF+LnkerZ2VNEAvoMS14NXyp8a/5MpLSlbO5iPIQ1rjT60HDTwvy2Vv8s
         i1fw==
X-Forwarded-Encrypted: i=1; AJvYcCVllsiUsdJWEGz1LJiWjyus8EHdT7SiejSQUhXkA/DlYf4qiCV0ywiPlhteTFntC1anKv50Rz4vZ7SZci5vH5ncaBbyRko8QqfuLZuS
X-Gm-Message-State: AOJu0YwAA0b0Dxp2DcA1N/BZkJUUn0YcoyRQXtZR1TE7EuxMjnlA70qO
	u/CFUYPITKVRoMvHXg7EFr1Cg87QHbx1AN4JuM1TUws+NWHT6gcG/ND8/fgpgGfv1lHdlBX8URC
	cpDsvs+lioTh7Q7mANz2aLTn4/zQ=
X-Google-Smtp-Source: AGHT+IHV4Hnfq98k7TmmzqjRqRfeMubkYShvTkClNj0gjeREUvSgOeXUKzbIjAcUbY4/JslcU+i2hKpq3cgTRT6iaFE=
X-Received: by 2002:a17:906:ff4b:b0:a68:2f99:a3da with SMTP id
 a640c23a62f3a-a682f99a4a0mr669420266b.16.1717486279850; Tue, 04 Jun 2024
 00:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530232054.3559043-1-chris.packham@alliedtelesis.co.nz>
 <ZlnuNx6gKJV6w9YS@smile.fi.intel.com> <87e2e4c2-ed9e-4ab4-8920-e7983c5a18ac@alliedtelesis.co.nz>
 <CAHp75Ve5XCFYemAZHZM5ZTf0B2cHJrH5GdPCR+cLPE1aoMDs2Q@mail.gmail.com>
In-Reply-To: <CAHp75Ve5XCFYemAZHZM5ZTf0B2cHJrH5GdPCR+cLPE1aoMDs2Q@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Jun 2024 10:30:43 +0300
Message-ID: <CAHp75VfHBt6YvnxjrW=sYZOsH6qpb63zGZnyMX=97HX=DYjwkg@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: linedisp: Support configuring the boot message
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Andy Shevchenko <andy@kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>, 
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "ojeda@kernel.org" <ojeda@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 10:27=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jun 4, 2024 at 12:59=E2=80=AFAM Chris Packham
> <Chris.Packham@alliedtelesis.co.nz> wrote:
> > On 1/06/24 03:35, Andy Shevchenko wrote:
> > > On Fri, May 31, 2024 at 11:20:54AM +1200, Chris Packham wrote:
> > >> Like we do for charlcd, allow the configuration of the initial messa=
ge
> > >> on line-display devices.
> > > Pushed to my review and testing queue, thanks!
> > >
> > > I tweaked the define to be LINEDISP as Geert suggested.
> > >
> > Actually did you? I just checked what's in
> > andy/linux-auxdisplay/review-andy and it still uses LINE_DISP.
>
> Oh, it seems I forgot to squash the change, thank you for the catch!

Now updated.

--=20
With Best Regards,
Andy Shevchenko

