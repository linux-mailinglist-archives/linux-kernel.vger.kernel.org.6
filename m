Return-Path: <linux-kernel+bounces-298040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3EE95C104
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 00:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D29AB21369
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282581D1743;
	Thu, 22 Aug 2024 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3xKNhLU"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9068317E006
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724366768; cv=none; b=L6tFq47pkEOSvfyKaL2UDnpB23iZN8rI9Uy6g+VvlfKnEMPejdf1mKoS6oTqUdx5/9LDt9mU3FFa/MtanjRMXTtxJDLpb2063aXfz2RgiGkY7HoF2WtZr9YEsm4v2iIkpaSPVZQMuHPpCW7fms6UMfAj9YyYsJN6ji9/YtUbZDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724366768; c=relaxed/simple;
	bh=4Hf5PUu0dXlsRl1rofCzd3OSIBQjJkDX+UBrSNvcZ2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=seMfPdCOYorc8/pBKPjM37Wlq4ri8FTSDjCZ67sgiWZWlhMX/WFzpyjVwDNDv3AfYLnrrNcbuVyHZ84YFI/3nahjPLIGEjALKwiXFcNs7RPE1DB7938XPU48XFC3pMY8Fl5nu2g17YwSGjsPLiTRns/QxvexnSJxYmfZ9n787n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U3xKNhLU; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53351642021so1268777e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 15:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724366764; x=1724971564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GDln139mCm+Zd13awBRXGy0VzjVE5RxG35fqlHyQFyw=;
        b=U3xKNhLU7CNufN+VX/I0zLBaAaZyFinctlx47h0b17yvCoJJZG2pela49fTpF+MHnY
         uKTwazliZzHKmovCpCp4qYQFngN8Fassu8U01Y8aciaXCb3YB+qgwdhHKXOPwno0W6AH
         wm8nOKZNeFop25cloaCc2wGFlqLYlYerAB8tu6x9pXhLhOym36QF/7PejHFRO3REfSQE
         fkjxQk7+x7cGjVRp/gSFVw3jaGLlqt1HzxL7OpPozgPYrDJTmBwPc+2ZUeeI95nFHmF6
         +MaGXkBJj4gdUpvoPNu5DV1LF+KxUfVTQIDsqT2v/CK8QJTRPwMR/5JriX7XKH2meIPW
         pfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724366764; x=1724971564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GDln139mCm+Zd13awBRXGy0VzjVE5RxG35fqlHyQFyw=;
        b=UAa7FRiZJ9vyBEIv9E8T+ysS+lAUIDIZx3ZZmTb4JwAJeIgqePm+ba+jSsfQqUpYGn
         jwQDacYcHVkTH5strP998/TVRw5b9TwoXx9tk3dZ9Xo0VuQPrdX03dHLhw+smk3PVKaq
         0sRvGO13aMqxCNsoxMW1rS9RZilTs4lNFvAaCC0sXCieHQ92zgG4KwMTwDKAEASArdZF
         9qrvLVYYqDJ5LWoLL3hZtGKaPe6uX4R6lSEHT4X07IRX2zx67C1eccR7e552CXPPdv6I
         9z21dOr8S7YSTJQsaQtKdylLS/RQJu5LB0h8m+/+xnYhyGz2qXmTX3TXlQQQnIdJt7N2
         NO2g==
X-Forwarded-Encrypted: i=1; AJvYcCWiWzGHjH1Qg3fsZ8LvfXrGZqm+jGskgm7Zg3JwSSiGJd/LiUNyPLPReUuuCEIY6iun+Czcq91/9sDaOkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIyu/g9K0e8q6EfA2E/dHUrlMDNsX57JW+Z0RtwmGIg7s5E1Ky
	9Me9DZnbSJjKgM/G1I1f9AsyX14Az98sNUFAnmqEJ/THgjgowVW+fCaCZlC+03w=
X-Google-Smtp-Source: AGHT+IFjVQunj9GKCtth0S4ejm9CXTEW6D+raTuzjDc0w/Drq5/I9hvp1yQaTp6WSmFZ8QYDX2Jjiw==
X-Received: by 2002:a05:6512:128a:b0:52f:c27b:d572 with SMTP id 2adb3069b0e04-534387c4b18mr189259e87.59.1724366764414;
        Thu, 22 Aug 2024 15:46:04 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea362a4sm379443e87.66.2024.08.22.15.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 15:46:03 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ilia Lin <ilia.lin@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/10] OPP/pmdomain: Assign required_devs for required OPPs through genpd
Date: Fri, 23 Aug 2024 00:45:37 +0200
Message-Id: <20240822224547.385095-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
	- Combine the two series [1] and [2] into one.
	- A few minor changes to consumer drivers.
	- Clarification in commit messages.

Through dev_pm_opp_set_config() the _opp_attach_genpd() allows consumer
drivers to attach a device to its PM domains. Their corresponding virtual
devices that are created by genpd during attach, are later being assigned
as the required_devs for the corresponding required OPPs. In principle,
using dev_pm_opp_set_config() for this works fine.

However, attaching a device to its PM domains is in general better done
with dev_pm_domain_attach|detach_list(). To avoid having two different ways
to manage this, this series prepare for the removal of _opp_attach_genpd().

Moreover, it converts the few existing users of the _opp_attach_genpd() into
dev|devm__pm_domain_attach(), allowing the final patch to drop the redundant
code that becomes redundant.

To test this, I have used a QEMU setup, with local PM test-drivers to try to
test all various combinations of single/multi power/performance PM domains for
a device. Hopefully I have covered it all, but I would certainly appreciate if
someone could help to run a slew of tests on some HWs.

Note, due to dependencies I think this whole series is best funneled together
through my pmdomain tree. If you think there may be issues with this approach,
please let me know so we can figure out the best merging strategy.

Kind regards
Ulf Hansson

[1]
https://lore.kernel.org/all/20240718234319.356451-1-ulf.hansson@linaro.org/
[2]
https://lore.kernel.org/all/20240723144610.564273-1-ulf.hansson@linaro.org/


Ulf Hansson (10):
  OPP: Fix support for required OPPs for multiple PM domains
  OPP: Rework _set_required_devs() to manage a single device per call
  pmdomain: core: Manage the default required OPP from a separate
    function
  OPP/pmdomain: Set the required_dev for a required OPP during genpd
    attach
  pmdomain: core: Drop the redundant dev_to_genpd_dev()
  OPP: Drop redundant code in _link_required_opps()
  drm/tegra: gr3d: Convert into devm_pm_domain_attach_list()
  media: venus: Convert into devm_pm_domain_attach_list() for OPP PM
    domain
  cpufreq: qcom-nvmem: Convert to dev_pm_domain_attach|detach_list()
  OPP: Drop redundant _opp_attach|detach_genpd()

 drivers/cpufreq/qcom-cpufreq-nvmem.c          |  79 ++----
 drivers/gpu/drm/tegra/gr3d.c                  |  38 +--
 drivers/media/platform/qcom/venus/core.c      |   8 +-
 drivers/media/platform/qcom/venus/core.h      |   6 +-
 .../media/platform/qcom/venus/pm_helpers.c    |  44 +--
 drivers/opp/core.c                            | 252 ++++++------------
 drivers/opp/of.c                              |  39 +--
 drivers/opp/opp.h                             |   5 +-
 drivers/pmdomain/core.c                       | 107 ++++++--
 include/linux/pm_domain.h                     |   6 -
 include/linux/pm_opp.h                        |  42 +--
 11 files changed, 217 insertions(+), 409 deletions(-)

-- 
2.34.1


