Return-Path: <linux-kernel+bounces-300084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0D295DE8D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 16:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBBD1F2244D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 14:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5760F176AC1;
	Sat, 24 Aug 2024 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="biHFKvVJ"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D60BA94D
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724510837; cv=none; b=c+nEQe3FKOHqL1rnawZCyLrF9g/sQzLOtjEE3uK9/kZoDs9mFozeGc8HS/HTTAO5rGGnL9UvSVSngHxbdy/E+auRSV1EOLoVMjoG/CtQPnf0HWhoIPEB+xYVIXhB5zYY0uDu3pd4tALMpFRYaC4icDI5Detjw6fivJT6nVAJH/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724510837; c=relaxed/simple;
	bh=VxmePK1MR2lfFIOHVIYLSnRBuh/pse5SImux3VQ2L0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5F6cfKfTzNBEu47aywyrQZryeLAIneoLButncb+W85gcSYRL8GryNmFqXyYRfx78GVnSqBMI/k0puWMlfqAucT7xzMgAMgQpg54x0V67XIdxoxwTqc14feH1muF4wEkhF6i7U5y7t8AmTH/2JUl6QspSjg1iodbhg5JMhVfGiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=biHFKvVJ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-533461323cdso3326635e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 07:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724510833; x=1725115633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxmePK1MR2lfFIOHVIYLSnRBuh/pse5SImux3VQ2L0A=;
        b=biHFKvVJtKG5yIDMHAtzqg7rmfSJPEM81Rz/CI6Gbwqm4HplUVpCQZRBhqNeDfsAEd
         YyHmIpTomL3QIji+ESQhKWRXuX3/9RXlluNt7rZ2C4ufXRXp9FIYIs6OBLjA0wZwuUPZ
         pUC83y0VeIFj/6cEy0r8T4IZ8wNULV8sffKUo1BWt/xr2EwLgm+3XDEX/6+e2vMY1yo4
         MiM/vYlZ2oNCn/6JfSBrUdFSuvlLxRfz8pHiIYqQzbTCmgrY96lsGc/a2Y/bGpW39efr
         zaQ+rIyEWIMpLljFUHkmGNuaSQsvM/wkDAXVeTGVj4JVJQWLThmaYGxcvM4oeNgFReBU
         Yl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724510833; x=1725115633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxmePK1MR2lfFIOHVIYLSnRBuh/pse5SImux3VQ2L0A=;
        b=XFf6bOzga9zp3oDFduGlID5klh/FZPOyh4rkfT/a0kyU0JhHTxPBnW6rv8swZZ6gml
         Wd3rylO24+StDDJtaQuiwR20lFged8tBVC53CON3h2Hbm9Cl/Yj+b5vXIrPlojmywSG5
         8hjKACVUSo04mrJa2/XzibNczCAMs8LfQVBaqmtll7JnyZWY9TDed0Cs3Loq/FQOnXzs
         np7m95+rMBH3f+O6UjviP5gE2vtZwPmh0VScyEn7D/G4ldYFE12EcfMi/6Au97cDLx2n
         BQq0qrFFB2y1ujUjTYCGya9EP4LRMDbeBWrEKg/NDIQWPvOjPGApli/I2XS7K8nOoEda
         I0cw==
X-Forwarded-Encrypted: i=1; AJvYcCVxwV6nIIiToCSpMTME3dmT4fkHl7kA7sJQe9v+sdoLhgJyyhVcrIL1FcZEH079KloFPXCGVUSJOipSOtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz905x++i2ir5wh49r5UsTU9Cgv7nd0+YaxTN0DBYzV5q/rlTAR
	8/u0qNaaOph7Bj/HgWCyVms+82QCBYpp8swnhARi/+fn8WYdXDqjm6KMFSP+iH2o0dIrlHyP2FB
	f3fq3bARDkg4vr9zifkj1ERQGP7WvHD4Iw3AWYw==
X-Google-Smtp-Source: AGHT+IE2mHENN/zOrvG7aOdqBwUXQbceX1qjSYkYZP6RbiQu47UeCJukYn/GyAu31qdflvCTn3ooMOoDWrd6FY4SgaU=
X-Received: by 2002:a05:6512:108d:b0:533:415e:cd69 with SMTP id
 2adb3069b0e04-53438831ee6mr3220445e87.23.1724510832107; Sat, 24 Aug 2024
 07:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820122604.42736-1-liaochen4@huawei.com>
In-Reply-To: <20240820122604.42736-1-liaochen4@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 24 Aug 2024 16:47:01 +0200
Message-ID: <CACRpkdbN8yDLqVVCJQkMtOz0c99ykqDQwuh4gEE1TgF_Fw=fvQ@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: bcm2835: fix module autoloading
To: Liao Chen <liaochen4@huawei.com>
Cc: linux-gpio@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	rjui@broadcom.com, sbranden@broadcom.com, wahrenst@gmx.net, wens@csie.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 2:34=E2=80=AFPM Liao Chen <liaochen4@huawei.com> wr=
ote:

> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
>
> Signed-off-by: Liao Chen <liaochen4@huawei.com>

Patch applied.

Yours,
Linus Walleij

