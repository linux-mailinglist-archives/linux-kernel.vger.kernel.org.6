Return-Path: <linux-kernel+bounces-357218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E217996DCC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88FD41F219FD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3DE19CC28;
	Wed,  9 Oct 2024 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnLHcQlu"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5D41A2562
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484197; cv=none; b=WV4QVe2oxI1mraQcylBZY7wPFyqypIWZbMww+n4+aHAvpGohlLpbu1qFB16Hcr7Pdr6CmWIDajujN8sGHz/STLyM8tf6UYbmS8bhzvrHtQdHLMRXM9VbzIuOVunscGbS6bOSCGvLTXCQVdRF26L2UY3A/OfaD0NRLiTCRQksjko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484197; c=relaxed/simple;
	bh=6rg8fudV2HDi1NEoULsMUGCnazkZy5kFAgN4WeYPYbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUwndNOfUwn7Mslmf/DVhtEQ8bFZPZSQQL4sVkp20Bjy4amjTaf7YbNBD9vkfGYqBJzh5uRrk5Sf404jul3Ag21wJnKnrHe9ZHPdiqlbfJ6Ozm2g7i9g0it4QDPqRsPVhw0EqlP/VYvzIunY5vE8RsGIcSmP8kxzuHJI1rYi0Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnLHcQlu; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5e800d4e47dso769699eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728484195; x=1729088995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1HJ5l2YJxm3O72neDz3rx650xEJBhAU/4equGAO1fYw=;
        b=VnLHcQluLuEC1YhygaVznuCTqL7K4Q534f8mhX+hptUqmojq59x4MjfVO3IpQX9m93
         opg93Hr31fhvyjbjPI/FtWXBjyZofFsqjeZyhfvfmokfZqTh7ZklLBVQaTcIFasxCJOW
         ItlYw43ojYbbRpcg4xVoCLboEly7nwsnus6B/4LB6SD/McA/g0GV95+VXLKsYxA5R1aX
         uQKl9l0QF+pVeEtDXoBsjU1BphOjEKU5ZY9jNARF1gfPCDHQqroAHYbSDqps7KzCpjlI
         krFW2T5jQA38TdWWok7lyvV1MeBjBdlHdzuegwPPm2r6nt2UQmATrBHG5y/EFTUhuLuU
         SG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728484195; x=1729088995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1HJ5l2YJxm3O72neDz3rx650xEJBhAU/4equGAO1fYw=;
        b=SVeb4gthEtpoDs9PgvEFWoGXsIhZERDERN5uOeIwOTL/wji5jWbMCSRkp1ZhRX5Hzb
         AKWsWME1OXHIJBGSExw7xLfUujV3nDuoXUKzT8IJeHUsbbKQ9eLKFI36WfiiNfdhpDhA
         czW+WIlX/IJFlysBN5lyTmndqMvkoM7x2jd+AOI6ciYY/ufBqH+cFahAQZFCpaK7XGb1
         HCS6BP1BFoODBxKY8Ivi8gDXEaOZXKfryO+x2tj4uUd5GjvvREjE6MXG6GEdM0/by4ZW
         AHRUJNFLiY6B4mliFMQ26POxfavy4M3Tign6O0u+qYvxABOiN8Dr6qLkdDsn4MVJbmS0
         c2Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXHpbmkJgIGEPsa19ojiVa8JmcJiXOj+5CDK9ig5qI5xKqapWWe+mj9XYoVuJEE+J9S+TWuv//uLk2gYTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNOHVcKtU7Xd78Q8ne5LbxHBSbiyVZATywXth5YlVXMsq7evxp
	sACgoYph/SBwpuTBvhJ0OC3H47qwz0vFVnoSYVv6rpaAtPUB2cAmmcA79fZlJ8uDfKpltvnnsZA
	x5f9Rsz+Ri/e1f5Y2gjSbrCvNkfM=
X-Google-Smtp-Source: AGHT+IHOrvLRQI0/DuijimlqP0nw80CW8kMD/I1XWLU6FBTX4UZBqAZ7fjEFo17vF1pCXjI4KLjeFyqN7tzpy6H2yAQ=
X-Received: by 2002:a05:6820:308c:b0:5e8:4dd:46cb with SMTP id
 006d021491bc7-5e987b8b2c2mr1453420eaf.8.1728484195021; Wed, 09 Oct 2024
 07:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007035616.2701-3-linux.amoon@gmail.com> <a86437f6-1f62-4f44-bff1-f1203d04edda@stanley.mountain>
