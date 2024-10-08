Return-Path: <linux-kernel+bounces-355413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADFF9951EA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F0D1C24F0A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4866C38DC0;
	Tue,  8 Oct 2024 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dv4N+39V"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE481DFD9A
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398192; cv=none; b=FUawTTJP0Wfmc7C/i8BxxkGLtQPjibclYV3zoTqXgBuN6xGdMWYipywcKHiRSr5mHMl9DvHfoL6K+5KUVRXZJki8k/KRPDCe5APOPMZoVoGMHUhK+19ExLJ6EC2LIQlL9+EGhzomwcWabgOy/WJVbd9tA1CehiKbHjXc1auE+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398192; c=relaxed/simple;
	bh=trhP2fQ5tQcbrAcoOmy+SrWN61xKTxkCLLzO4F17ztc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nj4b2Ky7kJfBD7/ybIfuj8UWRib3y8u1Nn/zxJXPAPmDfNYRKAjQryhuodRiBPw/oS3F/phehQnHJBc1jb+1uheNkcpivXNwjG/eFI0ZTVYZgkSq2C4qYjD88+TEzm/TyMiAsKel3NJCpqeF+T7UtkYcQ4qaOMEJzis4Uwfxt74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dv4N+39V; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso5698491276.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728398189; x=1729002989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BAg7ZidTPorvVYHmDce4EjXWI2oNXBm6unQqHawkopY=;
        b=Dv4N+39VHrFx5b92LvIVvlnb6REu+ZYGjkinLIFcE8A5Mc/R0RH3GuU97a+qrbCIUy
         FjfEofgi01xLSwLtOWmCt425/h/NkaOyozUWQcafRIMPoNVznjO7CfNpTGbBPyzZe9x2
         AAsVRBH34MLR/BtstDO7/aD+EF4u3OGPOrNi+aPDSmfOrWVAqGCgtgVb8nfFs8b1ZXvq
         9RLBL0dn1HqsgoBC15LXS3CjGSofWLxcW1XYIpAM9RfvRns1l/XshB1XwK4CnTT1GoHc
         HOj1hvYobE1uDD5Na8trdKh+IZxO92ejriGFx6PZlbWUKjzoLcjE+dh84GEsl/FO6BDd
         ayHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398189; x=1729002989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAg7ZidTPorvVYHmDce4EjXWI2oNXBm6unQqHawkopY=;
        b=gVeVIVfvXt+oCDVl/3Fz0f0IPp+/D22HnQXEJX9tNVDLmyF+CmmqLYTCBh7PS72q2C
         rrzLj+h/SSrA7J1i5bSFP7njBP914UC3P/u+tRhgkAM++m/tOOrh7eD8Bc76BsXi2OgV
         vRtL25JrWJTMX7VZhW7xlLfF31kWzNLnHouSC4Id0UDif89zkCJQ/NGS8qy2jQs22WAf
         jbgPF1WicwEDwVtVF6y6wa2PPrjSM/T96EiOmM3LTAcOaJL2vw3aYz2jbjL+qperVLFP
         qQJsI2jOmvRMq4jqlknAZmA4ZWYJKeQYjUdEZuOEVxaO+axr+rBqDdP/4/VZ/z3Jn9Z0
         q6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu3Hqi4t5Oq8LCnG+xi3j3YHvNuEF+QaGWcITih9MCRPNRyHcKF2IoslinA9o9jI1TBeG6XEtIShbksLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj5mq9gM6nFj5YkDRsBlp4kDwgO+1UgTT2WeQ2yt6d0tRoKIMt
	tfOWN+fhwCPNlAsdp7jBoGojlr4HlnER0TluptHt9Mns63shLs/8OX8dipoptXdDyBNAphaeB52
	uCfLn9sCs8fl8pNC9X55xOeDZAJZFoK3P1ZqvafHW9pbanA2c
X-Google-Smtp-Source: AGHT+IElQGC355Tl6gUscWB/+cWTaMDp3U8oY/mskRAuU/uZktLuiXA3kZX0imsHGtcNvu2zACQAimf/q0UcsteCplI=
X-Received: by 2002:a05:6902:2289:b0:e20:25bb:7893 with SMTP id
 3f1490d57ef6-e28939282b3mr11151806276.46.1728398188940; Tue, 08 Oct 2024
 07:36:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6509d6f6ed64193f04e747a98ccea7492c976ca8.1727540434.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <6509d6f6ed64193f04e747a98ccea7492c976ca8.1727540434.git.christophe.jaillet@wanadoo.fr>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 16:35:50 +0200
