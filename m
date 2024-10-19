Return-Path: <linux-kernel+bounces-372640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EBA9A4B57
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 07:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD50A1F22EFD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 05:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8981D2B1B;
	Sat, 19 Oct 2024 05:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R06mnRgt"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871331D0169
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 05:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729316572; cv=none; b=m1BUzWX1ZZM/wv3hARdNxrXHuAViBFlQbuHQEkcbKM3dceF4vOp/pF86mXKRRUN+QOUVvLN7acYg5eFN/Rws4scDzqGCPXva5mB5XYtYBuxDrrxiAOW8yRtRrA1eTebMasPQQXoUTmNkBvqXzVRcj1YgPuzV6r2a1OaOJbktNJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729316572; c=relaxed/simple;
	bh=Fz8SqKP1uHowIapTRbRFvVKoMLY1FsF7+S4uGHynG6c=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3sBEI4oV8iiQ3qlUJCZDW9VGy7KyZ5lZVK8IaBKq6aHEL+HTUG0BGp6zMSy/ls4YSumXUvqInGaeOBfL/hAGSzCQXpnvEdTMBSXIXgJ6DWSYwJHYJJtcqtDSpJxMh26MWCGM11B7cHWJlZotvbBI7Mhyt1nsK6Ko5AriezXOSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R06mnRgt; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460a23ad00eso19996191cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 22:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729316568; x=1729921368; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38uHeg7U8taINS003z4nsL0moH37te8cu6msh48JjeU=;
        b=R06mnRgtfwUkZ3EgYXRMKTF5PzB1X6kPlOWHtKsg8HsK9pVraIaxYNmWNT9/2atcAU
         lSlwtGXun+gjw6jVGU/rMYn0PocaNFqkvfzGjHkFUxw2yWMwmv1bSxQWhyuKbLLhzO8w
         tfGfxQ1W/4HpyRhuJNPh6anJLE5C9zervdvEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729316568; x=1729921368;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38uHeg7U8taINS003z4nsL0moH37te8cu6msh48JjeU=;
        b=h/A6sSaLa5kKJF6viPsbHsArmYmh20GB0tu7+nZvw2we/3JFGRuUf1aG/1SjwU1rmu
         DACNtD7cg5uvn2lDu83Z0hCn48W0sTEQI26gevfSC6AWfNUpyv7vqUsPmg1753EwrTwX
         X1aDtsqwwP2E+XgF16U7k0tSu0EVL4u6lyzi1ByKVXgot9VUYm73mtc0mS3GC5mt6A1t
         2gbqvUFQDhteCkGo/e0fy6G13vFQ7TGGnzmL47IRhbufp3TbWjcsxJFIqJhxWNFfUqUq
         1pN+rqylT9fNzbqohX6QxJmMyzmypsTI5dfgrBtRdmH7mBG41eTh1tTa4rag3ERtU+8q
         uQ1g==
X-Forwarded-Encrypted: i=1; AJvYcCWHShc7GVj+fINYpRMpGF40WcgmaBN+XHgniKfTBXNz03dfiepe0JUoUSMbV2arab9+v9gLcOqChlSt0Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNWAk7bbyWO/LnuHfGVhSpdITsKuzDPPTxPA4IGmTZnOCnEpfX
	GP1ET1CWPoboIJhH7W8spqhMLZLqP7JgBurm2n9vQUPMsy/t+JOJPQetYxoscvlNnLxwesnG1+T
	4Qq7W+Ujc/2k9wR4mm71+NdgWdP7a0KhEcPm0
X-Google-Smtp-Source: AGHT+IHcrn2IEf1cChfNodoLs2wc3W9pzjfl5TJdUYdOATX2Xw0JIz86mzqzlYVx37yQ/m7JwvB1D/0HhOqmDTq9w38=
X-Received: by 2002:a05:622a:5148:b0:451:b77e:a8c1 with SMTP id
 d75a77b69052e-4609b44cbf0mr165252061cf.3.1729316568440; Fri, 18 Oct 2024
 22:42:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Oct 2024 22:42:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241018-arm-psci-system_reset2-vendor-reboots-v6-3-50cbe88b0a24@quicinc.com>
References: <20241018-arm-psci-system_reset2-vendor-reboots-v6-0-50cbe88b0a24@quicinc.com>
 <20241018-arm-psci-system_reset2-vendor-reboots-v6-3-50cbe88b0a24@quicinc.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Fri, 18 Oct 2024 22:42:46 -0700
