Return-Path: <linux-kernel+bounces-182302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7708C8C895F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C521F23764
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4B612DDA7;
	Fri, 17 May 2024 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E+x+X2lP"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36AF12D201
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959898; cv=none; b=YfiDw7uMwtM5ASc4WJLL5tVDv6omjKC8wao4EZWomTLdBKkIJ70Gd/AJmilcnqa3ixZ4qrL3fZUNDH1w6a8hjNgIsTLM+WTyxjdJ4UmtAZhsIpajd3T/5yns8DGyot3k0trAuvHx+cNPdh7NuTvjytbcAVfp1mvx3DDVTZYSmL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959898; c=relaxed/simple;
	bh=wN74hcYde7suK53u4RRbLX0ng5P14jxD8jMODvoUHv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QijcXYwVD2i077Su8j7CDAs0UrUtlRAQ8OYG6wCgM70k4eilyHqiaJzMGlHImVpCUTpGeOSO3UNdGHuxKhox9VpAtlzO1l0rb2HV9oKTu2PMud/86tVSat1mTUd84n+z2bFkKQtqx6z8x0Q00Xs2Zrrm4mZZJ+INQkM6wDBkKNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E+x+X2lP; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43df751b5b8so6106851cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715959896; x=1716564696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7megH/H2PCv2+j9G389xKdUzN7SbYmctbozhmOjrak=;
        b=E+x+X2lP6A6hBGxFUW5t+IU0I6n799mNpHBmcjYuQTlPQnmgpA0CkMQSgZQ3Gs9VnJ
         QK5nw7H9mFuaNIuynchHcOJBnQBa9OmsNSAP9m1PycBm9F3T1YfYEIBPGqxjv2c+DmfS
         jR6TfMgAj3d6Lldu4bwaipc4ijaFq96efwxHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715959896; x=1716564696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7megH/H2PCv2+j9G389xKdUzN7SbYmctbozhmOjrak=;
        b=hDbilwrLI6LeWPiPtFW/qanwhnoBlTs3QsaW++P5Mt22ssfTQEF4rU5x+10gT/JMGB
         9lxJgg42f+3e/rQiAnrzNB7p3ySQxS1NKmXBymv5WQC6M+UZ+h1ljkKO0JGiiOsSj4HM
         6Hr1arHbpOX9Nj9FPGE95hZYYdvU9yNFfOa460krYsCgzGDUNbdZuldLJkX5MJlJyEFN
         os4Rjws6dqSgHtG0gIyS5YknJnqO0XB5SVBigDXN9LbbBvY9u7Z+jtDV12k8spnC48Di
         pollze8qrqpCTMplKM2hqW51+2EDxpqHFKmKo5dCJupcbE/zFCOh3cSGpmfY0cQ/RZKi
         dt2g==
X-Gm-Message-State: AOJu0YyOZIIiLjfgtYvsJzhFP/sMhbdtrCml6wnB+aZmcnGq+ruKxgG1
	ub512buGT6ccC8Z/iLSZKFr6M+5tteiOgtazZMU9AZ7NeiICnYDPPo8EfEdigqa7R0qOWn+gmxo
	mlEykUA/NINeH4FkHRfwTknVz8OTMldTyCdEG
X-Google-Smtp-Source: AGHT+IGhcIgFiNUmswLwDNFrEyhlQEYmVuB0KuktpQFJvPdoeuKAcVFmkHhvUvnReCh+DA3a2Vh8QYXmcY74cB7LSJU=
X-Received: by 2002:a05:622a:1109:b0:43a:699e:114c with SMTP id
 d75a77b69052e-43dec39cd25mr388192291cf.31.1715959895750; Fri, 17 May 2024
 08:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516115721.1.I8d413e641239c059d018d46cc569048b813a5d9b@changeid>
 <9dd1cfd1-fe13-4434-a7cc-e14113dcaf53@amd.com>
In-Reply-To: <9dd1cfd1-fe13-4434-a7cc-e14113dcaf53@amd.com>
From: Tim Van Patten <timvp@chromium.org>
Date: Fri, 17 May 2024 09:31:25 -0600
Message-ID: <CAMaBtwFTBp-oAMLD4BKgrxQrfvWpJ6NbWBpyoLXeaqg8ebLGaQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove GC HW IP 9.3.0 from noretry=1
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, alexander.deucher@amd.com, 
	prathyushi.nangia@amd.com, Tim Van Patten <timvp@google.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>, Le Ma <le.ma@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, "Shaoyun.liu" <Shaoyun.liu@amd.com>, 
	Shiwu Zhang <shiwu.zhang@amd.com>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	chris.kuruts@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 12:35=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 16.05.24 um 19:57 schrieb Tim Van Patten:
> > From: Tim Van Patten <timvp@google.com>
> >
> > The following commit updated gmc->noretry from 0 to 1 for GC HW IP
> > 9.3.0:
> >
> >      commit 5f3854f1f4e2 ("drm/amdgpu: add more cases to noretry=3D1")
> >
> > This causes the device to hang when a page fault occurs, until the
> > device is rebooted. Instead, revert back to gmc->noretry=3D0 so the dev=
ice
> > is still responsive.
>
> Wait a second. Why does the device hang on a page fault? That shouldn't
> happen independent of noretry.

No idea, but hopefully someone within AMD can help answer that.

I'm not an expert in this area, I was just able to bisect to the CL
causing the change in behavior. There are other reports of people
bisecting to the same CL, so this issue appears to extend beyond
ChromeOS:
https://gitlab.freedesktop.org/mesa/mesa/-/issues/9728#note_2063879

> So that strongly sounds like this is just hiding a bug elsewhere.

That's entirely possible, bringing the number of real issues up to (at
least) two:
1. Why the page faults are occurring to begin with.
  - Any video of size 66x2158 seems to trigger the issue.
2. Why the page faults result in the device hanging with gmc->noretry=3D1.

I've asked prathyushi.nangia@amd (chris.kuruts@amd may be helping as
well) to look into the page faults further, since they can't hang the
device if they don't exist. She should be able to provide any further
details if you're interested, but please feel free to reach out to me
as well if you have any other questions.

