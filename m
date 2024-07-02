Return-Path: <linux-kernel+bounces-238537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562A8924BAC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBDCB2830FB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5637F155A24;
	Tue,  2 Jul 2024 22:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xa/SdsRd"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7FF1DA30E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 22:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719960101; cv=none; b=dPBkppmjwVJ0kW+QpBkffgV4o8AcD3HirXKFhArOtDDThb0y8yCt6R0Sf841WZ5VUxXV09G0/1VcpAXPM7qkAO8wjnZJRCqhjxSJGb/C/syBxMQ0w3Tkgja4F/scPCM7ax1Z2L2OyHpoVAvqAAZdJilM20JEMbO7cgK8DkF9fuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719960101; c=relaxed/simple;
	bh=WwmCP4yWBUuYDJXI8BO59+v6R2ohok84k65c1Ooi1pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANtKU0aKJ2/v7fVgDpHHNRp0gigoDmFLxmiTt/AJRs27U2gP9LEQzUd0/HG1xzJqGC5ohcNyPVgZtpw+njYIZMBgxitvwiExNSkEWA4XNWGXyeyx5qMFBWqEQwKUvjDX3/c3nzEG1nUyLml9TgcEPaD2x3Mw8llKeEbbpfRmooI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xa/SdsRd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fa901ad6f3so61655ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 15:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719960099; x=1720564899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9puiPQoNYWjSHsTzNFQQtyTm738ElAqP8Fm6xVoFMc=;
        b=xa/SdsRdFGoLOlQg5jnqWoUWEDGyr9uXRbwlnmhdP2XJ2EU1TPvQtMILZOPtXLN6rW
         JoKYgCwnCnTNQ0Khdv+M10mOQRpLNX7ULmw7BTHi0MlhcErO5ZWdamCZYVRe4BDP8YbN
         hheB9LqDxNwbJn9m27JiwsWJE7FL56p7sWpZIKmMiRSLqoUspqoqNEbJ9YR0wSqHrhpF
         Y+/JsF5B8GY/gNy+3m7lY2wUoPpoxZ9UnCcDmf7O9zeEzf3NIQSmYqv5b+97P7x36jJU
         nSmj8pAxFaOfAL03P+hiiqpjs6epcuGhnxiLvFXS1v93p7oKH7uuOw83BNMqsMat9pcK
         a3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719960099; x=1720564899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9puiPQoNYWjSHsTzNFQQtyTm738ElAqP8Fm6xVoFMc=;
        b=VWLUG6p9xquD434f/KOZsFaMJJbVgY2uqk4ng7xzCbBYg3E6pWMT2hkIA5oW0ZBNmE
         BEYgnYYQCF6wjUjOiRWBuaqi3sHlcqCH9En4qNJE+Ugdc6W4AuqTVhSSUTHLVtbzUXeg
         01Sv9QgIcxc+NKBuDNW//1HRHruJU3nmog69TGj5FuBGQKm4PZsdPUuOAL5hJiKoC3K/
         iAeDY0pZ3ly8gUpoPiZb0ENHshM2Om6ayZrtu7OO2IZr5Xa/CjhXItvmdf7TIdT9DboU
         kgenUGug+3I9ruVrPPKgmgk+kSX+xincjUlYNlMS4d+iSJjlFWZv3qpidEg1FZkD4Dd8
         mONA==
X-Gm-Message-State: AOJu0Yzlgd5wxfIcs5sMqtR5Rgf7Tx3Ni7lzMveKBcc64tMUgZVgYQtR
	HevaNhZIUvU30/I1T05wFEQm+5a33lRTHNRzgQ7EfMPal0402XEKm/YAoY2ydWa2JQVROzghV31
	WvlzVmZCK/dkZ8SNvTwP9FuGIY7/ZM7kV2sdtlIuiEPjb0WNCsjha0b8=
