Return-Path: <linux-kernel+bounces-239860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41A6926629
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA868B24A28
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53C11822F8;
	Wed,  3 Jul 2024 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX5QiSVG"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA48117B42A;
	Wed,  3 Jul 2024 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024269; cv=none; b=Kb0vNxCHKryjUCIs+4sRCURaRMLA8vnnahdCHfVXl9h30dHh9g/MqBrVUPrU9dOEqBa3iGvwN+04rX1yPvDGdFba+s0HQatF/76EbCqCN+mqGd1fE6eHLWjW12F5R2ySTf8XPY3z4K/JI3s2JtQFTpsWfcSfADloUm9PNMrtpOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024269; c=relaxed/simple;
	bh=XKSBWmqF879WuQt1zwlB4Yw4FT4A10AdhIIUDd6y6/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2G/hIom/F5ZqxsqvsSjkeryMhYAZK+ZMt+asRm9zO1Nw85L3Ins2WCDbyGH6cvDnVpYIOEWVDhwbM/qF4Ubgx9KEPDYtBJfBFLpz3FmKkhs+ZYFfvBAi1F5ygwU7I7aBMFayu2RFZqFLIwlzfczYi9cGNM+LO8VkcPOWgtQRNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EX5QiSVG; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58b447c511eso3101488a12.2;
        Wed, 03 Jul 2024 09:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720024266; x=1720629066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFaq7stua5V9e6ShlOsqMdtdi5IpEqIinV2Ihg5PfEo=;
        b=EX5QiSVG9DLWTnO9w/K9aNqdtytyAluNjLzmatLD08QvGPpDT8kzKgTgZJ1idIGDCr
         dvFnf7CaPMZNJN5LYpiXqel3kKalewClAhMfcXceT/FWpYqumem56wzODM1q/OVXYNA8
         kfITtzcwKgoK4FQt1l7bJ5W/vAj5lDp30Ux/fwn16wQUa+KaW+ot0qfA3kVDN/GEnsZj
         B71yiNmhswHOljeCPwdo4B6ZwTIeA5rjiB6hWrmfUYrYWBjrSzZzvUwyMJARJ54bn93U
         oOxtAcBoXpXC+uLmBF/iyrm05xFFLufeeBrpA2reXg2kBiuOt0rVdnyQKGj4W524L3At
         MWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720024266; x=1720629066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFaq7stua5V9e6ShlOsqMdtdi5IpEqIinV2Ihg5PfEo=;
        b=ECW1VJtExEiJug7iEC7GkNijsm2UcsJXkaO0Gb55yirxvDxWRpVOhA93+TdDy6xFI8
         FffzUA3UcegMrcWT6/GKRfasHLGReZzEBzSe3yer1F3DM3ZcO9VadMdjIIQF4PrRZwrk
         fSqjAAc7WUFEw7fIyu4MYg64q92Q0hZEvs7a1F5jrgz9jBmzLFsz/LU7X9fYcifPto/b
         Nqumf3HtuqUGxo9mLraOOZyHakj8jeI7vpFJYcQSkHqj2bn80+XA7CebYdw/z9bYrHaq
         MguaBWudqfgxdCU87H2bEXjlk7kRwIrZwUjXYtnIZI5BvOKJIxwJ8N0zD4BgIjBFbogu
         Chkg==
X-Forwarded-Encrypted: i=1; AJvYcCWq8GCymDXARCX9UdxI4P9coLu7xeqb1iUEGjuv51XISfLqkeD9ElHNW4LcBk5p1Dq6SdbVw+Tapwh5iDUEHWSzo+8zSCUs/jGNtaUlh9qtCQJvXA==
X-Gm-Message-State: AOJu0YwnJa5uUOrMoZzEqO+fYZR0LDtvahjN2nglkV5+RIQPsj35BHTo
	Tln7Ga5wxtX1Wwc07ZS+RBazN8lWDfI/2wdxeBv364/WhKF0AAu6DJPU710o9HZcZA+qu2kde6R
	dOobBDJnDlYOszoEU++Lj89aV0XY=
