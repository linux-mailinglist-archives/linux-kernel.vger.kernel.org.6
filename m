Return-Path: <linux-kernel+bounces-385868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 580B39B3CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8DF1C223AC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3921E00A0;
	Mon, 28 Oct 2024 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="arxxIELD"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BECD19005F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730151206; cv=none; b=W2vfdtnh7C3XXKe55QBZNDf34qVUX1EP7XywPuaA4EnOvoOOv2mrq6SfXcI0Y18KTvYRMOO9Q3zaN7X6iMlFzAH2W/yAZQQHyzUZJqAMMEgnBOsQ7cpM79LL8VcMu+nw4BlO7/Uv35WUXKq/78UCSFGYqkCmEvX1xq/JkEeJqKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730151206; c=relaxed/simple;
	bh=mWHqBO7ggUCFVDg3HGgCG/OeU8lRFkRHqMQJvFNQjcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UC66v2xxDfEG+OCW1NZ0rj3sHF2e2+hke/G+LhDWgeZEDTbRdKV3XRYu/LDREoPswmyS6agd9RAY6jZw4/VbUYfNxdcMLmYd/sj2+D7gsiBfyoO6BD2da69OQQuVY+K9pAxXkYqe/e2BxrklZFvGHYhTv0eFcobH41DoJy10ESc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=arxxIELD; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82cd93a6617so158220939f.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730151203; x=1730756003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFZKIzMwJccmjbRWz8hr4dF1BDbSPdCqeQ+MDKxNuD8=;
        b=arxxIELDUmRedJxNm+wSBF8ShnNy6C2RIky9yytjv57uIeyEyIyOuhmOSzbhAJMttf
         3+DMhk91nM/kB+/OKDhqBZnI6Nr4inDcF7eF5NKJZTh4+vAG2QsKSWaQZKNhPsNwWJSa
         dUCcef7OZzrZXtVW2QMIFGr3YtAl7RzTQBn98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730151203; x=1730756003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFZKIzMwJccmjbRWz8hr4dF1BDbSPdCqeQ+MDKxNuD8=;
        b=C82nqP/1XA3I8fVQRIEOaddkPAx6mrSpQ2yf74zTyfCK238xAPx+HuhxeldsLVioHT
         fY7DaA/efWYlJ6nQyWA9EAH+8f8IvY5qZDMsVYpIl+jh224OHjZ56IazHVUXXVU+rn6t
         eiZMiU1+XQEZQnBippVjk6o7zZ69CtI1zK9IxKj8kQk1Ll69OLFx5qzDS32pKbpu6P2k
         GZGJgmVtjp1wIgp6yDkloQz4S0yNsLzQnUqvkdik3IFm663t4kvgYk/r4sl6OxrQoPY4
         MSLCWvoRwSQW5egmwlMydyGPzG63FlC1vD7YNjfjSCt+h+UaF1XnMZX4vI9E1GVXeK/f
         jK0g==
X-Forwarded-Encrypted: i=1; AJvYcCXDOXSHpi7Y/NV9bxLOYqu52TxPdNYgKh5nrjS6e2eMkkeXuQ1Ivm6W2J5nXNPyAexS1IpYbYrU2Ph/82M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyibUBOryAJM4UhxaJm8/v3FffBt8ofGXh4W4wNbA1cZOmSavnA
	Jm7q1Ko820YOP4gAhqxBwDa9GKqU30LBfL6xvYlnmuKtskjqec1xuQvSaAd5erIZs0qQByp7JwX
	TQB9IA3zf0JOvtOLuQjzmD92P6Sa5KXhTUwd0
X-Google-Smtp-Source: AGHT+IFRf7Qdfzoq2U9A+NIDwOGbIKY7nZWXffb09QD8AJkz3xy2j34ROShaH6Jj6HGBK3DfHA78bcGG4mf4sL65r5o=
X-Received: by 2002:a05:6602:1686:b0:82a:2a67:9429 with SMTP id
 ca18e2360f4ac-83b1c3e7abemr939673139f.5.1730151203568; Mon, 28 Oct 2024
 14:33:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827181717.187245-1-robdclark@gmail.com> <Zx97PU7cUEVCnpPl@google.com>
In-Reply-To: <Zx97PU7cUEVCnpPl@google.com>
From: Rob Clark <robdclark@chromium.org>
Date: Mon, 28 Oct 2024 14:33:12 -0700
Message-ID: <CAJs_Fx6EB=0GMqe4cZVdxptFSV3b63HHybfTOgiYVBudgAafsA@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] io-pgtable-arm + drm/msm: Extend iova fault debugging
To: Mostafa Saleh <smostafa@google.com>
Cc: Rob Clark <robdclark@gmail.com>, iommu@lists.linux.dev, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, 
	"open list:DRM DRIVER for Qualcomm Adreno GPUs" <dri-devel@lists.freedesktop.org>, 
	"open list:DRM DRIVER for Qualcomm Adreno GPUs" <freedreno@lists.freedesktop.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Joao Martins <joao.m.martins@oracle.com>, Kevin Tian <kevin.tian@intel.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	"open list:DRM DRIVER for Qualcomm Adreno GPUs" <linux-arm-msm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sean Paul <sean@poorly.run>, Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 4:53=E2=80=AFAM Mostafa Saleh <smostafa@google.com>=
 wrote:
>
> Hi Rob,
>
> On Tue, Aug 27, 2024 at 11:17:08AM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > This series extends io-pgtable-arm with a method to retrieve the page
> > table entries traversed in the process of address translation, and then
> > beefs up drm/msm gpu devcore dump to include this (and additional info)
> > in the devcore dump.
> >
> > This is a respin of https://patchwork.freedesktop.org/series/94968/
> > (minus a patch that was already merged)
> >
> > v2: Fix an armv7/32b build error in the last patch
> > v3: Incorperate Will Deacon's suggestion to make the interface
> >     callback based.
> > v4: Actually wire up the callback
> > v5: Drop the callback approach
> > v6: Make walk-data struct pgtable specific and rename
> >     io_pgtable_walk_data to arm_lpae_io_pgtable_walk_data
> > v7: Re-use the pgtable walker added for arm_lpae_read_and_clear_dirty()
> > v8: Pass pte pointer to callback so it can modify the actual pte
> > v9: Fix selftests_running case
> >
> > Rob Clark (4):
> >   iommu/io-pgtable-arm: Make pgtable walker more generic
> >   iommu/io-pgtable-arm: Re-use the pgtable walk for iova_to_phys
> >   iommu/io-pgtable-arm: Add way to debug pgtable walk
> >   drm/msm: Extend gpu devcore dumps with pgtbl info
>
> Do you have plans to post another version of this series, as I am
> working on some patches, that would use some of the common page walk
> logic, so it would be more convenient to have them upstream.
> Otherwise, I can have your series as a dependency.

Sorry, this had dropped off my radar, I'll post an updated iteration
in a couple minutes.

BR,
-R

> Thanks,
> Mostafa
>
>
> >
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  10 ++
> >  drivers/gpu/drm/msm/msm_gpu.c           |   9 ++
> >  drivers/gpu/drm/msm/msm_gpu.h           |   8 ++
> >  drivers/gpu/drm/msm/msm_iommu.c         |  22 ++++
> >  drivers/gpu/drm/msm/msm_mmu.h           |   3 +-
> >  drivers/iommu/io-pgtable-arm.c          | 149 +++++++++++++++---------
> >  include/linux/io-pgtable.h              |  15 +++
> >  7 files changed, 160 insertions(+), 56 deletions(-)
> >
> > --
> > 2.46.0
> >

