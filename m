Return-Path: <linux-kernel+bounces-416063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799F19D3FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E94283DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFE915383A;
	Wed, 20 Nov 2024 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QxoSfMV9"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C13145B1B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118661; cv=none; b=NN6sUTAKasLJN4vbtyhkZE6ltZvUdDTjdDyAHPHWEQXsSVe9e74BofOHFUZ+7vt4TZS40waZ8ml9DOVPb6scQ3G4yeIe5So/O3BgEvbxF9gfeetPJcxJmnuGjEEgZFtWyJk4aPt6bQa/7vd2hItWbFyoz9GJvvCgiND8k5Eoptw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118661; c=relaxed/simple;
	bh=C+ipxx2Lxjuq8RmwyJkp0n9Ga1pbn3fP/mqsnlPvJ0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEI229kzo/2MLMP7dreErNZ9UMwmI/UwzxR6YLYH2GGRKkbBSgE7M0T6cJxwuDFv3kFXVdzjZUa3yetwGRmvlTZ0BlIvONsRve8u1P0mXYGH5IT0PY/0qjDK2/aky4NrTVt1Yv+14rPZmmyWAAUGHupQpnW9FRntQq0WIwkpWDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QxoSfMV9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so6880918a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732118656; x=1732723456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OnybE9QCu9YjR+AlgSDdsYdZNq3wPb3NxMHboXiHWhU=;
        b=QxoSfMV9bJ1eKNaQVT1or+tscmPs/yOYX7wU/tNBC3fLXaYmsGee43AaWtSXfUjbki
         DbzBNC1eAnTOK93AVzZJwlyhWZyS/bYaCsm9uPUNxdutjAfgx4bzdriyAD7w/7JL+Aqx
         N0t3sNBcd0f5iYwhDSPu0qqmqQrOLH/ZRnl3UP8q2/OGQFBEnVeX7cEufjzelNl00aNm
         x3cUm87CwIabnagrmbiyafKfbs44lvyTbPV1MDPTppG/+aNY+sO9B+AywEDMwCsEAEIz
         DKhnWBiB4fI2GAaQJ3uKg66/Tr1S6grZtF+KPMmTE6+n1wqm9JDatWd6rZJu7jJLZY38
         NOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732118656; x=1732723456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OnybE9QCu9YjR+AlgSDdsYdZNq3wPb3NxMHboXiHWhU=;
        b=D6DN43GFZe5TzsWE8f2ZXQ4q250xuavV+1r4HJqXEQekoF2n3yFwcu3E7YcEPbRsro
         GMpKjRnn9+0/FGM34Ne7FJdqFD7qHqA4HIyoYzL/gIS9GjDCAd8eEEt/EpSS9iiCh/ul
         7749x2ZqFrZylbrrXZWrcidu8MKZWZyTD4fyzbWqvUArDniAfyjr/0xo9dt4nUyaUqrU
         hCcaTtHDDrx7ADwD5AdcgcJ4oqFNVWKl2vPnBNIJ6jExRcSlR3NEtYg7gXXp7B1BujuQ
         97mwhpd8/NpoRIqZUw9HZPtVxFKxbac9CV6ToXdbhyo3THG0VGCn8jdxxlYsa4JZvrXe
         Vq/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVr9VFkLhg9SiPGsUC4yH9d+MUkxQ68RRSONofG97cv0MQNXtY+U5LYq1hvuW3EbM+oRn/aaSlJv8RoeP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCVHKf8K4lIVm8EtnFMLfJaPQCMgxAc2wPK9MhBJ3pmLg2hoMj
	jWWCvAUNt9ip/7Cfk8feQQLDieOuWO6umntPH4mB2ohvFRpHSIJwZ7XzNkYCyf0nAld06nou/bE
	eoGpza1mz2AAQLLPtgYg9utv5jd32gvuqHmTEyw==
X-Google-Smtp-Source: AGHT+IEezToTFcoX5Xms/RtQNmq3YRhKxr9Pb8q85vlLo+drb3zJ5gE/CYUXZHS4Gz0odg4pA6FKIoe9SJMmNxotd3g=
X-Received: by 2002:a05:6402:1e89:b0:5cf:d333:eb75 with SMTP id
 4fb4d7f45d1cf-5cff4cd134amr2866973a12.27.1732118656340; Wed, 20 Nov 2024
 08:04:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104133515.256497-1-arnaud.pouliquen@foss.st.com>
 <20241104133515.256497-5-arnaud.pouliquen@foss.st.com> <Zzt+7NBdNjyzWZIb@p14s>
 <0d9075cd-68c2-49ec-9b9c-4315aa8c8517@foss.st.com> <CANLsYkxvTuLv8Omw-UeyPaA9g9QokmtMaMYD0eoUPo20wUuONQ@mail.gmail.com>