X-Google-Smtp-Source: AGHT+IHu3wetG9Pagsl3I+K8iH33fbKEb5artAF9ID9j9z4atH2RUNsQ1iZOEh62M7M2c/G3B9EXLGNRSsuArtW6JvQ=
X-Received: by 2002:a05:6402:2786:b0:57d:3ea:3862 with SMTP id
 4fb4d7f45d1cf-587a091952amr10632937a12.27.1720024266013; Wed, 03 Jul 2024
 09:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGcaFA3c_rc6HVVqc2=UqOgu2c7zX_XTWNx7Yf-KL7W8LgEi7A@mail.gmail.com>
 <20240703113850.2726539-1-mmaslanka@google.com>
In-Reply-To: <20240703113850.2726539-1-mmaslanka@google.com>
From: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Date: Wed, 3 Jul 2024 12:30:39 -0400
Message-ID: <CAE2upjS-hzciBNm+csXM+i-dnW1knBEyAwcGDya1WCezxD7M=Q@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86:intel/pmc: Enable the ACPI PM Timer to be
 turned off when suspended
To: Marek Maslanka <mmaslanka@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, David E Box <david.e.box@intel.com>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, 
	"David E. Box" <david.e.box@linux.intel.com>, Rafael J Wysocki <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 7:39=E2=80=AFAM Marek Maslanka <mmaslanka@google.com=
> wrote:
>
> Allow to disable ACPI PM Timer on suspend and enable on resume. A
> disabled timer helps optimise power consumption when the system is
> suspended. On resume the timer is only reactivated if it was activated
> prior to suspend, so unless the ACPI PM timer is enabled in the BIOS,
> this won't change anything.

Back in the days IIRC, it was frowned upon but I am not sure anymore.
Maybe Rafael or David will have some opinion on this change. Is this
something that could be done in a platform specific manner such as in
coreboot?

