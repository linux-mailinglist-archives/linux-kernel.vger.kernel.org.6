Return-Path: <linux-kernel+bounces-323219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD75497399F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFFE1F2563E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE2D197A97;
	Tue, 10 Sep 2024 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BtdVmvkA"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FD4195F28
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977713; cv=none; b=U+7aVUocmnmKl0eF5WDPGAWfLeYsWeHSTnmD5VVAsSsbg57jrdyeAn8vvqdXZULOiwrvcAc/Ug/j+Fc4Z3DBzg8O0Q4zfhvUOPuZtGEJwnWJERCvrR31fOcp8vBVmFex2ubicapcr3q+z3LJwlfWyaTK7Bd5RaplPjViPEElQto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977713; c=relaxed/simple;
	bh=o12lXWffYA2duKfNkX3xBv+v9fkQ0G/xTm6g4Zkt/HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PyYb1sZTit8HBGDiVT/ka8LSj804wDb9QhXLZf59XorGrUAIVFtOQlAyQxiv0gsi7m7Xil383mYMMOTO97GfuSYLy1l66L+qcwk+fFLURnsuRgXn0pT6rFqIUxsAfHvup7C6Ro7UjXdDgBMOratPRykPdANmPAiaGf5q7KZYOYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BtdVmvkA; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c26852aff1so6526640a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725977710; x=1726582510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o12lXWffYA2duKfNkX3xBv+v9fkQ0G/xTm6g4Zkt/HY=;
        b=BtdVmvkArkf7hu636EeTaeUoFS/aHpaGBe2346q6wqinG1w9tytSmkumoSbITehion
         FVGreHAR5VwJlo9svxr74B8dzjH+rC6rKz5YJ9MaQdV6vh43G21V5ICKwUWirJAeL4NM
         zPN/ELX8Nn2lQxEF1+wSPHgIixDOy/fZNc+HyNbaIMuFXTBxuyAeTsfCu2m7AmxyOzYc
         egfm1nlU2GEDBbZp+oByhJsy+NpmOyoZnfBoeAYhYW5B5uvEdDtwZZYOSuQ/GjdzNQ0h
         bC9ZlBHRjlnCsBoJy9OxS3TV7yQSbzqRg68hswbhZaXD3I/UK5sJ4Uz1dQ/2cdc0YKXg
         Q6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725977710; x=1726582510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o12lXWffYA2duKfNkX3xBv+v9fkQ0G/xTm6g4Zkt/HY=;
        b=TvZDCgZVALHFkomnWnL+MGY4O7rqYnuGj2KmsqQ3TfVZIA+I3CRlfuckcRLoEH+pjq
         GpTKVvSw+BwBC6cd1ifM+t9AKyaMMRKkIdiZGTeP7Ml2LrG9XoCeX3XbC7QSpqmW7Bjf
         Yo3tTLrIk45Dy2ovQFFintEojim7Gm98WndUVl5Q7cua2iP/bXh5WSQ+M8JzcLc1UQhZ
         2ioX8D3H63qhECEYi+zDMPEeQkvcZ660EhHZcIlGTg5NFPjhqTESu4aQ+9gsW9nKP30e
         joJgrJGXpQ/EWDluM/qIhyW72brlN6N3dcbitvmWMEoBMCj5JqPG0yrr5c4D981kgjkt
         LnBA==
X-Forwarded-Encrypted: i=1; AJvYcCXFWl3AI5TunHXiAFPxYfMeg+cGO/kdG3vzhsyuSOirniUqREOIwJnryoTDa5yheFWHbPLg+c5NgN88OSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbXfW8LLyOTWuJhN6x/gzSDCF1SXT1EuQiq2HR8NaNlVGPAk18
	qx8U8rAAshp07RcTwUKYiUo9tCBak7tlV09Eamp95MNGRbhPJ/qWW6KG1It1BFeoUsKQLE9Ucz7
	qBWF9ZGEX1+JHpmfNigDWD257Yi7kfR9T3FgNgA==
X-Google-Smtp-Source: AGHT+IFNbnJcv991n6EaGeE+4q5VW27Y2Ncf5QyZ9FldTxQk0HrQFWE/YbOvJOp9f8ir/5TrCOSOe0F83sf2QNM8B9w=
X-Received: by 2002:a05:6402:5cd:b0:5c3:cc7d:c29d with SMTP id
 4fb4d7f45d1cf-5c3e95354abmr7741754a12.6.1725977709882; Tue, 10 Sep 2024
 07:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906000314.2368749-1-tjmercier@google.com> <CANDhNCqudbuWM-WG7jiY_KQfgOZ84nAwWUfUHNzgniBiSZzeyA@mail.gmail.com>
In-Reply-To: <CANDhNCqudbuWM-WG7jiY_KQfgOZ84nAwWUfUHNzgniBiSZzeyA@mail.gmail.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Tue, 10 Sep 2024 19:44:58 +0530
Message-ID: <CAO_48GES8YytcVyTsm3a_eeL65B41bMnCj=q=e3F6GKg4V-Sew@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: heaps: Add __init to CMA and system heap
 module_init functions
To: John Stultz <jstultz@google.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, 6 Sept 2024 at 05:47, John Stultz <jstultz@google.com> wrote:
>
> On Thu, Sep 5, 2024 at 5:03=E2=80=AFPM T.J. Mercier <tjmercier@google.com=
> wrote:
> >
> > Shrink the kernel .text a bit after successful initialization of the
> > heaps.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
>
> Acked-by: John Stultz <jstultz@google.com>

Thanks for the patch; pushed to drm-misc-next.

Best,
Sumit.