X-Google-Smtp-Source: AGHT+IEC1Q1F/v6X7G8CxtK3fnJsiiYTaAJAOHrT34l/0++cv5s8Krtl9Emmk1CsMKzRP7G3hlTnjWXlHJDJMyD6jis=
X-Received: by 2002:a17:902:bd89:b0:1f6:7fce:5684 with SMTP id
 d9443c01a7336-1fb150ce66bmr449465ad.3.1719960098426; Tue, 02 Jul 2024
 15:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701222508.1.I872f9412fdb7cdc20d7c6e98b93daa014f3616dc@changeid>
 <6c4a7fab-6ee8-4a61-b790-7402cc107807@redhat.com>
In-Reply-To: <6c4a7fab-6ee8-4a61-b790-7402cc107807@redhat.com>
From: =?UTF-8?Q?Marek_Ma=C5=9Blanka?= <mmaslanka@google.com>
Date: Wed, 3 Jul 2024 00:41:26 +0200
Message-ID: <CAGcaFA3c_rc6HVVqc2=UqOgu2c7zX_XTWNx7Yf-KL7W8LgEi7A@mail.gmail.com>
Subject: Re: [PATCH] platform/x86:intel/pmc: Enable the ACPI PM Timer to be
 turned off when suspended
To: Hans de Goede <hdegoede@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, David E Box <david.e.box@intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Tue, Jul 2, 2024 at 10:02=E2=80=AFAM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi Marek,
>
> On 7/2/24 12:25 AM, Marek Maslanka wrote:
> > Allow to disable ACPI PM Timer on suspend and enable on resume. A
> > disabled timer helps optimise power consumption when the system is
> > suspended. On resume the timer is only reactivated if it was activated
> > prior to suspend, so unless the ACPI PM timer is enabled in the BIOS,
> > this won't change anything.
> >
> > Signed-off-by: Marek Maslanka <mmaslanka@google.com>
>
> Thank you for your patch. I have not looked into it into too much
> detail (I expect the Intel maintainers of the driver will do that)
> but why is there a Kconfig option for this ?
>
> It seems to me that this is something which we simply always want
> to do and we don't need all the #ifdef-s ?

Yes, you're right, ifdef-s are not needed as there are conditions that chec=
k if
CPU support disables the timer. I'll remove it in the next patch.

Best,
Marek