In-Reply-To: <CANLsYkxvTuLv8Omw-UeyPaA9g9QokmtMaMYD0eoUPo20wUuONQ@mail.gmail.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 20 Nov 2024 09:04:05 -0700
Message-ID: <CANLsYkwPDFvJxgXrAV=92w+sT8tXB=-=K8Qs8eRVKm2C2v+0aA@mail.gmail.com>
Subject: Re: [PATCH v13 4/7] remoteproc: Introduce release_fw optional operation
To: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Jens Wiklander <jens.wiklander@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Nov 2024 at 13:38, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Tue, 19 Nov 2024 at 11:14, Arnaud POULIQUEN
> <arnaud.pouliquen@foss.st.com> wrote:
> >
> > Hello Mathieu,
> >
> > On 11/18/24 18:52, Mathieu Poirier wrote:
> > > On Mon, Nov 04, 2024 at 02:35:12PM +0100, Arnaud Pouliquen wrote:
> > >> This patch updates the rproc_ops struct to include an optional
> > >> release_fw function.
> > >>
> > >> The release_fw ops is responsible for releasing the remote processor
> > >> firmware image. The ops is called in the following cases:
> > >>
> > >>  - An error occurs in rproc_start() between the loading of the segments and
> > >>       the start of the remote processor.
> > >>  - after stopping the remote processor.
> > >>
> > >> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> > >> ---
> > >> Updates from version V11:
> > >> - fix typo in @release_fw comment
> > >> ---
> > >>  drivers/remoteproc/remoteproc_core.c | 5 +++++
> > >>  include/linux/remoteproc.h           | 3 +++
> > >>  2 files changed, 8 insertions(+)
> > >>
> > >> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > >> index 7694817f25d4..46863e1ca307 100644
> > >> --- a/drivers/remoteproc/remoteproc_core.c
> > >> +++ b/drivers/remoteproc/remoteproc_core.c
> > >> @@ -1258,6 +1258,9 @@ static int rproc_alloc_registered_carveouts(struct rproc *rproc)
> > >>
> > >>  static void rproc_release_fw(struct rproc *rproc)
> > >>  {
> > >> +    if (rproc->ops->release_fw)
> > >> +            rproc->ops->release_fw(rproc);
> > >> +
> > >>      /* Free the copy of the resource table */
> > >>      kfree(rproc->cached_table);
> > >>      rproc->cached_table = NULL;
> > >> @@ -1377,6 +1380,8 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
> > >>  unprepare_subdevices:
> > >>      rproc_unprepare_subdevices(rproc);
> > >>  reset_table_ptr:
> > >> +    if (rproc->ops->release_fw)
> > >> +            rproc->ops->release_fw(rproc);
> > >>      rproc->table_ptr = rproc->cached_table;
> > >
> > > I suggest the following:
> > >
> > > 1) Create two new functions, i.e rproc_load_fw() and rproc_release_fw().  The
> > > only thing those would do is call rproc->ops->load_fw() and
> > > rproc->ops->release_fw(), if they are present.  When a TEE interface is
> > > available, ->load_fw() and ->release_fw() become rproc_tee_load_fw() and
> > > rproc_tee_release_fw().
> >
> >
> > I'm wondering if it should be ->preload_fw() instead of ->load_fw() ops, as the
> > ->load() op already exists.
> >
>
> I agree that ->load() and ->load_fw() will lead to confusion.  I would
> support ->preload_fw() but there is no obvious antonyme.
>
> Since we already have rproc_ops::prepare() and rproc_prepare_device()
> I suggest rproc_ops::prepare_fw() and rproc_prepare_fw().  The
> corollary would be rproc_ops::unprepare_fw() and rproc_unprepare_fm().
> That said, I'm open to other ideas should you be interested in finding
> other alternatives.
>

Actually...  A better approach might to rename rproc::load to
rproc::load_segments.  That way we can use rproc::load_fw() and
rproc_load_fw() without confusion.

> > >
> > > 2) Call rproc_load_fw() in rproc_boot(), just before rproc_fw_boot().  If the
> > > call to rproc_fw_boot() fails, call rproc_release_fw().
> > >
> > > 3) The same logic applies to rproc_boot_recovery(), i.e call rproc_load_fw()
> > > before rproc_start() and call rproc_release_fw() if rproc_start() fails.
> >
> >
> > I implemented this and I'm currently testing it.
> > Thise second part requires a few adjustments to work. The ->load() ops needs to
> > becomes optional to not be called if the "->preload_fw()" is used.
> >
> > For that, I propose to return 0 in rproc_load_segments if rproc->ops->load is
> > NULL and compensate by checking that at least "->preload_fw()" or ->load() is
> > non-null in rproc_alloc_ops.
> >
>
> I agree.
>
> > Thanks,
> > Arnaud
> >
> >
> > >
> > > 4) Take rproc_tee_load_fw() out of rproc_tee_parse_fw().  It will now be called
> > > in rproc_load_fw().
> > >
> > > 5) As stated above function rproc_release_fw() now calls rproc_tee_release_fw().
> > > The former is already called in rproc_shutdown() so we are good in that front.
> > >
> > > With the above the cached_table management within the core remains the same and
> > > we can get rid of patch 3.7.
> >
> > >
> > > Thanks,
> > > Mathieu
> > >
> > >>
> > >>      return ret;
> > >> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > >> index 2e0ddcb2d792..08e0187a84d9 100644
> > >> --- a/include/linux/remoteproc.h
> > >> +++ b/include/linux/remoteproc.h
> > >> @@ -381,6 +381,8 @@ enum rsc_handling_status {
> > >>   * @panic:  optional callback to react to system panic, core will delay
> > >>   *          panic at least the returned number of milliseconds
> > >>   * @coredump:         collect firmware dump after the subsystem is shutdown
> > >> + * @release_fw:     optional function to release the firmware image from ROM memories.
> > >> + *          This function is called after stopping the remote processor or in case of an error
> > >>   */
> > >>  struct rproc_ops {
> > >>      int (*prepare)(struct rproc *rproc);
> > >> @@ -403,6 +405,7 @@ struct rproc_ops {
> > >>      u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
> > >>      unsigned long (*panic)(struct rproc *rproc);
> > >>      void (*coredump)(struct rproc *rproc);
> > >> +    void (*release_fw)(struct rproc *rproc);
> > >>  };
> > >>
> > >>  /**
> > >> --
> > >> 2.25.1
> > >>

