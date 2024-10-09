Return-Path: <linux-kernel+bounces-357563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC6C997298
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DE91F22FB4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C301B19D098;
	Wed,  9 Oct 2024 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcLAB44+"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8521822F8
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493455; cv=none; b=iteByBFxdTp9wI5/WQgWoLoBXYFMVfJAf5HQqKqyDfdYYhtVw3cy4lJ2O3MeOOL1QagMZjZemQEkR821ukv318K/UOssb9HyfNHRojk4n4hot4zMVW8nDZcmFtDFxIMxy+fLgxmCWC9clf1xXpleMInJLW6F9Eiz31u1TKieVMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493455; c=relaxed/simple;
	bh=GpAZrRGB56bFCpj2C99KdaRD//Z7XPl20beSs+QjVfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKQyAiSp5DbkCMf6jo3/cf8ESFd3NX2BwULRTeRV9CAtkpCdn2ekkjqsDIxgFwGxhC1Ml+O2JxB76bhye0USu3MkYHei3OK7EDg6GGlpA60ikOp0yk+82Au+SrjLTElLRmUhLwg48SVeSO04vHe5DYf7UIgFMWeNBf96hacey1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcLAB44+; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53997328633so9659997e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 10:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728493451; x=1729098251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bAgrg9p0IyL/cHjq8NFMqrg11vbFoHJhejVSOZpWnuI=;
        b=IcLAB44+YZUUIA+3DM6JFNukVAxUDnAapXWCxpShkQpRopYIjtAhV5zu2L/ATceGNS
         15xlWrMnsV7wIDgcNpsLx5UpEmWByZtQ+Yzb9F8OHaC4Nlszr/0o4nAE+374h6XX5yB7
         XOlqxxv7vGc8dLsUZYnh1uN2u2eCQvCnVUHzm2FboBb1lwbdhFmW9PZ8p4HyWyYt81NQ
         FOxkdSfZWZW9JE4yld5Uc6E3HwO0w1GxdkQtnc7lGqEgBlg4/OIb8GrIjaK76sR5mIvD
         Y9GSA4olvPukb5qg57KWAh5N75mLACG3yVZP63EXUqPmSekiJDexDzbqwKBfnzp3iwDT
         RwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728493451; x=1729098251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAgrg9p0IyL/cHjq8NFMqrg11vbFoHJhejVSOZpWnuI=;
        b=v8paAAMR/5MXacBsoOyy9wrHMfA0hOCXPDtcZgsa63AotkQlKdI79MZYVclNQVqVUY
         t6U2BR826k9FAAwe/DVdgN10WdM+tUKrs4GV1i3PViTKQLN5SRhexGS5Urseox1eQaiI
         puKs3cScb2h3jPZZT6ee2n7f8gVTOx8X6uAdmeOj9bzl4X0cIwdjU1jrMZyTzkwdIbia
         1lw3n3DUdDiIJrEvkot/h3B+Stv1IpmQu938uKwW+fYEhSWWJCL8R40u/JZ6nPnrO7pa
         +G4FsAxvkFQWrMIke9G+f/adXddxl2aRAraU0v03vGPHtwnx5SOWzsNYIL3zoVwGU1QN
         +jlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzRHwJiLPU3PjwPfVwZiVuWpy6tjfhTRZD6Tw7XKL5ORuBDHsmgehjUQiqjm+l/d2lO42yGbUS+IWnqAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv8xgPMhfhgaJcUUEj8v6XRzhIF9FSt31epYB3u20x5vm8ddhV
	HrqHgeOH0/epxQrABrbKLdyfVsVxtQ9RODy7H55KOfHt6jnExmP/XZ1ZXcmlcPWn+WYGyEbTycr
	8+uB0pxZm7sWUNTulVBpWlk9jI7A=
X-Google-Smtp-Source: AGHT+IH/I2srRvV6OFd9jUWGGQC2LsJXZB49Gad0HgloebLrdtnJxijWTQhwoBydGy2Ta8YUkJfwrY1JaK6EnGhfYQY=
X-Received: by 2002:a05:6512:3da6:b0:539:936c:9845 with SMTP id
 2adb3069b0e04-539c4957e39mr3243843e87.37.1728493451037; Wed, 09 Oct 2024
 10:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007035616.2701-3-linux.amoon@gmail.com> <a86437f6-1f62-4f44-bff1-f1203d04edda@stanley.mountain>
 <CANAwSgQObCHr19fmwuc2BfQmoiV3ZgDTFumtfCH8PP_9VbQw+w@mail.gmail.com>
 <20f261b3-5917-4e3e-96be-7dbb993c5a80@stanley.mountain> <CANAwSgTRWmXbyCO0dOeKSu-C_aXAEVGpzGV8SO-BmouFGiaj+g@mail.gmail.com>
In-Reply-To: <CANAwSgTRWmXbyCO0dOeKSu-C_aXAEVGpzGV8SO-BmouFGiaj+g@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 9 Oct 2024 22:33:51 +0530
Message-ID: <CANAwSgROrML0zW-G0aPh6qsdCodOv+7pE8hhaSA4ismJP4G=6g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] phy: rockchip-pcie: Use devm_clk_get_enabled() helper
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Dan,

