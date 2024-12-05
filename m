Return-Path: <linux-kernel+bounces-432701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8F49E4EF8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419B21881D74
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004D11BD9F6;
	Thu,  5 Dec 2024 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vGAmGiXC"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80981B3927
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733385218; cv=none; b=NoE8HN7h1IoZoEVetQahKamE2TTwR8RXxsvJHcnMbaazrwJP73SrccV2lcziZRmi/myPYaQcKOgRX6T0/IIGkRo2Gut4bdow/6/iWozOZTy8/PC0FWG1ILAK2hfGWRP7byMS1r+geF1ED6BehXST7Kcil+Y2S3/j8b7aaWun2vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733385218; c=relaxed/simple;
	bh=rNLkOrja+fjelYi49mXop/QbH0nhaWqHZi1LrcwdE/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oCHBv5tex4Epx6A8ddOkWZwCmrMa5Bk8Owem+o/Z4l1pmooQjJMuMa8BiRV4+waBG8k00C9xaaFKsU+zfnb526CRqQYYEtvDoE7tQsz7lZNviwMj2+HCjBbbuJ/dtVR9GqdE5wSGa1ElcTXxc+ZDNDxVKF3DgX0b3zhE7OljOI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vGAmGiXC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a044dce2so5993595e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 23:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733385214; x=1733990014; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cw0aKudym1GacjK1kSQ+ayXt2em3H+XIjkba+DLt6j4=;
        b=vGAmGiXCm3MbZdSfaRHQCG9G75bADqtqxKqH0DgnNSAcwkNJaWlVD7XmRJ/64SpboD
         V+LUKjqRBH0cqqUqwBC2LLBNmn1dUjZsDnxI/fbklOw6a3EtQ62/4EYjBMNsVBp8HjSN
         ImGHxk/dDFJ7m2hfPR0gpQomvTZPum0hrDYuuigJ7WTyg9nOlYkj1AEyHB3U2MSgN+5b
         g8G2IbRC5DIbOgZiMXSjeDiK5czqTmEAndE26YUD4iCT0zLNOBx4dRIMcxYgJygOabjQ
         afBoMWX1lGeuKZ9xr3o+XEka4UfIYTuZs1n4sa2mYrAaSbcZmuqeQo1Tdw2hQYxj9nt3
         b4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733385214; x=1733990014;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cw0aKudym1GacjK1kSQ+ayXt2em3H+XIjkba+DLt6j4=;
        b=fVqXJ/wnnJrOVOSo+w1AAG9FbPvWlPK0V6izCtmEYoVsorhr3KFUtaSqNL4mbzCf0Y
         h0nDyHfvlaqVc2fhqb3G7ZAtDM2ZwjpmaFgtvUElNvIDFOFaLCfKn1PnI1EUCcTIfw1X
         2GxF+tEsESz1vN00fPzDfGagtVdNVunPKK+g3as9v6skXB9laKgANepVouwHP+WHVBe2
         ydzYyhf5ciOBr01TA2mAiz1FIwulS362tochjmCN8QnPdvkvqhO/W04n8DbCGbbYgsnO
         BHLHbyQTktdR/srNgumZuDt5Aak9sMDPxMjsdQaF9zlkAlE2zCAQdpnAGMxmC5LziJnw
         suFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIX6SqZJzi7qtn+0az1SeyByBxgDFn3P1RT7Zr/N2P5OuGHwuu3C/LW5Xf2CwqkXboBCTHSCjCqIM7R9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrZIrMCLSggMJIxwHDX0G8iDdQaOGNaZoX7abBUylkEZaqhn3z
	vPgygLr31jJJ0JSs7raHX14L686W/xDWuy1VVJWt25STMEtmL1LB0/w++zlzVm4=
X-Gm-Gg: ASbGnctgZGR1LHQlv5D+yUmZDKEmf7VL3MYC5i1Ok4rGlQC4NgHBHPTMh0SzCS0RVd8
	xGFPm/d1O6H6V8Pn5CjktEjblguV4PA5of5wlYVo13jdObW0OfkeEfYS53itpAFuWMQ4/sYoZLt
	CGhrunkkEigxhCjpoTeJwvRNWNIA/P++Yc9ADHqgimfU2hqSG4QTiaOYwPy0Di18kPPVYYIiUMQ
	inGTG0izxSCk5SKZmaqqd4X4X0CMYgtuwzqWbfQySz3NzZPLPxkz+4=
X-Google-Smtp-Source: AGHT+IHeHx6J40zka1wLL2JkYZnlM+LhLjW9YE2vh1+GWCFVNs50wHfukGoUdRPwrZOGx+bmYNmclw==
X-Received: by 2002:a05:600c:450e:b0:434:a30b:5445 with SMTP id 5b1f17b1804b1-434d09d1cfemr86118705e9.19.1733385214272;
        Wed, 04 Dec 2024 23:53:34 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d6961sm14679745e9.12.2024.12.04.23.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:53:33 -0800 (PST)
Date: Thu, 5 Dec 2024 10:53:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Dave Jiang <dave.jiang@intel.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: drivers/dma/idxd/device.c:370 idxd_cmd_exec() warn: mixing irqsave
 and irq
