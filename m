Return-Path: <linux-kernel+bounces-357424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5159099711B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91E01F26D70
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874621E102C;
	Wed,  9 Oct 2024 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7FpiEDr"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4E219925F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490114; cv=none; b=t3DzC2559xSqlu0LwS4ALQQ7/k6NEO3ixjUwdX71Xu25Fa2YYNVXK2JJC7+9sJDWpvEWoJMei5Sb/X2gOW/u4lAAaEfvv/Vtcrx9rMH1UTIVmGdIC2qNZnX5PulOYPxgvBoF70eHvpjI6C8ZGLsj7wAF20OZ/58bd67wFogd9dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490114; c=relaxed/simple;
	bh=Igjc2fjP7/krIv/lq+RWcyh4VTxthMbh0r64QFTO0Pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLtQZtQ+8p96E/l6hSPr01KJ93q8pLEqXSLANJty0HsFvl/rhkmX7GhxQNL6Kh5pBOYGr7VN4CAkmdJHhPK+mubNTQZl/gYrqzpAYLhwcIUax1x3b7cvsadmmCoRcjOUSOdTo0HMoQpnIpHenDja74MsbE7nwuaEKY733YXdjKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7FpiEDr; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5e800d4e462so1064954eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728490112; x=1729094912; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dUwGSsjHrSgoOIsgeTS2M31kgjJgAf7Nhhvgn0kPgQI=;
        b=B7FpiEDrCeSg/ls34HYWyBIzNIWg9090HAj859Wi9yjgETeLL4IazwYihnE7Sbppfw
         hZlg4w3zLulAPk9ycNtKMsy9jRktjZ4Yt/NDbb7obs2C3Dae2PinsuvQmQyWJWzV+gyr
         UExfVQRGLHW5uviFQulmqgpuopDM5VBPihHD93IJhJAs0zlylJC4nQCzoaa5/iHyNjz+
         f+lPVm5XcXm50lVcWOPJLRsTPs5En1uZKUHsw40LR2GP7Y78g6ZZV7yhdb0mOWo65FSi
         jtbTWxzF6PPlv30AUryYOH4XQz1z4maqxpSul3NHNp9mtsgXWWnJ/xrvivH+cHWtApOE
         Tc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490112; x=1729094912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUwGSsjHrSgoOIsgeTS2M31kgjJgAf7Nhhvgn0kPgQI=;
        b=FRGwXK6HV8VYh2ujukRQyfKSB02z73OFeZzfwaG7S6Bu+uWnwfR5CHiKUn63RdrRze
         ly9URkcQj0wsa09WVUcCyvFMUsCCm1ZxT+tc2g/yJ0CO4yNU1IDcZ4ztqkBuGeum/8Qk
         ADGZ8q7FUBDrM7CkJ3skYHCT4hQi8Z0Ge+xCMwojp948tXinUmJw4B56y15fEkk7Uw3z
         sWvO2gegGAS1BqUdfELB4djV6VrCZOYMCG+RKP0hPI8a0n55C/aswMF2GPMOaziM9o4Q
         f/MbgdgOeJK51cZ/LlZFm8Yxk0m9ynUcmFeL4Edvo7kLhOr+qdr2EkEV3dgONWLwI8x/
         f1bg==
X-Forwarded-Encrypted: i=1; AJvYcCVS17rHbQA/Yzp6j3lB02GXV1M1tK6OGpzBjiqaMIybZezcbMbKUdrvsGWDEcdBhSwoxyrmYIKoutFDNlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ShVAtsOjRBcn5fHeA7fiZpPIGQdHWCSokCDYe44VTofGE1XD
	Gpk2jOTgcp6Y0neA0TOBLQKLMYYR8hg7FShY7nA7cBJ2GoS6kY9Ucvs5LzZIyNLFb5QKIwdJae5
	6H70xd9cYWwOegtHqxIFeWOOOlCM=
X-Google-Smtp-Source: AGHT+IFMMbtkx3tK+aTrJ3F2KHX8kyggky/0UMYtM+dmOz61z+cm/RkkmSILPX2+wyk4erwR+cBKIflL/G7OjeVhmfA=
X-Received: by 2002:a05:6820:1acc:b0:5e1:cd24:c19c with SMTP id
 006d021491bc7-5e98fe0de88mr699676eaf.0.1728490111971; Wed, 09 Oct 2024
 09:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007035616.2701-3-linux.amoon@gmail.com> <a86437f6-1f62-4f44-bff1-f1203d04edda@stanley.mountain>
 <CANAwSgQObCHr19fmwuc2BfQmoiV3ZgDTFumtfCH8PP_9VbQw+w@mail.gmail.com> <20f261b3-5917-4e3e-96be-7dbb993c5a80@stanley.mountain>
In-Reply-To: <20f261b3-5917-4e3e-96be-7dbb993c5a80@stanley.mountain>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 9 Oct 2024 21:38:16 +0530
Message-ID: <CANAwSgTRWmXbyCO0dOeKSu-C_aXAEVGpzGV8SO-BmouFGiaj+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] phy: rockchip-pcie: Use devm_clk_get_enabled() helper
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Dan,

