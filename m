Return-Path: <linux-kernel+bounces-349124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0172E98F153
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE42281ADA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB47B19D8A9;
	Thu,  3 Oct 2024 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DY67YH40"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EDB13D245
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965397; cv=none; b=ueyOB9SLdYJuuZfBWGaI0N9vL9ngUx3LsO8zr/NVRjHWFiAc9UQzuOwUQurgEU6C/QnOh6uNXdCQMfCXzCY1ussKhN2YbDryy9fsDzQNhMSQU4SDEGvzmDvVLxVu/Yve7UwcJYzxj8OguIxyUGDBMDLvB+B6WGFqSviED4AhQIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965397; c=relaxed/simple;
	bh=dAjex3br5LGI/C7OLyif4ht2N7fpXhcmDxX+rYqm3rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUOTp/dvdnCRqPxth4ASwUrqCEdGC91T0iBrr/osarwtuINulJpzefaux6XrJTtjrg+uOxJnZnhur0WoomVb6RU95COnfBsVZ4Of8cVZ+cbPe+XiGxskl/3pEgWRDyK12g9gOgOLaqOp7RejfYsxzMQhGYQbGk3RuK6VAJemEQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DY67YH40; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fadc95ccfcso12474241fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 07:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727965394; x=1728570194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAjex3br5LGI/C7OLyif4ht2N7fpXhcmDxX+rYqm3rM=;
        b=DY67YH40ZFe6+Gjk3l1Zmhx7aKwdRpBZuMuPrEmjlUv3S7LUTKstmkE1bVe4vOkrO4
         3sPtz5DCgNVEdmajVVwFSZ8J3yVhfvAOjW0aJKISNX7Ycll61516pvZsqflIQreQp3PJ
         KtksBBDMZFzizGCLccUPlbxu1gp1MK1McHwuw43DN4wP1rwDf2rUebRHjYhvHUK8HsRD
         yZyxBgLcXs7n5EhG7PZtzpbtESdHM3p7wjLisjQXzy9hIwELnlme98EDihg/4dUZRlQB
         g5PziTzuQw0wZxfVyvmnG55CjJjKXhTekxJXMWLIg82C1mQ5iJtw8UuWJ+9a0GdWZFPA
         eo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727965394; x=1728570194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAjex3br5LGI/C7OLyif4ht2N7fpXhcmDxX+rYqm3rM=;
        b=XEwKkzEz82mkR7H1sfuCBdWUjvI5WjwB6Y94S75UHNt536FG6Mpw/imm0JGPfbvSA5
         tQBPTlOWzT1hD7FFV1Dsc7pkGP4jla+XcZhQk05sARFMdf22i5EywAdhACoBFpUBh+Lw
         OsJBkjXVFRyfcaqY+kxNomCHRrIU5o42Fe0l2uO9NKGU2M7etybG+rzIwNsg8UnMmFUf
         sPfDYSRC8GUHpbEZpksZY2BAxSTKmGpY32/UupTc+TLYSrcXXHd3i9kyJlHKywKb+IsD
         ytS4sELJMmJRAKkDazSr05f14frCuqwu5L3v/0RFFQZ74K6GrQiK2THUZeErdK7PjpMb
         WGHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUih+KMizWFZw3m0O0j+QVGbc51y90RnPoQ9QLWGzgRoyKkGhbCbAw78K3lqV/3fehzR6FyYo8dPgN7rpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSgmeLdMTYlP8KgKK1Fh3cCipOLyGQWURQYd9Ph2GKhXxqRdvU
	8G7vP7Nib0Q8E2e9QLiTw9yGAh1D0FLEX5KxDslGQkBHpWfEmd8EfEqEnOrte8nuU3JdR+zW6Uo
	pvv1uzVUZja//fkI7iPsTAdDVVoA47fo2gs+Twg==
X-Google-Smtp-Source: AGHT+IFdip7cwgk4spxBoXMqdcyn6mIZ+Y2LKQntlDxnri37/Ai9RYCDnI6+mmKZGbfnvUn0T4S00ZAMRU8P+OFkQS0=
X-Received: by 2002:a2e:be04:0:b0:2fa:e658:27b4 with SMTP id
 38308e7fff4ca-2fae6586dfamr37063361fa.4.1727965393557; Thu, 03 Oct 2024
 07:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003-imx-pinctrl-compile-test-fix-v1-1-145ca1948cc3@geanix.com>
In-Reply-To: <20241003-imx-pinctrl-compile-test-fix-v1-1-145ca1948cc3@geanix.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 3 Oct 2024 16:23:02 +0200
Message-ID: <CACRpkdbaLzV=7mD5i1PS3Bu5Znc2nV8j06pYSB40k9dWSyBapQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: freescale: fix COMPILE_TEST error with PINCTRL_IMX_SCU
To: Esben Haabendal <esben@geanix.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-gpio@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 11:23=E2=80=AFAM Esben Haabendal <esben@geanix.com> =
wrote:

> When PINCTRL_IMX_SCU was selected by PINCTRL_IMX8DXL or PINCTRL_IMX8QM
> combined with COMPILE_TEST on a non-arm platforms, the IMX_SCU
> dependency could not be enabled.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410031439.GyTSa0kX-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202410030852.q0Hukplf-lkp@i=
ntel.com/
> Signed-off-by: Esben Haabendal <esben@geanix.com>

Patch applied!

Let's see how much more the robots find! :D

Yours,
Linus Walleij

