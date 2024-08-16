Return-Path: <linux-kernel+bounces-289428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B85695461E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C241F22EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4104685C5E;
	Fri, 16 Aug 2024 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="A3QExZz8"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1FB142E60
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723801734; cv=none; b=FoojfxsZKzPe1vKL6RXIUu3C4xaiTJ94yDnLd6TdTEhE8Y1KgeW97DMTmE0L2PKrPtdo+caym9PbOS+Wy///VT5ESFqCnAzaR1HZg5JN5Ipz+8pU0XA3AEEVWS6Bbatzzedn//0ecr6kcSwa7AuC7bX4+HLHjIeSziUEUaDYxSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723801734; c=relaxed/simple;
	bh=YgticG9dxHj5aMeMFYXDjN5eoKKd0nnxiMOkIVpF/ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpGM64Svs0/zbiirkpvYiab3el89JkhTTNip734atOvbemZKa4/UD9Zga6n5xYTBN/ryraubrHgNHQcSZeP3ypyUQqslcDTzDF5MMF1d6nBrqI/vORElxDq0PTmcIR2jWvo5/9oVQcK95+4grkFAMv/bwJB0/pmMqenlVSnhB7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=A3QExZz8; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52f01afa11cso2280672e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723801731; x=1724406531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgticG9dxHj5aMeMFYXDjN5eoKKd0nnxiMOkIVpF/ZA=;
        b=A3QExZz8gQbxqpXVdT1qh678ZPFPsa7BLiyXU5pzKZ8g6IdmVQoTR8VJYoYuhPE0e7
         aDoc0pX6HuqXbNOscDbDXTz67Wn288m6dYzEMU7PvStuYh5bqYlgTFfYnEcClW6XTRc0
         NDgN+viehjG9vqssX3x0AF2kNusNkEmB7K3JLI4aQEsRwNozIprvKTbuwwVrvXmGgASJ
         /4NTpRtzDQa3uc+LwIajS2K3rTDrGVgqSmIkJ+H6yPabJEN7hWcIV1znDi2oZKtqcyxI
         55saH4ZXkoVHvV7Uqe/5wc13xJPJFThCQE+sAXSlDhTL78ig7gkAYCZRr7YgTNKGXOrQ
         GUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723801731; x=1724406531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgticG9dxHj5aMeMFYXDjN5eoKKd0nnxiMOkIVpF/ZA=;
        b=iVMeW01SHXviBJySx9JI5/M+WbVrgZoqBAzvJwiReMLCjKaEJ9Eoe2p+YqMXVA7K6e
         lvazQ2RAjgDB/NQybH/2WAvljggfv9BH3KeEJG2KNGJ23CCA3Vk6KKPvdigbbPaFiTS0
         3fHioAYxOgUTl/+7qLIw/WxRZuLvpzkXyhKLnpBL2Dkz5DNWl2FnJThvaQRjI5/Zfa7i
         YZQ/dAapPMZOf7G2vCJeBCGJo/0LtWL7SD8UPqr6MAFj9aVMIBlBlnruIRJHrZJlfo6J
         VDCMJHfH2Hn4Q/6Z1j9Q+6VJu/Ite1mnFTRqbw/XVocIJ7xFD0L3i+s8kSKscjhD6h+O
         m/ag==
X-Forwarded-Encrypted: i=1; AJvYcCVJwplDLjg1AVNWSfIr7Gd/TiWqAvbZhlGJOJS8QO8BbBPtHC7Rgt5snRRIUmECiTIVI1UsYDxl9Q7hpfK67zBzERFUyy5iu8QW38Hn
X-Gm-Message-State: AOJu0YykVUXV2aR73QE3mXHCOW2kwFLfwuWtvDiBCFSeYV88w+OwOu+L
	PeCYPHMR4kla85AFJ2eHlhofyXvk7HubT1hSFSGlcr+4Fb+EYC5+KwNP5jeScFOSYWJylMb+57V
	rXyjt9d2CLxMYMq7/cfySE9kbM1Kq//b2nzS5tQ==
X-Google-Smtp-Source: AGHT+IFij/jJsP/niqDckTb0DeGvPRhcCSmaDzREmmynoAVx9zNL/PyJ/e5FT5YitoKM5rpx+usdhEOKsfU75w8yY/w=
X-Received: by 2002:a05:6512:1111:b0:52c:e01f:3665 with SMTP id
 2adb3069b0e04-5331c6b01aamr1377360e87.25.1723801730065; Fri, 16 Aug 2024
 02:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815071651.3645949-1-ye.zhang@rock-chips.com> <20240815071651.3645949-2-ye.zhang@rock-chips.com>
In-Reply-To: <20240815071651.3645949-2-ye.zhang@rock-chips.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 16 Aug 2024 11:48:38 +0200
Message-ID: <CAMRc=MfFJBTExgUah6tz8ceB-za=GcR6TxuXt0720ykBo8L8ww@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] gpio: rockchip: support acpi
To: Ye Zhang <ye.zhang@rock-chips.com>
Cc: linus.walleij@linaro.org, heiko@sntech.de, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, tao.huang@rock-chips.com, 
	finley.xiao@rock-chips.com, tim.chen@rock-chips.com, 
	elaine.zhang@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:17=E2=80=AFAM Ye Zhang <ye.zhang@rock-chips.com> =
wrote:
>
> 1. support ACPI
> 2. support 'clock-names' from dt nodes
> 3. driver works without pinctrl device

This is not how commit messages are written. Please take a look at
examples in kernel git history. Also: the three bullet points here
sound like they should be separate commits.

Bart