On Wed, 9 Oct 2024 at 20:19, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Wed, Oct 09, 2024 at 07:59:38PM +0530, Anand Moon wrote:
> > Hi Dan,
> >
> > Thanks for the report.
> >
> > On Wed, 9 Oct 2024 at 17:55, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > >
> > > Hi Anand,
> > >
> > > kernel test robot noticed the following build warnings:
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Anand-Moon/phy-rockchip-pcie-Simplify-error-handling-with-dev_err_probe/20241007-115910
> > > base:   8f602276d3902642fdc3429b548d73c745446601
> > > patch link:    https://lore.kernel.org/r/20241007035616.2701-3-linux.amoon%40gmail.com
> > > patch subject: [PATCH v2 2/3] phy: rockchip-pcie: Use devm_clk_get_enabled() helper
> > > config: loongarch-randconfig-r071-20241009 (https://download.01.org/0day-ci/archive/20241009/202410092019.vGogfPIO-lkp@intel.com/config)
> > > compiler: loongarch64-linux-gcc (GCC) 14.1.0
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > | Closes: https://lore.kernel.org/r/202410092019.vGogfPIO-lkp@intel.com/
> > >
> > > smatch warnings:
> > > drivers/phy/rockchip/phy-rockchip-pcie.c:278 rockchip_pcie_phy_init() warn: missing error code 'err'
> > >
> >
> > All the functions in this file explicitly return 0 instead of err, I
> > will fix this.
> >
> > > vim +/err +278 drivers/phy/rockchip/phy-rockchip-pcie.c
> > >
> > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  269  static int rockchip_pcie_phy_init(struct phy *phy)
> > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  270  {
> > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  271      struct phy_pcie_instance *inst = phy_get_drvdata(phy);
> > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  272      struct rockchip_pcie_phy *rk_phy = to_pcie_phy(inst);
> > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  273      int err = 0;
> > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  274
> > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  275      mutex_lock(&rk_phy->pcie_mutex);
> > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  276
> > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  277      if (rk_phy->init_cnt++)
> > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19 @278              goto err_out;
> > >
> > > Originally, this path just unlocked at returned zero.
> > >
> > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  279
> > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  280      err = reset_control_assert(rk_phy->phy_rst);
> > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  281      if (err) {
> > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  282              dev_err(&phy->dev, "assert phy_rst err %d\n", err);
> > > 3114329651e74f drivers/phy/rockchip/phy-rockchip-pcie.c Anand Moon 2024-10-07  283              goto err_out;
> > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  284      }
> > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  285
> > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  286      mutex_unlock(&rk_phy->pcie_mutex);
> > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  287      return 0;
> > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  288
> > > 3114329651e74f drivers/phy/rockchip/phy-rockchip-pcie.c Anand Moon 2024-10-07  289  err_out:
> > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  290      rk_phy->init_cnt--;
> > >
> > > Now it decrements the counter so presumably it leads to an underflow/use after
> > > free.
> >
> > I was planning to replace the mutex_lock / mutex_unlock
> > with guard(mutex)(&rk_phy->pcie_mutex) in the follow up patch.
> > I will add this in the next revision.
> >
> > >
> > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  291      mutex_unlock(&rk_phy->pcie_mutex);
> > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  292      return err;
> > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  293  }
> > >
> >
>
> Thanks!
>
> > Here are my modified changes on top of my changes for the review process.
> > -----8<----------8<----------8<----------8<----------8<----------8<-----
> > diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c
> > b/drivers/phy/rockchip/phy-rockchip-pcie.c
> > index 2c4d6f68f02a..09685dc3fe17 100644
> > --- a/drivers/phy/rockchip/phy-rockchip-pcie.c
> > +++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
> > @@ -248,20 +248,19 @@ static int rockchip_pcie_phy_init(struct phy *phy)
> >
> >         mutex_lock(&rk_phy->pcie_mutex);
> >
> > -       if (rk_phy->init_cnt++)
> > -               goto err_out;
> > +       if (rk_phy->init_cnt++) {
> > +               mutex_unlock(&rk_phy->pcie_mutex);
> > +               return err;
>
> Please make this a return 0.  It's faster to not have to look up what a variable
> is.
>
Ok.
> > +       }
> >
> >         err = reset_control_assert(rk_phy->phy_rst);
> >         if (err) {
> >                 dev_err(&phy->dev, "assert phy_rst err %d\n", err);
> > -               goto err_out;
> > +               rk_phy->init_cnt--;
> > +               mutex_unlock(&rk_phy->pcie_mutex);
> > +               return err;
> >         }
> >
> > -       mutex_unlock(&rk_phy->pcie_mutex);
> > -       return 0;
> > -
> > -err_out:
> > -       rk_phy->init_cnt--;
> >         mutex_unlock(&rk_phy->pcie_mutex);
> >         return err;
>
> return 0; here too.
>
Ok. I will update the patch.
> regards,
> dan carpenter
>

Thanks
-Anand

