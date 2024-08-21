Return-Path: <linux-kernel+bounces-294812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A27C9592FD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 04:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F491C2117E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D328E1547D6;
	Wed, 21 Aug 2024 02:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FowInNfT"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A205A1537D2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724208412; cv=none; b=fHxr3OcDq0dsJWmSnxz73fODhHvOTnbBPRXTfNCp0jItZwI7WNVEX2vvkLUKnZtQruchHDudhKabHO8Eyp+H9zB53+c5n38JYFdQ3FEaYPeW9FSGxqu9OlAz4YwSBw2Xw0+FFjSD4D/caAXYYPYtAy9UkY4XtydjJXm8rtNgLYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724208412; c=relaxed/simple;
	bh=5ffCrwx+98BuRFQdrWE2pK2sx399FSfOemoLHXG3ixI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXOMbn1PdasRHiv3K09p5VXmNaRXqekC8GLth97GUE9iMpiNQ0NaRZC15DmQc1QUxEQ26825oj+B96QDGqFqpIES2EcADALVJIJVEJLj/kAO4ueG41yj4YI33ICW2zlTbMNpeGQaVWQdP/JJ1pi94CQq+mray9GKk3dCpsK0CE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FowInNfT; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bf825d779eso24065046d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 19:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724208409; x=1724813209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjQlK/w1X7l7zoTUunhB0pgBWrHMDmZGIJHzaU2XuNI=;
        b=FowInNfTIS8OJT+QTodHp0zH4erg9ntHcXLh6vk7qMUbJ0bMNcari7l3YBTaYmVwu1
         IV+/LtgBtVLzEIrB/2uMaia5REaGhMF5xN2YZqaMbYtl4EWOVB/qz27v7fHSkrjWZVzu
         4v8Qa9QiLM9R+sgtoy0hU7lemHlGGAHsAhx70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724208409; x=1724813209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjQlK/w1X7l7zoTUunhB0pgBWrHMDmZGIJHzaU2XuNI=;
        b=KetWllHvv57ebvnOzaZDLNfKOuuPEj0u/T7GdzoezcG8hIdXz2bFWE8XZyxV01ucM+
         wkH4R+gldI8l86dtskeY/iE3f8mvuXOibM7GDZoAwcvFpyB9bYjgZqX+YK2jJfSVVLLS
         /6T1ChP70WlbS2nvdL1iJL1DlzhNpIwYB2tR/DgwfgWP7yUsAhd2+9XvlcQjjRHuTAgy
         TB7C3v0frKiTOdVJUA1qaKeaJIzC3JzjGdeFtuvrkmV5PjnYljCpDS1rlCU4z9Vgyut5
         E6lqRCJnOSSc+u9RNZqVQEIWWvjwkYz1/Xt/EzzDLRgV0oKqShzi2I/GmbgAHxJmc1/W
         2WxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuXqRCEvW+8mnZj7YBizFFuiiI/OQDkcJ1KzPgoLQNh8Xp2Vt32sL+P4E9Lo4lXvLCfvfQmUeaXO2Fhrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYTYtHk7kDUNJfwcZ+jL9SQBKAz6Pyp3M0JFQhsQzb6f9u0TSh
	U3LQIsY3PFn0H6t+XBnml/yOk4Q1aPGnFJRKcf4lYNQPxJjCuSjEzMkEAB7yUHXiSJ/7ukEWx0Q
	MQkHl4z4MQOr556pvMjRI56tO25SHG2KcGSe6
X-Google-Smtp-Source: AGHT+IEy16IjVIk++AR2PbHJeMBe06xcx9alXU67L5emPBtwtM9BYEqe4b9oPhs5p/4ItXs4BHcPjzRMMm1C+mtJYmA=
X-Received: by 2002:a05:6214:5d13:b0:6bb:b397:cceb with SMTP id
 6a1803df08f44-6c155de5028mr15373636d6.28.1724208409389; Tue, 20 Aug 2024
 19:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815005704.2331005-1-philipchen@chromium.org>
 <66c3bf85b52e3_2ddc242941@iweiny-mobl.notmuch> <CA+cxXhmg6y4xePSHO3+0V-Td4OarCS1e4qyOKUducFoETojqFw@mail.gmail.com>
 <66c4a6d18e811_2f0245294ba@iweiny-mobl.notmuch>
In-Reply-To: <66c4a6d18e811_2f0245294ba@iweiny-mobl.notmuch>
From: Philip Chen <philipchen@chromium.org>
Date: Tue, 20 Aug 2024 19:46:38 -0700
Message-ID: <CA+cxXh=7Vp0LO0jJSwKuX-8W4jAR87N8qagASb=_uqt1=7WN3Q@mail.gmail.com>
Subject: Re: [PATCH] virtio_pmem: Check device status before requesting flush
To: Ira Weiny <ira.weiny@intel.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	virtualization@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 20, 2024 at 7:23=E2=80=AFAM Ira Weiny <ira.weiny@intel.com> wro=
te:
>
> Philip Chen wrote:
> > On Mon, Aug 19, 2024 at 2:56=E2=80=AFPM Ira Weiny <ira.weiny@intel.com>=
 wrote:
> > >
> > > Philip Chen wrote:
> > > > If a pmem device is in a bad status, the driver side could wait for
> > > > host ack forever in virtio_pmem_flush(), causing the system to hang=
.
> > >
> > > I assume this was supposed to be v2 and you resent this as a proper v=
2
> > > with a change list from v1?
> > Ah...yes, I'll fix it and re-send it as a v2 patch.
>
> Wait didn't you already do that?  Wasn't this v2?

Yes, but somehow the patch didn't go to my inbox.
(Maybe it's because there is no code change between v1 and v2?)
So I resent another v2 (with some minor change to the comment):
https://lore.kernel.org/all/20240820172256.903251-1-philipchen@chromium.org=
/
Please take a look.

>
> https://lore.kernel.org/all/20240815010337.2334245-1-philipchen@chromium.=
org/
>
> Ira

