Return-Path: <linux-kernel+bounces-211293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECAB904F93
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3611C2261A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B1C16E875;
	Wed, 12 Jun 2024 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NqCaQPRl"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C53D16E868
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185624; cv=none; b=VlOdABmjlmP/IWFwa4NyV7ZhqlAQaIIwCuSbMVnzhQofHtPQK0PQjceVrJwahb30qS79V/mXScOrZiPp8U90hkgFwjnlmNODukpGJSP1Cen+ZsVhuYZ/Ztt30s679HL4edG0tTBlCFnhutUJ/mm/pyhXg49Cl60JlupFQcyyYGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185624; c=relaxed/simple;
	bh=zQKdgF8mcEp+wVi7lqvaVDwpdEckLhnlchOC12xC+RA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TV4P0amtMSJ+rxeA4XmTjPbEgs8aZex0O6Etu2mTcGxdnccYkTF3qFLTAOPVcW2EkRkgI6z6fQSjC1eUc0Wv+O5Y3dmCLv7l5JjQtLbTPxdI0o8szVpmBn5yqhEPKczpYw1zjNJlw0wEgFj7gGKu+oJrHtFsp9WphDpPossmyHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NqCaQPRl; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52c9034860dso3316211e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 02:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718185621; x=1718790421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQKdgF8mcEp+wVi7lqvaVDwpdEckLhnlchOC12xC+RA=;
        b=NqCaQPRlTRnZ5AqJpRZYeLGeRA00pmfFw6V7DlOqQ8WqAeyOOAMnVc1OnRdnQUszEi
         om+vkFuWK55xI7UGVC5Zhy1DK+RyJgrVPq/VU5zYB3AUQbH72GQPU+vDBiUAxqA7a9AY
         JcLby1i/X5OSb6AKFLYXEk8UHflvIVEOGEXzqsrKpxc+viIPQEMt4Tf8qB+bUCFaQ1Gp
         mgeIKlh7RQ6nWyEWatcaFiGEnJpTaLlWadLTi1vg6T0AKrwE4Ym8AV2De8vLADQ0YrYY
         tZCf1eA4fDR9jkYx72fALjhAUjU22dZI48vnbRC8rkpjJ2iws8MKViFWZjNutZ1TfSjS
         Ff1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718185621; x=1718790421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQKdgF8mcEp+wVi7lqvaVDwpdEckLhnlchOC12xC+RA=;
        b=hVIOLZrFjrDYWHr0RDDlNDMwHvcVGSHqHP2eOdO3eGCW7eHSgAOUrDk/oeXkp94ay0
         sSeyWHOMH/+aQJbhjX1CUXFaDzvH5HXNHU5+T66lipzvjd0+/tPqoomCznmyiJhVLy3h
         1C1kH8uFZGSFwvpY6m942j4QYeVVVOxu84/yGmg6XdTx0gry313aZWO76SGD+n/DtkPz
         tUE4sZ338Hv7ShIs31HDsjjD1BFYVE3msuKn2+FmwJSC3mvtPuQPtqCH/75PoLp4wYpk
         NA1yUBxsB2beF2UTo3lKQ249ULBw2Swv51uQz7nvZ6DPgbsmkTR5zNJEboz8XDQBOrtr
         PAqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU58zSIIqLek6o7IMqr+cwqLE81uQMaGsvR2rQLkVZKc1xBBrPXLqx7FM8aV6jflcO/C8flkyzNUdUUFsDu6cH0bxvmELbMbE/fod0C
X-Gm-Message-State: AOJu0YzyZvFuGBSfwFjbDm+/VeZC1v45FqYuAM+gRJJufaJAP1xxVvEa
	OK+e1TLgVH0yYXoLtw4jZlcTDDDDvOM1OLCOsOF3zB3uZw21YiudzAwPHy3cn2e4R40VaXZuzuI
	mn5Xz+V95eO9a5Ab1gBew5cISmevtC9X7ieub6g==
X-Google-Smtp-Source: AGHT+IGCNkHASnW9VHX/JSYWKJzZNEu3Qmg4CK2c1hPkFlnh/pbup3cTnpgiY+Of0KiWJ4QoVJYCQXU1sRI9qEXlsX4=
X-Received: by 2002:a19:e00a:0:b0:52c:8811:42f7 with SMTP id
 2adb3069b0e04-52c9a3d2020mr998967e87.19.1718185620774; Wed, 12 Jun 2024
 02:47:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530165424.3173673-1-Frank.Li@nxp.com>
In-Reply-To: <20240530165424.3173673-1-Frank.Li@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Jun 2024 11:46:49 +0200
Message-ID: <CACRpkdYbZAMjgLQPo9Xw_ooqpohwGKG3S1qMV0sKsDAYh3Pv+A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: gpio: mpc8xxx: Convert to yaml format
To: Frank Li <Frank.Li@nxp.com>
Cc: robh@kernel.org, brgl@bgdev.pl, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, krzk+dt@kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 6:54=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:

> Convert binding doc from txt to yaml.
>
> Remove redundated "gpio1: gpio@2300000" example.
> Add gpio-controller at example "gpio@1100".
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

