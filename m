Return-Path: <linux-kernel+bounces-406547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAA29C60A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269A01F218EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F26F217F5C;
	Tue, 12 Nov 2024 18:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUmGUQQj"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8BC217F56
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437053; cv=none; b=XzswHFDu8AywKzVLiywTz7UQqIKU5ysjfhPZ4Y7yO4pKrQP5czumjEynUhn/wlwnPlWE7gU1/f2wkt04C6+R/OncpIugbBMEmDDCOjS/3smNiEc241ZseqAL7kmHy+INjbKab8ECFj+iuelL8e0vEwxBsVRQFBsiSYOFtTJqcxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437053; c=relaxed/simple;
	bh=I+FspxCvjXN1d6jAEz7mVDNmvXxhrfS/Nunabzq1yo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnELzAeYskID7t4VWxYRav1VE3H5cEcuKjmsEMSJhGLNRbhpoMDdIr0Qg0oXP3jMl3Lg81V9kmSD87SpvY785TI1AnKvkGCg3LACJpwbiqg9lHNg1/OnPt2TxLbgNueLLCpeGH+vEeYPCrvVnPINoMjaeSwFLimZ/ArdZakeMXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kUmGUQQj; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ea7c9226bbso59404847b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731437051; x=1732041851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=raxppSo1jMcpz5wA1AgpjcgkeRdGGPMkWi2ZmAReokQ=;
        b=kUmGUQQjLMaEdk2RFniXP2MVtZqGxT8vga6vTmzXE327+Go98UiLDzB5eSo3flSLzH
         3EAdbaiVaDUOSzYGViO/PM9BRZG9tloXkqb3EUh7luC1gtUX1pcDFxRilOWADOPakARd
         FSjlxNQceucubmHVf+fBJrdHPlLEcWjyZnNfyN30A7mBS9CZhYqLCSmoFV34kgslNISw
         Cu9ynpvQrQvzvqE1J6n1sB4clc4SDHhQJ6sCDss2TJ9UUU1n+XtfceDzlvOe0+FP1+/a
         jOjbQihgHlhqOmsssa3RgIFn7mQEyZ3fI89LYZEtComwaUt139A+XD999vdMFmOmkBzx
         +KCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731437051; x=1732041851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=raxppSo1jMcpz5wA1AgpjcgkeRdGGPMkWi2ZmAReokQ=;
        b=Umj4ILd01N8uQiQAXwMC9jQmPRhcOoyVBaUu/TPgOhn5v0gxTyY+v7NFLnnKHLnpTQ
         EMpRyIljLYkKCxjehgzp3sSn0bP9gOjkjoCIGmcb3qYyaSHbXedr2tkYat2SyZx6ywzy
         gq5pADSGnjF6s5JLawl7M+eazqWmt04vdBkjcsmRvq7Y6X1WptfXaRXzCkgVpTQ+CPkn
         dSNa+rOuJe+1u73V4BTGqdTXVJCd0Nqc3qUZhKi7i8Bf+9JSVld8xBxVoa9oNUslcaif
         jRGr9RL+Xla4xA7CiIIwKbHuz+8nyCoRf2uGLpGYcVOnVop/FfHx6EJp11e4HQpU7DV2
         4wbA==
X-Forwarded-Encrypted: i=1; AJvYcCX0MNL/JIZbBxI0ae1JUu/BRmZycvAGPOllIs/RF2SomTWV3xSN75FHfu6moRcFZJDdjbzkpiDkVDx1X48=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTHS7pqw9VF9M8sAUAj+2q93DntzBOJWhvD5b//J8q8StbUXUp
	91KxLVLfeR7RV1xZahmYdTgduDf2bm/vEipxF4nReaEc750ey6yw26CNOMaMCYLQmvt11LIcGCM
	j9bvnYOnYfylT2O37tvbL/ANvKypQv/sn6woATQ==
X-Google-Smtp-Source: AGHT+IHggGwQBF3hSzjzb92c45ZRJ4m2KowZjmIDRaih1Yr1+njT1vET97p0CVVZ9fc8pdTOaC5cWsqpuqzxPOTvyJ4=
X-Received: by 2002:a05:690c:6483:b0:6ea:8132:4081 with SMTP id
 00721157ae682-6eca4640b4emr44240157b3.3.1731437050114; Tue, 12 Nov 2024
 10:44:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101104416.4954-1-victorshihgli@gmail.com>
In-Reply-To: <20241101104416.4954-1-victorshihgli@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 19:43:34 +0100
Message-ID: <CAPDyKFq25Y2Ftk+7A-hxEu1dLx2hJeAA7yzrcc7FZkSyjL=B+g@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-uhs2: correction a warning caused by
 incorrect type in argument
To: Victor Shih <victorshihgli@gmail.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, 
	kernel test robot <lkp@intel.com>, Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 11:44, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> There is a type issue in the argument in the uhs2_dev_cmd()
> that will generate a warning when building the kernel.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410260525.ZUuPhMJz-lkp@intel.com/
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-uhs2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 7f41ca67b069..33a16cf2e656 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -70,7 +70,7 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>
>  static inline u16 uhs2_dev_cmd(struct mmc_command *cmd)
>  {
> -       return be16_to_cpu((__be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR_MASK;
> +       return be16_to_cpu((__force __be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR_MASK;
>  }
>
>  static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
> --
> 2.25.1
>

