Return-Path: <linux-kernel+bounces-363462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE7599C2CC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A72D283F00
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311B314F12D;
	Mon, 14 Oct 2024 08:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="p0qNWgk7"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EF614A4E1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893763; cv=none; b=ZiykpK9LQXWk57596/wedge0pQVsDClMONxIoAaB6LD69QrmMRAa/pkFqbnX120kORY80O/FC8hKol7qgcGdVgxeAkMwNZvcTUJDP7R1Cax6YbRYKrkK1LPI3OMOpKr8yPlhlV7H8us4SWwag0qlzwV7Rch7wCXVDtx1WO8A5EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893763; c=relaxed/simple;
	bh=ZgDKMVeLxznmFf5ZCrSGz0IvyrvooVbXTGlKGwkLa+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=id/Wqy/50R8BPRACbkqI0wCSVwa64AlP0hohkdWWqyOVhW+MWhxoXNQgkvTy2H01Do7wMb70yzdqq1gv97HQ1ykjLa3oq72V7QviN3eP03lvW1BtD9tdzEsfivWY5wYx6UOZGlO2lFeWNnU2AW3tmzaAQWZRRi3T9Hl8X92Br24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=p0qNWgk7; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539d0929f20so3037823e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728893760; x=1729498560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgDKMVeLxznmFf5ZCrSGz0IvyrvooVbXTGlKGwkLa+s=;
        b=p0qNWgk7lgNR73CDmbKNCe8carjDxZi5xf7N5xFzH/WMMVlLSUad0tKT9vbRpGgrsk
         fK8g/NCV+Ewiq8Ax+HaeaRtSqErxlSJXzqCDz9i5XSFO3po2Q52HsuKbwjx8sGmTYMt1
         nH1K8Y4OlmzNA9OE7/2r3CFiXSvo9JfE/ThDXDZBw/6GF/+yTJWyN87w85pqTL0A89Mj
         1+fcgL5kStWyCjlHDZOiauonOZ0xlxafbmCsZAvnktDvHAN8kgi4tPwur68F0YWSz+HN
         TWSZq7iKZBsBQFatlhV079Dkw3CH0E+DR3x4Uc8Bm+B7dDKfBDZtFGMurW/rJkvmO9h/
         zaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728893760; x=1729498560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgDKMVeLxznmFf5ZCrSGz0IvyrvooVbXTGlKGwkLa+s=;
        b=QcVBBp+tIPlPwABQWe94ZHEKdY3RblNXc2FkBj10EkuKFclFYOj8HKkDq9X4aGEJsy
         Uubk6oNNPVz1kqYrTsVWmuRoKGyR3/S8aXkdwtJNHdrC5N4TOT7R5WD0Ap9eQoHz43JJ
         3H05M9BYJqiECc2DPFHrpmeZ4sLxflWzVORVJBFWtjWo36iBuJHgj7wM2G0LOJVGC/3p
         wSjopDBsNDpWKIhL0xDhzyNL586PoI1HmLrIFcxfkh/03fZ5JPuA1KLLMepcaSTtMGrA
         Mwzpiw9VLzWT6FEPnunM2+dup70eOmHlfyGcA0F0ABCMywImGeFw7fi185s4aGoMLJ9U
         EOWA==
X-Forwarded-Encrypted: i=1; AJvYcCVVyy0zNzueKpmamWGgqhUrkDfNpRDP87tnYPxJCMbV/LgubDgBl+YH/ihof0Hccy1qzzScDnNKWDlMtX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRfgyN4rewxMNPOdgl8FBacAvBRDdJbpbgGpCkVKdMYepx9OQa
	yKYZaSASZTS4bGdEm64tpfr5yHLZ/hb256N1ZSgCJjDUsJMU0LRUWUIZ+s8qZmYTQxHIQ9DLiBo
	xHtVxS5QWGlhCs/g76xUIgtlSCRxOCAfc8yMKCg==
X-Google-Smtp-Source: AGHT+IHdDAIjXYd2S69FLZv9SLr0zTg0livk5nl6SwOydMcHkiUKTf2/hmy4fWdIKBPYwmr/c88DMXlSKUPi9UaNRr0=
X-Received: by 2002:a05:6512:3d1e:b0:539:9f5f:efd5 with SMTP id
 2adb3069b0e04-539c98b923dmr4809047e87.26.1728893760273; Mon, 14 Oct 2024
 01:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014075329.10400-1-pstanner@redhat.com> <20241014075329.10400-5-pstanner@redhat.com>
 <CAMRc=McAfEPM0b0m6oYUO9_RC=qTd1vsg4wMn1Hb4jYQbx4irA@mail.gmail.com> <dc9d7bd817e5c8bc88b0b8dfffcf83b2676cc225.camel@redhat.com>
In-Reply-To: <dc9d7bd817e5c8bc88b0b8dfffcf83b2676cc225.camel@redhat.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 Oct 2024 10:15:49 +0200
Message-ID: <CAMRc=Me8U+7EwNDEh2RJJD8+FTPqO-CbwG_fiDmHLpjxh33o5w@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] gpio: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, 
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Richard Cochran <richardcochran@gmail.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Al Viro <viro@zeniv.linux.org.uk>, 
	Keith Busch <kbusch@kernel.org>, Li Zetao <lizetao1@huawei.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:08=E2=80=AFAM Philipp Stanner <pstanner@redhat.c=
om> wrote:
>
> On Mon, 2024-10-14 at 09:59 +0200, Bartosz Golaszewski wrote:
> > On Mon, Oct 14, 2024 at 9:53=E2=80=AFAM Philipp Stanner <pstanner@redha=
t.com>
> > wrote:
> > >
> > > pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> > > the
> > > PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> > > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> > >
> > > Replace those functions with calls to pcim_iomap_region().
> > >
> > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> > > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> >
> > This is part of a larger series so I acked it previously but at
> > second
> > glance it doesn't look like it depends on anything that comes before?
> > Should it have been sent separately to the GPIO tree? Should I pick
> > it
> > up independently?
>
> Thx for the offer, but it depends on pcim_iounmap_region(), which only
> becomes a public symbol through patch No.1 of this series :)
>

Then a hint: to make it more obvious to maintainers, I'd change the
commit title for patch 1 to say explicitly it makes this function
public. In fact: I'd split it and the deprecation into two separate
patches.

Bart

