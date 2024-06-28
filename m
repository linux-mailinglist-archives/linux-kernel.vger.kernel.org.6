Return-Path: <linux-kernel+bounces-234563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE8D91C80D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1431F22C36
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DF97E103;
	Fri, 28 Jun 2024 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RnvAyi2s"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAF65C89
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609833; cv=none; b=gmIcdkHtHyGKi2SwK2YNaH8KoxCfAD1uvfZCW9czQHTQ57cZ+A3lOjlSDObD+FNPN7gOXlaaWJuE2NSkr0wG6S/78AP+RiGt4uboKGKQvUCFr6N1VKzrKf69dPXvxY9yJz1WAGCdCpQEhWwygvToMFz5mxhOHE2UJfdNvNUhCTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609833; c=relaxed/simple;
	bh=I395gSmM2mRVaufGoBhAubG4eI18NB5NGs1I5z8QfNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAJkPCEaB8WL+V83YsQ9bygUNaS8nTcBLKzlKaXpKKNg5H6IIaAGbw2N7yUjaZ8dJoED51gxkyvk8saOGfmIdgxIOeeFLJVGIeKpBWzUs2XakfAOc7EIryNzCCKftMPgVSWQzTU2kFiXmegoHuTT9OA5I48bMDU8uHgWDbv6fgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RnvAyi2s; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee83so1415304a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719609830; x=1720214630; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fPONzgFDKNc6mvaoY/BV8TnQODNhboH9X4hMvRJS3Xo=;
        b=RnvAyi2seA+w/m/gAKe1RPMsydMjxsJzusqqBHSLcsFUjH3AgFV7qW9gFTZxceZvQP
         DvPyVcfsxW0ifN789trvFSQ6z0yWvRpQBhTXd2k5AbKCR5tht5P2QL6xuOWNYkJaVdp2
         gvAH3zV6BPhxl1FZpuSQNW9Idb0vDkFExMYsI6z22kaEPSsLdcrUEDZU9S6wCo3O0YVD
         k9BAe6aPAMEnxEUZyawUc9/l83Eey8AktiM9tW9+us5PLQAdWV4l0z8p2x1UPuKcRsPb
         jpE7tDAPkPcBArF6qYDXdyc8nprawzAdVVArXcVmVkp8VmSkvgD3zhrFTf3KU4Xi5Tz9
         alKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719609830; x=1720214630;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPONzgFDKNc6mvaoY/BV8TnQODNhboH9X4hMvRJS3Xo=;
        b=LzEIDAwGIiVvzLbob64PGYBixIRIO5ju7eLrQRxdfswxTd3TlqrMm1B8s4jT58alBu
         MmT3pfb5Lx5RjZEOAGPp9ozKqf++d8slw+tDWTYNPPwh8twqYOA3hbBNNBVvZP+Td/Kk
         huOf1rsDY1/EZMHHZXN8pIK/Dfrm+vGbbh+ugvK622KtqRtxLxME573SjSPLW3Z8GT/5
         9qcDEQfaJAFzvUec+ruvDZulsYjAlVB8Wj+m5etaBshfQCoRfsBi4daMdCTHK8C9N6fn
         SvqqyJThaeKQgWQxvzjWehM690JJ2I2ucRrPn/L029PcwC39H3ZN6jypaR/4yUmbdGsM
         gsZA==
X-Forwarded-Encrypted: i=1; AJvYcCUewT2NV4+v6czlBkAlXaQu2ERdtzpHpVMFdrQ8gosE//Hx/EdbCnLCN4NFXqQMPSS4138DZJ2z3CaFY5ES1msc8C6IrG/jOnn4QyEu
X-Gm-Message-State: AOJu0YwBN6485PWhQytHV5UZlmFyeV7ZoJuJoaYQHPtW+Wf+Ld6dobjw
	7kONH4DatPwiF5xQM6MybUZgYXHfip116ARzRRl9pbAcKMmkumoTRtXr0DolFrvL2ZG9O+tjdbh
	K8KnSvznOP9/NbjsWvosT2rzlj7kgWe6os/iIFQ==
X-Google-Smtp-Source: AGHT+IHP5K9VyaLHbZkzSrUTRDHOKNmezm41XM6NEtYOq+8i5E6s2bM5BtHkDtB12x/NAsn0biKrdMvFHJpJ95d30hU=
X-Received: by 2002:a50:9342:0:b0:57c:6d58:e1f1 with SMTP id
 4fb4d7f45d1cf-57d45780309mr12092712a12.9.1719609830495; Fri, 28 Jun 2024
 14:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621150058.319524-1-richard.genoud@bootlin.com>
In-Reply-To: <20240621150058.319524-1-richard.genoud@bootlin.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Fri, 28 Jun 2024 15:23:39 -0600
Message-ID: <CANLsYkyVW_PVRVA_POi9D1ug4mS-6G9Xdu9qD0Keh6Las6uu1A@mail.gmail.com>
Subject: Re: [PATCH 0/4] remoteproc: k3-r5: Introduce suspend to ram support
To: Richard Genoud <richard.genoud@bootlin.com>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Hari Nagalla <hnagalla@ti.com>, "Andrew F. Davis" <afd@ti.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Suman Anna <s-anna@ti.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Udit Kumar <u-kumar1@ti.com>, 
	Thomas Richard <thomas.richard@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	=?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jun 2024 at 09:01, Richard Genoud <richard.genoud@bootlin.com> wrote:
>
> This series enables the suspend to ram with R5F remote processors on TI K3
> platform.
>
> The 1st patch is actually a fix, independent from the others
>
> The 2nd patch introduces the suspend/resume handlers.
> On suspend, the running rprocs will be stopped (or detached) and then
> re-loaded in resume.
> The logic behind this is:
>  - shutdown the cores that Linux started to save power in suspend.
>  - detach the cores that were started before Linux.
>
> Then, the 3rd and 4th patches introduce the graceful shutdown of remote
> procs. This will give them a chance to release resources and shut down
> in a civilized manner.
>
> Without this series, the suspend fails with:
>
> omap-mailbox 31f81000.mailbox: fifo 1 has unexpected unread messages
> omap-mailbox 31f81000.mailbox: PM: dpm_run_callback(): platform_pm_suspend returns -16
> omap-mailbox 31f81000.mailbox: PM: platform_pm_suspend returned -16 after 16328 usecs
> omap-mailbox 31f81000.mailbox: PM: failed to suspend: error -16
>
> Patches 2 and 4 are based on work from Hari Nagalla <hnagalla@ti.com>.
>
> @Hari, please feel free to add your Co-developed-by:/Signed-off-by:
>
> Tested on J7200X SoM
> Series is based on v6.10-rc4
>
> Richard Genoud (4):
>   remoteproc: k3-r5: Fix IPC-only mode detection
>   remoteproc: k3-r5: Introduce PM suspend/resume handlers
>   remoteproc: k3-r5: k3_r5_rproc_stop: code reorder
>   remoteproc: k3-r5: support for graceful stop of remote cores
>
>  drivers/remoteproc/omap_remoteproc.h     |   9 +-
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 196 +++++++++++++++++++++--
>  2 files changed, 188 insertions(+), 17 deletions(-)
>

Nishanth, Vignesh, Hari and Andrew - I will wait for you guys to
review this patch before moving forward.

Thanks,
Mathieu