>
> Regards,
>
> Hans
>
>
>
> > ---
> >
> >  drivers/platform/x86/intel/pmc/Kconfig | 13 ++++++++
> >  drivers/platform/x86/intel/pmc/adl.c   |  4 +++
> >  drivers/platform/x86/intel/pmc/cnp.c   |  4 +++
> >  drivers/platform/x86/intel/pmc/core.c  | 43 ++++++++++++++++++++++++++
> >  drivers/platform/x86/intel/pmc/core.h  | 14 +++++++++
> >  drivers/platform/x86/intel/pmc/icl.c   |  4 +++
> >  drivers/platform/x86/intel/pmc/mtl.c   |  4 +++
> >  drivers/platform/x86/intel/pmc/spt.c   |  4 +++
> >  drivers/platform/x86/intel/pmc/tgl.c   |  4 +++
> >  9 files changed, 94 insertions(+)
> >
> > diff --git a/drivers/platform/x86/intel/pmc/Kconfig b/drivers/platform/=
x86/intel/pmc/Kconfig
> > index d2f651fbec2cf..3a563db8eba6a 100644
> > --- a/drivers/platform/x86/intel/pmc/Kconfig
> > +++ b/drivers/platform/x86/intel/pmc/Kconfig
> > @@ -24,3 +24,16 @@ config INTEL_PMC_CORE
> >               - SLPS0 Debug registers (Cannonlake/Icelake PCH)
> >               - Low Power Mode registers (Tigerlake and beyond)
> >               - PMC quirks as needed to enable SLPS0/S0ix
> > +
> > +config DISABLE_ACPI_PM_TIMER_ON_SUSPEND
> > +     bool "Disable ACPI PM Timer on suspend"
> > +     default n
> > +     depends on INTEL_PMC_CORE
> > +     help
> > +       Disable ACPI Power Management Timer on entering to suspend and =
enable it
> > +       on resume. This helps optimize energy consumption while the sys=
tem is
> > +       suspend.
> > +
> > +       This is only applicable if the ACPI PM timer is enabled by the =
BIOS.
> > +
> > +       Say N if unsure.
> > diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x8=
6/intel/pmc/adl.c
> > index e7878558fd909..8859e0d275288 100644
> > --- a/drivers/platform/x86/intel/pmc/adl.c
> > +++ b/drivers/platform/x86/intel/pmc/adl.c
> > @@ -295,6 +295,10 @@ const struct pmc_reg_map adl_reg_map =3D {
> >       .ppfear_buckets =3D CNP_PPFEAR_NUM_ENTRIES,
> >       .pm_cfg_offset =3D CNP_PMC_PM_CFG_OFFSET,
> >       .pm_read_disable_bit =3D CNP_PMC_READ_DISABLE_BIT,
> > +#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
> > +     .acpi_pm_tmr_ctl_offset =3D SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> > +     .acpi_pm_tmr_disable_bit =3D SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
> > +#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
> >       .ltr_ignore_max =3D ADL_NUM_IP_IGN_ALLOWED,
> >       .lpm_num_modes =3D ADL_LPM_NUM_MODES,
> >       .lpm_num_maps =3D ADL_LPM_NUM_MAPS,
> > diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x8=
6/intel/pmc/cnp.c
> > index dd72974bf71e2..e92157aa3c9f1 100644
> > --- a/drivers/platform/x86/intel/pmc/cnp.c
> > +++ b/drivers/platform/x86/intel/pmc/cnp.c
> > @@ -200,6 +200,10 @@ const struct pmc_reg_map cnp_reg_map =3D {
> >       .ppfear_buckets =3D CNP_PPFEAR_NUM_ENTRIES,
> >       .pm_cfg_offset =3D CNP_PMC_PM_CFG_OFFSET,
> >       .pm_read_disable_bit =3D CNP_PMC_READ_DISABLE_BIT,
> > +#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
> > +     .acpi_pm_tmr_ctl_offset =3D SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> > +     .acpi_pm_tmr_disable_bit =3D SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
> > +#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
> >       .ltr_ignore_max =3D CNP_NUM_IP_IGN_ALLOWED,
> >       .etr3_offset =3D ETR3_OFFSET,
> >  };
> > diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x=
86/intel/pmc/core.c
> > index 10c96c1a850af..a3e56c524308f 100644
> > --- a/drivers/platform/x86/intel/pmc/core.c
> > +++ b/drivers/platform/x86/intel/pmc/core.c
> > @@ -1171,6 +1171,37 @@ static bool pmc_core_is_pson_residency_enabled(s=
truct pmc_dev *pmcdev)
> >       return val =3D=3D 1;
> >  }
> >
> > +#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
> > +/*
> > + * Enable or disable APCI PM Timer
> > + *
> > + * @return: Previous APCI PM Timer enabled state
> > + */
> > +static bool pmc_core_enable_apci_pm_timer(struct pmc_dev *pmcdev, bool=
 enable)
