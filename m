Return-Path: <linux-kernel+bounces-318502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C522396EECC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E211C208D2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA821C7B88;
	Fri,  6 Sep 2024 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYIyLU9U"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FC515852E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613581; cv=none; b=r2H08cjfWBmYdGCOx5DTJbrIVVC7qRvVti4LtdNhTnBiELz2oN4rlr03zr3P1Nk/PsU/0c5NG2fvifosAtaCxuOIsGVTBpytSK22xq0ndbmADWAyvy1MrFuJMxQU+r0Tr6FhykQI5FSDqpgAEfci9SO14+JzgJGotJmrQsNjROI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613581; c=relaxed/simple;
	bh=zlgEGvaO0mwBm9Y0cviQJdOiB/Hd76XGYSIn/QNgOPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PT7E7+JELlxSsHd+NKDMAF7+P2WX+tV7MQ1DYTO0NzORgY9e6hDcg+rcWk8pqzrVwf5PfohX+c8WFf4WADF2xXrmb4qWlkHL5KzZSwZbl1jApKJavFIs3ikjp/tPR7mfVuHh3Mvj0JuUE7NK7Lp2lVaa7N91Zg4KsBuxGm+88R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JYIyLU9U; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e1a82d1ef62so1890156276.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 02:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725613579; x=1726218379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlgEGvaO0mwBm9Y0cviQJdOiB/Hd76XGYSIn/QNgOPU=;
        b=JYIyLU9U6hU54nUIAXO/eHH+NeLA24qsGAAsfrolcq9U87OHMU7IgfE9dqqLx+UPJR
         N5yWLvmJyQMr19vBxaqhhqa70kEDtkFevwgFdk+pr2k5enUvt/HzAFX/5IHXpd+d7u9P
         vZHiPTLjpAShU7zkFZViLgIVWPvkB8rGQVOf2lgl+0Cr1xPM6pCjIBfEw+Rfl/POoNPp
         c1PD4Q2/DRZNSkNBZTkO8peslEnK1ESvshfNqWjyxDnkdKbCn3+DDHYmJURfY59aYiU9
         2XHWIErGE33IKRfGhI6J5lXHJJsLccCJQDcLDTaphTwaIZGvouxCuojufVksdswg6cOd
         0QvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725613579; x=1726218379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlgEGvaO0mwBm9Y0cviQJdOiB/Hd76XGYSIn/QNgOPU=;
        b=erRmAlMZjBHM6i8xhl78zPQr7N182x5LSiH+D8rAV9crNAPXoAqRel1fz8Su/uWMJP
         yZ3BOoStjqMVUbSVvjrgE23PaC3DWWA7GuVCrw/3ZDuXJe8x+81lhKeKoNnCtDLYl3N5
         P2CMVQvlQxKZCOmz1nBh33MvN2Fckc0j2/swwap/CrMkg8o62IX3MFtluI1rv7JoEtq/
         PpwKdcqp8ZNGUvp26bBO2PE0BKyJZSF/UB/J/nYLs4w/ZLZ0nPNu23CgsdNgrDik7I31
         HFDHEyGIvujSFsxrpWvc+mJm6kFbMl46dJqme69zDs/kGTSoRW16tBJBrl1r6SYdMuNx
         L3HA==
X-Forwarded-Encrypted: i=1; AJvYcCWauo22+3Vw6xkZ6dAMPrIPUqbzWue2UhvIbFemLyCfEkhjJF3dxZExYvuwwX1L10Pak2Rv3cVhE+kUhLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbPuKw2QPPMW5VwS7FDh3znBnaY0z3zp0iOc4qp0GuKX9FibOB
	LiffvOD+rrM/cPxNO83Eq4sIXwP9oB5akwAomkDVbhhrZXgw9RTPdF3oGiU9ZHQ2lbtdvt066LP
	QgqKoYK9Goq+jNNCHCqiEjvdnMpb5zo8Va+bMXw==
X-Google-Smtp-Source: AGHT+IEQhveipLe0kgAFzEV+OcUI/LgMXEd1VtfHS12t97hEIT4q5sW5xGf2x1tlGWQTK88dSL0ODPpNSyiMgItcjlc=
X-Received: by 2002:a05:6902:230b:b0:e11:6ae6:1bde with SMTP id
 3f1490d57ef6-e1d3489d816mr2400004276.31.1725613578877; Fri, 06 Sep 2024
 02:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905164344.186880-1-ulf.hansson@linaro.org>
 <b748a4aa-504b-4e58-9988-170e462401eb@kernel.dk> <CAPDyKFrgzuuDBMWjBDVFAzwTP30JeD+zP2mVo+E=P0MZwUepHA@mail.gmail.com>
 <2f2bd13d-933b-da9d-7ea0-5f875dec574b@huaweicloud.com>
In-Reply-To: <2f2bd13d-933b-da9d-7ea0-5f875dec574b@huaweicloud.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 6 Sep 2024 11:05:43 +0200
Message-ID: <CAPDyKFrpbgWmHyk2HPP11dA5To9PTwdBLVLyHTVfUOVKYzTUeQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Move the BFQ io scheduler to Odd Fixes state
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org, Paolo Valente <paolo.valente@unimore.it>, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Sept 2024 at 03:15, Yu Kuai <yukuai1@huaweicloud.com> wrote:
>
> Hi,
>
> =E5=9C=A8 2024/09/06 0:56, Ulf Hansson =E5=86=99=E9=81=93:
> > On Thu, 5 Sept 2024 at 18:49, Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 9/5/24 10:43 AM, Ulf Hansson wrote:
> >>> To not give up entirely on maintenance of BFQ, add myself and Linus W=
alleij
> >>> as maintainers for BFQ. Although, as both of us has limited bandwidth=
 for
> >>> this, let's reflect that by changing the state to Odd Fixes. If there=
 are
> >>> anybody else that would be interested to help with maintenance of BFQ=
,
> >>> please let us know.
> >>
> >> We don't add maintainers that haven't actually worked on the code. As =
it
> >> so happens, we already have a good candidate for this, who knows the
> >> block layer code and does many fixes there, Yu Kuai. And they recently
> >> sent in real fixes too. So that's likely the way the needle will swing=
.
> >
> > I would certainly appreciate it if Yu Kuai could step in and help,
> > that's why I cced him too.
> >
> > Although, me and Linus were thinking that helping with "Odd Fixes" is
> > better than nothing. Ohh, well, let's see what Yu Kuai thinks, then.
>
> I appreciate the opportunity and am willing to help with maintaining
> BFQ.
>
> Thank you for considering me for this role.
> Kuai

That's really great news! Looking forward to seeing a patch from you
to MAINTAINERS and I will do my best as a community citizen to support
you!

Kind regards
Uffe

