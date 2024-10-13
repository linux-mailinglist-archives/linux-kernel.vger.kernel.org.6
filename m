Return-Path: <linux-kernel+bounces-362810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7972099B985
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F28281B4E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 13:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A37144D01;
	Sun, 13 Oct 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HKDQQuZH"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B937C13E022
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728825037; cv=none; b=K4QxFO8S+PcKIdVIsOfseOdwpgWOrHMEVw8GCKfYd8sIaQ+QFWgs1llof9uQqjDR1G1/246EsVX7DuDmOoMC2CmkMN43o9KFDGbqUzCOXQfiO4PGUZrimi6uZZaQlk4nL+KNrWWjF7/xR/d8uwsYMrC42dCP986J4/TqPp4j054=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728825037; c=relaxed/simple;
	bh=wzcxfYeSJZjtVidkrKG3NCopsw8G1fnQwrUyijVJnic=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X/wSvgBn/9JF3alhBowDbcP7CtN57KVPJqyt+iu3aZxKm5Jw/PjEVGOO2ZQfnQVAD1KwnLSYsrAF39QjA4lVlho3CpAWyEyOVqpEdKHQ8gW6acKDS11AB7Ro2zN6xKDC+UgMHXcUId2dab8Wmhflh5ITOmNOqXYGlWHN7UHC/jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HKDQQuZH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so157790266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 06:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728825034; x=1729429834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RmhVzZWaYpGgo5jji9BT1Mz/NRT8JqO4PMF3sNeIjU=;
        b=HKDQQuZHokaF4GiSSQg8Q2LJGnczpQ/BLLJjpPh968iRevHuC9SZaHB+cqLX9yQlIK
         me8HU/Z/8Q4Qa2ierFVIesR3vWwJ6+zFQWb5i1WCcXwuOqRg5x28gvCmPFn3yRLISSMd
         HZ5l0MT5vx736ZtuXY+5O8HFtPCVW1zFZavC0YUC1yCQQCcyUyMHPCJqF9LrtbinMxt5
         P+gr3DzE7AHECYnTYQ08P+FGhsguw7/JhRZyXctgbsd+5+Vb8H3lv2r2Jqm9MwSNCGJv
         PquXO7B2+Ws6XAmaGAN47g7Yeu6Ev/kmP/jOthuTMMeilJT27gD8H+jYUXRqsrZx6Knl
         fR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728825034; x=1729429834;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RmhVzZWaYpGgo5jji9BT1Mz/NRT8JqO4PMF3sNeIjU=;
        b=X86sYfZpnS+WuGOhGfYclBXt0FYW6ajboUPzXNSfjsKFGyUk362mTsrgbx2eBHyjeq
         VXzXWIJcAyGj63rjhAEwKHWFXsFPyQOj0MxkYsh1lZKsKIrsi3szlGzCaYrYqfL1JJas
         wIkAwY3QOso69nAPSn8R+K/TOBS/l/BZX0CP9uOvzJcwCxm/CFCLbmnwLojfalqpK+cb
         CobDt2DhnH8dQnfIUd/LHBgfiX8uZAJOUO6sw48PmAdAki5cpp1HyLtNA45Kc0Eh90mm
         P3MjxpY899/CS4bCiIBSRMaiQ5fSRUuPRasARRms6L+nsD5kuUG8S8GALmGUgnBuCv6J
         ZuCA==
X-Forwarded-Encrypted: i=1; AJvYcCWm+JWLI0yobuSNQ45VlXIgGgRzEMeugxnkcaDlVekDSHzKVgaeG2yQ4GE6e2DqXSbhCctLuTbKfjoxogA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTIHa5rhLnuk22lcxW4dB1XE1tD+XHO6ZKdLEUeMjX4UFkIYgt
	lav+Y2lporSpF3ITYlDPXwLTlMvT/Uu7kbmnxGGSjIMTifd1UsKfY+K+33gXSyM=
X-Google-Smtp-Source: AGHT+IERtQg6IrWwPi6EJnDFHtfuz2s3SWelnjet4RDpaSdohjVrKCZ7V7hn4GyBSss6HYvAxTzZcw==
X-Received: by 2002:a17:907:6e89:b0:a9a:a5c:e23b with SMTP id a640c23a62f3a-a9a0a5ce2d0mr88319266b.58.1728825034159;
        Sun, 13 Oct 2024 06:10:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80cb013sm444649666b.131.2024.10.13.06.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 06:10:33 -0700 (PDT)
Date: Sun, 13 Oct 2024 16:10:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: drivers/net/wireless/st/cw1200/cw1200_spi.c:440
 cw1200_spi_disconnect() error: we previously assumed 'self' could be null
 (see line 433)
Message-ID: <72b5769f-c9f3-44c0-812a-0ba0c6e8176b@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   09f6b0c8904bfaa1e0601bc102e1b6aa6de8c98f
commit: 2719a9e7156c4b3983b43db467c1ff96801bda99 wifi: cw1200: Convert to GPIO descriptors
date:   8 months ago
config: x86_64-randconfig-161-20241012 (https://download.01.org/0day-ci/archive/20241012/202410121505.nyghqEkK-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202410121505.nyghqEkK-lkp@intel.com/

smatch warnings:
drivers/net/wireless/st/cw1200/cw1200_spi.c:440 cw1200_spi_disconnect() error: we previously assumed 'self' could be null (see line 433)

vim +/self +440 drivers/net/wireless/st/cw1200/cw1200_spi.c

a0386bba70934d drivers/net/wireless/st/cw1200/cw1200_spi.c Uwe Kleine-König 2022-01-23  429  static void cw1200_spi_disconnect(struct spi_device *func)
a910e4a94f6923 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-05-24  430  {
911373cca1b455 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-06-01  431  	struct hwbus_priv *self = spi_get_drvdata(func);
a910e4a94f6923 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-05-24  432  
a910e4a94f6923 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-05-24 @433  	if (self) {
                                                                                                    ^^^^
If self is NULL

a910e4a94f6923 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-05-24  434  		cw1200_spi_irq_unsubscribe(self);
a910e4a94f6923 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-05-24  435  		if (self->core) {
a910e4a94f6923 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-05-24  436  			cw1200_core_release(self->core);
a910e4a94f6923 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-05-24  437  			self->core = NULL;
a910e4a94f6923 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-05-24  438  		}
a910e4a94f6923 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-05-24  439  	}
2719a9e7156c4b drivers/net/wireless/st/cw1200/cw1200_spi.c Linus Walleij    2024-01-31 @440  	cw1200_spi_off(self, dev_get_platdata(&func->dev));
                                                                                                               ^^^^
This will oops

a910e4a94f6923 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-05-24  441  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


