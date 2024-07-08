Return-Path: <linux-kernel+bounces-244381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 640C292A382
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E7F1F229B8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33A5136E2C;
	Mon,  8 Jul 2024 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYIKBDVW"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33984B665
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720444582; cv=none; b=XKkH0PH6nzFMohjwLJlGMg0jS1Fts27g3dnDpa+f7CFWeOgGrHMzQvBpHO4FSwvzofr+DanL+1LDS/I4EWtaPml6YXIjGssJ6nvYOoN0a9J7DRFvPNIBC8T3wyKssmk2sJ30OMdzoTspgscfzIE5xbI0I8iWs9wkVVOjoapIeoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720444582; c=relaxed/simple;
	bh=Pk3uDbdnBhzSMKDQEpbcS/aYip4O9HKB9AJVi7KIBRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNoosgEivLS71X/C+Ka9ZnQf5mjgNSBxoxC8cduju/xIEEyXvForPGxaXVgGrtKyMhSLU75Whiv/psbFXkXyJEdJkqgX0ybKrlIufYSTjXpmea2Yb6hvIW3NO+DaoSaYufrLc4VzLqwfAy5OKi+XSCGv/Hs891BkulKjD4VjyZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DYIKBDVW; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e03db345b0cso2957812276.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 06:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720444580; x=1721049380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CbfiZHX8yMoYqE/2GWwgS7it6nWDSORmbr7HWPP/rrg=;
        b=DYIKBDVW/l+dKeVl59pnu6ekwQjJmuXYScr7VQuhtZJEE50Y8xSdpWaRpqbr9mCoVY
         9VSrei43W63ca1OzfazbrFzjMfnVoRum15oo8b5LY3d4Dhb9ApRzzUPOCrGJzDAbLvTm
         wjRkzvWgSfn513Rjyk6qVLvTf7anTYcSOW2LvzVL9KWHfG4S11e3QA6CcbET0gg91VCA
         +Q1ts8+GGVKzoP02yS9zv+aFlsPj9wa2SRJg5hYGeOUG8kUZ0EBPyPa8wvq5ToJzp3Pw
         mXt43RKmoUyyiiThhjlWz0XPx7wuOcQnjGtaXlsqv7sgZoLstKdi1XNOle5EgrCYZIq2
         /nRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720444580; x=1721049380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbfiZHX8yMoYqE/2GWwgS7it6nWDSORmbr7HWPP/rrg=;
        b=YESJT6aNyvsfyiS+bvQHJAMsN/vnzzbcfrOd+QUg11Y0Y/tnXbIQ3QsMJgu3Dvqb/C
         NlCwIdQ/wP2xFINQqUhfEwqKerpY43SgfAzic1qb+j/Wv7X3aH4yObCxMPt2bfXRWMVX
         u0Bag8mYmdqV298ZJOzCqD4B3b1RI87bMx4V/lcd+0kedM1a0IQqg9mNlTzSiMDKaG98
         CzvldS39EKqCHhz16DA1M+zJC37GKK6OvQ12ibhJx9rzcX+/IeawmR2uC3sewnK3O2pf
         oTmLg/rdqlwd1dbN5bwbY+bM1WxpAVAm0kgwA2462i8DNDWE+iXb+0qvC4M55HAZtqYw
         K57Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKLc5ISFAJsVLWsxUX1XhAT22tD4Tmbxbwuf85OILvp1GHLBD/gDE5yCCQ3hVrOjaen8dDHGvayDEUEi/wVFbv1jmV8QezMSdxMMpb
X-Gm-Message-State: AOJu0YwvrcK8UY3gjYs4kDKStzRx2OBWwZ9zAlOzsOVCyFNmzld2vESE
	o6jDGzgFHDECJ8hb6nOSQ90GzRZBR5V37fo7Ad9ymg3AjLHb1YmfE0oo0JH5MSL/F3ZB9PDp3d0
	zmtcAFFDZxAWOYg7mRlyPDI9OezpJ27naMvCscQ==
X-Google-Smtp-Source: AGHT+IESZNqaZhad1TzrScFyCiXEebpAqCPGG8pUyqeGhyCL5To0pcDYwzf396OVCrYMoMFUdYg/8Laoi+7Ogl/+x14=
X-Received: by 2002:a25:dc87:0:b0:dff:883:cac3 with SMTP id
 3f1490d57ef6-e03c190c094mr13271686276.14.1720444579965; Mon, 08 Jul 2024
 06:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718213918.git.limings@nvidia.com> <2c459196c6867e325f9386ec0559efea464cfdd6.1718213918.git.limings@nvidia.com>
 <CAPDyKFqXZ3JdQBMpTM1ccAFqUSsqUcZ2fn+Ste2aG-APS2dt2w@mail.gmail.com> <BN9PR12MB506861D155E2BFC6B8B61252D3D52@BN9PR12MB5068.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB506861D155E2BFC6B8B61252D3D52@BN9PR12MB5068.namprd12.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 8 Jul 2024 15:15:43 +0200