On Wed, 9 Oct 2024 at 21:38, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Dan,
>
> On Wed, 9 Oct 2024 at 20:19, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > On Wed, Oct 09, 2024 at 07:59:38PM +0530, Anand Moon wrote:
> > > Hi Dan,
> > >
> > > Thanks for the report.
> > >
> > > On Wed, 9 Oct 2024 at 17:55, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > > >
> > > > Hi Anand,
> > > >
> > > > kernel test robot noticed the following build warnings:
> > > >
> > > > url:    https://github.com/intel-lab-lkp/linux/commits/Anand-Moon/phy-rockchip-pcie-Simplify-error-handling-with-dev_err_probe/20241007-115910
> > > > base:   8f602276d3902642fdc3429b548d73c745446601
> > > > patch link:    https://lore.kernel.org/r/20241007035616.2701-3-linux.amoon%40gmail.com
> > > > patch subject: [PATCH v2 2/3] phy: rockchip-pcie: Use devm_clk_get_enabled() helper
> > > > config: loongarch-randconfig-r071-20241009 (https://download.01.org/0day-ci/archive/20241009/202410092019.vGogfPIO-lkp@intel.com/config)
> > > > compiler: loongarch64-linux-gcc (GCC) 14.1.0
> > > >
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > | Closes: https://lore.kernel.org/r/202410092019.vGogfPIO-lkp@intel.com/
> > > >
> > > > smatch warnings:
> > > > drivers/phy/rockchip/phy-rockchip-pcie.c:278 rockchip_pcie_phy_init() warn: missing error code 'err'
> > > >
> > >
> > > All the functions in this file explicitly return 0 instead of err, I
> > > will fix this.
> > >
> > > > vim +/err +278 drivers/phy/rockchip/phy-rockchip-pcie.c
> > > >
> > > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  269  static int rockchip_pcie_phy_init(struct phy *phy)
> > > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  270  {
> > > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  271      struct phy_pcie_instance *inst = phy_get_drvdata(phy);
> > > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  272      struct rockchip_pcie_phy *rk_phy = to_pcie_phy(inst);
> > > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  273      int err = 0;
> > > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  274
> > > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  275      mutex_lock(&rk_phy->pcie_mutex);
> > > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  276
> > > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  277      if (rk_phy->init_cnt++)
> > > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19 @278              goto err_out;
> > > >
> > > > Originally, this path just unlocked at returned zero.
> > > >
> > > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  279
> > > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  280      err = reset_control_assert(rk_phy->phy_rst);
> > > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  281      if (err) {
> > > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  282              dev_err(&phy->dev, "assert phy_rst err %d\n", err);
> > > > 3114329651e74f drivers/phy/rockchip/phy-rockchip-pcie.c Anand Moon 2024-10-07  283              goto err_out;
> > > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  284      }
> > > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  285
> > > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  286      mutex_unlock(&rk_phy->pcie_mutex);
> > > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  287      return 0;
> > > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  288
> > > > 3114329651e74f drivers/phy/rockchip/phy-rockchip-pcie.c Anand Moon 2024-10-07  289  err_out:
> > > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  290      rk_phy->init_cnt--;
> > > >
> > > > Now it decrements the counter so presumably it leads to an underflow/use after
> > > > free.
> > >
> > > I was planning to replace the mutex_lock / mutex_unlock
> > > with guard(mutex)(&rk_phy->pcie_mutex) in the follow up patch.
> > > I will add this in the next revision.
> > >
> > > >
> > > > 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  291      mutex_unlock(&rk_phy->pcie_mutex);
> > > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  292      return err;
> > > > fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  293  }
> > > >
> > >
> >
> > Thanks!
> >
> > > Here are my modified changes on top of my changes for the review process.
> > > -----8<----------8<----------8<----------8<----------8<----------8<-----
> > > diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c
> > > b/drivers/phy/rockchip/phy-rockchip-pcie.c
> > > index 2c4d6f68f02a..09685dc3fe17 100644
> > > --- a/drivers/phy/rockchip/phy-rockchip-pcie.c
> > > +++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
> > > @@ -248,20 +248,19 @@ static int rockchip_pcie_phy_init(struct phy *phy)
> > >
> > >         mutex_lock(&rk_phy->pcie_mutex);
> > >
> > > -       if (rk_phy->init_cnt++)
> > > -               goto err_out;
> > > +       if (rk_phy->init_cnt++) {
> > > +               mutex_unlock(&rk_phy->pcie_mutex);
> > > +               return err;
> >
> > Please make this a return 0.  It's faster to not have to look up what a variable
> > is.
> >
> Ok.
> > > +       }
> > >
> > >         err = reset_control_assert(rk_phy->phy_rst);
> > >         if (err) {
> > >                 dev_err(&phy->dev, "assert phy_rst err %d\n", err);
> > > -               goto err_out;
> > > +               rk_phy->init_cnt--;
> > > +               mutex_unlock(&rk_phy->pcie_mutex);
> > > +               return err;
> > >         }
> > >
> > > -       mutex_unlock(&rk_phy->pcie_mutex);
> > > -       return 0;
> > > -
> > > -err_out:
> > > -       rk_phy->init_cnt--;
> > >         mutex_unlock(&rk_phy->pcie_mutex);
> > >         return err;
> >
> > return 0; here too.
The above warning " missing error code 'err'"
so it's correct to return err. here.
> >
> Ok. I will update the patch.
> > regards,
> > dan carpenter
> >
>
Thanks
-Anand