Message-ID: <CAPDyKFpBK_aGqJh-k=mRYJoupJTULgGW7MueYzQXimLMAaUwTw@mail.gmail.com>
Subject: Re: [PATCH] memstick: Constify struct memstick_device_id
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 28 Sept 2024 at 18:21, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'struct memstick_device_id' are not modified in these drivers.
>
> Constifying this structure moves some data to a read-only section, so
> increases overall security.
>
> Update memstick_dev_match(), memstick_bus_match() and struct
> memstick_driver accordingly.
>
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text    data     bss     dec     hex filename
>   74055    3455      88   77598   12f1e drivers/memstick/core/ms_block.o
>
> After:
> =====
>    text    data     bss     dec     hex filename
>   74087    3423      88   77598   12f1e drivers/memstick/core/ms_block.o
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Compile tested only
> ---
>  drivers/memstick/core/memstick.c    | 4 ++--
>  drivers/memstick/core/ms_block.c    | 2 +-
>  drivers/memstick/core/mspro_block.c | 2 +-
>  include/linux/memstick.h            | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index 9a3a784054cc..ae4e8b8e6eb7 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -26,7 +26,7 @@ static DEFINE_IDR(memstick_host_idr);
>  static DEFINE_SPINLOCK(memstick_host_lock);
>
>  static int memstick_dev_match(struct memstick_dev *card,
> -                             struct memstick_device_id *id)
> +                             const struct memstick_device_id *id)
>  {
>         if (id->match_flags & MEMSTICK_MATCH_ALL) {
>                 if ((id->type == card->id.type)
> @@ -44,7 +44,7 @@ static int memstick_bus_match(struct device *dev, const struct device_driver *dr
>                                                  dev);
>         const struct memstick_driver *ms_drv = container_of_const(drv, struct memstick_driver,
>                                                                   driver);
> -       struct memstick_device_id *ids = ms_drv->id_table;
> +       const struct memstick_device_id *ids = ms_drv->id_table;
>
>         if (ids) {
>                 while (ids->match_flags) {
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index 47a314a4eb6f..c572f870fcf1 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -2279,7 +2279,7 @@ static int msb_resume(struct memstick_dev *card)
>
>  #endif /* CONFIG_PM */
>
> -static struct memstick_device_id msb_id_tbl[] = {
> +static const struct memstick_device_id msb_id_tbl[] = {
>         {MEMSTICK_MATCH_ALL, MEMSTICK_TYPE_LEGACY, MEMSTICK_CATEGORY_STORAGE,
>          MEMSTICK_CLASS_FLASH},
>
> diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
> index 49accfdc89d6..13b317c56069 100644
> --- a/drivers/memstick/core/mspro_block.c
> +++ b/drivers/memstick/core/mspro_block.c
> @@ -1349,7 +1349,7 @@ static int mspro_block_resume(struct memstick_dev *card)
>
>  #endif /* CONFIG_PM */
>
> -static struct memstick_device_id mspro_block_id_tbl[] = {
> +static const struct memstick_device_id mspro_block_id_tbl[] = {
>         {MEMSTICK_MATCH_ALL, MEMSTICK_TYPE_PRO, MEMSTICK_CATEGORY_STORAGE_DUO,
>          MEMSTICK_CLASS_DUO},
>         {}
> diff --git a/include/linux/memstick.h b/include/linux/memstick.h
> index ebf73d4ee969..107bdcbedf79 100644
> --- a/include/linux/memstick.h
> +++ b/include/linux/memstick.h
> @@ -293,7 +293,7 @@ struct memstick_host {
>  };
>
>  struct memstick_driver {
> -       struct memstick_device_id *id_table;
> +       const struct memstick_device_id *id_table;
>         int                       (*probe)(struct memstick_dev *card);
>         void                      (*remove)(struct memstick_dev *card);
>         int                       (*suspend)(struct memstick_dev *card,
> --
> 2.46.2
>

