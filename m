Return-Path: <linux-kernel+bounces-534709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE352A46A26
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6B116D551
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA50233724;
	Wed, 26 Feb 2025 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C5N51EM5"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3282356A5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595811; cv=none; b=OLDl9OP4OtdLuF4aOYcKySn841SIT20WO9HWHMLmD1IkFRfIKVsyv2OdQzZmugN0Dg3oqRe1UhUGYxb6CdG3APVqBVF04ycEB7hxgs7MzV/Wha7WbUtRwqaQMrEG9nPMEN3iHLHSX9YLROVZyetl9nE1bj1WK9fpnaBu+onmfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595811; c=relaxed/simple;
	bh=QjLBKUPu/fo8+UnsxQcBT3c6o1uCrB6eHJBJqKsC+W4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mu2zgNoXgIbizfm8DiDai7VOdjVJASdZ10DM/Oe+Zamk+Hexinveg1auo1wcHJZ9l8Wy1GOQWjVz8sQJz+BKErjChiTXSgqo5wpsUoL7T0JqNBTltqg1PDyg46mavgjTtrrs1oYBmLMvi1Hnri0G2edbMRym4RltjZGhXqIi8RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=C5N51EM5; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51QIo2KI1550254
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 12:50:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740595802;
	bh=nyrTkivqa5p9GTKson4Jh8E/hGqHDVIUjBOtaASPEQk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=C5N51EM5GbMuZuZRgqOlYaCgVonW8i8DNZvRxAaxH7Llusaey0UOpy62uEMR/IySQ
	 qKAPBri6Ah0Avm9Y640WaFByea8fpQkHZd0LNMtCPO9bv+hm6D4mzfSKbHylWt5O13
	 ouqwxlIYtoC3ncq/sOsKOWSTuNntp64D/qbKRKyI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51QInvkG108623
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Feb 2025 12:49:57 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 12:49:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 12:49:57 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51QInvBM082351;
	Wed, 26 Feb 2025 12:49:57 -0600
From: Nishanth Menon <nm@ti.com>
To: Tero Kristo <kristo@kernel.org>,
        Guillaume La Roque
	<glaroque@baylibre.com>
CC: Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] firmware: config: ti-sci: Default set to ARCH_K3 for the ti sci driver
Date: Wed, 26 Feb 2025 12:49:56 -0600
Message-ID: <174059578810.2603560.7052142220899568448.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250220-ti-firmware-v2-1-ff26883c6ce9@baylibre.com>
References: <20250220-ti-firmware-v2-1-ff26883c6ce9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Guillaume La Roque,

On Thu, 20 Feb 2025 14:31:17 +0100, Guillaume La Roque wrote:
> With ARCH_K3=y we cannot enable TI_SCI_PROTOCOL=m because
> ARCH_K3 selects TI_SCI_PROTOCOL.
> 
> Modify the logic to enable TI_SCI_PROTOCOL by default when ARCH_K3=y
> allowing us to submit a future patch to remove select on ARCH_K3 without
> breaking existing users.
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] firmware: config: ti-sci: Default set to ARCH_K3 for the ti sci driver
      commit: 9a9b7cd77b2427d0722fe52301fa270690928989

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
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


