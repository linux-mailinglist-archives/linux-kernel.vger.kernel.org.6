Return-Path: <linux-kernel+bounces-312927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB71969DCF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971B81F212A2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5734B2101BC;
	Tue,  3 Sep 2024 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vect8TnW"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6E22101AA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367093; cv=none; b=EWbmFN5gBY82DB3mIbwnA7d6pxzBU7YVhuLu496xekIzbc209VA1UvXFVLvPz9Y/5o6rR6m8xVwjuO8JNZ+VF4W1R8jp7nC3hjMR4tDPWt9x8ls+DEgqanqZKR++I3vst93PE3TDWn9Ey9nVeO4G2j7RF44FRzL+3yLoJnftJb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367093; c=relaxed/simple;
	bh=8bcjz7Guh52Axz9nJOwQxROCirWukCUGoHqIdK15WZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkmYlQi/0aNV96qizcUItM1yO3bJKwFHTGlM2l7Kv0VFe9nDUiEuBMD9vGLLamgXJiJN+Q7ex+vUq7YF8uxphDkC6LFW4nU7M6BwNTiLqBn1d9J1bqtBww+kPrdplOE50ESNCFtZ01hbm9gW7QCQ89M9cq6a5uNK5B9JDh2PYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vect8TnW; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e1a9dc3efc1so2951670276.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 05:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725367091; x=1725971891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1nuruAFvQc61s51X1Lt2ynIqtOiGDBJmKVvebKTz6SQ=;
        b=Vect8TnWTweL9I3WUK81MIuartiLmzrAfHgR4eaUMyKRcd0i4WzFHZZH/xjbQV+7XR
         1q4P20TNzbBkW91x1xsr1JlORTzBk+64eSGsrCAmuSJWyoWZhBjFfyyCl5rvRGXKwPJM
         HplgXxs6+6nDmZXRnhPzYbpdI1u9rnD4IyMofZCY+lBSbA7W85paTSpd/tW52j5lyygS
         dLZYk4vBzcxciREdhJIJjEDEsYYTM0ULWHCOjYcSQO9fD4u9JBtt+xFGycyY/dWhlg+d
         Kn6kodeq44SwMzDlayNjo9LzugEXC1RDo/Bo5+0qcaHzBiKzhfKwY+muOfEOQkJilQgW
         E7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367091; x=1725971891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1nuruAFvQc61s51X1Lt2ynIqtOiGDBJmKVvebKTz6SQ=;
        b=nuu8fuC3xC0F1ggMLsi9GIvI82KGLf4MJ6h06h0oMu98jwQRqH/87hstwgGlBmAhGx
         yDU5tg/sm+qMcJf69vWuqrRdiVnzDgH3kB5kK56Ew8q2rIrmhJDATUOF6OCT+XWPaSR3
         aBpx6vJeBe+IuEcJgiFqB9Jw1CwcVCUaAJUFmWwnAExWd6t6q8Eg1v4PDqJSoq9bMLCC
         O0+t4IjUCLFNxpjOr6u5H0X+zolocAfo1o+5rrdAAOFWnJBpHRs4wgPHG2t6XxP5hHa6
         pKEkBuyOsJAiibCF9HnFeEs0PSNl6p2w+H3KjhSx5cvugXITuJTY75jwU6jSkW6c3Uyt
         EE/w==
X-Gm-Message-State: AOJu0YzHLO/NTjp9VmFhSvL3EMxfMx5Ghs7g9Ve7N5XySS4L5yhwFf84
	aKyVw4vMqMSB/xNmAkJHprdhp/+ovBm3MObmifjtQjXs1RCZMJhvcXMXq0m0l/Hws5+3g1zmxfK
	P5JXiNHbykb3oXAYGHe5UwomUG/+mjICss8B6Mw==
X-Google-Smtp-Source: AGHT+IH36/x00Xh4gkPimjkJghxFprOWbRD0VDyx3aqVi0zk7vM4OHwRNy7deO6EqUO9xV6CrWnm6VQxvWzFxXaGLVc=
X-Received: by 2002:a05:6902:1282:b0:e13:e932:6f51 with SMTP id
 3f1490d57ef6-e1a7a1c8b39mr13641364276.50.1725367091177; Tue, 03 Sep 2024
 05:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902151231.3705204-1-jens.wiklander@linaro.org>
In-Reply-To: <20240902151231.3705204-1-jens.wiklander@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2024 14:37:35 +0200
Message-ID: <CAPDyKFpqDRWFRhKP7pH9p0NwfP=tEE2SJ-njKt5AcXtJoUg1ug@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: block: add RPMB dependency
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, Arnd Bergmann <arnd@arndb.de>, 
	Sumit Garg <sumit.garg@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 17:12, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Prevent build error when CONFIG_RPMB=m and CONFIG_MMC_BLOCK=y by adding
> a dependency to CONFIG_RPMB for CONFIG_MMC_BLOCK block so the RPMB
> subsystem always is reachable if configured. This means that
> CONFIG_MMC_BLOCK automatically becomes compiled as a module if
> CONFIG_RPMB is compiled as a module. If CONFIG_RPMB isn't configured or
> is configured as built-in, CONFIG_MMC_BLOCK will remain unchanged.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409021448.RSvcBPzt-lkp@intel.com/
> Fixes: 7852028a35f0 ("mmc: block: register RPMB partition with the RPMB subsystem")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Replacing "rpmb: use IS_REACHABLE instead of IS_ENABLED"
> https://lore.kernel.org/lkml/20240902080727.2665235-1-jens.wiklander@linaro.org/
> ---
>  drivers/mmc/core/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index bf4e29ef023c..14d2ecbb04d3 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -37,6 +37,7 @@ config PWRSEQ_SIMPLE
>  config MMC_BLOCK
>         tristate "MMC block device driver"
>         depends on BLOCK
> +       depends on RPMB || !RPMB
>         imply IOSCHED_BFQ
>         default y
>         help
> --
> 2.34.1
>