>
> Signed-off-by: Marek Maslanka <mmaslanka@google.com>
> ---
>  drivers/platform/x86/intel/pmc/adl.c  |  2 ++
>  drivers/platform/x86/intel/pmc/cnp.c  |  2 ++
>  drivers/platform/x86/intel/pmc/core.c | 37 +++++++++++++++++++++++++++
>  drivers/platform/x86/intel/pmc/core.h |  8 ++++++
>  drivers/platform/x86/intel/pmc/icl.c  |  2 ++
>  drivers/platform/x86/intel/pmc/mtl.c  |  2 ++
>  drivers/platform/x86/intel/pmc/spt.c  |  2 ++
>  drivers/platform/x86/intel/pmc/tgl.c  |  2 ++
>  8 files changed, 57 insertions(+)
>
> diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/=
intel/pmc/adl.c
> index e7878558fd909..9d9c07f44ff61 100644
> --- a/drivers/platform/x86/intel/pmc/adl.c
> +++ b/drivers/platform/x86/intel/pmc/adl.c
> @@ -295,6 +295,8 @@ const struct pmc_reg_map adl_reg_map =3D {
>         .ppfear_buckets =3D CNP_PPFEAR_NUM_ENTRIES,
>         .pm_cfg_offset =3D CNP_PMC_PM_CFG_OFFSET,
>         .pm_read_disable_bit =3D CNP_PMC_READ_DISABLE_BIT,
> +       .acpi_pm_tmr_ctl_offset =3D SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> +       .acpi_pm_tmr_disable_bit =3D SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>         .ltr_ignore_max =3D ADL_NUM_IP_IGN_ALLOWED,
>         .lpm_num_modes =3D ADL_LPM_NUM_MODES,
>         .lpm_num_maps =3D ADL_LPM_NUM_MAPS,
> diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/=
intel/pmc/cnp.c
> index dd72974bf71e2..513c02670c5aa 100644
> --- a/drivers/platform/x86/intel/pmc/cnp.c
> +++ b/drivers/platform/x86/intel/pmc/cnp.c
> @@ -200,6 +200,8 @@ const struct pmc_reg_map cnp_reg_map =3D {
>         .ppfear_buckets =3D CNP_PPFEAR_NUM_ENTRIES,
>         .pm_cfg_offset =3D CNP_PMC_PM_CFG_OFFSET,
>         .pm_read_disable_bit =3D CNP_PMC_READ_DISABLE_BIT,
> +       .acpi_pm_tmr_ctl_offset =3D SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> +       .acpi_pm_tmr_disable_bit =3D SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>         .ltr_ignore_max =3D CNP_NUM_IP_IGN_ALLOWED,
>         .etr3_offset =3D ETR3_OFFSET,
>  };
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86=
/intel/pmc/core.c
> index 10c96c1a850af..e97ac7a8a18bc 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -1171,6 +1171,35 @@ static bool pmc_core_is_pson_residency_enabled(str=
uct pmc_dev *pmcdev)
>         return val =3D=3D 1;
>  }
>
> +/*
> + * Enable or disable APCI PM Timer
> + *
> + * @return: Previous APCI PM Timer enabled state
> + */
> +static bool pmc_core_enable_apci_pm_timer(struct pmc_dev *pmcdev, bool e=
nable)
> +{
> +       struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_MAIN];
> +       const struct pmc_reg_map *map =3D pmc->map;
> +       bool state;
> +       u32 reg;
> +
> +       if (!map->acpi_pm_tmr_ctl_offset)
> +               return false;
> +
> +       mutex_lock(&pmcdev->lock);
> +
> +       reg =3D pmc_core_reg_read(pmc, map->acpi_pm_tmr_ctl_offset);
> +       state =3D !(reg & map->acpi_pm_tmr_disable_bit);
> +       if (enable)
> +               reg &=3D ~map->acpi_pm_tmr_disable_bit;
> +       else
> +               reg |=3D map->acpi_pm_tmr_disable_bit;
> +       pmc_core_reg_write(pmc, map->acpi_pm_tmr_ctl_offset, reg);
> +
> +       mutex_unlock(&pmcdev->lock);
> +
> +       return state;
> +}
>
>  static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
>  {
> @@ -1446,6 +1475,10 @@ static __maybe_unused int pmc_core_suspend(struct =
device *dev)
>         if (pmcdev->suspend)
>                 pmcdev->suspend(pmcdev);
>
> +       /* Disable APCI PM Timer */
> +       pmcdev->enable_acpi_pm_timer_on_resume =3D
> +               pmc_core_enable_apci_pm_timer(pmcdev, false);
> +
>         /* Check if the syspend will actually use S0ix */
>         if (pm_suspend_via_firmware())
>                 return 0;
> @@ -1500,6 +1533,10 @@ int pmc_core_resume_common(struct pmc_dev *pmcdev)
>         int offset =3D pmc->map->lpm_status_offset;
>         int i;
>
> +       /* Enable APCI PM Timer */
> +       if (pmcdev->enable_acpi_pm_timer_on_resume)
> +               pmc_core_enable_apci_pm_timer(pmcdev, true);
> +
>         /* Check if the syspend used S0ix */
>         if (pm_suspend_via_firmware())
>                 return 0;
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86=
/intel/pmc/core.h
> index 83504c49a0e31..fe1a94f693b63 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -67,6 +67,8 @@ struct telem_endpoint;
>  #define SPT_PMC_LTR_SCC                                0x3A0
>  #define SPT_PMC_LTR_ISH                                0x3A4
>
> +#define SPT_PMC_ACPI_PM_TMR_CTL_OFFSET         0x18FC
> +
>  /* Sunrise Point: PGD PFET Enable Ack Status Registers */
>  enum ppfear_regs {
>         SPT_PMC_XRAM_PPFEAR0A =3D 0x590,
> @@ -147,6 +149,8 @@ enum ppfear_regs {
>  #define SPT_PMC_VRIC1_SLPS0LVEN                        BIT(13)
>  #define SPT_PMC_VRIC1_XTALSDQDIS               BIT(22)
>
> +#define SPT_PMC_BIT_ACPI_PM_TMR_DISABLE                BIT(1)
> +
>  /* Cannonlake Power Management Controller register offsets */
>  #define CNP_PMC_SLPS0_DBG_OFFSET               0x10B4
>  #define CNP_PMC_PM_CFG_OFFSET                  0x1818
> @@ -344,6 +348,8 @@ struct pmc_reg_map {
>         const u8  *lpm_reg_index;
>         const u32 pson_residency_offset;
>         const u32 pson_residency_counter_step;
> +       const u32 acpi_pm_tmr_ctl_offset;
> +       const u32 acpi_pm_tmr_disable_bit;
>  };
>
>  /**
> @@ -417,6 +423,8 @@ struct pmc_dev {
>         u32 die_c6_offset;
>         struct telem_endpoint *punit_ep;
>         struct pmc_info *regmap_list;
> +
> +       bool enable_acpi_pm_timer_on_resume;
>  };
>
>  enum pmc_index {
> diff --git a/drivers/platform/x86/intel/pmc/icl.c b/drivers/platform/x86/=
intel/pmc/icl.c
> index 71b0fd6cb7d84..cbbd440544688 100644
> --- a/drivers/platform/x86/intel/pmc/icl.c
> +++ b/drivers/platform/x86/intel/pmc/icl.c
> @@ -46,6 +46,8 @@ const struct pmc_reg_map icl_reg_map =3D {
>         .ppfear_buckets =3D ICL_PPFEAR_NUM_ENTRIES,
>         .pm_cfg_offset =3D CNP_PMC_PM_CFG_OFFSET,
>         .pm_read_disable_bit =3D CNP_PMC_READ_DISABLE_BIT,
> +       .acpi_pm_tmr_ctl_offset =3D SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> +       .acpi_pm_tmr_disable_bit =3D SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>         .ltr_ignore_max =3D ICL_NUM_IP_IGN_ALLOWED,
>         .etr3_offset =3D ETR3_OFFSET,
>  };
> diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/=
intel/pmc/mtl.c
> index c7d15d864039d..91f2fa728f5c8 100644
> --- a/drivers/platform/x86/intel/pmc/mtl.c
> +++ b/drivers/platform/x86/intel/pmc/mtl.c
> @@ -462,6 +462,8 @@ const struct pmc_reg_map mtl_socm_reg_map =3D {
>         .ppfear_buckets =3D MTL_SOCM_PPFEAR_NUM_ENTRIES,
>         .pm_cfg_offset =3D CNP_PMC_PM_CFG_OFFSET,
>         .pm_read_disable_bit =3D CNP_PMC_READ_DISABLE_BIT,
> +       .acpi_pm_tmr_ctl_offset =3D SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> +       .acpi_pm_tmr_disable_bit =3D SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>         .lpm_num_maps =3D ADL_LPM_NUM_MAPS,
>         .ltr_ignore_max =3D MTL_SOCM_NUM_IP_IGN_ALLOWED,
>         .lpm_res_counter_step_x2 =3D TGL_PMC_LPM_RES_COUNTER_STEP_X2,
> diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/=
intel/pmc/spt.c
> index ab993a69e33ee..2cd2b3c68e468 100644
> --- a/drivers/platform/x86/intel/pmc/spt.c
> +++ b/drivers/platform/x86/intel/pmc/spt.c
> @@ -130,6 +130,8 @@ const struct pmc_reg_map spt_reg_map =3D {
>         .ppfear_buckets =3D SPT_PPFEAR_NUM_ENTRIES,
>         .pm_cfg_offset =3D SPT_PMC_PM_CFG_OFFSET,
>         .pm_read_disable_bit =3D SPT_PMC_READ_DISABLE_BIT,
> +       .acpi_pm_tmr_ctl_offset =3D SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> +       .acpi_pm_tmr_disable_bit =3D SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>         .ltr_ignore_max =3D SPT_NUM_IP_IGN_ALLOWED,
>         .pm_vric1_offset =3D SPT_PMC_VRIC1_OFFSET,
>  };
> diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/=
intel/pmc/tgl.c
> index e0580de180773..371b4e30f1426 100644
> --- a/drivers/platform/x86/intel/pmc/tgl.c
> +++ b/drivers/platform/x86/intel/pmc/tgl.c
> @@ -197,6 +197,8 @@ const struct pmc_reg_map tgl_reg_map =3D {
>         .ppfear_buckets =3D ICL_PPFEAR_NUM_ENTRIES,
>         .pm_cfg_offset =3D CNP_PMC_PM_CFG_OFFSET,
>         .pm_read_disable_bit =3D CNP_PMC_READ_DISABLE_BIT,
> +       .acpi_pm_tmr_ctl_offset =3D SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> +       .acpi_pm_tmr_disable_bit =3D SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
>         .ltr_ignore_max =3D TGL_NUM_IP_IGN_ALLOWED,
>         .lpm_num_maps =3D TGL_LPM_NUM_MAPS,
>         .lpm_res_counter_step_x2 =3D TGL_PMC_LPM_RES_COUNTER_STEP_X2,
> --
> 2.45.2.803.g4e1b14247a-goog
>


--=20
Thanks,
Rajneesh