Message-ID: <CAPDyKFpkxqxeCmWHhw9e1gDUQtGUDJxyFe1JVUhf0DTCcjNCMw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] dw_mmc-bluefield: add hw_reset() support
To: Liming Sun <limings@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, David Thompson <davthompson@nvidia.com>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 21:13, Liming Sun <limings@nvidia.com> wrote:
>
> Thanks, Uffe. Please see some comments/questions below.
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Thursday, June 20, 2024 10:22 AM
> > To: Liming Sun <limings@nvidia.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>; David Thompson
> > <davthompson@nvidia.com>; linux-mmc@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH v1 2/2] dw_mmc-bluefield: add hw_reset() support
> >
> > On Thu, 13 Jun 2024 at 00:53, Liming Sun <limings@nvidia.com> wrote:
> > >
> > > The eMMC RST_N register is implemented as secure register on
> > > BlueField SoC and controlled by ATF. This commit sends SMC call
> > > to ATF for the eMMC HW reset.
> >
> > Just to make sure I get this correctly. Asserting the eMMC reset line
> > is managed through a secure register? Or is this about resetting the
> > eMMC controller?
>
> Yes, asserting the eMMC reset line (RST_N) is managed through a secure register.
> It's the same register but implemented as secure and can only be written in ATF.

Okay, thanks for clarifying!

>
> >
> > No matter what, it looks to me that it should be implemented as a
> > reset provider.
>
> Do you mean that ' hw_reset()' should implement the whole function instead of just the toggling the RST_N?

Sorry, for being very unclear from my side! I was thinking of
modelling it as a GPIO pin that we can assert/deassert to manage the
reset.

However, after a second thought, it looks to me that it would be
unnecessarily complicated. That said, I decided to apply patch 1 and
patch 2, as is. While applying I took the liberty of clarifying the
commit messages a bit, please let me know if it doesn't look okay to
you.

Kind regards
Uffe



>
> >
> > Kind regards
> > Uffe
> >
> > >
> > > Reviewed-by: David Thompson <davthompson@nvidia.com>
> > > Signed-off-by: Liming Sun <limings@nvidia.com>
> > > ---
> > >  drivers/mmc/host/dw_mmc-bluefield.c | 18 +++++++++++++++++-
> > >  1 file changed, 17 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/host/dw_mmc-bluefield.c
> > b/drivers/mmc/host/dw_mmc-bluefield.c
> > > index 4747e5698f48..24e0b604b405 100644
> > > --- a/drivers/mmc/host/dw_mmc-bluefield.c
> > > +++ b/drivers/mmc/host/dw_mmc-bluefield.c
> > > @@ -3,6 +3,7 @@
> > >   * Copyright (C) 2018 Mellanox Technologies.
> > >   */
> > >
> > > +#include <linux/arm-smccc.h>
> > >  #include <linux/bitfield.h>
> > >  #include <linux/bitops.h>
> > >  #include <linux/mmc/host.h>
> > > @@ -20,6 +21,9 @@
> > >  #define BLUEFIELD_UHS_REG_EXT_SAMPLE   2
> > >  #define BLUEFIELD_UHS_REG_EXT_DRIVE    4
> > >
> > > +/* SMC call for RST_N */
> > > +#define BLUEFIELD_SMC_SET_EMMC_RST_N   0x82000007
> > > +
> > >  static void dw_mci_bluefield_set_ios(struct dw_mci *host, struct mmc_ios
> > *ios)
> > >  {
> > >         u32 reg;
> > > @@ -34,8 +38,20 @@ static void dw_mci_bluefield_set_ios(struct dw_mci
> > *host, struct mmc_ios *ios)
> > >         mci_writel(host, UHS_REG_EXT, reg);
> > >  }
> > >
> > > +static void dw_mci_bluefield_hw_reset(struct dw_mci *host)
> > > +{
> > > +               struct arm_smccc_res res = { 0 };
> > > +
> > > +               arm_smccc_smc(BLUEFIELD_SMC_SET_EMMC_RST_N, 0, 0, 0, 0, 0,
> > 0, 0,
> > > +                             &res);
> > > +
> > > +               if (res.a0)
> > > +                       pr_err("RST_N failed.\n");
> > > +}
> > > +
> > >  static const struct dw_mci_drv_data bluefield_drv_data = {
> > > -       .set_ios                = dw_mci_bluefield_set_ios
> > > +       .set_ios                = dw_mci_bluefield_set_ios,
> > > +       .hw_reset               = dw_mci_bluefield_hw_reset
> > >  };
> > >
> > >  static const struct of_device_id dw_mci_bluefield_match[] = {
> > > --
> > > 2.30.1
> > >

