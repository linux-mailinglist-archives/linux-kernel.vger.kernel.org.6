Return-Path: <linux-kernel+bounces-250552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CD692F8F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4981C22F08
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F7815ADA7;
	Fri, 12 Jul 2024 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tTIjKRqR"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B830915A851
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779874; cv=none; b=l/FhwEMTo74Lur8oBDEZS85GsOaAPEddMoR7fM4Rct+1rJr5Pj0maDL/y1sxtpd+7lJN4Hma0PW7WZQT7QqvJdB+54m9V4hpEWDmUdfFeLH8nzvUgnbaCCbpd/q4ieqZkOKZ2QH6NQGIf0apM5MT2GFJ+wJTTmi3xxS6ffiC4mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779874; c=relaxed/simple;
	bh=HqZiCRw2NLU2XKAhHPCRc0/GWvY5VzMIPC+2HkzIaLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+7Qo7/d45g/MVBA49ddWTXlVD6TKL1jN3YJFDNTU3Nowuf7+koq0SGcPAF6A1DCI4+cNc2L1kCmAL6NHFtF8NCqoBPS7EX23ZBfz3QYIIj+aqcbMTEFVgzv5RrwXw2yRrbhvFWy8Os3QvkTLXw9ZZfN1vcVqIhlsvGl/az6cQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tTIjKRqR; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso2041648276.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720779871; x=1721384671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+VRQCbcpx9R3q3II2rgwsC0Uz/Ighdl9GbELSByS5y8=;
        b=tTIjKRqR+vuz1dMdeuIWiVQmIYtXiFlOITDNGelgfxc57jadda35UWTgJ0Q9HsCapn
         crqsZOb4kxmTcin/grA4t4tXoHQfpEzCEiZ95ksSQx6+Ux9UIn7r2vYdA9b9esCACKie
         Zmfrc9MdIQRXbiVfb59a1ZpYN3gIlbpMk/Ei7R95IrSGJ08ZfKUvLHWWqmhd2B7TsW5K
         hvhaat62XpC/XqxocSgQFIGEu7H+iBlSplrf+a1vAhCvLA07biZ4RVDl8wgHRCMKDQAN
         DHPMreqKx2YrB1LejNFwUGq6RPIf82OPzHKlaaUUIewW6zdj95YAK1aj2jY+kfUyin5Q
         sS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779871; x=1721384671;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VRQCbcpx9R3q3II2rgwsC0Uz/Ighdl9GbELSByS5y8=;
        b=mvjp/d1hoXZ91L9Yoc6g2PG6qKemM8FbVAl8a0rkUPOx4LIrMnBOQg6BiCg/QQugt5
         0JMoSdydJifAPmpnfWgmAQ+1phpmevsoQt2MYF/SWNoqDb+op7SBpPJeees4Bb+0PMJY
         Pl1m6iz4O7GsK11tpEeAZPDcy/PA8Id2sQI6ZIz8T1a2WUaH6d7EmN1qr6j3dLzXoHj3
         HEYLZAKsGuPBWb+6T377/L8KkSXVEZHfvdp46PraapnFFUQwoGd/fS8yoABqxy2zC/WB
         kK4gUMI2UllqwxILh+SL5MHihBWo+C+PefcHmbXAWNhR3Ka8A7zKxSKcdi+TlkOaly1H
         xDFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6drf0bpI73qZmjVbuMt89or6QSheSYEyAAt0BfXThehA+ntiytys8mQcQsCSiItnpJ0yy06FGS9vUwzF62AFR7VKYcuw1P0lrz3L+
X-Gm-Message-State: AOJu0YyvD9hJaBQlcqaHXdCJrpCMv9AVwErujwD+iNHaLZDKmMmCA1Pr
	vuml7mD1O7WEcFnM7/uJELWWZHzSPpXY9Wgst6arU0U5i7ha3y5CfHc+u599ladaSvfJ0j1m1ez
	dTvNQgqi89tQllXDqpubdoSs/2QJvCPUE9P6MTsFr5mhxRJKN
X-Google-Smtp-Source: AGHT+IG2u7oPYblciDyGiNZd4/9k+U/KQ8en3SG5yXyygHZBORuC+P7l6UYsZj1IX1HbtiJTKp1OpY8918TJtuYQ6jg=
X-Received: by 2002:a25:ef09:0:b0:e03:a688:ab5e with SMTP id
 3f1490d57ef6-e041b0785b8mr12312862276.27.1720779871043; Fri, 12 Jul 2024
 03:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <80e17dffa8f4c1d3fdedd4d82df3a722aa4044ff.1720707932.git.geert+renesas@glider.be>
 <0e4c9ffdc8a5caffcda2afb8d5480900f7adebf6.1720707932.git.geert+renesas@glider.be>
In-Reply-To: <0e4c9ffdc8a5caffcda2afb8d5480900f7adebf6.1720707932.git.geert+renesas@glider.be>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 12 Jul 2024 13:24:19 +0300
Message-ID: <CAA8EJprLg8-BQT2OsLb5xSNVdFLf2mF6sSw_gAie0dBXawQFqQ@mail.gmail.com>
Subject: Re: [PATCH] platform: arm64: EC_LENOVO_YOGA_C630 should depend on ARCH_QCOM
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 17:32, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The Lenovo Yoga C630 Embedded Controller is only present on the Qualcomm
> Snapdragon-based Lenovo Yoga C630 laptop.  Hence add a dependency on
> ARCH_QCOM, to prevent asking the user about this driver when configuring
> a kernel without Qualcomm SoC support.
>
> Fixes: 5e5f2f92cccc29f3 ("platform: arm64: add Lenovo Yoga C630 WOS EC driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/platform/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Could you please add the same condition to the Acer Aspire 1 entry?

>
> diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kconfig
> index 058a4baa216a83b8..f7539e5419cf1616 100644
> --- a/drivers/platform/arm64/Kconfig
> +++ b/drivers/platform/arm64/Kconfig
> @@ -35,6 +35,7 @@ config EC_ACER_ASPIRE1
>
>  config EC_LENOVO_YOGA_C630
>         tristate "Lenovo Yoga C630 Embedded Controller driver"
> +       depends on ARCH_QCOM || COMPILE_TEST
>         depends on I2C
>         select AUXILIARY_BUS
>         help
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

