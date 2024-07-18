Return-Path: <linux-kernel+bounces-256846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32179937130
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E811B21D9E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DBF146D6F;
	Thu, 18 Jul 2024 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lQKtL87Y"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7774C145FF9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721346209; cv=none; b=uVZ64PKTRgWJGqEsMVUtBvcjviXOZC3/Df2re3F3e9pz/2E5bA+ES/rSk+1ozfJvdosVnJ7e6UefxLS8XbvPjRdC6EyiaieUtpNe5ydbUrIAbA8sjB5xBD7X3+qPIM00baAOAXxcdTljiQjblyNzsKWPJRC+LRzN0np2L3v5C5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721346209; c=relaxed/simple;
	bh=Fs8BMs6N/B/fxf7s4SP/Ab68hcA0mRBxxocOljHPwzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qNGJKCNXDHPY1HSKTxWwlqGSRXkzvG2EwF4PfpYDhaxzkocihool2ZCexH4faf6q6SrvySPlsTf+s/T+uv+ibDagsQ+F4HTIhdiFgx1RmtxQHrTfP7q9nH8Odcj/gUDO4WBL/fvbp0cJivU5fG83BlgTTfykJ5XRqclMd53J/Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lQKtL87Y; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ea929ea56so1856849e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 16:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721346204; x=1721951004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2G6Wi/ghJW7ne1nL1LZ4kJtoZ1WxIyqIm9N6B8fvRMM=;
        b=lQKtL87YSjKAeWJ1Izcu8bBm0eHgThAiDHJcf8CN2ZbTsHVPDXW01gQmeiHMCOiVqL
         OZ4FSrx4M/V6gs79tp6CuxvIym3tI5xCSuplS4BC84wztNJA4u6zeg/k3kRvdP0nG7Z9
         kgUAPlhY5JHAb1KRDa75jjg5Z0KFNneYo3GsNVXsV4MaUI6mLyayQJIXWzy1CHrDxakh
         I+uN1Mijv1p+oeT5/76XeTxjnYHYW3LcLSl39H/Qy14EhIIXKyiniQ2O9U4IDmvQxVBm
         w4PSV5nEVux4/uUenuUt6RDVQCWraWtJwhRbPlF2YUMlwAO7Sy6TbecPhDdh6UHemjVe
         znOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721346204; x=1721951004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2G6Wi/ghJW7ne1nL1LZ4kJtoZ1WxIyqIm9N6B8fvRMM=;
        b=EynJoTZhW/cwUy5Um8C4+BRUcxTZMBg8Yt3eRuRVhozqRxw65rPuh7sjreCd4Xvm9A
         vw9irj/0StLOya0h0+rwnN0ArEfXKsups/Ss4lMuycrZR4WSuOT3gJxhUjVGXTptuK5b
         +z3GtBzfJyUE8HZoAacaewnutIKv2e9Mrzoh8nXo770pm+C5NKZ2CAmA4wAPszFP5fP5
         R3AxBqggnJHyf66MxfoLJnjTMlEmxbERHE3CjcV8KmrH4T47jT7crpA2fGbWwBiHlHOU
         kexSu5nth4dorU3neGGntonBmKCG3DzojxZGhPxa48UAcmPGAUbQmuqMHQvEcqUgGF9x
         o+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS9UEeiHDX/NRH3+HLgGE2DllMT+4cMmyYHbk1k9V9NqJX5n4i87pivaM5MhTA0vfsnN5YzLgvPW4AQcvbj+mwMDjLd2bzFUCE8G1K
X-Gm-Message-State: AOJu0YzrTcEkBHlpDJSIgtEEPOSeSfykUw932Kh4D6Fzz1ENbviCKMPV
	y1rk3pP9rZU9dENPZSQWTxLLc9U7AePbyUYV0KYQri5ymasM7vP1zhOUxh5dK3k=
X-Google-Smtp-Source: AGHT+IF+UwNsOHX2ZzNai2nhy5hTeg1HLABZ8GOiwqfPygMYjAAPG1DIHy5+fJSGlK3pIRK+hwampg==
X-Received: by 2002:a05:6512:3055:b0:52c:df83:a740 with SMTP id 2adb3069b0e04-52ee53d7630mr5487536e87.30.1721346204544;
        Thu, 18 Jul 2024 16:43:24 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef556b4fbsm22491e87.139.2024.07.18.16.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 16:43:24 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] OPP/pmdomain: Assign required_devs for required OPPs through genpd
Date: Fri, 19 Jul 2024 01:43:13 +0200
Message-Id: <20240718234319.356451-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Through dev_pm_opp_set_config() the _opp_attach_genpd() allows consumer drivers
to hook up a device to its PM domains. Their corresponding virtual devices that
are created by genpd during attach, are later being assigned as the
required_devs for the corresponding required OPPs.

In _opp_attach_genpd() we are also cross-checking whether the attached device's
required OPPs really belongs to its PM domain's OPP table - and tries to fix it
up if possible. In principle this works fine, but sometimes it's not convenient
for consumer drivers to use _opp_attach_genpd().  Especially in the single PM
domain case, when a device is usually attached by the bus-level ->probe()
callbacks.

Moreover, we now have dev_pm_domain_attach|detach_list() that helps consumer
drivers to attach their devices to their PM domains.

To improve the situation, this series moves genpd to assign the required_devs
during device attach in genpd, which makes the cross-check of the OPP table to
always get done.

Note that, we still need to support the existing users of _opp_attach_genpd(),
which makes this series slightly complicated. Once we have migrated those users
to dev_pm_domain_attach|detach_list(), we should be able to remove
_opp_attach_genpd() altogether.

To test this, I have used a QEMU setup, with local PM test-drivers to try to
test all various combinations of single/multi power/performance PM domains for
a device. Hopefully I have covered it all, but I would certainly appreciate if
someone could help to run a slew of tests on some HWs.

Kind regards
Ulf Hansson

Ulf Hansson (6):
  OPP: Fix support for required OPPs for multiple PM domains
  OPP: Rework _set_required_devs() to manage a single device per call
  pmdomain: core: Manage the default required OPP from a separate
    function
  OPP/pmdomain: Set the required_dev for a required OPP during genpd
    attach
  pmdomain: core: Drop the redundant dev_to_genpd_dev()
  OPP: Drop redundant code in _link_required_opps()

 drivers/opp/core.c        | 182 ++++++++++++++++++--------------------
 drivers/opp/of.c          |  39 +-------
 drivers/opp/opp.h         |   4 +-
 drivers/pmdomain/core.c   | 107 +++++++++++++++++-----
 include/linux/pm_domain.h |   6 --
 include/linux/pm_opp.h    |  10 ++-
 6 files changed, 183 insertions(+), 165 deletions(-)

-- 
2.34.1


