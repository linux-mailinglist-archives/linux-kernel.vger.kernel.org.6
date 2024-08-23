Return-Path: <linux-kernel+bounces-298363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A339495C647
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61541C22E88
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE4513AA2A;
	Fri, 23 Aug 2024 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="XslyPLyx"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2126113D244
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396990; cv=none; b=gT3mgobArnsE0tGJ4QIfiYeXKE9FZKE9IBT5HrsgWuGAZhyD15SV5xOI+WsS8eHMqt9wVuvCzByJ1nT7/9KwjYfYgTgTQobo8Qn9NKIuamriEH64jT0syyIfhzS305dhhSRaTazo/ARklgkjW+w5rrGuOTWq/Gur6kFsg2LBzlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396990; c=relaxed/simple;
	bh=6/Y+PAcwqnv9X4Hn2IGNsHNmrjRh+Nqm3Kd7gOnya3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xw2rVy/oyetFdqUcztuMygSGmRNveAcbf7WJpnnMDsy4dX4PoNTrrEsJWKfh1xBTXYQkeWq+cP9ktwNHNZ0ygCWXdcMqcz4uDIEdgsveaSWq26Trwovou1W5wS8yvlWiBrELo+WWhH1mJL1QvxNDvvNvqy7SZF3T3Ymol2uovHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=XslyPLyx; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39d4a4e4931so5137815ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 00:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1724396988; x=1725001788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYiyuSQAwfiQQ39+HAQvaBlmRARXpxRgdyCqu4zVO9c=;
        b=XslyPLyx14NG0ioOukxMW9PD6r+BTCl8L4jjyQvyfb1PZj0zsPV9VLHBaFF55N4fd3
         vjnqU2Nl6GyE//j2sC4cKvBTBztaOctjsK+SBe9YyXUq+TQolsfDvbislIcXZhhVf47q
         nznOuXhuImmIQbN4ifHJOe25OCSOPul5AVQ1XHTQN2XHv6DujJPUOhL+t26ARZqn7Zpw
         zm8FEd7TUt2rK4kiwIrIuK6suUVWPriIw/lTV3xj5RmXDlSH6OWtu8hb36aMKnWXFldH
         anGNVLt2KiRYeZXJYm+fUH/bD0PZCJKtSYDB8ak01VMWDNed1uG7/ijlRKUqst4XE7eO
         CzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724396988; x=1725001788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYiyuSQAwfiQQ39+HAQvaBlmRARXpxRgdyCqu4zVO9c=;
        b=fQ4UVpGSzjtwHMZvzxlLYe5F3ys8T0kxspPiW61PuOzPeWK1JoKSEm8JOl7sgVL4Zm
         GcZawdKr7GRAIPxy1ElmgRGO8GT2b5KSM4NcD/jzGDFl4tkQbAKU0xgy8WiKU5SsliiK
         lVUBhlg8phfNb/6irn8HEX9d+/TP7joPrYLXkbYIpFsNbCC0ivgWZPYKotxRe93JIGua
         fR+KsIRhZ87iBYVJGlFE4/5Uua8nhhLibxXcJD4ItLv9KXO5BMh+Zc0RNpp02Uc6BKYr
         JDbfbzgt+dIVgpwvB1IKXAcYX/leT9pS9KBQuV3Lq58VqlvqfZ+bOdn+lfn5gF5ofL38
         4d9g==
X-Forwarded-Encrypted: i=1; AJvYcCXml2wxij9y0+Uq0sxpU5Ac0ji4C07Mliw6jIBat5miEfmYypL9dWj90P2yaxIcLCp3UzSNBg9ADGqS5II=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRPtvWezVpcgULRXGbhk4Ae7cEWqOV0N7TSII5FjLSToE/HSSf
	JJFL8NkPoYJtZa/dPvSXYsl6CsLAbdIwdU6ZeRv83fvs/1XBltHyB0ly3EcNO0b4ZZ6XSS8oJ14
	zf0rF80UZoz0aQ0m40g7sbuwn8I+25eDcUjeecBYVl+qLpyCjYWM=
X-Google-Smtp-Source: AGHT+IFheFAcpjMzzb2iqY4HfoVxZvmcsr/sK9zcF/qfuUz+TYRMD4/KAnFW1EAGR+jGgOYeNhlDxxZStd4REvhqF1Y=
X-Received: by 2002:a05:6e02:1a65:b0:39b:3e01:cbd4 with SMTP id
 e9e14a558f8ab-39e3c98c3ecmr14412585ab.14.1724396988109; Fri, 23 Aug 2024
 00:09:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814054434.3563453-1-nick.hu@sifive.com> <20240814054434.3563453-3-nick.hu@sifive.com>
In-Reply-To: <20240814054434.3563453-3-nick.hu@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 23 Aug 2024 12:39:37 +0530
Message-ID: <CAAhSdy0aPwod6_5xf6rw++jFFZNnOSSWJzQ9CJM0g55483rVSA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpuidle: riscv-sbi: Add cpuidle_disabled() check
To: Nick Hu <nick.hu@sifive.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	greentime.hu@sifive.com, zong.li@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 11:14=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrote=
:
>
> The consumer devices that inside the cpu/cluster power domain may registe=
r
> the genpd notifier where their power domains point to the pd nodes under
> '/cpus/power-domains'. If the cpuidle.off=3D=3D1, the genpd notifier will=
 fail
> due to sbi_cpuidle_pd_allow_domain_state is not set. We also need the
> sbi_cpuidle_cpuhp_up/down to invoke the callbacks. Therefore adding a
> cpuidle_disabled() check before cpuidle_register() to address the issue.
>
> Signed-off-by: Nick Hu <nick.hu@sifive.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidl=
e-riscv-sbi.c
> index 98e7751dbfe8..3c8a509288f3 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -25,6 +25,7 @@
>  #include <asm/smp.h>
>  #include <asm/suspend.h>
>
> +#include "cpuidle.h"
>  #include "dt_idle_states.h"
>  #include "dt_idle_genpd.h"
>
> @@ -336,6 +337,9 @@ static int sbi_cpuidle_init_cpu(struct device *dev, i=
nt cpu)
>                 return ret;
>         }
>
> +       if (cpuidle_disabled())
> +               return 0;
> +
>         ret =3D cpuidle_register(drv, NULL);
>         if (ret)
>                 goto deinit;
> @@ -548,7 +552,10 @@ static int sbi_cpuidle_probe(struct platform_device =
*pdev)
>         /* Setup CPU hotplut notifiers */
>         sbi_idle_init_cpuhp();
>
> -       pr_info("idle driver registered for all CPUs\n");
> +       if (cpuidle_disabled())
> +               pr_info("cpuidle is disabled\n");
> +       else
> +               pr_info("idle driver registered for all CPUs\n");
>
>         return 0;
>
> --
> 2.34.1
>

