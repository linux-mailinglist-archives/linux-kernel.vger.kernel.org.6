Return-Path: <linux-kernel+bounces-186617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0878CC662
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8273282304
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3032145FE4;
	Wed, 22 May 2024 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxNysHD6"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3741422A1
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716402859; cv=none; b=t0mFk+iZgu0aTKPGidS/rMgKMTsv2ZOg4irZ+lO4l14WGivthPPxvELAi7AJmznAm43WEXnJmyAbBp3JzbGOUhRvX6c/aCSx+zDdMI81nVfM4EWjElvsLXTIcU2cb0+eXA9V8qNJ15lyB/8Bcn/CiUEeQgJf6QTZtdKgYeqx2SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716402859; c=relaxed/simple;
	bh=7H6bDFuryLuKipfoW/x/JW8852Pk7g5KvRRPCe4w288=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7TQFltlkEqA3matcpGRxEw9tKv1h3/Qx2qHs6+QIEiOlv0tyH72vhmqYBLP0n3iBoA7gIagS6GJbxbRnBgFWOjVyEIAcQCm7ZFv7W1ph5xAmyUn+wuKkB8WQvNcRrQR3EE9OqgbmhGUTYP7zXYgl6EzsOCGmFY2rrtlUrKlcyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxNysHD6; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-47f3e985a84so1819751137.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716402856; x=1717007656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFXKlIKgDPCNdWHHAlyeZ/Dt2RLUBRjZBqCR8Jamito=;
        b=KxNysHD6VowvQdC9YQ31AvvOBbtFn/4KqxlYj9dYNscfwaEhXx+AxKLUmRw9QFuJ1F
         f3QjIXTELTShgxjY5EKCcneUL22XxdSWa7KtQPkWj4encqyjZlJvFkL7Ul3ZS4o9QTcx
         dqy5pTpj1nhKKRNedLDEz5YpjdZtgk5EOPSGHWJa8GiSgtSVidjGHBsyzgeChlNyDNkb
         84lozd1f/W4970QbkbxZ1dsLWC5BFaovM7TIvQPTbwTI20fuaKJGrJJ7PY7e1lqx4Zb4
         FY3u7loeB2LV9+pHE2wGBvJEXO5PRcD/nVi1VfolfaYbRZNgAAphZpSprUQDRWwo9RP8
         fIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716402856; x=1717007656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFXKlIKgDPCNdWHHAlyeZ/Dt2RLUBRjZBqCR8Jamito=;
        b=UfqUcn1HsUpFIiGauir2zykJDkUY2PmHlhBnJye55y6z/4mfOv/3g0Xi5z4HaDEnXS
         +ZT7nSY3WDydzA9QbKo7z365wUmuKToDVJDB4YqhDnARNZY4QeA+TFdDaPDp+Yyk4wsn
         9RUHdF2xI0Nj/naxTyebwaL8UVUI+U0J7fR8OnPmPJJIHrTUcgOS/ckoQobUwr9JlRjq
         zHcqnTm7c9+w2XfSx3Q6rfJcqGOq0V3Fc+4+vVl0jwsfOR3f21g1Jp6tHzb/m1fCgVkR
         nESwE1AV1quQlilvpOpFFGtwb/sYHAdcxjGR9LZuNISZqTE5NNOLxIKw/z8GGepmj6El
         BbiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6JGXDjtCs0qNdpfQf5VgYhMmVfI1DBAG3jEaDVQNTZoSB6SaD3rmVoy5dFozxJ2B2CPP3dQD3NbAHCVs8Ys6hGxftqstDHnO6l97H
X-Gm-Message-State: AOJu0Yx+HsMd/0hUIbxuPXWHhjeiBf89PXBeXrYAdHHGzteN1WwANxmH
	Gmv4HkuLphi53X1w0JXKuy5zRpVGGPZ5uvyt6oAvi6sjs5GOTHC6sTU/xX+cdPqmcmULmZQ/l3l
	YnrE3px2F9e0UC2llrIPJE15+EuY=
X-Google-Smtp-Source: AGHT+IEEmD/CCeIUWY2+eazkHvob9wyzgRKhKjSFVJeJyHafDS6M40zNGlxR9TI0NGUo6cYWpXYJPUXAYT6AMe+7ZVw=
X-Received: by 2002:a05:6102:32d4:b0:47c:abf:383 with SMTP id
 ada2fe7eead31-489058437bemr3025281137.5.1716402856397; Wed, 22 May 2024
 11:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516174357.26755-1-jim.cromie@gmail.com> <20240516174357.26755-23-jim.cromie@gmail.com>
 <CALwA+Nb8EKBRk+1ejxWhRBhoYf=Arge5TvA-mPzDD95Am+7pYw@mail.gmail.com>
 <CAJfuBxxhTzOOBz_kTc9APGVw==r1fkyk+rdiri3wJAYJZSYoLQ@mail.gmail.com> <CALwA+NaYPZY6956KG6u4t3WxN5YAWABitvhwYn30kcH_nrxeuA@mail.gmail.com>
In-Reply-To: <CALwA+NaYPZY6956KG6u4t3WxN5YAWABitvhwYn30kcH_nrxeuA@mail.gmail.com>
From: jim.cromie@gmail.com
Date: Wed, 22 May 2024 12:33:50 -0600
Message-ID: <CAJfuBxymaL_7P6bi5i+bkV71ym1G7pweVo=uTm=KQ=ZfbZ0DWg@mail.gmail.com>
Subject: Re: [PATCH v8-RESEND 22/33] dyndbg: split multi-query strings with %
To: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org, daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, seanpaul@chromium.org, 
	robdclark@gmail.com, groeck@google.com, yanivt@google.com, bleung@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 10:57=E2=80=AFAM =C5=81ukasz Bartosik <ukaszb@chrom=
ium.org> wrote:
>
> On Tue, May 21, 2024 at 6:08=E2=80=AFPM <jim.cromie@gmail.com> wrote:
> >
> > On Tue, May 21, 2024 at 5:58=E2=80=AFAM =C5=81ukasz Bartosik <ukaszb@ch=
romium.org> wrote:
> > >
> > > On Thu, May 16, 2024 at 7:45=E2=80=AFPM Jim Cromie <jim.cromie@gmail.=
com> wrote:
> > > >
> > > > Multi-query strings have long allowed:
> >
> > ... input like:  (Im using it like a verb)
> >
> > > Missing been ?
> >
> > this is an alternative.
>
> I see
>
> > maybe s/strings/commands/ too
> >
>
> I like commands more
>
> > > >
> > > >   modprobe drm dyndbg=3D"class DRM_UT_CORE +p; class DRM_UT_KMS +p"
> > > >   modprobe drm dyndbg=3D<<EOX
> > > >      class DRM_UT_CORE +p
> > > >      class DRM_UT_KMS +p
> > > >   EOX
> > > >

I did reword it - to:

Subject: [PATCH v8d 22/36] dyndbg: split multi-query strings with %

Since commit
85f7f6c0edb8 ("dynamic_debug: process multiple debug-queries on a line")

Multi-query commands have been allowed:

  modprobe drm dyndbg=3D"class DRM_UT_CORE +p; class DRM_UT_KMS +p"
  modprobe drm dyndbg=3D<<EOX
     class DRM_UT_CORE +p
     class DRM_UT_KMS +p
  EOX


the other thing I didnt do was add an example writing to >control explicitl=
y,
but they are equivalent.

