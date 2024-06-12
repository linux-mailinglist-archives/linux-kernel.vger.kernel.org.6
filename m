Return-Path: <linux-kernel+bounces-211597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF5490542D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038D81F2759B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A78317D894;
	Wed, 12 Jun 2024 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUaZomfi"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2197D17C7D5;
	Wed, 12 Jun 2024 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200338; cv=none; b=knD3Zuuz1aLKIFcSAsX07hWJDyf4cUQ3njOTdSNRdqMu2ig0ju55kiWAssXL4QjYEC+XOWTcqGnxZRWnp+CoxmLhMObq+npZgab058kI6C8Glq5ezvfX0Hxid3FVZPmdZ6oc/piewAYysRXWFJh8kdGb6R4qNqaQZw7crbSLKbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200338; c=relaxed/simple;
	bh=vURfWWaoavuMQtr8iMiAzgJp1HrcPNwaH67podfLJMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMBMfn7n0ATkz9xTn5dLi5dnxBjf2D1IEKhagf6uNG4s4797DmTu61AE65QOA8/Stt3zRSxpR5K6Olv1hSg1HI4iETxhzbKpEQYlq7T90lklwzRobIpeRch0IApMq8ZhDKqDcI/5OYW95C6lZVzGFb3nhvWHowEfDUsRdmarOCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUaZomfi; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57c778b5742so4930689a12.2;
        Wed, 12 Jun 2024 06:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718200335; x=1718805135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHc1ZsPbCGCdwzhRZnld9g8jJXsdFer/PGpVjzNGvKE=;
        b=lUaZomfiGXrL1oaUGv8gRFZvIWYSgmQsmNzXFkF2w3bB2GrwPtrqrvIOTYnlqYuwbF
         XXPZmHYVsTS2XXl08Zcy4Ie+kr2qgsqwdurIyPMPCHME13zCn6YBFe64MHH2i+JoKKKw
         EM7egboTMYt/Mrq2zSemtQTHNH+ishBQbno4PWqL4b9uS4vjxGBcnVeogXPG5jIM0NOv
         Ykw1XjiRYGcZuGe03SB5X513ZH0rJwYuK3RfKYbIWmQkpsoJaucBBmf5h4pvxX6jHVvB
         GDMYeipTii4coIm6IkSqtVJY6gdTLyoWSB1pONj5Ek0nGxQrqn+nA+WOtv6XoEBEVEoK
         zbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718200335; x=1718805135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHc1ZsPbCGCdwzhRZnld9g8jJXsdFer/PGpVjzNGvKE=;
        b=kIC6aW9CrmY/gVNV+ponob6htxhIXX0rl5f+hv2RpuScd9y7lobhuf66PorN7Uj/jh
         0e+FBIigIw8SJmSLCtWmyDsNXG2M3JGHqaiytAWajrT9dwm+3DLeSMGj21pnCVCms2QF
         D+GNFuHvWCcovLJNu2YlkW/7o3NqE1ShM+v53YI3FMNSslLHEpVzlXKFc9D95LlqRcP8
         x6dbRFl5nXjBozdQUOHSkK2bIu53pmmx270sQw++bZfI5/u945Bv3SzCFHSx6HXcqHqr
         bXVaMchTZfi94jpOrntBvZPHlO3+6K/+ZQlhper1kQElwGGOVBx5oeg9Fftnn4Wsp1CD
         ZVBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzddau7vkoY8A7t5LYT04yYIYDYIdhj5XZHAz1nqnOLeC8I7VD6epIwxSZnH5FRZuxAy3NEqgiRcQLenqvJejjfeZC29WWLidv94exI2g44LIYRQJ7J9ItkJDj03EvVMkqUtZ4tBQz
X-Gm-Message-State: AOJu0YxvSJVc3WExKHoZD9BCifDr5/TWtRxeqHbTAD6UI3GMb0fqKnyE
	xNrCj/uHIHDrieHgg6hxuK5y0IqTdFskintpFfCgGtNgVYuHuEcTJRFvSA41cXeRm2WHBp76jly
	drcM9lJHluscAWuYFmg8jhu8bVwQZpFKmGtb4cALp
X-Google-Smtp-Source: AGHT+IHai32POF9NwMbJgKxEhFaNjtRaTSulQTdshOHH6hj/3GrZgrLGSjBn3CD7CoSio0wBrjlptmoxR2YiDgg0A0Q=
X-Received: by 2002:a50:8e1b:0:b0:573:555e:6d89 with SMTP id
 4fb4d7f45d1cf-57ca9749559mr1283497a12.1.1718200335202; Wed, 12 Jun 2024
 06:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601092646.52139-1-joswang1221@gmail.com> <20240611142953.12057-1-joswang1221@gmail.com>
 <2024061247-geranium-unstaffed-ff09@gregkh>
In-Reply-To: <2024061247-geranium-unstaffed-ff09@gregkh>
From: joswang <joswang1221@gmail.com>
Date: Wed, 12 Jun 2024 21:52:04 +0800
Message-ID: <CAMtoTm32JDwWAjpKJ4TXxA9ROqqr-fNaOR1nqui8ayMHnYzkjg@mail.gmail.com>
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
> Should this have a cc: stable line?
>
> thanks,
>
> greg k-h

I have a question here, please help me confirm
1. Cc: stable@vger.kernel.org or Cc: stable@kernel.org ?
2. Do I need to modify the commit message, for example:
Cc: stable@kernel.org
Signed-off-by: Jos Wang <joswang@lenovo.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jos Wang <joswang@lenovo.com>

