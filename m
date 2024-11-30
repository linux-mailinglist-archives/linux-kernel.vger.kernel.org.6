Return-Path: <linux-kernel+bounces-426336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12119DF1DF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB8428186A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EB31A0BE3;
	Sat, 30 Nov 2024 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DoFdFvq0"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7AC19E965
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732982071; cv=none; b=NG1xzq26e40sXE+oTA/mWPHPf4Zi/gsjwsl+cbyR0BXrMX/D2zuB+vevlYQoFqsUx9BdMkEWcnwhqDoXKnVsMo6BEDbhPjCwTz9Ra7FXIgBYOQ9sNUlDDIEOAs0N4tNXvXrIi0ZmSulwH0+THCAj6n9qd7Lcu73qdr9+zD6m5zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732982071; c=relaxed/simple;
	bh=fPINurpBvzEOEixbYbqSeiiaOJB6aUyizq1CxAy61Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VuwX/yFrc3k9zXimuowICf3mPs93DGhEwI/DYJ8Sa8uSBevicplofJwLQ4wJv1nb53XuUoCdc7OUSLcTXb/NtCWhmLOg9zJ9uWjFeCdIQkyMCYaZc/IOYoSuwb3GEto8nhIDaWXxUZv6wFakLCRZk26BwEVvOPHeeU5ZUfiCrCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DoFdFvq0; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so153426966b.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 07:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732982067; x=1733586867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKwWzGZlj30zR5uG3r8pc5O9AbO9pAuOvOctXvF3moE=;
        b=DoFdFvq0M++zQ6j71DHo6naZ9ZjviuLzpmJsZlvIfro2236RWE6zFJKuhnXi5WCEVW
         lup4VoVkGxH+DttHwVRr5WsHz3otivzS3wvg2HPhBFhBPaC78g88GUDkiLw0KuOGnj5K
         xuWtuLs7nk6b+vny+0Di+f96Ag/jKl+O1UTJc/eHEVF6EmYRx2R6HZ6rBG7te4DUYNMR
         pOBqH8P8Ll6usVQj2I1W4xgGGMsoNX/jnmCk53JUUeYWLQF5zwjR3hqw3UDqOGwxJvg0
         mmNliH5EGDvX/3Hfz4TFxa6o8CornIZ/U4479gYpVkh0fYMRnfcu2a/Qsb9Z11PbK5Bw
         uZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732982067; x=1733586867;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKwWzGZlj30zR5uG3r8pc5O9AbO9pAuOvOctXvF3moE=;
        b=NUVR8St2mHj0LNuoAzgEomlBUUo+b3IaR54xsXzqoMS6dkHyRKN/TD+T6o4spJJoM5
         IBPo0fbQjT12YQ0tM0Tqile3k6RdjmqeVXsLatqiUUTrDctQIaTJaPaixMrbnXI+catv
         gKKt3cgGhJ5GNVpbpuXjmjU38S2uF5kj2E7YrMu7EddgMFs5ix9I6QvkM6gRQym7jvev
         HlwQ9hXU1l3tuY2ZSJk8d9oW32oe42Z/xEcAr2i6s5eTZFt8Cl71By1U95scUO6u9DL9
         qjeR5E3OmoJ04yqP2R7KFOFvT0f+mqyfGmKrQqMfvYXxlZLkAl1ccmrBI/bgcei4Dn9x
         eLdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWH1arWqfYR2EITZI/9B8y82xP9yxDB9b2RgL8jsK7Rv0P+GuQIPNmtIzFzwBXy5xxa8gWcj3vHL5LEYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7KBa8eHOH5/TnR87T1thzvha7rRM1EuS4BuiTDG9yleqEvI/d
	anoLW7I1OjyejzDl0iYBKsgmj8iTgi+zsgLpn/aczCQVtrrVOe5HJaMgdNqtsgs=
X-Gm-Gg: ASbGncujsXqnM4bvmry+7gKRXRRGYPhbWpwVMR1EAQ/z1K3bZZTHo9AdNCBb8Gzsq9x
	sdAHDKqhyz549OuBxvhcUpAFQfbotM0uHmpZtIaqCqqXGLwjT0xR6FTu0cdTLhtGhCWwc1XcLxs
	Wt8qSaImbQAjQSw59UEOQz+IaYQvEOoQ1oDZn4H85oAzg3xUweTukicJqLWAyEe8SywODykRn0+
	QHsY/LNa2VUxR6YLkMuwQRiOplcsfmUPEz1nK+qEyE4KpdYXMXtYAFDY+TL9rz9pGRLEMYB
X-Google-Smtp-Source: AGHT+IHBkIAuWmfbDNtg/9ztOOmya2ShVS9Hw3bM4eNoJLWIM5eK9WriL+fLJVTbXc07AX+5qZtP9g==
X-Received: by 2002:a05:6402:42c3:b0:5d0:96db:dd97 with SMTP id 4fb4d7f45d1cf-5d096dbe5a8mr13940585a12.10.1732982067548;
        Sat, 30 Nov 2024 07:54:27 -0800 (PST)
Received: from localhost (h1109.n1.ips.mtn.co.ug. [41.210.145.9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0c6a8e9b0sm1062632a12.41.2024.11.30.07.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 07:54:27 -0800 (PST)
Date: Sat, 30 Nov 2024 18:54:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: drivers/net/wireless/st/cw1200/cw1200_spi.c:440
 cw1200_spi_disconnect() error: we previously assumed 'self' could be null
 (see line 433)
Message-ID: <72e9e3bb-e96a-445a-8c31-8505f3a4ffaa@stanley.mountain>
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
head:   aaf20f870da056752f6386693cc0d8e25421ef35
commit: 2719a9e7156c4b3983b43db467c1ff96801bda99 wifi: cw1200: Convert to GPIO descriptors
config: riscv-randconfig-r073-20241111 (https://download.01.org/0day-ci/archive/20241127/202411271742.Xa7CNVh1-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202411271742.Xa7CNVh1-lkp@intel.com/

smatch warnings:
drivers/net/wireless/st/cw1200/cw1200_spi.c:440 cw1200_spi_disconnect() error: we previously assumed 'self' could be null (see line 433)

vim +/self +440 drivers/net/wireless/st/cw1200/cw1200_spi.c

a0386bba70934d drivers/net/wireless/st/cw1200/cw1200_spi.c Uwe Kleine-König 2022-01-23  429  static void cw1200_spi_disconnect(struct spi_device *func)
a910e4a94f6923 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-05-24  430  {
911373cca1b455 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-06-01  431  	struct hwbus_priv *self = spi_get_drvdata(func);
a910e4a94f6923 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-05-24  432  
a910e4a94f6923 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-05-24 @433  	if (self) {

Check for NULL

a910e4a94f6923 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-05-24  434  		cw1200_spi_irq_unsubscribe(self);
a910e4a94f6923 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-05-24  435  		if (self->core) {
a910e4a94f6923 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-05-24  436  			cw1200_core_release(self->core);
a910e4a94f6923 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-05-24  437  			self->core = NULL;
a910e4a94f6923 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-05-24  438  		}
a910e4a94f6923 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-05-24  439  	}
2719a9e7156c4b drivers/net/wireless/st/cw1200/cw1200_spi.c Linus Walleij    2024-01-31 @440  	cw1200_spi_off(self, dev_get_platdata(&func->dev));
                                                                                                               ^^^^
Unchecked dereference

a910e4a94f6923 drivers/net/wireless/cw1200/cw1200_spi.c    Solomon Peachy   2013-05-24  441  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


