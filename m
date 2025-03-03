Return-Path: <linux-kernel+bounces-540995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B235CA4B745
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA7618925A7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB191DDC23;
	Mon,  3 Mar 2025 04:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eyehp6S3"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB2733FE;
	Mon,  3 Mar 2025 04:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740977351; cv=none; b=GGDOxsU+ZgNUuqiIIrdIXBc5LsWZ21oFUEgDThe7/MaRVjwGqf1Z2fHtkmKy5ma3rywdei/GgQgHHtOX5iq1lWlqRCc3q7dRTYjLJw92QzvEyJfnH0dvt12l3WGk57upFI8HOHjdkPAs6vDqZL2wE2gp+RxsP6PSvQYyE/wDkMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740977351; c=relaxed/simple;
	bh=Re0US//5z2zBhLPVUwz6ZLMmTFMo3MlRNOGAtPZo6qM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myMHtIW75wAiuheQOQja9x2FDXxFZeirHso5DfXoyNGBorpbLgX+mvzKZZAqdJmKAHUyr4+3L4G7Q9qtCwYYmuatk4ZJwgfXr17qh2Twqn/4IgvryadaHL0bogqei654GZ5nbPyHJM6s2EjO39+U9G8/BqI/Q4+SsveeIKzLLAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eyehp6S3; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5234mllH2589775
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Mar 2025 22:48:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740977328;
	bh=FCkRH65NwGl00HMiThTUBsiZpkAdvh3DpvpaROVnq2g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=eyehp6S3CddB2RtUJznYJjMIrii+52wavayNT87k8K3Yb4Cij990S0w1duZ8uKqt2
	 yhkz3r2Sv65T6EqIjVXVUVVDkpkan+qEJp+SEgwMm+WXzEI1UUUCGxQqu9UpPYMDZR
	 OwouZ42seINIEgJ4co6r0jGnP60HlHDmBvjivncI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5234mlFO067333
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Mar 2025 22:48:47 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Mar 2025 22:48:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Mar 2025 22:48:47 -0600
Received: from uda0132425.dhcp.ti.com (dhcp-10-24-69-250.dhcp.ti.com [10.24.69.250])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5234mgG2056332;
	Sun, 2 Mar 2025 22:48:43 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <kees@kernel.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, Wadim Egorov <w.egorov@phytec.de>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am64-phycore-som: Reserve RTOS IPC memory
Date: Mon, 3 Mar 2025 10:18:41 +0530
Message-ID: <174092143359.3272913.1513661794535250352.b4-ty@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131093531.1054924-1-w.egorov@phytec.de>
References: <20250131093531.1054924-1-w.egorov@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Wadim Egorov,

On Fri, 31 Jan 2025 10:35:30 +0100, Wadim Egorov wrote:
> Reserve a portion of memory for inter-processor communication between
> all remote processors running RTOS or baremetal firmware.
> 
> 

I have applied the following to branch ti-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am64-phycore-som: Reserve RTOS IPC memory
      commit: eeab4a777eb490b9eca670379720b938226b1c79
[2/2] arm64: dts: ti: k3-am62-phycore-som: Reserve RTOS IPC memory
      commit: 4ad59ca98c2764ee2a58e48c96338b6fb88ce85a

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