In-Reply-To: <a86437f6-1f62-4f44-bff1-f1203d04edda@stanley.mountain>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 9 Oct 2024 19:59:38 +0530
Message-ID: <CANAwSgQObCHr19fmwuc2BfQmoiV3ZgDTFumtfCH8PP_9VbQw+w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] phy: rockchip-pcie: Use devm_clk_get_enabled() helper
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Dan,

Thanks for the report.

On Wed, 9 Oct 2024 at 17:55, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> Hi Anand,
>
> kernel test robot noticed the following build warnings:
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Anand-Moon/phy-rockchip-pcie-Simplify-error-handling-with-dev_err_probe/20241007-115910
> base:   8f602276d3902642fdc3429b548d73c745446601
> patch link:    https://lore.kernel.org/r/20241007035616.2701-3-linux.amoon%40gmail.com
> patch subject: [PATCH v2 2/3] phy: rockchip-pcie: Use devm_clk_get_enabled() helper
> config: loongarch-randconfig-r071-20241009 (https://download.01.org/0day-ci/archive/20241009/202410092019.vGogfPIO-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 14.1.0
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202410092019.vGogfPIO-lkp@intel.com/
>
> smatch warnings:
> drivers/phy/rockchip/phy-rockchip-pcie.c:278 rockchip_pcie_phy_init() warn: missing error code 'err'
>

All the functions in this file explicitly return 0 instead of err, I
will fix this.

> vim +/err +278 drivers/phy/rockchip/phy-rockchip-pcie.c
>
> fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  269  static int rockchip_pcie_phy_init(struct phy *phy)
> fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  270  {
> 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  271      struct phy_pcie_instance *inst = phy_get_drvdata(phy);
> 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  272      struct rockchip_pcie_phy *rk_phy = to_pcie_phy(inst);
> fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  273      int err = 0;
> fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  274
> 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  275      mutex_lock(&rk_phy->pcie_mutex);
> 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  276
> 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  277      if (rk_phy->init_cnt++)
> 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19 @278              goto err_out;
>
> Originally, this path just unlocked at returned zero.
>
> 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  279
> fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  280      err = reset_control_assert(rk_phy->phy_rst);
> fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  281      if (err) {
> fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  282              dev_err(&phy->dev, "assert phy_rst err %d\n", err);
> 3114329651e74f drivers/phy/rockchip/phy-rockchip-pcie.c Anand Moon 2024-10-07  283              goto err_out;
> fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  284      }
> fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  285
> 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  286      mutex_unlock(&rk_phy->pcie_mutex);
> 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  287      return 0;
> fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  288
> 3114329651e74f drivers/phy/rockchip/phy-rockchip-pcie.c Anand Moon 2024-10-07  289  err_out:
> 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  290      rk_phy->init_cnt--;
>
> Now it decrements the counter so presumably it leads to an underflow/use after
> free.

I was planning to replace the mutex_lock / mutex_unlock
with guard(mutex)(&rk_phy->pcie_mutex) in the follow up patch.
I will add this in the next revision.

>
> 90a7612d070d5c drivers/phy/rockchip/phy-rockchip-pcie.c Shawn Lin  2017-07-19  291      mutex_unlock(&rk_phy->pcie_mutex);
> fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  292      return err;
> fcffee3d54fcad drivers/phy/phy-rockchip-pcie.c          Shawn Lin  2016-09-01  293  }
>

Here are my modified changes on top of my changes for the review process.
-----8<----------8<----------8<----------8<----------8<----------8<-----
diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c
b/drivers/phy/rockchip/phy-rockchip-pcie.c
index 2c4d6f68f02a..09685dc3fe17 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -248,20 +248,19 @@ static int rockchip_pcie_phy_init(struct phy *phy)

        mutex_lock(&rk_phy->pcie_mutex);

-       if (rk_phy->init_cnt++)
-               goto err_out;
+       if (rk_phy->init_cnt++) {
+               mutex_unlock(&rk_phy->pcie_mutex);
+               return err;
+       }

        err = reset_control_assert(rk_phy->phy_rst);
        if (err) {
                dev_err(&phy->dev, "assert phy_rst err %d\n", err);
-               goto err_out;
+               rk_phy->init_cnt--;
+               mutex_unlock(&rk_phy->pcie_mutex);
+               return err;
        }

-       mutex_unlock(&rk_phy->pcie_mutex);
-       return 0;
-
-err_out:
-       rk_phy->init_cnt--;
        mutex_unlock(&rk_phy->pcie_mutex);
        return err;
 }

Thanks
-Anand