Message-ID: <0047f184-52c2-4d7c-8f03-425b6f185860@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   feffde684ac29a3b7aec82d2df850fbdbdee55e4
commit: 0d5c10b4c84d6ae6255129e5f16a0d2119c74334 dmaengine: idxd: add work queue drain support
config: x86_64-randconfig-161-20241112 (https://download.01.org/0day-ci/archive/20241205/202412050237.MXIHJMPC-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202412050237.MXIHJMPC-lkp@intel.com/

smatch warnings:
drivers/dma/idxd/device.c:370 idxd_cmd_exec() warn: mixing irqsave and irq

vim +370 drivers/dma/idxd/device.c

0d5c10b4c84d6a Dave Jiang 2020-06-26  357  static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
0d5c10b4c84d6a Dave Jiang 2020-06-26  358  			  u32 *status)
bfe1d56091c1a4 Dave Jiang 2020-01-21  359  {
bfe1d56091c1a4 Dave Jiang 2020-01-21  360  	union idxd_command_reg cmd;
0d5c10b4c84d6a Dave Jiang 2020-06-26  361  	DECLARE_COMPLETION_ONSTACK(done);
0d5c10b4c84d6a Dave Jiang 2020-06-26  362  	unsigned long flags;
bfe1d56091c1a4 Dave Jiang 2020-01-21  363  
bfe1d56091c1a4 Dave Jiang 2020-01-21  364  	memset(&cmd, 0, sizeof(cmd));
bfe1d56091c1a4 Dave Jiang 2020-01-21  365  	cmd.cmd = cmd_code;
bfe1d56091c1a4 Dave Jiang 2020-01-21  366  	cmd.operand = operand;
0d5c10b4c84d6a Dave Jiang 2020-06-26  367  	cmd.int_req = 1;
0d5c10b4c84d6a Dave Jiang 2020-06-26  368  
0d5c10b4c84d6a Dave Jiang 2020-06-26  369  	spin_lock_irqsave(&idxd->dev_lock, flags);
0d5c10b4c84d6a Dave Jiang 2020-06-26 @370  	wait_event_lock_irq(idxd->cmd_waitq,
0d5c10b4c84d6a Dave Jiang 2020-06-26  371  			    !test_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags),
0d5c10b4c84d6a Dave Jiang 2020-06-26  372  			    idxd->dev_lock);

Please understand that these emails complaining about ancient code are
from the zero day bot, not from me.  The issue here is that
using spin_lock_irqsave() implies that perhaps the caller disabled IRQs
but then the wait_event_lock_irq() macro enables IRQs when it is
finished.

0d5c10b4c84d6a Dave Jiang 2020-06-26  373  
bfe1d56091c1a4 Dave Jiang 2020-01-21  374  	dev_dbg(&idxd->pdev->dev, "%s: sending cmd: %#x op: %#x\n",
bfe1d56091c1a4 Dave Jiang 2020-01-21  375  		__func__, cmd_code, operand);
0d5c10b4c84d6a Dave Jiang 2020-06-26  376  
0d5c10b4c84d6a Dave Jiang 2020-06-26  377  	__set_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags);
0d5c10b4c84d6a Dave Jiang 2020-06-26  378  	idxd->cmd_done = &done;
bfe1d56091c1a4 Dave Jiang 2020-01-21  379  	iowrite32(cmd.bits, idxd->reg_base + IDXD_CMD_OFFSET);
bfe1d56091c1a4 Dave Jiang 2020-01-21  380  
0d5c10b4c84d6a Dave Jiang 2020-06-26  381  	/*
0d5c10b4c84d6a Dave Jiang 2020-06-26  382  	 * After command submitted, release lock and go to sleep until
0d5c10b4c84d6a Dave Jiang 2020-06-26  383  	 * the command completes via interrupt.
0d5c10b4c84d6a Dave Jiang 2020-06-26  384  	 */
0d5c10b4c84d6a Dave Jiang 2020-06-26  385  	spin_unlock_irqrestore(&idxd->dev_lock, flags);

This irqrestore sets the IRQs back to whatever they were when the function
was called.

0d5c10b4c84d6a Dave Jiang 2020-06-26  386  	wait_for_completion(&done);
0d5c10b4c84d6a Dave Jiang 2020-06-26  387  	spin_lock_irqsave(&idxd->dev_lock, flags);
0d5c10b4c84d6a Dave Jiang 2020-06-26  388  	if (status)
0d5c10b4c84d6a Dave Jiang 2020-06-26  389  		*status = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
0d5c10b4c84d6a Dave Jiang 2020-06-26  390  	__clear_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags);
0d5c10b4c84d6a Dave Jiang 2020-06-26  391  	/* Wake up other pending commands */
0d5c10b4c84d6a Dave Jiang 2020-06-26  392  	wake_up(&idxd->cmd_waitq);
0d5c10b4c84d6a Dave Jiang 2020-06-26  393  	spin_unlock_irqrestore(&idxd->dev_lock, flags);
bfe1d56091c1a4 Dave Jiang 2020-01-21  394  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


