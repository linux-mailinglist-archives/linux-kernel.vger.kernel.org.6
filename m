Return-Path: <linux-kernel+bounces-293124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B03957B06
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD561F23004
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24D11798F;
	Tue, 20 Aug 2024 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3zYAmpq"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B235AF9EC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724117665; cv=none; b=Zo9Qt7zF3zDz+oisn8+i8NBcX0ODC3nuX5g4SpeMpx+w0EQccHswBT2CGgyI0gTrk53ws7E8JaEm0HhHpe3vMoyZ1zXXmhLietbcrBKoHq6r/7Mv7reW0f3hOK093FUVrONoX7IXVB8WcifXD2eEBXLMVmtWl4BZ+hSd8+KSTp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724117665; c=relaxed/simple;
	bh=o6qPa8f3sP1mC+rT2qdvoPFSMYzpk0OUGYh5ItWMEms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVG0YieN3yY6d0ENs4J0MZlA8F33/SYpwEMa0JRwXUEGAriiliOR/n7HBxRLHpVJ5pMMLJq6ztYKCPQwKRynMwzRtU6cLS1DyPwTohju8Buh8rrvo8ihXIf8KkE5kEmX5xWFMvWqWGoHvICr+0Ecp1anY0RWxhkXwthWjMBYLvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3zYAmpq; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39d25267dacso2023685ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724117663; x=1724722463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zz0yf1/Y0q98UkeCNc6m4P8pN/IvsoVhD8EtrTurEF8=;
        b=J3zYAmpq4v3dKXJSVyQPgUcn1k+Z9EYLlJs9EKjFtCHZvAiVqtq845P4fYsjP+m8dG
         AhETC3TleWar9GSfetvxJB1c+C8T0xiQ5wyKogMHhMT8CcPuwQ20RWAz/7s/ocuReZ68
         oCvSUeeTe0fS9HZGhHdmOm6+RBWXrHP6lk6Idcw7xAghr3VRxYV3Us0FaFilW1XFMsrs
         DsxV9wbCzBGrEe3rJSzEeJZci/FyuTajXc+/Z0pkDgw5jAZQ+efbmcu2LuB8Y4m7+c/T
         TdVnFeL0UB0GUHg3BuHhmtgiRdgIRvE7xGeHK99ThIobEcyVSbGXtuOdvHHdJw3NuIZA
         kV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724117663; x=1724722463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zz0yf1/Y0q98UkeCNc6m4P8pN/IvsoVhD8EtrTurEF8=;
        b=ogckqZpUaaonXm6XDJBN/5sVVbuqMobyoeaLlDyWk4V6lJkhZ8JDE+2oCgaNGtkefE
         PGZJ0D33FGzFrQQcyB4a7Ml7AYB7ZYtdGZbgPUbYCqvTe9x1KuiHvO/RtKxOmZunJ1yI
         K+3rf9oibiVeDSdy9+jBJatvsCcBW0AISOOrWVfia9kx8G+q2tXaUSwFIy61gE0HuJ6v
         3KnO2wAZoeZNI/lvYf4HIGtKzETytulRy07/c5dmyqnpcPoSCAZo9FrGl/Izzc+Ph3uH
         Oh43WqSGR2WZ4qdkBB/vZmz44zH3iFLqSXPeflacZ23d7JTeySeKa5oJF3xGxjdaLWO/
         /nNA==
X-Forwarded-Encrypted: i=1; AJvYcCVFdkLaiY2YoMye38a7R6xdCyDoWMYzEdlmtGMuxUnQCLy9At6IG0tFVfzEoBjb+Qr0eMELr/KPK8fXKns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgO+8olJynSjCR7tHddrLhJw5zySJCzQ/hFdN/HOfdBPzBFN1v
	jxvI2WIOPFCCmMogt4VUQadRXmltzj+lXAQ9nBLQAuLRbZuqBtMFJ8CfkhHx6JqGAHbD/sPCNhc
	bG9seOWBwH5vFtez1jEd+gZkTrEfvkTvc7Zk=
X-Google-Smtp-Source: AGHT+IH2AsFaMWdba8AOgcnp+2GFW/3VG5Vj4/V/h1JYgxxD5JHekYstIjqy6bOiXsUFWjTCM1F2jVROifOBG4WowQo=
X-Received: by 2002:a05:6e02:1d0e:b0:39a:f126:9d86 with SMTP id
 e9e14a558f8ab-39d27963062mr82986245ab.0.1724117662736; Mon, 19 Aug 2024
 18:34:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com> <20240819-i3c_fix-v3-1-7d69f7b0a05e@nxp.com>
In-Reply-To: <20240819-i3c_fix-v3-1-7d69f7b0a05e@nxp.com>
From: Stanley Chu <stanley.chuys@gmail.com>
Date: Tue, 20 Aug 2024 09:34:11 +0800
Message-ID: <CAPwEoQOXme+GofEhpXaBBmsyGJP-QQtLMJG45PTdNsSqFn391w@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] i3c: master: Remove i3c_dev_disable_ibi_locked(olddev)
 on device hotjoin
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Parshuram Thombare <pthombar@cadence.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Boris Brezillon <bbrezillon@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Conor Culhane <conor.culhane@silvaco.com>, linux-i3c@lists.infradead.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 12:02=E2=80=AFAM Frank Li <Frank.Li@nxp.com> wrote:
>
> When a new device hotjoins, a new dynamic address is assigned.
> i3c_master_add_i3c_dev_locked() identifies that the device was previously
> attached to the bus and locates the olddev.
>
> i3c_master_add_i3c_dev_locked()
> {
>     ...
>     olddev =3D i3c_master_search_i3c_dev_duplicate(newdev);
>     ...
>     if (olddev) {
>         ...
>         i3c_dev_disable_ibi_locked(olddev);
>         ^^^^^^
>         The olddev should not receive any commands on the i3c bus as it
>         does not exist and has been assigned a new address. This will
>         result in NACK or timeout. So remove it.
>     }
> }
>
> Fixes: 317bacf960a4 ("i3c: master: add enable(disable) hot join in sys en=
try")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/i3c/master.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 7028f03c2c42e..852b32178b722 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2039,10 +2039,8 @@ int i3c_master_add_i3c_dev_locked(struct i3c_maste=
r_controller *master,
>                         ibireq.max_payload_len =3D olddev->ibi->max_paylo=
ad_len;
>                         ibireq.num_slots =3D olddev->ibi->num_slots;
>
> -                       if (olddev->ibi->enabled) {
> +                       if (olddev->ibi->enabled)
>                                 enable_ibi =3D true;
> -                               i3c_dev_disable_ibi_locked(olddev);
> -                       }
>
>                         i3c_dev_free_ibi_locked(olddev);

i3c_dev_free_ibi_locked will still encounter WARN_ON(dev->ibi->enabled).

Thanks,
Stanley

>                 }
>
> --
> 2.34.1
>
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

