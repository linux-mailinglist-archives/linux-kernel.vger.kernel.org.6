Return-Path: <linux-kernel+bounces-386616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8209B45E5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CADE1C221E4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785B8204039;
	Tue, 29 Oct 2024 09:43:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8567926AFC;
	Tue, 29 Oct 2024 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195035; cv=none; b=tifovfc4nofaAgNbt38K0CoNpjs9gUc4g1uDdaLpjnf4qtH1G+4KjE4203HNPheF+XbDolVfk/f6rqLo57DXLZQIzND+yrCLEPHPcyTiaTnacaoqK8wZ0Masbfef2LP4DVNWeVgmqrayBxvUgxuP6OgsTkzUEFyJaVqZlYqUUlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195035; c=relaxed/simple;
	bh=ZtRs8jiXiWiRLZAbLrYbLsFyRRuNx7W1DkYJelr76LU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GGk0vUAcjXSnNv2TXueac2J/4knVRH7oqA8p/fy8Trw3UKOggTO9ElMWeWTBEWxvZaZhTQUZ+2g8apmUWRn0V9COn9tDEEh5cwXlHDS4yqTTlmYksDS47fV5iZ+uVvrcv6npnGNmqSQI+ns7R+gOFc5ZfFlKYvF9yHKrmNpp5ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFE1313D5;
	Tue, 29 Oct 2024 02:44:21 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.57.182])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 25FA73F528;
	Tue, 29 Oct 2024 02:43:51 -0700 (PDT)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	rafael@kernel.org
Subject: [PATCH v2 0/1] Update Energy Model with performance limits
Date: Tue, 29 Oct 2024 09:43:28 +0000
Message-ID: <20241029094452.495439-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch set allows to specify in the EM the range of performance levels that
the device is allowed to operate. It will impact EAS decision, especially for
SoCs where CPUs share the voltage & frequency domain with other CPUs or devices
e.g.
- Mid CPUs + Big CPU
- Little CPU + L3 cache in DSU
- some other device + Little CPUs

The minimum allowed frequency will be taken into account while doing EAS task
placement simulation. When the min frequency is higher for the whole domain
and not driven by the CPUs in that PD utilization, than the energy for
computation in that PD will be higher. This patch helps to reflect that higher
cost.

More explanation can be found in my presentation at OSPM2023 [1].
I have shown experiments with Big CPU running high frequency and increasing
the L3 cache frequency (to reduce the latency), but that impacted Little
CPU which are in the same DVFS domain with L3 cache. It had bad impact for
total energy consumed by small tasks placed on Little CPU. The EAS was not
aware about the min frequency&voltage of the Little CPUs and energy estimation
was wrong.

Changelog:
v2:
- added mutex to guard simultaneous updates and make them atomic (Hongyan)
- added Doxygen two new arguments description (Dietmar)
- changed patch header description (Dietmar) and added an example
- dropped the SCMI patch for now, since the notifications are not merged there yet
v1 [2]:
- basic implementation

Regards,
Lukasz Luba

[1] https://www.youtube.com/watch?v=2C-5uikSbtM&list=PL0fKordpLTjKsBOUcZqnzlHShri4YBL1H
[2] https://lore.kernel.org/lkml/20240403162315.1458337-1-lukasz.luba@arm.com/


Lukasz Luba (1):
  PM: EM: Add min/max available performance state limits

 include/linux/energy_model.h | 24 ++++++++++++++---
 kernel/power/energy_model.c  | 52 ++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 4 deletions(-)

-- 
2.46.0


