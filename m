Return-Path: <linux-kernel+bounces-410525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 015959CDCCE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD3228325C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199CC1B3948;
	Fri, 15 Nov 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kGQzV+hM"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9E018950A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667241; cv=none; b=K3cwxLYhhZX+srelOqyZkyfr+auzqBk+cew109l5+I/0ENjxs0Xshv3ybCZAuaxlMOpKAOPBuwUoVY+ujmQ3ba010zxxOgKvg1DXUGHtSEArqPpHsyp6Pv87LXXljJO2DATPrRTrikIBC/riVw393djHUh4NHfGONacaVhI2A9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667241; c=relaxed/simple;
	bh=ilGIpaaX54RTYzqtFywkuJv9jhWNTIMieNFKaKBDOHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VN16Mgq3OzRI3BkMJjhAbKRoAbeFazVlgWRBDQc+Sxd5oQ6TWBek89GIyd4Y93T5LKEmx2FjJEePlK03CkhG7SPCYZJAQO5Tf7MGTpdUwKcAWKtY91LCaM0KXFB6xIMFU0ySCUQ8uj3ZIIKIzujieAHBYyZiea1cVukLZfTrGy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kGQzV+hM; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so4864151fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 02:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731667237; x=1732272037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Z6LvJ/sPB+Dl1kFLmZv/mrYyYjioWG5VXi0FQmBtqQ=;
        b=kGQzV+hM7h+DcWptLj5py2CSLh2d4JokTi2eou7qvm+pq5A5tJbBzKzJzGgFeaeMmi
         bbhH2cUTCS/yqArL+Kkurrrw+ddcawsufneyJjoSIJvYJPgtAxwjeXUmBYi+Bem3b93L
         B1i6ltMpMjTdeFcmpLa+bFLmVoCJpbCGi2XUbeV3taWYDE1SKsLTpJALjm0jHFgsQv5t
         FH/KRRR/LfRfgJEld1p99b9ASmceO+FsKov8wRdqQkHBZcklMD3RRm7/fgycicovrQSu
         RdVhCVzcZQyp0jrFziUDaqV5lyD1CRMiyCr+m4UqsXf3QLqnvA6y4NTOgQVYdNhwNAgF
         iTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731667237; x=1732272037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Z6LvJ/sPB+Dl1kFLmZv/mrYyYjioWG5VXi0FQmBtqQ=;
        b=iEsAqx/saISYsxTD/sUiKc9aaR2DmeHuTBAkY66KgCWLnasuIAYwDPqItHx9uYa3bW
         bihLNB4WtCXju5Tw/dbE4xkGgZvbiaFgpnNvA0wbNmPwSZzxTQX6YLghrouEjL1hG0a2
         Le3C2CEHkqrUchHrMeEEWnW3vkjXdmcOxXEMfVwmxv4Hs8LwvwjU6ZOawmusld/QNtYk
         cumDIdTAMrAsbksbQKOdGqS5JjWKhQHLxnPJFDGy3Fw6TOvY8GFfpNjvjNpapoQLgbfn
         sFpi0mpUBSOBK0I7krqJWUJm8IAAVDBdkbIV7iPjMjr+XAxdF91s4xqBt5J+uDAMQOoX
         HVTg==
X-Forwarded-Encrypted: i=1; AJvYcCWK06EeZwreWvyq0sQDNUjprNwZn2y2Flb5JB2VjIDRu4TFCwvkdrlTK3iuvghBo/4jxfyzRa7NYyroEP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJGiNN+pPiZT2fMKal5V0KNAwre5Gwlz3ldqlJ9s7DFyfoDsiU
	tezEAKq7FlKDcboYqe2QC2QAjRV12DoV5ggYDKQVMuwT6Lm5Z3SlT/CkddKg2NQ=
X-Google-Smtp-Source: AGHT+IHochvip3ndT36pY7JzUJ9o2k/DM6zBRNTgAKVEogfP3W6wLBEgo4qo8JTEtM7I1Em76KrM6g==
X-Received: by 2002:a2e:a99c:0:b0:2fc:97a8:48f9 with SMTP id 38308e7fff4ca-2ff606900f0mr14332601fa.19.1731667236678;
        Fri, 15 Nov 2024 02:40:36 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff597a067dsm5179361fa.65.2024.11.15.02.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 02:40:35 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain/arm_scmi fixes for v6.12-rc8
Date: Fri, 15 Nov 2024 11:40:29 +0100
Message-ID: <20241115104029.119226-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of pmdomain and arm_scmi fixes intended for v6.12-rc8.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 7738568885f2eaecfc10a3f530a2693e5f0ae3d0:

  PM: domains: Fix alloc/free in dev_pm_domain_attach|detach_list() (2024-10-10 13:55:17 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.12-rc1-2

for you to fetch changes up to d2fab3fc27cbca7ba65c539a2c5fc7f941231983:

  mailbox: qcom-cpucp: Mark the irq with IRQF_NO_SUSPEND flag (2024-11-12 19:45:25 +0100)

----------------------------------------------------------------
pmdomain core:
 - Add GENPD_FLAG_DEV_NAME_FW flag to generate unique names

pmdomain providers:
 - arm: Use FLAG_DEV_NAME_FW to ensure unique names
 - imx93-blk-ctrl: Fix the remove path

arm_scmi/qcom-cpucp:
 - Report duplicate OPPs as firmware bugs for arm_scmi
 - Skip OPP duplicates for arm_scmi
 - Mark the qcom-cpucp mailbox irq with IRQF_NO_SUSPEND flag

----------------------------------------------------------------
Cristian Marussi (1):
      firmware: arm_scmi: Skip opp duplicates

Peng Fan (1):
      pmdomain: imx93-blk-ctrl: correct remove path

Sibi Sankar (4):
      pmdomain: core: Add GENPD_FLAG_DEV_NAME_FW flag
      pmdomain: arm: Use FLAG_DEV_NAME_FW to ensure unique names
      firmware: arm_scmi: Report duplicate opps as firmware bugs
      mailbox: qcom-cpucp: Mark the irq with IRQF_NO_SUSPEND flag

 drivers/firmware/arm_scmi/perf.c        | 44 +++++++++++++++++++++--------
 drivers/mailbox/qcom-cpucp-mbox.c       |  2 +-
 drivers/pmdomain/arm/scmi_perf_domain.c |  3 +-
 drivers/pmdomain/core.c                 | 49 +++++++++++++++++++++++----------
 drivers/pmdomain/imx/imx93-blk-ctrl.c   |  4 ++-
 include/linux/pm_domain.h               |  6 ++++
 6 files changed, 78 insertions(+), 30 deletions(-)

