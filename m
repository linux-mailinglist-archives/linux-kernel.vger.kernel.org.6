Return-Path: <linux-kernel+bounces-424566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A28C29DB5FD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55AB61611A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A28192D95;
	Thu, 28 Nov 2024 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMkBem3L"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662E9187862
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732790993; cv=none; b=br5xhBrtcCeOWCagnx4MB6lbShKbhrO1yYbvcn9VOMgJe3nR1gvceQ5+8XSpwwxy76/yo/tL6R++XUJc09m9rIkezb2uC/zB7MGDMj6O+NGiYsZdFVl4AEY9UEoGr2YiWErS8+59aaM32cVBbQnTDg/O5aM3U4h0rBz6SG1WARw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732790993; c=relaxed/simple;
	bh=S+6oOaM0s6Tu6ZxZFSf1VxM7YfIeZpwsBu0bRCHSjm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8oINAlNF3LJm2qoDITvFPPXtK8BOfnJSl7AnWEwhcvXTYUXHmYBOqPu1mr4fjrNETn+27GjXeuiqfCfFFJUWoeVUx4X2PWAPGFRTzR1eG5u2lDb39QgQPF1egWdBzZoyOOcQO7ZBASLFvn8mLNFVE0uEES7U98ZQiPNnzbUNEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EMkBem3L; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-296539a58b4so439422fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732790991; x=1733395791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+6oOaM0s6Tu6ZxZFSf1VxM7YfIeZpwsBu0bRCHSjm4=;
        b=EMkBem3L6R0fo+5kuXSurd2vWNU1w+wY/pQ3KTyRC0sZFTY76LPLkMOsNvpw+aUPXx
         4fwNg0Zg6vHfjXXluu9ChGYJKlt3nc7P/m+GaKthL3Qw25SyzQC26MHqYJZYq/6lFTs+
         rpYzqo6Yt25Yg6xYJ02qcxCO6ypxE78Ff34efkqpTwFZ+ildJcDMGh0HUp2S/aOdr5gb
         k10l+KhNiPjWTACWY14TpIvejNNZj1pxugwVxlIezhH8uwYA6XlmV64cSm9L2gz09WJ+
         B1ijILoIOPg3OKLrdvoGXpSKmsqlf0PFxkBT9J3RAiFwJ2teAcV37S/erZVp+AAzCzYv
         UOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732790991; x=1733395791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+6oOaM0s6Tu6ZxZFSf1VxM7YfIeZpwsBu0bRCHSjm4=;
        b=CUjCqXRNa4jW7z3WMMMHPMxnA7GRYdt4xlUUaph9erqYwGbE5I/ikZ4Cg7tA1tO1bd
         j7QUpx6Nmi/ALPYV9mNL1KN8V/Pv/e6WKv85xsDGJl//gYaQ24HwMm8n42fplx1eJPc5
         o/laKzAoVQNva/ENvQMdskgdI9GMSvDlHlAoJ5TWT8tT52mK1Z0JPv50D+Ltwv25dVaG
         U9/nNxLGqfkxSLCquFoUYnp1CsG2vxeK96Xk7J5C3XD2sO44uCeewVnHiilMzTmbno5M
         ByUO9NXGmGngVTtgS3NdEf+RnNaP0gfM9QsB3pkOVz+mVLw6XwiAdyWpV+YBSazeAyX6
         P4TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqKTpedyEFKvx7BURKxsE7ZwIIyKkmkiIM31LbW99PXxpNLRWKeTeQtt7rxCN23Ai7y4iYEm69qgs0AEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZHyR3DV6jssWGCuudWdJlY4rZlP00m7sezZPRKGOk15D3fef2
	dbWdWTmjRyQDbGEEaYgU3Ur/iMwDeSQrY/oBnetux7JbGmG+Y8mkKHj5oPe54plJhHG9taV+8Dx
	1Tcg670QRB1L9jQFd6nQrBx0WwtpILMryBHZDTQ==
X-Gm-Gg: ASbGncvX6aYAsrZqwIU+quDcxKhW9X7gBRI5/TM5vxbSDv7I+BknTNGFByhIQj1Fb8s
	iinQoYLAQD0HeRnBJWtXrTr2wvDqgotD2
X-Google-Smtp-Source: AGHT+IHSW4AauQXzPQcYvXTGYQGOqaCzi/aJx5YRC8Z2JJs3/8I5KClVLNxBsZmq2QaZI74lTF4hFwtZQD27MqcFr60=
X-Received: by 2002:a05:6871:e7c4:b0:29d:c8fd:cccd with SMTP id
 586e51a60fabf-29dc8fdf378mr5912643fac.2.1732790990078; Thu, 28 Nov 2024
 02:49:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-gs101-phy-lanes-orientation-dts-v1-0-5222d8508b71@linaro.org>
 <20241127-gs101-phy-lanes-orientation-dts-v1-1-5222d8508b71@linaro.org>
In-Reply-To: <20241127-gs101-phy-lanes-orientation-dts-v1-1-5222d8508b71@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 28 Nov 2024 10:49:38 +0000
Message-ID: <CADrjBPq3vJmHh9bnS0u=d_aTeaRH8Z00JqgBfkqjQQ_Fv14xxw@mail.gmail.com>
Subject: Re: [PATCH 1/6] arm64: defconfig: enable Maxim TCPCI driver
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jagan Sridharan <badhri@google.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
	Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Wed, 27 Nov 2024 at 11:01, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> Enable the Maxim max33359 as this is used by the gs101-oriole (Google
> Pixel 6) board.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

regards,

Peter