Message-ID: <CAE-0n515sUkmTWptgY8pOaMDBPfDp5pZBy9Nby+4cMdMAnAZfA@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] firmware: psci: Read and use vendor reset types
To: Andy Yan <andy.yan@rock-chips.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Elliot Berman <quic_eberman@quicinc.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Olof Johansson <olof@lixom.net>, Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, Melody Olvera <quic_molvera@quicinc.com>, 
	Shivendra Pratap <quic_spratap@quicinc.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Elliot Berman (2024-10-18 12:39:48)
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 2328ca58bba6..60bc285622ce 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -29,6 +29,8 @@
>  #include <asm/smp_plat.h>
>  #include <asm/suspend.h>
>
> +#define REBOOT_PREFIX "mode-"

Maybe move this near the function that uses it.

> +
>  /*
>   * While a 64-bit OS can make calls with SMC32 calling conventions, for some
>   * calls it is necessary to use SMC64 to pass or return 64-bit values.
> @@ -305,9 +315,29 @@ static int get_set_conduit_method(const struct device_node *np)
>         return 0;
>  }
>
> +static void psci_vendor_sys_reset2(unsigned long action, void *data)
> +{
> +       const char *cmd = data;
> +       unsigned long ret;
> +       size_t i;
> +
> +       for (i = 0; i < num_psci_reset_params; i++) {
> +               if (!strcmp(psci_reset_params[i].mode, cmd)) {
> +                       ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
> +                                            psci_reset_params[i].reset_type,
> +                                            psci_reset_params[i].cookie, 0);
> +                       pr_err("failed to perform reset \"%s\": %ld\n",
> +                               cmd, (long)ret);

Do this intentionally return? Should it be some other function that's
__noreturn instead and a while (1) if the firmware returns back to the
kernel?

> +               }
> +       }
> +}
> +
>  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
>                           void *data)
>  {
> +       if (data && num_psci_reset_params)
> +               psci_vendor_sys_reset2(action, data);
> +
>         if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
>             psci_system_reset2_supported) {
>                 /*
> @@ -750,6 +780,68 @@ static const struct of_device_id psci_of_match[] __initconst = {
>         {},
>  };
>
> +static int __init psci_init_system_reset2_modes(void)
> +{
> +       const size_t len = strlen(REBOOT_PREFIX);
> +       struct psci_reset_param *param;
> +       struct device_node *psci_np __free(device_node) = NULL;
> +       struct device_node *np __free(device_node) = NULL;
> +       struct property *prop;
> +       size_t count = 0;
> +       u32 magic[2];
> +       int num;
> +
> +       if (!psci_system_reset2_supported)
> +               return 0;
> +
> +       psci_np = of_find_matching_node(NULL, psci_of_match);
> +       if (!psci_np)
> +               return 0;
> +
> +       np = of_find_node_by_name(psci_np, "reset-types");
> +       if (!np)
> +               return 0;
> +
> +       for_each_property_of_node(np, prop) {
> +               if (strncmp(prop->name, REBOOT_PREFIX, len))
> +                       continue;
> +               num = of_property_count_elems_of_size(np, prop->name, sizeof(magic[0]));

Use of_property_count_u32_elems()?

> +               if (num != 1 && num != 2)
> +                       continue;
> +
> +               count++;
> +       }
> +
> +       param = psci_reset_params = kcalloc(count, sizeof(*psci_reset_params), GFP_KERNEL);
> +       if (!psci_reset_params)
> +               return -ENOMEM;
> +
> +       for_each_property_of_node(np, prop) {
> +               if (strncmp(prop->name, REBOOT_PREFIX, len))
> +                       continue;
> +
> +               param->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
> +               if (!param->mode)
> +                       continue;
> +
> +               num = of_property_read_variable_u32_array(np, prop->name, magic, 1, 2);

ARRAY_SIZE(magic)?

> +               if (num < 0) {

Should this be less than 1?

> +                       pr_warn("Failed to parse vendor reboot mode %s\n", param->mode);
> +                       kfree_const(param->mode);
> +                       continue;
> +               }
> +
> +               /* Force reset type to be in vendor space */
> +               param->reset_type = PSCI_1_1_RESET_TYPE_VENDOR_START | magic[0];
> +               param->cookie = num == 2 ? magic[1] : 0;

ARRAY_SIZE(magic)?

> +               param++;
> +               num_psci_reset_params++;
> +       }
> +
> +       return 0;

