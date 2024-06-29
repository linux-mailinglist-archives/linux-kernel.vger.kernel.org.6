Return-Path: <linux-kernel+bounces-234769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9550291CAC6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 05:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494E11F22C92
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 03:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F4F1CF9B;
	Sat, 29 Jun 2024 03:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5kHilRn"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307EA1CD16
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 03:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719630519; cv=none; b=BxpAy5T5hZC0rkINNDEc0KeiMsXtkXK7ljwzHXlkki4+1C5blYxSKn32QTR2o4SA5HNkFjrUJj/XTqiaBqf/y4j94GlDEFMikKfYY2SgOdqhIYLEma0530LmvuaAaLQU9DEBSu02uuCwCwuDVJ0YdJ5aIFzCSSUAh1r/lDUnwPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719630519; c=relaxed/simple;
	bh=qgGPcvsb6+r1xFDoLZxcteM9a1bh4kiL5lMtFZ4Q4Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuyAsxvU3bYZuWMLTZa/yu8sFb8JzK6T/Modk4v77lr4YB4kPwNUeICHuaguRR5Jxe6dIO4LD6HA6Cjh3cvXCbCO2MJpS7wZqHultyKrfK5du4ntVpcreklRujGGx6OEGqSLVypMO7RHyLidPGUpTv255DeZ2dXA/g8ljCKt1RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5kHilRn; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-80b76c5de79so305876241.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 20:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719630517; x=1720235317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wnDlBRDbrFFEHWTsI1GTSLJKALgYqucEpLx25tc8G0=;
        b=I5kHilRnnB9YhMNRGLoVyHVtqgQUeX1i8Xut/8en7WmGt3ItkcT2pLIC2fHeVbdQXF
         YDQ0NVYwXx9rHRtjEIZWYFbF0jfxUwbGRLSlvppU7ZwrPkOriARvS6DcChG+B6aOHSu5
         l2x+3d/DQEjcxGKG1ulc/PTX23WfA+XM25ptGTD3VC1V5KLZs9zS3yWpv16K9YxvZcAk
         M327YHXQctw4GTpkvuweq9l1LzLYfqs0INc/JMyYFInvjx4BCC5KRk9bnSpvBb6MBp5K
         K7y4EuSRq6Rdyev3NyhE6C3SYbqtD9UFw0HcGqFN64MBdGx05/lp4zkpjS4li3dycAc5
         FO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719630517; x=1720235317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wnDlBRDbrFFEHWTsI1GTSLJKALgYqucEpLx25tc8G0=;
        b=R1gCcfuHGuA3Ew/GLZ6W67/iCrUKUYQbtjvK0Vf4OWvhUcQbF0Dy9C7xyz0sISXF50
         //m0JHHSmV7eDuIlocLO5Ad0rKCDsMGl7vmZynBP83eYutOTuswC8AOmpGD89cbqPUg+
         ALU17a6iP49/ijxgiffv+1H5G77rdRX9miDTzmErW38eX1UVa9YQ0yxoozOYEyBGXPVl
         /5T3mowdvLPvb0OtW9d37SnCXcFDSMcMNq/EB/VExCbuNR+E9O6+eOY+3+M5z7EOvvQU
         s1TB3Yca4L5rAV7vQsGFthCg4R3KI8MtC4xbWJ7rHFwUV6isBMrrDOvPFagbzlKNYvST
         IotA==
X-Forwarded-Encrypted: i=1; AJvYcCXC0REiYfeF/y/Fks5wEJ5bULr8duZnnn/oiJaOE/xlqpuiM4OZ/dGqn3C5JTZKeJkMCQtN20RuKx6KR9T3YVRRz1eLHEssJXepbGVf
X-Gm-Message-State: AOJu0YxAD6jUKUISers0gLHJq0A7R1aV+0M7qLgtArALtnHuH3AqOPgw
	zBEZ4X2ock9+i1avfF4Clu0vydVF3j1Ni3+vXdIMRaWeLdfjPq/yx1LpgggelE3CbBu0ixYcoYY
	2zPDf0PJCHehiCZjuT/Byg7q0ZDg=
X-Google-Smtp-Source: AGHT+IEqdYyqlZVAB91EWsBZkFGv2Ld0LLd1tYty5zbmWTQg46BTlegrkIgfb0nwZQMkDf4wN47qNiiJSB1sQxuuye0=
X-Received: by 2002:a67:f8d9:0:b0:48c:42e9:1eeb with SMTP id
 ada2fe7eead31-48f52b00d9cmr17326855137.17.1719630516987; Fri, 28 Jun 2024
 20:08:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628130750.73097-1-ioworker0@gmail.com> <20240628130750.73097-3-ioworker0@gmail.com>
In-Reply-To: <20240628130750.73097-3-ioworker0@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 29 Jun 2024 15:08:25 +1200
Message-ID: <CAGsJ_4ybc6-PmJEP-h_uWmT1wqE9gmT8b0juXkYYi7XpzSrpdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: add docs for per-order mTHP split counters
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, dj456119@gmail.com, ryan.roberts@arm.com, 
	david@redhat.com, shy828301@gmail.com, ziy@nvidia.com, libang.li@antgroup.com, 
	baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Mingzhe Yang <mingzhe.yang@ly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 1:09=E2=80=AFAM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> This commit introduces documentation for mTHP split counters in
> transhuge.rst.
>
> Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  Documentation/admin-guide/mm/transhuge.rst | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index 1f72b00af5d3..709fe10b60f4 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -514,6 +514,22 @@ file_fallback_charge
>         falls back to using small pages even though the allocation was
>         successful.
>
> +split
> +       is incremented every time a huge page is successfully split into
> +       base pages. This can happen for a variety of reasons but a common
> +       reason is that a huge page is old and is being reclaimed.
> +       This action implies splitting any block mappings into PTEs.
> +
> +split_failed
> +       is incremented if kernel fails to split huge
> +       page. This can happen if the page was pinned by somebody.
> +
> +split_deferred
> +       is incremented when a huge page is put onto split
> +       queue. This happens when a huge page is partially unmapped and
> +       splitting it would free up some memory. Pages on split queue are
> +       going to be split under memory pressure.
> +
>  As the system ages, allocating huge pages may be expensive as the
>  system uses memory compaction to copy data around memory to free a
>  huge page for use. There are some counters in ``/proc/vmstat`` to help
> --
> 2.45.2
>

