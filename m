Return-Path: <linux-kernel+bounces-221169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBD590EFB7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21FA7282B26
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB2A150984;
	Wed, 19 Jun 2024 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q9VE0pQM"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488041DFCF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806148; cv=none; b=GgbT3/hR6wR5AEbXVrGeEaPnjBe0KXKQNjjGduEGgXeAtjam+Qij2aLfcE4YDzMvcl0OWtQeS6TXc462ge1O//GDH0N2rA2Akpm3fSBau+VvSAMUzDgVPL8k36Jf6c/VBUDi1Fs6tmp54XGigbOsyjJ1xGr7TY/esNnsg27J+dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806148; c=relaxed/simple;
	bh=xxBk4Vi2ofgvIr6TnMk1h9bALTrj2WDTbCiUrt1MBl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k1Xt9tcJ3pt8re1oPn5sHuKRzwSZEPsZmdch0K1zlN+Mt0lkKtvtEuBbbhva1svZCaafY14Q+XgxDY3o8f61VFHqpk7Z2TLcJQYVPZ8APisXpm3HIQk1lJsppoX4m1F0oJCVd1JSrZaKVIhMpBSmgFomW4vWTZQe/aFxsmtntRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q9VE0pQM; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52cccd44570so691880e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718806144; x=1719410944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nvycpBB6sFeiiSCGvfkTFvRas6FqApeihphIpdqcmcs=;
        b=q9VE0pQMDwp4YFv2w8V5U7dN7e0Z0Jb7Oe7Zmj5d+C4XNP/uH58lJ7A1ruWfEFYFXW
         duYyNOe0iF6tzzXV0U8E674OEMgoMritsrliTXn+NXh7ZqJsG0NL2HSp82YS4VxXtkH0
         LKoUkk3HxvEdABghlRPAKYqa14/u68Cw4L2eW74T/GjwpaC+NJpGtKe/+UAQZokhvBRB
         ByVfN7kK9HobkRLAI+MWwNl0rMeuEAzez6F7GHD4N9jAgg1XpHES3P+lDBcxZhzhJfMw
         IQAFLR8jx5+gmwDhKSm9TYaTC6ywHXMuVzrmroSmHFTGEzC5xC97YgpyEBpgkcfkrE6V
         iqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806144; x=1719410944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvycpBB6sFeiiSCGvfkTFvRas6FqApeihphIpdqcmcs=;
        b=qmXIcPLofgypCJYdUaf0QUNXR4M6BFPB8Cc7VKZ7MFfUK3gpqZKpIlbVNJJ4XR1Ui3
         TU6jUrqRkGfvpAkzOIJnTfj522tOzs/AIWO7Jo6dl6f9FQy4+juegjMTvmuK3KzZnKwH
         ar2eEJSZCkZI29JwT+d85972du2hDoh2Sw75IM/p04GuARrAHVOLUF3TV7mPyMJfX9nk
         /E17jxuHkKTShZf1Y7n+rNmlh6r6Af7wHnz0YY3PJvFcZi5YRG1nHR4yw6lJ531iYmNU
         7CbZVCmD6lZMqmzgnq1dyDcmkpI76XOV7GW49CgSRoqTXiX9kXHTgI/xZ5BT9Su27sjA
         Xyhw==
X-Forwarded-Encrypted: i=1; AJvYcCWiFkZQVbO2iw+a2CgXWeYRuSxHxQuTxW/dW9Ipmp7mqaO3GUA753DUcXLEpyiO4HZkTQuqQdy8vCxLZ23ApyCJ2iq7bFQw+kN3XeCg
X-Gm-Message-State: AOJu0YwNb62OvYmJNU8b+B6lyTvr4DTXVbzo2iYCOGxXPdSP8/QiHGW0
	RtgX53H0etEI0CzpYKL0ydWTTlQ8ZAytIqAb1p5XyfUcFhoUH1nT9GBsnSUehKk=
X-Google-Smtp-Source: AGHT+IFI0Nyk+muBONfseoLj9XtYy+0CZu9z+FKo2et/S8eFchtWWMGZOEkfH8LH6NNHHXpvJVbrEg==
X-Received: by 2002:a05:6512:3c9e:b0:52b:82d5:8fd2 with SMTP id 2adb3069b0e04-52ccaa97444mr1959568e87.47.1718806144420;
        Wed, 19 Jun 2024 07:09:04 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2872241sm1787003e87.124.2024.06.19.07.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:09:03 -0700 (PDT)
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
Subject: [PATCH 0/7] OPP/pmdomain: Assign required_devs for required OPPs through genpd
Date: Wed, 19 Jun 2024 16:08:42 +0200
Message-Id: <20240619140849.368580-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Through dev_pm_opp_set_config() the _opp_attach_genpd() allows consumer
drivers to hook up a device to its PM domains. This works for both a single
and multiple PM domains. Their corresponding virtual devices that are
created by genpd during attach, are later being assigned as the
required_devs for the corresponding required OPPs.

In principle this works fine, but there are some problems. Especially as
the index for a "required-opps" may not necessarily need to match the index
for the "power-domain" in DT, in which case things gets screwed up.

This series intends to improve the situation, but it's also the first step to
enable consumers of _opp_attach_genpd() to start migrating to use the new
dev_pm_domain_attach_list() instead. Down the road, we should then be able to
drop _opp_attach_genpd() completely.

To test this, I have used a QEMU setup, with local PM test-drivers to try to
test all various combinations of single/multi power/performance PM domains for
a device. Hopefully I have covered it all, but I would certainly appreciate if
someone could help to run a slew of tests on some HWs.

Note: Patch1 is actually a fix that has been posted [1] separately too. I
decided to include here for completeness.

Kind regards
Ulf Hansson

[1]
https://lore.kernel.org/linux-kernel/20240618155013.323322-1-ulf.hansson@linaro.org/

Ulf Hansson (7):
  OPP: Fix support for required OPPs for multiple PM domains
  OPP: Drop a redundant in-parameter to _set_opp_level()
  OPP: Rework _set_required_devs() to manage a single device per call
  OPP: Introduce an OF helper function to inform if required-opps is
    used
  pmdomain: core: Manage the default required OPP from a separate
    function
  OPP/pmdomain: Set the required_dev for a required OPP during genpd
    attach
  pmdomain: core: Drop the redundant dev_to_genpd_dev()

 drivers/opp/core.c        | 185 ++++++++++++++++++--------------------
 drivers/opp/of.c          |  32 +++++++
 drivers/opp/opp.h         |   4 +-
 drivers/pmdomain/core.c   | 103 ++++++++++++++++-----
 include/linux/pm_domain.h |   6 --
 include/linux/pm_opp.h    |  16 +++-
 6 files changed, 215 insertions(+), 131 deletions(-)

-- 
2.34.1