> > +{
> > +     struct pmc *pmc =3D pmcdev->pmcs[PMC_IDX_MAIN];
> > +     const struct pmc_reg_map *map =3D pmc->map;
> > +     bool state;
> > +     u32 reg;
> > +
> > +     if (!map->acpi_pm_tmr_ctl_offset)
> > +             return false;
> > +
> > +     mutex_lock(&pmcdev->lock);
> > +
> > +     reg =3D pmc_core_reg_read(pmc, map->acpi_pm_tmr_ctl_offset);
> > +     state =3D !(reg & map->acpi_pm_tmr_disable_bit);
> > +     if (enable)
> > +             reg &=3D ~map->acpi_pm_tmr_disable_bit;
> > +     else
> > +             reg |=3D map->acpi_pm_tmr_disable_bit;
> > +     pmc_core_reg_write(pmc, map->acpi_pm_tmr_ctl_offset, reg);
> > +
> > +     mutex_unlock(&pmcdev->lock);
> > +
> > +     return state;
> > +}
> > +#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
> >
> >  static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
> >  {
> > @@ -1446,6 +1477,12 @@ static __maybe_unused int pmc_core_suspend(struc=
t device *dev)
> >       if (pmcdev->suspend)
> >               pmcdev->suspend(pmcdev);
> >
> > +#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
> > +     /* Disable APCI PM Timer */
> > +     pmcdev->enable_acpi_pm_timer_on_resume =3D
> > +             pmc_core_enable_apci_pm_timer(pmcdev, false);
> > +#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
> > +
> >       /* Check if the syspend will actually use S0ix */
> >       if (pm_suspend_via_firmware())
> >               return 0;
> > @@ -1500,6 +1537,12 @@ int pmc_core_resume_common(struct pmc_dev *pmcde=
v)
> >       int offset =3D pmc->map->lpm_status_offset;
> >       int i;
> >
> > +#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
> > +     /* Enable APCI PM Timer */
> > +     if (pmcdev->enable_acpi_pm_timer_on_resume)
> > +             pmc_core_enable_apci_pm_timer(pmcdev, true);
> > +#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
> > +
> >       /* Check if the syspend used S0ix */
> >       if (pm_suspend_via_firmware())
> >               return 0;
> > diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x=
86/intel/pmc/core.h
> > index 83504c49a0e31..4d5983d741433 100644
> > --- a/drivers/platform/x86/intel/pmc/core.h
> > +++ b/drivers/platform/x86/intel/pmc/core.h
> > @@ -67,6 +67,10 @@ struct telem_endpoint;
> >  #define SPT_PMC_LTR_SCC                              0x3A0
> >  #define SPT_PMC_LTR_ISH                              0x3A4
> >
> > +#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
> > +#define SPT_PMC_ACPI_PM_TMR_CTL_OFFSET               0x18FC
> > +#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
> > +
> >  /* Sunrise Point: PGD PFET Enable Ack Status Registers */
> >  enum ppfear_regs {
> >       SPT_PMC_XRAM_PPFEAR0A =3D 0x590,
> > @@ -147,6 +151,10 @@ enum ppfear_regs {
> >  #define SPT_PMC_VRIC1_SLPS0LVEN                      BIT(13)
> >  #define SPT_PMC_VRIC1_XTALSDQDIS             BIT(22)
> >
> > +#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
> > +#define SPT_PMC_BIT_ACPI_PM_TMR_DISABLE              BIT(1)
> > +#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
> > +
> >  /* Cannonlake Power Management Controller register offsets */
> >  #define CNP_PMC_SLPS0_DBG_OFFSET             0x10B4
> >  #define CNP_PMC_PM_CFG_OFFSET                        0x1818
> > @@ -344,6 +352,8 @@ struct pmc_reg_map {
> >       const u8  *lpm_reg_index;
> >       const u32 pson_residency_offset;
> >       const u32 pson_residency_counter_step;
> > +     const u32 acpi_pm_tmr_ctl_offset;
> > +     const u32 acpi_pm_tmr_disable_bit;
> >  };
> >
> >  /**
> > @@ -417,6 +427,10 @@ struct pmc_dev {
> >       u32 die_c6_offset;
> >       struct telem_endpoint *punit_ep;
> >       struct pmc_info *regmap_list;
> > +
> > +#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
> > +     bool enable_acpi_pm_timer_on_resume;
> > +#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
> >  };
> >
> >  enum pmc_index {
> > diff --git a/drivers/platform/x86/intel/pmc/icl.c b/drivers/platform/x8=
6/intel/pmc/icl.c
> > index 71b0fd6cb7d84..8b5c782e71ebd 100644
> > --- a/drivers/platform/x86/intel/pmc/icl.c
> > +++ b/drivers/platform/x86/intel/pmc/icl.c
> > @@ -46,6 +46,10 @@ const struct pmc_reg_map icl_reg_map =3D {
> >       .ppfear_buckets =3D ICL_PPFEAR_NUM_ENTRIES,
> >       .pm_cfg_offset =3D CNP_PMC_PM_CFG_OFFSET,
> >       .pm_read_disable_bit =3D CNP_PMC_READ_DISABLE_BIT,
> > +#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
> > +     .acpi_pm_tmr_ctl_offset =3D SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> > +     .acpi_pm_tmr_disable_bit =3D SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
> > +#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
> >       .ltr_ignore_max =3D ICL_NUM_IP_IGN_ALLOWED,
> >       .etr3_offset =3D ETR3_OFFSET,
> >  };
> > diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x8=
6/intel/pmc/mtl.c
> > index c7d15d864039d..c726ef8f1d5a9 100644
> > --- a/drivers/platform/x86/intel/pmc/mtl.c
> > +++ b/drivers/platform/x86/intel/pmc/mtl.c
> > @@ -462,6 +462,10 @@ const struct pmc_reg_map mtl_socm_reg_map =3D {
> >       .ppfear_buckets =3D MTL_SOCM_PPFEAR_NUM_ENTRIES,
> >       .pm_cfg_offset =3D CNP_PMC_PM_CFG_OFFSET,
> >       .pm_read_disable_bit =3D CNP_PMC_READ_DISABLE_BIT,
> > +#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
> > +     .acpi_pm_tmr_ctl_offset =3D SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> > +     .acpi_pm_tmr_disable_bit =3D SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
> > +#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
> >       .lpm_num_maps =3D ADL_LPM_NUM_MAPS,
> >       .ltr_ignore_max =3D MTL_SOCM_NUM_IP_IGN_ALLOWED,
> >       .lpm_res_counter_step_x2 =3D TGL_PMC_LPM_RES_COUNTER_STEP_X2,
> > diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x8=
6/intel/pmc/spt.c
> > index ab993a69e33ee..4832e953d0403 100644
> > --- a/drivers/platform/x86/intel/pmc/spt.c
> > +++ b/drivers/platform/x86/intel/pmc/spt.c
> > @@ -130,6 +130,10 @@ const struct pmc_reg_map spt_reg_map =3D {
> >       .ppfear_buckets =3D SPT_PPFEAR_NUM_ENTRIES,
> >       .pm_cfg_offset =3D SPT_PMC_PM_CFG_OFFSET,
> >       .pm_read_disable_bit =3D SPT_PMC_READ_DISABLE_BIT,
> > +#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
> > +     .acpi_pm_tmr_ctl_offset =3D SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> > +     .acpi_pm_tmr_disable_bit =3D SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
> > +#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
> >       .ltr_ignore_max =3D SPT_NUM_IP_IGN_ALLOWED,
> >       .pm_vric1_offset =3D SPT_PMC_VRIC1_OFFSET,
> >  };
> > diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x8=
6/intel/pmc/tgl.c
> > index e0580de180773..4742b84fe226e 100644
> > --- a/drivers/platform/x86/intel/pmc/tgl.c
> > +++ b/drivers/platform/x86/intel/pmc/tgl.c
> > @@ -197,6 +197,10 @@ const struct pmc_reg_map tgl_reg_map =3D {
> >       .ppfear_buckets =3D ICL_PPFEAR_NUM_ENTRIES,
> >       .pm_cfg_offset =3D CNP_PMC_PM_CFG_OFFSET,
> >       .pm_read_disable_bit =3D CNP_PMC_READ_DISABLE_BIT,
> > +#ifdef CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND
> > +     .acpi_pm_tmr_ctl_offset =3D SPT_PMC_ACPI_PM_TMR_CTL_OFFSET,
> > +     .acpi_pm_tmr_disable_bit =3D SPT_PMC_BIT_ACPI_PM_TMR_DISABLE,
> > +#endif /* CONFIG_DISABLE_ACPI_PM_TIMER_ON_SUSPEND */
> >       .ltr_ignore_max =3D TGL_NUM_IP_IGN_ALLOWED,
> >       .lpm_num_maps =3D TGL_LPM_NUM_MAPS,
> >       .lpm_res_counter_step_x2 =3D TGL_PMC_LPM_RES_COUNTER_STEP_X2,
>

