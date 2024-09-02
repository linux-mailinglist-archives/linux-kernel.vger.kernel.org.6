Return-Path: <linux-kernel+bounces-311336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A969687A9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5720F28382A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F54819C569;
	Mon,  2 Sep 2024 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YU5NwkdK"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048BE19C54E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280765; cv=none; b=tHHFxT8RidwGU/iLqElG0rMPyOVR4BA/RNyi10eTl/rRPUBuW17IqBIpW6NXvJsV95AFqwGnyysJSwSsIvU/J5OMEJE99loz0tSt1xzxVWb+K0mF9WZWvidGybvKs98AVqkQCm6zU74bU1k3ziFid8fD4p+oUWY4Yv7sOTfBFw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280765; c=relaxed/simple;
	bh=CaY7UHB4Cavc4mqMEywTAthZAqJc1/sEmZ2JH5qknFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pn8WgUrEpyyjwcOun1HxSzyIQ6B7twAtvNcbeL8xHj+vCuTJtdorwt5f8YCsRToIuNnqHtQPtaaXF2JGNCf8ePbeWWNzUWCOfEwoULFJv1rWVMfaZX890qFqJm6LmjqOY4RW4wePRNbQC4Z5O569b96hOahSHSHajeonjgO/AnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YU5NwkdK; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53345604960so4665030e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725280762; x=1725885562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaY7UHB4Cavc4mqMEywTAthZAqJc1/sEmZ2JH5qknFo=;
        b=YU5NwkdKdxc825nRu3XKqrpavnrKfLSDKuPyqoBtJpnU6t2XPvZs+P1ugn7pZnPdBL
         XJV+rlmoJgPapRzVUwuuxDU7lNQOYMAKuRRf2U1hCYQj0zH3Cfpcn3WsqyRXUTyzdpti
         vMqUL4JTbge2IOQuwZgECYSt7e1NORGrQu/1l8WKxLSWulgWeem9t4Dh3cqS7towFWnQ
         zOKLE5yf6NneawpAOTAL/NDfFqIpOO3Cd40W28jId9HFySWAqBP6uH2sEs+zGM6FffLO
         8MWT3QKU4NM2TaH1KGSpvFO7hjIqyyt3ATVaBI00TrtvbgGkvLH78bMtKpF1MiN1ECHx
         0PhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725280762; x=1725885562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaY7UHB4Cavc4mqMEywTAthZAqJc1/sEmZ2JH5qknFo=;
        b=NwqD2D/hho8PlbWep9pqhscRRYPcQqi4aNOddKdUuph4B6rLGKNyIsM5Wt4R0HEADG
         c4s6Pzs3eywiGb2R9WXmKtYK2Wuit8xtzVwr9RN8WGaeFqI2NxMSTLy9tLbafGhDjHZg
         injp+99oY8CTxUmauEDvVGikMF60MAU/TBFKFYH5hZi7PUu/Bpi1sW2afHlGY39NtEE1
         EOy6Dksj1h6cWAantooGaqesGU1jlQSNv56rArWHJ7gZsLnmJa69ZVhkYicMSogF8doV
         wpz4odmm9Wxzm4fNO1jZ+mTeTFK0BrWrxTxtYeN8QudGMV5dOH8AwgL7Vgx/hWMBwmNp
         axAA==
X-Forwarded-Encrypted: i=1; AJvYcCUtvdxpIVwBfzoe0cR7sYSG4LrHGAQ8nmqS40ry2Zw/f1ewErid5143uv0MiOvL9sqbWzHPvW4QRln+v68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWB8JuyHWg0NpdjWkXOWzTNBQ0M6zq2JWl5SdP0Wz9IiSvzfMu
	IsxlRBoPN89E4LwMVE3/mRqHEpfmxBmWrf4guXed1FaO8KuqHNPbMUyFb7YEetyNpEyyJJfuOTT
	Rbt0pQY+GTvydBf9II0oI4CMtziDggXKZDC40hQ==
X-Google-Smtp-Source: AGHT+IHPGAquvt6NrXMvKDP+0Bo8xxFeYiZ8iZqjJ/iDxU17TxwK/wUM0CTUKYZm8BBQv1/cZmm4LgYLP+zevIkbRH0=
X-Received: by 2002:a05:6512:15a0:b0:530:ac0a:15e8 with SMTP id
 2adb3069b0e04-53546af3fb5mr6665465e87.11.1725280761445; Mon, 02 Sep 2024
 05:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902113320.903147-1-liaochen4@huawei.com> <20240902113320.903147-4-liaochen4@huawei.com>
In-Reply-To: <20240902113320.903147-4-liaochen4@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 2 Sep 2024 14:39:09 +0200
Message-ID: <CACRpkdY_jF-qeayDefTh1pzE3Yjxbkmrnx9nCxDm+V4tsrdatg@mail.gmail.com>
Subject: Re: [PATCH -next 3/3] drm/mcde: Enable module autoloading
To: Liao Chen <liaochen4@huawei.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, thierry.reding@gmail.com, 
	mperttunen@nvidia.com, jonathanh@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 1:41=E2=80=AFPM Liao Chen <liaochen4@huawei.com> wro=
te:

> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
> on the alias from of_device_id table.
>
> Signed-off-by: Liao Chen <liaochen4@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

