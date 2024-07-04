Return-Path: <linux-kernel+bounces-240398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BFD926D36
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0153DB223CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D3F101DB;
	Thu,  4 Jul 2024 01:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RfB46auM"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33105DF53
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 01:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720057729; cv=none; b=OJQOQBuxT3x2h1mqHPUW79A7mGr3BINpQwdgiIMJ7nnWksL944eFwHSOYpky4ypO6bnld8UfVH/GWbGLY8PRi6NUJkIE1CtJXBIhsV/B0IaIKEtC4uCz9JvQt7jv4R2aubJFv0zrIuvIWtmTeqJpgmRgmZhCtRDpEwt8rhtjB00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720057729; c=relaxed/simple;
	bh=G59GNkOWbkHEYhhvdW7B0tM3W2apbni9xrSBJTuFhGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LiqFUrSj5W7xa3px7LzPa24d4HVALwf/echD80rWRBtH8REmBrYSnywi3Y1AyhTDAaKwgxwhS606trEob8pwbBzQw78Pep9OiWR3tzYwhbjoJ6mDheM7ueWiFr3ukXv1WPbk7di9VvRbLobHyyPetUezAxDi0ToeAG7tieosF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RfB46auM; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec50a5e230so972691fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 18:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720057726; x=1720662526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G59GNkOWbkHEYhhvdW7B0tM3W2apbni9xrSBJTuFhGU=;
        b=RfB46auMDNQYWZr9TsXHtHvSbBRXjKxOpqRbArw++Up6/IY/u9HK7HOdPHKf5XGH8x
         33ws4gYeRKeTu/WqT3EmIHwnpBzRcRcdx37soRnu/3aOrq9YhtyTWfVKYXQdAjM/85MS
         bfDztLxAgnlau8LuvXmjexaFu+J0FAH0FVZXfZFtE6e5AdWysuXQ9aV15s+HvvA0FrsD
         AW7hXyWcUrHJWRde0PmOxpJfhiliO0pXI4pDucsEVtzNK568iBj9GNtL/5kDDXpWVNNh
         xB7mGcQMocr85Mzlg40Czj0R8L9p2zxhjTABP2GbGPo3WIVzAf1/onr/jIGLYkNf4SkP
         zQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720057726; x=1720662526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G59GNkOWbkHEYhhvdW7B0tM3W2apbni9xrSBJTuFhGU=;
        b=SyIwYEuzhdKGlOaj7NnJA2Pd7udVeU8SPScDXd4fNsc+nMO8v4BxyPTE/1G6npc1AO
         6iBOrO0uewAJXLz1WVj/K3syzVZIpbVfv4u5AAQUdCI5kAKepl/bvmT0LgXSBnH41Uwb
         16p1A+uTlOk3sDpRqFz9CG5I3w6T7dHyxdivm3SDOOrFUN0zvsD8FQ+O6j9MZX0LpOE/
         trh7VA5U/u1s1Y9RVmtq//Wxu/JxawHzl3Mg698FOAaSKOYLktEsAWOpFwhgd8qDK1J/
         TcJTv+0FMDSu2KZAtdr6Kj24pc+od8hTH/HbK+RPiWwGe0VEt7v1woaGIzdMtC+k72hh
         fzmg==
X-Forwarded-Encrypted: i=1; AJvYcCXvm+PbIN/Bihi+MrAjLBZ31RqggGDLeH+2vzpZmYuuUMryjK9av8NRRydhMe/a9zMpv16GeNMQjeZZmkyomdf+OEOubXjtbBhinnT1
X-Gm-Message-State: AOJu0YwHF1JHemDrlwgHDH3fZ6IKPf8i72MxwvdyR2GnKTyX9FRJnat4
	329rVZbVkSI8AFlk3zjxgDgeMeV9ecaDKkF8Q77a25d0vefdBD+xXI9A37cuTaLtA7qFAu2pMts
	Z0uhI48E+xdeeRFdymMaVfb+p2GuTMc/EuxD1tA==
X-Google-Smtp-Source: AGHT+IHfLv4s+vQIweVjQ7Xr1GgMPxbR9W9NSDAeDl6zTwN0+s3wCrlLDx11lSg6hn3Q5ddlFYVlYAEAVqfoxvcoJwg=
X-Received: by 2002:a19:ca43:0:b0:52c:e1d4:8ecd with SMTP id
 2adb3069b0e04-52ea061309bmr84261e87.8.1720057726255; Wed, 03 Jul 2024
 18:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703215905.2031038-1-robh@kernel.org>
In-Reply-To: <20240703215905.2031038-1-robh@kernel.org>
From: Shawn Guo <shawn.guo@linaro.org>
Date: Thu, 4 Jul 2024 09:48:34 +0800
Message-ID: <CAAQ0ZWQ4ua6aN15Wr+gJF7GkgNgzA-OunUhSMyeecZEJZq7DtA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: phy: hisilicon,hi3798cv200-combphy: Convert
 to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jianguo Sun <sunjianguo1@huawei.com>, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 5:59=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
> Convert the hisilicon,hi3798cv200-combphy binding to DT schema format.
>
> Drop the example as arm/hisilicon/controller/hi3798cv200-perictrl.yaml
> already contains an example of this binding.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

